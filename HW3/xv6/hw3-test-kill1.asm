
_hw3-test-kill1:     file format elf32-i386

Disassembly of section .text:

00000000 <time_equal>:

int stdout = 1;
int stderr = 2;

// Return true if <a> and <b> differ in at most 5%. 
inline int time_equal(int a, int b) {
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	8b 55 08             	mov    0x8(%ebp),%edx
   6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  if (a < 0 || b < 0)
   9:	85 d2                	test   %edx,%edx
   b:	78 23                	js     30 <time_equal+0x30>
   d:	85 c9                	test   %ecx,%ecx
   f:	78 1f                	js     30 <time_equal+0x30>
    return 0;
  if (a > b) {
  11:	39 ca                	cmp    %ecx,%edx
  13:	7e 06                	jle    1b <time_equal+0x1b>
  15:	89 c8                	mov    %ecx,%eax
  17:	89 d1                	mov    %edx,%ecx
  19:	89 c2                	mov    %eax,%edx
    int t = a;
    a = b;
    b = t;
  }
  return 10 * (b - a) <= b;
  1b:	89 c8                	mov    %ecx,%eax
  1d:	29 d0                	sub    %edx,%eax
  1f:	8d 04 80             	lea    (%eax,%eax,4),%eax
  22:	01 c0                	add    %eax,%eax
  24:	39 c8                	cmp    %ecx,%eax
}
  26:	5d                   	pop    %ebp
  if (a > b) {
    int t = a;
    a = b;
    b = t;
  }
  return 10 * (b - a) <= b;
  27:	0f 9e c0             	setle  %al
  2a:	0f b6 c0             	movzbl %al,%eax
}
  2d:	c3                   	ret    
  2e:	66 90                	xchg   %ax,%ax
  30:	5d                   	pop    %ebp
int stdout = 1;
int stderr = 2;

// Return true if <a> and <b> differ in at most 5%. 
inline int time_equal(int a, int b) {
  if (a < 0 || b < 0)
  31:	31 c0                	xor    %eax,%eax
    int t = a;
    a = b;
    b = t;
  }
  return 10 * (b - a) <= b;
}
  33:	c3                   	ret    
  34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000040 <handle_error>:

inline void handle_error(const char *msg) {
  40:	55                   	push   %ebp
  41:	89 e5                	mov    %esp,%ebp
  43:	83 ec 18             	sub    $0x18,%esp
  printf(stderr, "%s\n", msg);
  46:	8b 45 08             	mov    0x8(%ebp),%eax
  49:	c7 44 24 04 85 09 00 	movl   $0x985,0x4(%esp)
  50:	00 
  51:	89 44 24 08          	mov    %eax,0x8(%esp)
  55:	a1 1c 0a 00 00       	mov    0xa1c,%eax
  5a:	89 04 24             	mov    %eax,(%esp)
  5d:	e8 4e 06 00 00       	call   6b0 <printf>
  exit();
  62:	e8 d1 04 00 00       	call   538 <exit>
  67:	89 f6                	mov    %esi,%esi
  69:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000070 <thread_function>:
  check = MAGIC_VALUE;
  texit();
}

void thread_function(void *arg)
{
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	83 ec 08             	sub    $0x8,%esp
  for (;;)
    sleep(0xFFFF);
  76:	c7 04 24 ff ff 00 00 	movl   $0xffff,(%esp)
  7d:	e8 46 05 00 00       	call   5c8 <sleep>
  82:	eb f2                	jmp    76 <thread_function+0x6>
  84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000090 <thread_verify>:
#define N_THREADS 8

int check;

void thread_verify(void *arg)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  check = MAGIC_VALUE;
  texit();
}
  93:	5d                   	pop    %ebp

int check;

void thread_verify(void *arg)
{
  check = MAGIC_VALUE;
  94:	c7 05 2c 0a 00 00 ef 	movl   $0x987cdef,0xa2c
  9b:	cd 87 09 
  texit();
  9e:	e9 4d 05 00 00       	jmp    5f0 <texit>
  a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000000b0 <child_process>:

  texit();
}

void child_process(int do_exit, int thread)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	53                   	push   %ebx
  b4:	83 ec 14             	sub    $0x14,%esp
  char *stack[N_THREADS];
  int tid[N_THREADS];
  int i;

  if (thread)
  b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  ba:	85 d2                	test   %edx,%edx
  bc:	75 15                	jne    d3 <child_process+0x23>
    for (i = 0; i < N_THREADS; i++)
      NEW_STACK_THREAD(thread_function, 0, stack[i], tid[i]);

  if (do_exit)
  be:	8b 45 08             	mov    0x8(%ebp),%eax
  c1:	85 c0                	test   %eax,%eax
  c3:	75 72                	jne    137 <child_process+0x87>
    exit();
  else
    for (;;)
      sleep(0xFFFF);
  c5:	c7 04 24 ff ff 00 00 	movl   $0xffff,(%esp)
  cc:	e8 f7 04 00 00       	call   5c8 <sleep>
  d1:	eb f2                	jmp    c5 <child_process+0x15>
{
  char *stack[N_THREADS];
  int tid[N_THREADS];
  int i;

  if (thread)
  d3:	31 db                	xor    %ebx,%ebx
  d5:	eb 29                	jmp    100 <child_process+0x50>
    for (i = 0; i < N_THREADS; i++)
      NEW_STACK_THREAD(thread_function, 0, stack[i], tid[i]);
  d7:	05 00 10 00 00       	add    $0x1000,%eax
  dc:	89 44 24 08          	mov    %eax,0x8(%esp)
  e0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  e7:	00 
  e8:	c7 04 24 70 00 00 00 	movl   $0x70,(%esp)
  ef:	e8 f4 04 00 00       	call   5e8 <tfork>
  f4:	85 c0                	test   %eax,%eax
  f6:	78 22                	js     11a <child_process+0x6a>
  char *stack[N_THREADS];
  int tid[N_THREADS];
  int i;

  if (thread)
    for (i = 0; i < N_THREADS; i++)
  f8:	83 c3 01             	add    $0x1,%ebx
  fb:	83 fb 08             	cmp    $0x8,%ebx
  fe:	74 be                	je     be <child_process+0xe>
      NEW_STACK_THREAD(thread_function, 0, stack[i], tid[i]);
 100:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 107:	e8 a4 07 00 00       	call   8b0 <malloc>
 10c:	85 c0                	test   %eax,%eax
 10e:	75 c7                	jne    d7 <child_process+0x27>
  }
  return 10 * (b - a) <= b;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 110:	c7 44 24 08 89 09 00 	movl   $0x989,0x8(%esp)
 117:	00 
 118:	eb 08                	jmp    122 <child_process+0x72>
  exit();
 11a:	c7 44 24 08 98 09 00 	movl   $0x998,0x8(%esp)
 121:	00 
 122:	a1 1c 0a 00 00       	mov    0xa1c,%eax
 127:	c7 44 24 04 85 09 00 	movl   $0x985,0x4(%esp)
 12e:	00 
 12f:	89 04 24             	mov    %eax,(%esp)
 132:	e8 79 05 00 00       	call   6b0 <printf>
 137:	e8 fc 03 00 00       	call   538 <exit>
 13c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000140 <start>:
    for (;;)
      sleep(0xFFFF);
}

void start(int thread)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	57                   	push   %edi
 144:	56                   	push   %esi
 145:	31 f6                	xor    %esi,%esi
 147:	53                   	push   %ebx
 148:	83 ec 1c             	sub    $0x1c,%esp
 14b:	90                   	nop    
 14c:	8d 74 26 00          	lea    0x0(%esi),%esi
  int pid[4], i, j, cpid, flag;

  for (i = 0; i < 4; i++) {
    pid[i] = fork();
 150:	e8 db 03 00 00       	call   530 <fork>
    if (pid[i] < 0)
 155:	83 f8 00             	cmp    $0x0,%eax
void start(int thread)
{
  int pid[4], i, j, cpid, flag;

  for (i = 0; i < 4; i++) {
    pid[i] = fork();
 158:	89 c7                	mov    %eax,%edi
    if (pid[i] < 0)
 15a:	0f 8c 9b 00 00 00    	jl     1fb <start+0xbb>
      handle_error("fork() error");
    if (pid[i] == 0)
 160:	74 78                	je     1da <start+0x9a>
void start(int thread)
{
  int pid[4], i, j, cpid, flag;

  for (i = 0; i < 4; i++) {
    pid[i] = fork();
 162:	8d 5d e4             	lea    -0x1c(%ebp),%ebx
 165:	89 3c b3             	mov    %edi,(%ebx,%esi,4)

void start(int thread)
{
  int pid[4], i, j, cpid, flag;

  for (i = 0; i < 4; i++) {
 168:	83 c6 01             	add    $0x1,%esi
 16b:	83 fe 04             	cmp    $0x4,%esi
 16e:	75 e0                	jne    150 <start+0x10>
      handle_error("fork() error");
    if (pid[i] == 0)
      child_process(i % 2, thread);
  }

  sleep(ONE_SEC / 2);
 170:	c7 04 24 32 00 00 00 	movl   $0x32,(%esp)
 177:	66 be 01 00          	mov    $0x1,%si
 17b:	e8 48 04 00 00       	call   5c8 <sleep>

  for (i = 0; i < 4; i++) {
    if (kill(pid[i]) < 0)
 180:	8b 44 b3 fc          	mov    -0x4(%ebx,%esi,4),%eax
 184:	89 04 24             	mov    %eax,(%esp)
 187:	e8 dc 03 00 00       	call   568 <kill>
 18c:	85 c0                	test   %eax,%eax
 18e:	0f 88 89 00 00 00    	js     21d <start+0xdd>
 194:	83 c6 01             	add    $0x1,%esi
      child_process(i % 2, thread);
  }

  sleep(ONE_SEC / 2);

  for (i = 0; i < 4; i++) {
 197:	83 fe 05             	cmp    $0x5,%esi
 19a:	75 e4                	jne    180 <start+0x40>
 19c:	66 31 f6             	xor    %si,%si
 19f:	90                   	nop    
      handle_error("kill() error");
  }

  for (i = 0; i < 4; i++) {
    flag = 0;
    cpid = wait();
 1a0:	e8 9b 03 00 00       	call   540 <wait>
 1a5:	31 c9                	xor    %ecx,%ecx
 1a7:	ba 01 00 00 00       	mov    $0x1,%edx
 1ac:	8d 74 26 00          	lea    0x0(%esi),%esi
    for (j = 0; j < 4; j++) {
      if (cpid == pid[j])
 1b0:	3b 44 93 fc          	cmp    -0x4(%ebx,%edx,4),%eax
 1b4:	74 1d                	je     1d3 <start+0x93>
 1b6:	83 c2 01             	add    $0x1,%edx
  }

  for (i = 0; i < 4; i++) {
    flag = 0;
    cpid = wait();
    for (j = 0; j < 4; j++) {
 1b9:	83 fa 05             	cmp    $0x5,%edx
 1bc:	75 f2                	jne    1b0 <start+0x70>
      if (cpid == pid[j])
        flag = 1;
    }
    if (flag != 1)
 1be:	83 e9 01             	sub    $0x1,%ecx
 1c1:	75 64                	jne    227 <start+0xe7>
  for (i = 0; i < 4; i++) {
    if (kill(pid[i]) < 0)
      handle_error("kill() error");
  }

  for (i = 0; i < 4; i++) {
 1c3:	83 c6 01             	add    $0x1,%esi
 1c6:	83 fe 04             	cmp    $0x4,%esi
 1c9:	75 d5                	jne    1a0 <start+0x60>
        flag = 1;
    }
    if (flag != 1)
      handle_error("wait() error");
  }
}
 1cb:	83 c4 1c             	add    $0x1c,%esp
 1ce:	5b                   	pop    %ebx
 1cf:	5e                   	pop    %esi
 1d0:	5f                   	pop    %edi
 1d1:	5d                   	pop    %ebp
 1d2:	c3                   	ret    

  for (i = 0; i < 4; i++) {
    flag = 0;
    cpid = wait();
    for (j = 0; j < 4; j++) {
      if (cpid == pid[j])
 1d3:	b9 01 00 00 00       	mov    $0x1,%ecx
 1d8:	eb dc                	jmp    1b6 <start+0x76>
  for (i = 0; i < 4; i++) {
    pid[i] = fork();
    if (pid[i] < 0)
      handle_error("fork() error");
    if (pid[i] == 0)
      child_process(i % 2, thread);
 1da:	8b 45 08             	mov    0x8(%ebp),%eax
 1dd:	89 f2                	mov    %esi,%edx
 1df:	c1 ea 1f             	shr    $0x1f,%edx
 1e2:	89 44 24 04          	mov    %eax,0x4(%esp)
 1e6:	8d 04 16             	lea    (%esi,%edx,1),%eax
 1e9:	83 e0 01             	and    $0x1,%eax
 1ec:	29 d0                	sub    %edx,%eax
 1ee:	89 04 24             	mov    %eax,(%esp)
 1f1:	e8 ba fe ff ff       	call   b0 <child_process>
 1f6:	e9 67 ff ff ff       	jmp    162 <start+0x22>
  }
  return 10 * (b - a) <= b;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 1fb:	c7 44 24 08 99 09 00 	movl   $0x999,0x8(%esp)
 202:	00 
 203:	a1 1c 0a 00 00       	mov    0xa1c,%eax
 208:	c7 44 24 04 85 09 00 	movl   $0x985,0x4(%esp)
 20f:	00 
 210:	89 04 24             	mov    %eax,(%esp)
 213:	e8 98 04 00 00       	call   6b0 <printf>
  exit();
 218:	e8 1b 03 00 00       	call   538 <exit>
  }
  return 10 * (b - a) <= b;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 21d:	c7 44 24 08 a6 09 00 	movl   $0x9a6,0x8(%esp)
 224:	00 
 225:	eb dc                	jmp    203 <start+0xc3>
      handle_error("wait() error");
  }
}

int main(int argc, char *argv[])
{
 227:	c7 44 24 08 b4 09 00 	movl   $0x9b4,0x8(%esp)
 22e:	00 
 22f:	eb d2                	jmp    203 <start+0xc3>
 231:	eb 0d                	jmp    240 <main>
 233:	90                   	nop    
 234:	90                   	nop    
 235:	90                   	nop    
 236:	90                   	nop    
 237:	90                   	nop    
 238:	90                   	nop    
 239:	90                   	nop    
 23a:	90                   	nop    
 23b:	90                   	nop    
 23c:	90                   	nop    
 23d:	90                   	nop    
 23e:	90                   	nop    
 23f:	90                   	nop    

00000240 <main>:
 240:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 244:	83 e4 f0             	and    $0xfffffff0,%esp
 247:	ff 71 fc             	pushl  -0x4(%ecx)
 24a:	55                   	push   %ebp
 24b:	89 e5                	mov    %esp,%ebp
 24d:	51                   	push   %ecx
 24e:	83 ec 14             	sub    $0x14,%esp
  char *stack;
  int tid;

  NEW_STACK_THREAD(thread_verify, 0, stack, tid);
 251:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 258:	e8 53 06 00 00       	call   8b0 <malloc>
 25d:	85 c0                	test   %eax,%eax
 25f:	0f 84 87 00 00 00    	je     2ec <main+0xac>
 265:	05 00 10 00 00       	add    $0x1000,%eax
 26a:	89 44 24 08          	mov    %eax,0x8(%esp)
 26e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 275:	00 
 276:	c7 04 24 90 00 00 00 	movl   $0x90,(%esp)
 27d:	e8 66 03 00 00       	call   5e8 <tfork>
 282:	85 c0                	test   %eax,%eax
 284:	78 70                	js     2f6 <main+0xb6>
  WAIT_THREAD(tid, 0);
 286:	89 04 24             	mov    %eax,(%esp)
 289:	e8 6a 03 00 00       	call   5f8 <twait>
 28e:	85 c0                	test   %eax,%eax
 290:	78 6e                	js     300 <main+0xc0>
  if (check != MAGIC_VALUE)
 292:	81 3d 2c 0a 00 00 ef 	cmpl   $0x987cdef,0xa2c
 299:	cd 87 09 
 29c:	75 6c                	jne    30a <main+0xca>
    handle_error("check value error");

  start(0);
 29e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2a5:	e8 96 fe ff ff       	call   140 <start>
  if (pschk() != 3)
 2aa:	e8 29 03 00 00       	call   5d8 <pschk>
 2af:	83 f8 03             	cmp    $0x3,%eax
 2b2:	75 16                	jne    2ca <main+0x8a>
    handle_error("proc status error");
  start(1);
 2b4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2bb:	e8 80 fe ff ff       	call   140 <start>
  if (pschk() != 3)
 2c0:	e8 13 03 00 00       	call   5d8 <pschk>
 2c5:	83 f8 03             	cmp    $0x3,%eax
 2c8:	74 4a                	je     314 <main+0xd4>
 2ca:	c7 44 24 08 d3 09 00 	movl   $0x9d3,0x8(%esp)
 2d1:	00 
  exit();
 2d2:	a1 1c 0a 00 00       	mov    0xa1c,%eax
 2d7:	c7 44 24 04 85 09 00 	movl   $0x985,0x4(%esp)
 2de:	00 
 2df:	89 04 24             	mov    %eax,(%esp)
 2e2:	e8 c9 03 00 00       	call   6b0 <printf>
 2e7:	e8 4c 02 00 00       	call   538 <exit>
  }
  return 10 * (b - a) <= b;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 2ec:	c7 44 24 08 89 09 00 	movl   $0x989,0x8(%esp)
 2f3:	00 
 2f4:	eb dc                	jmp    2d2 <main+0x92>
 2f6:	c7 44 24 08 98 09 00 	movl   $0x998,0x8(%esp)
 2fd:	00 
 2fe:	eb d2                	jmp    2d2 <main+0x92>
    handle_error("proc status error");

  printf(stdout, "hw3-test-kill1 succeeded!\n");
 300:	c7 44 24 08 b3 09 00 	movl   $0x9b3,0x8(%esp)
 307:	00 
 308:	eb c8                	jmp    2d2 <main+0x92>
 30a:	c7 44 24 08 c1 09 00 	movl   $0x9c1,0x8(%esp)
 311:	00 
 312:	eb be                	jmp    2d2 <main+0x92>
 314:	a1 18 0a 00 00       	mov    0xa18,%eax
 319:	c7 44 24 04 e5 09 00 	movl   $0x9e5,0x4(%esp)
 320:	00 
 321:	89 04 24             	mov    %eax,(%esp)
 324:	e8 87 03 00 00       	call   6b0 <printf>
  exit();
 329:	e8 0a 02 00 00       	call   538 <exit>
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

000005d8 <pschk>:
SYSCALL(pschk)
 5d8:	b8 17 00 00 00       	mov    $0x17,%eax
 5dd:	cd 40                	int    $0x40
 5df:	c3                   	ret    

000005e0 <rwlock>:
SYSCALL(rwlock)
 5e0:	b8 16 00 00 00       	mov    $0x16,%eax
 5e5:	cd 40                	int    $0x40
 5e7:	c3                   	ret    

000005e8 <tfork>:
SYSCALL(tfork)
 5e8:	b8 18 00 00 00       	mov    $0x18,%eax
 5ed:	cd 40                	int    $0x40
 5ef:	c3                   	ret    

000005f0 <texit>:
SYSCALL(texit)
 5f0:	b8 19 00 00 00       	mov    $0x19,%eax
 5f5:	cd 40                	int    $0x40
 5f7:	c3                   	ret    

000005f8 <twait>:
SYSCALL(twait)
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
 65d:	0f b6 82 07 0a 00 00 	movzbl 0xa07(%edx),%eax
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
 79b:	b9 00 0a 00 00       	mov    $0xa00,%ecx
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
 831:	8b 0d 28 0a 00 00    	mov    0xa28,%ecx
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
 87d:	89 0d 28 0a 00 00    	mov    %ecx,0xa28
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
 8a5:	89 0d 28 0a 00 00    	mov    %ecx,0xa28
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
 8bc:	8b 15 28 0a 00 00    	mov    0xa28,%edx
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
 8e3:	3b 0d 28 0a 00 00    	cmp    0xa28,%ecx
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
 905:	89 15 28 0a 00 00    	mov    %edx,0xa28
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
 93d:	8b 15 28 0a 00 00    	mov    0xa28,%edx
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
 95d:	ba 20 0a 00 00       	mov    $0xa20,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 962:	c7 05 28 0a 00 00 20 	movl   $0xa20,0xa28
 969:	0a 00 00 
 96c:	c7 05 20 0a 00 00 20 	movl   $0xa20,0xa20
 973:	0a 00 00 
    base.s.size = 0;
 976:	c7 05 24 0a 00 00 00 	movl   $0x0,0xa24
 97d:	00 00 00 
 980:	e9 4e ff ff ff       	jmp    8d3 <malloc+0x23>
