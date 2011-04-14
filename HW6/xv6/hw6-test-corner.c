#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "hw6-common.h"

int main() {
  int fd, r;
  char buf[512];
  // test: Excerpt form New Kid in Town by the Eagles
  char test[] = "There's talk on the street, it sounds so familiar. "
		"Great expectations, everybody's watching you. "
		"People you meet they all seem to know you. "
		"Even your old friends treat you like you're something new. "
		"Johnny come lately, the new kid in town. "
		"Everybody loves you so don't let them down. "
		"You look in her eyes, the music begins to play. "
		"Hopeless romantics, here we go again. "
		"But after a while you're looking the other way. "
		"It's those restless hearts that never mend. "
		"Johnny come lately, the new kid in town. "
		"Will she still love you when you're not around? "
		"There's so many things you should have told her. "
		"But night after night you're willing to hold her, "
		"just hold her. "
		"Tears on your shoulder.";

  printf(stdout, "Homework 6 -- Corner Case Test\n");

  fd = open("testcor", O_RDWR | O_CREATE);
  if (fd < 0)
    panic("open() fail");

  // Retag

  r = ftag(fd, "test1", "TEST!", strlen("TEST!") + 1);
  if (r < 0)
    panic("ftag() fail");

  r = ftag(fd, "test1", "GDXG@", strlen("GDXG@") + 1);
  if (r < 0)
    panic("ftag() fail");

  r = ftag(fd, "test1", "BCWB#", strlen("BCWB#") + 1);
  if (r < 0)
    panic("ftag() fail");

  r = gettag(fd, "test1", buf, 512);
  if (r < 0)
    panic("gettag() fail");
  if (strcmp(buf, "BCWB#") != 0)
    panic("gettag() wrong -- retag");

  // Non-exist

  r = gettag(fd, "testnonex", buf, 512);
  if (r >= 0)
    panic("gettag() fail -- should return -1");

  // Long data

  r = ftag(fd, "test2", test, strlen(test) + 1);
  if (r >= 0)
    panic("ftag() fail -- should return -1");

  // Zero data

  r = ftag(fd, "test2i", test, 0);
  if (r >= 0)
    panic("ftag() fail -- should return -1");

  // Long name

  r = ftag(fd, "test3name", "TEST#", strlen("TEST#") + 1);
  if (r < 0)
    panic("ftag() fail -- long name");

  r = ftag(fd, "test3name3", "GDXGE", strlen("GDXGE") + 1);
  if (r >= 0)
    panic("ftag() fail -- long name, should return -1");

  r = gettag(fd, "test3name", buf, 512);
  if (r < 0)
    panic("gettag() fail");
  if (strcmp(buf, "TEST#") != 0)
    panic("gettag() wrong -- long name");

  printf(stdout, "hw6-test-corner succeeded\n");
  exit();
}
