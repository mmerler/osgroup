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
	This is an implemtation of the reader writer lock that favors the
	writer as presented by Courtois et al. "Concurrent Control with
	'Readers' and 'Writers'" Communications of the ACM, Vol. 14, 
	Number 10, Oct. 1971.
*/
void
initrwlock(struct rwlock *m)
{
	m->readcount = 0;
	m->writecount = 0;
	m->wantsR = 0;
	
	/*struct spinlock *mutex1 = (struct spinlock *) kalloc ();
	struct spinlock *mutex2 = (struct spinlock *) kalloc ();
	struct spinlock *mutex3 = (struct spinlock *) kalloc ();
	struct spinlock *r = (struct spinlock *) kalloc ();
	struct spinlock *w = (struct spinlock *) kalloc ();*/

	initlock (&m->mutex1, "mutex1");
	initlock (&m->mutex2, "mutex2");
	initlock (&m->mutex3, "mutex3");
	initlock (&m->w, "w");
	initlock (&m->r, "r");

	/*m->mutex1 = mutex1;
	m->mutex2 = mutex2;
	m->mutex3 = mutex3;
	m->w = w;
	m->r = r;*/
}

void
destroyrwlock(struct rwlock *m)
{
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
	acquire (&m->mutex3); //mutex3 ensures that a reader has exlusive
			    // access from acquire (m->r) to release (m->r)
			    // inclusive. In other words, only one process 
			    // is ever waiting at r.
		acquire (&m->r);
			acquire(&m->mutex1);
				m->readcount = m->readcount + 1;
				if(m->readcount == 1) 
					acquire(&m->w); //stops writers
			release(&m->mutex1);
		release (&m->r);
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
	release (&m->mutex3);
}

void
readunlock(struct rwlock *m)
{
	acquire (&m->mutex1);//ensures that only one reader is in this section
		m->readcount = m->readcount - 1;
		if (m->readcount == 0)
			release (&m->w);
	release (&m->mutex1);
}

void
writelock(struct rwlock *m)
{

	acquire (&m->mutex2);//ensures that only one writer is in this section
		m->writecount = m->writecount + 1;
		if (m->writecount == 1)
		{
			m->wantsR = 1;
			acquire(&m->r); //stops new readers from entering 
					//the critical section.
			m->wantsR = 0;
		}
	release (&m->mutex2);
	acquire (&m->w);
}

void
writeunlock(struct rwlock *m)
{
	release (&m->w);
	acquire (&m->mutex2);
		m->writecount = m->writecount - 1;
		if (m->writecount == 0) release (&m->r);

	release (&m->mutex2);
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

