#include "types.h"
#include "defs.h"
#include "param.h"
#include "mmu.h"
#include "x86.h"
#include "spinlock.h"
#include "rwlock.h"
#include "proc.h"



struct {
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

static struct proc *initproc;

int nextpid = 1;
extern void forkret(void);
extern void trapret(void);

static void wakeup1(void *chan);

void
pinit(void)
{
  initlock(&ptable.lock, "ptable");
}

// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  static char *states[] = {
  [UNUSED]    "unused",
  [EMBRYO]    "embryo",
  [SLEEPING]  "sleep ",
  [RUNNABLE]  "runble",
  [RUNNING]   "run   ",
  [ZOMBIE]    "zombie",
  [TZOMBIE]   "tzombe"
  };
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}

int
pschk()
{
  struct proc *p;
  int count = 0;

  acquire(&ptable.lock);

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
    if (p->state == UNUSED)
      continue;

    count ++;
	
	//cprintf("Pcount : %d (added %d, state %d)\n",count,p->pid,p->state);
	
    if (p->state == ZOMBIE || p->state == TZOMBIE) {
      release(&ptable.lock);
      return -1;
    }
  }

  release(&ptable.lock);
  return count;
}

// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and return it.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
  release(&ptable.lock);

  // Allocate kernel stack if possible.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe*)sp;
  
  // Set up new context to start executing at forkret,
  // which returns to trapret (see below).
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
  return p;
}

// Set up first user process.
void
userinit(void)
{
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
  initproc = p;
  p->common = &p->threadcommon;
  if(!(p->common->pgdir = setupkvm()))
    panic("userinit: out of memory?");
  inituvm(p->common->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->common->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->common->cwd = namei("/");

  p->state = RUNNABLE;
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;

  writelock(&proc->common->pglock);

  sz = proc->common->sz;
  if (n > 0)
    sz = allocuvm(proc->common->pgdir, sz, sz + n);
  else if (n < 0)
    sz = deallocuvm(proc->common->pgdir, sz, sz + n);

  if (sz == 0) {
    writeunlock(&proc->common->pglock);
    return -1;
  }

  proc->common->sz = sz;
  switchuvm(proc);

  writeunlock(&proc->common->pglock);
  return 0;
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
    return -1;

  np->common = &np->threadcommon;

  // Copy process state from p.

  readlock(&proc->common->pglock);
  if(!(np->common->pgdir = copyuvm(proc->common->pgdir, proc->common->sz))){
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->common->sz = proc->common->sz;
  readunlock(&proc->common->pglock);

  acquire(&proc->common->lock);
  for(i = 0; i < NOFILE; i++)
    if(proc->common->ofile[i])
      np->common->ofile[i] = filedup(proc->common->ofile[i]);
  np->common->cwd = idup(proc->common->cwd);
  release(&proc->common->lock);

  // Clear %eax so that fork returns 0 in the child.
  *np->tf = *proc->tf;
  np->tf->eax = 0;

  // Make sure the page table lock is unlocked.
  initrwlock(&np->common->pglock);

  
  if(proc->common == &proc->threadcommon)
  	 np->parent = proc; 
  else
     np->parent = proc->mainThread;
	 
 /// cprintf("Created p %d with parent %d\n",np->pid,np->parent->pid);
    
  np->mainThread = np;
  np->common->count = 1;
  
  safestrcpy(np->name, proc->name, sizeof(proc->name));
  np->state = RUNNABLE;

  pid = np->pid;

  return pid;
}

int tfork( uint entry, uint arg, uint spbottom )
{

  int pid;
  struct proc *np;

  
  // Allocate process.
  if((np = allocproc()) == 0)
    return -1;

  np->common = &proc->threadcommon;

  spbottom -= 4;
  *(uint *)spbottom = (int) arg;

  
  spbottom -= 4;
  *(uint *)spbottom = 0xffffffff;
  

  // Clear %eax so that fork returns 0 in the child.
  *np->tf = *proc->tf;

  
  np->tf->esp = (uint)spbottom;
  np->tf->eip = (uint)entry;
  
  np->parent = proc->parent;

  acquire(&proc->common->lock);
  np->common->count++;
  release(&proc->common->lock);
  

  np->mainThread = proc->mainThread;
  
///  cprintf("Created p %d with parent %d\n",np->pid,np->parent->pid);
  
  safestrcpy(np->name, proc->name, sizeof(proc->name));
  np->state = RUNNABLE;

  pid = np->pid;
  
  return pid;

}

int texit(void)
{

  // main thread 
  if ( proc->common == &proc->threadcommon ) 
    return -1;

  acquire(&ptable.lock);
  
  wakeup1(proc->mainThread);
  
  // Jump into the scheduler, never to return.
  proc->state = TZOMBIE;
  sched();
  panic("zombie exit");

}

int twait(int tid)
{

  struct proc *p;
  int found = 0;
  
  acquire(&ptable.lock);

  // Scan through table looking if tid is a main thread
  for(;;){
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  
		if( p->pid == tid ) {
		
			found = 1;
			
			if( p->common == &p->threadcommon) {
			    //cprintf("I found the tid and it was a main thread!\n");
				release(&ptable.lock);
				return -1;
			}
			else{
				if( p->state == TZOMBIE ){
				
					// Found one.
					acquire(&p->common->lock);
					p->common->count--;
					release(&p->common->lock);
					
					tid = p->pid;
					kfree(p->kstack);
					p->kstack = 0;
					p->state = UNUSED;
					p->pid = 0;
					p->mainThread = 0;
					p->parent = 0;
					p->name[0] = 0;
									
					release(&ptable.lock);
					return tid;
				}		
				else{
				
   				  // wait for thread to exit
				  sleep(proc, &ptable.lock);  
	
				}	
			}
		}
	}

	  // if it did not find the thread
	if( !found ){
	  release(&ptable.lock);
	  return -1;}

  }
  
  //cprintf("I am done with wait\n");

  release(&ptable.lock);
  

  
  return 0;
}

  

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  struct proc *p;
  int fd;

  if(proc == initproc)
    panic("init exiting");

  acquire(&proc->common->lock);

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->common->ofile[fd]){
      fileclose(proc->common->ofile[fd]);
      proc->common->ofile[fd] = 0;
    }
  }

  iput(proc->common->cwd);
  proc->common->cwd = 0;

  release(&proc->common->lock);

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
  //wakeup1(proc->mainThread);
  
  //cprintf("Exit porc %d, threads ",proc->mainThread->pid);
  
  // Find other threads in current process
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->mainThread == proc->mainThread){
       
	  if( p->common != &p->threadcommon )
		p->state = TZOMBIE;	
	  else
		p->state = ZOMBIE;	
		
	//  cprintf(" %d(%d)",p->pid, p->state);
    
    }
  }
  
 // cprintf("\n");

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc) { 
      
	  p->parent = initproc;
	  
      if(p->state == ZOMBIE)
        wakeup1(initproc);
	 
    }
  }
  
  // Jump into the scheduler, never to return.
  //proc->state = ZOMBIE;
  
  sched();
  panic("zombie exit");
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{

  //cprintf("Process %d invoked wait()\n",proc->pid);

  struct proc *p;
  int havekids, pid;
  
  acquire(&ptable.lock);
   
  for(;;){
  
    // Scan through table looking for zombie children.
    havekids = 0;
	
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
     
	 if(p->parent != proc) 
        continue;
      
      havekids = 1;
	  
	  //cprintf("Parent %d found child %d\n",proc->pid,p->pid);

	  // found a main thread being ZOMBIE
      if( p->state == ZOMBIE ){ 
	  
		acquire(&p->common->lock);
		freevm(p->common->pgdir);
		p->common->killed = 0;
		release(&p->common->lock);
		p->common = 0;
		
		pid = p->pid;
	
		// loop to find other threads in same process 
		struct proc *p2;
		for(p2 = ptable.proc; p2 < &ptable.proc[NPROC]; p2++){
		   if(p2->mainThread == p){
		        //acquire(&p2->common->lock);
				//p2->common->count--;	
				//release(&p2->common->lock);
				kfree(p2->kstack);
				p2->kstack = 0;
				p2->state = UNUSED;
				p2->pid = 0;
				p2->parent = 0;
				p2->mainThread = 0;
				p2->name[0] = 0; 
			}		
        }
			
///		cprintf("wait returning %d\n",pid);	
		release(&ptable.lock);
        return pid;
      }
    }
	

    // No point waiting if we don't have any children.
    if(!havekids || proc->common->killed){
	  //cprintf("Error wait on %d HK %d PCK %d\n",proc->pid, havekids, proc->common->killed);
      release(&ptable.lock);
      return -1;
    }
	
    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }


}

// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  struct proc *p;

  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      switchuvm(p);
      p->state = RUNNING;
      swtch(&cpu->scheduler, proc->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);

  }
}

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
  int intena;

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = cpu->intena;
  swtch(&proc->context, cpu->scheduler);
  cpu->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  proc->state = RUNNABLE;
  sched();
  release(&ptable.lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
  
  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  if(proc == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }

  // Go to sleep.
  proc->chan = chan;
  proc->state = SLEEPING;
  sched();

  // Tidy up.
  proc->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}

// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  struct proc *p;
  struct proc *p2;
  //struct proc *mainThreadRef = 0;

  acquire(&ptable.lock);
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){

	///  cprintf("Found proc %d and set to kill threads ",pid); 
	   
	  acquire(&p->common->lock);
	  
	  // if it is not a main thread, return -1
      if ( p->common != &p->threadcommon ){
	     //cprintf("wait it was not a main thread!\n");
	     release(&p->common->lock);
		 release(&ptable.lock);
	     return -1; 
	  }
      else
	  {
	     // it's a main thread, kill all other threads in the process
	     p->common->killed = 1;
		 
		 if(p->state == SLEEPING) 
			p->state = RUNNABLE;
					
		 for(p2 = ptable.proc; p2 < &ptable.proc[NPROC]; p2++){ 

			if ( p2->mainThread == p ){
		///	   cprintf("%d ",p2->pid); 
			   if(p2->state == SLEEPING) 
					p2->state = RUNNABLE;
			}
		 }
	///	 cprintf("\n");
		 
         release(&p->common->lock);
		 release(&ptable.lock);
	     return 0;
	  }
    }
  }

  release(&ptable.lock);

  return 0;
  
}
