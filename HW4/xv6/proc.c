#include "types.h"
#include "defs.h"
#include "param.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"

// START HW4
char *q_names[5] = {"runqueue_0","runqueue_1","runqueue_2","runqueue_3","runqueue_4"};

// Process run queue
struct {
  struct spinlock lock; //[NQUEUE]
  proc_queue *q[NQUEUE];
} runqueue;
// END HW4

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
  
  // START HW4
  // initialize ready queues for scheduler
  int i;
 
  initlock(&runqueue.lock, "runqueue");

  acquire(&runqueue.lock);
  for(i=0; i<NQUEUE; i++){ 
	//initlock( &runqueue.lock[i],  q_names[i]);
	runqueue.q[i] = 0;
  }
  release(&runqueue.lock);
  // END HW4 
  
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
  [ZOMBIE]    "zombie"
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
  if(!(p->pgdir = setupkvm()))
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  p->state = RUNNABLE;
  
  // START HW4
  p->priority = 0;
  p->affinity = -1;

  acquire(&runqueue.lock);
  enqueue( p->pid, 0 );
  release(&runqueue.lock); 
  // END HW4
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz = proc->sz;
  if(n > 0){
    if(!(sz = allocuvm(proc->pgdir, sz, sz + n)))
      return -1;
  } else if(n < 0){
    if(!(sz = deallocuvm(proc->pgdir, sz, sz + n)))
      return -1;
  }
  proc->sz = sz;
  switchuvm(proc);
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

  // Copy process state from p.
  if(!(np->pgdir = copyuvm(proc->pgdir, proc->sz))){
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = proc->sz;
  np->parent = proc;
  *np->tf = *proc->tf;
   

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
 
  pid = np->pid;
  np->state = RUNNABLE;
  
  //START HW4
  // priority and affinity
  np->affinity = proc->affinity;
  np->priority = proc->priority;
  
  acquire(&runqueue.lock); 
 // cprintf("enqueuing forked process %d to queue %d\n", np->pid, np->priority);
  enqueue( np->pid , np->priority );  //
 // print_queue( np->priority );
  release(&runqueue.lock); 
  // END HW4 
  
  safestrcpy(np->name, proc->name, sizeof(proc->name));
  return pid;
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{

  // cprintf("Entered exit proc %d state %d\n", proc->pid, proc->state); 

  struct proc *p;
  int fd;

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd]){
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  iput(proc->cwd);
  proc->cwd = 0;

  acquire(&ptable.lock);
 
  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
	  //p->priority = 0;
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }
  
  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
  sched();
  panic("zombie exit");
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{

//   cprintf("Entered wait proc %d state %d\n", proc->pid, proc->state); 

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
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->state = UNUSED;
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
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

	acquire(&ptable.lock);
	
	// Loop over process table looking for process to run.
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
	   
      if(p->state != RUNNABLE)
        continue;
	
	  // START HW4 
	  // see if current process has the highest priority      
	  acquire(&runqueue.lock);	
	  int i, found=1;
      for(i=0; i<=p->priority ; i++){
	     
	     if( runqueue.q[i] != 0 && ( i < p->priority || runqueue.q[i]->pid != p->pid )   )  {
		    found = 0;
		    break;
		 }	
      }	  
	  
	  if(!found){
	     release(&runqueue.lock);
		 continue;
	  }
	  // END HW4

	//cprintf("found process2 %d cpu %d\n" ,p->pid, cpu->id);	
	  
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      switchuvm(p);
      p->state = RUNNING;
	  
	  // START HW4 
	  remove_from_queue( p->pid, p->priority );  
	  release(&runqueue.lock); 
	  // END HW4
	  
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

  //cprintf("Entered yield\n");
 
  acquire(&ptable.lock);  //DOC: yieldlock
  proc->state = RUNNABLE;

  // START HW4   
  // put process at end of queue
  acquire(&runqueue.lock); 
  remove_from_queue( proc->pid, proc->priority );
  enqueue( proc->pid,proc->priority  ); //
  release(&runqueue.lock); 
  // END HW4
  
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
  if(holding(&runqueue.lock))
	release(&runqueue.lock);
  
  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    cprintf("Entered sleep proc %d state %d\n", proc->pid, proc->state);

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
    if(p->state == SLEEPING && p->chan == chan){
    
      p->state = RUNNABLE;
	  
	  // START HW4
	  acquire(&runqueue.lock);
      enqueue( p->pid, p->priority ); 
      release(&runqueue.lock); 
	  // END HW4
	  
	}
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
 // acquire(&runqueue.lock);
  wakeup1(chan);
 // release(&runqueue.lock);
  release(&ptable.lock);
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
	  
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;

      release(&ptable.lock);
      return 0;
    }
  }

  release(&ptable.lock);
  return -1;
}

// START HW4
int getpriority(int pid){

  struct proc *p;
  int prio = -1;

  acquire(&ptable.lock);
 
  // Scan through table looking for the process with the specified pid
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->pid == pid){
	      prio = p->priority;
		  break; 
	  }
  }      	  
	  
  release(&ptable.lock); 
  
  return prio;
  
}

int setpriority(int pid,int new_priority){

  struct proc *p;
  int found = -1;

  acquire(&ptable.lock);

  // Scan through table looking for the process with the specified pid
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->pid == pid){
	  
		 acquire(&runqueue.lock);
		 remove_from_queue( p->pid, p->priority );
		  
		 p->priority = new_priority;
		
         release(&runqueue.lock);
		  
		 found = 0;
		 break; 
	  }
  }      	  
  
  release(&ptable.lock); 
  
  return found;
  
}


int setaffinity(int pid,int new_affinity){

  struct proc *p;
  int i, found = -1;
  
  // check validity of new_affinity
  for(i=0; i<=cpunum(); i++){
      if(new_affinity != i){
	     cprintf("Invalid new_affinity value!\n");
	     return -1;
	  }
  }
    

  acquire(&ptable.lock);
  // Scan through table looking for the process with the specified pid
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->pid == pid){
	      p->affinity = new_affinity;
		  found = 0;
		  break; 
	  }
  }      	  
  release(&ptable.lock); 
  
  return 0;
  
}


int getaffinity(int pid){

  struct proc *p;
  int aff = -2;

  acquire(&ptable.lock);
 
  // Scan through table looking for the process with the specified pid
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->pid == pid){
	      aff = p->affinity;
		  break; 
	  }
  }      	  
	  
  release(&ptable.lock); 
  
  return ( (aff != -2) ? aff : -1 );
  
}



// function to add a new process to the queue
int enqueue( int pid, int prio ){

   // create new process
   proc_queue *newProc = (proc_queue *) kalloc();
   
   if ( newProc == 0 ) {
		cprintf("Unable to allocate memory for new element\n");
		return(-1);
   }
   
   newProc->pid = pid;
   newProc->next = 0;
   
   // insert new process 
   if( runqueue.q[prio]==0 ){
     runqueue.q[prio] = newProc;
   }
   else{   
	   proc_queue *tmp = runqueue.q[prio];
	   while(tmp->next != 0)
		  tmp = tmp->next;
		   
	   tmp->next = newProc;
   }

   return 0;   

}

// function to remove the top process from the queue 
int dequeue( int prio ){

   if( runqueue.q[prio] == 0 ){
       cprintf("Error, empty process queue\n");
	   return -1;
   }

   proc_queue *tmp = runqueue.q[prio];
   
   int pid = tmp->pid;
   
   runqueue.q[prio] = runqueue.q[prio]->next;
   
   kfree( (void *) tmp );  

   return pid;    

}

int remove_from_queue( int pid, int prio){

   if( runqueue.q[prio] == 0 ){
       //cprintf("Error, empty process queue\n");
	   return -1;
   }
   
   if( runqueue.q[prio]->pid == pid )
      return( dequeue( prio ) );

   proc_queue *tmp = runqueue.q[prio];
   int found = 0;
   
   while( tmp->next !=0 ){
     
      if( tmp->next->pid == pid ){
	      proc_queue *tmp2 = tmp->next;
		  tmp->next = tmp->next->next;
		  kfree( (void *) tmp2 ); 
		  found = 1;
		  break;
	  }
	  tmp = tmp->next;
   }

   if( !found ){
	  return -1;
   }
   
   return 0;   
}

// function to print all the processes in the queue
int print_queue( int prio ) {

   proc_queue *tmp = runqueue.q[prio];
   
   cprintf("Process list %d: ",prio);
   
   if( runqueue.q[prio]==0 ){
      cprintf("Empty");
   }
   else{
   
	  while( tmp != 0 ){
	    cprintf("%d ", tmp->pid);
	    tmp = tmp->next;
	  }
   }
   cprintf("\n");
   
   return 0;
   
}
// END HW4

