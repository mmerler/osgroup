#include "types.h"
#include "user.h"
#include "record.h"
#include "fcntl.h"
#include "syscall.h"
#include "hw2-common.h"

int main(int argc, char *argv[]) {
  int ret;

  ret = startrecording();
  if (ret != 0)
    handle_error("error startrecording");

  ret = startrecording();
  if (ret == 0)
    handle_error("This startrecording should return -1");

  ret = startrecording();
  if (ret == 0)
    handle_error("This startrecording should return -1");

  ret = stoprecording();
  if (ret != 0)
    handle_error("error stoprecording");

  ret = stoprecording();
  if (ret == 0)
    handle_error("This stoprecording should return -1");
  
  printf(stdout, "hw2-test-invalid succeeded\n");

  exit();
}

