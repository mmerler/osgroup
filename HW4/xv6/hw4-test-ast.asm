
_hw4-test-ast:     file format elf32-i386

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
   9:	8b 15 50 0a 00 00    	mov    0xa50,%edx
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
  1b:	89 15 50 0a 00 00    	mov    %edx,0xa50
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
  59:	83 2d 50 0a 00 00 01 	subl   $0x1,0xa50
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
  79:	c7 44 24 04 48 09 00 	movl   $0x948,0x4(%esp)
  80:	00 
  81:	89 44 24 08          	mov    %eax,0x8(%esp)
  85:	a1 4c 0a 00 00       	mov    0xa4c,%eax
  8a:	89 04 24             	mov    %eax,(%esp)
  8d:	e8 de 05 00 00       	call   670 <printf>
  exit();
  92:	e8 61 04 00 00       	call   4f8 <exit>
  97:	89 f6                	mov    %esi,%esi
  99:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000000a0 <main>:
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
	int cpuid=1;
	for (i = 0; i < N; i++) {
		value[i] = 0;
  aa:	b8 02 00 00 00       	mov    $0x2,%eax
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
  b6:	81 ec 78 04 00 00    	sub    $0x478,%esp
	int value[N];
	int pids[NUM_CHILD];
	int pids_prio[MAX_PROC_ID];
	int cpuid=1;
	for (i = 0; i < N; i++) {
		value[i] = 0;
  bc:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  c3:	c7 44 85 cc 00 00 00 	movl   $0x0,-0x34(%ebp,%eax,4)
  ca:	00 
  cb:	83 c0 01             	add    $0x1,%eax
	int pid=1;
	int value[N];
	int pids[NUM_CHILD];
	int pids_prio[MAX_PROC_ID];
	int cpuid=1;
	for (i = 0; i < N; i++) {
  ce:	83 f8 09             	cmp    $0x9,%eax
  d1:	75 f0                	jne    c3 <main+0x23>
		value[i] = 0;
	}
	if (setaffinity(1, cpuid) < 0)  /* init process */
  d3:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  da:	00 
  db:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  e2:	e8 d1 04 00 00       	call   5b8 <setaffinity>
  e7:	85 c0                	test   %eax,%eax
  e9:	0f 88 c0 01 00 00    	js     2af <main+0x20f>
		handle_error("setaffinity failed\n");
	if (setaffinity(2, cpuid) < 0)  /* sh process */
  ef:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  f6:	00 
  f7:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  fe:	e8 b5 04 00 00       	call   5b8 <setaffinity>
 103:	85 c0                	test   %eax,%eax
 105:	0f 88 a4 01 00 00    	js     2af <main+0x20f>
		handle_error("setaffinity failed\n");
	if (setaffinity(getpid(), cpuid) < 0)
 10b:	e8 68 04 00 00       	call   578 <getpid>
 110:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
 117:	00 
 118:	89 04 24             	mov    %eax,(%esp)
 11b:	e8 98 04 00 00       	call   5b8 <setaffinity>
 120:	85 c0                	test   %eax,%eax
 122:	0f 88 87 01 00 00    	js     2af <main+0x20f>
		handle_error("setaffinity failed\n");
	if (getaffinity(getpid()) != cpuid)
 128:	e8 4b 04 00 00       	call   578 <getpid>
 12d:	31 ff                	xor    %edi,%edi
 12f:	89 04 24             	mov    %eax,(%esp)
 132:	e8 79 04 00 00       	call   5b0 <getaffinity>
 137:	83 e8 01             	sub    $0x1,%eax
 13a:	0f 85 7c 01 00 00    	jne    2bc <main+0x21c>
	 * to the first four queues.
	 * One child will be in the last queue,
	 * and it is suppposed to exit last.
	 */
	for (i = 0; i < NUM_CHILD; i++) {
		pid = fork();
 140:	e8 ab 03 00 00       	call   4f0 <fork>
		if (pid == -1) {
 145:	83 f8 ff             	cmp    $0xffffffff,%eax
	 * to the first four queues.
	 * One child will be in the last queue,
	 * and it is suppposed to exit last.
	 */
	for (i = 0; i < NUM_CHILD; i++) {
		pid = fork();
 148:	89 c6                	mov    %eax,%esi
		if (pid == -1) {
 14a:	0f 84 f3 00 00 00    	je     243 <main+0x1a3>
			handle_error("fork failed\n");
		} else if (pid == 0) { /* child */
 150:	85 c0                	test   %eax,%eax
 152:	0f 84 f5 00 00 00    	je     24d <main+0x1ad>
			break;
		} else { /* parent */
			pids_prio[pid] = (i!=(NUM_CHILD-1) ? i % (MAX_PRIO-1) : MAX_PRIO-1);
 158:	83 ff 0c             	cmp    $0xc,%edi
 15b:	bb 04 00 00 00       	mov    $0x4,%ebx
 160:	74 10                	je     172 <main+0xd2>
 162:	89 f8                	mov    %edi,%eax
 164:	c1 f8 1f             	sar    $0x1f,%eax
 167:	c1 e8 1e             	shr    $0x1e,%eax
 16a:	8d 1c 07             	lea    (%edi,%eax,1),%ebx
 16d:	83 e3 03             	and    $0x3,%ebx
 170:	29 c3                	sub    %eax,%ebx
			if (setpriority(pid, pids_prio[pid]) < 0) {
 172:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 176:	89 34 24             	mov    %esi,(%esp)
 179:	e8 2a 04 00 00       	call   5a8 <setpriority>
 17e:	85 c0                	test   %eax,%eax
 180:	0f 88 f3 00 00 00    	js     279 <main+0x1d9>
	/* All children will be distributed 
	 * to the first four queues.
	 * One child will be in the last queue,
	 * and it is suppposed to exit last.
	 */
	for (i = 0; i < NUM_CHILD; i++) {
 186:	83 c7 01             	add    $0x1,%edi
 189:	83 ff 0d             	cmp    $0xd,%edi
		if (pid == -1) {
			handle_error("fork failed\n");
		} else if (pid == 0) { /* child */
			break;
		} else { /* parent */
			pids_prio[pid] = (i!=(NUM_CHILD-1) ? i % (MAX_PRIO-1) : MAX_PRIO-1);
 18c:	89 9c b5 9c fb ff ff 	mov    %ebx,-0x464(%ebp,%esi,4)
	/* All children will be distributed 
	 * to the first four queues.
	 * One child will be in the last queue,
	 * and it is suppposed to exit last.
	 */
	for (i = 0; i < NUM_CHILD; i++) {
 193:	75 ab                	jne    140 <main+0xa0>
		exit();
	}

	/* parent goes here */
	for (i = 0; i < NUM_CHILD; i++) {
		pids[i] = wait();  
 195:	e8 66 03 00 00       	call   500 <wait>
 19a:	bb 02 00 00 00       	mov    $0x2,%ebx
 19f:	8d 75 9c             	lea    -0x64(%ebp),%esi
 1a2:	89 45 9c             	mov    %eax,-0x64(%ebp)
 1a5:	e8 56 03 00 00       	call   500 <wait>
 1aa:	89 44 9e fc          	mov    %eax,-0x4(%esi,%ebx,4)
 1ae:	83 c3 01             	add    $0x1,%ebx
		lengthy(value, N, 0);
		exit();
	}

	/* parent goes here */
	for (i = 0; i < NUM_CHILD; i++) {
 1b1:	83 fb 0e             	cmp    $0xe,%ebx
 1b4:	75 ef                	jne    1a5 <main+0x105>
		pids[i] = wait();  
		/* pids[] records the order of finished children */
	}
	for (i = 0; i < NUM_CHILD; i++) {
		printf(stdout, "child %d exits: prio: %d\n", 
 1b6:	8b 45 9c             	mov    -0x64(%ebp),%eax
 1b9:	b3 02                	mov    $0x2,%bl
 1bb:	c7 44 24 04 6d 09 00 	movl   $0x96d,0x4(%esp)
 1c2:	00 
 1c3:	8b 94 85 9c fb ff ff 	mov    -0x464(%ebp,%eax,4),%edx
 1ca:	89 44 24 08          	mov    %eax,0x8(%esp)
 1ce:	a1 48 0a 00 00       	mov    0xa48,%eax
 1d3:	89 54 24 0c          	mov    %edx,0xc(%esp)
 1d7:	89 04 24             	mov    %eax,(%esp)
 1da:	e8 91 04 00 00       	call   670 <printf>
 1df:	90                   	nop    
 1e0:	8b 44 9e fc          	mov    -0x4(%esi,%ebx,4),%eax
 1e4:	83 c3 01             	add    $0x1,%ebx
 1e7:	c7 44 24 04 6d 09 00 	movl   $0x96d,0x4(%esp)
 1ee:	00 
 1ef:	8b 94 85 9c fb ff ff 	mov    -0x464(%ebp,%eax,4),%edx
 1f6:	89 44 24 08          	mov    %eax,0x8(%esp)
 1fa:	a1 48 0a 00 00       	mov    0xa48,%eax
 1ff:	89 54 24 0c          	mov    %edx,0xc(%esp)
 203:	89 04 24             	mov    %eax,(%esp)
 206:	e8 65 04 00 00       	call   670 <printf>
	/* parent goes here */
	for (i = 0; i < NUM_CHILD; i++) {
		pids[i] = wait();  
		/* pids[] records the order of finished children */
	}
	for (i = 0; i < NUM_CHILD; i++) {
 20b:	83 fb 0e             	cmp    $0xe,%ebx
 20e:	75 d0                	jne    1e0 <main+0x140>
		printf(stdout, "child %d exits: prio: %d\n", 
		       pids[i], pids_prio[pids[i]] );
	}

	if (pids_prio[pids[NUM_CHILD-1]] != MAX_PRIO - 1)
 210:	8b 45 cc             	mov    -0x34(%ebp),%eax
 213:	83 bc 85 9c fb ff ff 	cmpl   $0x4,-0x464(%ebp,%eax,4)
 21a:	04 
 21b:	0f 84 a8 00 00 00    	je     2c9 <main+0x229>
int stdout = 1;
int stderr = 2;
inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 221:	c7 44 24 08 ec 09 00 	movl   $0x9ec,0x8(%esp)
 228:	00 
 229:	a1 4c 0a 00 00       	mov    0xa4c,%eax
 22e:	c7 44 24 04 48 09 00 	movl   $0x948,0x4(%esp)
 235:	00 
 236:	89 04 24             	mov    %eax,(%esp)
 239:	e8 32 04 00 00       	call   670 <printf>
  exit();
 23e:	e8 b5 02 00 00       	call   4f8 <exit>
int stdout = 1;
int stderr = 2;
inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 243:	c7 44 24 08 60 09 00 	movl   $0x960,0x8(%esp)
 24a:	00 
 24b:	eb dc                	jmp    229 <main+0x189>
				exit();
			}
		}
	}
	if (!pid) { /* children go here */
		sleep(1);
 24d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 254:	e8 2f 03 00 00       	call   588 <sleep>
		lengthy(value, N, 0);
 259:	8d 45 d0             	lea    -0x30(%ebp),%eax
 25c:	89 04 24             	mov    %eax,(%esp)
 25f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
 266:	00 
 267:	c7 44 24 04 08 00 00 	movl   $0x8,0x4(%esp)
 26e:	00 
 26f:	e8 8c fd ff ff       	call   0 <lengthy>
		exit();
 274:	e8 7f 02 00 00       	call   4f8 <exit>
		} else if (pid == 0) { /* child */
			break;
		} else { /* parent */
			pids_prio[pid] = (i!=(NUM_CHILD-1) ? i % (MAX_PRIO-1) : MAX_PRIO-1);
			if (setpriority(pid, pids_prio[pid]) < 0) {
				printf(stdout, 
 279:	e8 fa 02 00 00       	call   578 <getpid>
 27e:	89 04 24             	mov    %eax,(%esp)
 281:	e8 1a 03 00 00       	call   5a0 <getpriority>
 286:	89 c3                	mov    %eax,%ebx
 288:	e8 eb 02 00 00       	call   578 <getpid>
 28d:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
 291:	c7 44 24 04 c8 09 00 	movl   $0x9c8,0x4(%esp)
 298:	00 
 299:	89 44 24 08          	mov    %eax,0x8(%esp)
 29d:	a1 48 0a 00 00       	mov    0xa48,%eax
 2a2:	89 04 24             	mov    %eax,(%esp)
 2a5:	e8 c6 03 00 00       	call   670 <printf>
				       "%d setpriority failed, prio: %d\n", 
				       getpid(), getpriority(getpid()));
				exit();
 2aa:	e8 49 02 00 00       	call   4f8 <exit>
 2af:	c7 44 24 08 4c 09 00 	movl   $0x94c,0x8(%esp)
 2b6:	00 
 2b7:	e9 6d ff ff ff       	jmp    229 <main+0x189>
 2bc:	c7 44 24 08 a0 09 00 	movl   $0x9a0,0x8(%esp)
 2c3:	00 
 2c4:	e9 60 ff ff ff       	jmp    229 <main+0x189>

	if (pids_prio[pids[NUM_CHILD-1]] != MAX_PRIO - 1)
		handle_error("Scheduling error: the process in the last queue does not exit last.");
	

	printf(stdout, "hw4-test-ast succeeded\n");
 2c9:	a1 48 0a 00 00       	mov    0xa48,%eax
 2ce:	c7 44 24 04 87 09 00 	movl   $0x987,0x4(%esp)
 2d5:	00 
 2d6:	89 04 24             	mov    %eax,(%esp)
 2d9:	e8 92 03 00 00       	call   670 <printf>

	exit();
 2de:	e8 15 02 00 00       	call   4f8 <exit>
 2e3:	90                   	nop    
 2e4:	90                   	nop    
 2e5:	90                   	nop    
 2e6:	90                   	nop    
 2e7:	90                   	nop    
 2e8:	90                   	nop    
 2e9:	90                   	nop    
 2ea:	90                   	nop    
 2eb:	90                   	nop    
 2ec:	90                   	nop    
 2ed:	90                   	nop    
 2ee:	90                   	nop    
 2ef:	90                   	nop    

000002f0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	53                   	push   %ebx
 2f4:	8b 5d 08             	mov    0x8(%ebp),%ebx
 2f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 2fa:	89 da                	mov    %ebx,%edx
 2fc:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 300:	0f b6 01             	movzbl (%ecx),%eax
 303:	83 c1 01             	add    $0x1,%ecx
 306:	88 02                	mov    %al,(%edx)
 308:	83 c2 01             	add    $0x1,%edx
 30b:	84 c0                	test   %al,%al
 30d:	75 f1                	jne    300 <strcpy+0x10>
    ;
  return os;
}
 30f:	89 d8                	mov    %ebx,%eax
 311:	5b                   	pop    %ebx
 312:	5d                   	pop    %ebp
 313:	c3                   	ret    
 314:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 31a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000320 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	8b 4d 08             	mov    0x8(%ebp),%ecx
 326:	53                   	push   %ebx
 327:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 32a:	0f b6 01             	movzbl (%ecx),%eax
 32d:	84 c0                	test   %al,%al
 32f:	74 24                	je     355 <strcmp+0x35>
 331:	0f b6 13             	movzbl (%ebx),%edx
 334:	38 d0                	cmp    %dl,%al
 336:	74 12                	je     34a <strcmp+0x2a>
 338:	eb 1e                	jmp    358 <strcmp+0x38>
 33a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 340:	0f b6 13             	movzbl (%ebx),%edx
 343:	83 c1 01             	add    $0x1,%ecx
 346:	38 d0                	cmp    %dl,%al
 348:	75 0e                	jne    358 <strcmp+0x38>
 34a:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 34e:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 351:	84 c0                	test   %al,%al
 353:	75 eb                	jne    340 <strcmp+0x20>
 355:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 358:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 359:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 35c:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 35d:	0f b6 d2             	movzbl %dl,%edx
 360:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 362:	c3                   	ret    
 363:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 369:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000370 <strlen>:

uint
strlen(char *s)
{
 370:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 371:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 373:	89 e5                	mov    %esp,%ebp
 375:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 378:	80 39 00             	cmpb   $0x0,(%ecx)
 37b:	74 0e                	je     38b <strlen+0x1b>
 37d:	31 d2                	xor    %edx,%edx
 37f:	90                   	nop    
 380:	83 c2 01             	add    $0x1,%edx
 383:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
 387:	89 d0                	mov    %edx,%eax
 389:	75 f5                	jne    380 <strlen+0x10>
    ;
  return n;
}
 38b:	5d                   	pop    %ebp
 38c:	c3                   	ret    
 38d:	8d 76 00             	lea    0x0(%esi),%esi

00000390 <memset>:

void*
memset(void *dst, int c, uint n)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	8b 55 08             	mov    0x8(%ebp),%edx
 396:	57                   	push   %edi
 397:	8b 45 0c             	mov    0xc(%ebp),%eax
 39a:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 39d:	89 d7                	mov    %edx,%edi
 39f:	fc                   	cld    
 3a0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3a2:	5f                   	pop    %edi
 3a3:	89 d0                	mov    %edx,%eax
 3a5:	5d                   	pop    %ebp
 3a6:	c3                   	ret    
 3a7:	89 f6                	mov    %esi,%esi
 3a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000003b0 <strchr>:

char*
strchr(const char *s, char c)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	8b 45 08             	mov    0x8(%ebp),%eax
 3b6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 3ba:	0f b6 10             	movzbl (%eax),%edx
 3bd:	84 d2                	test   %dl,%dl
 3bf:	75 0c                	jne    3cd <strchr+0x1d>
 3c1:	eb 11                	jmp    3d4 <strchr+0x24>
 3c3:	83 c0 01             	add    $0x1,%eax
 3c6:	0f b6 10             	movzbl (%eax),%edx
 3c9:	84 d2                	test   %dl,%dl
 3cb:	74 07                	je     3d4 <strchr+0x24>
    if(*s == c)
 3cd:	38 ca                	cmp    %cl,%dl
 3cf:	90                   	nop    
 3d0:	75 f1                	jne    3c3 <strchr+0x13>
      return (char*) s;
  return 0;
}
 3d2:	5d                   	pop    %ebp
 3d3:	c3                   	ret    
 3d4:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 3d5:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 3d7:	c3                   	ret    
 3d8:	90                   	nop    
 3d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000003e0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3e6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3e7:	31 db                	xor    %ebx,%ebx
 3e9:	0f b6 11             	movzbl (%ecx),%edx
 3ec:	8d 42 d0             	lea    -0x30(%edx),%eax
 3ef:	3c 09                	cmp    $0x9,%al
 3f1:	77 18                	ja     40b <atoi+0x2b>
    n = n*10 + *s++ - '0';
 3f3:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 3f6:	0f be d2             	movsbl %dl,%edx
 3f9:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3fd:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 401:	83 c1 01             	add    $0x1,%ecx
 404:	8d 42 d0             	lea    -0x30(%edx),%eax
 407:	3c 09                	cmp    $0x9,%al
 409:	76 e8                	jbe    3f3 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 40b:	89 d8                	mov    %ebx,%eax
 40d:	5b                   	pop    %ebx
 40e:	5d                   	pop    %ebp
 40f:	c3                   	ret    

00000410 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	8b 4d 10             	mov    0x10(%ebp),%ecx
 416:	56                   	push   %esi
 417:	8b 75 08             	mov    0x8(%ebp),%esi
 41a:	53                   	push   %ebx
 41b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 41e:	85 c9                	test   %ecx,%ecx
 420:	7e 10                	jle    432 <memmove+0x22>
 422:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 424:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 428:	88 04 32             	mov    %al,(%edx,%esi,1)
 42b:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 42e:	39 ca                	cmp    %ecx,%edx
 430:	75 f2                	jne    424 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 432:	89 f0                	mov    %esi,%eax
 434:	5b                   	pop    %ebx
 435:	5e                   	pop    %esi
 436:	5d                   	pop    %ebp
 437:	c3                   	ret    
 438:	90                   	nop    
 439:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000440 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 446:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 449:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 44c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 44f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 454:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 45b:	00 
 45c:	89 04 24             	mov    %eax,(%esp)
 45f:	e8 d4 00 00 00       	call   538 <open>
  if(fd < 0)
 464:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 466:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 468:	78 19                	js     483 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 46a:	8b 45 0c             	mov    0xc(%ebp),%eax
 46d:	89 1c 24             	mov    %ebx,(%esp)
 470:	89 44 24 04          	mov    %eax,0x4(%esp)
 474:	e8 d7 00 00 00       	call   550 <fstat>
  close(fd);
 479:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 47c:	89 c6                	mov    %eax,%esi
  close(fd);
 47e:	e8 9d 00 00 00       	call   520 <close>
  return r;
}
 483:	89 f0                	mov    %esi,%eax
 485:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 488:	8b 75 fc             	mov    -0x4(%ebp),%esi
 48b:	89 ec                	mov    %ebp,%esp
 48d:	5d                   	pop    %ebp
 48e:	c3                   	ret    
 48f:	90                   	nop    

00000490 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	56                   	push   %esi
 495:	31 f6                	xor    %esi,%esi
 497:	53                   	push   %ebx
 498:	83 ec 1c             	sub    $0x1c,%esp
 49b:	8b 7d 08             	mov    0x8(%ebp),%edi
 49e:	eb 06                	jmp    4a6 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 4a0:	3c 0d                	cmp    $0xd,%al
 4a2:	74 39                	je     4dd <gets+0x4d>
 4a4:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4a6:	8d 5e 01             	lea    0x1(%esi),%ebx
 4a9:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 4ac:	7d 31                	jge    4df <gets+0x4f>
    cc = read(0, &c, 1);
 4ae:	8d 45 f3             	lea    -0xd(%ebp),%eax
 4b1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4b8:	00 
 4b9:	89 44 24 04          	mov    %eax,0x4(%esp)
 4bd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4c4:	e8 47 00 00 00       	call   510 <read>
    if(cc < 1)
 4c9:	85 c0                	test   %eax,%eax
 4cb:	7e 12                	jle    4df <gets+0x4f>
      break;
    buf[i++] = c;
 4cd:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 4d1:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 4d5:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 4d9:	3c 0a                	cmp    $0xa,%al
 4db:	75 c3                	jne    4a0 <gets+0x10>
 4dd:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 4df:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 4e3:	89 f8                	mov    %edi,%eax
 4e5:	83 c4 1c             	add    $0x1c,%esp
 4e8:	5b                   	pop    %ebx
 4e9:	5e                   	pop    %esi
 4ea:	5f                   	pop    %edi
 4eb:	5d                   	pop    %ebp
 4ec:	c3                   	ret    
 4ed:	90                   	nop    
 4ee:	90                   	nop    
 4ef:	90                   	nop    

000004f0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4f0:	b8 01 00 00 00       	mov    $0x1,%eax
 4f5:	cd 40                	int    $0x40
 4f7:	c3                   	ret    

000004f8 <exit>:
SYSCALL(exit)
 4f8:	b8 02 00 00 00       	mov    $0x2,%eax
 4fd:	cd 40                	int    $0x40
 4ff:	c3                   	ret    

00000500 <wait>:
SYSCALL(wait)
 500:	b8 03 00 00 00       	mov    $0x3,%eax
 505:	cd 40                	int    $0x40
 507:	c3                   	ret    

00000508 <pipe>:
SYSCALL(pipe)
 508:	b8 04 00 00 00       	mov    $0x4,%eax
 50d:	cd 40                	int    $0x40
 50f:	c3                   	ret    

00000510 <read>:
SYSCALL(read)
 510:	b8 06 00 00 00       	mov    $0x6,%eax
 515:	cd 40                	int    $0x40
 517:	c3                   	ret    

00000518 <write>:
SYSCALL(write)
 518:	b8 05 00 00 00       	mov    $0x5,%eax
 51d:	cd 40                	int    $0x40
 51f:	c3                   	ret    

00000520 <close>:
SYSCALL(close)
 520:	b8 07 00 00 00       	mov    $0x7,%eax
 525:	cd 40                	int    $0x40
 527:	c3                   	ret    

00000528 <kill>:
SYSCALL(kill)
 528:	b8 08 00 00 00       	mov    $0x8,%eax
 52d:	cd 40                	int    $0x40
 52f:	c3                   	ret    

00000530 <exec>:
SYSCALL(exec)
 530:	b8 09 00 00 00       	mov    $0x9,%eax
 535:	cd 40                	int    $0x40
 537:	c3                   	ret    

00000538 <open>:
SYSCALL(open)
 538:	b8 0a 00 00 00       	mov    $0xa,%eax
 53d:	cd 40                	int    $0x40
 53f:	c3                   	ret    

00000540 <mknod>:
SYSCALL(mknod)
 540:	b8 0b 00 00 00       	mov    $0xb,%eax
 545:	cd 40                	int    $0x40
 547:	c3                   	ret    

00000548 <unlink>:
SYSCALL(unlink)
 548:	b8 0c 00 00 00       	mov    $0xc,%eax
 54d:	cd 40                	int    $0x40
 54f:	c3                   	ret    

00000550 <fstat>:
SYSCALL(fstat)
 550:	b8 0d 00 00 00       	mov    $0xd,%eax
 555:	cd 40                	int    $0x40
 557:	c3                   	ret    

00000558 <link>:
SYSCALL(link)
 558:	b8 0e 00 00 00       	mov    $0xe,%eax
 55d:	cd 40                	int    $0x40
 55f:	c3                   	ret    

00000560 <mkdir>:
SYSCALL(mkdir)
 560:	b8 0f 00 00 00       	mov    $0xf,%eax
 565:	cd 40                	int    $0x40
 567:	c3                   	ret    

00000568 <chdir>:
SYSCALL(chdir)
 568:	b8 10 00 00 00       	mov    $0x10,%eax
 56d:	cd 40                	int    $0x40
 56f:	c3                   	ret    

00000570 <dup>:
SYSCALL(dup)
 570:	b8 11 00 00 00       	mov    $0x11,%eax
 575:	cd 40                	int    $0x40
 577:	c3                   	ret    

00000578 <getpid>:
SYSCALL(getpid)
 578:	b8 12 00 00 00       	mov    $0x12,%eax
 57d:	cd 40                	int    $0x40
 57f:	c3                   	ret    

00000580 <sbrk>:
SYSCALL(sbrk)
 580:	b8 13 00 00 00       	mov    $0x13,%eax
 585:	cd 40                	int    $0x40
 587:	c3                   	ret    

00000588 <sleep>:
SYSCALL(sleep)
 588:	b8 14 00 00 00       	mov    $0x14,%eax
 58d:	cd 40                	int    $0x40
 58f:	c3                   	ret    

00000590 <uptime>:
SYSCALL(uptime)
 590:	b8 15 00 00 00       	mov    $0x15,%eax
 595:	cd 40                	int    $0x40
 597:	c3                   	ret    

00000598 <nice>:
SYSCALL(nice)
 598:	b8 16 00 00 00       	mov    $0x16,%eax
 59d:	cd 40                	int    $0x40
 59f:	c3                   	ret    

000005a0 <getpriority>:
SYSCALL(getpriority)
 5a0:	b8 17 00 00 00       	mov    $0x17,%eax
 5a5:	cd 40                	int    $0x40
 5a7:	c3                   	ret    

000005a8 <setpriority>:
SYSCALL(setpriority)
 5a8:	b8 18 00 00 00       	mov    $0x18,%eax
 5ad:	cd 40                	int    $0x40
 5af:	c3                   	ret    

000005b0 <getaffinity>:
SYSCALL(getaffinity)
 5b0:	b8 19 00 00 00       	mov    $0x19,%eax
 5b5:	cd 40                	int    $0x40
 5b7:	c3                   	ret    

000005b8 <setaffinity>:
SYSCALL(setaffinity)
 5b8:	b8 1a 00 00 00       	mov    $0x1a,%eax
 5bd:	cd 40                	int    $0x40
 5bf:	c3                   	ret    

000005c0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	83 ec 18             	sub    $0x18,%esp
 5c6:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 5c9:	8d 55 fc             	lea    -0x4(%ebp),%edx
 5cc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5d3:	00 
 5d4:	89 54 24 04          	mov    %edx,0x4(%esp)
 5d8:	89 04 24             	mov    %eax,(%esp)
 5db:	e8 38 ff ff ff       	call   518 <write>
}
 5e0:	c9                   	leave  
 5e1:	c3                   	ret    
 5e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 5e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000005f0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	57                   	push   %edi
 5f4:	56                   	push   %esi
 5f5:	89 ce                	mov    %ecx,%esi
 5f7:	53                   	push   %ebx
 5f8:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5fb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 5fe:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 601:	85 c9                	test   %ecx,%ecx
 603:	74 04                	je     609 <printint+0x19>
 605:	85 d2                	test   %edx,%edx
 607:	78 54                	js     65d <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 609:	89 d0                	mov    %edx,%eax
 60b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 612:	31 db                	xor    %ebx,%ebx
 614:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 617:	31 d2                	xor    %edx,%edx
 619:	f7 f6                	div    %esi
 61b:	89 c1                	mov    %eax,%ecx
 61d:	0f b6 82 37 0a 00 00 	movzbl 0xa37(%edx),%eax
 624:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 627:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 62a:	85 c9                	test   %ecx,%ecx
 62c:	89 c8                	mov    %ecx,%eax
 62e:	75 e7                	jne    617 <printint+0x27>
  if(neg)
 630:	8b 45 e0             	mov    -0x20(%ebp),%eax
 633:	85 c0                	test   %eax,%eax
 635:	74 08                	je     63f <printint+0x4f>
    buf[i++] = '-';
 637:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 63c:	83 c3 01             	add    $0x1,%ebx
 63f:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 642:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 646:	83 eb 01             	sub    $0x1,%ebx
 649:	8b 45 dc             	mov    -0x24(%ebp),%eax
 64c:	e8 6f ff ff ff       	call   5c0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 651:	39 fb                	cmp    %edi,%ebx
 653:	75 ed                	jne    642 <printint+0x52>
    putc(fd, buf[i]);
}
 655:	83 c4 1c             	add    $0x1c,%esp
 658:	5b                   	pop    %ebx
 659:	5e                   	pop    %esi
 65a:	5f                   	pop    %edi
 65b:	5d                   	pop    %ebp
 65c:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 65d:	89 d0                	mov    %edx,%eax
 65f:	f7 d8                	neg    %eax
 661:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 668:	eb a8                	jmp    612 <printint+0x22>
 66a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000670 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	57                   	push   %edi
 674:	56                   	push   %esi
 675:	53                   	push   %ebx
 676:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 679:	8b 55 0c             	mov    0xc(%ebp),%edx
 67c:	0f b6 02             	movzbl (%edx),%eax
 67f:	84 c0                	test   %al,%al
 681:	0f 84 87 00 00 00    	je     70e <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 687:	8d 4d 10             	lea    0x10(%ebp),%ecx
 68a:	31 ff                	xor    %edi,%edi
 68c:	31 f6                	xor    %esi,%esi
 68e:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 691:	eb 18                	jmp    6ab <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 693:	83 fb 25             	cmp    $0x25,%ebx
 696:	0f 85 7a 00 00 00    	jne    716 <printf+0xa6>
 69c:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6a0:	83 c7 01             	add    $0x1,%edi
 6a3:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 6a7:	84 c0                	test   %al,%al
 6a9:	74 63                	je     70e <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 6ab:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 6ad:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 6b0:	74 e1                	je     693 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6b2:	83 fe 25             	cmp    $0x25,%esi
 6b5:	75 e9                	jne    6a0 <printf+0x30>
      if(c == 'd'){
 6b7:	83 fb 64             	cmp    $0x64,%ebx
 6ba:	0f 84 f0 00 00 00    	je     7b0 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 6c0:	83 fb 78             	cmp    $0x78,%ebx
 6c3:	74 64                	je     729 <printf+0xb9>
 6c5:	83 fb 70             	cmp    $0x70,%ebx
 6c8:	74 5f                	je     729 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 6ca:	83 fb 73             	cmp    $0x73,%ebx
 6cd:	8d 76 00             	lea    0x0(%esi),%esi
 6d0:	74 7e                	je     750 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6d2:	83 fb 63             	cmp    $0x63,%ebx
 6d5:	0f 84 b9 00 00 00    	je     794 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 6db:	83 fb 25             	cmp    $0x25,%ebx
 6de:	66 90                	xchg   %ax,%ax
 6e0:	0f 84 f2 00 00 00    	je     7d8 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6e6:	8b 45 08             	mov    0x8(%ebp),%eax
 6e9:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6ee:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 6f1:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6f3:	e8 c8 fe ff ff       	call   5c0 <putc>
        putc(fd, c);
 6f8:	8b 45 08             	mov    0x8(%ebp),%eax
 6fb:	0f be d3             	movsbl %bl,%edx
 6fe:	e8 bd fe ff ff       	call   5c0 <putc>
 703:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 706:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 70a:	84 c0                	test   %al,%al
 70c:	75 9d                	jne    6ab <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 70e:	83 c4 0c             	add    $0xc,%esp
 711:	5b                   	pop    %ebx
 712:	5e                   	pop    %esi
 713:	5f                   	pop    %edi
 714:	5d                   	pop    %ebp
 715:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 716:	8b 45 08             	mov    0x8(%ebp),%eax
 719:	0f be d3             	movsbl %bl,%edx
 71c:	e8 9f fe ff ff       	call   5c0 <putc>
 721:	8b 55 0c             	mov    0xc(%ebp),%edx
 724:	e9 77 ff ff ff       	jmp    6a0 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 729:	8b 45 f0             	mov    -0x10(%ebp),%eax
 72c:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 731:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 733:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 73a:	8b 10                	mov    (%eax),%edx
 73c:	8b 45 08             	mov    0x8(%ebp),%eax
 73f:	e8 ac fe ff ff       	call   5f0 <printint>
 744:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 747:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 74b:	e9 50 ff ff ff       	jmp    6a0 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 750:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 753:	8b 01                	mov    (%ecx),%eax
        ap++;
 755:	83 c1 04             	add    $0x4,%ecx
 758:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 75b:	b9 30 0a 00 00       	mov    $0xa30,%ecx
 760:	85 c0                	test   %eax,%eax
 762:	75 2c                	jne    790 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 764:	0f b6 01             	movzbl (%ecx),%eax
 767:	84 c0                	test   %al,%al
 769:	74 1e                	je     789 <printf+0x119>
 76b:	89 cb                	mov    %ecx,%ebx
 76d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 770:	0f be d0             	movsbl %al,%edx
 773:	8b 45 08             	mov    0x8(%ebp),%eax
 776:	e8 45 fe ff ff       	call   5c0 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 77b:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 77f:	83 c3 01             	add    $0x1,%ebx
 782:	84 c0                	test   %al,%al
 784:	75 ea                	jne    770 <printf+0x100>
 786:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 789:	31 f6                	xor    %esi,%esi
 78b:	e9 10 ff ff ff       	jmp    6a0 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 790:	89 c1                	mov    %eax,%ecx
 792:	eb d0                	jmp    764 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 794:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 797:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 799:	0f be 10             	movsbl (%eax),%edx
 79c:	8b 45 08             	mov    0x8(%ebp),%eax
 79f:	e8 1c fe ff ff       	call   5c0 <putc>
 7a4:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 7a7:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 7ab:	e9 f0 fe ff ff       	jmp    6a0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 7b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b3:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 7b8:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 7bb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 7c2:	8b 10                	mov    (%eax),%edx
 7c4:	8b 45 08             	mov    0x8(%ebp),%eax
 7c7:	e8 24 fe ff ff       	call   5f0 <printint>
 7cc:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 7cf:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 7d3:	e9 c8 fe ff ff       	jmp    6a0 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 7d8:	8b 45 08             	mov    0x8(%ebp),%eax
 7db:	ba 25 00 00 00       	mov    $0x25,%edx
 7e0:	31 f6                	xor    %esi,%esi
 7e2:	e8 d9 fd ff ff       	call   5c0 <putc>
 7e7:	8b 55 0c             	mov    0xc(%ebp),%edx
 7ea:	e9 b1 fe ff ff       	jmp    6a0 <printf+0x30>
 7ef:	90                   	nop    

000007f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f1:	8b 0d 5c 0a 00 00    	mov    0xa5c,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 7f7:	89 e5                	mov    %esp,%ebp
 7f9:	56                   	push   %esi
 7fa:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 7fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 7fe:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 801:	39 d9                	cmp    %ebx,%ecx
 803:	73 18                	jae    81d <free+0x2d>
 805:	8b 11                	mov    (%ecx),%edx
 807:	39 d3                	cmp    %edx,%ebx
 809:	72 17                	jb     822 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 80b:	39 d1                	cmp    %edx,%ecx
 80d:	72 08                	jb     817 <free+0x27>
 80f:	39 d9                	cmp    %ebx,%ecx
 811:	72 0f                	jb     822 <free+0x32>
 813:	39 d3                	cmp    %edx,%ebx
 815:	72 0b                	jb     822 <free+0x32>
 817:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 819:	39 d9                	cmp    %ebx,%ecx
 81b:	72 e8                	jb     805 <free+0x15>
 81d:	8b 11                	mov    (%ecx),%edx
 81f:	90                   	nop    
 820:	eb e9                	jmp    80b <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 822:	8b 73 04             	mov    0x4(%ebx),%esi
 825:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 828:	39 d0                	cmp    %edx,%eax
 82a:	74 18                	je     844 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 82c:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 82e:	8b 51 04             	mov    0x4(%ecx),%edx
 831:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 834:	39 d8                	cmp    %ebx,%eax
 836:	74 20                	je     858 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 838:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 83a:	5b                   	pop    %ebx
 83b:	5e                   	pop    %esi
 83c:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 83d:	89 0d 5c 0a 00 00    	mov    %ecx,0xa5c
}
 843:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 844:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 847:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 849:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 84c:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 84f:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 851:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 854:	39 d8                	cmp    %ebx,%eax
 856:	75 e0                	jne    838 <free+0x48>
    p->s.size += bp->s.size;
 858:	03 53 04             	add    0x4(%ebx),%edx
 85b:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 85e:	8b 13                	mov    (%ebx),%edx
 860:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 862:	5b                   	pop    %ebx
 863:	5e                   	pop    %esi
 864:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 865:	89 0d 5c 0a 00 00    	mov    %ecx,0xa5c
}
 86b:	c3                   	ret    
 86c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000870 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 870:	55                   	push   %ebp
 871:	89 e5                	mov    %esp,%ebp
 873:	57                   	push   %edi
 874:	56                   	push   %esi
 875:	53                   	push   %ebx
 876:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 879:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 87c:	8b 15 5c 0a 00 00    	mov    0xa5c,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 882:	83 c0 07             	add    $0x7,%eax
 885:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 888:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 88a:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 88d:	0f 84 8a 00 00 00    	je     91d <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 893:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 895:	8b 41 04             	mov    0x4(%ecx),%eax
 898:	39 c3                	cmp    %eax,%ebx
 89a:	76 1a                	jbe    8b6 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 89c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 8a3:	3b 0d 5c 0a 00 00    	cmp    0xa5c,%ecx
 8a9:	89 ca                	mov    %ecx,%edx
 8ab:	74 29                	je     8d6 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ad:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 8af:	8b 41 04             	mov    0x4(%ecx),%eax
 8b2:	39 c3                	cmp    %eax,%ebx
 8b4:	77 ed                	ja     8a3 <malloc+0x33>
      if(p->s.size == nunits)
 8b6:	39 c3                	cmp    %eax,%ebx
 8b8:	74 5d                	je     917 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 8ba:	29 d8                	sub    %ebx,%eax
 8bc:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 8bf:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 8c2:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 8c5:	89 15 5c 0a 00 00    	mov    %edx,0xa5c
      return (void*) (p + 1);
 8cb:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8ce:	83 c4 0c             	add    $0xc,%esp
 8d1:	5b                   	pop    %ebx
 8d2:	5e                   	pop    %esi
 8d3:	5f                   	pop    %edi
 8d4:	5d                   	pop    %ebp
 8d5:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 8d6:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 8dc:	89 de                	mov    %ebx,%esi
 8de:	89 f8                	mov    %edi,%eax
 8e0:	76 29                	jbe    90b <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 8e2:	89 04 24             	mov    %eax,(%esp)
 8e5:	e8 96 fc ff ff       	call   580 <sbrk>
  if(p == (char*) -1)
 8ea:	83 f8 ff             	cmp    $0xffffffff,%eax
 8ed:	74 18                	je     907 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 8ef:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 8f2:	83 c0 08             	add    $0x8,%eax
 8f5:	89 04 24             	mov    %eax,(%esp)
 8f8:	e8 f3 fe ff ff       	call   7f0 <free>
  return freep;
 8fd:	8b 15 5c 0a 00 00    	mov    0xa5c,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 903:	85 d2                	test   %edx,%edx
 905:	75 a6                	jne    8ad <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 907:	31 c0                	xor    %eax,%eax
 909:	eb c3                	jmp    8ce <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 90b:	be 00 10 00 00       	mov    $0x1000,%esi
 910:	b8 00 80 00 00       	mov    $0x8000,%eax
 915:	eb cb                	jmp    8e2 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 917:	8b 01                	mov    (%ecx),%eax
 919:	89 02                	mov    %eax,(%edx)
 91b:	eb a8                	jmp    8c5 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 91d:	ba 54 0a 00 00       	mov    $0xa54,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 922:	c7 05 5c 0a 00 00 54 	movl   $0xa54,0xa5c
 929:	0a 00 00 
 92c:	c7 05 54 0a 00 00 54 	movl   $0xa54,0xa54
 933:	0a 00 00 
    base.s.size = 0;
 936:	c7 05 58 0a 00 00 00 	movl   $0x0,0xa58
 93d:	00 00 00 
 940:	e9 4e ff ff ff       	jmp    893 <malloc+0x23>
