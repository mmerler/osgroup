#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "hw6-common.h"

int main() {
  int fd, r;
  char buf[1024];

  printf(stdout, "Homework 6 -- Functionality Test\n");

  fd = open("testfunc", O_RDWR | O_CREATE);
  if (fd < 0)
    panic("open() fail");

  r = ftag(fd, "test1", "TEST!", strlen("TEST!") + 1);
  if (r < 0)
    panic("ftag() fail");

  r = gettag(fd, "test1", buf, 1024);
  if (r < 0)
    panic("gettag() fail");
  if (strcmp(buf, "TEST!") != 0)
    panic("gettag() wrong");

  r = funtag(fd, "test1");
  if (r < 0)
    panic("funtag() fail");

  r = gettag(fd, "test1", buf, 1024);
  if (r >= 0)
    panic("gettag() fail -- should return -1");

  r = ftag(fd, "test2", "TEST@", strlen("TEST@") + 1);
  if (r < 0)
    panic("ftag() fail");

  r = close(fd);
  if (r < 0)
    panic("close() fail");

  fd = open("testfunc", O_RDWR);
  if (fd < 0)
    panic("open() fail");

  r = gettag(fd, "test1", buf, 1024);
  if (r >= 0)
    panic("gettag() fail -- should return -1");

  r = gettag(fd, "test2", buf, 1024);
  if (r < 0)
    panic("gettag() fail");
  if (strcmp(buf, "TEST@") != 0)
    panic("gettag() wrong");

  r = close(fd);
  if (r < 0)
    panic("close() fail");

  printf(stdout, "hw6-test-functionality succeeded\n");
  exit();
}
