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
  int i;
  
  ret = startrecording();
  if (ret == -1)
    handle_error("error startrecording");

  printf(stderr, "test\n");
  
  ret = stoprecording();
  if (ret == -1)
    handle_error("error stoprecording");

  num_records = fetchrecords(0, 0);
  if (num_records == -1)
    handle_error("error fetching # of records\n");

  if (num_records != 25)
    handle_error("# of records is wrong\n");

  records = malloc(sizeof(struct record) * num_records);
  if (!records)
    handle_error("error malloc");

  ret = fetchrecords(records, num_records);
  if (ret == -1)
    handle_error("error fetchrecords");

  for (i = 0; i < 5; i++) {
    check_syscall_no(&records[i * 5 + 0], SYS_write);
    check_arg_integer(&records[i * 5 + 1], stderr);
    check_arg_pointer(&records[i * 5 + 2], (void *)0x1f9b);
    check_arg_integer(&records[i * 5 + 3], 1);
    check_ret_value(&records[i * 5 + 4], 1);
  }

  free(records);

  printf(stdout, "hw2-test-pointer succeeded\n");

  exit();
}

