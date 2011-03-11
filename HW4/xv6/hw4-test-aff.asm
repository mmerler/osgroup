
_hw4-test-aff:     file format elf32-i386

Disassembly of section .text:

00000000 <lengthy>:
  printf(stderr, "%s\n", msg);
  exit();
}

void lengthy(int *value, int N, int k)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 ec 10             	sub    $0x10,%esp
	static int level = -1;
	int i;
	level = level + 1;
   9:	8b 15 d0 0a 00 00    	mov    0xad0,%edx
  printf(stderr, "%s\n", msg);
  exit();
}

void lengthy(int *value, int N, int k)
{
   f:	8b 7d 08             	mov    0x8(%ebp),%edi
  12:	8b 75 0c             	mov    0xc(%ebp),%esi
	static int level = -1;
	int i;
	level = level + 1;
	value[k] = level;
  15:	8b 45 10             	mov    0x10(%ebp),%eax

void lengthy(int *value, int N, int k)
{
	static int level = -1;
	int i;
	level = level + 1;
  18:	83 c2 01             	add    $0x1,%edx
  1b:	89 15 d0 0a 00 00    	mov    %edx,0xad0
	value[k] = level;

	for (i = 0; i < N; i++)
  21:	85 f6                	test   %esi,%esi
void lengthy(int *value, int N, int k)
{
	static int level = -1;
	int i;
	level = level + 1;
	value[k] = level;
  23:	8d 04 87             	lea    (%edi,%eax,4),%eax
  26:	89 45 f0             	mov    %eax,-0x10(%ebp)
  29:	89 10                	mov    %edx,(%eax)

	for (i = 0; i < N; i++)
  2b:	7e 29                	jle    56 <lengthy+0x56>
  2d:	31 db                	xor    %ebx,%ebx
  2f:	eb 07                	jmp    38 <lengthy+0x38>
  31:	83 c3 01             	add    $0x1,%ebx
  34:	39 f3                	cmp    %esi,%ebx
  36:	74 1e                	je     56 <lengthy+0x56>
		if (value[i] == 0)
  38:	8b 04 9f             	mov    (%edi,%ebx,4),%eax
  3b:	85 c0                	test   %eax,%eax
  3d:	75 f2                	jne    31 <lengthy+0x31>
			lengthy(value, N, i);
  3f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
	static int level = -1;
	int i;
	level = level + 1;
	value[k] = level;

	for (i = 0; i < N; i++)
  43:	83 c3 01             	add    $0x1,%ebx
		if (value[i] == 0)
			lengthy(value, N, i);
  46:	89 74 24 04          	mov    %esi,0x4(%esp)
  4a:	89 3c 24             	mov    %edi,(%esp)
  4d:	e8 ae ff ff ff       	call   0 <lengthy>
	static int level = -1;
	int i;
	level = level + 1;
	value[k] = level;

	for (i = 0; i < N; i++)
  52:	39 f3                	cmp    %esi,%ebx
  54:	75 e2                	jne    38 <lengthy+0x38>
		if (value[i] == 0)
			lengthy(value, N, i);

	level = level-1; 
	value[k] = 0;
  56:	8b 45 f0             	mov    -0x10(%ebp),%eax

	for (i = 0; i < N; i++)
		if (value[i] == 0)
			lengthy(value, N, i);

	level = level-1; 
  59:	83 2d d0 0a 00 00 01 	subl   $0x1,0xad0
	value[k] = 0;
  60:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return;
}
  66:	83 c4 10             	add    $0x10,%esp
  69:	5b                   	pop    %ebx
  6a:	5e                   	pop    %esi
  6b:	5f                   	pop    %edi
  6c:	5d                   	pop    %ebp
  6d:	c3                   	ret    
  6e:	66 90                	xchg   %ax,%ax

00000070 <handle_error>:
int stdout = 1;
int stderr = 2;
inline void handle_error(const char *msg) {
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	83 ec 18             	sub    $0x18,%esp
  printf(stderr, "%s\n", msg);
  76:	8b 45 08             	mov    0x8(%ebp),%eax
  79:	c7 44 24 04 88 09 00 	movl   $0x988,0x4(%esp)
  80:	00 
  81:	89 44 24 08          	mov    %eax,0x8(%esp)
  85:	a1 cc 0a 00 00       	mov    0xacc,%eax
  8a:	89 04 24             	mov    %eax,(%esp)
  8d:	e8 1e 06 00 00       	call   6b0 <printf>
  exit();
  92:	e8 a1 04 00 00       	call   538 <exit>
  97:	89 f6                	mov    %esi,%esi
  99:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000000a0 <main>:
#define MAX_PROC_ID 256
#define MAX_PRIO 5

/* If the affinity works, this test case will reduce to one cpu scheduling */
int main(int argc, const char *argv[])
{
  a0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  a4:	83 e4 f0             	and    $0xfffffff0,%esp
  a7:	ff 71 fc             	pushl  -0x4(%ecx)
	int value[N];
	int pids[NUM_CHILD];
	int pids_prio[MAX_PROC_ID];
	int cpuid = 1;
	for (i = 0; i < N; i++) {
		value[i] = 0;
  aa:	b8 02 00 00 00       	mov    $0x2,%eax
#define MAX_PROC_ID 256
#define MAX_PRIO 5

/* If the affinity works, this test case will reduce to one cpu scheduling */
int main(int argc, const char *argv[])
{
  af:	55                   	push   %ebp
  b0:	89 e5                	mov    %esp,%ebp
  b2:	57                   	push   %edi
  b3:	56                   	push   %esi
  b4:	53                   	push   %ebx
  b5:	51                   	push   %ecx
  b6:	81 ec 58 04 00 00    	sub    $0x458,%esp
	int value[N];
	int pids[NUM_CHILD];
	int pids_prio[MAX_PROC_ID];
	int cpuid = 1;
	for (i = 0; i < N; i++) {
		value[i] = 0;
  bc:	c7 45 b0 00 00 00 00 	movl   $0x0,-0x50(%ebp)
  c3:	c7 44 85 ac 00 00 00 	movl   $0x0,-0x54(%ebp,%eax,4)
  ca:	00 
  cb:	83 c0 01             	add    $0x1,%eax
	int pid=1;
	int value[N];
	int pids[NUM_CHILD];
	int pids_prio[MAX_PROC_ID];
	int cpuid = 1;
	for (i = 0; i < N; i++) {
  ce:	83 f8 0a             	cmp    $0xa,%eax
  d1:	75 f0                	jne    c3 <main+0x23>
	 * Two will be in the second queue
	 * One will be in the 3rd queue
	 * One will be in the 4th queue
	 * One will be in the 5th queue
	 */
	if (setaffinity(1, cpuid) < 0)  /* init process */
  d3:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  da:	00 
  db:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  e2:	e8 11 05 00 00       	call   5f8 <setaffinity>
  e7:	85 c0                	test   %eax,%eax
  e9:	0f 88 05 02 00 00    	js     2f4 <main+0x254>
		handle_error("setaffinity failed\n");
	if (setaffinity(2, cpuid) < 0)  /* sh process */
  ef:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  f6:	00 
  f7:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  fe:	e8 f5 04 00 00       	call   5f8 <setaffinity>
 103:	85 c0                	test   %eax,%eax
 105:	0f 88 e9 01 00 00    	js     2f4 <main+0x254>
		handle_error("setaffinity failed\n");
	if (setaffinity(getpid(), cpuid) < 0)
 10b:	e8 a8 04 00 00       	call   5b8 <getpid>
 110:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
 117:	00 
 118:	89 04 24             	mov    %eax,(%esp)
 11b:	e8 d8 04 00 00       	call   5f8 <setaffinity>
 120:	85 c0                	test   %eax,%eax
 122:	0f 88 cc 01 00 00    	js     2f4 <main+0x254>
		handle_error("setaffinity failed\n");
	if (getaffinity(getpid()) != cpuid)
 128:	e8 8b 04 00 00       	call   5b8 <getpid>
 12d:	31 ff                	xor    %edi,%edi
 12f:	89 04 24             	mov    %eax,(%esp)
 132:	e8 b9 04 00 00       	call   5f0 <getaffinity>
 137:	83 e8 01             	sub    $0x1,%eax
 13a:	0f 85 ce 01 00 00    	jne    30e <main+0x26e>
		handle_error("getaffinity failed or inconsistent.\n");

	for (i = 0; i < NUM_CHILD; i++) {
		pid = fork();
 140:	e8 eb 03 00 00       	call   530 <fork>
		if (pid == -1) {
 145:	83 f8 ff             	cmp    $0xffffffff,%eax
		handle_error("setaffinity failed\n");
	if (getaffinity(getpid()) != cpuid)
		handle_error("getaffinity failed or inconsistent.\n");

	for (i = 0; i < NUM_CHILD; i++) {
		pid = fork();
 148:	89 c3                	mov    %eax,%ebx
		if (pid == -1) {
 14a:	0f 84 20 01 00 00    	je     270 <main+0x1d0>
			handle_error("fork failed\n");
		} else if (pid == 0) { /* child */
 150:	85 c0                	test   %eax,%eax
 152:	0f 84 3a 01 00 00    	je     292 <main+0x1f2>
			//printf(stdout, "my pid: %d, my affinity: %d\n", 
			//	getpid(), getaffinity(getpid()));
			break;
		} else { /* parent */
			pids_prio[pid] = i % MAX_PRIO;
 158:	89 f8                	mov    %edi,%eax
 15a:	ba 67 66 66 66       	mov    $0x66666667,%edx
 15f:	f7 ea                	imul   %edx
 161:	89 f8                	mov    %edi,%eax
 163:	c1 f8 1f             	sar    $0x1f,%eax
 166:	89 fe                	mov    %edi,%esi
			if (setpriority(pid, i % MAX_PRIO) < 0) {
 168:	89 1c 24             	mov    %ebx,(%esp)
		} else if (pid == 0) { /* child */
			//printf(stdout, "my pid: %d, my affinity: %d\n", 
			//	getpid(), getaffinity(getpid()));
			break;
		} else { /* parent */
			pids_prio[pid] = i % MAX_PRIO;
 16b:	d1 fa                	sar    %edx
 16d:	29 c2                	sub    %eax,%edx
 16f:	8d 14 92             	lea    (%edx,%edx,4),%edx
 172:	29 d6                	sub    %edx,%esi
			if (setpriority(pid, i % MAX_PRIO) < 0) {
 174:	89 74 24 04          	mov    %esi,0x4(%esp)
 178:	e8 6b 04 00 00       	call   5e8 <setpriority>
 17d:	85 c0                	test   %eax,%eax
 17f:	0f 88 39 01 00 00    	js     2be <main+0x21e>
	if (setaffinity(getpid(), cpuid) < 0)
		handle_error("setaffinity failed\n");
	if (getaffinity(getpid()) != cpuid)
		handle_error("getaffinity failed or inconsistent.\n");

	for (i = 0; i < NUM_CHILD; i++) {
 185:	83 c7 01             	add    $0x1,%edi
 188:	83 ff 07             	cmp    $0x7,%edi
		} else if (pid == 0) { /* child */
			//printf(stdout, "my pid: %d, my affinity: %d\n", 
			//	getpid(), getaffinity(getpid()));
			break;
		} else { /* parent */
			pids_prio[pid] = i % MAX_PRIO;
 18b:	89 b4 9d b0 fb ff ff 	mov    %esi,-0x450(%ebp,%ebx,4)
	if (setaffinity(getpid(), cpuid) < 0)
		handle_error("setaffinity failed\n");
	if (getaffinity(getpid()) != cpuid)
		handle_error("getaffinity failed or inconsistent.\n");

	for (i = 0; i < NUM_CHILD; i++) {
 192:	75 ac                	jne    140 <main+0xa0>
		exit();
	}

	/* parent goes here */
	for (i = 0; i < NUM_CHILD; i++) {
		pids[i] = wait();
 194:	e8 a7 03 00 00       	call   540 <wait>
 199:	bb 02 00 00 00       	mov    $0x2,%ebx
 19e:	8d 75 d4             	lea    -0x2c(%ebp),%esi
 1a1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 1a4:	e8 97 03 00 00       	call   540 <wait>
 1a9:	89 44 9e fc          	mov    %eax,-0x4(%esi,%ebx,4)
 1ad:	83 c3 01             	add    $0x1,%ebx
		lengthy(value, N, 0);
		exit();
	}

	/* parent goes here */
	for (i = 0; i < NUM_CHILD; i++) {
 1b0:	83 fb 08             	cmp    $0x8,%ebx
 1b3:	75 ef                	jne    1a4 <main+0x104>
		pids[i] = wait();
		/* pids[] records the order of finished children */
	}
	for (i = 0; i < NUM_CHILD; i++) {
		printf(stdout, "child %d exits: prio: %d\n", 
 1b5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 1b8:	b3 02                	mov    $0x2,%bl
 1ba:	c7 44 24 04 ad 09 00 	movl   $0x9ad,0x4(%esp)
 1c1:	00 
 1c2:	8b 94 85 b0 fb ff ff 	mov    -0x450(%ebp,%eax,4),%edx
 1c9:	89 44 24 08          	mov    %eax,0x8(%esp)
 1cd:	a1 c8 0a 00 00       	mov    0xac8,%eax
 1d2:	89 54 24 0c          	mov    %edx,0xc(%esp)
 1d6:	89 04 24             	mov    %eax,(%esp)
 1d9:	e8 d2 04 00 00       	call   6b0 <printf>
 1de:	66 90                	xchg   %ax,%ax
 1e0:	8b 44 9e fc          	mov    -0x4(%esi,%ebx,4),%eax
 1e4:	83 c3 01             	add    $0x1,%ebx
 1e7:	c7 44 24 04 ad 09 00 	movl   $0x9ad,0x4(%esp)
 1ee:	00 
 1ef:	8b 94 85 b0 fb ff ff 	mov    -0x450(%ebp,%eax,4),%edx
 1f6:	89 44 24 08          	mov    %eax,0x8(%esp)
 1fa:	a1 c8 0a 00 00       	mov    0xac8,%eax
 1ff:	89 54 24 0c          	mov    %edx,0xc(%esp)
 203:	89 04 24             	mov    %eax,(%esp)
 206:	e8 a5 04 00 00       	call   6b0 <printf>
	/* parent goes here */
	for (i = 0; i < NUM_CHILD; i++) {
		pids[i] = wait();
		/* pids[] records the order of finished children */
	}
	for (i = 0; i < NUM_CHILD; i++) {
 20b:	83 fb 08             	cmp    $0x8,%ebx
 20e:	75 d0                	jne    1e0 <main+0x140>
		printf(stdout, "child %d exits: prio: %d\n", 
		       pids[i], pids_prio[pids[i]]);
	}

	if (pids_prio[pids[NUM_CHILD-1]] != MAX_PRIO - 1)
 210:	8b 45 ec             	mov    -0x14(%ebp),%eax
 213:	83 bc 85 b0 fb ff ff 	cmpl   $0x4,-0x450(%ebp,%eax,4)
 21a:	04 
 21b:	0f 85 fa 00 00 00    	jne    31b <main+0x27b>
		handle_error("Scheduling error: the process in the last queue does not exit last.");
	
	for (i = 0; i+2 < NUM_CHILD; i+=2) {
		if (pids_prio[pids[i]] >= pids_prio[pids[i+2]]) {
 221:	8b 45 dc             	mov    -0x24(%ebp),%eax
 224:	8b 94 85 b0 fb ff ff 	mov    -0x450(%ebp,%eax,4),%edx
 22b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 22e:	39 94 85 b0 fb ff ff 	cmp    %edx,-0x450(%ebp,%eax,4)
 235:	0f 8d c6 00 00 00    	jge    301 <main+0x261>
 23b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 23e:	8b 84 85 b0 fb ff ff 	mov    -0x450(%ebp,%eax,4),%eax
 245:	39 c2                	cmp    %eax,%edx
 247:	0f 8d b4 00 00 00    	jge    301 <main+0x261>
 24d:	83 f8 03             	cmp    $0x3,%eax
 250:	0f 8f ab 00 00 00    	jg     301 <main+0x261>
			handle_error("Scheduling error: the expected exit time of children is wrong.");
		}
	}
	

	printf(stdout, "hw4-test-aff succeeded\n");
 256:	a1 c8 0a 00 00       	mov    0xac8,%eax
 25b:	c7 44 24 04 c7 09 00 	movl   $0x9c7,0x4(%esp)
 262:	00 
 263:	89 04 24             	mov    %eax,(%esp)
 266:	e8 45 04 00 00       	call   6b0 <printf>

	exit();
 26b:	e8 c8 02 00 00       	call   538 <exit>
int stdout = 1;
int stderr = 2;
inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 270:	c7 44 24 08 a0 09 00 	movl   $0x9a0,0x8(%esp)
 277:	00 
  exit();
 278:	a1 cc 0a 00 00       	mov    0xacc,%eax
 27d:	c7 44 24 04 88 09 00 	movl   $0x988,0x4(%esp)
 284:	00 
 285:	89 04 24             	mov    %eax,(%esp)
 288:	e8 23 04 00 00       	call   6b0 <printf>
 28d:	e8 a6 02 00 00       	call   538 <exit>
				exit();
			}
		}
	}
	if (!pid) { /* children go here */
		sleep(1);
 292:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 299:	e8 2a 03 00 00       	call   5c8 <sleep>
		lengthy(value, N, 0);
 29e:	8d 45 b0             	lea    -0x50(%ebp),%eax
 2a1:	89 04 24             	mov    %eax,(%esp)
 2a4:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
 2ab:	00 
 2ac:	c7 44 24 04 09 00 00 	movl   $0x9,0x4(%esp)
 2b3:	00 
 2b4:	e8 47 fd ff ff       	call   0 <lengthy>
		exit();
 2b9:	e8 7a 02 00 00       	call   538 <exit>
			//	getpid(), getaffinity(getpid()));
			break;
		} else { /* parent */
			pids_prio[pid] = i % MAX_PRIO;
			if (setpriority(pid, i % MAX_PRIO) < 0) {
				printf(stdout, 
 2be:	e8 f5 02 00 00       	call   5b8 <getpid>
 2c3:	89 04 24             	mov    %eax,(%esp)
 2c6:	e8 15 03 00 00       	call   5e0 <getpriority>
 2cb:	89 c3                	mov    %eax,%ebx
 2cd:	e8 e6 02 00 00       	call   5b8 <getpid>
 2d2:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
 2d6:	c7 44 24 04 08 0a 00 	movl   $0xa08,0x4(%esp)
 2dd:	00 
 2de:	89 44 24 08          	mov    %eax,0x8(%esp)
 2e2:	a1 c8 0a 00 00       	mov    0xac8,%eax
 2e7:	89 04 24             	mov    %eax,(%esp)
 2ea:	e8 c1 03 00 00       	call   6b0 <printf>
				       "%d setpriority failed, prio: %d\n", 
				       getpid(), getpriority(getpid()));
				exit();
 2ef:	e8 44 02 00 00       	call   538 <exit>
int stdout = 1;
int stderr = 2;
inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 2f4:	c7 44 24 08 8c 09 00 	movl   $0x98c,0x8(%esp)
 2fb:	00 
 2fc:	e9 77 ff ff ff       	jmp    278 <main+0x1d8>
 301:	c7 44 24 08 70 0a 00 	movl   $0xa70,0x8(%esp)
 308:	00 
 309:	e9 6a ff ff ff       	jmp    278 <main+0x1d8>
 30e:	c7 44 24 08 e0 09 00 	movl   $0x9e0,0x8(%esp)
 315:	00 
 316:	e9 5d ff ff ff       	jmp    278 <main+0x1d8>
 31b:	c7 44 24 08 2c 0a 00 	movl   $0xa2c,0x8(%esp)
 322:	00 
 323:	e9 50 ff ff ff       	jmp    278 <main+0x1d8>
 328:	90                   	nop    
 329:	90                   	nop    
 32a:	90                   	nop    
 32b:	90                   	nop    
 32c:	90                   	nop    
 32d:	90                   	nop    
 32e:	90                   	nop    
 32f:	90                   	nop    

00000330 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	53                   	push   %ebx
 334:	8b 5d 08             	mov    0x8(%ebp),%ebx
 337:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 33a:	89 da                	mov    %ebx,%edx
 33c:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 340:	0f b6 01             	movzbl (%ecx),%eax
 343:	83 c1 01             	add    $0x1,%ecx
 346:	88 02                	mov    %al,(%edx)
 348:	83 c2 01             	add    $0x1,%edx
 34b:	84 c0                	test   %al,%al
 34d:	75 f1                	jne    340 <strcpy+0x10>
    ;
  return os;
}
 34f:	89 d8                	mov    %ebx,%eax
 351:	5b                   	pop    %ebx
 352:	5d                   	pop    %ebp
 353:	c3                   	ret    
 354:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 35a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000360 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	8b 4d 08             	mov    0x8(%ebp),%ecx
 366:	53                   	push   %ebx
 367:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 36a:	0f b6 01             	movzbl (%ecx),%eax
 36d:	84 c0                	test   %al,%al
 36f:	74 24                	je     395 <strcmp+0x35>
 371:	0f b6 13             	movzbl (%ebx),%edx
 374:	38 d0                	cmp    %dl,%al
 376:	74 12                	je     38a <strcmp+0x2a>
 378:	eb 1e                	jmp    398 <strcmp+0x38>
 37a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 380:	0f b6 13             	movzbl (%ebx),%edx
 383:	83 c1 01             	add    $0x1,%ecx
 386:	38 d0                	cmp    %dl,%al
 388:	75 0e                	jne    398 <strcmp+0x38>
 38a:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 38e:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 391:	84 c0                	test   %al,%al
 393:	75 eb                	jne    380 <strcmp+0x20>
 395:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 398:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 399:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 39c:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 39d:	0f b6 d2             	movzbl %dl,%edx
 3a0:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 3a2:	c3                   	ret    
 3a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000003b0 <strlen>:

uint
strlen(char *s)
{
 3b0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 3b1:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 3b3:	89 e5                	mov    %esp,%ebp
 3b5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 3b8:	80 39 00             	cmpb   $0x0,(%ecx)
 3bb:	74 0e                	je     3cb <strlen+0x1b>
 3bd:	31 d2                	xor    %edx,%edx
 3bf:	90                   	nop    
 3c0:	83 c2 01             	add    $0x1,%edx
 3c3:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
 3c7:	89 d0                	mov    %edx,%eax
 3c9:	75 f5                	jne    3c0 <strlen+0x10>
    ;
  return n;
}
 3cb:	5d                   	pop    %ebp
 3cc:	c3                   	ret    
 3cd:	8d 76 00             	lea    0x0(%esi),%esi

000003d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	8b 55 08             	mov    0x8(%ebp),%edx
 3d6:	57                   	push   %edi
 3d7:	8b 45 0c             	mov    0xc(%ebp),%eax
 3da:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3dd:	89 d7                	mov    %edx,%edi
 3df:	fc                   	cld    
 3e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3e2:	5f                   	pop    %edi
 3e3:	89 d0                	mov    %edx,%eax
 3e5:	5d                   	pop    %ebp
 3e6:	c3                   	ret    
 3e7:	89 f6                	mov    %esi,%esi
 3e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000003f0 <strchr>:

char*
strchr(const char *s, char c)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	8b 45 08             	mov    0x8(%ebp),%eax
 3f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 3fa:	0f b6 10             	movzbl (%eax),%edx
 3fd:	84 d2                	test   %dl,%dl
 3ff:	75 0c                	jne    40d <strchr+0x1d>
 401:	eb 11                	jmp    414 <strchr+0x24>
 403:	83 c0 01             	add    $0x1,%eax
 406:	0f b6 10             	movzbl (%eax),%edx
 409:	84 d2                	test   %dl,%dl
 40b:	74 07                	je     414 <strchr+0x24>
    if(*s == c)
 40d:	38 ca                	cmp    %cl,%dl
 40f:	90                   	nop    
 410:	75 f1                	jne    403 <strchr+0x13>
      return (char*) s;
  return 0;
}
 412:	5d                   	pop    %ebp
 413:	c3                   	ret    
 414:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 415:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 417:	c3                   	ret    
 418:	90                   	nop    
 419:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000420 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	8b 4d 08             	mov    0x8(%ebp),%ecx
 426:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 427:	31 db                	xor    %ebx,%ebx
 429:	0f b6 11             	movzbl (%ecx),%edx
 42c:	8d 42 d0             	lea    -0x30(%edx),%eax
 42f:	3c 09                	cmp    $0x9,%al
 431:	77 18                	ja     44b <atoi+0x2b>
    n = n*10 + *s++ - '0';
 433:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 436:	0f be d2             	movsbl %dl,%edx
 439:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 43d:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 441:	83 c1 01             	add    $0x1,%ecx
 444:	8d 42 d0             	lea    -0x30(%edx),%eax
 447:	3c 09                	cmp    $0x9,%al
 449:	76 e8                	jbe    433 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 44b:	89 d8                	mov    %ebx,%eax
 44d:	5b                   	pop    %ebx
 44e:	5d                   	pop    %ebp
 44f:	c3                   	ret    

00000450 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	8b 4d 10             	mov    0x10(%ebp),%ecx
 456:	56                   	push   %esi
 457:	8b 75 08             	mov    0x8(%ebp),%esi
 45a:	53                   	push   %ebx
 45b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 45e:	85 c9                	test   %ecx,%ecx
 460:	7e 10                	jle    472 <memmove+0x22>
 462:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 464:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 468:	88 04 32             	mov    %al,(%edx,%esi,1)
 46b:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 46e:	39 ca                	cmp    %ecx,%edx
 470:	75 f2                	jne    464 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 472:	89 f0                	mov    %esi,%eax
 474:	5b                   	pop    %ebx
 475:	5e                   	pop    %esi
 476:	5d                   	pop    %ebp
 477:	c3                   	ret    
 478:	90                   	nop    
 479:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000480 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 486:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 489:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 48c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 48f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 494:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 49b:	00 
 49c:	89 04 24             	mov    %eax,(%esp)
 49f:	e8 d4 00 00 00       	call   578 <open>
  if(fd < 0)
 4a4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4a6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 4a8:	78 19                	js     4c3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 4aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 4ad:	89 1c 24             	mov    %ebx,(%esp)
 4b0:	89 44 24 04          	mov    %eax,0x4(%esp)
 4b4:	e8 d7 00 00 00       	call   590 <fstat>
  close(fd);
 4b9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 4bc:	89 c6                	mov    %eax,%esi
  close(fd);
 4be:	e8 9d 00 00 00       	call   560 <close>
  return r;
}
 4c3:	89 f0                	mov    %esi,%eax
 4c5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 4c8:	8b 75 fc             	mov    -0x4(%ebp),%esi
 4cb:	89 ec                	mov    %ebp,%esp
 4cd:	5d                   	pop    %ebp
 4ce:	c3                   	ret    
 4cf:	90                   	nop    

000004d0 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	57                   	push   %edi
 4d4:	56                   	push   %esi
 4d5:	31 f6                	xor    %esi,%esi
 4d7:	53                   	push   %ebx
 4d8:	83 ec 1c             	sub    $0x1c,%esp
 4db:	8b 7d 08             	mov    0x8(%ebp),%edi
 4de:	eb 06                	jmp    4e6 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 4e0:	3c 0d                	cmp    $0xd,%al
 4e2:	74 39                	je     51d <gets+0x4d>
 4e4:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4e6:	8d 5e 01             	lea    0x1(%esi),%ebx
 4e9:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 4ec:	7d 31                	jge    51f <gets+0x4f>
    cc = read(0, &c, 1);
 4ee:	8d 45 f3             	lea    -0xd(%ebp),%eax
 4f1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4f8:	00 
 4f9:	89 44 24 04          	mov    %eax,0x4(%esp)
 4fd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 504:	e8 47 00 00 00       	call   550 <read>
    if(cc < 1)
 509:	85 c0                	test   %eax,%eax
 50b:	7e 12                	jle    51f <gets+0x4f>
      break;
    buf[i++] = c;
 50d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 511:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 515:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 519:	3c 0a                	cmp    $0xa,%al
 51b:	75 c3                	jne    4e0 <gets+0x10>
 51d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 51f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 523:	89 f8                	mov    %edi,%eax
 525:	83 c4 1c             	add    $0x1c,%esp
 528:	5b                   	pop    %ebx
 529:	5e                   	pop    %esi
 52a:	5f                   	pop    %edi
 52b:	5d                   	pop    %ebp
 52c:	c3                   	ret    
 52d:	90                   	nop    
 52e:	90                   	nop    
 52f:	90                   	nop    

00000530 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 530:	b8 01 00 00 00       	mov    $0x1,%eax
 535:	cd 40                	int    $0x40
 537:	c3                   	ret    

00000538 <exit>:
SYSCALL(exit)
 538:	b8 02 00 00 00       	mov    $0x2,%eax
 53d:	cd 40                	int    $0x40
 53f:	c3                   	ret    

00000540 <wait>:
SYSCALL(wait)
 540:	b8 03 00 00 00       	mov    $0x3,%eax
 545:	cd 40                	int    $0x40
 547:	c3                   	ret    

00000548 <pipe>:
SYSCALL(pipe)
 548:	b8 04 00 00 00       	mov    $0x4,%eax
 54d:	cd 40                	int    $0x40
 54f:	c3                   	ret    

00000550 <read>:
SYSCALL(read)
 550:	b8 06 00 00 00       	mov    $0x6,%eax
 555:	cd 40                	int    $0x40
 557:	c3                   	ret    

00000558 <write>:
SYSCALL(write)
 558:	b8 05 00 00 00       	mov    $0x5,%eax
 55d:	cd 40                	int    $0x40
 55f:	c3                   	ret    

00000560 <close>:
SYSCALL(close)
 560:	b8 07 00 00 00       	mov    $0x7,%eax
 565:	cd 40                	int    $0x40
 567:	c3                   	ret    

00000568 <kill>:
SYSCALL(kill)
 568:	b8 08 00 00 00       	mov    $0x8,%eax
 56d:	cd 40                	int    $0x40
 56f:	c3                   	ret    

00000570 <exec>:
SYSCALL(exec)
 570:	b8 09 00 00 00       	mov    $0x9,%eax
 575:	cd 40                	int    $0x40
 577:	c3                   	ret    

00000578 <open>:
SYSCALL(open)
 578:	b8 0a 00 00 00       	mov    $0xa,%eax
 57d:	cd 40                	int    $0x40
 57f:	c3                   	ret    

00000580 <mknod>:
SYSCALL(mknod)
 580:	b8 0b 00 00 00       	mov    $0xb,%eax
 585:	cd 40                	int    $0x40
 587:	c3                   	ret    

00000588 <unlink>:
SYSCALL(unlink)
 588:	b8 0c 00 00 00       	mov    $0xc,%eax
 58d:	cd 40                	int    $0x40
 58f:	c3                   	ret    

00000590 <fstat>:
SYSCALL(fstat)
 590:	b8 0d 00 00 00       	mov    $0xd,%eax
 595:	cd 40                	int    $0x40
 597:	c3                   	ret    

00000598 <link>:
SYSCALL(link)
 598:	b8 0e 00 00 00       	mov    $0xe,%eax
 59d:	cd 40                	int    $0x40
 59f:	c3                   	ret    

000005a0 <mkdir>:
SYSCALL(mkdir)
 5a0:	b8 0f 00 00 00       	mov    $0xf,%eax
 5a5:	cd 40                	int    $0x40
 5a7:	c3                   	ret    

000005a8 <chdir>:
SYSCALL(chdir)
 5a8:	b8 10 00 00 00       	mov    $0x10,%eax
 5ad:	cd 40                	int    $0x40
 5af:	c3                   	ret    

000005b0 <dup>:
SYSCALL(dup)
 5b0:	b8 11 00 00 00       	mov    $0x11,%eax
 5b5:	cd 40                	int    $0x40
 5b7:	c3                   	ret    

000005b8 <getpid>:
SYSCALL(getpid)
 5b8:	b8 12 00 00 00       	mov    $0x12,%eax
 5bd:	cd 40                	int    $0x40
 5bf:	c3                   	ret    

000005c0 <sbrk>:
SYSCALL(sbrk)
 5c0:	b8 13 00 00 00       	mov    $0x13,%eax
 5c5:	cd 40                	int    $0x40
 5c7:	c3                   	ret    

000005c8 <sleep>:
SYSCALL(sleep)
 5c8:	b8 14 00 00 00       	mov    $0x14,%eax
 5cd:	cd 40                	int    $0x40
 5cf:	c3                   	ret    

000005d0 <uptime>:
SYSCALL(uptime)
 5d0:	b8 15 00 00 00       	mov    $0x15,%eax
 5d5:	cd 40                	int    $0x40
 5d7:	c3                   	ret    

000005d8 <nice>:
SYSCALL(nice)
 5d8:	b8 16 00 00 00       	mov    $0x16,%eax
 5dd:	cd 40                	int    $0x40
 5df:	c3                   	ret    

000005e0 <getpriority>:
SYSCALL(getpriority)
 5e0:	b8 17 00 00 00       	mov    $0x17,%eax
 5e5:	cd 40                	int    $0x40
 5e7:	c3                   	ret    

000005e8 <setpriority>:
SYSCALL(setpriority)
 5e8:	b8 18 00 00 00       	mov    $0x18,%eax
 5ed:	cd 40                	int    $0x40
 5ef:	c3                   	ret    

000005f0 <getaffinity>:
SYSCALL(getaffinity)
 5f0:	b8 19 00 00 00       	mov    $0x19,%eax
 5f5:	cd 40                	int    $0x40
 5f7:	c3                   	ret    

000005f8 <setaffinity>:
SYSCALL(setaffinity)
 5f8:	b8 1a 00 00 00       	mov    $0x1a,%eax
 5fd:	cd 40                	int    $0x40
 5ff:	c3                   	ret    

00000600 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 600:	55                   	push   %ebp
 601:	89 e5                	mov    %esp,%ebp
 603:	83 ec 18             	sub    $0x18,%esp
 606:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 609:	8d 55 fc             	lea    -0x4(%ebp),%edx
 60c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 613:	00 
 614:	89 54 24 04          	mov    %edx,0x4(%esp)
 618:	89 04 24             	mov    %eax,(%esp)
 61b:	e8 38 ff ff ff       	call   558 <write>
}
 620:	c9                   	leave  
 621:	c3                   	ret    
 622:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 629:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000630 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	57                   	push   %edi
 634:	56                   	push   %esi
 635:	89 ce                	mov    %ecx,%esi
 637:	53                   	push   %ebx
 638:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 63b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 63e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 641:	85 c9                	test   %ecx,%ecx
 643:	74 04                	je     649 <printint+0x19>
 645:	85 d2                	test   %edx,%edx
 647:	78 54                	js     69d <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 649:	89 d0                	mov    %edx,%eax
 64b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 652:	31 db                	xor    %ebx,%ebx
 654:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 657:	31 d2                	xor    %edx,%edx
 659:	f7 f6                	div    %esi
 65b:	89 c1                	mov    %eax,%ecx
 65d:	0f b6 82 b7 0a 00 00 	movzbl 0xab7(%edx),%eax
 664:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 667:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 66a:	85 c9                	test   %ecx,%ecx
 66c:	89 c8                	mov    %ecx,%eax
 66e:	75 e7                	jne    657 <printint+0x27>
  if(neg)
 670:	8b 45 e0             	mov    -0x20(%ebp),%eax
 673:	85 c0                	test   %eax,%eax
 675:	74 08                	je     67f <printint+0x4f>
    buf[i++] = '-';
 677:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 67c:	83 c3 01             	add    $0x1,%ebx
 67f:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 682:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 686:	83 eb 01             	sub    $0x1,%ebx
 689:	8b 45 dc             	mov    -0x24(%ebp),%eax
 68c:	e8 6f ff ff ff       	call   600 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 691:	39 fb                	cmp    %edi,%ebx
 693:	75 ed                	jne    682 <printint+0x52>
    putc(fd, buf[i]);
}
 695:	83 c4 1c             	add    $0x1c,%esp
 698:	5b                   	pop    %ebx
 699:	5e                   	pop    %esi
 69a:	5f                   	pop    %edi
 69b:	5d                   	pop    %ebp
 69c:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 69d:	89 d0                	mov    %edx,%eax
 69f:	f7 d8                	neg    %eax
 6a1:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 6a8:	eb a8                	jmp    652 <printint+0x22>
 6aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000006b0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6b0:	55                   	push   %ebp
 6b1:	89 e5                	mov    %esp,%ebp
 6b3:	57                   	push   %edi
 6b4:	56                   	push   %esi
 6b5:	53                   	push   %ebx
 6b6:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6b9:	8b 55 0c             	mov    0xc(%ebp),%edx
 6bc:	0f b6 02             	movzbl (%edx),%eax
 6bf:	84 c0                	test   %al,%al
 6c1:	0f 84 87 00 00 00    	je     74e <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 6c7:	8d 4d 10             	lea    0x10(%ebp),%ecx
 6ca:	31 ff                	xor    %edi,%edi
 6cc:	31 f6                	xor    %esi,%esi
 6ce:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 6d1:	eb 18                	jmp    6eb <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 6d3:	83 fb 25             	cmp    $0x25,%ebx
 6d6:	0f 85 7a 00 00 00    	jne    756 <printf+0xa6>
 6dc:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6e0:	83 c7 01             	add    $0x1,%edi
 6e3:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 6e7:	84 c0                	test   %al,%al
 6e9:	74 63                	je     74e <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 6eb:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 6ed:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 6f0:	74 e1                	je     6d3 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6f2:	83 fe 25             	cmp    $0x25,%esi
 6f5:	75 e9                	jne    6e0 <printf+0x30>
      if(c == 'd'){
 6f7:	83 fb 64             	cmp    $0x64,%ebx
 6fa:	0f 84 f0 00 00 00    	je     7f0 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 700:	83 fb 78             	cmp    $0x78,%ebx
 703:	74 64                	je     769 <printf+0xb9>
 705:	83 fb 70             	cmp    $0x70,%ebx
 708:	74 5f                	je     769 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 70a:	83 fb 73             	cmp    $0x73,%ebx
 70d:	8d 76 00             	lea    0x0(%esi),%esi
 710:	74 7e                	je     790 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 712:	83 fb 63             	cmp    $0x63,%ebx
 715:	0f 84 b9 00 00 00    	je     7d4 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 71b:	83 fb 25             	cmp    $0x25,%ebx
 71e:	66 90                	xchg   %ax,%ax
 720:	0f 84 f2 00 00 00    	je     818 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 726:	8b 45 08             	mov    0x8(%ebp),%eax
 729:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 72e:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 731:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 733:	e8 c8 fe ff ff       	call   600 <putc>
        putc(fd, c);
 738:	8b 45 08             	mov    0x8(%ebp),%eax
 73b:	0f be d3             	movsbl %bl,%edx
 73e:	e8 bd fe ff ff       	call   600 <putc>
 743:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 746:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 74a:	84 c0                	test   %al,%al
 74c:	75 9d                	jne    6eb <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 74e:	83 c4 0c             	add    $0xc,%esp
 751:	5b                   	pop    %ebx
 752:	5e                   	pop    %esi
 753:	5f                   	pop    %edi
 754:	5d                   	pop    %ebp
 755:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 756:	8b 45 08             	mov    0x8(%ebp),%eax
 759:	0f be d3             	movsbl %bl,%edx
 75c:	e8 9f fe ff ff       	call   600 <putc>
 761:	8b 55 0c             	mov    0xc(%ebp),%edx
 764:	e9 77 ff ff ff       	jmp    6e0 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 769:	8b 45 f0             	mov    -0x10(%ebp),%eax
 76c:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 771:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 773:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 77a:	8b 10                	mov    (%eax),%edx
 77c:	8b 45 08             	mov    0x8(%ebp),%eax
 77f:	e8 ac fe ff ff       	call   630 <printint>
 784:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 787:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 78b:	e9 50 ff ff ff       	jmp    6e0 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 790:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 793:	8b 01                	mov    (%ecx),%eax
        ap++;
 795:	83 c1 04             	add    $0x4,%ecx
 798:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 79b:	b9 b0 0a 00 00       	mov    $0xab0,%ecx
 7a0:	85 c0                	test   %eax,%eax
 7a2:	75 2c                	jne    7d0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 7a4:	0f b6 01             	movzbl (%ecx),%eax
 7a7:	84 c0                	test   %al,%al
 7a9:	74 1e                	je     7c9 <printf+0x119>
 7ab:	89 cb                	mov    %ecx,%ebx
 7ad:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 7b0:	0f be d0             	movsbl %al,%edx
 7b3:	8b 45 08             	mov    0x8(%ebp),%eax
 7b6:	e8 45 fe ff ff       	call   600 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7bb:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 7bf:	83 c3 01             	add    $0x1,%ebx
 7c2:	84 c0                	test   %al,%al
 7c4:	75 ea                	jne    7b0 <printf+0x100>
 7c6:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 7c9:	31 f6                	xor    %esi,%esi
 7cb:	e9 10 ff ff ff       	jmp    6e0 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 7d0:	89 c1                	mov    %eax,%ecx
 7d2:	eb d0                	jmp    7a4 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 7d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 7d7:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 7d9:	0f be 10             	movsbl (%eax),%edx
 7dc:	8b 45 08             	mov    0x8(%ebp),%eax
 7df:	e8 1c fe ff ff       	call   600 <putc>
 7e4:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 7e7:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 7eb:	e9 f0 fe ff ff       	jmp    6e0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 7f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f3:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 7f8:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 7fb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 802:	8b 10                	mov    (%eax),%edx
 804:	8b 45 08             	mov    0x8(%ebp),%eax
 807:	e8 24 fe ff ff       	call   630 <printint>
 80c:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 80f:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 813:	e9 c8 fe ff ff       	jmp    6e0 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 818:	8b 45 08             	mov    0x8(%ebp),%eax
 81b:	ba 25 00 00 00       	mov    $0x25,%edx
 820:	31 f6                	xor    %esi,%esi
 822:	e8 d9 fd ff ff       	call   600 <putc>
 827:	8b 55 0c             	mov    0xc(%ebp),%edx
 82a:	e9 b1 fe ff ff       	jmp    6e0 <printf+0x30>
 82f:	90                   	nop    

00000830 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 830:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 831:	8b 0d dc 0a 00 00    	mov    0xadc,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 837:	89 e5                	mov    %esp,%ebp
 839:	56                   	push   %esi
 83a:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 83b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 83e:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 841:	39 d9                	cmp    %ebx,%ecx
 843:	73 18                	jae    85d <free+0x2d>
 845:	8b 11                	mov    (%ecx),%edx
 847:	39 d3                	cmp    %edx,%ebx
 849:	72 17                	jb     862 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 84b:	39 d1                	cmp    %edx,%ecx
 84d:	72 08                	jb     857 <free+0x27>
 84f:	39 d9                	cmp    %ebx,%ecx
 851:	72 0f                	jb     862 <free+0x32>
 853:	39 d3                	cmp    %edx,%ebx
 855:	72 0b                	jb     862 <free+0x32>
 857:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 859:	39 d9                	cmp    %ebx,%ecx
 85b:	72 e8                	jb     845 <free+0x15>
 85d:	8b 11                	mov    (%ecx),%edx
 85f:	90                   	nop    
 860:	eb e9                	jmp    84b <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 862:	8b 73 04             	mov    0x4(%ebx),%esi
 865:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 868:	39 d0                	cmp    %edx,%eax
 86a:	74 18                	je     884 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 86c:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 86e:	8b 51 04             	mov    0x4(%ecx),%edx
 871:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 874:	39 d8                	cmp    %ebx,%eax
 876:	74 20                	je     898 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 878:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 87a:	5b                   	pop    %ebx
 87b:	5e                   	pop    %esi
 87c:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 87d:	89 0d dc 0a 00 00    	mov    %ecx,0xadc
}
 883:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 884:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 887:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 889:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 88c:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 88f:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 891:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 894:	39 d8                	cmp    %ebx,%eax
 896:	75 e0                	jne    878 <free+0x48>
    p->s.size += bp->s.size;
 898:	03 53 04             	add    0x4(%ebx),%edx
 89b:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 89e:	8b 13                	mov    (%ebx),%edx
 8a0:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 8a2:	5b                   	pop    %ebx
 8a3:	5e                   	pop    %esi
 8a4:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 8a5:	89 0d dc 0a 00 00    	mov    %ecx,0xadc
}
 8ab:	c3                   	ret    
 8ac:	8d 74 26 00          	lea    0x0(%esi),%esi

000008b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8b0:	55                   	push   %ebp
 8b1:	89 e5                	mov    %esp,%ebp
 8b3:	57                   	push   %edi
 8b4:	56                   	push   %esi
 8b5:	53                   	push   %ebx
 8b6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 8bc:	8b 15 dc 0a 00 00    	mov    0xadc,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8c2:	83 c0 07             	add    $0x7,%eax
 8c5:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 8c8:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8ca:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 8cd:	0f 84 8a 00 00 00    	je     95d <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d3:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 8d5:	8b 41 04             	mov    0x4(%ecx),%eax
 8d8:	39 c3                	cmp    %eax,%ebx
 8da:	76 1a                	jbe    8f6 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 8dc:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 8e3:	3b 0d dc 0a 00 00    	cmp    0xadc,%ecx
 8e9:	89 ca                	mov    %ecx,%edx
 8eb:	74 29                	je     916 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ed:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 8ef:	8b 41 04             	mov    0x4(%ecx),%eax
 8f2:	39 c3                	cmp    %eax,%ebx
 8f4:	77 ed                	ja     8e3 <malloc+0x33>
      if(p->s.size == nunits)
 8f6:	39 c3                	cmp    %eax,%ebx
 8f8:	74 5d                	je     957 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 8fa:	29 d8                	sub    %ebx,%eax
 8fc:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 8ff:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 902:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 905:	89 15 dc 0a 00 00    	mov    %edx,0xadc
      return (void*) (p + 1);
 90b:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 90e:	83 c4 0c             	add    $0xc,%esp
 911:	5b                   	pop    %ebx
 912:	5e                   	pop    %esi
 913:	5f                   	pop    %edi
 914:	5d                   	pop    %ebp
 915:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 916:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 91c:	89 de                	mov    %ebx,%esi
 91e:	89 f8                	mov    %edi,%eax
 920:	76 29                	jbe    94b <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 922:	89 04 24             	mov    %eax,(%esp)
 925:	e8 96 fc ff ff       	call   5c0 <sbrk>
  if(p == (char*) -1)
 92a:	83 f8 ff             	cmp    $0xffffffff,%eax
 92d:	74 18                	je     947 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 92f:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 932:	83 c0 08             	add    $0x8,%eax
 935:	89 04 24             	mov    %eax,(%esp)
 938:	e8 f3 fe ff ff       	call   830 <free>
  return freep;
 93d:	8b 15 dc 0a 00 00    	mov    0xadc,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 943:	85 d2                	test   %edx,%edx
 945:	75 a6                	jne    8ed <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 947:	31 c0                	xor    %eax,%eax
 949:	eb c3                	jmp    90e <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 94b:	be 00 10 00 00       	mov    $0x1000,%esi
 950:	b8 00 80 00 00       	mov    $0x8000,%eax
 955:	eb cb                	jmp    922 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 957:	8b 01                	mov    (%ecx),%eax
 959:	89 02                	mov    %eax,(%edx)
 95b:	eb a8                	jmp    905 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 95d:	ba d4 0a 00 00       	mov    $0xad4,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 962:	c7 05 dc 0a 00 00 d4 	movl   $0xad4,0xadc
 969:	0a 00 00 
 96c:	c7 05 d4 0a 00 00 d4 	movl   $0xad4,0xad4
 973:	0a 00 00 
    base.s.size = 0;
 976:	c7 05 d8 0a 00 00 00 	movl   $0x0,0xad8
 97d:	00 00 00 
 980:	e9 4e ff ff ff       	jmp    8d3 <malloc+0x23>
