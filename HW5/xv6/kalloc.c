// Physical memory allocator, intended to allocate
// memory for user processes, kernel stacks, page table pages,
// and pipe buffers. Allocates 4096-byte pages.

#include "types.h"
#include "defs.h"
#include "param.h"
#include "mmu.h"
#include "spinlock.h"

struct run {
  struct run *next;
};

struct {
  struct spinlock lock;
  struct run *freelist;
} kmem;

struct {
  struct spinlock lock;
  char* refCountList;
} refcounts;

// Initialize free list of physical pages.
void
kinit(void)
{
  extern char end[];
  
  
  initlock(&kmem.lock, "kmem");
  initlock(&refcounts.lock, "refcounts");

  char *p = (char*)PGROUNDUP((uint)end);

  

  for( ; p + PGSIZE - 1 < (char*) PHYSTOP; p += PGSIZE)
    {
      kfree(p);
    }

 

}

void initRefCounts() 
{
   // Get the number of free pages 
  int numFreePages = sys_freepages(); 

  acquire(&refcounts.lock);
  char* refCountPage = kalloc(); 
  if ( !refCountPage ) panic("refCountPage allocation failed \n");

  uint i = 0; 
  for ( ; i < numFreePages ; i++ ) 
    {
      refCountPage[i] = 0; 
    } 

  refcounts.refCountList = refCountPage;
  release(&refcounts.lock);

  cprintf("number of free pages before = %d, after = %d ", numFreePages, sys_freepages() );  
  cprintf( " refcounts[1] = %d", refcounts.refCountList[1] ); 

}

void incRefCount(uint a) 
{
  acquire(&refcounts.lock);

  extern char end[];
  
  char *p = (char*)PGROUNDUP((uint)end);
 

  uint idx = ((uint)a/PGSIZE)-((uint)p/PGSIZE);

  cprintf("inc refcounts.refCountList[i] =%x, a = %x \n",  refcounts.refCountList[idx], (uint)a/PGSIZE ); 

  refcounts.refCountList[idx] = refcounts.refCountList[idx] + 1;  

  cprintf("inc refcounts.refCountList[i] =%x, a = %x \n",  refcounts.refCountList[idx], (uint)a/PGSIZE ); 

  release(&refcounts.lock);
}

void decRefCount(uint a) 
{
  acquire(&refcounts.lock);

  extern char end[];
  char *p = (char*)PGROUNDUP((uint)end);
 
  uint idx = ((uint)a/PGSIZE)-((uint)p/PGSIZE);

  refcounts.refCountList[idx] = refcounts.refCountList[idx] - 1;  

  

  release(&refcounts.lock);

}

uint getRefCount(uint a)
{
  acquire(&refcounts.lock);
 
  extern char end[];
  char *p = (char*)PGROUNDUP((uint)end);
 
  uint idx = ((uint)a/PGSIZE)-((uint)p/PGSIZE);
 
  release(&refcounts.lock);

  return (uint)refcounts.refCountList[idx];

  
}


// Free the page of physical memory pointed at by v,
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
  struct run *r;

  if(((uint) v) % PGSIZE || (uint)v < 1024*1024 || (uint)v >= PHYSTOP) 
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  acquire(&kmem.lock);
  r = (struct run *) v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  release(&kmem.lock);

  /* acquire(&refcounts.lock); */
  /* refcounts.refCountList[(uint)r / PGSIZE] = 0; */
  /* release(&refcounts.lock); */

}

// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc()
{
  struct run *r;

  
  acquire(&kmem.lock);
  r = kmem.freelist;
  if(r)
    kmem.freelist = r->next;
  release(&kmem.lock);

  /* acquire(&refcounts.lock); */
  /* refcounts.refCountList[(uint)r / PGSIZE] = 0; */
  /* release(&refcounts.lock); */

  return (char*) r;
}

// Count the number of free physical pages.
int
sys_freepages()
{
  struct run *r;
  int num = 0;

  acquire(&kmem.lock);
  for (r = kmem.freelist; r; r = r->next)
    ++num;
  release(&kmem.lock);

  return num;
}

