
_hw4-test-str:     file format elf32-i386

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
   9:	8b 15 94 09 00 00    	mov    0x994,%edx
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
  1b:	89 15 94 09 00 00    	mov    %edx,0x994
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
  59:	83 2d 94 09 00 00 01 	subl   $0x1,0x994
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
  79:	c7 44 24 04 c8 08 00 	movl   $0x8c8,0x4(%esp)
  80:	00 
  81:	89 44 24 08          	mov    %eax,0x8(%esp)
  85:	a1 90 09 00 00       	mov    0x990,%eax
  8a:	89 04 24             	mov    %eax,(%esp)
  8d:	e8 5e 05 00 00       	call   5f0 <printf>
  exit();
  92:	e8 e1 03 00 00       	call   478 <exit>
  97:	89 f6                	mov    %esi,%esi
  99:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000000a0 <main>:
#define NUM_CHILD 21
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
#define NUM_CHILD 21
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
  b6:	81 ec 98 01 00 00    	sub    $0x198,%esp
	int pid=1;
	int value[N];
	int pids[NUM_CHILD];
	int pids_prio[NPROC];
	for (i = 0; i < N; i++) {
		value[i] = 0;
  bc:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  c3:	c7 44 85 cc 00 00 00 	movl   $0x0,-0x34(%ebp,%eax,4)
  ca:	00 
  cb:	83 c0 01             	add    $0x1,%eax
	int i;
	int pid=1;
	int value[N];
	int pids[NUM_CHILD];
	int pids_prio[NPROC];
	for (i = 0; i < N; i++) {
  ce:	83 f8 09             	cmp    $0x9,%eax
  d1:	75 f0                	jne    c3 <main+0x23>
  d3:	31 ff                	xor    %edi,%edi
	 * to the first four queues.
	 * One child will be in the last queue,
	 * and it is suppposed to exit last.
	 */
	for (i = 0; i < NUM_CHILD; i++) {
		pid = fork();
  d5:	e8 96 03 00 00       	call   470 <fork>
		if (pid == -1) {
  da:	83 f8 ff             	cmp    $0xffffffff,%eax
	 * to the first four queues.
	 * One child will be in the last queue,
	 * and it is suppposed to exit last.
	 */
	for (i = 0; i < NUM_CHILD; i++) {
		pid = fork();
  dd:	89 c6                	mov    %eax,%esi
		if (pid == -1) {
  df:	0f 84 fe 00 00 00    	je     1e3 <main+0x143>
			handle_error("fork failed\n");
		} else if (pid == 0) { /* child */
  e5:	85 c0                	test   %eax,%eax
  e7:	0f 84 00 01 00 00    	je     1ed <main+0x14d>
			break;
		} else { /* parent */
			pids_prio[pid] = (i!=(NUM_CHILD-1) ? i % (MAX_PRIO-1) : MAX_PRIO-1);
  ed:	83 ff 14             	cmp    $0x14,%edi
  f0:	bb 04 00 00 00       	mov    $0x4,%ebx
  f5:	74 10                	je     107 <main+0x67>
  f7:	89 f8                	mov    %edi,%eax
  f9:	c1 f8 1f             	sar    $0x1f,%eax
  fc:	c1 e8 1e             	shr    $0x1e,%eax
  ff:	8d 1c 07             	lea    (%edi,%eax,1),%ebx
 102:	83 e3 03             	and    $0x3,%ebx
 105:	29 c3                	sub    %eax,%ebx
			if (setpriority(pid, pids_prio[pid]) < 0) {
 107:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 10b:	89 34 24             	mov    %esi,(%esp)
 10e:	e8 15 04 00 00       	call   528 <setpriority>
 113:	85 c0                	test   %eax,%eax
 115:	0f 88 fe 00 00 00    	js     219 <main+0x179>
	/* All children will be distributed 
	 * to the first four queues.
	 * One child will be in the last queue,
	 * and it is suppposed to exit last.
	 */
	for (i = 0; i < NUM_CHILD; i++) {
 11b:	83 c7 01             	add    $0x1,%edi
 11e:	83 ff 15             	cmp    $0x15,%edi
		if (pid == -1) {
			handle_error("fork failed\n");
		} else if (pid == 0) { /* child */
			break;
		} else { /* parent */
			pids_prio[pid] = (i!=(NUM_CHILD-1) ? i % (MAX_PRIO-1) : MAX_PRIO-1);
 121:	89 9c b5 7c fe ff ff 	mov    %ebx,-0x184(%ebp,%esi,4)
	/* All children will be distributed 
	 * to the first four queues.
	 * One child will be in the last queue,
	 * and it is suppposed to exit last.
	 */
	for (i = 0; i < NUM_CHILD; i++) {
 128:	75 ab                	jne    d5 <main+0x35>
		exit();
	}

	/* parent goes here */
	for (i = 0; i < NUM_CHILD; i++) {
		pids[i] = wait();  
 12a:	e8 51 03 00 00       	call   480 <wait>
 12f:	bb 02 00 00 00       	mov    $0x2,%ebx
 134:	8d b5 7c ff ff ff    	lea    -0x84(%ebp),%esi
 13a:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
 140:	e8 3b 03 00 00       	call   480 <wait>
 145:	89 44 9e fc          	mov    %eax,-0x4(%esi,%ebx,4)
 149:	83 c3 01             	add    $0x1,%ebx
		lengthy(value, N, 0);
		exit();
	}

	/* parent goes here */
	for (i = 0; i < NUM_CHILD; i++) {
 14c:	83 fb 16             	cmp    $0x16,%ebx
 14f:	75 ef                	jne    140 <main+0xa0>
		pids[i] = wait();  
		/* pids[] records the order of finished children */
	}
	for (i = 0; i < NUM_CHILD; i++) {
		printf(stdout, "child %d exits: prio: %d\n", 
 151:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
 157:	b3 02                	mov    $0x2,%bl
 159:	c7 44 24 04 d9 08 00 	movl   $0x8d9,0x4(%esp)
 160:	00 
 161:	8b 94 85 7c fe ff ff 	mov    -0x184(%ebp,%eax,4),%edx
 168:	89 44 24 08          	mov    %eax,0x8(%esp)
 16c:	a1 8c 09 00 00       	mov    0x98c,%eax
 171:	89 54 24 0c          	mov    %edx,0xc(%esp)
 175:	89 04 24             	mov    %eax,(%esp)
 178:	e8 73 04 00 00       	call   5f0 <printf>
 17d:	8d 76 00             	lea    0x0(%esi),%esi
 180:	8b 44 9e fc          	mov    -0x4(%esi,%ebx,4),%eax
 184:	83 c3 01             	add    $0x1,%ebx
 187:	c7 44 24 04 d9 08 00 	movl   $0x8d9,0x4(%esp)
 18e:	00 
 18f:	8b 94 85 7c fe ff ff 	mov    -0x184(%ebp,%eax,4),%edx
 196:	89 44 24 08          	mov    %eax,0x8(%esp)
 19a:	a1 8c 09 00 00       	mov    0x98c,%eax
 19f:	89 54 24 0c          	mov    %edx,0xc(%esp)
 1a3:	89 04 24             	mov    %eax,(%esp)
 1a6:	e8 45 04 00 00       	call   5f0 <printf>
	/* parent goes here */
	for (i = 0; i < NUM_CHILD; i++) {
		pids[i] = wait();  
		/* pids[] records the order of finished children */
	}
	for (i = 0; i < NUM_CHILD; i++) {
 1ab:	83 fb 16             	cmp    $0x16,%ebx
 1ae:	75 d0                	jne    180 <main+0xe0>
		printf(stdout, "child %d exits: prio: %d\n", 
		       pids[i], pids_prio[pids[i]]);
	}

	if (pids_prio[pids[NUM_CHILD-1]] != MAX_PRIO - 1)
 1b0:	8b 45 cc             	mov    -0x34(%ebp),%eax
 1b3:	83 bc 85 7c fe ff ff 	cmpl   $0x4,-0x184(%ebp,%eax,4)
 1ba:	04 
 1bb:	0f 84 8e 00 00 00    	je     24f <main+0x1af>
int stdout = 1;
int stderr = 2;
inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 1c1:	c7 44 24 08 30 09 00 	movl   $0x930,0x8(%esp)
 1c8:	00 
 1c9:	a1 90 09 00 00       	mov    0x990,%eax
 1ce:	c7 44 24 04 c8 08 00 	movl   $0x8c8,0x4(%esp)
 1d5:	00 
 1d6:	89 04 24             	mov    %eax,(%esp)
 1d9:	e8 12 04 00 00       	call   5f0 <printf>
  exit();
 1de:	e8 95 02 00 00       	call   478 <exit>
int stdout = 1;
int stderr = 2;
inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 1e3:	c7 44 24 08 cc 08 00 	movl   $0x8cc,0x8(%esp)
 1ea:	00 
 1eb:	eb dc                	jmp    1c9 <main+0x129>
				exit();
			}
		}
	}
	if (!pid) { /* children go here */
		sleep(1);
 1ed:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1f4:	e8 0f 03 00 00       	call   508 <sleep>
		lengthy(value, N, 0);
 1f9:	8d 45 d0             	lea    -0x30(%ebp),%eax
 1fc:	89 04 24             	mov    %eax,(%esp)
 1ff:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
 206:	00 
 207:	c7 44 24 04 08 00 00 	movl   $0x8,0x4(%esp)
 20e:	00 
 20f:	e8 ec fd ff ff       	call   0 <lengthy>
		exit();
 214:	e8 5f 02 00 00       	call   478 <exit>
		} else if (pid == 0) { /* child */
			break;
		} else { /* parent */
			pids_prio[pid] = (i!=(NUM_CHILD-1) ? i % (MAX_PRIO-1) : MAX_PRIO-1);
			if (setpriority(pid, pids_prio[pid]) < 0) {
				printf(stdout, 
 219:	e8 da 02 00 00       	call   4f8 <getpid>
 21e:	89 04 24             	mov    %eax,(%esp)
 221:	e8 fa 02 00 00       	call   520 <getpriority>
 226:	89 c3                	mov    %eax,%ebx
 228:	e8 cb 02 00 00       	call   4f8 <getpid>
 22d:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
 231:	c7 44 24 04 0c 09 00 	movl   $0x90c,0x4(%esp)
 238:	00 
 239:	89 44 24 08          	mov    %eax,0x8(%esp)
 23d:	a1 8c 09 00 00       	mov    0x98c,%eax
 242:	89 04 24             	mov    %eax,(%esp)
 245:	e8 a6 03 00 00       	call   5f0 <printf>
				       "%d setpriority failed, prio: %d\n", 
				       getpid(), getpriority(getpid()));
				exit();
 24a:	e8 29 02 00 00       	call   478 <exit>

	if (pids_prio[pids[NUM_CHILD-1]] != MAX_PRIO - 1)
		handle_error("Scheduling error: the process in the last queue does not exit last.");
	

	printf(stdout, "hw4-test-str succeeded\n");
 24f:	a1 8c 09 00 00       	mov    0x98c,%eax
 254:	c7 44 24 04 f3 08 00 	movl   $0x8f3,0x4(%esp)
 25b:	00 
 25c:	89 04 24             	mov    %eax,(%esp)
 25f:	e8 8c 03 00 00       	call   5f0 <printf>

	exit();
 264:	e8 0f 02 00 00       	call   478 <exit>
 269:	90                   	nop    
 26a:	90                   	nop    
 26b:	90                   	nop    
 26c:	90                   	nop    
 26d:	90                   	nop    
 26e:	90                   	nop    
 26f:	90                   	nop    

00000270 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	53                   	push   %ebx
 274:	8b 5d 08             	mov    0x8(%ebp),%ebx
 277:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 27a:	89 da                	mov    %ebx,%edx
 27c:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 280:	0f b6 01             	movzbl (%ecx),%eax
 283:	83 c1 01             	add    $0x1,%ecx
 286:	88 02                	mov    %al,(%edx)
 288:	83 c2 01             	add    $0x1,%edx
 28b:	84 c0                	test   %al,%al
 28d:	75 f1                	jne    280 <strcpy+0x10>
    ;
  return os;
}
 28f:	89 d8                	mov    %ebx,%eax
 291:	5b                   	pop    %ebx
 292:	5d                   	pop    %ebp
 293:	c3                   	ret    
 294:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 29a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000002a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2a6:	53                   	push   %ebx
 2a7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 2aa:	0f b6 01             	movzbl (%ecx),%eax
 2ad:	84 c0                	test   %al,%al
 2af:	74 24                	je     2d5 <strcmp+0x35>
 2b1:	0f b6 13             	movzbl (%ebx),%edx
 2b4:	38 d0                	cmp    %dl,%al
 2b6:	74 12                	je     2ca <strcmp+0x2a>
 2b8:	eb 1e                	jmp    2d8 <strcmp+0x38>
 2ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2c0:	0f b6 13             	movzbl (%ebx),%edx
 2c3:	83 c1 01             	add    $0x1,%ecx
 2c6:	38 d0                	cmp    %dl,%al
 2c8:	75 0e                	jne    2d8 <strcmp+0x38>
 2ca:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 2ce:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2d1:	84 c0                	test   %al,%al
 2d3:	75 eb                	jne    2c0 <strcmp+0x20>
 2d5:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 2d8:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2d9:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 2dc:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2dd:	0f b6 d2             	movzbl %dl,%edx
 2e0:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 2e2:	c3                   	ret    
 2e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000002f0 <strlen>:

uint
strlen(char *s)
{
 2f0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 2f1:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 2f3:	89 e5                	mov    %esp,%ebp
 2f5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 2f8:	80 39 00             	cmpb   $0x0,(%ecx)
 2fb:	74 0e                	je     30b <strlen+0x1b>
 2fd:	31 d2                	xor    %edx,%edx
 2ff:	90                   	nop    
 300:	83 c2 01             	add    $0x1,%edx
 303:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
 307:	89 d0                	mov    %edx,%eax
 309:	75 f5                	jne    300 <strlen+0x10>
    ;
  return n;
}
 30b:	5d                   	pop    %ebp
 30c:	c3                   	ret    
 30d:	8d 76 00             	lea    0x0(%esi),%esi

00000310 <memset>:

void*
memset(void *dst, int c, uint n)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	8b 55 08             	mov    0x8(%ebp),%edx
 316:	57                   	push   %edi
 317:	8b 45 0c             	mov    0xc(%ebp),%eax
 31a:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 31d:	89 d7                	mov    %edx,%edi
 31f:	fc                   	cld    
 320:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 322:	5f                   	pop    %edi
 323:	89 d0                	mov    %edx,%eax
 325:	5d                   	pop    %ebp
 326:	c3                   	ret    
 327:	89 f6                	mov    %esi,%esi
 329:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000330 <strchr>:

char*
strchr(const char *s, char c)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	8b 45 08             	mov    0x8(%ebp),%eax
 336:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 33a:	0f b6 10             	movzbl (%eax),%edx
 33d:	84 d2                	test   %dl,%dl
 33f:	75 0c                	jne    34d <strchr+0x1d>
 341:	eb 11                	jmp    354 <strchr+0x24>
 343:	83 c0 01             	add    $0x1,%eax
 346:	0f b6 10             	movzbl (%eax),%edx
 349:	84 d2                	test   %dl,%dl
 34b:	74 07                	je     354 <strchr+0x24>
    if(*s == c)
 34d:	38 ca                	cmp    %cl,%dl
 34f:	90                   	nop    
 350:	75 f1                	jne    343 <strchr+0x13>
      return (char*) s;
  return 0;
}
 352:	5d                   	pop    %ebp
 353:	c3                   	ret    
 354:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 355:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 357:	c3                   	ret    
 358:	90                   	nop    
 359:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000360 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	8b 4d 08             	mov    0x8(%ebp),%ecx
 366:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 367:	31 db                	xor    %ebx,%ebx
 369:	0f b6 11             	movzbl (%ecx),%edx
 36c:	8d 42 d0             	lea    -0x30(%edx),%eax
 36f:	3c 09                	cmp    $0x9,%al
 371:	77 18                	ja     38b <atoi+0x2b>
    n = n*10 + *s++ - '0';
 373:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 376:	0f be d2             	movsbl %dl,%edx
 379:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 37d:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 381:	83 c1 01             	add    $0x1,%ecx
 384:	8d 42 d0             	lea    -0x30(%edx),%eax
 387:	3c 09                	cmp    $0x9,%al
 389:	76 e8                	jbe    373 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 38b:	89 d8                	mov    %ebx,%eax
 38d:	5b                   	pop    %ebx
 38e:	5d                   	pop    %ebp
 38f:	c3                   	ret    

00000390 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	8b 4d 10             	mov    0x10(%ebp),%ecx
 396:	56                   	push   %esi
 397:	8b 75 08             	mov    0x8(%ebp),%esi
 39a:	53                   	push   %ebx
 39b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 39e:	85 c9                	test   %ecx,%ecx
 3a0:	7e 10                	jle    3b2 <memmove+0x22>
 3a2:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 3a4:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 3a8:	88 04 32             	mov    %al,(%edx,%esi,1)
 3ab:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3ae:	39 ca                	cmp    %ecx,%edx
 3b0:	75 f2                	jne    3a4 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 3b2:	89 f0                	mov    %esi,%eax
 3b4:	5b                   	pop    %ebx
 3b5:	5e                   	pop    %esi
 3b6:	5d                   	pop    %ebp
 3b7:	c3                   	ret    
 3b8:	90                   	nop    
 3b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000003c0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3c6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 3c9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 3cc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 3cf:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3d4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 3db:	00 
 3dc:	89 04 24             	mov    %eax,(%esp)
 3df:	e8 d4 00 00 00       	call   4b8 <open>
  if(fd < 0)
 3e4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3e6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 3e8:	78 19                	js     403 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 3ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ed:	89 1c 24             	mov    %ebx,(%esp)
 3f0:	89 44 24 04          	mov    %eax,0x4(%esp)
 3f4:	e8 d7 00 00 00       	call   4d0 <fstat>
  close(fd);
 3f9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 3fc:	89 c6                	mov    %eax,%esi
  close(fd);
 3fe:	e8 9d 00 00 00       	call   4a0 <close>
  return r;
}
 403:	89 f0                	mov    %esi,%eax
 405:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 408:	8b 75 fc             	mov    -0x4(%ebp),%esi
 40b:	89 ec                	mov    %ebp,%esp
 40d:	5d                   	pop    %ebp
 40e:	c3                   	ret    
 40f:	90                   	nop    

00000410 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	31 f6                	xor    %esi,%esi
 417:	53                   	push   %ebx
 418:	83 ec 1c             	sub    $0x1c,%esp
 41b:	8b 7d 08             	mov    0x8(%ebp),%edi
 41e:	eb 06                	jmp    426 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 420:	3c 0d                	cmp    $0xd,%al
 422:	74 39                	je     45d <gets+0x4d>
 424:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 426:	8d 5e 01             	lea    0x1(%esi),%ebx
 429:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 42c:	7d 31                	jge    45f <gets+0x4f>
    cc = read(0, &c, 1);
 42e:	8d 45 f3             	lea    -0xd(%ebp),%eax
 431:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 438:	00 
 439:	89 44 24 04          	mov    %eax,0x4(%esp)
 43d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 444:	e8 47 00 00 00       	call   490 <read>
    if(cc < 1)
 449:	85 c0                	test   %eax,%eax
 44b:	7e 12                	jle    45f <gets+0x4f>
      break;
    buf[i++] = c;
 44d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 451:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 455:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 459:	3c 0a                	cmp    $0xa,%al
 45b:	75 c3                	jne    420 <gets+0x10>
 45d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 45f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 463:	89 f8                	mov    %edi,%eax
 465:	83 c4 1c             	add    $0x1c,%esp
 468:	5b                   	pop    %ebx
 469:	5e                   	pop    %esi
 46a:	5f                   	pop    %edi
 46b:	5d                   	pop    %ebp
 46c:	c3                   	ret    
 46d:	90                   	nop    
 46e:	90                   	nop    
 46f:	90                   	nop    

00000470 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 470:	b8 01 00 00 00       	mov    $0x1,%eax
 475:	cd 40                	int    $0x40
 477:	c3                   	ret    

00000478 <exit>:
SYSCALL(exit)
 478:	b8 02 00 00 00       	mov    $0x2,%eax
 47d:	cd 40                	int    $0x40
 47f:	c3                   	ret    

00000480 <wait>:
SYSCALL(wait)
 480:	b8 03 00 00 00       	mov    $0x3,%eax
 485:	cd 40                	int    $0x40
 487:	c3                   	ret    

00000488 <pipe>:
SYSCALL(pipe)
 488:	b8 04 00 00 00       	mov    $0x4,%eax
 48d:	cd 40                	int    $0x40
 48f:	c3                   	ret    

00000490 <read>:
SYSCALL(read)
 490:	b8 06 00 00 00       	mov    $0x6,%eax
 495:	cd 40                	int    $0x40
 497:	c3                   	ret    

00000498 <write>:
SYSCALL(write)
 498:	b8 05 00 00 00       	mov    $0x5,%eax
 49d:	cd 40                	int    $0x40
 49f:	c3                   	ret    

000004a0 <close>:
SYSCALL(close)
 4a0:	b8 07 00 00 00       	mov    $0x7,%eax
 4a5:	cd 40                	int    $0x40
 4a7:	c3                   	ret    

000004a8 <kill>:
SYSCALL(kill)
 4a8:	b8 08 00 00 00       	mov    $0x8,%eax
 4ad:	cd 40                	int    $0x40
 4af:	c3                   	ret    

000004b0 <exec>:
SYSCALL(exec)
 4b0:	b8 09 00 00 00       	mov    $0x9,%eax
 4b5:	cd 40                	int    $0x40
 4b7:	c3                   	ret    

000004b8 <open>:
SYSCALL(open)
 4b8:	b8 0a 00 00 00       	mov    $0xa,%eax
 4bd:	cd 40                	int    $0x40
 4bf:	c3                   	ret    

000004c0 <mknod>:
SYSCALL(mknod)
 4c0:	b8 0b 00 00 00       	mov    $0xb,%eax
 4c5:	cd 40                	int    $0x40
 4c7:	c3                   	ret    

000004c8 <unlink>:
SYSCALL(unlink)
 4c8:	b8 0c 00 00 00       	mov    $0xc,%eax
 4cd:	cd 40                	int    $0x40
 4cf:	c3                   	ret    

000004d0 <fstat>:
SYSCALL(fstat)
 4d0:	b8 0d 00 00 00       	mov    $0xd,%eax
 4d5:	cd 40                	int    $0x40
 4d7:	c3                   	ret    

000004d8 <link>:
SYSCALL(link)
 4d8:	b8 0e 00 00 00       	mov    $0xe,%eax
 4dd:	cd 40                	int    $0x40
 4df:	c3                   	ret    

000004e0 <mkdir>:
SYSCALL(mkdir)
 4e0:	b8 0f 00 00 00       	mov    $0xf,%eax
 4e5:	cd 40                	int    $0x40
 4e7:	c3                   	ret    

000004e8 <chdir>:
SYSCALL(chdir)
 4e8:	b8 10 00 00 00       	mov    $0x10,%eax
 4ed:	cd 40                	int    $0x40
 4ef:	c3                   	ret    

000004f0 <dup>:
SYSCALL(dup)
 4f0:	b8 11 00 00 00       	mov    $0x11,%eax
 4f5:	cd 40                	int    $0x40
 4f7:	c3                   	ret    

000004f8 <getpid>:
SYSCALL(getpid)
 4f8:	b8 12 00 00 00       	mov    $0x12,%eax
 4fd:	cd 40                	int    $0x40
 4ff:	c3                   	ret    

00000500 <sbrk>:
SYSCALL(sbrk)
 500:	b8 13 00 00 00       	mov    $0x13,%eax
 505:	cd 40                	int    $0x40
 507:	c3                   	ret    

00000508 <sleep>:
SYSCALL(sleep)
 508:	b8 14 00 00 00       	mov    $0x14,%eax
 50d:	cd 40                	int    $0x40
 50f:	c3                   	ret    

00000510 <uptime>:
SYSCALL(uptime)
 510:	b8 15 00 00 00       	mov    $0x15,%eax
 515:	cd 40                	int    $0x40
 517:	c3                   	ret    

00000518 <nice>:
SYSCALL(nice)
 518:	b8 16 00 00 00       	mov    $0x16,%eax
 51d:	cd 40                	int    $0x40
 51f:	c3                   	ret    

00000520 <getpriority>:
SYSCALL(getpriority)
 520:	b8 17 00 00 00       	mov    $0x17,%eax
 525:	cd 40                	int    $0x40
 527:	c3                   	ret    

00000528 <setpriority>:
SYSCALL(setpriority)
 528:	b8 18 00 00 00       	mov    $0x18,%eax
 52d:	cd 40                	int    $0x40
 52f:	c3                   	ret    

00000530 <getaffinity>:
SYSCALL(getaffinity)
 530:	b8 19 00 00 00       	mov    $0x19,%eax
 535:	cd 40                	int    $0x40
 537:	c3                   	ret    

00000538 <setaffinity>:
SYSCALL(setaffinity)
 538:	b8 1a 00 00 00       	mov    $0x1a,%eax
 53d:	cd 40                	int    $0x40
 53f:	c3                   	ret    

00000540 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	83 ec 18             	sub    $0x18,%esp
 546:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 549:	8d 55 fc             	lea    -0x4(%ebp),%edx
 54c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 553:	00 
 554:	89 54 24 04          	mov    %edx,0x4(%esp)
 558:	89 04 24             	mov    %eax,(%esp)
 55b:	e8 38 ff ff ff       	call   498 <write>
}
 560:	c9                   	leave  
 561:	c3                   	ret    
 562:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 569:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000570 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 570:	55                   	push   %ebp
 571:	89 e5                	mov    %esp,%ebp
 573:	57                   	push   %edi
 574:	56                   	push   %esi
 575:	89 ce                	mov    %ecx,%esi
 577:	53                   	push   %ebx
 578:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 57b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 57e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 581:	85 c9                	test   %ecx,%ecx
 583:	74 04                	je     589 <printint+0x19>
 585:	85 d2                	test   %edx,%edx
 587:	78 54                	js     5dd <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 589:	89 d0                	mov    %edx,%eax
 58b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 592:	31 db                	xor    %ebx,%ebx
 594:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 597:	31 d2                	xor    %edx,%edx
 599:	f7 f6                	div    %esi
 59b:	89 c1                	mov    %eax,%ecx
 59d:	0f b6 82 7b 09 00 00 	movzbl 0x97b(%edx),%eax
 5a4:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 5a7:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 5aa:	85 c9                	test   %ecx,%ecx
 5ac:	89 c8                	mov    %ecx,%eax
 5ae:	75 e7                	jne    597 <printint+0x27>
  if(neg)
 5b0:	8b 45 e0             	mov    -0x20(%ebp),%eax
 5b3:	85 c0                	test   %eax,%eax
 5b5:	74 08                	je     5bf <printint+0x4f>
    buf[i++] = '-';
 5b7:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 5bc:	83 c3 01             	add    $0x1,%ebx
 5bf:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 5c2:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 5c6:	83 eb 01             	sub    $0x1,%ebx
 5c9:	8b 45 dc             	mov    -0x24(%ebp),%eax
 5cc:	e8 6f ff ff ff       	call   540 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 5d1:	39 fb                	cmp    %edi,%ebx
 5d3:	75 ed                	jne    5c2 <printint+0x52>
    putc(fd, buf[i]);
}
 5d5:	83 c4 1c             	add    $0x1c,%esp
 5d8:	5b                   	pop    %ebx
 5d9:	5e                   	pop    %esi
 5da:	5f                   	pop    %edi
 5db:	5d                   	pop    %ebp
 5dc:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 5dd:	89 d0                	mov    %edx,%eax
 5df:	f7 d8                	neg    %eax
 5e1:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 5e8:	eb a8                	jmp    592 <printint+0x22>
 5ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000005f0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	57                   	push   %edi
 5f4:	56                   	push   %esi
 5f5:	53                   	push   %ebx
 5f6:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5f9:	8b 55 0c             	mov    0xc(%ebp),%edx
 5fc:	0f b6 02             	movzbl (%edx),%eax
 5ff:	84 c0                	test   %al,%al
 601:	0f 84 87 00 00 00    	je     68e <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 607:	8d 4d 10             	lea    0x10(%ebp),%ecx
 60a:	31 ff                	xor    %edi,%edi
 60c:	31 f6                	xor    %esi,%esi
 60e:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 611:	eb 18                	jmp    62b <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 613:	83 fb 25             	cmp    $0x25,%ebx
 616:	0f 85 7a 00 00 00    	jne    696 <printf+0xa6>
 61c:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 620:	83 c7 01             	add    $0x1,%edi
 623:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 627:	84 c0                	test   %al,%al
 629:	74 63                	je     68e <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 62b:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 62d:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 630:	74 e1                	je     613 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 632:	83 fe 25             	cmp    $0x25,%esi
 635:	75 e9                	jne    620 <printf+0x30>
      if(c == 'd'){
 637:	83 fb 64             	cmp    $0x64,%ebx
 63a:	0f 84 f0 00 00 00    	je     730 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 640:	83 fb 78             	cmp    $0x78,%ebx
 643:	74 64                	je     6a9 <printf+0xb9>
 645:	83 fb 70             	cmp    $0x70,%ebx
 648:	74 5f                	je     6a9 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 64a:	83 fb 73             	cmp    $0x73,%ebx
 64d:	8d 76 00             	lea    0x0(%esi),%esi
 650:	74 7e                	je     6d0 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 652:	83 fb 63             	cmp    $0x63,%ebx
 655:	0f 84 b9 00 00 00    	je     714 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 65b:	83 fb 25             	cmp    $0x25,%ebx
 65e:	66 90                	xchg   %ax,%ax
 660:	0f 84 f2 00 00 00    	je     758 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 666:	8b 45 08             	mov    0x8(%ebp),%eax
 669:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 66e:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 671:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 673:	e8 c8 fe ff ff       	call   540 <putc>
        putc(fd, c);
 678:	8b 45 08             	mov    0x8(%ebp),%eax
 67b:	0f be d3             	movsbl %bl,%edx
 67e:	e8 bd fe ff ff       	call   540 <putc>
 683:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 686:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 68a:	84 c0                	test   %al,%al
 68c:	75 9d                	jne    62b <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 68e:	83 c4 0c             	add    $0xc,%esp
 691:	5b                   	pop    %ebx
 692:	5e                   	pop    %esi
 693:	5f                   	pop    %edi
 694:	5d                   	pop    %ebp
 695:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 696:	8b 45 08             	mov    0x8(%ebp),%eax
 699:	0f be d3             	movsbl %bl,%edx
 69c:	e8 9f fe ff ff       	call   540 <putc>
 6a1:	8b 55 0c             	mov    0xc(%ebp),%edx
 6a4:	e9 77 ff ff ff       	jmp    620 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 6a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6ac:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 6b1:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 6b3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 6ba:	8b 10                	mov    (%eax),%edx
 6bc:	8b 45 08             	mov    0x8(%ebp),%eax
 6bf:	e8 ac fe ff ff       	call   570 <printint>
 6c4:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 6c7:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 6cb:	e9 50 ff ff ff       	jmp    620 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 6d0:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 6d3:	8b 01                	mov    (%ecx),%eax
        ap++;
 6d5:	83 c1 04             	add    $0x4,%ecx
 6d8:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 6db:	b9 74 09 00 00       	mov    $0x974,%ecx
 6e0:	85 c0                	test   %eax,%eax
 6e2:	75 2c                	jne    710 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 6e4:	0f b6 01             	movzbl (%ecx),%eax
 6e7:	84 c0                	test   %al,%al
 6e9:	74 1e                	je     709 <printf+0x119>
 6eb:	89 cb                	mov    %ecx,%ebx
 6ed:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 6f0:	0f be d0             	movsbl %al,%edx
 6f3:	8b 45 08             	mov    0x8(%ebp),%eax
 6f6:	e8 45 fe ff ff       	call   540 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6fb:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 6ff:	83 c3 01             	add    $0x1,%ebx
 702:	84 c0                	test   %al,%al
 704:	75 ea                	jne    6f0 <printf+0x100>
 706:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 709:	31 f6                	xor    %esi,%esi
 70b:	e9 10 ff ff ff       	jmp    620 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 710:	89 c1                	mov    %eax,%ecx
 712:	eb d0                	jmp    6e4 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 714:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 717:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 719:	0f be 10             	movsbl (%eax),%edx
 71c:	8b 45 08             	mov    0x8(%ebp),%eax
 71f:	e8 1c fe ff ff       	call   540 <putc>
 724:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 727:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 72b:	e9 f0 fe ff ff       	jmp    620 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 730:	8b 45 f0             	mov    -0x10(%ebp),%eax
 733:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 738:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 73b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 742:	8b 10                	mov    (%eax),%edx
 744:	8b 45 08             	mov    0x8(%ebp),%eax
 747:	e8 24 fe ff ff       	call   570 <printint>
 74c:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 74f:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 753:	e9 c8 fe ff ff       	jmp    620 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 758:	8b 45 08             	mov    0x8(%ebp),%eax
 75b:	ba 25 00 00 00       	mov    $0x25,%edx
 760:	31 f6                	xor    %esi,%esi
 762:	e8 d9 fd ff ff       	call   540 <putc>
 767:	8b 55 0c             	mov    0xc(%ebp),%edx
 76a:	e9 b1 fe ff ff       	jmp    620 <printf+0x30>
 76f:	90                   	nop    

00000770 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 770:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 771:	8b 0d a0 09 00 00    	mov    0x9a0,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 777:	89 e5                	mov    %esp,%ebp
 779:	56                   	push   %esi
 77a:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 77b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 77e:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 781:	39 d9                	cmp    %ebx,%ecx
 783:	73 18                	jae    79d <free+0x2d>
 785:	8b 11                	mov    (%ecx),%edx
 787:	39 d3                	cmp    %edx,%ebx
 789:	72 17                	jb     7a2 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 78b:	39 d1                	cmp    %edx,%ecx
 78d:	72 08                	jb     797 <free+0x27>
 78f:	39 d9                	cmp    %ebx,%ecx
 791:	72 0f                	jb     7a2 <free+0x32>
 793:	39 d3                	cmp    %edx,%ebx
 795:	72 0b                	jb     7a2 <free+0x32>
 797:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 799:	39 d9                	cmp    %ebx,%ecx
 79b:	72 e8                	jb     785 <free+0x15>
 79d:	8b 11                	mov    (%ecx),%edx
 79f:	90                   	nop    
 7a0:	eb e9                	jmp    78b <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7a2:	8b 73 04             	mov    0x4(%ebx),%esi
 7a5:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 7a8:	39 d0                	cmp    %edx,%eax
 7aa:	74 18                	je     7c4 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7ac:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 7ae:	8b 51 04             	mov    0x4(%ecx),%edx
 7b1:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 7b4:	39 d8                	cmp    %ebx,%eax
 7b6:	74 20                	je     7d8 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7b8:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 7ba:	5b                   	pop    %ebx
 7bb:	5e                   	pop    %esi
 7bc:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 7bd:	89 0d a0 09 00 00    	mov    %ecx,0x9a0
}
 7c3:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7c4:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 7c7:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7c9:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7cc:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 7cf:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7d1:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 7d4:	39 d8                	cmp    %ebx,%eax
 7d6:	75 e0                	jne    7b8 <free+0x48>
    p->s.size += bp->s.size;
 7d8:	03 53 04             	add    0x4(%ebx),%edx
 7db:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 7de:	8b 13                	mov    (%ebx),%edx
 7e0:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 7e2:	5b                   	pop    %ebx
 7e3:	5e                   	pop    %esi
 7e4:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 7e5:	89 0d a0 09 00 00    	mov    %ecx,0x9a0
}
 7eb:	c3                   	ret    
 7ec:	8d 74 26 00          	lea    0x0(%esi),%esi

000007f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7f0:	55                   	push   %ebp
 7f1:	89 e5                	mov    %esp,%ebp
 7f3:	57                   	push   %edi
 7f4:	56                   	push   %esi
 7f5:	53                   	push   %ebx
 7f6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7fc:	8b 15 a0 09 00 00    	mov    0x9a0,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 802:	83 c0 07             	add    $0x7,%eax
 805:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 808:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 80a:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 80d:	0f 84 8a 00 00 00    	je     89d <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 813:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 815:	8b 41 04             	mov    0x4(%ecx),%eax
 818:	39 c3                	cmp    %eax,%ebx
 81a:	76 1a                	jbe    836 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 81c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 823:	3b 0d a0 09 00 00    	cmp    0x9a0,%ecx
 829:	89 ca                	mov    %ecx,%edx
 82b:	74 29                	je     856 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 82d:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 82f:	8b 41 04             	mov    0x4(%ecx),%eax
 832:	39 c3                	cmp    %eax,%ebx
 834:	77 ed                	ja     823 <malloc+0x33>
      if(p->s.size == nunits)
 836:	39 c3                	cmp    %eax,%ebx
 838:	74 5d                	je     897 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 83a:	29 d8                	sub    %ebx,%eax
 83c:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 83f:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 842:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 845:	89 15 a0 09 00 00    	mov    %edx,0x9a0
      return (void*) (p + 1);
 84b:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 84e:	83 c4 0c             	add    $0xc,%esp
 851:	5b                   	pop    %ebx
 852:	5e                   	pop    %esi
 853:	5f                   	pop    %edi
 854:	5d                   	pop    %ebp
 855:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 856:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 85c:	89 de                	mov    %ebx,%esi
 85e:	89 f8                	mov    %edi,%eax
 860:	76 29                	jbe    88b <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 862:	89 04 24             	mov    %eax,(%esp)
 865:	e8 96 fc ff ff       	call   500 <sbrk>
  if(p == (char*) -1)
 86a:	83 f8 ff             	cmp    $0xffffffff,%eax
 86d:	74 18                	je     887 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 86f:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 872:	83 c0 08             	add    $0x8,%eax
 875:	89 04 24             	mov    %eax,(%esp)
 878:	e8 f3 fe ff ff       	call   770 <free>
  return freep;
 87d:	8b 15 a0 09 00 00    	mov    0x9a0,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 883:	85 d2                	test   %edx,%edx
 885:	75 a6                	jne    82d <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 887:	31 c0                	xor    %eax,%eax
 889:	eb c3                	jmp    84e <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 88b:	be 00 10 00 00       	mov    $0x1000,%esi
 890:	b8 00 80 00 00       	mov    $0x8000,%eax
 895:	eb cb                	jmp    862 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 897:	8b 01                	mov    (%ecx),%eax
 899:	89 02                	mov    %eax,(%edx)
 89b:	eb a8                	jmp    845 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 89d:	ba 98 09 00 00       	mov    $0x998,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 8a2:	c7 05 a0 09 00 00 98 	movl   $0x998,0x9a0
 8a9:	09 00 00 
 8ac:	c7 05 98 09 00 00 98 	movl   $0x998,0x998
 8b3:	09 00 00 
    base.s.size = 0;
 8b6:	c7 05 9c 09 00 00 00 	movl   $0x0,0x99c
 8bd:	00 00 00 
 8c0:	e9 4e ff ff ff       	jmp    813 <malloc+0x23>
