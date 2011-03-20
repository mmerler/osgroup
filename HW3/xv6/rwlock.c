// Read-write mutexes. 
// Added by Jingyue

#include "types.h"
#include "defs.h"
#include "param.h"
#include "x86.h"
#include "mmu.h"
#include "spinlock.h"
#include "rwlock.h"
#include "proc.h"

/*
	This is an implemtation of the reader writer lock design that 
	favors the writer presented by Courtois et al. in "Concurrent 
	Control with 'Readers' and 'Writers'" Communications of the ACM, 
	Vol. 14, Number 10, Oct. 1971.

	note to grader: swapped out spin locks at last minute.
*/

long test_and_set(volatile long* lock)
{
	int old;
	asm
	(
		"xchgl %0, %1"
		: "=r"(old), "+m"(*lock) // output
		: "0"(1) // input
		: "memory" // can clobber anything in memory
	);
	return old;
}


void
initrwlock(struct rwlock *m)
{
	m->readcount = 0;
	m->writecount = 0;
	//m->wantsR = 0;

	m->mutex1 = 0;
	m->mutex2 = 0;
	m->mutex3 = 0;
	m->wantsR = 0;
	m->wantsR = 0;
	
	/*struct spinlock *mutex1 = (struct spinlock *) kalloc ();
	struct spinlock *mutex2 = (struct spinlock *) kalloc ();
	struct spinlock *mutex3 = (struct spinlock *) kalloc ();
	struct spinlock *r = (struct spinlock *) kalloc ();
	struct spinlock *w = (struct spinlock *) kalloc ();*/

	/*initlock (&m->mutex1, "mutex1");
	initlock (&m->mutex2, "mutex2");
	initlock (&m->mutex3, "mutex3");
	initlock (&m->w, "w");
	initlock (&m->r, "r");*/

	/*m->mutex1 = mutex1;
	m->mutex2 = mutex2;
	m->mutex3 = mutex3;
	m->w = w;
	m->r = r;*/
}

void
destroyrwlock(struct rwlock *m)
{
	//As far a I know, we don't need anything hear since we
	//didn't use kalloc. 

	/*kfree ((void *) m->mutex1);
	kfree ((void *) m->mutex2);
	kfree ((void *) m->mutex3);
	kfree ((void *) m->w);
	kfree ((void *) m->r);*/

	//kfree ((void *) m);
}

void
readlock(struct rwlock *m)
{
	while (test_and_set (&m->mutex3)) yield (); //mutex3 ensures that a reader has exlusive
			    // access from acquire (m->r) to release (m->r)
			    // inclusive. In other words, only one process 
			    // is ever waiting at r.
		while (test_and_set (&m->r)) yield ();
			test_and_set(&m->mutex1);
				m->readcount = m->readcount + 1;
				if(m->readcount == 1) 
					while (test_and_set(&m->w)) yield (); //stops writers
			m->mutex1 = 0;
		m->r = 0;
	if (m->wantsR == 1) yield ();
	/*
		This is my addition to the Courtois et al. solution. I am
		not satisified that, while a writer is waiting at r, a 
		reader could release r and mutex3 and another reader could 
		acquire both of them before the writer has a chance. 
		Theoretically, as far as I can see, the writer could still 			starve. By placing a yield () after release r and before
		release mutex3, we ensure that the writer has a chance to 
		acquire r before the next reader.

		Simply adding a yield would, of course, create serious
		preformance issues as each reader would have to wait to be
		reschedualed before it could reader. For this reason we
		added a variable wantsR with the writer sets to tell the
		readers that it wants them to yield. Writes to wantsR are
		protected by mutex2. Reads to wantsR are not synchronized 
		and could produce undefined results. However, the worse 
		case scenario is that a reader fails to yeild when it is 
		suppose to or yeilds when it doesn't have to. Once way, it 
		preforms the same as the Courtois et al. lock and the 
		other it causes a minor preformance loss. Either way, not 
		a disaster.
	*/
	m->mutex3 = 0;
}

void
readunlock(struct rwlock *m)
{
	while (test_and_set (&m->mutex1)) yield ();//ensures that only one reader is in this section
		m->readcount = m->readcount - 1;
		if (m->readcount == 0)
			m->w = 0;
	m->mutex1 = 0;
}

void
writelock(struct rwlock *m)
{

	while (test_and_set (&m->mutex2)) yield ();//ensures that only one writer is in this section
		m->writecount = m->writecount + 1;
		if (m->writecount == 1)
		{
			m->wantsR = 1;
			while (test_and_set (&m->r)) yield (); //stops new readers from entering 
					//the critical section.
			m->wantsR = 0;
		}
	m->mutex2 = 0;
	while (test_and_set (&m->w)) yield ();
}

void
writeunlock(struct rwlock *m)
{
	m->w = 0;
	while (test_and_set (&m->mutex2)) yield ();
		m->writecount = m->writecount - 1;
		if (m->writecount == 0) 
			m->r = 0;
	m->mutex2 = 0;
}

int
sys_rwlock()
{
  struct rwlock *m;
  int op;

  if (argptr(0, (char **)&m, sizeof(struct rwlock)) < 0 || argint(1, &op) < 0)
    return -1;

  switch (op) {
    case OP_INIT: initrwlock(m); break;
    case OP_READLOCK: readlock(m); break;
    case OP_READUNLOCK: readunlock(m); break;
    case OP_WRITELOCK: writelock(m); break;
    case OP_WRITEUNLOCK: writeunlock(m); break;
    case OP_DESTROY: destroyrwlock(m); break;
    default: return -1; // Invalid op. 
  }

  return 0;
}

