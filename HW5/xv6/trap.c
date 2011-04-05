#include "types.h"
#include "defs.h"
#include "param.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"
#include "traps.h"
#include "spinlock.h"

// Interrupt descriptor table (shared by all CPUs).
struct gatedesc idt[256];
extern uint vectors[];  // in vectors.S: array of 256 entry pointers
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
  
  initlock(&tickslock, "time");
}

void
idtinit(void)
{
  lidt(idt, sizeof(idt));
}

void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(proc->killed)
      exit();
    proc->tf = tf;
    syscall();
    if(proc->killed)
      exit();
    return;
  }

  pte_t *pte;
  uint pa, i;
  char *mem;
  uint r,m;
  pde_t *pde;
  pte_t *pgtab;


  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
      acquire(&tickslock);
      ticks++;
      wakeup(&ticks);
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
    break;
  case T_PGFLT:      

    

    //asm("\t movl %%cr2,%0" : "=r"(i));
    i = rcr2();


    //    cprintf("page fault handler entry = %x, prod->pid =%x \n", i, proc->pid);

    // having issues linking walkpgdir
    // here's a copy-paste
    pde = &proc->pgdir[PDX((void*)i)];
    if(*pde & PTE_P){
      pgtab = (pte_t*) PTE_ADDR(*pde);
    } else if(!(r = (uint) kalloc()))
      panic("page fault handler : this should never happen \n");
    else {
      pgtab = (pte_t*) r;
      // Make sure all those PTE_P bits are zero.
      memset(pgtab, 0, PGSIZE);
      // The permissions here are overly generous, but they can
      // be further restricted by the permissions in the page table 
      // entries, if necessary.
      *pde = PADDR(r) | PTE_P | PTE_W | PTE_U;
    }
    if ( ! (pte =  &pgtab[PTX((void*)i)]))
      panic("page fault handler: pte should exist\n");
    
    

    //    if(!(pte = walkpgdir(proc->pgdir, (void *)i, 0)))
    //  panic("page fault handler: pte should exist\n");

    pa = PTE_ADDR(*pte);  
    if(!(mem = kalloc()))
      panic("page fault handler : page fault\n");
    memmove(mem, (char *)pa, PGSIZE);
    if(!mappages(proc->pgdir, (void *)i, PGSIZE, PADDR(mem), PTE_W|PTE_U))
      panic("page fault handler : page fault\n");

    // tLB flush
    //asm("\t movl %%cr3,%0" : "=r"(m));
    //asm ("\t movl %0,%%cr3": :"r" (m));
    m = rcr3(); 
    lcr3(m);


    break;

  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
            rcr2());
    proc->killed = 1;
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
