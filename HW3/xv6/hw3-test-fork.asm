
_hw3-test-fork:     file format elf32-i386

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

00000040 <child_func>:

int check;
int thread_check;

void child_func(void)
{
  40:	55                   	push   %ebp
  41:	89 e5                	mov    %esp,%ebp
  43:	83 ec 08             	sub    $0x8,%esp
  check = MAGIC_VALUE;
  46:	c7 05 34 0a 00 00 ef 	movl   $0x987cdef,0xa34
  4d:	cd 87 09 
  exit();
  50:	e8 f3 04 00 00       	call   548 <exit>
  55:	8d 74 26 00          	lea    0x0(%esi),%esi
  59:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000060 <handle_error>:

inline void handle_error(const char *msg) {
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	83 ec 18             	sub    $0x18,%esp
  printf(stderr, "%s\n", msg);
  66:	8b 45 08             	mov    0x8(%ebp),%eax
  69:	c7 44 24 04 95 09 00 	movl   $0x995,0x4(%esp)
  70:	00 
  71:	89 44 24 08          	mov    %eax,0x8(%esp)
  75:	a1 20 0a 00 00       	mov    0xa20,%eax
  7a:	89 04 24             	mov    %eax,(%esp)
  7d:	e8 3e 06 00 00       	call   6c0 <printf>
  exit();
  82:	e8 c1 04 00 00       	call   548 <exit>
  87:	89 f6                	mov    %esi,%esi
  89:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000090 <thread_dude>:
  }
  return pid;
}

void thread_dude(void *arg)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	83 ec 08             	sub    $0x8,%esp
  for (;;)
    sleep(0xFFFF);
  96:	c7 04 24 ff ff 00 00 	movl   $0xffff,(%esp)
  9d:	e8 36 05 00 00       	call   5d8 <sleep>
  a2:	eb f2                	jmp    96 <thread_dude+0x6>
  a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000b0 <thread_wait>:
  pid = forktest(1);
  texit();
}

void thread_wait(void *arg)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	53                   	push   %ebx
  b4:	83 ec 14             	sub    $0x14,%esp
  b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int pid;

  pid = (int)arg;

  if (wait() != pid)
  ba:	e8 91 04 00 00       	call   550 <wait>
  bf:	39 d8                	cmp    %ebx,%eax
  c1:	75 0a                	jne    cd <thread_wait+0x1d>
    handle_error("wait() error");

  texit();
}
  c3:	83 c4 14             	add    $0x14,%esp
  c6:	5b                   	pop    %ebx
  c7:	5d                   	pop    %ebp
  pid = (int)arg;

  if (wait() != pid)
    handle_error("wait() error");

  texit();
  c8:	e9 33 05 00 00       	jmp    600 <texit>
  }
  return 10 * (b - a) <= b;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
  cd:	a1 20 0a 00 00       	mov    0xa20,%eax
  d2:	c7 44 24 08 db 09 00 	movl   $0x9db,0x8(%esp)
  d9:	00 
  da:	c7 44 24 04 95 09 00 	movl   $0x995,0x4(%esp)
  e1:	00 
  e2:	89 04 24             	mov    %eax,(%esp)
  e5:	e8 d6 05 00 00       	call   6c0 <printf>
  exit();
  ea:	e8 59 04 00 00       	call   548 <exit>
  ef:	90                   	nop    

000000f0 <forktest>:
  check = MAGIC_VALUE;
  exit();
}

int forktest(int do_wait)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	53                   	push   %ebx
  f4:	83 ec 14             	sub    $0x14,%esp
  int pid;

  pid = fork();
  f7:	e8 44 04 00 00       	call   540 <fork>
  if (pid < 0)
  fc:	83 f8 00             	cmp    $0x0,%eax

int forktest(int do_wait)
{
  int pid;

  pid = fork();
  ff:	89 c3                	mov    %eax,%ebx
  if (pid < 0)
 101:	7c 54                	jl     157 <forktest+0x67>
    handle_error("fork() error");
  if (pid == 0)
 103:	74 4b                	je     150 <forktest+0x60>
    child_func();
  if (do_wait) {
 105:	8b 45 08             	mov    0x8(%ebp),%eax
 108:	85 c0                	test   %eax,%eax
 10a:	75 08                	jne    114 <forktest+0x24>
      handle_error("wait() error");
    if (check == MAGIC_VALUE)
      handle_error("check value error");
  }
  return pid;
}
 10c:	89 d8                	mov    %ebx,%eax
 10e:	83 c4 14             	add    $0x14,%esp
 111:	5b                   	pop    %ebx
 112:	5d                   	pop    %ebp
 113:	c3                   	ret    
  if (pid < 0)
    handle_error("fork() error");
  if (pid == 0)
    child_func();
  if (do_wait) {
    if (wait() != pid)
 114:	e8 37 04 00 00       	call   550 <wait>
 119:	39 c3                	cmp    %eax,%ebx
 11b:	75 45                	jne    162 <forktest+0x72>
      handle_error("wait() error");
    if (check == MAGIC_VALUE)
 11d:	81 3d 34 0a 00 00 ef 	cmpl   $0x987cdef,0xa34
 124:	cd 87 09 
 127:	75 e3                	jne    10c <forktest+0x1c>
  }
  return 10 * (b - a) <= b;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 129:	c7 44 24 08 99 09 00 	movl   $0x999,0x8(%esp)
 130:	00 
  exit();
 131:	a1 20 0a 00 00       	mov    0xa20,%eax
 136:	c7 44 24 04 95 09 00 	movl   $0x995,0x4(%esp)
 13d:	00 
 13e:	89 04 24             	mov    %eax,(%esp)
 141:	e8 7a 05 00 00       	call   6c0 <printf>
 146:	e8 fd 03 00 00       	call   548 <exit>
 14b:	90                   	nop    
 14c:	8d 74 26 00          	lea    0x0(%esi),%esi

  pid = fork();
  if (pid < 0)
    handle_error("fork() error");
  if (pid == 0)
    child_func();
 150:	e8 eb fe ff ff       	call   40 <child_func>
 155:	eb ae                	jmp    105 <forktest+0x15>
  }
  return 10 * (b - a) <= b;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 157:	c7 44 24 08 cd 09 00 	movl   $0x9cd,0x8(%esp)
 15e:	00 
 15f:	90                   	nop    
 160:	eb cf                	jmp    131 <forktest+0x41>
 162:	c7 44 24 08 db 09 00 	movl   $0x9db,0x8(%esp)
 169:	00 
 16a:	eb c5                	jmp    131 <forktest+0x41>
 16c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000170 <main>:

  texit();
}

int main(int argc, char *argv[])
{
 170:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 174:	83 e4 f0             	and    $0xfffffff0,%esp
 177:	ff 71 fc             	pushl  -0x4(%ecx)
 17a:	55                   	push   %ebp
 17b:	89 e5                	mov    %esp,%ebp
 17d:	53                   	push   %ebx
  exit();
 17e:	31 db                	xor    %ebx,%ebx
 180:	51                   	push   %ecx
 181:	83 ec 10             	sub    $0x10,%esp
  char *stack[N_THREADS], *fstack;
  int tid[N_THREADS], ftid, i;

  forktest(1);
 184:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 18b:	e8 60 ff ff ff       	call   f0 <forktest>

  PROC_CHECK(3);
 190:	e8 53 04 00 00       	call   5e8 <pschk>
 195:	83 f8 03             	cmp    $0x3,%eax
 198:	0f 85 ff 00 00 00    	jne    29d <main+0x12d>
 19e:	66 90                	xchg   %ax,%ax

  for (i = 0; i < N_THREADS; i++)
    NEW_STACK_THREAD(thread_dude, 0, stack[i], tid[i]);
 1a0:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 1a7:	e8 14 07 00 00       	call   8c0 <malloc>
 1ac:	85 c0                	test   %eax,%eax
 1ae:	66 90                	xchg   %ax,%ax
 1b0:	0f 84 09 01 00 00    	je     2bf <main+0x14f>
 1b6:	05 00 10 00 00       	add    $0x1000,%eax
 1bb:	89 44 24 08          	mov    %eax,0x8(%esp)
 1bf:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1c6:	00 
 1c7:	c7 04 24 90 00 00 00 	movl   $0x90,(%esp)
 1ce:	e8 25 04 00 00       	call   5f8 <tfork>
 1d3:	85 c0                	test   %eax,%eax
 1d5:	0f 88 ee 00 00 00    	js     2c9 <main+0x159>

  forktest(1);

  PROC_CHECK(3);

  for (i = 0; i < N_THREADS; i++)
 1db:	83 c3 01             	add    $0x1,%ebx
 1de:	83 fb 30             	cmp    $0x30,%ebx
 1e1:	75 bd                	jne    1a0 <main+0x30>
    NEW_STACK_THREAD(thread_dude, 0, stack[i], tid[i]);
  PROC_CHECK(N_THREADS + 3);
 1e3:	e8 00 04 00 00       	call   5e8 <pschk>
 1e8:	83 f8 33             	cmp    $0x33,%eax
 1eb:	0f 85 ac 00 00 00    	jne    29d <main+0x12d>

  NEW_STACK_THREAD(thread_fork, 0, fstack, ftid);
 1f1:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 1f8:	e8 c3 06 00 00       	call   8c0 <malloc>
 1fd:	85 c0                	test   %eax,%eax
 1ff:	90                   	nop    
 200:	0f 84 b9 00 00 00    	je     2bf <main+0x14f>
 206:	05 00 10 00 00       	add    $0x1000,%eax
 20b:	89 44 24 08          	mov    %eax,0x8(%esp)
 20f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 216:	00 
 217:	c7 04 24 10 03 00 00 	movl   $0x310,(%esp)
 21e:	e8 d5 03 00 00       	call   5f8 <tfork>
 223:	85 c0                	test   %eax,%eax
 225:	0f 88 9e 00 00 00    	js     2c9 <main+0x159>
  WAIT_THREAD(ftid, 0);
 22b:	89 04 24             	mov    %eax,(%esp)
 22e:	e8 d5 03 00 00       	call   608 <twait>
 233:	85 c0                	test   %eax,%eax
 235:	0f 88 98 00 00 00    	js     2d3 <main+0x163>
  if (thread_check != MAGIC_VALUE)
 23b:	81 3d 30 0a 00 00 ef 	cmpl   $0x987cdef,0xa30
 242:	cd 87 09 
 245:	0f 85 92 00 00 00    	jne    2dd <main+0x16d>
    handle_error("check value error");
  NEW_STACK_THREAD(thread_wait, (void *)forktest(0), fstack, ftid);
 24b:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 252:	e8 69 06 00 00       	call   8c0 <malloc>
 257:	85 c0                	test   %eax,%eax
 259:	89 c3                	mov    %eax,%ebx
 25b:	74 62                	je     2bf <main+0x14f>
 25d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 264:	e8 87 fe ff ff       	call   f0 <forktest>
 269:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
 26f:	89 54 24 08          	mov    %edx,0x8(%esp)
 273:	c7 04 24 b0 00 00 00 	movl   $0xb0,(%esp)
 27a:	89 44 24 04          	mov    %eax,0x4(%esp)
 27e:	e8 75 03 00 00       	call   5f8 <tfork>
 283:	85 c0                	test   %eax,%eax
 285:	78 42                	js     2c9 <main+0x159>
  WAIT_THREAD(ftid, 0);
 287:	89 04 24             	mov    %eax,(%esp)
 28a:	e8 79 03 00 00       	call   608 <twait>
 28f:	85 c0                	test   %eax,%eax
 291:	78 40                	js     2d3 <main+0x163>

  PROC_CHECK(N_THREADS + 3);
 293:	e8 50 03 00 00       	call   5e8 <pschk>
 298:	83 f8 33             	cmp    $0x33,%eax
 29b:	74 4a                	je     2e7 <main+0x177>
  }
  return 10 * (b - a) <= b;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 29d:	c7 44 24 08 ab 09 00 	movl   $0x9ab,0x8(%esp)
 2a4:	00 
  exit();
 2a5:	a1 20 0a 00 00       	mov    0xa20,%eax
 2aa:	c7 44 24 04 95 09 00 	movl   $0x995,0x4(%esp)
 2b1:	00 
 2b2:	89 04 24             	mov    %eax,(%esp)
 2b5:	e8 06 04 00 00       	call   6c0 <printf>
 2ba:	e8 89 02 00 00       	call   548 <exit>
  }
  return 10 * (b - a) <= b;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 2bf:	c7 44 24 08 bd 09 00 	movl   $0x9bd,0x8(%esp)
 2c6:	00 
 2c7:	eb dc                	jmp    2a5 <main+0x135>

  printf(stdout, "hw3-test-fork succeeded!\n");
 2c9:	c7 44 24 08 cc 09 00 	movl   $0x9cc,0x8(%esp)
 2d0:	00 
 2d1:	eb d2                	jmp    2a5 <main+0x135>
 2d3:	c7 44 24 08 da 09 00 	movl   $0x9da,0x8(%esp)
 2da:	00 
 2db:	eb c8                	jmp    2a5 <main+0x135>
 2dd:	c7 44 24 08 99 09 00 	movl   $0x999,0x8(%esp)
 2e4:	00 
 2e5:	eb be                	jmp    2a5 <main+0x135>
 2e7:	a1 1c 0a 00 00       	mov    0xa1c,%eax
 2ec:	c7 44 24 04 e8 09 00 	movl   $0x9e8,0x4(%esp)
 2f3:	00 
 2f4:	89 04 24             	mov    %eax,(%esp)
 2f7:	e8 c4 03 00 00       	call   6c0 <printf>

  exit();
 2fc:	e8 47 02 00 00       	call   548 <exit>
 301:	eb 0d                	jmp    310 <thread_fork>
 303:	90                   	nop    
 304:	90                   	nop    
 305:	90                   	nop    
 306:	90                   	nop    
 307:	90                   	nop    
 308:	90                   	nop    
 309:	90                   	nop    
 30a:	90                   	nop    
 30b:	90                   	nop    
 30c:	90                   	nop    
 30d:	90                   	nop    
 30e:	90                   	nop    
 30f:	90                   	nop    

00000310 <thread_fork>:
    sleep(0xFFFF);
  texit();
}

void thread_fork(void *arg)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	83 ec 08             	sub    $0x8,%esp
  int pid;

  thread_check = MAGIC_VALUE;
 316:	c7 05 30 0a 00 00 ef 	movl   $0x987cdef,0xa30
 31d:	cd 87 09 
  pid = forktest(1);
 320:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 327:	e8 c4 fd ff ff       	call   f0 <forktest>
  texit();
}
 32c:	c9                   	leave  
{
  int pid;

  thread_check = MAGIC_VALUE;
  pid = forktest(1);
  texit();
 32d:	e9 ce 02 00 00       	jmp    600 <texit>
 332:	90                   	nop    
 333:	90                   	nop    
 334:	90                   	nop    
 335:	90                   	nop    
 336:	90                   	nop    
 337:	90                   	nop    
 338:	90                   	nop    
 339:	90                   	nop    
 33a:	90                   	nop    
 33b:	90                   	nop    
 33c:	90                   	nop    
 33d:	90                   	nop    
 33e:	90                   	nop    
 33f:	90                   	nop    

00000340 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	53                   	push   %ebx
 344:	8b 5d 08             	mov    0x8(%ebp),%ebx
 347:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 34a:	89 da                	mov    %ebx,%edx
 34c:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 350:	0f b6 01             	movzbl (%ecx),%eax
 353:	83 c1 01             	add    $0x1,%ecx
 356:	88 02                	mov    %al,(%edx)
 358:	83 c2 01             	add    $0x1,%edx
 35b:	84 c0                	test   %al,%al
 35d:	75 f1                	jne    350 <strcpy+0x10>
    ;
  return os;
}
 35f:	89 d8                	mov    %ebx,%eax
 361:	5b                   	pop    %ebx
 362:	5d                   	pop    %ebp
 363:	c3                   	ret    
 364:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 36a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000370 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	8b 4d 08             	mov    0x8(%ebp),%ecx
 376:	53                   	push   %ebx
 377:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 37a:	0f b6 01             	movzbl (%ecx),%eax
 37d:	84 c0                	test   %al,%al
 37f:	74 24                	je     3a5 <strcmp+0x35>
 381:	0f b6 13             	movzbl (%ebx),%edx
 384:	38 d0                	cmp    %dl,%al
 386:	74 12                	je     39a <strcmp+0x2a>
 388:	eb 1e                	jmp    3a8 <strcmp+0x38>
 38a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 390:	0f b6 13             	movzbl (%ebx),%edx
 393:	83 c1 01             	add    $0x1,%ecx
 396:	38 d0                	cmp    %dl,%al
 398:	75 0e                	jne    3a8 <strcmp+0x38>
 39a:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 39e:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3a1:	84 c0                	test   %al,%al
 3a3:	75 eb                	jne    390 <strcmp+0x20>
 3a5:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 3a8:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3a9:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 3ac:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3ad:	0f b6 d2             	movzbl %dl,%edx
 3b0:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 3b2:	c3                   	ret    
 3b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000003c0 <strlen>:

uint
strlen(char *s)
{
 3c0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 3c1:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 3c3:	89 e5                	mov    %esp,%ebp
 3c5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 3c8:	80 39 00             	cmpb   $0x0,(%ecx)
 3cb:	74 0e                	je     3db <strlen+0x1b>
 3cd:	31 d2                	xor    %edx,%edx
 3cf:	90                   	nop    
 3d0:	83 c2 01             	add    $0x1,%edx
 3d3:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
 3d7:	89 d0                	mov    %edx,%eax
 3d9:	75 f5                	jne    3d0 <strlen+0x10>
    ;
  return n;
}
 3db:	5d                   	pop    %ebp
 3dc:	c3                   	ret    
 3dd:	8d 76 00             	lea    0x0(%esi),%esi

000003e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	8b 55 08             	mov    0x8(%ebp),%edx
 3e6:	57                   	push   %edi
 3e7:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ea:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3ed:	89 d7                	mov    %edx,%edi
 3ef:	fc                   	cld    
 3f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3f2:	5f                   	pop    %edi
 3f3:	89 d0                	mov    %edx,%eax
 3f5:	5d                   	pop    %ebp
 3f6:	c3                   	ret    
 3f7:	89 f6                	mov    %esi,%esi
 3f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000400 <strchr>:

char*
strchr(const char *s, char c)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	8b 45 08             	mov    0x8(%ebp),%eax
 406:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 40a:	0f b6 10             	movzbl (%eax),%edx
 40d:	84 d2                	test   %dl,%dl
 40f:	75 0c                	jne    41d <strchr+0x1d>
 411:	eb 11                	jmp    424 <strchr+0x24>
 413:	83 c0 01             	add    $0x1,%eax
 416:	0f b6 10             	movzbl (%eax),%edx
 419:	84 d2                	test   %dl,%dl
 41b:	74 07                	je     424 <strchr+0x24>
    if(*s == c)
 41d:	38 ca                	cmp    %cl,%dl
 41f:	90                   	nop    
 420:	75 f1                	jne    413 <strchr+0x13>
      return (char*) s;
  return 0;
}
 422:	5d                   	pop    %ebp
 423:	c3                   	ret    
 424:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 425:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 427:	c3                   	ret    
 428:	90                   	nop    
 429:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000430 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	8b 4d 08             	mov    0x8(%ebp),%ecx
 436:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 437:	31 db                	xor    %ebx,%ebx
 439:	0f b6 11             	movzbl (%ecx),%edx
 43c:	8d 42 d0             	lea    -0x30(%edx),%eax
 43f:	3c 09                	cmp    $0x9,%al
 441:	77 18                	ja     45b <atoi+0x2b>
    n = n*10 + *s++ - '0';
 443:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 446:	0f be d2             	movsbl %dl,%edx
 449:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 44d:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 451:	83 c1 01             	add    $0x1,%ecx
 454:	8d 42 d0             	lea    -0x30(%edx),%eax
 457:	3c 09                	cmp    $0x9,%al
 459:	76 e8                	jbe    443 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 45b:	89 d8                	mov    %ebx,%eax
 45d:	5b                   	pop    %ebx
 45e:	5d                   	pop    %ebp
 45f:	c3                   	ret    

00000460 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	8b 4d 10             	mov    0x10(%ebp),%ecx
 466:	56                   	push   %esi
 467:	8b 75 08             	mov    0x8(%ebp),%esi
 46a:	53                   	push   %ebx
 46b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 46e:	85 c9                	test   %ecx,%ecx
 470:	7e 10                	jle    482 <memmove+0x22>
 472:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 474:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 478:	88 04 32             	mov    %al,(%edx,%esi,1)
 47b:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 47e:	39 ca                	cmp    %ecx,%edx
 480:	75 f2                	jne    474 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 482:	89 f0                	mov    %esi,%eax
 484:	5b                   	pop    %ebx
 485:	5e                   	pop    %esi
 486:	5d                   	pop    %ebp
 487:	c3                   	ret    
 488:	90                   	nop    
 489:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000490 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 496:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 499:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 49c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 49f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4a4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 4ab:	00 
 4ac:	89 04 24             	mov    %eax,(%esp)
 4af:	e8 d4 00 00 00       	call   588 <open>
  if(fd < 0)
 4b4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4b6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 4b8:	78 19                	js     4d3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 4ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 4bd:	89 1c 24             	mov    %ebx,(%esp)
 4c0:	89 44 24 04          	mov    %eax,0x4(%esp)
 4c4:	e8 d7 00 00 00       	call   5a0 <fstat>
  close(fd);
 4c9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 4cc:	89 c6                	mov    %eax,%esi
  close(fd);
 4ce:	e8 9d 00 00 00       	call   570 <close>
  return r;
}
 4d3:	89 f0                	mov    %esi,%eax
 4d5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 4d8:	8b 75 fc             	mov    -0x4(%ebp),%esi
 4db:	89 ec                	mov    %ebp,%esp
 4dd:	5d                   	pop    %ebp
 4de:	c3                   	ret    
 4df:	90                   	nop    

000004e0 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	56                   	push   %esi
 4e5:	31 f6                	xor    %esi,%esi
 4e7:	53                   	push   %ebx
 4e8:	83 ec 1c             	sub    $0x1c,%esp
 4eb:	8b 7d 08             	mov    0x8(%ebp),%edi
 4ee:	eb 06                	jmp    4f6 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 4f0:	3c 0d                	cmp    $0xd,%al
 4f2:	74 39                	je     52d <gets+0x4d>
 4f4:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4f6:	8d 5e 01             	lea    0x1(%esi),%ebx
 4f9:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 4fc:	7d 31                	jge    52f <gets+0x4f>
    cc = read(0, &c, 1);
 4fe:	8d 45 f3             	lea    -0xd(%ebp),%eax
 501:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 508:	00 
 509:	89 44 24 04          	mov    %eax,0x4(%esp)
 50d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 514:	e8 47 00 00 00       	call   560 <read>
    if(cc < 1)
 519:	85 c0                	test   %eax,%eax
 51b:	7e 12                	jle    52f <gets+0x4f>
      break;
    buf[i++] = c;
 51d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 521:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 525:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 529:	3c 0a                	cmp    $0xa,%al
 52b:	75 c3                	jne    4f0 <gets+0x10>
 52d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 52f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 533:	89 f8                	mov    %edi,%eax
 535:	83 c4 1c             	add    $0x1c,%esp
 538:	5b                   	pop    %ebx
 539:	5e                   	pop    %esi
 53a:	5f                   	pop    %edi
 53b:	5d                   	pop    %ebp
 53c:	c3                   	ret    
 53d:	90                   	nop    
 53e:	90                   	nop    
 53f:	90                   	nop    

00000540 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 540:	b8 01 00 00 00       	mov    $0x1,%eax
 545:	cd 40                	int    $0x40
 547:	c3                   	ret    

00000548 <exit>:
SYSCALL(exit)
 548:	b8 02 00 00 00       	mov    $0x2,%eax
 54d:	cd 40                	int    $0x40
 54f:	c3                   	ret    

00000550 <wait>:
SYSCALL(wait)
 550:	b8 03 00 00 00       	mov    $0x3,%eax
 555:	cd 40                	int    $0x40
 557:	c3                   	ret    

00000558 <pipe>:
SYSCALL(pipe)
 558:	b8 04 00 00 00       	mov    $0x4,%eax
 55d:	cd 40                	int    $0x40
 55f:	c3                   	ret    

00000560 <read>:
SYSCALL(read)
 560:	b8 06 00 00 00       	mov    $0x6,%eax
 565:	cd 40                	int    $0x40
 567:	c3                   	ret    

00000568 <write>:
SYSCALL(write)
 568:	b8 05 00 00 00       	mov    $0x5,%eax
 56d:	cd 40                	int    $0x40
 56f:	c3                   	ret    

00000570 <close>:
SYSCALL(close)
 570:	b8 07 00 00 00       	mov    $0x7,%eax
 575:	cd 40                	int    $0x40
 577:	c3                   	ret    

00000578 <kill>:
SYSCALL(kill)
 578:	b8 08 00 00 00       	mov    $0x8,%eax
 57d:	cd 40                	int    $0x40
 57f:	c3                   	ret    

00000580 <exec>:
SYSCALL(exec)
 580:	b8 09 00 00 00       	mov    $0x9,%eax
 585:	cd 40                	int    $0x40
 587:	c3                   	ret    

00000588 <open>:
SYSCALL(open)
 588:	b8 0a 00 00 00       	mov    $0xa,%eax
 58d:	cd 40                	int    $0x40
 58f:	c3                   	ret    

00000590 <mknod>:
SYSCALL(mknod)
 590:	b8 0b 00 00 00       	mov    $0xb,%eax
 595:	cd 40                	int    $0x40
 597:	c3                   	ret    

00000598 <unlink>:
SYSCALL(unlink)
 598:	b8 0c 00 00 00       	mov    $0xc,%eax
 59d:	cd 40                	int    $0x40
 59f:	c3                   	ret    

000005a0 <fstat>:
SYSCALL(fstat)
 5a0:	b8 0d 00 00 00       	mov    $0xd,%eax
 5a5:	cd 40                	int    $0x40
 5a7:	c3                   	ret    

000005a8 <link>:
SYSCALL(link)
 5a8:	b8 0e 00 00 00       	mov    $0xe,%eax
 5ad:	cd 40                	int    $0x40
 5af:	c3                   	ret    

000005b0 <mkdir>:
SYSCALL(mkdir)
 5b0:	b8 0f 00 00 00       	mov    $0xf,%eax
 5b5:	cd 40                	int    $0x40
 5b7:	c3                   	ret    

000005b8 <chdir>:
SYSCALL(chdir)
 5b8:	b8 10 00 00 00       	mov    $0x10,%eax
 5bd:	cd 40                	int    $0x40
 5bf:	c3                   	ret    

000005c0 <dup>:
SYSCALL(dup)
 5c0:	b8 11 00 00 00       	mov    $0x11,%eax
 5c5:	cd 40                	int    $0x40
 5c7:	c3                   	ret    

000005c8 <getpid>:
SYSCALL(getpid)
 5c8:	b8 12 00 00 00       	mov    $0x12,%eax
 5cd:	cd 40                	int    $0x40
 5cf:	c3                   	ret    

000005d0 <sbrk>:
SYSCALL(sbrk)
 5d0:	b8 13 00 00 00       	mov    $0x13,%eax
 5d5:	cd 40                	int    $0x40
 5d7:	c3                   	ret    

000005d8 <sleep>:
SYSCALL(sleep)
 5d8:	b8 14 00 00 00       	mov    $0x14,%eax
 5dd:	cd 40                	int    $0x40
 5df:	c3                   	ret    

000005e0 <uptime>:
SYSCALL(uptime)
 5e0:	b8 15 00 00 00       	mov    $0x15,%eax
 5e5:	cd 40                	int    $0x40
 5e7:	c3                   	ret    

000005e8 <pschk>:
SYSCALL(pschk)
 5e8:	b8 17 00 00 00       	mov    $0x17,%eax
 5ed:	cd 40                	int    $0x40
 5ef:	c3                   	ret    

000005f0 <rwlock>:
SYSCALL(rwlock)
 5f0:	b8 16 00 00 00       	mov    $0x16,%eax
 5f5:	cd 40                	int    $0x40
 5f7:	c3                   	ret    

000005f8 <tfork>:
SYSCALL(tfork)
 5f8:	b8 18 00 00 00       	mov    $0x18,%eax
 5fd:	cd 40                	int    $0x40
 5ff:	c3                   	ret    

00000600 <texit>:
SYSCALL(texit)
 600:	b8 19 00 00 00       	mov    $0x19,%eax
 605:	cd 40                	int    $0x40
 607:	c3                   	ret    

00000608 <twait>:
SYSCALL(twait)
 608:	b8 1a 00 00 00       	mov    $0x1a,%eax
 60d:	cd 40                	int    $0x40
 60f:	c3                   	ret    

00000610 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 610:	55                   	push   %ebp
 611:	89 e5                	mov    %esp,%ebp
 613:	83 ec 18             	sub    $0x18,%esp
 616:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 619:	8d 55 fc             	lea    -0x4(%ebp),%edx
 61c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 623:	00 
 624:	89 54 24 04          	mov    %edx,0x4(%esp)
 628:	89 04 24             	mov    %eax,(%esp)
 62b:	e8 38 ff ff ff       	call   568 <write>
}
 630:	c9                   	leave  
 631:	c3                   	ret    
 632:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 639:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000640 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	57                   	push   %edi
 644:	56                   	push   %esi
 645:	89 ce                	mov    %ecx,%esi
 647:	53                   	push   %ebx
 648:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 64b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 64e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 651:	85 c9                	test   %ecx,%ecx
 653:	74 04                	je     659 <printint+0x19>
 655:	85 d2                	test   %edx,%edx
 657:	78 54                	js     6ad <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 659:	89 d0                	mov    %edx,%eax
 65b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 662:	31 db                	xor    %ebx,%ebx
 664:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 667:	31 d2                	xor    %edx,%edx
 669:	f7 f6                	div    %esi
 66b:	89 c1                	mov    %eax,%ecx
 66d:	0f b6 82 09 0a 00 00 	movzbl 0xa09(%edx),%eax
 674:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 677:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 67a:	85 c9                	test   %ecx,%ecx
 67c:	89 c8                	mov    %ecx,%eax
 67e:	75 e7                	jne    667 <printint+0x27>
  if(neg)
 680:	8b 45 e0             	mov    -0x20(%ebp),%eax
 683:	85 c0                	test   %eax,%eax
 685:	74 08                	je     68f <printint+0x4f>
    buf[i++] = '-';
 687:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 68c:	83 c3 01             	add    $0x1,%ebx
 68f:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 692:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 696:	83 eb 01             	sub    $0x1,%ebx
 699:	8b 45 dc             	mov    -0x24(%ebp),%eax
 69c:	e8 6f ff ff ff       	call   610 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 6a1:	39 fb                	cmp    %edi,%ebx
 6a3:	75 ed                	jne    692 <printint+0x52>
    putc(fd, buf[i]);
}
 6a5:	83 c4 1c             	add    $0x1c,%esp
 6a8:	5b                   	pop    %ebx
 6a9:	5e                   	pop    %esi
 6aa:	5f                   	pop    %edi
 6ab:	5d                   	pop    %ebp
 6ac:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 6ad:	89 d0                	mov    %edx,%eax
 6af:	f7 d8                	neg    %eax
 6b1:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 6b8:	eb a8                	jmp    662 <printint+0x22>
 6ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000006c0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	57                   	push   %edi
 6c4:	56                   	push   %esi
 6c5:	53                   	push   %ebx
 6c6:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6c9:	8b 55 0c             	mov    0xc(%ebp),%edx
 6cc:	0f b6 02             	movzbl (%edx),%eax
 6cf:	84 c0                	test   %al,%al
 6d1:	0f 84 87 00 00 00    	je     75e <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 6d7:	8d 4d 10             	lea    0x10(%ebp),%ecx
 6da:	31 ff                	xor    %edi,%edi
 6dc:	31 f6                	xor    %esi,%esi
 6de:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 6e1:	eb 18                	jmp    6fb <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 6e3:	83 fb 25             	cmp    $0x25,%ebx
 6e6:	0f 85 7a 00 00 00    	jne    766 <printf+0xa6>
 6ec:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6f0:	83 c7 01             	add    $0x1,%edi
 6f3:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 6f7:	84 c0                	test   %al,%al
 6f9:	74 63                	je     75e <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 6fb:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 6fd:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 700:	74 e1                	je     6e3 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 702:	83 fe 25             	cmp    $0x25,%esi
 705:	75 e9                	jne    6f0 <printf+0x30>
      if(c == 'd'){
 707:	83 fb 64             	cmp    $0x64,%ebx
 70a:	0f 84 f0 00 00 00    	je     800 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 710:	83 fb 78             	cmp    $0x78,%ebx
 713:	74 64                	je     779 <printf+0xb9>
 715:	83 fb 70             	cmp    $0x70,%ebx
 718:	74 5f                	je     779 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 71a:	83 fb 73             	cmp    $0x73,%ebx
 71d:	8d 76 00             	lea    0x0(%esi),%esi
 720:	74 7e                	je     7a0 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 722:	83 fb 63             	cmp    $0x63,%ebx
 725:	0f 84 b9 00 00 00    	je     7e4 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 72b:	83 fb 25             	cmp    $0x25,%ebx
 72e:	66 90                	xchg   %ax,%ax
 730:	0f 84 f2 00 00 00    	je     828 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 736:	8b 45 08             	mov    0x8(%ebp),%eax
 739:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 73e:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 741:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 743:	e8 c8 fe ff ff       	call   610 <putc>
        putc(fd, c);
 748:	8b 45 08             	mov    0x8(%ebp),%eax
 74b:	0f be d3             	movsbl %bl,%edx
 74e:	e8 bd fe ff ff       	call   610 <putc>
 753:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 756:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 75a:	84 c0                	test   %al,%al
 75c:	75 9d                	jne    6fb <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 75e:	83 c4 0c             	add    $0xc,%esp
 761:	5b                   	pop    %ebx
 762:	5e                   	pop    %esi
 763:	5f                   	pop    %edi
 764:	5d                   	pop    %ebp
 765:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 766:	8b 45 08             	mov    0x8(%ebp),%eax
 769:	0f be d3             	movsbl %bl,%edx
 76c:	e8 9f fe ff ff       	call   610 <putc>
 771:	8b 55 0c             	mov    0xc(%ebp),%edx
 774:	e9 77 ff ff ff       	jmp    6f0 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 779:	8b 45 f0             	mov    -0x10(%ebp),%eax
 77c:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 781:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 783:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 78a:	8b 10                	mov    (%eax),%edx
 78c:	8b 45 08             	mov    0x8(%ebp),%eax
 78f:	e8 ac fe ff ff       	call   640 <printint>
 794:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 797:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 79b:	e9 50 ff ff ff       	jmp    6f0 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 7a0:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 7a3:	8b 01                	mov    (%ecx),%eax
        ap++;
 7a5:	83 c1 04             	add    $0x4,%ecx
 7a8:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 7ab:	b9 02 0a 00 00       	mov    $0xa02,%ecx
 7b0:	85 c0                	test   %eax,%eax
 7b2:	75 2c                	jne    7e0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 7b4:	0f b6 01             	movzbl (%ecx),%eax
 7b7:	84 c0                	test   %al,%al
 7b9:	74 1e                	je     7d9 <printf+0x119>
 7bb:	89 cb                	mov    %ecx,%ebx
 7bd:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 7c0:	0f be d0             	movsbl %al,%edx
 7c3:	8b 45 08             	mov    0x8(%ebp),%eax
 7c6:	e8 45 fe ff ff       	call   610 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7cb:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 7cf:	83 c3 01             	add    $0x1,%ebx
 7d2:	84 c0                	test   %al,%al
 7d4:	75 ea                	jne    7c0 <printf+0x100>
 7d6:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 7d9:	31 f6                	xor    %esi,%esi
 7db:	e9 10 ff ff ff       	jmp    6f0 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 7e0:	89 c1                	mov    %eax,%ecx
 7e2:	eb d0                	jmp    7b4 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 7e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 7e7:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 7e9:	0f be 10             	movsbl (%eax),%edx
 7ec:	8b 45 08             	mov    0x8(%ebp),%eax
 7ef:	e8 1c fe ff ff       	call   610 <putc>
 7f4:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 7f7:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 7fb:	e9 f0 fe ff ff       	jmp    6f0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 800:	8b 45 f0             	mov    -0x10(%ebp),%eax
 803:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 808:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 80b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 812:	8b 10                	mov    (%eax),%edx
 814:	8b 45 08             	mov    0x8(%ebp),%eax
 817:	e8 24 fe ff ff       	call   640 <printint>
 81c:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 81f:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 823:	e9 c8 fe ff ff       	jmp    6f0 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 828:	8b 45 08             	mov    0x8(%ebp),%eax
 82b:	ba 25 00 00 00       	mov    $0x25,%edx
 830:	31 f6                	xor    %esi,%esi
 832:	e8 d9 fd ff ff       	call   610 <putc>
 837:	8b 55 0c             	mov    0xc(%ebp),%edx
 83a:	e9 b1 fe ff ff       	jmp    6f0 <printf+0x30>
 83f:	90                   	nop    

00000840 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 840:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 841:	8b 0d 2c 0a 00 00    	mov    0xa2c,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 847:	89 e5                	mov    %esp,%ebp
 849:	56                   	push   %esi
 84a:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 84b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 84e:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 851:	39 d9                	cmp    %ebx,%ecx
 853:	73 18                	jae    86d <free+0x2d>
 855:	8b 11                	mov    (%ecx),%edx
 857:	39 d3                	cmp    %edx,%ebx
 859:	72 17                	jb     872 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 85b:	39 d1                	cmp    %edx,%ecx
 85d:	72 08                	jb     867 <free+0x27>
 85f:	39 d9                	cmp    %ebx,%ecx
 861:	72 0f                	jb     872 <free+0x32>
 863:	39 d3                	cmp    %edx,%ebx
 865:	72 0b                	jb     872 <free+0x32>
 867:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 869:	39 d9                	cmp    %ebx,%ecx
 86b:	72 e8                	jb     855 <free+0x15>
 86d:	8b 11                	mov    (%ecx),%edx
 86f:	90                   	nop    
 870:	eb e9                	jmp    85b <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 872:	8b 73 04             	mov    0x4(%ebx),%esi
 875:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 878:	39 d0                	cmp    %edx,%eax
 87a:	74 18                	je     894 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 87c:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 87e:	8b 51 04             	mov    0x4(%ecx),%edx
 881:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 884:	39 d8                	cmp    %ebx,%eax
 886:	74 20                	je     8a8 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 888:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 88a:	5b                   	pop    %ebx
 88b:	5e                   	pop    %esi
 88c:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 88d:	89 0d 2c 0a 00 00    	mov    %ecx,0xa2c
}
 893:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 894:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 897:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 899:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 89c:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 89f:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 8a1:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 8a4:	39 d8                	cmp    %ebx,%eax
 8a6:	75 e0                	jne    888 <free+0x48>
    p->s.size += bp->s.size;
 8a8:	03 53 04             	add    0x4(%ebx),%edx
 8ab:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 8ae:	8b 13                	mov    (%ebx),%edx
 8b0:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 8b2:	5b                   	pop    %ebx
 8b3:	5e                   	pop    %esi
 8b4:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 8b5:	89 0d 2c 0a 00 00    	mov    %ecx,0xa2c
}
 8bb:	c3                   	ret    
 8bc:	8d 74 26 00          	lea    0x0(%esi),%esi

000008c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8c0:	55                   	push   %ebp
 8c1:	89 e5                	mov    %esp,%ebp
 8c3:	57                   	push   %edi
 8c4:	56                   	push   %esi
 8c5:	53                   	push   %ebx
 8c6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 8cc:	8b 15 2c 0a 00 00    	mov    0xa2c,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8d2:	83 c0 07             	add    $0x7,%eax
 8d5:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 8d8:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8da:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 8dd:	0f 84 8a 00 00 00    	je     96d <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8e3:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 8e5:	8b 41 04             	mov    0x4(%ecx),%eax
 8e8:	39 c3                	cmp    %eax,%ebx
 8ea:	76 1a                	jbe    906 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 8ec:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 8f3:	3b 0d 2c 0a 00 00    	cmp    0xa2c,%ecx
 8f9:	89 ca                	mov    %ecx,%edx
 8fb:	74 29                	je     926 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8fd:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 8ff:	8b 41 04             	mov    0x4(%ecx),%eax
 902:	39 c3                	cmp    %eax,%ebx
 904:	77 ed                	ja     8f3 <malloc+0x33>
      if(p->s.size == nunits)
 906:	39 c3                	cmp    %eax,%ebx
 908:	74 5d                	je     967 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 90a:	29 d8                	sub    %ebx,%eax
 90c:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 90f:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 912:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 915:	89 15 2c 0a 00 00    	mov    %edx,0xa2c
      return (void*) (p + 1);
 91b:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 91e:	83 c4 0c             	add    $0xc,%esp
 921:	5b                   	pop    %ebx
 922:	5e                   	pop    %esi
 923:	5f                   	pop    %edi
 924:	5d                   	pop    %ebp
 925:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 926:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 92c:	89 de                	mov    %ebx,%esi
 92e:	89 f8                	mov    %edi,%eax
 930:	76 29                	jbe    95b <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 932:	89 04 24             	mov    %eax,(%esp)
 935:	e8 96 fc ff ff       	call   5d0 <sbrk>
  if(p == (char*) -1)
 93a:	83 f8 ff             	cmp    $0xffffffff,%eax
 93d:	74 18                	je     957 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 93f:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 942:	83 c0 08             	add    $0x8,%eax
 945:	89 04 24             	mov    %eax,(%esp)
 948:	e8 f3 fe ff ff       	call   840 <free>
  return freep;
 94d:	8b 15 2c 0a 00 00    	mov    0xa2c,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 953:	85 d2                	test   %edx,%edx
 955:	75 a6                	jne    8fd <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 957:	31 c0                	xor    %eax,%eax
 959:	eb c3                	jmp    91e <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 95b:	be 00 10 00 00       	mov    $0x1000,%esi
 960:	b8 00 80 00 00       	mov    $0x8000,%eax
 965:	eb cb                	jmp    932 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 967:	8b 01                	mov    (%ecx),%eax
 969:	89 02                	mov    %eax,(%edx)
 96b:	eb a8                	jmp    915 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 96d:	ba 24 0a 00 00       	mov    $0xa24,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 972:	c7 05 2c 0a 00 00 24 	movl   $0xa24,0xa2c
 979:	0a 00 00 
 97c:	c7 05 24 0a 00 00 24 	movl   $0xa24,0xa24
 983:	0a 00 00 
    base.s.size = 0;
 986:	c7 05 28 0a 00 00 00 	movl   $0x0,0xa28
 98d:	00 00 00 
 990:	e9 4e ff ff ff       	jmp    8e3 <malloc+0x23>
