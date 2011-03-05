#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "syscall.h"
#include "hw3-common.h"

#define N_THREADS 48

int check;
int thread_check;

void child_func(void)
{
  check = MAGIC_VALUE;
  exit();
}

int forktest(int do_wait)
{
  int pid;

  pid = fork();
  if (pid < 0)
    handle_error("fork() error");
  if (pid == 0)
    child_func();
  if (do_wait) {
    if (wait() != pid)
      handle_error("wait() error");
    if (check == MAGIC_VALUE)
      handle_error("check value error");
  }
  return pid;
}

void thread_dude(void *arg)
{
  for (;;)
    sleep(0xFFFF);
  texit();
}

void thread_fork(void *arg)
{
  int pid;

  thread_check = MAGIC_VALUE;
  pid = forktest(1);
  texit();
}

void thread_wait(void *arg)
{
  int pid;

  pid = (int)arg;

  if (wait() != pid)
    handle_error("wait() error");

  texit();
}

int main(int argc, char *argv[])
{
  char *stack[N_THREADS], *fstack;
  int tid[N_THREADS], ftid, i;

  forktest(1);

  PROC_CHECK(3);

  for (i = 0; i < N_THREADS; i++)
    NEW_STACK_THREAD(thread_dude, 0, stack[i], tid[i]);
  PROC_CHECK(N_THREADS + 3);

  NEW_STACK_THREAD(thread_fork, 0, fstack, ftid);
  WAIT_THREAD(ftid, 0);
  if (thread_check != MAGIC_VALUE)
    handle_error("check value error");
  NEW_STACK_THREAD(thread_wait, (void *)forktest(0), fstack, ftid);
  WAIT_THREAD(ftid, 0);

  PROC_CHECK(N_THREADS + 3);

  printf(stdout, "hw3-test-fork succeeded!\n");

  exit();

  return 0;
}

