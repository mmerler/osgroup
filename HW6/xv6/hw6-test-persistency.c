#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "hw6-common.h"

int main() {
  int fd, r;
  char buf[1024];

  printf(stdout, "Homework 6 -- Persistency Test\n");

  fd = open("testper", O_RDONLY);
  if (fd < 0)
    panic("open() fail");

  r = gettag(fd, "test1", buf, 1024);
  if (r < 0)
    panic("gettag() fail");
  if (strcmp(buf, "TEST!") != 0)
    panic("gettag() wrong");

  r = close(fd);
  if (r < 0)
    panic("close() fail");

  printf(stdout, "hw6-test-persistency succeeded\n");
  exit();
}
