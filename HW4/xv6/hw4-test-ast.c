#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "syscall.h"
#include "hw4-common.h"

/* N value will determine how lengthy the lengthy() will be */
#define N 8
#define NUM_CHILD 13
#define MAX_PROC_ID 256
#define MAX_PRIO 5


/* If the affinity works, this test case will reduce to one cpu scheduling */
int main(int argc, const char *argv[])
{
	int i;
	int pid=1;
	int value[N];
	int pids[NUM_CHILD];
	int pids_prio[MAX_PROC_ID];
	int cpuid=1;
	for (i = 0; i < N; i++) {
		value[i] = 0;
	}
	if (setaffinity(1, cpuid) < 0)  /* init process */
		handle_error("setaffinity failed\n");
	if (setaffinity(2, cpuid) < 0)  /* sh process */
		handle_error("setaffinity failed\n");
	if (setaffinity(getpid(), cpuid) < 0)
		handle_error("setaffinity failed\n");
	if (getaffinity(getpid()) != cpuid)
		handle_error("getaffinity failed or inconsistent.\n");

	/* All children will be distributed 
	 * to the first four queues.
	 * One child will be in the last queue,
	 * and it is suppposed to exit last.
	 */
	for (i = 0; i < NUM_CHILD; i++) {
		pid = fork();
		if (pid == -1) {
			handle_error("fork failed\n");
		} else if (pid == 0) { /* child */
			break;
		} else { /* parent */
			pids_prio[pid] = (i!=(NUM_CHILD-1) ? i % (MAX_PRIO-1) : MAX_PRIO-1);
			if (setpriority(pid, pids_prio[pid]) < 0) {
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
		       pids[i], pids_prio[pids[i]] );
	}

	if (pids_prio[pids[NUM_CHILD-1]] != MAX_PRIO - 1)
		handle_error("Scheduling error: the process in the last queue does not exit last.");
	

	printf(stdout, "hw4-test-ast succeeded\n");

	exit();
}
