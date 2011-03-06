#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "syscall.h"
#include "hw3-common.h"

int check;

void entry(void *arg)
{
  check = MAGIC_VALUE;

  printf(stdout,"Hey I work!\n");
  
  texit();
}

int main(int argc, char *argv[])
{
  char *stack;
  int tid;

  NEW_STACK_THREAD(entry, 0, stack, tid);
  WAIT_THREAD(tid, 0);
  free(stack);

  NEW_STACK_THREAD(entry, 0, stack, tid);
  if (wait() >= 0)
    handle_error("wait() error");
  WAIT_THREAD(tid, 0);
  free(stack);

  if (twait(MAGIC_VALUE) >= 0)
    handle_error("twait() error");

  if (tfork(entry, 0, 0) >= 0)
    handle_error("tfork() error");

  if (check != MAGIC_VALUE)
    handle_error("check value error");

  if (texit() >= 0)
    handle_error("texit() error");

  PROC_CHECK(3);
  

  printf(stdout, "hw3-test-single succeeded!\n");

  exit();

  return 0;
}

