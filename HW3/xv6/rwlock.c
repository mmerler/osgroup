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
// HW3 Todo
}

void
destroyrwlock(struct rwlock *m)
{
// HW3 Todo
}

void
readlock(struct rwlock *m)
{
// HW3 Todo
}

void
readunlock(struct rwlock *m)
{
// HW3 Todo
}

void
writelock(struct rwlock *m)
{
// HW3 Todo
}

void
writeunlock(struct rwlock *m)
{
// HW3 Todo
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

