// Added by Jingyue

#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "hw5-common.h"

#define MAX_BUF_SIZE (1024)

char *usertests_argv[] = {"usertests", 0};

int main() {
  int p[2];
  int child;
  char buf[MAX_BUF_SIZE];
  int succeed = 0;

  if (pipe(p) < 0)
    panic("pipe failed");

  child = fork();
  if (child == 0) {
    close(stdout);
    dup(p[1]);
    close(p[0]);
    close(p[1]);
    exec(usertests_argv[0], usertests_argv);
    panic("exec failed");
  }
  close(stdin);
  dup(p[0]);
  close(p[0]);
  close(p[1]);

  for (;;) {
    gets(buf, MAX_BUF_SIZE);
    if (strlen(buf) <= 0)
      break;
    if (strcmp(buf, "ALL TESTS PASSED\n") == 0)
      succeed = 1;
  }
  wait();

  if (succeed)
    printf(stdout, "hw5-test-comp succeeded\n");
  else
    printf(stdout, "hw5-test-comp failed\n");
  exit();
}

