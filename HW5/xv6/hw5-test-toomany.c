// Added by Jingyue

#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "stat.h"
#include "fs.h"
#include "hw5-common.h"

#define MAX_LEN (1024)
#define N_LOOPS (6)

int main() {

  int i;
  int root = 1;
  for (i = 0; i < N_LOOPS; i++) {
    int child_pid = fork();
    if (child_pid < 0) {
			int fd = open("fork-fail", O_CREATE);
			if (fd < 0)
				panic("open");
			close(fd);
		}
    if (child_pid == 0)
      root = 0;
  }

  sleep(root ? 4 * 100 : 1 * 100);
  // Wait for all children to exit. 
  while (wait() >= 0);
  // Only the root process decides whether the testcase is passed. 
  if (!root)
    exit();

	int fail = open("fork-fail", O_RDONLY);
	if (fail < 0)
		panic("Some forks should fail");
	close(fail);

  printf(stdout, "hw5-test-toomany succeeded\n");
  exit();
}

