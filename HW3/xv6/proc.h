// Segments in proc->gdt.
// Also known to bootasm.S and trapasm.S
#define SEG_KCODE 1 // kernel code
#define SEG_KDATA 2 // kernel data+stack
#define SEG_KCPU 3 // kernel per-cpu data
#define SEG_UCODE 4 // user code
#define SEG_UDATA 5 // user data+stack
#define SEG_TSS 6 // this process's task state
#define NSEGS 7

// Per-CPU state
struct cpu {
  uchar id; // Local APIC ID; index into cpus[] below
  struct context *scheduler; // Switch here to enter scheduler
  struct taskstate ts; // Used by x86 to find stack for interrupt
  struct segdesc gdt[NSEGS]; // x86 global descriptor table
  volatile uint booted; // Has the CPU started?
  int ncli; // Depth of pushcli nesting.
  int intena; // Were interrupts enabled before pushcli?
  
  // Cpu-local storage variables; see below
  struct cpu *cpu;
  struct proc *proc;
};

extern struct cpu cpus[NCPU];
extern int ncpu;

// Per-CPU variables, holding pointers to the
// current cpu and to the current process.
// The asm suffix tells gcc to use "%gs:0" to refer to cpu
// and "%gs:4" to refer to proc. ksegment sets up the
// %gs segment register so that %gs refers to the memory
// holding those two variables in the local cpu's struct cpu.
// This is similar to how thread-local variables are implemented
// in thread libraries such as Linux pthreads.
extern struct cpu *cpu asm("%gs:0"); // This cpu.
extern struct proc *proc asm("%gs:4"); // Current proc on this cpu.

// Saved registers for kernel context switches.
// Don't need to save all the segment registers (%cs, etc),
// because they are constant across kernel contexts.
// Don't need to save %eax, %ecx, %edx, because the
// x86 convention is that the caller has saved them.
// Contexts are stored at the bottom of the stack they
// describe; the stack pointer is the address of the context.
// The layout of the context matches the layout of the stack in swtch.S
// at the "Switch stacks" comment. Switch doesn't save eip explicitly,
// but it is on the stack and allocproc() manipulates it.
struct context {
  uint edi;
  uint esi;
  uint ebx;
  uint ebp;
  uint eip;
};

enum procstate { UNUSED, EMBRYO, SLEEPING, RUNNABLE, RUNNING, ZOMBIE, TZOMBIE };

#define offsetof(TYPE, MEMBER) ((uint) &((TYPE *)0)->MEMBER)
#define container_of(ptr, type, member) ({ \
const typeof( ((type *)0)->member ) *__mptr = (ptr); \
(type *)( (char *)__mptr - offsetof(type,member) );})

// Per-process state
struct proc {
  struct threadcommon {
    uint sz; // Size of process memory (bytes)
    pde_t* pgdir; // Linear address of proc's pgdir
    struct rwlock pglock; // Lock for the page table
    struct file *ofile[NOFILE];// Open files
    struct inode *cwd; // Current directory
    int killed; // If non-zero, have been killed
    struct spinlock lock; // Lock for the threadcommon
    int count; // Number of threads sharing this common
  } threadcommon;
  struct threadcommon *common; // Threadcommon pointer
  char *kstack; // Bottom of kernel stack for this process
  enum procstate state; // Process state
  volatile int pid; // Process ID
  struct proc *parent; // Parent process
  struct proc *mainThread; // Main thread
  struct trapframe *tf; // Trap frame for current syscall
  struct context *context; // Switch here to run process
  void *chan; // If non-zero, sleeping on chan
  char name[16]; // Process name (debugging)
};

// Process memory is laid out contiguously, low addresses first:
// text
// original data and bss
// fixed-size stack
// expandable heap
