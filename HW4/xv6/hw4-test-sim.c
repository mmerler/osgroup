#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "syscall.h"
#include "hw4-common.h"

/* N value will determine how lengthy the lengthy() will be */
#define N 9
/* Do not modify NUM_CHILD, or else you may fail the test */
#define NUM_CHILD 7
#define NPROC 64
#define MAX_PRIO 5

int main(int argc, const char *argv[])
{
	int i;
	int pid=1;
	int value[N];
	int pids[NUM_CHILD];
	int pids_prio[NPROC];
	for (i = 0; i < N; i++) {
		value[i] = 0;
	}

	/* There are NUM_CHILD (7) children
	 * Two will be in the first queue
	 * Two will be in the second queue
	 * One will be in the 3rd queue
	 * One will be in the 4th queue
	 * One will be in the 5th queue
	 */
	for (i = 0; i < NUM_CHILD; i++) {
		pid = fork();
		if (pid == -1) {
			handle_error("fork failed\n");
		} else if (pid == 0) { /* child */
			break;
		} else { /* parent */
			pids_prio[pid] = i % MAX_PRIO;
			if (setpriority(pid, i % MAX_PRIO) < 0) {
				printf(stdout, 
				       "%d setpriority failed, prio: %d\n", 
				       getpid(), getpriority(getpid()));
				exit();
			}
		}
	}
	if (!pid) { /* children go here */
		sleep(1);
		lengthy(value, N, 0);
		exit();
	}

	/* parent goes here */
	for (i = 0; i < NUM_CHILD; i++) {
		pids[i] = wait();  
		/* pids[] records the order of finished children */
	}
	for (i = 0; i < NUM_CHILD; i++) {
		printf(stdout, "child %d exits: prio: %d\n", 
		       pids[i], pids_prio[pids[i]]);
	}

	if (pids_prio[pids[NUM_CHILD-1]] != MAX_PRIO - 1)
		handle_error("Scheduling error: the process in the last queue does not exit last.");
	
	for (i = 0; i+2 < NUM_CHILD; i+=2) {
		if (pids_prio[pids[i]] >= pids_prio[pids[i+2]]) {
			handle_error("Scheduling error: the expected exit time of children is wrong.");
		}
	}
	

	printf(stdout, "hw4-test-sim succeeded\n");

	exit();
}
