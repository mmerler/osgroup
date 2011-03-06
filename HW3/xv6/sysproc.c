#include "types.h"
#include "x86.h"
#include "defs.h"
#include "param.h"
#include "mmu.h"
#include "spinlock.h"
#include "rwlock.h"
#include "proc.h"

int
sys_tfork(void)
{
  // HW3 TODO
  int entry = 0;
  int arg = 0;
  int spbottom = 0;

  if ( getuserint(0, &entry) == -1 ) {
      cprintf("Could not read entry\n");
      return -1;
  }

  if ( getuserint(1, &arg)== -1 ) {
    cprintf("Could not read arg\n");
    return -1;
  }

  if ( getuserint(2, &spbottom) == -1 ) {
    cprintf("Could not read spbottom\n");
    return -1; 
  }
  
  if( (uint)spbottom > proc->common->sz){
    cprintf("spbottom too small : %d : %d\n",(uint)spbottom, proc->common->sz );
    return -1; 
  }

  return tfork( (uint)entry, (uint)arg, (uint)spbottom );
}

int
sys_texit(void)
{
  // HW3 TODO
  return texit();
}

int
sys_twait(void)
{
  // HW3 TODO
  int tid;
  if ( getuserint(0, &tid) == -1 )
  return twait(tid);
}

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(getuserint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  if( proc->common == proc->parent->common )
     return proc->parent->pid;

  return proc->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;
  int fault = 0;

  if(getuserint(0, &n) < 0)
    return -1;

  addr = proc->common->sz;
  if(growproc(n) < 0)
    fault = 1;

  if (fault)
    return -1;
  else
    return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;
  
  if(getuserint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(proc->common->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since boot.
int
sys_uptime(void)
{
  uint xticks;
  
  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

// HW3: This system call is for grading purposes only; you should not
// call it in your code
int
sys_pschk(void)
{
  return pschk();
}
