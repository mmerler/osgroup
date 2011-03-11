
_hw4-test-sim:     file format elf32-i386

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
   9:	8b 15 14 0a 00 00    	mov    0xa14,%edx
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
  1b:	89 15 14 0a 00 00    	mov    %edx,0xa14
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
  59:	83 2d 14 0a 00 00 01 	subl   $0x1,0xa14
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
  79:	c7 44 24 04 08 09 00 	movl   $0x908,0x4(%esp)
  80:	00 
  81:	89 44 24 08          	mov    %eax,0x8(%esp)
  85:	a1 10 0a 00 00       	mov    0xa10,%eax
  8a:	89 04 24             	mov    %eax,(%esp)
  8d:	e8 9e 05 00 00       	call   630 <printf>
  exit();
  92:	e8 21 04 00 00       	call   4b8 <exit>
  97:	89 f6                	mov    %esi,%esi
  99:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000000a0 <main>:
#define NUM_CHILD 7
#define NPROC 64
#define MAX_PRIO 5

int main(int argc, const char *argv[])
{
  a0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  a4:	83 e4 f0             	and    $0xfffffff0,%esp
  a7:	ff 71 fc             	pushl  -0x4(%ecx)
	int pid=1;
	int value[N];
	int pids[NUM_CHILD];
	int pids_prio[NPROC];
	for (i = 0; i < N; i++) {
		value[i] = 0;
  aa:	b8 02 00 00 00       	mov    $0x2,%eax
#define NUM_CHILD 7
#define NPROC 64
#define MAX_PRIO 5

int main(int argc, const char *argv[])
{
  af:	55                   	push   %ebp
  b0:	89 e5                	mov    %esp,%ebp
  b2:	57                   	push   %edi
  b3:	56                   	push   %esi
  b4:	53                   	push   %ebx
  b5:	51                   	push   %ecx
  b6:	81 ec 58 01 00 00    	sub    $0x158,%esp
	int pid=1;
	int value[N];
	int pids[NUM_CHILD];
	int pids_prio[NPROC];
	for (i = 0; i < N; i++) {
		value[i] = 0;
  bc:	c7 45 b0 00 00 00 00 	movl   $0x0,-0x50(%ebp)
  c3:	c7 44 85 ac 00 00 00 	movl   $0x0,-0x54(%ebp,%eax,4)
  ca:	00 
  cb:	83 c0 01             	add    $0x1,%eax
	int i;
	int pid=1;
	int value[N];
	int pids[NUM_CHILD];
	int pids_prio[NPROC];
	for (i = 0; i < N; i++) {
  ce:	83 f8 0a             	cmp    $0xa,%eax
  d1:	75 f0                	jne    c3 <main+0x23>
  d3:	31 ff                	xor    %edi,%edi
	 * One will be in the 3rd queue
	 * One will be in the 4th queue
	 * One will be in the 5th queue
	 */
	for (i = 0; i < NUM_CHILD; i++) {
		pid = fork();
  d5:	e8 d6 03 00 00       	call   4b0 <fork>
		if (pid == -1) {
  da:	83 f8 ff             	cmp    $0xffffffff,%eax
	 * One will be in the 3rd queue
	 * One will be in the 4th queue
	 * One will be in the 5th queue
	 */
	for (i = 0; i < NUM_CHILD; i++) {
		pid = fork();
  dd:	89 c3                	mov    %eax,%ebx
		if (pid == -1) {
  df:	0f 84 2b 01 00 00    	je     210 <main+0x170>
			handle_error("fork failed\n");
		} else if (pid == 0) { /* child */
  e5:	85 c0                	test   %eax,%eax
  e7:	0f 84 45 01 00 00    	je     232 <main+0x192>
			break;
		} else { /* parent */
			pids_prio[pid] = i % MAX_PRIO;
  ed:	89 f8                	mov    %edi,%eax
  ef:	ba 67 66 66 66       	mov    $0x66666667,%edx
  f4:	f7 ea                	imul   %edx
  f6:	89 f8                	mov    %edi,%eax
  f8:	c1 f8 1f             	sar    $0x1f,%eax
  fb:	89 fe                	mov    %edi,%esi
			if (setpriority(pid, i % MAX_PRIO) < 0) {
  fd:	89 1c 24             	mov    %ebx,(%esp)
		if (pid == -1) {
			handle_error("fork failed\n");
		} else if (pid == 0) { /* child */
			break;
		} else { /* parent */
			pids_prio[pid] = i % MAX_PRIO;
 100:	d1 fa                	sar    %edx
 102:	29 c2                	sub    %eax,%edx
 104:	8d 14 92             	lea    (%edx,%edx,4),%edx
 107:	29 d6                	sub    %edx,%esi
			if (setpriority(pid, i % MAX_PRIO) < 0) {
 109:	89 74 24 04          	mov    %esi,0x4(%esp)
 10d:	e8 56 04 00 00       	call   568 <setpriority>
 112:	85 c0                	test   %eax,%eax
 114:	0f 88 44 01 00 00    	js     25e <main+0x1be>
	 * Two will be in the second queue
	 * One will be in the 3rd queue
	 * One will be in the 4th queue
	 * One will be in the 5th queue
	 */
	for (i = 0; i < NUM_CHILD; i++) {
 11a:	83 c7 01             	add    $0x1,%edi
 11d:	83 ff 07             	cmp    $0x7,%edi
		if (pid == -1) {
			handle_error("fork failed\n");
		} else if (pid == 0) { /* child */
			break;
		} else { /* parent */
			pids_prio[pid] = i % MAX_PRIO;
 120:	89 b4 9d b0 fe ff ff 	mov    %esi,-0x150(%ebp,%ebx,4)
	 * Two will be in the second queue
	 * One will be in the 3rd queue
	 * One will be in the 4th queue
	 * One will be in the 5th queue
	 */
	for (i = 0; i < NUM_CHILD; i++) {
 127:	75 ac                	jne    d5 <main+0x35>
		exit();
	}

	/* parent goes here */
	for (i = 0; i < NUM_CHILD; i++) {
		pids[i] = wait();  
 129:	e8 92 03 00 00       	call   4c0 <wait>
 12e:	bb 02 00 00 00       	mov    $0x2,%ebx
 133:	8d 75 d4             	lea    -0x2c(%ebp),%esi
 136:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 139:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 140:	e8 7b 03 00 00       	call   4c0 <wait>
 145:	89 44 9e fc          	mov    %eax,-0x4(%esi,%ebx,4)
 149:	83 c3 01             	add    $0x1,%ebx
		lengthy(value, N, 0);
		exit();
	}

	/* parent goes here */
	for (i = 0; i < NUM_CHILD; i++) {
 14c:	83 fb 08             	cmp    $0x8,%ebx
 14f:	75 ef                	jne    140 <main+0xa0>
		pids[i] = wait();  
		/* pids[] records the order of finished children */
	}
	for (i = 0; i < NUM_CHILD; i++) {
		printf(stdout, "child %d exits: prio: %d\n", 
 151:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 154:	b3 02                	mov    $0x2,%bl
 156:	c7 44 24 04 19 09 00 	movl   $0x919,0x4(%esp)
 15d:	00 
 15e:	8b 94 85 b0 fe ff ff 	mov    -0x150(%ebp,%eax,4),%edx
 165:	89 44 24 08          	mov    %eax,0x8(%esp)
 169:	a1 0c 0a 00 00       	mov    0xa0c,%eax
 16e:	89 54 24 0c          	mov    %edx,0xc(%esp)
 172:	89 04 24             	mov    %eax,(%esp)
 175:	e8 b6 04 00 00       	call   630 <printf>
 17a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 180:	8b 44 9e fc          	mov    -0x4(%esi,%ebx,4),%eax
 184:	83 c3 01             	add    $0x1,%ebx
 187:	c7 44 24 04 19 09 00 	movl   $0x919,0x4(%esp)
 18e:	00 
 18f:	8b 94 85 b0 fe ff ff 	mov    -0x150(%ebp,%eax,4),%edx
 196:	89 44 24 08          	mov    %eax,0x8(%esp)
 19a:	a1 0c 0a 00 00       	mov    0xa0c,%eax
 19f:	89 54 24 0c          	mov    %edx,0xc(%esp)
 1a3:	89 04 24             	mov    %eax,(%esp)
 1a6:	e8 85 04 00 00       	call   630 <printf>
	/* parent goes here */
	for (i = 0; i < NUM_CHILD; i++) {
		pids[i] = wait();  
		/* pids[] records the order of finished children */
	}
	for (i = 0; i < NUM_CHILD; i++) {
 1ab:	83 fb 08             	cmp    $0x8,%ebx
 1ae:	75 d0                	jne    180 <main+0xe0>
		printf(stdout, "child %d exits: prio: %d\n", 
		       pids[i], pids_prio[pids[i]]);
	}

	if (pids_prio[pids[NUM_CHILD-1]] != MAX_PRIO - 1)
 1b0:	8b 45 ec             	mov    -0x14(%ebp),%eax
 1b3:	83 bc 85 b0 fe ff ff 	cmpl   $0x4,-0x150(%ebp,%eax,4)
 1ba:	04 
 1bb:	0f 85 e0 00 00 00    	jne    2a1 <main+0x201>
		handle_error("Scheduling error: the process in the last queue does not exit last.");
	
	for (i = 0; i+2 < NUM_CHILD; i+=2) {
		if (pids_prio[pids[i]] >= pids_prio[pids[i+2]]) {
 1c1:	8b 45 dc             	mov    -0x24(%ebp),%eax
 1c4:	8b 94 85 b0 fe ff ff 	mov    -0x150(%ebp,%eax,4),%edx
 1cb:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 1ce:	39 94 85 b0 fe ff ff 	cmp    %edx,-0x150(%ebp,%eax,4)
 1d5:	0f 8d b9 00 00 00    	jge    294 <main+0x1f4>
 1db:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 1de:	8b 84 85 b0 fe ff ff 	mov    -0x150(%ebp,%eax,4),%eax
 1e5:	39 c2                	cmp    %eax,%edx
 1e7:	0f 8d a7 00 00 00    	jge    294 <main+0x1f4>
 1ed:	83 f8 03             	cmp    $0x3,%eax
 1f0:	0f 8f 9e 00 00 00    	jg     294 <main+0x1f4>
			handle_error("Scheduling error: the expected exit time of children is wrong.");
		}
	}
	

	printf(stdout, "hw4-test-sim succeeded\n");
 1f6:	a1 0c 0a 00 00       	mov    0xa0c,%eax
 1fb:	c7 44 24 04 33 09 00 	movl   $0x933,0x4(%esp)
 202:	00 
 203:	89 04 24             	mov    %eax,(%esp)
 206:	e8 25 04 00 00       	call   630 <printf>

	exit();
 20b:	e8 a8 02 00 00       	call   4b8 <exit>
int stdout = 1;
int stderr = 2;
inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 210:	c7 44 24 08 0c 09 00 	movl   $0x90c,0x8(%esp)
 217:	00 
  exit();
 218:	a1 10 0a 00 00       	mov    0xa10,%eax
 21d:	c7 44 24 04 08 09 00 	movl   $0x908,0x4(%esp)
 224:	00 
 225:	89 04 24             	mov    %eax,(%esp)
 228:	e8 03 04 00 00       	call   630 <printf>
 22d:	e8 86 02 00 00       	call   4b8 <exit>
				exit();
			}
		}
	}
	if (!pid) { /* children go here */
		sleep(1);
 232:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 239:	e8 0a 03 00 00       	call   548 <sleep>
		lengthy(value, N, 0);
 23e:	8d 45 b0             	lea    -0x50(%ebp),%eax
 241:	89 04 24             	mov    %eax,(%esp)
 244:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
 24b:	00 
 24c:	c7 44 24 04 09 00 00 	movl   $0x9,0x4(%esp)
 253:	00 
 254:	e8 a7 fd ff ff       	call   0 <lengthy>
		exit();
 259:	e8 5a 02 00 00       	call   4b8 <exit>
		} else if (pid == 0) { /* child */
			break;
		} else { /* parent */
			pids_prio[pid] = i % MAX_PRIO;
			if (setpriority(pid, i % MAX_PRIO) < 0) {
				printf(stdout, 
 25e:	e8 d5 02 00 00       	call   538 <getpid>
 263:	89 04 24             	mov    %eax,(%esp)
 266:	e8 f5 02 00 00       	call   560 <getpriority>
 26b:	89 c3                	mov    %eax,%ebx
 26d:	e8 c6 02 00 00       	call   538 <getpid>
 272:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
 276:	c7 44 24 04 4c 09 00 	movl   $0x94c,0x4(%esp)
 27d:	00 
 27e:	89 44 24 08          	mov    %eax,0x8(%esp)
 282:	a1 0c 0a 00 00       	mov    0xa0c,%eax
 287:	89 04 24             	mov    %eax,(%esp)
 28a:	e8 a1 03 00 00       	call   630 <printf>
				       "%d setpriority failed, prio: %d\n", 
				       getpid(), getpriority(getpid()));
				exit();
 28f:	e8 24 02 00 00       	call   4b8 <exit>
int stdout = 1;
int stderr = 2;
inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 294:	c7 44 24 08 b4 09 00 	movl   $0x9b4,0x8(%esp)
 29b:	00 
 29c:	e9 77 ff ff ff       	jmp    218 <main+0x178>
 2a1:	c7 44 24 08 70 09 00 	movl   $0x970,0x8(%esp)
 2a8:	00 
 2a9:	e9 6a ff ff ff       	jmp    218 <main+0x178>
 2ae:	90                   	nop    
 2af:	90                   	nop    

000002b0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	53                   	push   %ebx
 2b4:	8b 5d 08             	mov    0x8(%ebp),%ebx
 2b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 2ba:	89 da                	mov    %ebx,%edx
 2bc:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2c0:	0f b6 01             	movzbl (%ecx),%eax
 2c3:	83 c1 01             	add    $0x1,%ecx
 2c6:	88 02                	mov    %al,(%edx)
 2c8:	83 c2 01             	add    $0x1,%edx
 2cb:	84 c0                	test   %al,%al
 2cd:	75 f1                	jne    2c0 <strcpy+0x10>
    ;
  return os;
}
 2cf:	89 d8                	mov    %ebx,%eax
 2d1:	5b                   	pop    %ebx
 2d2:	5d                   	pop    %ebp
 2d3:	c3                   	ret    
 2d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000002e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2e6:	53                   	push   %ebx
 2e7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 2ea:	0f b6 01             	movzbl (%ecx),%eax
 2ed:	84 c0                	test   %al,%al
 2ef:	74 24                	je     315 <strcmp+0x35>
 2f1:	0f b6 13             	movzbl (%ebx),%edx
 2f4:	38 d0                	cmp    %dl,%al
 2f6:	74 12                	je     30a <strcmp+0x2a>
 2f8:	eb 1e                	jmp    318 <strcmp+0x38>
 2fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 300:	0f b6 13             	movzbl (%ebx),%edx
 303:	83 c1 01             	add    $0x1,%ecx
 306:	38 d0                	cmp    %dl,%al
 308:	75 0e                	jne    318 <strcmp+0x38>
 30a:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 30e:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 311:	84 c0                	test   %al,%al
 313:	75 eb                	jne    300 <strcmp+0x20>
 315:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 318:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 319:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 31c:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 31d:	0f b6 d2             	movzbl %dl,%edx
 320:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 322:	c3                   	ret    
 323:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 329:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000330 <strlen>:

uint
strlen(char *s)
{
 330:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 331:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 333:	89 e5                	mov    %esp,%ebp
 335:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 338:	80 39 00             	cmpb   $0x0,(%ecx)
 33b:	74 0e                	je     34b <strlen+0x1b>
 33d:	31 d2                	xor    %edx,%edx
 33f:	90                   	nop    
 340:	83 c2 01             	add    $0x1,%edx
 343:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
 347:	89 d0                	mov    %edx,%eax
 349:	75 f5                	jne    340 <strlen+0x10>
    ;
  return n;
}
 34b:	5d                   	pop    %ebp
 34c:	c3                   	ret    
 34d:	8d 76 00             	lea    0x0(%esi),%esi

00000350 <memset>:

void*
memset(void *dst, int c, uint n)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	8b 55 08             	mov    0x8(%ebp),%edx
 356:	57                   	push   %edi
 357:	8b 45 0c             	mov    0xc(%ebp),%eax
 35a:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 35d:	89 d7                	mov    %edx,%edi
 35f:	fc                   	cld    
 360:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 362:	5f                   	pop    %edi
 363:	89 d0                	mov    %edx,%eax
 365:	5d                   	pop    %ebp
 366:	c3                   	ret    
 367:	89 f6                	mov    %esi,%esi
 369:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000370 <strchr>:

char*
strchr(const char *s, char c)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	8b 45 08             	mov    0x8(%ebp),%eax
 376:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 37a:	0f b6 10             	movzbl (%eax),%edx
 37d:	84 d2                	test   %dl,%dl
 37f:	75 0c                	jne    38d <strchr+0x1d>
 381:	eb 11                	jmp    394 <strchr+0x24>
 383:	83 c0 01             	add    $0x1,%eax
 386:	0f b6 10             	movzbl (%eax),%edx
 389:	84 d2                	test   %dl,%dl
 38b:	74 07                	je     394 <strchr+0x24>
    if(*s == c)
 38d:	38 ca                	cmp    %cl,%dl
 38f:	90                   	nop    
 390:	75 f1                	jne    383 <strchr+0x13>
      return (char*) s;
  return 0;
}
 392:	5d                   	pop    %ebp
 393:	c3                   	ret    
 394:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 395:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 397:	c3                   	ret    
 398:	90                   	nop    
 399:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000003a0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3a6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3a7:	31 db                	xor    %ebx,%ebx
 3a9:	0f b6 11             	movzbl (%ecx),%edx
 3ac:	8d 42 d0             	lea    -0x30(%edx),%eax
 3af:	3c 09                	cmp    $0x9,%al
 3b1:	77 18                	ja     3cb <atoi+0x2b>
    n = n*10 + *s++ - '0';
 3b3:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 3b6:	0f be d2             	movsbl %dl,%edx
 3b9:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3bd:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 3c1:	83 c1 01             	add    $0x1,%ecx
 3c4:	8d 42 d0             	lea    -0x30(%edx),%eax
 3c7:	3c 09                	cmp    $0x9,%al
 3c9:	76 e8                	jbe    3b3 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 3cb:	89 d8                	mov    %ebx,%eax
 3cd:	5b                   	pop    %ebx
 3ce:	5d                   	pop    %ebp
 3cf:	c3                   	ret    

000003d0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3d6:	56                   	push   %esi
 3d7:	8b 75 08             	mov    0x8(%ebp),%esi
 3da:	53                   	push   %ebx
 3db:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3de:	85 c9                	test   %ecx,%ecx
 3e0:	7e 10                	jle    3f2 <memmove+0x22>
 3e2:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 3e4:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 3e8:	88 04 32             	mov    %al,(%edx,%esi,1)
 3eb:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3ee:	39 ca                	cmp    %ecx,%edx
 3f0:	75 f2                	jne    3e4 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 3f2:	89 f0                	mov    %esi,%eax
 3f4:	5b                   	pop    %ebx
 3f5:	5e                   	pop    %esi
 3f6:	5d                   	pop    %ebp
 3f7:	c3                   	ret    
 3f8:	90                   	nop    
 3f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000400 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 406:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 409:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 40c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 40f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 414:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 41b:	00 
 41c:	89 04 24             	mov    %eax,(%esp)
 41f:	e8 d4 00 00 00       	call   4f8 <open>
  if(fd < 0)
 424:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 426:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 428:	78 19                	js     443 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 42a:	8b 45 0c             	mov    0xc(%ebp),%eax
 42d:	89 1c 24             	mov    %ebx,(%esp)
 430:	89 44 24 04          	mov    %eax,0x4(%esp)
 434:	e8 d7 00 00 00       	call   510 <fstat>
  close(fd);
 439:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 43c:	89 c6                	mov    %eax,%esi
  close(fd);
 43e:	e8 9d 00 00 00       	call   4e0 <close>
  return r;
}
 443:	89 f0                	mov    %esi,%eax
 445:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 448:	8b 75 fc             	mov    -0x4(%ebp),%esi
 44b:	89 ec                	mov    %ebp,%esp
 44d:	5d                   	pop    %ebp
 44e:	c3                   	ret    
 44f:	90                   	nop    

00000450 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	57                   	push   %edi
 454:	56                   	push   %esi
 455:	31 f6                	xor    %esi,%esi
 457:	53                   	push   %ebx
 458:	83 ec 1c             	sub    $0x1c,%esp
 45b:	8b 7d 08             	mov    0x8(%ebp),%edi
 45e:	eb 06                	jmp    466 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 460:	3c 0d                	cmp    $0xd,%al
 462:	74 39                	je     49d <gets+0x4d>
 464:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 466:	8d 5e 01             	lea    0x1(%esi),%ebx
 469:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 46c:	7d 31                	jge    49f <gets+0x4f>
    cc = read(0, &c, 1);
 46e:	8d 45 f3             	lea    -0xd(%ebp),%eax
 471:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 478:	00 
 479:	89 44 24 04          	mov    %eax,0x4(%esp)
 47d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 484:	e8 47 00 00 00       	call   4d0 <read>
    if(cc < 1)
 489:	85 c0                	test   %eax,%eax
 48b:	7e 12                	jle    49f <gets+0x4f>
      break;
    buf[i++] = c;
 48d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 491:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 495:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 499:	3c 0a                	cmp    $0xa,%al
 49b:	75 c3                	jne    460 <gets+0x10>
 49d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 49f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 4a3:	89 f8                	mov    %edi,%eax
 4a5:	83 c4 1c             	add    $0x1c,%esp
 4a8:	5b                   	pop    %ebx
 4a9:	5e                   	pop    %esi
 4aa:	5f                   	pop    %edi
 4ab:	5d                   	pop    %ebp
 4ac:	c3                   	ret    
 4ad:	90                   	nop    
 4ae:	90                   	nop    
 4af:	90                   	nop    

000004b0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4b0:	b8 01 00 00 00       	mov    $0x1,%eax
 4b5:	cd 40                	int    $0x40
 4b7:	c3                   	ret    

000004b8 <exit>:
SYSCALL(exit)
 4b8:	b8 02 00 00 00       	mov    $0x2,%eax
 4bd:	cd 40                	int    $0x40
 4bf:	c3                   	ret    

000004c0 <wait>:
SYSCALL(wait)
 4c0:	b8 03 00 00 00       	mov    $0x3,%eax
 4c5:	cd 40                	int    $0x40
 4c7:	c3                   	ret    

000004c8 <pipe>:
SYSCALL(pipe)
 4c8:	b8 04 00 00 00       	mov    $0x4,%eax
 4cd:	cd 40                	int    $0x40
 4cf:	c3                   	ret    

000004d0 <read>:
SYSCALL(read)
 4d0:	b8 06 00 00 00       	mov    $0x6,%eax
 4d5:	cd 40                	int    $0x40
 4d7:	c3                   	ret    

000004d8 <write>:
SYSCALL(write)
 4d8:	b8 05 00 00 00       	mov    $0x5,%eax
 4dd:	cd 40                	int    $0x40
 4df:	c3                   	ret    

000004e0 <close>:
SYSCALL(close)
 4e0:	b8 07 00 00 00       	mov    $0x7,%eax
 4e5:	cd 40                	int    $0x40
 4e7:	c3                   	ret    

000004e8 <kill>:
SYSCALL(kill)
 4e8:	b8 08 00 00 00       	mov    $0x8,%eax
 4ed:	cd 40                	int    $0x40
 4ef:	c3                   	ret    

000004f0 <exec>:
SYSCALL(exec)
 4f0:	b8 09 00 00 00       	mov    $0x9,%eax
 4f5:	cd 40                	int    $0x40
 4f7:	c3                   	ret    

000004f8 <open>:
SYSCALL(open)
 4f8:	b8 0a 00 00 00       	mov    $0xa,%eax
 4fd:	cd 40                	int    $0x40
 4ff:	c3                   	ret    

00000500 <mknod>:
SYSCALL(mknod)
 500:	b8 0b 00 00 00       	mov    $0xb,%eax
 505:	cd 40                	int    $0x40
 507:	c3                   	ret    

00000508 <unlink>:
SYSCALL(unlink)
 508:	b8 0c 00 00 00       	mov    $0xc,%eax
 50d:	cd 40                	int    $0x40
 50f:	c3                   	ret    

00000510 <fstat>:
SYSCALL(fstat)
 510:	b8 0d 00 00 00       	mov    $0xd,%eax
 515:	cd 40                	int    $0x40
 517:	c3                   	ret    

00000518 <link>:
SYSCALL(link)
 518:	b8 0e 00 00 00       	mov    $0xe,%eax
 51d:	cd 40                	int    $0x40
 51f:	c3                   	ret    

00000520 <mkdir>:
SYSCALL(mkdir)
 520:	b8 0f 00 00 00       	mov    $0xf,%eax
 525:	cd 40                	int    $0x40
 527:	c3                   	ret    

00000528 <chdir>:
SYSCALL(chdir)
 528:	b8 10 00 00 00       	mov    $0x10,%eax
 52d:	cd 40                	int    $0x40
 52f:	c3                   	ret    

00000530 <dup>:
SYSCALL(dup)
 530:	b8 11 00 00 00       	mov    $0x11,%eax
 535:	cd 40                	int    $0x40
 537:	c3                   	ret    

00000538 <getpid>:
SYSCALL(getpid)
 538:	b8 12 00 00 00       	mov    $0x12,%eax
 53d:	cd 40                	int    $0x40
 53f:	c3                   	ret    

00000540 <sbrk>:
SYSCALL(sbrk)
 540:	b8 13 00 00 00       	mov    $0x13,%eax
 545:	cd 40                	int    $0x40
 547:	c3                   	ret    

00000548 <sleep>:
SYSCALL(sleep)
 548:	b8 14 00 00 00       	mov    $0x14,%eax
 54d:	cd 40                	int    $0x40
 54f:	c3                   	ret    

00000550 <uptime>:
SYSCALL(uptime)
 550:	b8 15 00 00 00       	mov    $0x15,%eax
 555:	cd 40                	int    $0x40
 557:	c3                   	ret    

00000558 <nice>:
SYSCALL(nice)
 558:	b8 16 00 00 00       	mov    $0x16,%eax
 55d:	cd 40                	int    $0x40
 55f:	c3                   	ret    

00000560 <getpriority>:
SYSCALL(getpriority)
 560:	b8 17 00 00 00       	mov    $0x17,%eax
 565:	cd 40                	int    $0x40
 567:	c3                   	ret    

00000568 <setpriority>:
SYSCALL(setpriority)
 568:	b8 18 00 00 00       	mov    $0x18,%eax
 56d:	cd 40                	int    $0x40
 56f:	c3                   	ret    

00000570 <getaffinity>:
SYSCALL(getaffinity)
 570:	b8 19 00 00 00       	mov    $0x19,%eax
 575:	cd 40                	int    $0x40
 577:	c3                   	ret    

00000578 <setaffinity>:
SYSCALL(setaffinity)
 578:	b8 1a 00 00 00       	mov    $0x1a,%eax
 57d:	cd 40                	int    $0x40
 57f:	c3                   	ret    

00000580 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	83 ec 18             	sub    $0x18,%esp
 586:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 589:	8d 55 fc             	lea    -0x4(%ebp),%edx
 58c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 593:	00 
 594:	89 54 24 04          	mov    %edx,0x4(%esp)
 598:	89 04 24             	mov    %eax,(%esp)
 59b:	e8 38 ff ff ff       	call   4d8 <write>
}
 5a0:	c9                   	leave  
 5a1:	c3                   	ret    
 5a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 5a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000005b0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	57                   	push   %edi
 5b4:	56                   	push   %esi
 5b5:	89 ce                	mov    %ecx,%esi
 5b7:	53                   	push   %ebx
 5b8:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5bb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 5be:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5c1:	85 c9                	test   %ecx,%ecx
 5c3:	74 04                	je     5c9 <printint+0x19>
 5c5:	85 d2                	test   %edx,%edx
 5c7:	78 54                	js     61d <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5c9:	89 d0                	mov    %edx,%eax
 5cb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 5d2:	31 db                	xor    %ebx,%ebx
 5d4:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 5d7:	31 d2                	xor    %edx,%edx
 5d9:	f7 f6                	div    %esi
 5db:	89 c1                	mov    %eax,%ecx
 5dd:	0f b6 82 fb 09 00 00 	movzbl 0x9fb(%edx),%eax
 5e4:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 5e7:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 5ea:	85 c9                	test   %ecx,%ecx
 5ec:	89 c8                	mov    %ecx,%eax
 5ee:	75 e7                	jne    5d7 <printint+0x27>
  if(neg)
 5f0:	8b 45 e0             	mov    -0x20(%ebp),%eax
 5f3:	85 c0                	test   %eax,%eax
 5f5:	74 08                	je     5ff <printint+0x4f>
    buf[i++] = '-';
 5f7:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 5fc:	83 c3 01             	add    $0x1,%ebx
 5ff:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 602:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 606:	83 eb 01             	sub    $0x1,%ebx
 609:	8b 45 dc             	mov    -0x24(%ebp),%eax
 60c:	e8 6f ff ff ff       	call   580 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 611:	39 fb                	cmp    %edi,%ebx
 613:	75 ed                	jne    602 <printint+0x52>
    putc(fd, buf[i]);
}
 615:	83 c4 1c             	add    $0x1c,%esp
 618:	5b                   	pop    %ebx
 619:	5e                   	pop    %esi
 61a:	5f                   	pop    %edi
 61b:	5d                   	pop    %ebp
 61c:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 61d:	89 d0                	mov    %edx,%eax
 61f:	f7 d8                	neg    %eax
 621:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 628:	eb a8                	jmp    5d2 <printint+0x22>
 62a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000630 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	57                   	push   %edi
 634:	56                   	push   %esi
 635:	53                   	push   %ebx
 636:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 639:	8b 55 0c             	mov    0xc(%ebp),%edx
 63c:	0f b6 02             	movzbl (%edx),%eax
 63f:	84 c0                	test   %al,%al
 641:	0f 84 87 00 00 00    	je     6ce <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 647:	8d 4d 10             	lea    0x10(%ebp),%ecx
 64a:	31 ff                	xor    %edi,%edi
 64c:	31 f6                	xor    %esi,%esi
 64e:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 651:	eb 18                	jmp    66b <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 653:	83 fb 25             	cmp    $0x25,%ebx
 656:	0f 85 7a 00 00 00    	jne    6d6 <printf+0xa6>
 65c:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 660:	83 c7 01             	add    $0x1,%edi
 663:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 667:	84 c0                	test   %al,%al
 669:	74 63                	je     6ce <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 66b:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 66d:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 670:	74 e1                	je     653 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 672:	83 fe 25             	cmp    $0x25,%esi
 675:	75 e9                	jne    660 <printf+0x30>
      if(c == 'd'){
 677:	83 fb 64             	cmp    $0x64,%ebx
 67a:	0f 84 f0 00 00 00    	je     770 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 680:	83 fb 78             	cmp    $0x78,%ebx
 683:	74 64                	je     6e9 <printf+0xb9>
 685:	83 fb 70             	cmp    $0x70,%ebx
 688:	74 5f                	je     6e9 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 68a:	83 fb 73             	cmp    $0x73,%ebx
 68d:	8d 76 00             	lea    0x0(%esi),%esi
 690:	74 7e                	je     710 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 692:	83 fb 63             	cmp    $0x63,%ebx
 695:	0f 84 b9 00 00 00    	je     754 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 69b:	83 fb 25             	cmp    $0x25,%ebx
 69e:	66 90                	xchg   %ax,%ax
 6a0:	0f 84 f2 00 00 00    	je     798 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6a6:	8b 45 08             	mov    0x8(%ebp),%eax
 6a9:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6ae:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 6b1:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6b3:	e8 c8 fe ff ff       	call   580 <putc>
        putc(fd, c);
 6b8:	8b 45 08             	mov    0x8(%ebp),%eax
 6bb:	0f be d3             	movsbl %bl,%edx
 6be:	e8 bd fe ff ff       	call   580 <putc>
 6c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6c6:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 6ca:	84 c0                	test   %al,%al
 6cc:	75 9d                	jne    66b <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6ce:	83 c4 0c             	add    $0xc,%esp
 6d1:	5b                   	pop    %ebx
 6d2:	5e                   	pop    %esi
 6d3:	5f                   	pop    %edi
 6d4:	5d                   	pop    %ebp
 6d5:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 6d6:	8b 45 08             	mov    0x8(%ebp),%eax
 6d9:	0f be d3             	movsbl %bl,%edx
 6dc:	e8 9f fe ff ff       	call   580 <putc>
 6e1:	8b 55 0c             	mov    0xc(%ebp),%edx
 6e4:	e9 77 ff ff ff       	jmp    660 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 6e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6ec:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 6f1:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 6f3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 6fa:	8b 10                	mov    (%eax),%edx
 6fc:	8b 45 08             	mov    0x8(%ebp),%eax
 6ff:	e8 ac fe ff ff       	call   5b0 <printint>
 704:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 707:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 70b:	e9 50 ff ff ff       	jmp    660 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 710:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 713:	8b 01                	mov    (%ecx),%eax
        ap++;
 715:	83 c1 04             	add    $0x4,%ecx
 718:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 71b:	b9 f4 09 00 00       	mov    $0x9f4,%ecx
 720:	85 c0                	test   %eax,%eax
 722:	75 2c                	jne    750 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 724:	0f b6 01             	movzbl (%ecx),%eax
 727:	84 c0                	test   %al,%al
 729:	74 1e                	je     749 <printf+0x119>
 72b:	89 cb                	mov    %ecx,%ebx
 72d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 730:	0f be d0             	movsbl %al,%edx
 733:	8b 45 08             	mov    0x8(%ebp),%eax
 736:	e8 45 fe ff ff       	call   580 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 73b:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 73f:	83 c3 01             	add    $0x1,%ebx
 742:	84 c0                	test   %al,%al
 744:	75 ea                	jne    730 <printf+0x100>
 746:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 749:	31 f6                	xor    %esi,%esi
 74b:	e9 10 ff ff ff       	jmp    660 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 750:	89 c1                	mov    %eax,%ecx
 752:	eb d0                	jmp    724 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 754:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 757:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 759:	0f be 10             	movsbl (%eax),%edx
 75c:	8b 45 08             	mov    0x8(%ebp),%eax
 75f:	e8 1c fe ff ff       	call   580 <putc>
 764:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 767:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 76b:	e9 f0 fe ff ff       	jmp    660 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 770:	8b 45 f0             	mov    -0x10(%ebp),%eax
 773:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 778:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 77b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 782:	8b 10                	mov    (%eax),%edx
 784:	8b 45 08             	mov    0x8(%ebp),%eax
 787:	e8 24 fe ff ff       	call   5b0 <printint>
 78c:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 78f:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 793:	e9 c8 fe ff ff       	jmp    660 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 798:	8b 45 08             	mov    0x8(%ebp),%eax
 79b:	ba 25 00 00 00       	mov    $0x25,%edx
 7a0:	31 f6                	xor    %esi,%esi
 7a2:	e8 d9 fd ff ff       	call   580 <putc>
 7a7:	8b 55 0c             	mov    0xc(%ebp),%edx
 7aa:	e9 b1 fe ff ff       	jmp    660 <printf+0x30>
 7af:	90                   	nop    

000007b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b1:	8b 0d 20 0a 00 00    	mov    0xa20,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 7b7:	89 e5                	mov    %esp,%ebp
 7b9:	56                   	push   %esi
 7ba:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 7bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 7be:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c1:	39 d9                	cmp    %ebx,%ecx
 7c3:	73 18                	jae    7dd <free+0x2d>
 7c5:	8b 11                	mov    (%ecx),%edx
 7c7:	39 d3                	cmp    %edx,%ebx
 7c9:	72 17                	jb     7e2 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7cb:	39 d1                	cmp    %edx,%ecx
 7cd:	72 08                	jb     7d7 <free+0x27>
 7cf:	39 d9                	cmp    %ebx,%ecx
 7d1:	72 0f                	jb     7e2 <free+0x32>
 7d3:	39 d3                	cmp    %edx,%ebx
 7d5:	72 0b                	jb     7e2 <free+0x32>
 7d7:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d9:	39 d9                	cmp    %ebx,%ecx
 7db:	72 e8                	jb     7c5 <free+0x15>
 7dd:	8b 11                	mov    (%ecx),%edx
 7df:	90                   	nop    
 7e0:	eb e9                	jmp    7cb <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7e2:	8b 73 04             	mov    0x4(%ebx),%esi
 7e5:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 7e8:	39 d0                	cmp    %edx,%eax
 7ea:	74 18                	je     804 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7ec:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 7ee:	8b 51 04             	mov    0x4(%ecx),%edx
 7f1:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 7f4:	39 d8                	cmp    %ebx,%eax
 7f6:	74 20                	je     818 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7f8:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 7fa:	5b                   	pop    %ebx
 7fb:	5e                   	pop    %esi
 7fc:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 7fd:	89 0d 20 0a 00 00    	mov    %ecx,0xa20
}
 803:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 804:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 807:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 809:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 80c:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 80f:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 811:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 814:	39 d8                	cmp    %ebx,%eax
 816:	75 e0                	jne    7f8 <free+0x48>
    p->s.size += bp->s.size;
 818:	03 53 04             	add    0x4(%ebx),%edx
 81b:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 81e:	8b 13                	mov    (%ebx),%edx
 820:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 822:	5b                   	pop    %ebx
 823:	5e                   	pop    %esi
 824:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 825:	89 0d 20 0a 00 00    	mov    %ecx,0xa20
}
 82b:	c3                   	ret    
 82c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000830 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 830:	55                   	push   %ebp
 831:	89 e5                	mov    %esp,%ebp
 833:	57                   	push   %edi
 834:	56                   	push   %esi
 835:	53                   	push   %ebx
 836:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 839:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 83c:	8b 15 20 0a 00 00    	mov    0xa20,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 842:	83 c0 07             	add    $0x7,%eax
 845:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 848:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 84a:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 84d:	0f 84 8a 00 00 00    	je     8dd <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 853:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 855:	8b 41 04             	mov    0x4(%ecx),%eax
 858:	39 c3                	cmp    %eax,%ebx
 85a:	76 1a                	jbe    876 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 85c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 863:	3b 0d 20 0a 00 00    	cmp    0xa20,%ecx
 869:	89 ca                	mov    %ecx,%edx
 86b:	74 29                	je     896 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 86d:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 86f:	8b 41 04             	mov    0x4(%ecx),%eax
 872:	39 c3                	cmp    %eax,%ebx
 874:	77 ed                	ja     863 <malloc+0x33>
      if(p->s.size == nunits)
 876:	39 c3                	cmp    %eax,%ebx
 878:	74 5d                	je     8d7 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 87a:	29 d8                	sub    %ebx,%eax
 87c:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 87f:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 882:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 885:	89 15 20 0a 00 00    	mov    %edx,0xa20
      return (void*) (p + 1);
 88b:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 88e:	83 c4 0c             	add    $0xc,%esp
 891:	5b                   	pop    %ebx
 892:	5e                   	pop    %esi
 893:	5f                   	pop    %edi
 894:	5d                   	pop    %ebp
 895:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 896:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 89c:	89 de                	mov    %ebx,%esi
 89e:	89 f8                	mov    %edi,%eax
 8a0:	76 29                	jbe    8cb <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 8a2:	89 04 24             	mov    %eax,(%esp)
 8a5:	e8 96 fc ff ff       	call   540 <sbrk>
  if(p == (char*) -1)
 8aa:	83 f8 ff             	cmp    $0xffffffff,%eax
 8ad:	74 18                	je     8c7 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 8af:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 8b2:	83 c0 08             	add    $0x8,%eax
 8b5:	89 04 24             	mov    %eax,(%esp)
 8b8:	e8 f3 fe ff ff       	call   7b0 <free>
  return freep;
 8bd:	8b 15 20 0a 00 00    	mov    0xa20,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 8c3:	85 d2                	test   %edx,%edx
 8c5:	75 a6                	jne    86d <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 8c7:	31 c0                	xor    %eax,%eax
 8c9:	eb c3                	jmp    88e <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 8cb:	be 00 10 00 00       	mov    $0x1000,%esi
 8d0:	b8 00 80 00 00       	mov    $0x8000,%eax
 8d5:	eb cb                	jmp    8a2 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 8d7:	8b 01                	mov    (%ecx),%eax
 8d9:	89 02                	mov    %eax,(%edx)
 8db:	eb a8                	jmp    885 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 8dd:	ba 18 0a 00 00       	mov    $0xa18,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 8e2:	c7 05 20 0a 00 00 18 	movl   $0xa18,0xa20
 8e9:	0a 00 00 
 8ec:	c7 05 18 0a 00 00 18 	movl   $0xa18,0xa18
 8f3:	0a 00 00 
    base.s.size = 0;
 8f6:	c7 05 1c 0a 00 00 00 	movl   $0x0,0xa1c
 8fd:	00 00 00 
 900:	e9 4e ff ff ff       	jmp    853 <malloc+0x23>
