#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "syscall.h"
#include "hw4-common.h"


#define MAX_PRIO 5

int main(int argc, const char *argv[])
{
	if (nice(2*MAX_PRIO) != -1)
		handle_error("Error: error checking for syscalls should be implemented.\n");
	if (nice(-2*MAX_PRIO) != -1)
		handle_error("Error: error checking for syscalls should be implemented.\n");
	if (setpriority(-1,0) != -1)
		handle_error("Error: error checking for syscalls should be implemented.\n");
	if (getpriority(-1) != -1)
		handle_error("Error: error checking for syscalls should be implemented.\n");
	if (setpriority(getpid(),2*MAX_PRIO) != -1)
		handle_error("Error: error checking for syscalls should be implemented.\n");
	if (setpriority(getpid(),-1) != -1)
		handle_error("Error: error checking for syscalls should be implemented.\n");
	
	if (setaffinity(-1, 0) != -1)
		handle_error("Error: error checking for syscalls should be implemented.\n");
	if (setaffinity(getpid(), -1) != -1)
		handle_error("Error: error checking for syscalls should be implemented.\n");
	if (setaffinity(getpid(), 3) != -1)
		handle_error("Error: error checking for syscalls should be implemented.\n");
	if (getaffinity(-1) != -1)
		handle_error("Error: error checking for syscalls should be implemented.\n");

	printf(stdout, "hw4-test-err succeeded\n");

	exit();
}
