#include "types.h"
#include "user.h"
#include "record.h"
#include "fcntl.h"
#include "syscall.h"
#include "hw2-common.h"

int main(int argc, char *argv[]) {
  int ret;
  struct record *records;
  int num_records;
  int pid;
  int child_pid;
  
  ret = startrecording();
  if (ret == -1)
    handle_error("error startrecording");

  child_pid = fork();
  
  pid = getpid();

  ret = stoprecording();
  if (ret == -1)
    handle_error("error stoprecording");

  num_records = fetchrecords(0, 0);
  if (num_records == -1)
    handle_error("error fetching # of records\n");

  if (child_pid == 0 && num_records != 2)
    handle_error("wrong # of records in child process");
  if (child_pid != 0 && num_records != 4)
    handle_error("wrong # of records in parent process");

  records = malloc(sizeof(struct record) * num_records);
  if (!records)
    handle_error("error malloc");
  ret = fetchrecords(records, num_records);
  if (ret == -1)
    handle_error("error fetchrecords");

  if (child_pid == 0) {
    check_syscall_no(&records[0], SYS_getpid);
    check_ret_value(&records[1], pid);
  } else {
    check_syscall_no(&records[0], SYS_fork);
    check_ret_value(&records[1], child_pid);
    check_syscall_no(&records[2], SYS_getpid);
    check_ret_value(&records[3], pid);
  }

  free(records);
  
  if (child_pid == 0) {
    // The child process creates a file called child-succ to notify the parent
    // process that it has exited successfully. 
    int fd = open("child-succ", O_CREATE);
    close(fd);
    exit();
  }

  int fd;
  int finished_pid = wait();
  if (finished_pid != child_pid)
    handle_error("Wrong child");
  fd = open("child-succ", O_RDONLY);
  if (fd == -1)
    handle_error("The child process did not exit normally");
  else
    close(fd);
  printf(stdout, "hw2-test-fork succeeded\n");

  exit();
}

