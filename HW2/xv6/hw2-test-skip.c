#include "types.h"
#include "user.h"
#include "record.h"
#include "fcntl.h"
#include "syscall.h"
#include "hw2-common.h"

int main(int argc, char *argv[]) {
  int num_records;

  startrecording();
  startrecording();
  startrecording();
  stoprecording();
  
  num_records = fetchrecords(0, 0);
  if (num_records == -1)
    handle_error("error fetching # of records\n");

  if (num_records != 0)
    handle_error("# of records is wrong\n");

  printf(stdout, "hw2-test-skip succeeded\n");

  exit();
}

