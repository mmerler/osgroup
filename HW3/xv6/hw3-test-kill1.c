#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "syscall.h"
#include "hw3-common.h"

#define N_THREADS 8

int check;

void thread_verify(void *arg)
{
  check = MAGIC_VALUE;
  texit();
}

void thread_function(void *arg)
{
  for (;;)
    sleep(0xFFFF);

  texit();
}

void child_process(int do_exit, int thread)
{
  char *stack[N_THREADS];
  int tid[N_THREADS];
  int i;

  if (thread)
    for (i = 0; i < N_THREADS; i++)
      NEW_STACK_THREAD(thread_function, 0, stack[i], tid[i]);

  if (do_exit)
    exit();
  else
    for (;;)
      sleep(0xFFFF);
}

void start(int thread)
{
  int pid[4], i, j, cpid, flag;

  for (i = 0; i < 4; i++) {
    pid[i] = fork();
    if (pid[i] < 0)
      handle_error("fork() error");
    if (pid[i] == 0)
      child_process(i % 2, thread);
  }

  sleep(ONE_SEC / 2);

  for (i = 0; i < 4; i++) {
    if (kill(pid[i]) < 0)
      handle_error("kill() error");
  }

  for (i = 0; i < 4; i++) {
    flag = 0;
    cpid = wait();
    for (j = 0; j < 4; j++) {
      if (cpid == pid[j])
        flag = 1;
    }
    if (flag != 1)
      handle_error("wait() error");
  }
}

int main(int argc, char *argv[])
{
  char *stack;
  int tid;

  NEW_STACK_THREAD(thread_verify, 0, stack, tid);
  WAIT_THREAD(tid, 0);
  if (check != MAGIC_VALUE)
    handle_error("check value error");

  start(0);
  if (pschk() != 3)
    handle_error("proc status error");
  start(1);
  if (pschk() != 3)
    handle_error("proc status error");

  printf(stdout, "hw3-test-kill1 succeeded!\n");
  exit();
  return 0;
}

