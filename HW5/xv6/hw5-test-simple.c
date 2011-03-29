// Added by Jingyue

#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "hw5-common.h"

int main(int argc, char *argv[]) {
  int pid;
  int child_pid;
  
  pid = getpid();
  child_pid = fork();

  if (child_pid == -1)
    panic("fork");

  if (child_pid == 0) {
    // The child process creates a file called child-succ to notify the parent
    // process that it has exited successfully. 
    int fd = open("child-succ", O_CREATE);
    close(fd);
    exit();
  }
  
  if (pid == child_pid)
    panic("pid shouldn't equal child_pid");

  int fd;
  int finished_pid = wait();
  if (finished_pid != child_pid)
    panic("Wrong child");

  fd = open("child-succ", O_RDONLY);
  if (fd == -1)
    panic("The child process did not exit normally");

  close(fd);
  printf(stdout, "hw5-test-simple succeeded\n");

  exit();
}

