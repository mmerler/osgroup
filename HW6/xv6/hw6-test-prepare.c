#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "hw6-common.h"

int main() {
  int fd, r;

  printf(stdout, "Homework 6 -- Persistency Test Preparation\n");

  /* simply create and tag a file "testper" then exit,
   * hw6-test-per will test if the tagging succeeded */

  fd = open("testper", O_WRONLY | O_CREATE);
  if (fd < 0)
    panic("open() fail");

  r = ftag(fd, "test1", "TEST!", strlen("TEST!") + 1);
  if (r < 0)
    panic("ftag() fail");

  r = close(fd);
  if (r < 0)
    panic("close() fail");

  printf(stdout, "hw6-test-prepare succeeded\n");
  exit();
}
