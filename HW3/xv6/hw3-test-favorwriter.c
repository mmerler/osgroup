// Added by Jingyue
// Test whether the rwlock favors writers. 
// Writers start at 0, 2, 5, 8, 11.
// Readers start at 1, 4, 7, 10, 12.
// Writers should finish in 3, 6, 9, ...
// All the readers should wait until the last writer completes, 
// and thus complete at (# of writers) * 3 + 3

#include "types.h"
#include "user.h"
#include "spinlock.h"
#include "rwlock.h"
#include "hw3-common.h"

#define N (5)
#define SLEEP_TIME (ONE_SEC * 3) // Must be a multiple of ONE_SEC
#define STACK_SIZE (4096)

void reader_main(void *arg) {
  struct rwlock *m = arg;
  rwlock(m, OP_READLOCK);
  sleep(SLEEP_TIME);
  rwlock(m, OP_READUNLOCK);
  texit();
}

void writer_main(void *arg) {
  struct rwlock *m = arg;
  rwlock(m, OP_WRITELOCK);
  sleep(SLEEP_TIME);
  rwlock(m, OP_WRITEUNLOCK);
  texit();
}

int main() {
  
  struct rwlock m;
  int t, j;
  int start = uptime();
  char *reader_stacks[N], *writer_stacks[N];
  int reader_tids[N], writer_tids[N];

  for (j = 0; j < N; j++) {
    writer_stacks[j] = malloc(STACK_SIZE);
    reader_stacks[j] = malloc(STACK_SIZE);
  }

  rwlock(&m, OP_INIT);

  for (t = 0; t <= (N - 1) * SLEEP_TIME; t += ONE_SEC) {
    printf(stderr, "Time: %d / %d\n", t, (N - 1) * SLEEP_TIME);
    if (t == 0 || t % SLEEP_TIME == ONE_SEC * 2) {
      int i = (t == 0 ? 0 : (t + ONE_SEC) / SLEEP_TIME);
      writer_tids[i] = tfork(
          writer_main,
          &m,
          writer_stacks[i] + STACK_SIZE);
      if (writer_tids[i] < 0)
        handle_error("error on tfork()");
    } else if (t % SLEEP_TIME == ONE_SEC || t == (N - 1) * SLEEP_TIME) {
      int i = (t == (N - 1) * SLEEP_TIME ? N - 1 : (t - ONE_SEC) / SLEEP_TIME);
      reader_tids[i] = tfork(
          reader_main,
          &m,
          reader_stacks[i] + STACK_SIZE);
      if (reader_tids[i] < 0)
        handle_error("error on tfork()");
    }
    sleep(ONE_SEC);
  }

  for (j = 0; j < N; j++) {
    if (twait(reader_tids[j]) < 0)
      handle_error("error on twait()");
    if (twait(writer_tids[j]) < 0)
      handle_error("error on twait()");
  }

  rwlock(&m, OP_DESTROY);
  
  printf(stderr, "Program finished in %d tick(s).\n", uptime() - start);
  if (!time_equal(uptime() - start, SLEEP_TIME * (N + 1)))
    handle_error("Did not finish in a correct time.");

  for (j = 0; j < N; j++) {
    free(reader_stacks[j]);
    free(writer_stacks[j]);
  }

  printf(stdout, "hw3-test-favorwriter succeeded\n");
 
  exit();
}

