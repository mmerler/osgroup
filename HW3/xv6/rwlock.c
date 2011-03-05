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

void
initrwlock(struct rwlock *m)
{
	m->readcount = 0;
	m->writecount = 0;
	
	struct spinlock *mutex1 = (struct spinlock *) kalloc ();
	struct spinlock *mutex2 = (struct spinlock *) kalloc ();
	struct spinlock *mutex3 = (struct spinlock *) kalloc ();
	struct spinlock *r = (struct spinlock *) kalloc ();
	struct spinlock *w = (struct spinlock *) kalloc ();

	initlock (mutex1, "mutex1");
	initlock (mutex2, "mutex2");
	initlock (mutex3, "mutex3");
	initlock (w, "w");
	initlock (r, "r");

	m->mutex1 = mutex1;
	m->mutex2 = mutex2;
	m->mutex3 = mutex3;
	m->w = w;
	m->r = r;
}

void
destroyrwlock(struct rwlock *m)
{
	kfree ((void *) m->mutex1);
	kfree ((void *) m->mutex2);
	kfree ((void *) m->mutex3);
	kfree ((void *) m->w);
	kfree ((void *) m->r);

	kfree ((void *) m);
}

void
readlock(struct rwlock *m)
{
	acquire (m->mutex3);
		acquire (m->r);
			acquire(m->mutex1);
				++ m->nreader;
				if(m->nreader == 1) 
					acquire(m->w);
			release(m->mutex1);
		release (m->r);
	release (m->mutex3);
}

void
readunlock(struct rwlock *m)
{
	acquire (m->mutex1);
		-- m->readcount;
		if (m->readcount == 0)
			release (m->w);
	release (m->mutex1);
}

void
writelock(struct rwlock *m)
{
	acquire (m->mutex2);
		++ m->writecount;
		if (writecount == 1)
			then  P(r);
	release (m->mutex2);
	acquire (m->w);
}

void
writeunlock(struct rwlock *m)
{
	release (m->w);
	acquire (m->mutex2);
		-- writecount;
		if (writecount == 0)
			release (m->r);
	release (m->mutex2);
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

