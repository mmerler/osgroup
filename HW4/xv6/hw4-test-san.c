#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "syscall.h"
#include "hw4-common.h"


#define N 8
#define MAX_PRIO 5

int main(int argc, const char *argv[])
{
	int i;
	int pid;
	int value[N];
	for (i = 0; i < N; i++) {
		value[i] = 0;
	}

	if ((pid=fork())) { /* parent */
		if (setpriority(pid, 1) < 0)
			handle_error("set priority failed\n");
		if (wait() != pid) {
			handle_error("child pid inconsistent\n");
		}
	} else { /* child */
		lengthy(value, N, 0);
		exit();
	}

	printf(stdout, "hw4-test-san succeeded\n");

	exit();
}
