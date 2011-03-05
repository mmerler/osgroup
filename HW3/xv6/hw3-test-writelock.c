// Added by Jingyue

#include "types.h"
#include "user.h"
#include "spinlock.h"
#include "rwlock.h"
#include "hw3-common.h"

#define N_THREADS (10)
#define STACK_SIZE (4096)

void child_main(void *arg) {
  struct rwlock *m = arg;
  rwlock(m, OP_WRITELOCK);
  sleep(ONE_SEC);
  rwlock(m, OP_WRITEUNLOCK);
  texit();
}

int main() {
  
  struct rwlock m;
  int i;
  int children[N_THREADS];
  char *stacks[N_THREADS];
  int start = uptime();

  for (i = 0; i < N_THREADS; i++)
    stacks[i] = malloc(STACK_SIZE);

  rwlock(&m, OP_INIT);

  for (i = 0; i < N_THREADS; i++) {
    children[i] = tfork(child_main, &m, stacks[i] + STACK_SIZE);
    if (children[i] < 0)
      handle_error("error on tfork()");
  }

  for (i = 0; i < N_THREADS; i++) {
    if (twait(children[i]) < 0)
      handle_error("error on twait()");
  }

  rwlock(&m, OP_DESTROY);

  printf(stderr, "Program finished in %d tick(s).\n", uptime() - start);
  if (!time_equal(uptime() - start, ONE_SEC * N_THREADS))
    handle_error("Did not finish in a correct time.");

  for (i = 0; i < N_THREADS; i++)
    free(stacks[i]);

  printf(stdout, "hw3-test-writelock succeeded\n");
  
  exit();
}

