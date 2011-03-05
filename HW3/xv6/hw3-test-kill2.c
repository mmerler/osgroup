#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "syscall.h"
#include "hw3-common.h"

#define N_THREADS 8

int thread_check[N_THREADS];

void thread_function(void *arg)
{
  thread_check[(int)arg] = MAGIC_VALUE;

  for (;;)
    sleep(0xFFFF);

  texit();
}

void thread_kill_test()
{
  char *stack[N_THREADS];
  int tid[N_THREADS];
  int i;

  for (i = 0; i < N_THREADS; i ++)
    NEW_STACK_THREAD(thread_function, (void *)i, stack[i], tid[i]);

  for (i = 0; i < N_THREADS; i ++) {
    if (kill(tid[i]) >= 0)
      handle_error("kill() error");
  }

  sleep(ONE_SEC);

  for (i = 0; i < N_THREADS; i ++) {
    if (thread_check[i] != MAGIC_VALUE)
      handle_error("check value error");
  }

  PROC_CHECK(N_THREADS + 3);
}

int main(int argc, char *argv[])
{
  thread_kill_test();

  printf(stdout, "hw3-test-kill2 succeeded!\n");
  exit();
  return 0;
}

