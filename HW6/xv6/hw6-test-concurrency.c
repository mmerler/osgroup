#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "hw6-common.h"


int main() {
  int fd, r, i, j;
  char tfn[6] = "conca";
  char buf[512];
  // test: excerpt from American Pie by Don McLean
  char test[10][512] = {"A long, long time ago...",
                        "I can still remember",
                        "How that music used to make me smile",
                        "And I knew if I had my chance",
                        "That I could make those people dance",
                        "And, maybe, they'd be happy for a while",
                        "But February made me shiver",
                        "With every paper I'd deliver",
                        "Bad news on the doorstep",
                        "I couldn't take one more step"};

  printf(stdout, "Homework 6 -- Concurrency Test\n");

  for (i = 0; i < 10; i++) {
    if (fork() == 0) {
      // The child process
      break;
    }
  }

  if (i == 10) {
    // The parent / control process

    // Wait for all children end
    for (i = 0; i < 10; i++)
      wait();

    // Check if all children succeed
    for (i = 0; i < 10; i++) {
      printf(stdout, "checking child %s...\n", tfn);

      fd = open(tfn, O_RDONLY);
      if (fd < 0)
        panic("open() fail -- child fail");
      r = close(fd);
      if (r < 0)
        panic("close() fail");

      tfn[4] += 1;
    }

    fd = open("testconc", O_RDONLY);
    if (fd < 0)
      panic("open() fail");

    r = gettag(fd, "test", buf, 512);
    if (r < 0)
      panic("gettag() fail");

    // Check if the value is one of the test string
    for (i = 0; i < 10; i++) {
      if (strncmp(buf, test[i], 512) == 0) {
        printf(stdout, "match: %s\n", test[i]);
        printf(stdout, "hw6-test-concurrency succeeded\n");
        exit();
      }
    }

    panic("no match");

  } else {
    // 10 children

    fd = open("testconc", O_WRONLY | O_CREATE);
    if (fd < 0)
      panic("open() fail");

    // Tag for 100 times 
    for (j = 0; j < 100; j++) {
      r = ftag(fd, "test", test[i], strlen(test[i]) + 1);
      if (r < 0)
        panic("ftag() fail");
    }

    r = close(fd);
    if (r < 0)
      panic("close() fail");

    // Create the child-success-file
    tfn[4] += i;
    fd = open(tfn, O_WRONLY | O_CREATE);
    if (fd < 0)
      panic("open() fail");
    r = close(fd);
    if (r < 0)
      panic("close() fail");

    exit();
  }

  return 0; /* dummy return */
}

