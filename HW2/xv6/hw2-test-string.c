#include "types.h"
#include "user.h"
#include "record.h"
#include "fcntl.h"
#include "syscall.h"
#include "hw2-common.h"

int main(int argc, char *argv[]) {
  int ret;
  struct record *records;
  int fd;
  int num_records;
  
  ret = startrecording();
  if (ret == -1)
    handle_error("error startrecording");

  fd = open("README", O_RDONLY);
  open("abcdefghijklmnopqrstuvwxyz", O_WRONLY);
  close(fd);
  
  ret = stoprecording();
  if (ret == -1)
    handle_error("error stoprecording");

  num_records = fetchrecords(0, 0);
  if (num_records == -1)
    handle_error("error fetching # of records\n");

  if (num_records != 11)
    handle_error("# of records is wrong\n");

  records = malloc(sizeof(struct record) * num_records);
  if (!records)
    handle_error("error malloc");

  ret = fetchrecords(records, num_records);
  if (ret == -1)
    handle_error("error fetchrecords");

  check_syscall_no(&records[0], SYS_open);
  check_arg_string(&records[1], "README");
  check_arg_integer(&records[2], O_RDONLY);
  check_ret_value(&records[3], fd);
  check_syscall_no(&records[4], SYS_open);
  check_arg_string(&records[5], "abcdefghijklmnopqrs");
  check_arg_integer(&records[6], O_WRONLY);
  check_ret_value(&records[7], -1);
  check_syscall_no(&records[8], SYS_close);
  check_arg_integer(&records[9], fd);
  check_ret_value(&records[10], 0);

  free(records);

  printf(stdout, "hw2-test-string succeeded\n");

  exit();
}

