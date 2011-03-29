// Added by Jingyue

#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "hw5-common.h"

#define MAX_SIZE (600 * 1024)

char buf[MAX_SIZE];

int main() {

  int num_before, num_after;
  int child_pid;
  
  num_before = freepages();
  child_pid = fork();
  if (child_pid == -1)
    panic("fork");
  if (child_pid == 0) {
    // Never exits. 
    while (1);
    exit();
  }
  num_after = freepages();

  kill(child_pid);
  if (wait() < 0)
    panic("wait");

  printf(stdout, "# of free pages before fork() = %d\n", num_before);
  printf(stdout, "# of free pages after fork() = %d\n", num_after);
  if (num_before - num_after > 20)
    printf(stdout, "Too many pages allocated when forking.\n");
  else
    printf(stdout, "hw5-test-page succeeded\n");

  exit();
}

