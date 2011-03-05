#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "syscall.h"
#include "hw3-common.h"

#define N_THREADS 48

int check[N_THREADS];

void entry(void *arg)
{
  check[(int)arg] = MAGIC_VALUE + (int)arg;

  texit();
}

int main(int argc, char *argv[])
{
  char *stack[N_THREADS];
  int tid[N_THREADS];
  int i;

  for (i = 0; i < N_THREADS; i++)
    NEW_STACK_THREAD(entry, (char *)i, stack[i], tid[i]);

  for (i = 0; i < N_THREADS; i++) {
    if (twait(tid[i]) < 0)
      handle_error("twait() error");
    free(stack[i]);
  }

  for (i = 0; i < N_THREADS; i++) {
    if (check[i] != MAGIC_VALUE + i)
      handle_error("check value error");
  }

  // Either returns >= 0 or really exits will count to be wrong
  if (texit() >= 0)
    handle_error("texit() error");

  if (pschk() != 3)
    handle_error("proc status error");

  printf(stdout, "hw3-test-multiple succeeded!\n");

  exit();

  return 0;
}

