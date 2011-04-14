#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "hw6-common.h"

int main() {
  int fd, r;
  char buf[1024];

  printf(stdout, "Homework 6 -- Permission Test\n");

  // WRONLY
  fd = open("testperm", O_WRONLY | O_CREATE);
  if (fd < 0)
    panic("open() fail");

  // ftag in WRONLY
  r = ftag(fd, "test", "TEST!", strlen("TEST!") + 1);
  if (r < 0)
    panic("ftag() fail");

  // gettag in WRONLY
  r = gettag(fd, "test", buf, 1024);
  if (r >= 0)
    panic("gettag() fail -- should return -1");

  // funtag in WRONLY
  r = funtag(fd, "test");
  if (r < 0)
    panic("funtag() fail");

  // Used for RDONLY tests
  r = ftag(fd, "test", "TEST@", strlen("TEST@") + 1);
  if (r < 0)
    panic("ftag() fail");

  r = close(fd);
  if (r < 0)
    panic("close() fail");

  // RDONLY
  fd = open("testperm", O_RDONLY);
  if (fd < 0)
    panic("open() fail");

  // gettag in RDONLY
  r = gettag(fd, "test", buf, 1024);
  if (r < 0)
    panic("gettag() fail");
  if (strcmp(buf, "TEST@") != 0)
    panic("gettag() wrong");

  // ftag in RDONLY
  r = ftag(fd, "test", "TEST!", strlen("TEST!") + 1);
  if (r >= 0)
    panic("ftag() fail -- should return -1");

  // funtag in RDONLY
  r = funtag(fd, "test");
  if (r >= 0)
    panic("funtag() fail -- should return -1");

  printf(stdout, "hw6-test-permission succeeded\n");
  exit();
}
