// Added by Jingyue

#include "types.h"
#include "user.h"
#include "hw5-common.h"

#define N_LOOPS (100)
#define MAX_SIZE (64 * 1024)
#define N_PROCS (32)

int buf[MAX_SIZE];

int main() {

  int i;
	for (i = 0; i < MAX_SIZE; i++)
		buf[i] = 0;

  int root = 1;
  for (i = 0; i + 1 < N_PROCS; i++) {
    int child_pid = fork();
    if (child_pid < 0)
      panic("fork");
    if (child_pid == 0) {
      root = 0;
			break;
		}
  }

	int j;
	for (j = 0; j < N_LOOPS; j++) {
		for (i = 0; i < MAX_SIZE; i++)
			++buf[i];
	}

  // Wait for all children to exit. 
  while (wait() >= 0);

	if (!root)
		exit();
  
	printf(stdout, "hw5-test-stress succeeded\n");
  exit();
}

