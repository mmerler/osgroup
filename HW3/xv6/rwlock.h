// Added by Jingyue
// Read-write mutexes

#define OP_INIT         0
#define OP_READLOCK     1
#define OP_READUNLOCK   2
#define OP_WRITELOCK    3
#define OP_WRITEUNLOCK  4
#define OP_DESTROY      5

struct rwlock 
{
	int readcount, writecount, wantsR;
	struct spinlock mutex1, mutex2, mutex3, w, r;
};

