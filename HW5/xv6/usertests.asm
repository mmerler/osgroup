
_usertests:     file format elf32-i386

Disassembly of section .text:

00000000 <validateint>:
  printf(stdout, "sbrk test OK\n");
}

void
validateint(int *p)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}
       3:	5d                   	pop    %ebp
       4:	c3                   	ret    
       5:	8d 74 26 00          	lea    0x0(%esi),%esi
       9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000010 <opentest>:

// simple file system tests

void
opentest(void)
{
      10:	55                   	push   %ebp
      11:	89 e5                	mov    %esp,%ebp
      13:	83 ec 08             	sub    $0x8,%esp
  int fd;

  printf(stdout, "open test\n");
      16:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
      1b:	c7 44 24 04 38 37 00 	movl   $0x3738,0x4(%esp)
      22:	00 
      23:	89 04 24             	mov    %eax,(%esp)
      26:	e8 35 34 00 00       	call   3460 <printf>
  fd = open("echo", 0);
      2b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
      32:	00 
      33:	c7 04 24 43 37 00 00 	movl   $0x3743,(%esp)
      3a:	e8 09 33 00 00       	call   3348 <open>
  if(fd < 0){
      3f:	85 c0                	test   %eax,%eax
      41:	78 37                	js     7a <opentest+0x6a>
    printf(stdout, "open echo failed!\n");
    exit();
  }
  close(fd);
      43:	89 04 24             	mov    %eax,(%esp)
      46:	e8 e5 32 00 00       	call   3330 <close>
  fd = open("doesnotexist", 0);
      4b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
      52:	00 
      53:	c7 04 24 5b 37 00 00 	movl   $0x375b,(%esp)
      5a:	e8 e9 32 00 00       	call   3348 <open>
  if(fd >= 0){
      5f:	85 c0                	test   %eax,%eax
      61:	79 31                	jns    94 <opentest+0x84>
    printf(stdout, "open doesnotexist succeeded!\n");
    exit();
  }
  printf(stdout, "open test ok\n");
      63:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
      68:	c7 44 24 04 86 37 00 	movl   $0x3786,0x4(%esp)
      6f:	00 
      70:	89 04 24             	mov    %eax,(%esp)
      73:	e8 e8 33 00 00       	call   3460 <printf>
}
      78:	c9                   	leave  
      79:	c3                   	ret    
  int fd;

  printf(stdout, "open test\n");
  fd = open("echo", 0);
  if(fd < 0){
    printf(stdout, "open echo failed!\n");
      7a:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
      7f:	c7 44 24 04 48 37 00 	movl   $0x3748,0x4(%esp)
      86:	00 
      87:	89 04 24             	mov    %eax,(%esp)
      8a:	e8 d1 33 00 00       	call   3460 <printf>
    exit();
      8f:	e8 74 32 00 00       	call   3308 <exit>
  }
  close(fd);
  fd = open("doesnotexist", 0);
  if(fd >= 0){
    printf(stdout, "open doesnotexist succeeded!\n");
      94:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
      99:	c7 44 24 04 68 37 00 	movl   $0x3768,0x4(%esp)
      a0:	00 
      a1:	89 04 24             	mov    %eax,(%esp)
      a4:	e8 b7 33 00 00       	call   3460 <printf>
    exit();
      a9:	e8 5a 32 00 00       	call   3308 <exit>
      ae:	66 90                	xchg   %ax,%ax

000000b0 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
      b0:	55                   	push   %ebp
      b1:	89 e5                	mov    %esp,%ebp
      b3:	53                   	push   %ebx
  int n, pid;

  printf(1, "fork test\n");
      b4:	31 db                	xor    %ebx,%ebx
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
      b6:	83 ec 14             	sub    $0x14,%esp
  int n, pid;

  printf(1, "fork test\n");
      b9:	c7 44 24 04 94 37 00 	movl   $0x3794,0x4(%esp)
      c0:	00 
      c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      c8:	e8 93 33 00 00       	call   3460 <printf>
      cd:	eb 13                	jmp    e2 <forktest+0x32>
      cf:	90                   	nop    

  for(n=0; n<1000; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
      d0:	74 68                	je     13a <forktest+0x8a>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
      d2:	83 c3 01             	add    $0x1,%ebx
      d5:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
      db:	90                   	nop    
      dc:	8d 74 26 00          	lea    0x0(%esi),%esi
      e0:	74 5d                	je     13f <forktest+0x8f>
    pid = fork();
      e2:	e8 19 32 00 00       	call   3300 <fork>
    if(pid < 0)
      e7:	83 f8 00             	cmp    $0x0,%eax
      ea:	7d e4                	jge    d0 <forktest+0x20>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }
  
  for(; n > 0; n--){
      ec:	85 db                	test   %ebx,%ebx
      ee:	66 90                	xchg   %ax,%ax
      f0:	7e 10                	jle    102 <forktest+0x52>
    if(wait() < 0){
      f2:	e8 19 32 00 00       	call   3310 <wait>
      f7:	85 c0                	test   %eax,%eax
      f9:	78 2b                	js     126 <forktest+0x76>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }
  
  for(; n > 0; n--){
      fb:	83 eb 01             	sub    $0x1,%ebx
      fe:	66 90                	xchg   %ax,%ax
     100:	75 f0                	jne    f2 <forktest+0x42>
      printf(1, "wait stopped early\n");
      exit();
    }
  }
  
  if(wait() != -1){
     102:	e8 09 32 00 00       	call   3310 <wait>
     107:	83 c0 01             	add    $0x1,%eax
     10a:	75 4c                	jne    158 <forktest+0xa8>
    printf(1, "wait got too many\n");
    exit();
  }
  
  printf(1, "fork test OK\n");
     10c:	c7 44 24 04 c6 37 00 	movl   $0x37c6,0x4(%esp)
     113:	00 
     114:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     11b:	e8 40 33 00 00       	call   3460 <printf>
}
     120:	83 c4 14             	add    $0x14,%esp
     123:	5b                   	pop    %ebx
     124:	5d                   	pop    %ebp
     125:	c3                   	ret    
    exit();
  }
  
  for(; n > 0; n--){
    if(wait() < 0){
      printf(1, "wait stopped early\n");
     126:	c7 44 24 04 9f 37 00 	movl   $0x379f,0x4(%esp)
     12d:	00 
     12e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     135:	e8 26 33 00 00       	call   3460 <printf>
      exit();
     13a:	e8 c9 31 00 00       	call   3308 <exit>
    if(pid == 0)
      exit();
  }
  
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
     13f:	c7 44 24 04 10 45 00 	movl   $0x4510,0x4(%esp)
     146:	00 
     147:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     14e:	e8 0d 33 00 00       	call   3460 <printf>
  }
  
  for(; n > 0; n--){
    if(wait() < 0){
      printf(1, "wait stopped early\n");
      exit();
     153:	e8 b0 31 00 00       	call   3308 <exit>
    }
  }
  
  if(wait() != -1){
    printf(1, "wait got too many\n");
     158:	c7 44 24 04 b3 37 00 	movl   $0x37b3,0x4(%esp)
     15f:	00 
     160:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     167:	e8 f4 32 00 00       	call   3460 <printf>
    exit();
     16c:	e8 97 31 00 00       	call   3308 <exit>
     171:	eb 0d                	jmp    180 <exitwait>
     173:	90                   	nop    
     174:	90                   	nop    
     175:	90                   	nop    
     176:	90                   	nop    
     177:	90                   	nop    
     178:	90                   	nop    
     179:	90                   	nop    
     17a:	90                   	nop    
     17b:	90                   	nop    
     17c:	90                   	nop    
     17d:	90                   	nop    
     17e:	90                   	nop    
     17f:	90                   	nop    

00000180 <exitwait>:
}

// try to find any races between exit and wait
void
exitwait(void)
{
     180:	55                   	push   %ebp
     181:	89 e5                	mov    %esp,%ebp
     183:	56                   	push   %esi
     184:	31 f6                	xor    %esi,%esi
     186:	53                   	push   %ebx
     187:	83 ec 10             	sub    $0x10,%esp
     18a:	eb 17                	jmp    1a3 <exitwait+0x23>
     18c:	8d 74 26 00          	lea    0x0(%esi),%esi
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
     190:	74 53                	je     1e5 <exitwait+0x65>
      if(wait() != pid){
     192:	e8 79 31 00 00       	call   3310 <wait>
     197:	39 c3                	cmp    %eax,%ebx
     199:	75 2f                	jne    1ca <exitwait+0x4a>
void
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
     19b:	83 c6 01             	add    $0x1,%esi
     19e:	83 fe 64             	cmp    $0x64,%esi
     1a1:	74 47                	je     1ea <exitwait+0x6a>
    pid = fork();
     1a3:	e8 58 31 00 00       	call   3300 <fork>
    if(pid < 0){
     1a8:	83 f8 00             	cmp    $0x0,%eax
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
    pid = fork();
     1ab:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
     1ad:	7d e1                	jge    190 <exitwait+0x10>
      printf(1, "fork failed\n");
     1af:	c7 44 24 04 61 38 00 	movl   $0x3861,0x4(%esp)
     1b6:	00 
     1b7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     1be:	e8 9d 32 00 00       	call   3460 <printf>
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
}
     1c3:	83 c4 10             	add    $0x10,%esp
     1c6:	5b                   	pop    %ebx
     1c7:	5e                   	pop    %esi
     1c8:	5d                   	pop    %ebp
     1c9:	c3                   	ret    
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
      if(wait() != pid){
        printf(1, "wait wrong pid\n");
     1ca:	c7 44 24 04 d4 37 00 	movl   $0x37d4,0x4(%esp)
     1d1:	00 
     1d2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     1d9:	e8 82 32 00 00       	call   3460 <printf>
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
}
     1de:	83 c4 10             	add    $0x10,%esp
     1e1:	5b                   	pop    %ebx
     1e2:	5e                   	pop    %esi
     1e3:	5d                   	pop    %ebp
     1e4:	c3                   	ret    
      if(wait() != pid){
        printf(1, "wait wrong pid\n");
        return;
      }
    } else {
      exit();
     1e5:	e8 1e 31 00 00       	call   3308 <exit>
    }
  }
  printf(1, "exitwait ok\n");
     1ea:	c7 44 24 04 e4 37 00 	movl   $0x37e4,0x4(%esp)
     1f1:	00 
     1f2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     1f9:	e8 62 32 00 00       	call   3460 <printf>
}
     1fe:	83 c4 10             	add    $0x10,%esp
     201:	5b                   	pop    %ebx
     202:	5e                   	pop    %esi
     203:	5d                   	pop    %ebp
     204:	c3                   	ret    
     205:	8d 74 26 00          	lea    0x0(%esi),%esi
     209:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000210 <validatetest>:
      "ebx");
}

void
validatetest(void)
{
     210:	55                   	push   %ebp
     211:	89 e5                	mov    %esp,%ebp
     213:	56                   	push   %esi
  int hi = 1100*1024;

  printf(stdout, "validate test\n");
     214:	31 f6                	xor    %esi,%esi
      "ebx");
}

void
validatetest(void)
{
     216:	53                   	push   %ebx
     217:	83 ec 10             	sub    $0x10,%esp
  int hi = 1100*1024;

  printf(stdout, "validate test\n");
     21a:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
     21f:	c7 44 24 04 f1 37 00 	movl   $0x37f1,0x4(%esp)
     226:	00 
     227:	89 04 24             	mov    %eax,(%esp)
     22a:	e8 31 32 00 00       	call   3460 <printf>
     22f:	eb 48                	jmp    279 <validatetest+0x69>
    if ((pid = fork()) == 0) {
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
      exit();
    }
    sleep(0);
     231:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     238:	e8 5b 31 00 00       	call   3398 <sleep>
    sleep(0);
     23d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     244:	e8 4f 31 00 00       	call   3398 <sleep>
    kill(pid);
     249:	89 1c 24             	mov    %ebx,(%esp)
     24c:	e8 e7 30 00 00       	call   3338 <kill>
    wait();
     251:	e8 ba 30 00 00       	call   3310 <wait>

    // try to crash the kernel by passing in a bad string pointer
    if (link("nosuchfile", (char*)p) != -1) {
     256:	89 74 24 04          	mov    %esi,0x4(%esp)
     25a:	c7 04 24 00 38 00 00 	movl   $0x3800,(%esp)
     261:	e8 02 31 00 00       	call   3368 <link>
     266:	83 c0 01             	add    $0x1,%eax
     269:	75 1e                	jne    289 <validatetest+0x79>
  int hi = 1100*1024;

  printf(stdout, "validate test\n");

  uint p;
  for (p = 0; p <= (uint)hi; p += 4096) {
     26b:	81 c6 00 10 00 00    	add    $0x1000,%esi
     271:	81 fe 00 40 11 00    	cmp    $0x114000,%esi
     277:	74 2a                	je     2a3 <validatetest+0x93>
    int pid;
    if ((pid = fork()) == 0) {
     279:	e8 82 30 00 00       	call   3300 <fork>
     27e:	85 c0                	test   %eax,%eax
     280:	89 c3                	mov    %eax,%ebx
     282:	75 ad                	jne    231 <validatetest+0x21>
    wait();

    // try to crash the kernel by passing in a bad string pointer
    if (link("nosuchfile", (char*)p) != -1) {
      printf(stdout, "link should not succeed\n");
      exit();
     284:	e8 7f 30 00 00       	call   3308 <exit>
    kill(pid);
    wait();

    // try to crash the kernel by passing in a bad string pointer
    if (link("nosuchfile", (char*)p) != -1) {
      printf(stdout, "link should not succeed\n");
     289:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
     28e:	c7 44 24 04 0b 38 00 	movl   $0x380b,0x4(%esp)
     295:	00 
     296:	89 04 24             	mov    %eax,(%esp)
     299:	e8 c2 31 00 00       	call   3460 <printf>
      exit();
     29e:	e8 65 30 00 00       	call   3308 <exit>
    }
  }

  printf(stdout, "validate ok\n");
     2a3:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
     2a8:	c7 44 24 04 24 38 00 	movl   $0x3824,0x4(%esp)
     2af:	00 
     2b0:	89 04 24             	mov    %eax,(%esp)
     2b3:	e8 a8 31 00 00       	call   3460 <printf>
}
     2b8:	83 c4 10             	add    $0x10,%esp
     2bb:	5b                   	pop    %ebx
     2bc:	5e                   	pop    %esi
     2bd:	5d                   	pop    %ebp
     2be:	c3                   	ret    
     2bf:	90                   	nop    

000002c0 <sbrktest>:
  printf(1, "fork test OK\n");
}

void
sbrktest(void)
{
     2c0:	55                   	push   %ebp
     2c1:	89 e5                	mov    %esp,%ebp
     2c3:	57                   	push   %edi
     2c4:	56                   	push   %esi
  char *oldbrk = sbrk(0);

  printf(stdout, "sbrk test\n");

  // can one sbrk() less than a page?
  char *a = sbrk(0);
     2c5:	31 f6                	xor    %esi,%esi
  printf(1, "fork test OK\n");
}

void
sbrktest(void)
{
     2c7:	53                   	push   %ebx
     2c8:	81 ec ac 00 00 00    	sub    $0xac,%esp
  int pid;
  char *oldbrk = sbrk(0);
     2ce:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     2d5:	e8 b6 30 00 00       	call   3390 <sbrk>

  printf(stdout, "sbrk test\n");
     2da:	c7 44 24 04 31 38 00 	movl   $0x3831,0x4(%esp)
     2e1:	00 

void
sbrktest(void)
{
  int pid;
  char *oldbrk = sbrk(0);
     2e2:	89 c7                	mov    %eax,%edi

  printf(stdout, "sbrk test\n");
     2e4:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
     2e9:	89 04 24             	mov    %eax,(%esp)
     2ec:	e8 6f 31 00 00       	call   3460 <printf>

  // can one sbrk() less than a page?
  char *a = sbrk(0);
     2f1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     2f8:	e8 93 30 00 00       	call   3390 <sbrk>
     2fd:	89 c3                	mov    %eax,%ebx
     2ff:	eb 11                	jmp    312 <sbrktest+0x52>
  int i;
  for(i = 0; i < 5000; i++){
     301:	83 c6 01             	add    $0x1,%esi
    char *b = sbrk(1);
    if(b != a){
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
      exit();
    }
    *b = 1;
     304:	c6 03 01             	movb   $0x1,(%ebx)
    a = b + 1;
     307:	83 c3 01             	add    $0x1,%ebx
  printf(stdout, "sbrk test\n");

  // can one sbrk() less than a page?
  char *a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
     30a:	81 fe 88 13 00 00    	cmp    $0x1388,%esi
     310:	74 36                	je     348 <sbrktest+0x88>
    char *b = sbrk(1);
     312:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     319:	e8 72 30 00 00       	call   3390 <sbrk>
    if(b != a){
     31e:	39 c3                	cmp    %eax,%ebx
     320:	74 df                	je     301 <sbrktest+0x41>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
     322:	89 44 24 10          	mov    %eax,0x10(%esp)
     326:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
     32b:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
     32f:	89 74 24 08          	mov    %esi,0x8(%esp)
     333:	c7 44 24 04 3c 38 00 	movl   $0x383c,0x4(%esp)
     33a:	00 
     33b:	89 04 24             	mov    %eax,(%esp)
     33e:	e8 1d 31 00 00       	call   3460 <printf>
      exit();
     343:	e8 c0 2f 00 00       	call   3308 <exit>
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
     348:	e8 b3 2f 00 00       	call   3300 <fork>
  if(pid < 0){
     34d:	85 c0                	test   %eax,%eax
      exit();
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
     34f:	89 c6                	mov    %eax,%esi
  if(pid < 0){
     351:	0f 88 96 02 00 00    	js     5ed <sbrktest+0x32d>
    printf(stdout, "sbrk test fork failed\n");
    exit();
  }
  char *c = sbrk(1);
     357:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     35e:	e8 2d 30 00 00       	call   3390 <sbrk>
  c = sbrk(1);
     363:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     36a:	e8 21 30 00 00       	call   3390 <sbrk>
  if(c != a + 1){
     36f:	8d 53 01             	lea    0x1(%ebx),%edx
     372:	39 d0                	cmp    %edx,%eax
     374:	0f 85 ab 02 00 00    	jne    625 <sbrktest+0x365>
    printf(stdout, "sbrk test failed post-fork\n");
    exit();
  }
  if(pid == 0)
     37a:	85 f6                	test   %esi,%esi
     37c:	0f 84 9e 02 00 00    	je     620 <sbrktest+0x360>
    exit();
  wait();
     382:	e8 89 2f 00 00       	call   3310 <wait>

  // can one allocate the full 640K?
  a = sbrk(0);
     387:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     38e:	e8 fd 2f 00 00       	call   3390 <sbrk>
     393:	89 c3                	mov    %eax,%ebx
  uint amt = (640 * 1024) - (uint) a;
  char *p = sbrk(amt);
     395:	b8 00 00 0a 00       	mov    $0xa0000,%eax
     39a:	29 d8                	sub    %ebx,%eax
     39c:	89 04 24             	mov    %eax,(%esp)
     39f:	e8 ec 2f 00 00       	call   3390 <sbrk>
  if(p != a){
     3a4:	39 c3                	cmp    %eax,%ebx
     3a6:	0f 85 cf 02 00 00    	jne    67b <sbrktest+0x3bb>
    printf(stdout, "sbrk test failed 640K test, p %x a %x\n", p, a);
    exit();
  }
  char *lastaddr = (char *)(640 * 1024 - 1);
  *lastaddr = 99;
     3ac:	c6 05 ff ff 09 00 63 	movb   $0x63,0x9ffff

  // is one forbidden from allocating more than 640K?
  c = sbrk(4096);
     3b3:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
     3ba:	e8 d1 2f 00 00       	call   3390 <sbrk>
  if(c != (char *) 0xffffffff){
     3bf:	83 f8 ff             	cmp    $0xffffffff,%eax
     3c2:	0f 85 3f 02 00 00    	jne    607 <sbrktest+0x347>
    printf(stdout, "sbrk allocated more than 640K, c %x\n", c);
    exit();
  }

  // can one de-allocate?
  a = sbrk(0);
     3c8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     3cf:	e8 bc 2f 00 00       	call   3390 <sbrk>
  c = sbrk(-4096);
     3d4:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
    printf(stdout, "sbrk allocated more than 640K, c %x\n", c);
    exit();
  }

  // can one de-allocate?
  a = sbrk(0);
     3db:	89 c3                	mov    %eax,%ebx
  c = sbrk(-4096);
     3dd:	e8 ae 2f 00 00       	call   3390 <sbrk>
  if(c == (char *) 0xffffffff){
     3e2:	83 c0 01             	add    $0x1,%eax
     3e5:	0f 84 76 02 00 00    	je     661 <sbrktest+0x3a1>
    printf(stdout, "sbrk could not deallocate\n");
    exit();
  }
  c = sbrk(0);
     3eb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     3f2:	e8 99 2f 00 00       	call   3390 <sbrk>
     3f7:	89 c2                	mov    %eax,%edx
  if(c != a - 4096){
     3f9:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
     3ff:	39 c2                	cmp    %eax,%edx
     401:	0f 85 38 02 00 00    	jne    63f <sbrktest+0x37f>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    exit();
  }

  // can one re-allocate that page?
  a = sbrk(0);
     407:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     40e:	e8 7d 2f 00 00       	call   3390 <sbrk>
  c = sbrk(4096);
     413:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    exit();
  }

  // can one re-allocate that page?
  a = sbrk(0);
     41a:	89 c3                	mov    %eax,%ebx
  c = sbrk(4096);
     41c:	e8 6f 2f 00 00       	call   3390 <sbrk>
  if(c != a || sbrk(0) != a + 4096){
     421:	39 c3                	cmp    %eax,%ebx
    exit();
  }

  // can one re-allocate that page?
  a = sbrk(0);
  c = sbrk(4096);
     423:	89 c6                	mov    %eax,%esi
  if(c != a || sbrk(0) != a + 4096){
     425:	75 16                	jne    43d <sbrktest+0x17d>
     427:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     42e:	e8 5d 2f 00 00       	call   3390 <sbrk>
     433:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
     439:	39 d0                	cmp    %edx,%eax
     43b:	74 22                	je     45f <sbrktest+0x19f>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
     43d:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
     442:	89 74 24 0c          	mov    %esi,0xc(%esp)
     446:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     44a:	c7 44 24 04 bc 45 00 	movl   $0x45bc,0x4(%esp)
     451:	00 
     452:	89 04 24             	mov    %eax,(%esp)
     455:	e8 06 30 00 00       	call   3460 <printf>
    exit();
     45a:	e8 a9 2e 00 00       	call   3308 <exit>
  }
  if(*lastaddr == 99){
     45f:	80 3d ff ff 09 00 63 	cmpb   $0x63,0x9ffff
     466:	0f 84 67 01 00 00    	je     5d3 <sbrktest+0x313>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit();
  }

  c = sbrk(4096);
     46c:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  if(c != (char *) 0xffffffff){
    printf(stdout, "sbrk was able to re-allocate beyond 640K, c %x\n", c);
    exit();
     473:	bb 00 00 0a 00       	mov    $0xa0000,%ebx
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit();
  }

  c = sbrk(4096);
     478:	e8 13 2f 00 00       	call   3390 <sbrk>
  if(c != (char *) 0xffffffff){
     47d:	83 f8 ff             	cmp    $0xffffffff,%eax
     480:	0f 85 a9 02 00 00    	jne    72f <sbrktest+0x46f>
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(640*1024); a < (char *)2000000; a += 50000){
    int ppid = getpid();
     486:	e8 fd 2e 00 00       	call   3388 <getpid>
     48b:	89 c6                	mov    %eax,%esi
    int pid = fork();
     48d:	e8 6e 2e 00 00       	call   3300 <fork>
    if(pid < 0){
     492:	83 f8 00             	cmp    $0x0,%eax
     495:	0f 8c 7a 02 00 00    	jl     715 <sbrktest+0x455>
      printf(stdout, "fork failed\n");
      exit();
    }
    if(pid == 0){
     49b:	0f 84 47 02 00 00    	je     6e8 <sbrktest+0x428>
    printf(stdout, "sbrk was able to re-allocate beyond 640K, c %x\n", c);
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(640*1024); a < (char *)2000000; a += 50000){
     4a1:	81 c3 50 c3 00 00    	add    $0xc350,%ebx
    if(pid == 0){
      printf(stdout, "oops could read %x = %x\n", a, *a);
      kill(ppid);
      exit();
    }
    wait();
     4a7:	e8 64 2e 00 00       	call   3310 <wait>
    printf(stdout, "sbrk was able to re-allocate beyond 640K, c %x\n", c);
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(640*1024); a < (char *)2000000; a += 50000){
     4ac:	81 fb 70 99 1e 00    	cmp    $0x1e9970,%ebx
     4b2:	75 d2                	jne    486 <sbrktest+0x1c6>
    wait();
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  sbrk(-(sbrk(0) - oldbrk));
     4b4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  int pids[32];
  int fds[2];
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
     4bb:	be 01 00 00 00       	mov    $0x1,%esi
    wait();
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  sbrk(-(sbrk(0) - oldbrk));
     4c0:	e8 cb 2e 00 00       	call   3390 <sbrk>
     4c5:	89 fa                	mov    %edi,%edx
     4c7:	29 c2                	sub    %eax,%edx
     4c9:	89 14 24             	mov    %edx,(%esp)
     4cc:	e8 bf 2e 00 00       	call   3390 <sbrk>
  int pids[32];
  int fds[2];
  if(pipe(fds) != 0){
     4d1:	8d 45 e8             	lea    -0x18(%ebp),%eax
     4d4:	89 04 24             	mov    %eax,(%esp)
     4d7:	e8 3c 2e 00 00       	call   3318 <pipe>
     4dc:	85 c0                	test   %eax,%eax
     4de:	74 33                	je     513 <sbrktest+0x253>
     4e0:	e9 ea 01 00 00       	jmp    6cf <sbrktest+0x40f>
      write(fds[1], "x", 1);
      // sit around until killed
      for(;;) sleep(1000);
    }
    char scratch;
    if(pids[i] != -1)
     4e5:	83 f8 ff             	cmp    $0xffffffff,%eax
     4e8:	74 1a                	je     504 <sbrktest+0x244>
      read(fds[0], &scratch, 1);
     4ea:	8d 45 f3             	lea    -0xd(%ebp),%eax
     4ed:	89 44 24 04          	mov    %eax,0x4(%esp)
     4f1:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4f4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     4fb:	00 
     4fc:	89 04 24             	mov    %eax,(%esp)
     4ff:	e8 1c 2e 00 00       	call   3320 <read>
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if((pids[i] = fork()) == 0) {
     504:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
     50b:	83 c6 01             	add    $0x1,%esi
  int fds[2];
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
     50e:	83 fe 21             	cmp    $0x21,%esi
     511:	74 4f                	je     562 <sbrktest+0x2a2>
    if((pids[i] = fork()) == 0) {
     513:	e8 e8 2d 00 00       	call   3300 <fork>
     518:	85 c0                	test   %eax,%eax
     51a:	89 c3                	mov    %eax,%ebx
     51c:	75 c7                	jne    4e5 <sbrktest+0x225>
      // allocate the full 640K
      sbrk((640 * 1024) - (uint)sbrk(0));
     51e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     525:	e8 66 2e 00 00       	call   3390 <sbrk>
     52a:	ba 00 00 0a 00       	mov    $0xa0000,%edx
     52f:	29 c2                	sub    %eax,%edx
     531:	89 14 24             	mov    %edx,(%esp)
     534:	e8 57 2e 00 00       	call   3390 <sbrk>
      write(fds[1], "x", 1);
     539:	8b 45 ec             	mov    -0x14(%ebp),%eax
     53c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     543:	00 
     544:	c7 44 24 04 fa 3d 00 	movl   $0x3dfa,0x4(%esp)
     54b:	00 
     54c:	89 04 24             	mov    %eax,(%esp)
     54f:	e8 d4 2d 00 00       	call   3328 <write>
      // sit around until killed
      for(;;) sleep(1000);
     554:	c7 04 24 e8 03 00 00 	movl   $0x3e8,(%esp)
     55b:	e8 38 2e 00 00       	call   3398 <sleep>
     560:	eb f2                	jmp    554 <sbrktest+0x294>
    if(pids[i] != -1)
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
     562:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
     569:	bb 01 00 00 00       	mov    $0x1,%ebx
     56e:	e8 1d 2e 00 00       	call   3390 <sbrk>
     573:	89 c6                	mov    %eax,%esi
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if(pids[i] == -1)
     575:	8b 84 9d 64 ff ff ff 	mov    -0x9c(%ebp,%ebx,4),%eax
     57c:	83 f8 ff             	cmp    $0xffffffff,%eax
     57f:	74 0d                	je     58e <sbrktest+0x2ce>
      continue;
    kill(pids[i]);
     581:	89 04 24             	mov    %eax,(%esp)
     584:	e8 af 2d 00 00       	call   3338 <kill>
    wait();
     589:	e8 82 2d 00 00       	call   3310 <wait>
     58e:	83 c3 01             	add    $0x1,%ebx
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
     591:	83 fb 21             	cmp    $0x21,%ebx
     594:	75 df                	jne    575 <sbrktest+0x2b5>
    if(pids[i] == -1)
      continue;
    kill(pids[i]);
    wait();
  }
  if(c == (char*)0xffffffff) {
     596:	83 c6 01             	add    $0x1,%esi
     599:	0f 84 16 01 00 00    	je     6b5 <sbrktest+0x3f5>
    printf(stdout, "failed sbrk leaked memory\n");
    exit();
  }

  if(sbrk(0) > oldbrk)
     59f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     5a6:	e8 e5 2d 00 00       	call   3390 <sbrk>
     5ab:	39 c7                	cmp    %eax,%edi
     5ad:	0f 82 e7 00 00 00    	jb     69a <sbrktest+0x3da>
    sbrk(-(sbrk(0) - oldbrk));

  printf(stdout, "sbrk test OK\n");
     5b3:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
     5b8:	c7 44 24 04 e8 38 00 	movl   $0x38e8,0x4(%esp)
     5bf:	00 
     5c0:	89 04 24             	mov    %eax,(%esp)
     5c3:	e8 98 2e 00 00       	call   3460 <printf>
}
     5c8:	81 c4 ac 00 00 00    	add    $0xac,%esp
     5ce:	5b                   	pop    %ebx
     5cf:	5e                   	pop    %esi
     5d0:	5f                   	pop    %edi
     5d1:	5d                   	pop    %ebp
     5d2:	c3                   	ret    
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit();
  }
  if(*lastaddr == 99){
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
     5d3:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
     5d8:	c7 44 24 04 e4 45 00 	movl   $0x45e4,0x4(%esp)
     5df:	00 
     5e0:	89 04 24             	mov    %eax,(%esp)
     5e3:	e8 78 2e 00 00       	call   3460 <printf>
    exit();
     5e8:	e8 1b 2d 00 00       	call   3308 <exit>
    *b = 1;
    a = b + 1;
  }
  pid = fork();
  if(pid < 0){
    printf(stdout, "sbrk test fork failed\n");
     5ed:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
     5f2:	c7 44 24 04 57 38 00 	movl   $0x3857,0x4(%esp)
     5f9:	00 
     5fa:	89 04 24             	mov    %eax,(%esp)
     5fd:	e8 5e 2e 00 00       	call   3460 <printf>
    exit();
     602:	e8 01 2d 00 00       	call   3308 <exit>
  *lastaddr = 99;

  // is one forbidden from allocating more than 640K?
  c = sbrk(4096);
  if(c != (char *) 0xffffffff){
    printf(stdout, "sbrk allocated more than 640K, c %x\n", c);
     607:	89 44 24 08          	mov    %eax,0x8(%esp)
     60b:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
     610:	c7 44 24 04 5c 45 00 	movl   $0x455c,0x4(%esp)
     617:	00 
     618:	89 04 24             	mov    %eax,(%esp)
     61b:	e8 40 2e 00 00       	call   3460 <printf>
    exit();
     620:	e8 e3 2c 00 00       	call   3308 <exit>
    exit();
  }
  char *c = sbrk(1);
  c = sbrk(1);
  if(c != a + 1){
    printf(stdout, "sbrk test failed post-fork\n");
     625:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
     62a:	c7 44 24 04 6e 38 00 	movl   $0x386e,0x4(%esp)
     631:	00 
     632:	89 04 24             	mov    %eax,(%esp)
     635:	e8 26 2e 00 00       	call   3460 <printf>
    exit();
     63a:	e8 c9 2c 00 00       	call   3308 <exit>
    printf(stdout, "sbrk could not deallocate\n");
    exit();
  }
  c = sbrk(0);
  if(c != a - 4096){
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
     63f:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
     644:	89 54 24 0c          	mov    %edx,0xc(%esp)
     648:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     64c:	c7 44 24 04 84 45 00 	movl   $0x4584,0x4(%esp)
     653:	00 
     654:	89 04 24             	mov    %eax,(%esp)
     657:	e8 04 2e 00 00       	call   3460 <printf>
    exit();
     65c:	e8 a7 2c 00 00       	call   3308 <exit>

  // can one de-allocate?
  a = sbrk(0);
  c = sbrk(-4096);
  if(c == (char *) 0xffffffff){
    printf(stdout, "sbrk could not deallocate\n");
     661:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
     666:	c7 44 24 04 8a 38 00 	movl   $0x388a,0x4(%esp)
     66d:	00 
     66e:	89 04 24             	mov    %eax,(%esp)
     671:	e8 ea 2d 00 00       	call   3460 <printf>
    exit();
     676:	e8 8d 2c 00 00       	call   3308 <exit>
  // can one allocate the full 640K?
  a = sbrk(0);
  uint amt = (640 * 1024) - (uint) a;
  char *p = sbrk(amt);
  if(p != a){
    printf(stdout, "sbrk test failed 640K test, p %x a %x\n", p, a);
     67b:	89 44 24 08          	mov    %eax,0x8(%esp)
     67f:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
     684:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
     688:	c7 44 24 04 34 45 00 	movl   $0x4534,0x4(%esp)
     68f:	00 
     690:	89 04 24             	mov    %eax,(%esp)
     693:	e8 c8 2d 00 00       	call   3460 <printf>
     698:	eb 86                	jmp    620 <sbrktest+0x360>
    printf(stdout, "failed sbrk leaked memory\n");
    exit();
  }

  if(sbrk(0) > oldbrk)
    sbrk(-(sbrk(0) - oldbrk));
     69a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     6a1:	e8 ea 2c 00 00       	call   3390 <sbrk>
     6a6:	29 c7                	sub    %eax,%edi
     6a8:	89 3c 24             	mov    %edi,(%esp)
     6ab:	e8 e0 2c 00 00       	call   3390 <sbrk>
     6b0:	e9 fe fe ff ff       	jmp    5b3 <sbrktest+0x2f3>
      continue;
    kill(pids[i]);
    wait();
  }
  if(c == (char*)0xffffffff) {
    printf(stdout, "failed sbrk leaked memory\n");
     6b5:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
     6ba:	c7 44 24 04 cd 38 00 	movl   $0x38cd,0x4(%esp)
     6c1:	00 
     6c2:	89 04 24             	mov    %eax,(%esp)
     6c5:	e8 96 2d 00 00       	call   3460 <printf>
    exit();
     6ca:	e8 39 2c 00 00       	call   3308 <exit>
  // failed allocation?
  sbrk(-(sbrk(0) - oldbrk));
  int pids[32];
  int fds[2];
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
     6cf:	c7 44 24 04 be 38 00 	movl   $0x38be,0x4(%esp)
     6d6:	00 
     6d7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     6de:	e8 7d 2d 00 00       	call   3460 <printf>
    exit();
     6e3:	e8 20 2c 00 00       	call   3308 <exit>
    if(pid < 0){
      printf(stdout, "fork failed\n");
      exit();
    }
    if(pid == 0){
      printf(stdout, "oops could read %x = %x\n", a, *a);
     6e8:	0f be 03             	movsbl (%ebx),%eax
     6eb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     6ef:	c7 44 24 04 a5 38 00 	movl   $0x38a5,0x4(%esp)
     6f6:	00 
     6f7:	89 44 24 0c          	mov    %eax,0xc(%esp)
     6fb:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
     700:	89 04 24             	mov    %eax,(%esp)
     703:	e8 58 2d 00 00       	call   3460 <printf>
      kill(ppid);
     708:	89 34 24             	mov    %esi,(%esp)
     70b:	e8 28 2c 00 00       	call   3338 <kill>
      exit();
     710:	e8 f3 2b 00 00       	call   3308 <exit>
  // can we read the kernel's memory?
  for(a = (char*)(640*1024); a < (char *)2000000; a += 50000){
    int ppid = getpid();
    int pid = fork();
    if(pid < 0){
      printf(stdout, "fork failed\n");
     715:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
     71a:	c7 44 24 04 61 38 00 	movl   $0x3861,0x4(%esp)
     721:	00 
     722:	89 04 24             	mov    %eax,(%esp)
     725:	e8 36 2d 00 00       	call   3460 <printf>
      exit();
     72a:	e8 d9 2b 00 00       	call   3308 <exit>
    exit();
  }

  c = sbrk(4096);
  if(c != (char *) 0xffffffff){
    printf(stdout, "sbrk was able to re-allocate beyond 640K, c %x\n", c);
     72f:	89 44 24 08          	mov    %eax,0x8(%esp)
     733:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
     738:	c7 44 24 04 14 46 00 	movl   $0x4614,0x4(%esp)
     73f:	00 
     740:	89 04 24             	mov    %eax,(%esp)
     743:	e8 18 2d 00 00       	call   3460 <printf>
    exit();
     748:	e8 bb 2b 00 00       	call   3308 <exit>
     74d:	8d 76 00             	lea    0x0(%esi),%esi

00000750 <preempt>:
}

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     750:	55                   	push   %ebp
     751:	89 e5                	mov    %esp,%ebp
     753:	57                   	push   %edi
     754:	56                   	push   %esi
     755:	53                   	push   %ebx
     756:	83 ec 1c             	sub    $0x1c,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
     759:	c7 44 24 04 f6 38 00 	movl   $0x38f6,0x4(%esp)
     760:	00 
     761:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     768:	e8 f3 2c 00 00       	call   3460 <printf>
  pid1 = fork();
     76d:	e8 8e 2b 00 00       	call   3300 <fork>
  if(pid1 == 0)
     772:	85 c0                	test   %eax,%eax
{
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
  pid1 = fork();
     774:	89 c7                	mov    %eax,%edi
  if(pid1 == 0)
     776:	75 02                	jne    77a <preempt+0x2a>
     778:	eb fe                	jmp    778 <preempt+0x28>
     77a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for(;;)
      ;

  pid2 = fork();
     780:	e8 7b 2b 00 00       	call   3300 <fork>
  if(pid2 == 0)
     785:	85 c0                	test   %eax,%eax
  pid1 = fork();
  if(pid1 == 0)
    for(;;)
      ;

  pid2 = fork();
     787:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
     789:	75 02                	jne    78d <preempt+0x3d>
     78b:	eb fe                	jmp    78b <preempt+0x3b>
    for(;;)
      ;

  pipe(pfds);
     78d:	8d 45 ec             	lea    -0x14(%ebp),%eax
     790:	89 04 24             	mov    %eax,(%esp)
     793:	e8 80 2b 00 00       	call   3318 <pipe>
  pid3 = fork();
     798:	e8 63 2b 00 00       	call   3300 <fork>
  if(pid3 == 0){
     79d:	85 c0                	test   %eax,%eax
  if(pid2 == 0)
    for(;;)
      ;

  pipe(pfds);
  pid3 = fork();
     79f:	89 c3                	mov    %eax,%ebx
  if(pid3 == 0){
     7a1:	75 4c                	jne    7ef <preempt+0x9f>
    close(pfds[0]);
     7a3:	8b 45 ec             	mov    -0x14(%ebp),%eax
     7a6:	89 04 24             	mov    %eax,(%esp)
     7a9:	e8 82 2b 00 00       	call   3330 <close>
    if(write(pfds[1], "x", 1) != 1)
     7ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7b1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     7b8:	00 
     7b9:	c7 44 24 04 fa 3d 00 	movl   $0x3dfa,0x4(%esp)
     7c0:	00 
     7c1:	89 04 24             	mov    %eax,(%esp)
     7c4:	e8 5f 2b 00 00       	call   3328 <write>
     7c9:	83 e8 01             	sub    $0x1,%eax
     7cc:	74 14                	je     7e2 <preempt+0x92>
      printf(1, "preempt write error");
     7ce:	c7 44 24 04 00 39 00 	movl   $0x3900,0x4(%esp)
     7d5:	00 
     7d6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     7dd:	e8 7e 2c 00 00       	call   3460 <printf>
    close(pfds[1]);
     7e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7e5:	89 04 24             	mov    %eax,(%esp)
     7e8:	e8 43 2b 00 00       	call   3330 <close>
     7ed:	eb fe                	jmp    7ed <preempt+0x9d>
    for(;;)
      ;
  }

  close(pfds[1]);
     7ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7f2:	89 04 24             	mov    %eax,(%esp)
     7f5:	e8 36 2b 00 00       	call   3330 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     7fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
     7fd:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
     804:	00 
     805:	c7 44 24 04 e0 4b 00 	movl   $0x4be0,0x4(%esp)
     80c:	00 
     80d:	89 04 24             	mov    %eax,(%esp)
     810:	e8 0b 2b 00 00       	call   3320 <read>
     815:	83 e8 01             	sub    $0x1,%eax
     818:	74 1c                	je     836 <preempt+0xe6>
    printf(1, "preempt read error");
     81a:	c7 44 24 04 14 39 00 	movl   $0x3914,0x4(%esp)
     821:	00 
     822:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     829:	e8 32 2c 00 00       	call   3460 <printf>
  printf(1, "wait... ");
  wait();
  wait();
  wait();
  printf(1, "preempt ok\n");
}
     82e:	83 c4 1c             	add    $0x1c,%esp
     831:	5b                   	pop    %ebx
     832:	5e                   	pop    %esi
     833:	5f                   	pop    %edi
     834:	5d                   	pop    %ebp
     835:	c3                   	ret    
  close(pfds[1]);
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    printf(1, "preempt read error");
    return;
  }
  close(pfds[0]);
     836:	8b 45 ec             	mov    -0x14(%ebp),%eax
     839:	89 04 24             	mov    %eax,(%esp)
     83c:	e8 ef 2a 00 00       	call   3330 <close>
  printf(1, "kill... ");
     841:	c7 44 24 04 27 39 00 	movl   $0x3927,0x4(%esp)
     848:	00 
     849:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     850:	e8 0b 2c 00 00       	call   3460 <printf>
  kill(pid1);
     855:	89 3c 24             	mov    %edi,(%esp)
     858:	e8 db 2a 00 00       	call   3338 <kill>
  kill(pid2);
     85d:	89 34 24             	mov    %esi,(%esp)
     860:	e8 d3 2a 00 00       	call   3338 <kill>
  kill(pid3);
     865:	89 1c 24             	mov    %ebx,(%esp)
     868:	e8 cb 2a 00 00       	call   3338 <kill>
  printf(1, "wait... ");
     86d:	c7 44 24 04 30 39 00 	movl   $0x3930,0x4(%esp)
     874:	00 
     875:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     87c:	e8 df 2b 00 00       	call   3460 <printf>
  wait();
     881:	e8 8a 2a 00 00       	call   3310 <wait>
  wait();
     886:	e8 85 2a 00 00       	call   3310 <wait>
     88b:	90                   	nop    
     88c:	8d 74 26 00          	lea    0x0(%esi),%esi
  wait();
     890:	e8 7b 2a 00 00       	call   3310 <wait>
  printf(1, "preempt ok\n");
     895:	c7 44 24 04 39 39 00 	movl   $0x3939,0x4(%esp)
     89c:	00 
     89d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     8a4:	e8 b7 2b 00 00       	call   3460 <printf>
     8a9:	eb 83                	jmp    82e <preempt+0xde>
     8ab:	90                   	nop    
     8ac:	8d 74 26 00          	lea    0x0(%esi),%esi

000008b0 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     8b0:	55                   	push   %ebp
     8b1:	89 e5                	mov    %esp,%ebp
     8b3:	57                   	push   %edi
     8b4:	56                   	push   %esi
     8b5:	53                   	push   %ebx
     8b6:	83 ec 1c             	sub    $0x1c,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     8b9:	8d 45 ec             	lea    -0x14(%ebp),%eax
     8bc:	89 04 24             	mov    %eax,(%esp)
     8bf:	e8 54 2a 00 00       	call   3318 <pipe>
     8c4:	85 c0                	test   %eax,%eax
     8c6:	0f 85 53 01 00 00    	jne    a1f <pipe1+0x16f>
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork();
     8cc:	e8 2f 2a 00 00       	call   3300 <fork>
  seq = 0;
  if(pid == 0){
     8d1:	83 f8 00             	cmp    $0x0,%eax
     8d4:	74 7c                	je     952 <pipe1+0xa2>
        printf(1, "pipe1 oops 1\n");
        exit();
      }
    }
    exit();
  } else if(pid > 0){
     8d6:	0f 8e 5c 01 00 00    	jle    a38 <pipe1+0x188>
    close(fds[1]);
     8dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8df:	be 01 00 00 00       	mov    $0x1,%esi
     8e4:	31 ff                	xor    %edi,%edi
     8e6:	31 db                	xor    %ebx,%ebx
     8e8:	89 04 24             	mov    %eax,(%esp)
     8eb:	e8 40 2a 00 00       	call   3330 <close>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
     8f0:	89 74 24 08          	mov    %esi,0x8(%esp)
     8f4:	c7 44 24 04 e0 4b 00 	movl   $0x4be0,0x4(%esp)
     8fb:	00 
     8fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
     8ff:	89 04 24             	mov    %eax,(%esp)
     902:	e8 19 2a 00 00       	call   3320 <read>
     907:	85 c0                	test   %eax,%eax
     909:	0f 8e aa 00 00 00    	jle    9b9 <pipe1+0x109>
     90f:	31 d2                	xor    %edx,%edx
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     911:	38 9a e0 4b 00 00    	cmp    %bl,0x4be0(%edx)
     917:	75 1d                	jne    936 <pipe1+0x86>
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
     919:	83 c2 01             	add    $0x1,%edx
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     91c:	83 c3 01             	add    $0x1,%ebx
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
     91f:	39 c2                	cmp    %eax,%edx
     921:	75 ee                	jne    911 <pipe1+0x61>
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
      cc = cc * 2;
     923:	01 f6                	add    %esi,%esi
      if(cc > sizeof(buf))
     925:	81 fe 00 08 00 00    	cmp    $0x800,%esi
     92b:	76 05                	jbe    932 <pipe1+0x82>
     92d:	be 00 08 00 00       	mov    $0x800,%esi
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
     932:	01 c7                	add    %eax,%edi
     934:	eb ba                	jmp    8f0 <pipe1+0x40>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
     936:	c7 44 24 04 53 39 00 	movl   $0x3953,0x4(%esp)
     93d:	00 
     93e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     945:	e8 16 2b 00 00       	call   3460 <printf>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
}
     94a:	83 c4 1c             	add    $0x1c,%esp
     94d:	5b                   	pop    %ebx
     94e:	5e                   	pop    %esi
     94f:	5f                   	pop    %edi
     950:	5d                   	pop    %ebp
     951:	c3                   	ret    
    exit();
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
     952:	8b 45 ec             	mov    -0x14(%ebp),%eax
     955:	31 db                	xor    %ebx,%ebx
     957:	89 04 24             	mov    %eax,(%esp)
     95a:	e8 d1 29 00 00       	call   3330 <close>
      printf(1, "pipe1 oops 3 total %d\n", total);
    close(fds[0]);
    wait();
  } else {
    printf(1, "fork() failed\n");
    exit();
     95f:	89 d9                	mov    %ebx,%ecx
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
     961:	ba 01 00 00 00       	mov    $0x1,%edx
     966:	88 1d e0 4b 00 00    	mov    %bl,0x4be0
     96c:	8d 74 26 00          	lea    0x0(%esi),%esi
     970:	8d 04 11             	lea    (%ecx,%edx,1),%eax
     973:	88 82 e0 4b 00 00    	mov    %al,0x4be0(%edx)
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
     979:	83 c2 01             	add    $0x1,%edx
     97c:	81 fa 09 04 00 00    	cmp    $0x409,%edx
     982:	75 ec                	jne    970 <pipe1+0xc0>
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
     984:	c7 44 24 08 09 04 00 	movl   $0x409,0x8(%esp)
     98b:	00 
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
     98c:	81 c3 09 04 00 00    	add    $0x409,%ebx
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
     992:	c7 44 24 04 e0 4b 00 	movl   $0x4be0,0x4(%esp)
     999:	00 
     99a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     99d:	89 04 24             	mov    %eax,(%esp)
     9a0:	e8 83 29 00 00       	call   3328 <write>
     9a5:	3d 09 04 00 00       	cmp    $0x409,%eax
     9aa:	75 5a                	jne    a06 <pipe1+0x156>
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
     9ac:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
     9b2:	75 ab                	jne    95f <pipe1+0xaf>
      printf(1, "pipe1 oops 3 total %d\n", total);
    close(fds[0]);
    wait();
  } else {
    printf(1, "fork() failed\n");
    exit();
     9b4:	e8 4f 29 00 00       	call   3308 <exit>
      total += n;
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033)
     9b9:	81 ff 2d 14 00 00    	cmp    $0x142d,%edi
     9bf:	90                   	nop    
     9c0:	74 18                	je     9da <pipe1+0x12a>
      printf(1, "pipe1 oops 3 total %d\n", total);
     9c2:	89 7c 24 08          	mov    %edi,0x8(%esp)
     9c6:	c7 44 24 04 61 39 00 	movl   $0x3961,0x4(%esp)
     9cd:	00 
     9ce:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     9d5:	e8 86 2a 00 00       	call   3460 <printf>
    close(fds[0]);
     9da:	8b 45 ec             	mov    -0x14(%ebp),%eax
     9dd:	89 04 24             	mov    %eax,(%esp)
     9e0:	e8 4b 29 00 00       	call   3330 <close>
    wait();
     9e5:	e8 26 29 00 00       	call   3310 <wait>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
     9ea:	c7 44 24 04 78 39 00 	movl   $0x3978,0x4(%esp)
     9f1:	00 
     9f2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     9f9:	e8 62 2a 00 00       	call   3460 <printf>
}
     9fe:	83 c4 1c             	add    $0x1c,%esp
     a01:	5b                   	pop    %ebx
     a02:	5e                   	pop    %esi
     a03:	5f                   	pop    %edi
     a04:	5d                   	pop    %ebp
     a05:	c3                   	ret    
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
        printf(1, "pipe1 oops 1\n");
     a06:	c7 44 24 04 45 39 00 	movl   $0x3945,0x4(%esp)
     a0d:	00 
     a0e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a15:	e8 46 2a 00 00       	call   3460 <printf>
        exit();
     a1a:	e8 e9 28 00 00       	call   3308 <exit>
{
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
     a1f:	c7 44 24 04 be 38 00 	movl   $0x38be,0x4(%esp)
     a26:	00 
     a27:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a2e:	e8 2d 2a 00 00       	call   3460 <printf>
    exit();
     a33:	e8 d0 28 00 00       	call   3308 <exit>
    if(total != 5 * 1033)
      printf(1, "pipe1 oops 3 total %d\n", total);
    close(fds[0]);
    wait();
  } else {
    printf(1, "fork() failed\n");
     a38:	c7 44 24 04 82 39 00 	movl   $0x3982,0x4(%esp)
     a3f:	00 
     a40:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a47:	e8 14 2a 00 00       	call   3460 <printf>
     a4c:	e9 63 ff ff ff       	jmp    9b4 <pipe1+0x104>
     a51:	eb 0d                	jmp    a60 <fourteen>
     a53:	90                   	nop    
     a54:	90                   	nop    
     a55:	90                   	nop    
     a56:	90                   	nop    
     a57:	90                   	nop    
     a58:	90                   	nop    
     a59:	90                   	nop    
     a5a:	90                   	nop    
     a5b:	90                   	nop    
     a5c:	90                   	nop    
     a5d:	90                   	nop    
     a5e:	90                   	nop    
     a5f:	90                   	nop    

00000a60 <fourteen>:
  printf(1, "bigfile test ok\n");
}

void
fourteen(void)
{
     a60:	55                   	push   %ebp
     a61:	89 e5                	mov    %esp,%ebp
     a63:	83 ec 08             	sub    $0x8,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
     a66:	c7 44 24 04 91 39 00 	movl   $0x3991,0x4(%esp)
     a6d:	00 
     a6e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a75:	e8 e6 29 00 00       	call   3460 <printf>

  if(mkdir("12345678901234") != 0){
     a7a:	c7 04 24 cc 39 00 00 	movl   $0x39cc,(%esp)
     a81:	e8 ea 28 00 00       	call   3370 <mkdir>
     a86:	85 c0                	test   %eax,%eax
     a88:	0f 85 9a 00 00 00    	jne    b28 <fourteen+0xc8>
    printf(1, "mkdir 12345678901234 failed\n");
    exit();
  }
  if(mkdir("12345678901234/123456789012345") != 0){
     a8e:	c7 04 24 44 46 00 00 	movl   $0x4644,(%esp)
     a95:	e8 d6 28 00 00       	call   3370 <mkdir>
     a9a:	85 c0                	test   %eax,%eax
     a9c:	0f 85 9f 00 00 00    	jne    b41 <fourteen+0xe1>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit();
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
     aa2:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
     aa9:	00 
     aaa:	c7 04 24 94 46 00 00 	movl   $0x4694,(%esp)
     ab1:	e8 92 28 00 00       	call   3348 <open>
  if(fd < 0){
     ab6:	85 c0                	test   %eax,%eax
     ab8:	0f 88 9c 00 00 00    	js     b5a <fourteen+0xfa>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    exit();
  }
  close(fd);
     abe:	89 04 24             	mov    %eax,(%esp)
     ac1:	e8 6a 28 00 00       	call   3330 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
     ac6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     acd:	00 
     ace:	c7 04 24 04 47 00 00 	movl   $0x4704,(%esp)
     ad5:	e8 6e 28 00 00       	call   3348 <open>
  if(fd < 0){
     ada:	85 c0                	test   %eax,%eax
     adc:	0f 88 91 00 00 00    	js     b73 <fourteen+0x113>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    exit();
  }
  close(fd);
     ae2:	89 04 24             	mov    %eax,(%esp)
     ae5:	e8 46 28 00 00       	call   3330 <close>

  if(mkdir("12345678901234/12345678901234") == 0){
     aea:	c7 04 24 bd 39 00 00 	movl   $0x39bd,(%esp)
     af1:	e8 7a 28 00 00       	call   3370 <mkdir>
     af6:	85 c0                	test   %eax,%eax
     af8:	0f 84 8e 00 00 00    	je     b8c <fourteen+0x12c>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit();
  }
  if(mkdir("123456789012345/12345678901234") == 0){
     afe:	c7 04 24 a0 47 00 00 	movl   $0x47a0,(%esp)
     b05:	e8 66 28 00 00       	call   3370 <mkdir>
     b0a:	85 c0                	test   %eax,%eax
     b0c:	0f 84 93 00 00 00    	je     ba5 <fourteen+0x145>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    exit();
  }

  printf(1, "fourteen ok\n");
     b12:	c7 44 24 04 db 39 00 	movl   $0x39db,0x4(%esp)
     b19:	00 
     b1a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b21:	e8 3a 29 00 00       	call   3460 <printf>
}
     b26:	c9                   	leave  
     b27:	c3                   	ret    

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");

  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
     b28:	c7 44 24 04 a0 39 00 	movl   $0x39a0,0x4(%esp)
     b2f:	00 
     b30:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b37:	e8 24 29 00 00       	call   3460 <printf>
    exit();
     b3c:	e8 c7 27 00 00       	call   3308 <exit>
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
     b41:	c7 44 24 04 64 46 00 	movl   $0x4664,0x4(%esp)
     b48:	00 
     b49:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b50:	e8 0b 29 00 00       	call   3460 <printf>
    exit();
     b55:	e8 ae 27 00 00       	call   3308 <exit>
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
  if(fd < 0){
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
     b5a:	c7 44 24 04 c4 46 00 	movl   $0x46c4,0x4(%esp)
     b61:	00 
     b62:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b69:	e8 f2 28 00 00       	call   3460 <printf>
    exit();
     b6e:	e8 95 27 00 00       	call   3308 <exit>
  }
  close(fd);
  fd = open("12345678901234/12345678901234/12345678901234", 0);
  if(fd < 0){
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
     b73:	c7 44 24 04 34 47 00 	movl   $0x4734,0x4(%esp)
     b7a:	00 
     b7b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b82:	e8 d9 28 00 00       	call   3460 <printf>
    exit();
     b87:	e8 7c 27 00 00       	call   3308 <exit>
  }
  close(fd);

  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
     b8c:	c7 44 24 04 70 47 00 	movl   $0x4770,0x4(%esp)
     b93:	00 
     b94:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b9b:	e8 c0 28 00 00       	call   3460 <printf>
    exit();
     ba0:	e8 63 27 00 00       	call   3308 <exit>
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
     ba5:	c7 44 24 04 c0 47 00 	movl   $0x47c0,0x4(%esp)
     bac:	00 
     bad:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     bb4:	e8 a7 28 00 00       	call   3460 <printf>
    exit();
     bb9:	e8 4a 27 00 00       	call   3308 <exit>
     bbe:	66 90                	xchg   %ax,%ax

00000bc0 <iref>:
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
     bc0:	55                   	push   %ebp
     bc1:	89 e5                	mov    %esp,%ebp
     bc3:	53                   	push   %ebx
  int i, fd;

  printf(1, "empty file name\n");
     bc4:	31 db                	xor    %ebx,%ebx
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
     bc6:	83 ec 14             	sub    $0x14,%esp
  int i, fd;

  printf(1, "empty file name\n");
     bc9:	c7 44 24 04 e8 39 00 	movl   $0x39e8,0x4(%esp)
     bd0:	00 
     bd1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     bd8:	e8 83 28 00 00       	call   3460 <printf>
     bdd:	8d 76 00             	lea    0x0(%esi),%esi

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
     be0:	c7 04 24 f9 39 00 00 	movl   $0x39f9,(%esp)
     be7:	e8 84 27 00 00       	call   3370 <mkdir>
     bec:	85 c0                	test   %eax,%eax
     bee:	0f 85 b2 00 00 00    	jne    ca6 <iref+0xe6>
      printf(1, "mkdir irefd failed\n");
      exit();
    }
    if(chdir("irefd") != 0){
     bf4:	c7 04 24 f9 39 00 00 	movl   $0x39f9,(%esp)
     bfb:	e8 78 27 00 00       	call   3378 <chdir>
     c00:	85 c0                	test   %eax,%eax
     c02:	0f 85 b7 00 00 00    	jne    cbf <iref+0xff>
      printf(1, "chdir irefd failed\n");
      exit();
    }

    mkdir("");
     c08:	c7 04 24 b4 44 00 00 	movl   $0x44b4,(%esp)
     c0f:	e8 5c 27 00 00       	call   3370 <mkdir>
    link("README", "");
     c14:	c7 44 24 04 b4 44 00 	movl   $0x44b4,0x4(%esp)
     c1b:	00 
     c1c:	c7 04 24 27 3a 00 00 	movl   $0x3a27,(%esp)
     c23:	e8 40 27 00 00       	call   3368 <link>
    fd = open("", O_CREATE);
     c28:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
     c2f:	00 
     c30:	c7 04 24 b4 44 00 00 	movl   $0x44b4,(%esp)
     c37:	e8 0c 27 00 00       	call   3348 <open>
    if(fd >= 0)
     c3c:	85 c0                	test   %eax,%eax
     c3e:	78 08                	js     c48 <iref+0x88>
      close(fd);
     c40:	89 04 24             	mov    %eax,(%esp)
     c43:	e8 e8 26 00 00       	call   3330 <close>
    fd = open("xx", O_CREATE);
     c48:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
     c4f:	00 
     c50:	c7 04 24 f9 3d 00 00 	movl   $0x3df9,(%esp)
     c57:	e8 ec 26 00 00       	call   3348 <open>
    if(fd >= 0)
     c5c:	85 c0                	test   %eax,%eax
     c5e:	78 08                	js     c68 <iref+0xa8>
      close(fd);
     c60:	89 04 24             	mov    %eax,(%esp)
     c63:	e8 c8 26 00 00       	call   3330 <close>
  int i, fd;

  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
     c68:	83 c3 01             	add    $0x1,%ebx
    if(fd >= 0)
      close(fd);
    fd = open("xx", O_CREATE);
    if(fd >= 0)
      close(fd);
    unlink("xx");
     c6b:	c7 04 24 f9 3d 00 00 	movl   $0x3df9,(%esp)
     c72:	e8 e1 26 00 00       	call   3358 <unlink>
  int i, fd;

  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
     c77:	83 fb 33             	cmp    $0x33,%ebx
     c7a:	0f 85 60 ff ff ff    	jne    be0 <iref+0x20>
    if(fd >= 0)
      close(fd);
    unlink("xx");
  }

  chdir("/");
     c80:	c7 04 24 2e 3a 00 00 	movl   $0x3a2e,(%esp)
     c87:	e8 ec 26 00 00       	call   3378 <chdir>
  printf(1, "empty file name OK\n");
     c8c:	c7 44 24 04 30 3a 00 	movl   $0x3a30,0x4(%esp)
     c93:	00 
     c94:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c9b:	e8 c0 27 00 00       	call   3460 <printf>
}
     ca0:	83 c4 14             	add    $0x14,%esp
     ca3:	5b                   	pop    %ebx
     ca4:	5d                   	pop    %ebp
     ca5:	c3                   	ret    
  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
      printf(1, "mkdir irefd failed\n");
     ca6:	c7 44 24 04 ff 39 00 	movl   $0x39ff,0x4(%esp)
     cad:	00 
     cae:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     cb5:	e8 a6 27 00 00       	call   3460 <printf>
      exit();
     cba:	e8 49 26 00 00       	call   3308 <exit>
    }
    if(chdir("irefd") != 0){
      printf(1, "chdir irefd failed\n");
     cbf:	c7 44 24 04 13 3a 00 	movl   $0x3a13,0x4(%esp)
     cc6:	00 
     cc7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     cce:	e8 8d 27 00 00       	call   3460 <printf>
      exit();
     cd3:	e8 30 26 00 00       	call   3308 <exit>
     cd8:	90                   	nop    
     cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000ce0 <dirfile>:
  printf(1, "rmdot ok\n");
}

void
dirfile(void)
{
     ce0:	55                   	push   %ebp
     ce1:	89 e5                	mov    %esp,%ebp
     ce3:	53                   	push   %ebx
     ce4:	83 ec 14             	sub    $0x14,%esp
  int fd;

  printf(1, "dir vs file\n");
     ce7:	c7 44 24 04 44 3a 00 	movl   $0x3a44,0x4(%esp)
     cee:	00 
     cef:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     cf6:	e8 65 27 00 00       	call   3460 <printf>

  fd = open("dirfile", O_CREATE);
     cfb:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
     d02:	00 
     d03:	c7 04 24 51 3a 00 00 	movl   $0x3a51,(%esp)
     d0a:	e8 39 26 00 00       	call   3348 <open>
  if(fd < 0){
     d0f:	85 c0                	test   %eax,%eax
     d11:	0f 88 39 01 00 00    	js     e50 <dirfile+0x170>
    printf(1, "create dirfile failed\n");
    exit();
  }
  close(fd);
     d17:	89 04 24             	mov    %eax,(%esp)
     d1a:	e8 11 26 00 00       	call   3330 <close>
  if(chdir("dirfile") == 0){
     d1f:	c7 04 24 51 3a 00 00 	movl   $0x3a51,(%esp)
     d26:	e8 4d 26 00 00       	call   3378 <chdir>
     d2b:	85 c0                	test   %eax,%eax
     d2d:	0f 84 36 01 00 00    	je     e69 <dirfile+0x189>
    printf(1, "chdir dirfile succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", 0);
     d33:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     d3a:	00 
     d3b:	c7 04 24 8a 3a 00 00 	movl   $0x3a8a,(%esp)
     d42:	e8 01 26 00 00       	call   3348 <open>
  if(fd >= 0){
     d47:	85 c0                	test   %eax,%eax
     d49:	0f 89 e8 00 00 00    	jns    e37 <dirfile+0x157>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", O_CREATE);
     d4f:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
     d56:	00 
     d57:	c7 04 24 8a 3a 00 00 	movl   $0x3a8a,(%esp)
     d5e:	e8 e5 25 00 00       	call   3348 <open>
  if(fd >= 0){
     d63:	85 c0                	test   %eax,%eax
     d65:	0f 89 cc 00 00 00    	jns    e37 <dirfile+0x157>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  if(mkdir("dirfile/xx") == 0){
     d6b:	c7 04 24 8a 3a 00 00 	movl   $0x3a8a,(%esp)
     d72:	e8 f9 25 00 00       	call   3370 <mkdir>
     d77:	85 c0                	test   %eax,%eax
     d79:	0f 84 03 01 00 00    	je     e82 <dirfile+0x1a2>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile/xx") == 0){
     d7f:	c7 04 24 8a 3a 00 00 	movl   $0x3a8a,(%esp)
     d86:	e8 cd 25 00 00       	call   3358 <unlink>
     d8b:	85 c0                	test   %eax,%eax
     d8d:	0f 84 08 01 00 00    	je     e9b <dirfile+0x1bb>
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit();
  }
  if(link("README", "dirfile/xx") == 0){
     d93:	c7 44 24 04 8a 3a 00 	movl   $0x3a8a,0x4(%esp)
     d9a:	00 
     d9b:	c7 04 24 27 3a 00 00 	movl   $0x3a27,(%esp)
     da2:	e8 c1 25 00 00       	call   3368 <link>
     da7:	85 c0                	test   %eax,%eax
     da9:	0f 84 05 01 00 00    	je     eb4 <dirfile+0x1d4>
    printf(1, "link to dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile") != 0){
     daf:	c7 04 24 51 3a 00 00 	movl   $0x3a51,(%esp)
     db6:	e8 9d 25 00 00       	call   3358 <unlink>
     dbb:	85 c0                	test   %eax,%eax
     dbd:	0f 85 0a 01 00 00    	jne    ecd <dirfile+0x1ed>
    printf(1, "unlink dirfile failed!\n");
    exit();
  }

  fd = open(".", O_RDWR);
     dc3:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
     dca:	00 
     dcb:	c7 04 24 17 3d 00 00 	movl   $0x3d17,(%esp)
     dd2:	e8 71 25 00 00       	call   3348 <open>
  if(fd >= 0){
     dd7:	85 c0                	test   %eax,%eax
     dd9:	0f 89 07 01 00 00    	jns    ee6 <dirfile+0x206>
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
     ddf:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     de6:	00 
     de7:	c7 04 24 17 3d 00 00 	movl   $0x3d17,(%esp)
     dee:	e8 55 25 00 00       	call   3348 <open>
  if(write(fd, "x", 1) > 0){
     df3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     dfa:	00 
     dfb:	c7 44 24 04 fa 3d 00 	movl   $0x3dfa,0x4(%esp)
     e02:	00 
  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
     e03:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
     e05:	89 04 24             	mov    %eax,(%esp)
     e08:	e8 1b 25 00 00       	call   3328 <write>
     e0d:	85 c0                	test   %eax,%eax
     e0f:	0f 8f ea 00 00 00    	jg     eff <dirfile+0x21f>
    printf(1, "write . succeeded!\n");
    exit();
  }
  close(fd);
     e15:	89 1c 24             	mov    %ebx,(%esp)
     e18:	e8 13 25 00 00       	call   3330 <close>

  printf(1, "dir vs file OK\n");
     e1d:	c7 44 24 04 1a 3b 00 	movl   $0x3b1a,0x4(%esp)
     e24:	00 
     e25:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e2c:	e8 2f 26 00 00       	call   3460 <printf>
}
     e31:	83 c4 14             	add    $0x14,%esp
     e34:	5b                   	pop    %ebx
     e35:	5d                   	pop    %ebp
     e36:	c3                   	ret    
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", O_CREATE);
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
     e37:	c7 44 24 04 95 3a 00 	movl   $0x3a95,0x4(%esp)
     e3e:	00 
     e3f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e46:	e8 15 26 00 00       	call   3460 <printf>
    exit();
     e4b:	e8 b8 24 00 00       	call   3308 <exit>

  printf(1, "dir vs file\n");

  fd = open("dirfile", O_CREATE);
  if(fd < 0){
    printf(1, "create dirfile failed\n");
     e50:	c7 44 24 04 59 3a 00 	movl   $0x3a59,0x4(%esp)
     e57:	00 
     e58:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e5f:	e8 fc 25 00 00       	call   3460 <printf>
    exit();
     e64:	e8 9f 24 00 00       	call   3308 <exit>
  }
  close(fd);
  if(chdir("dirfile") == 0){
    printf(1, "chdir dirfile succeeded!\n");
     e69:	c7 44 24 04 70 3a 00 	movl   $0x3a70,0x4(%esp)
     e70:	00 
     e71:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e78:	e8 e3 25 00 00       	call   3460 <printf>
    exit();
     e7d:	e8 86 24 00 00       	call   3308 <exit>
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
     e82:	c7 44 24 04 b3 3a 00 	movl   $0x3ab3,0x4(%esp)
     e89:	00 
     e8a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e91:	e8 ca 25 00 00       	call   3460 <printf>
    exit();
     e96:	e8 6d 24 00 00       	call   3308 <exit>
  }
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
     e9b:	c7 44 24 04 d0 3a 00 	movl   $0x3ad0,0x4(%esp)
     ea2:	00 
     ea3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     eaa:	e8 b1 25 00 00       	call   3460 <printf>
    exit();
     eaf:	e8 54 24 00 00       	call   3308 <exit>
  }
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
     eb4:	c7 44 24 04 f4 47 00 	movl   $0x47f4,0x4(%esp)
     ebb:	00 
     ebc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ec3:	e8 98 25 00 00       	call   3460 <printf>
    exit();
     ec8:	e8 3b 24 00 00       	call   3308 <exit>
  }
  if(unlink("dirfile") != 0){
    printf(1, "unlink dirfile failed!\n");
     ecd:	c7 44 24 04 ee 3a 00 	movl   $0x3aee,0x4(%esp)
     ed4:	00 
     ed5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     edc:	e8 7f 25 00 00       	call   3460 <printf>
    exit();
     ee1:	e8 22 24 00 00       	call   3308 <exit>
  }

  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf(1, "open . for writing succeeded!\n");
     ee6:	c7 44 24 04 14 48 00 	movl   $0x4814,0x4(%esp)
     eed:	00 
     eee:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ef5:	e8 66 25 00 00       	call   3460 <printf>
    exit();
     efa:	e8 09 24 00 00       	call   3308 <exit>
  }
  fd = open(".", 0);
  if(write(fd, "x", 1) > 0){
    printf(1, "write . succeeded!\n");
     eff:	c7 44 24 04 06 3b 00 	movl   $0x3b06,0x4(%esp)
     f06:	00 
     f07:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f0e:	e8 4d 25 00 00       	call   3460 <printf>
    exit();
     f13:	e8 f0 23 00 00       	call   3308 <exit>
     f18:	90                   	nop    
     f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000f20 <rmdot>:
  printf(1, "fourteen ok\n");
}

void
rmdot(void)
{
     f20:	55                   	push   %ebp
     f21:	89 e5                	mov    %esp,%ebp
     f23:	83 ec 08             	sub    $0x8,%esp
  printf(1, "rmdot test\n");
     f26:	c7 44 24 04 2a 3b 00 	movl   $0x3b2a,0x4(%esp)
     f2d:	00 
     f2e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f35:	e8 26 25 00 00       	call   3460 <printf>
  if(mkdir("dots") != 0){
     f3a:	c7 04 24 36 3b 00 00 	movl   $0x3b36,(%esp)
     f41:	e8 2a 24 00 00       	call   3370 <mkdir>
     f46:	85 c0                	test   %eax,%eax
     f48:	0f 85 a2 00 00 00    	jne    ff0 <rmdot+0xd0>
    printf(1, "mkdir dots failed\n");
    exit();
  }
  if(chdir("dots") != 0){
     f4e:	c7 04 24 36 3b 00 00 	movl   $0x3b36,(%esp)
     f55:	e8 1e 24 00 00       	call   3378 <chdir>
     f5a:	85 c0                	test   %eax,%eax
     f5c:	0f 85 a7 00 00 00    	jne    1009 <rmdot+0xe9>
    printf(1, "chdir dots failed\n");
    exit();
  }
  if(unlink(".") == 0){
     f62:	c7 04 24 17 3d 00 00 	movl   $0x3d17,(%esp)
     f69:	e8 ea 23 00 00       	call   3358 <unlink>
     f6e:	85 c0                	test   %eax,%eax
     f70:	0f 84 ac 00 00 00    	je     1022 <rmdot+0x102>
    printf(1, "rm . worked!\n");
    exit();
  }
  if(unlink("..") == 0){
     f76:	c7 04 24 16 3d 00 00 	movl   $0x3d16,(%esp)
     f7d:	e8 d6 23 00 00       	call   3358 <unlink>
     f82:	85 c0                	test   %eax,%eax
     f84:	0f 84 b1 00 00 00    	je     103b <rmdot+0x11b>
    printf(1, "rm .. worked!\n");
    exit();
  }
  if(chdir("/") != 0){
     f8a:	c7 04 24 2e 3a 00 00 	movl   $0x3a2e,(%esp)
     f91:	e8 e2 23 00 00       	call   3378 <chdir>
     f96:	85 c0                	test   %eax,%eax
     f98:	0f 85 b6 00 00 00    	jne    1054 <rmdot+0x134>
    printf(1, "chdir / failed\n");
    exit();
  }
  if(unlink("dots/.") == 0){
     f9e:	c7 04 24 8e 3b 00 00 	movl   $0x3b8e,(%esp)
     fa5:	e8 ae 23 00 00       	call   3358 <unlink>
     faa:	85 c0                	test   %eax,%eax
     fac:	0f 84 bb 00 00 00    	je     106d <rmdot+0x14d>
    printf(1, "unlink dots/. worked!\n");
    exit();
  }
  if(unlink("dots/..") == 0){
     fb2:	c7 04 24 ac 3b 00 00 	movl   $0x3bac,(%esp)
     fb9:	e8 9a 23 00 00       	call   3358 <unlink>
     fbe:	85 c0                	test   %eax,%eax
     fc0:	0f 84 c0 00 00 00    	je     1086 <rmdot+0x166>
    printf(1, "unlink dots/.. worked!\n");
    exit();
  }
  if(unlink("dots") != 0){
     fc6:	c7 04 24 36 3b 00 00 	movl   $0x3b36,(%esp)
     fcd:	e8 86 23 00 00       	call   3358 <unlink>
     fd2:	85 c0                	test   %eax,%eax
     fd4:	0f 85 c5 00 00 00    	jne    109f <rmdot+0x17f>
    printf(1, "unlink dots failed!\n");
    exit();
  }
  printf(1, "rmdot ok\n");
     fda:	c7 44 24 04 e1 3b 00 	movl   $0x3be1,0x4(%esp)
     fe1:	00 
     fe2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     fe9:	e8 72 24 00 00       	call   3460 <printf>
}
     fee:	c9                   	leave  
     fef:	c3                   	ret    
void
rmdot(void)
{
  printf(1, "rmdot test\n");
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
     ff0:	c7 44 24 04 3b 3b 00 	movl   $0x3b3b,0x4(%esp)
     ff7:	00 
     ff8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     fff:	e8 5c 24 00 00       	call   3460 <printf>
    exit();
    1004:	e8 ff 22 00 00       	call   3308 <exit>
  }
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    1009:	c7 44 24 04 4e 3b 00 	movl   $0x3b4e,0x4(%esp)
    1010:	00 
    1011:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1018:	e8 43 24 00 00       	call   3460 <printf>
    exit();
    101d:	e8 e6 22 00 00       	call   3308 <exit>
  }
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    1022:	c7 44 24 04 61 3b 00 	movl   $0x3b61,0x4(%esp)
    1029:	00 
    102a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1031:	e8 2a 24 00 00       	call   3460 <printf>
    exit();
    1036:	e8 cd 22 00 00       	call   3308 <exit>
  }
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    103b:	c7 44 24 04 6f 3b 00 	movl   $0x3b6f,0x4(%esp)
    1042:	00 
    1043:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    104a:	e8 11 24 00 00       	call   3460 <printf>
    exit();
    104f:	e8 b4 22 00 00       	call   3308 <exit>
  }
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    1054:	c7 44 24 04 7e 3b 00 	movl   $0x3b7e,0x4(%esp)
    105b:	00 
    105c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1063:	e8 f8 23 00 00       	call   3460 <printf>
    exit();
    1068:	e8 9b 22 00 00       	call   3308 <exit>
  }
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    106d:	c7 44 24 04 95 3b 00 	movl   $0x3b95,0x4(%esp)
    1074:	00 
    1075:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    107c:	e8 df 23 00 00       	call   3460 <printf>
    exit();
    1081:	e8 82 22 00 00       	call   3308 <exit>
  }
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    1086:	c7 44 24 04 b4 3b 00 	movl   $0x3bb4,0x4(%esp)
    108d:	00 
    108e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1095:	e8 c6 23 00 00       	call   3460 <printf>
    exit();
    109a:	e8 69 22 00 00       	call   3308 <exit>
  }
  if(unlink("dots") != 0){
    printf(1, "unlink dots failed!\n");
    109f:	c7 44 24 04 cc 3b 00 	movl   $0x3bcc,0x4(%esp)
    10a6:	00 
    10a7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10ae:	e8 ad 23 00 00       	call   3460 <printf>
    exit();
    10b3:	e8 50 22 00 00       	call   3308 <exit>
    10b8:	90                   	nop    
    10b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000010c0 <subdir>:
  printf(1, "bigdir ok\n");
}

void
subdir(void)
{
    10c0:	55                   	push   %ebp
    10c1:	89 e5                	mov    %esp,%ebp
    10c3:	53                   	push   %ebx
    10c4:	83 ec 14             	sub    $0x14,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    10c7:	c7 44 24 04 eb 3b 00 	movl   $0x3beb,0x4(%esp)
    10ce:	00 
    10cf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10d6:	e8 85 23 00 00       	call   3460 <printf>

  unlink("ff");
    10db:	c7 04 24 74 3c 00 00 	movl   $0x3c74,(%esp)
    10e2:	e8 71 22 00 00       	call   3358 <unlink>
  if(mkdir("dd") != 0){
    10e7:	c7 04 24 11 3d 00 00 	movl   $0x3d11,(%esp)
    10ee:	e8 7d 22 00 00       	call   3370 <mkdir>
    10f3:	85 c0                	test   %eax,%eax
    10f5:	0f 85 f6 03 00 00    	jne    14f1 <subdir+0x431>
    printf(1, "subdir mkdir dd failed\n");
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    10fb:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1102:	00 
    1103:	c7 04 24 4a 3c 00 00 	movl   $0x3c4a,(%esp)
    110a:	e8 39 22 00 00       	call   3348 <open>
  if(fd < 0){
    110f:	85 c0                	test   %eax,%eax
  if(mkdir("dd") != 0){
    printf(1, "subdir mkdir dd failed\n");
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    1111:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1113:	0f 88 f1 03 00 00    	js     150a <subdir+0x44a>
    printf(1, "create dd/ff failed\n");
    exit();
  }
  write(fd, "ff", 2);
    1119:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
    1120:	00 
    1121:	c7 44 24 04 74 3c 00 	movl   $0x3c74,0x4(%esp)
    1128:	00 
    1129:	89 04 24             	mov    %eax,(%esp)
    112c:	e8 f7 21 00 00       	call   3328 <write>
  close(fd);
    1131:	89 1c 24             	mov    %ebx,(%esp)
    1134:	e8 f7 21 00 00       	call   3330 <close>
  
  if(unlink("dd") >= 0){
    1139:	c7 04 24 11 3d 00 00 	movl   $0x3d11,(%esp)
    1140:	e8 13 22 00 00       	call   3358 <unlink>
    1145:	85 c0                	test   %eax,%eax
    1147:	0f 89 d6 03 00 00    	jns    1523 <subdir+0x463>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit();
  }

  if(mkdir("/dd/dd") != 0){
    114d:	c7 04 24 25 3c 00 00 	movl   $0x3c25,(%esp)
    1154:	e8 17 22 00 00       	call   3370 <mkdir>
    1159:	85 c0                	test   %eax,%eax
    115b:	0f 85 db 03 00 00    	jne    153c <subdir+0x47c>
    printf(1, "subdir mkdir dd/dd failed\n");
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1161:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1168:	00 
    1169:	c7 04 24 47 3c 00 00 	movl   $0x3c47,(%esp)
    1170:	e8 d3 21 00 00       	call   3348 <open>
  if(fd < 0){
    1175:	85 c0                	test   %eax,%eax
  if(mkdir("/dd/dd") != 0){
    printf(1, "subdir mkdir dd/dd failed\n");
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1177:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1179:	0f 88 d6 03 00 00    	js     1555 <subdir+0x495>
    printf(1, "create dd/dd/ff failed\n");
    exit();
  }
  write(fd, "FF", 2);
    117f:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
    1186:	00 
    1187:	c7 44 24 04 68 3c 00 	movl   $0x3c68,0x4(%esp)
    118e:	00 
    118f:	89 04 24             	mov    %eax,(%esp)
    1192:	e8 91 21 00 00       	call   3328 <write>
  close(fd);
    1197:	89 1c 24             	mov    %ebx,(%esp)
    119a:	e8 91 21 00 00       	call   3330 <close>

  fd = open("dd/dd/../ff", 0);
    119f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11a6:	00 
    11a7:	c7 04 24 6b 3c 00 00 	movl   $0x3c6b,(%esp)
    11ae:	e8 95 21 00 00       	call   3348 <open>
  if(fd < 0){
    11b3:	85 c0                	test   %eax,%eax
    exit();
  }
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
    11b5:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    11b7:	0f 88 b1 03 00 00    	js     156e <subdir+0x4ae>
    printf(1, "open dd/dd/../ff failed\n");
    exit();
  }
  cc = read(fd, buf, sizeof(buf));
    11bd:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    11c4:	00 
    11c5:	c7 44 24 04 e0 4b 00 	movl   $0x4be0,0x4(%esp)
    11cc:	00 
    11cd:	89 04 24             	mov    %eax,(%esp)
    11d0:	e8 4b 21 00 00       	call   3320 <read>
  if(cc != 2 || buf[0] != 'f'){
    11d5:	83 f8 02             	cmp    $0x2,%eax
    11d8:	75 09                	jne    11e3 <subdir+0x123>
    11da:	80 3d e0 4b 00 00 66 	cmpb   $0x66,0x4be0
    11e1:	74 1d                	je     1200 <subdir+0x140>
    printf(1, "dd/dd/../ff wrong content\n");
    11e3:	c7 44 24 04 90 3c 00 	movl   $0x3c90,0x4(%esp)
    11ea:	00 
    11eb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11f2:	e8 69 22 00 00       	call   3460 <printf>
    exit();
    11f7:	e8 0c 21 00 00       	call   3308 <exit>
    11fc:	8d 74 26 00          	lea    0x0(%esi),%esi
  }
  close(fd);
    1200:	89 1c 24             	mov    %ebx,(%esp)
    1203:	e8 28 21 00 00       	call   3330 <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1208:	c7 44 24 04 ab 3c 00 	movl   $0x3cab,0x4(%esp)
    120f:	00 
    1210:	c7 04 24 47 3c 00 00 	movl   $0x3c47,(%esp)
    1217:	e8 4c 21 00 00       	call   3368 <link>
    121c:	85 c0                	test   %eax,%eax
    121e:	0f 85 ae 03 00 00    	jne    15d2 <subdir+0x512>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    exit();
  }

  if(unlink("dd/dd/ff") != 0){
    1224:	c7 04 24 47 3c 00 00 	movl   $0x3c47,(%esp)
    122b:	e8 28 21 00 00       	call   3358 <unlink>
    1230:	85 c0                	test   %eax,%eax
    1232:	0f 85 68 03 00 00    	jne    15a0 <subdir+0x4e0>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1238:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    123f:	00 
    1240:	c7 04 24 47 3c 00 00 	movl   $0x3c47,(%esp)
    1247:	e8 fc 20 00 00       	call   3348 <open>
    124c:	85 c0                	test   %eax,%eax
    124e:	0f 89 65 03 00 00    	jns    15b9 <subdir+0x4f9>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit();
  }

  if(chdir("dd") != 0){
    1254:	c7 04 24 11 3d 00 00 	movl   $0x3d11,(%esp)
    125b:	e8 18 21 00 00       	call   3378 <chdir>
    1260:	85 c0                	test   %eax,%eax
    1262:	0f 85 83 03 00 00    	jne    15eb <subdir+0x52b>
    printf(1, "chdir dd failed\n");
    exit();
  }
  if(chdir("dd/../../dd") != 0){
    1268:	c7 04 24 df 3c 00 00 	movl   $0x3cdf,(%esp)
    126f:	e8 04 21 00 00       	call   3378 <chdir>
    1274:	85 c0                	test   %eax,%eax
    1276:	0f 85 0b 03 00 00    	jne    1587 <subdir+0x4c7>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("dd/../../../dd") != 0){
    127c:	c7 04 24 05 3d 00 00 	movl   $0x3d05,(%esp)
    1283:	e8 f0 20 00 00       	call   3378 <chdir>
    1288:	85 c0                	test   %eax,%eax
    128a:	0f 85 f7 02 00 00    	jne    1587 <subdir+0x4c7>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("./..") != 0){
    1290:	c7 04 24 14 3d 00 00 	movl   $0x3d14,(%esp)
    1297:	e8 dc 20 00 00       	call   3378 <chdir>
    129c:	85 c0                	test   %eax,%eax
    129e:	0f 85 79 03 00 00    	jne    161d <subdir+0x55d>
    printf(1, "chdir ./.. failed\n");
    exit();
  }

  fd = open("dd/dd/ffff", 0);
    12a4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    12ab:	00 
    12ac:	c7 04 24 ab 3c 00 00 	movl   $0x3cab,(%esp)
    12b3:	e8 90 20 00 00       	call   3348 <open>
  if(fd < 0){
    12b8:	85 c0                	test   %eax,%eax
  if(chdir("./..") != 0){
    printf(1, "chdir ./.. failed\n");
    exit();
  }

  fd = open("dd/dd/ffff", 0);
    12ba:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    12bc:	0f 88 42 03 00 00    	js     1604 <subdir+0x544>
    printf(1, "open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    12c2:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    12c9:	00 
    12ca:	c7 44 24 04 e0 4b 00 	movl   $0x4be0,0x4(%esp)
    12d1:	00 
    12d2:	89 04 24             	mov    %eax,(%esp)
    12d5:	e8 46 20 00 00       	call   3320 <read>
    12da:	83 f8 02             	cmp    $0x2,%eax
    12dd:	0f 85 85 03 00 00    	jne    1668 <subdir+0x5a8>
    printf(1, "read dd/dd/ffff wrong len\n");
    exit();
  }
  close(fd);
    12e3:	89 1c 24             	mov    %ebx,(%esp)
    12e6:	e8 45 20 00 00       	call   3330 <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    12eb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    12f2:	00 
    12f3:	c7 04 24 47 3c 00 00 	movl   $0x3c47,(%esp)
    12fa:	e8 49 20 00 00       	call   3348 <open>
    12ff:	85 c0                	test   %eax,%eax
    1301:	0f 89 48 03 00 00    	jns    164f <subdir+0x58f>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit();
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    1307:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    130e:	00 
    130f:	c7 04 24 5f 3d 00 00 	movl   $0x3d5f,(%esp)
    1316:	e8 2d 20 00 00       	call   3348 <open>
    131b:	85 c0                	test   %eax,%eax
    131d:	0f 89 13 03 00 00    	jns    1636 <subdir+0x576>
    printf(1, "create dd/ff/ff succeeded!\n");
    exit();
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    1323:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    132a:	00 
    132b:	c7 04 24 84 3d 00 00 	movl   $0x3d84,(%esp)
    1332:	e8 11 20 00 00       	call   3348 <open>
    1337:	85 c0                	test   %eax,%eax
    1339:	0f 89 42 03 00 00    	jns    1681 <subdir+0x5c1>
    printf(1, "create dd/xx/ff succeeded!\n");
    exit();
  }
  if(open("dd", O_CREATE) >= 0){
    133f:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    1346:	00 
    1347:	c7 04 24 11 3d 00 00 	movl   $0x3d11,(%esp)
    134e:	e8 f5 1f 00 00       	call   3348 <open>
    1353:	85 c0                	test   %eax,%eax
    1355:	0f 89 d5 03 00 00    	jns    1730 <subdir+0x670>
    printf(1, "create dd succeeded!\n");
    exit();
  }
  if(open("dd", O_RDWR) >= 0){
    135b:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    1362:	00 
    1363:	c7 04 24 11 3d 00 00 	movl   $0x3d11,(%esp)
    136a:	e8 d9 1f 00 00       	call   3348 <open>
    136f:	85 c0                	test   %eax,%eax
    1371:	0f 89 a0 03 00 00    	jns    1717 <subdir+0x657>
    printf(1, "open dd rdwr succeeded!\n");
    exit();
  }
  if(open("dd", O_WRONLY) >= 0){
    1377:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    137e:	00 
    137f:	c7 04 24 11 3d 00 00 	movl   $0x3d11,(%esp)
    1386:	e8 bd 1f 00 00       	call   3348 <open>
    138b:	85 c0                	test   %eax,%eax
    138d:	0f 89 6b 03 00 00    	jns    16fe <subdir+0x63e>
    printf(1, "open dd wronly succeeded!\n");
    exit();
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    1393:	c7 44 24 04 f3 3d 00 	movl   $0x3df3,0x4(%esp)
    139a:	00 
    139b:	c7 04 24 5f 3d 00 00 	movl   $0x3d5f,(%esp)
    13a2:	e8 c1 1f 00 00       	call   3368 <link>
    13a7:	85 c0                	test   %eax,%eax
    13a9:	0f 84 36 03 00 00    	je     16e5 <subdir+0x625>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    13af:	c7 44 24 04 f3 3d 00 	movl   $0x3df3,0x4(%esp)
    13b6:	00 
    13b7:	c7 04 24 84 3d 00 00 	movl   $0x3d84,(%esp)
    13be:	e8 a5 1f 00 00       	call   3368 <link>
    13c3:	85 c0                	test   %eax,%eax
    13c5:	0f 84 01 03 00 00    	je     16cc <subdir+0x60c>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    13cb:	c7 44 24 04 ab 3c 00 	movl   $0x3cab,0x4(%esp)
    13d2:	00 
    13d3:	c7 04 24 4a 3c 00 00 	movl   $0x3c4a,(%esp)
    13da:	e8 89 1f 00 00       	call   3368 <link>
    13df:	85 c0                	test   %eax,%eax
    13e1:	0f 84 cc 02 00 00    	je     16b3 <subdir+0x5f3>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit();
  }
  if(mkdir("dd/ff/ff") == 0){
    13e7:	c7 04 24 5f 3d 00 00 	movl   $0x3d5f,(%esp)
    13ee:	e8 7d 1f 00 00       	call   3370 <mkdir>
    13f3:	85 c0                	test   %eax,%eax
    13f5:	0f 84 9f 02 00 00    	je     169a <subdir+0x5da>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/xx/ff") == 0){
    13fb:	c7 04 24 84 3d 00 00 	movl   $0x3d84,(%esp)
    1402:	e8 69 1f 00 00       	call   3370 <mkdir>
    1407:	85 c0                	test   %eax,%eax
    1409:	0f 84 3a 03 00 00    	je     1749 <subdir+0x689>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/dd/ffff") == 0){
    140f:	c7 04 24 ab 3c 00 00 	movl   $0x3cab,(%esp)
    1416:	e8 55 1f 00 00       	call   3370 <mkdir>
    141b:	85 c0                	test   %eax,%eax
    141d:	0f 84 d5 03 00 00    	je     17f8 <subdir+0x738>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit();
  }
  if(unlink("dd/xx/ff") == 0){
    1423:	c7 04 24 84 3d 00 00 	movl   $0x3d84,(%esp)
    142a:	e8 29 1f 00 00       	call   3358 <unlink>
    142f:	85 c0                	test   %eax,%eax
    1431:	0f 84 a8 03 00 00    	je     17df <subdir+0x71f>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit();
  }
  if(unlink("dd/ff/ff") == 0){
    1437:	c7 04 24 5f 3d 00 00 	movl   $0x3d5f,(%esp)
    143e:	e8 15 1f 00 00       	call   3358 <unlink>
    1443:	85 c0                	test   %eax,%eax
    1445:	0f 84 7b 03 00 00    	je     17c6 <subdir+0x706>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/ff") == 0){
    144b:	c7 04 24 4a 3c 00 00 	movl   $0x3c4a,(%esp)
    1452:	e8 21 1f 00 00       	call   3378 <chdir>
    1457:	85 c0                	test   %eax,%eax
    1459:	0f 84 4e 03 00 00    	je     17ad <subdir+0x6ed>
    printf(1, "chdir dd/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/xx") == 0){
    145f:	c7 04 24 f6 3d 00 00 	movl   $0x3df6,(%esp)
    1466:	e8 0d 1f 00 00       	call   3378 <chdir>
    146b:	85 c0                	test   %eax,%eax
    146d:	0f 84 21 03 00 00    	je     1794 <subdir+0x6d4>
    printf(1, "chdir dd/xx succeeded!\n");
    exit();
  }

  if(unlink("dd/dd/ffff") != 0){
    1473:	c7 04 24 ab 3c 00 00 	movl   $0x3cab,(%esp)
    147a:	e8 d9 1e 00 00       	call   3358 <unlink>
    147f:	85 c0                	test   %eax,%eax
    1481:	0f 85 19 01 00 00    	jne    15a0 <subdir+0x4e0>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(unlink("dd/ff") != 0){
    1487:	c7 04 24 4a 3c 00 00 	movl   $0x3c4a,(%esp)
    148e:	e8 c5 1e 00 00       	call   3358 <unlink>
    1493:	85 c0                	test   %eax,%eax
    1495:	0f 85 e0 02 00 00    	jne    177b <subdir+0x6bb>
    printf(1, "unlink dd/ff failed\n");
    exit();
  }
  if(unlink("dd") == 0){
    149b:	c7 04 24 11 3d 00 00 	movl   $0x3d11,(%esp)
    14a2:	e8 b1 1e 00 00       	call   3358 <unlink>
    14a7:	85 c0                	test   %eax,%eax
    14a9:	0f 84 b3 02 00 00    	je     1762 <subdir+0x6a2>
    printf(1, "unlink non-empty dd succeeded!\n");
    exit();
  }
  if(unlink("dd/dd") < 0){
    14af:	c7 04 24 26 3c 00 00 	movl   $0x3c26,(%esp)
    14b6:	e8 9d 1e 00 00       	call   3358 <unlink>
    14bb:	85 c0                	test   %eax,%eax
    14bd:	0f 88 67 03 00 00    	js     182a <subdir+0x76a>
    printf(1, "unlink dd/dd failed\n");
    exit();
  }
  if(unlink("dd") < 0){
    14c3:	c7 04 24 11 3d 00 00 	movl   $0x3d11,(%esp)
    14ca:	e8 89 1e 00 00       	call   3358 <unlink>
    14cf:	85 c0                	test   %eax,%eax
    14d1:	0f 88 3a 03 00 00    	js     1811 <subdir+0x751>
    printf(1, "unlink dd failed\n");
    exit();
  }

  printf(1, "subdir ok\n");
    14d7:	c7 44 24 04 f3 3e 00 	movl   $0x3ef3,0x4(%esp)
    14de:	00 
    14df:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14e6:	e8 75 1f 00 00       	call   3460 <printf>
}
    14eb:	83 c4 14             	add    $0x14,%esp
    14ee:	5b                   	pop    %ebx
    14ef:	5d                   	pop    %ebp
    14f0:	c3                   	ret    

  printf(1, "subdir test\n");

  unlink("ff");
  if(mkdir("dd") != 0){
    printf(1, "subdir mkdir dd failed\n");
    14f1:	c7 44 24 04 f8 3b 00 	movl   $0x3bf8,0x4(%esp)
    14f8:	00 
    14f9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1500:	e8 5b 1f 00 00       	call   3460 <printf>
    exit();
    1505:	e8 fe 1d 00 00       	call   3308 <exit>
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/ff failed\n");
    150a:	c7 44 24 04 10 3c 00 	movl   $0x3c10,0x4(%esp)
    1511:	00 
    1512:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1519:	e8 42 1f 00 00       	call   3460 <printf>
    exit();
    151e:	e8 e5 1d 00 00       	call   3308 <exit>
  }
  write(fd, "ff", 2);
  close(fd);
  
  if(unlink("dd") >= 0){
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    1523:	c7 44 24 04 34 48 00 	movl   $0x4834,0x4(%esp)
    152a:	00 
    152b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1532:	e8 29 1f 00 00       	call   3460 <printf>
    exit();
    1537:	e8 cc 1d 00 00       	call   3308 <exit>
  }

  if(mkdir("/dd/dd") != 0){
    printf(1, "subdir mkdir dd/dd failed\n");
    153c:	c7 44 24 04 2c 3c 00 	movl   $0x3c2c,0x4(%esp)
    1543:	00 
    1544:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    154b:	e8 10 1f 00 00       	call   3460 <printf>
    exit();
    1550:	e8 b3 1d 00 00       	call   3308 <exit>
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/dd/ff failed\n");
    1555:	c7 44 24 04 50 3c 00 	movl   $0x3c50,0x4(%esp)
    155c:	00 
    155d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1564:	e8 f7 1e 00 00       	call   3460 <printf>
    exit();
    1569:	e8 9a 1d 00 00       	call   3308 <exit>
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/../ff failed\n");
    156e:	c7 44 24 04 77 3c 00 	movl   $0x3c77,0x4(%esp)
    1575:	00 
    1576:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    157d:	e8 de 1e 00 00       	call   3460 <printf>
    exit();
    1582:	e8 81 1d 00 00       	call   3308 <exit>
  if(chdir("dd/../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("dd/../../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    1587:	c7 44 24 04 eb 3c 00 	movl   $0x3ceb,0x4(%esp)
    158e:	00 
    158f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1596:	e8 c5 1e 00 00       	call   3460 <printf>
    exit();
    159b:	e8 68 1d 00 00       	call   3308 <exit>
    printf(1, "chdir dd/xx succeeded!\n");
    exit();
  }

  if(unlink("dd/dd/ffff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    15a0:	c7 44 24 04 b6 3c 00 	movl   $0x3cb6,0x4(%esp)
    15a7:	00 
    15a8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15af:	e8 ac 1e 00 00       	call   3460 <printf>
    exit();
    15b4:	e8 4f 1d 00 00       	call   3308 <exit>
  if(unlink("dd/dd/ff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    15b9:	c7 44 24 04 80 48 00 	movl   $0x4880,0x4(%esp)
    15c0:	00 
    15c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15c8:	e8 93 1e 00 00       	call   3460 <printf>
    exit();
    15cd:	e8 36 1d 00 00       	call   3308 <exit>
    exit();
  }
  close(fd);

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    15d2:	c7 44 24 04 5c 48 00 	movl   $0x485c,0x4(%esp)
    15d9:	00 
    15da:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15e1:	e8 7a 1e 00 00       	call   3460 <printf>
    exit();
    15e6:	e8 1d 1d 00 00       	call   3308 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit();
  }

  if(chdir("dd") != 0){
    printf(1, "chdir dd failed\n");
    15eb:	c7 44 24 04 ce 3c 00 	movl   $0x3cce,0x4(%esp)
    15f2:	00 
    15f3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15fa:	e8 61 1e 00 00       	call   3460 <printf>
    exit();
    15ff:	e8 04 1d 00 00       	call   3308 <exit>
    exit();
  }

  fd = open("dd/dd/ffff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    1604:	c7 44 24 04 2c 3d 00 	movl   $0x3d2c,0x4(%esp)
    160b:	00 
    160c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1613:	e8 48 1e 00 00       	call   3460 <printf>
    exit();
    1618:	e8 eb 1c 00 00       	call   3308 <exit>
  if(chdir("dd/../../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("./..") != 0){
    printf(1, "chdir ./.. failed\n");
    161d:	c7 44 24 04 19 3d 00 	movl   $0x3d19,0x4(%esp)
    1624:	00 
    1625:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    162c:	e8 2f 1e 00 00       	call   3460 <printf>
    exit();
    1631:	e8 d2 1c 00 00       	call   3308 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit();
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    1636:	c7 44 24 04 68 3d 00 	movl   $0x3d68,0x4(%esp)
    163d:	00 
    163e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1645:	e8 16 1e 00 00       	call   3460 <printf>
    exit();
    164a:	e8 b9 1c 00 00       	call   3308 <exit>
    exit();
  }
  close(fd);

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    164f:	c7 44 24 04 a4 48 00 	movl   $0x48a4,0x4(%esp)
    1656:	00 
    1657:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    165e:	e8 fd 1d 00 00       	call   3460 <printf>
    exit();
    1663:	e8 a0 1c 00 00       	call   3308 <exit>
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    printf(1, "read dd/dd/ffff wrong len\n");
    1668:	c7 44 24 04 44 3d 00 	movl   $0x3d44,0x4(%esp)
    166f:	00 
    1670:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1677:	e8 e4 1d 00 00       	call   3460 <printf>
    exit();
    167c:	e8 87 1c 00 00       	call   3308 <exit>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    exit();
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    1681:	c7 44 24 04 8d 3d 00 	movl   $0x3d8d,0x4(%esp)
    1688:	00 
    1689:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1690:	e8 cb 1d 00 00       	call   3460 <printf>
    exit();
    1695:	e8 6e 1c 00 00       	call   3308 <exit>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit();
  }
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    169a:	c7 44 24 04 fc 3d 00 	movl   $0x3dfc,0x4(%esp)
    16a1:	00 
    16a2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16a9:	e8 b2 1d 00 00       	call   3460 <printf>
    exit();
    16ae:	e8 55 1c 00 00       	call   3308 <exit>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    16b3:	c7 44 24 04 14 49 00 	movl   $0x4914,0x4(%esp)
    16ba:	00 
    16bb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16c2:	e8 99 1d 00 00       	call   3460 <printf>
    exit();
    16c7:	e8 3c 1c 00 00       	call   3308 <exit>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    16cc:	c7 44 24 04 f0 48 00 	movl   $0x48f0,0x4(%esp)
    16d3:	00 
    16d4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16db:	e8 80 1d 00 00       	call   3460 <printf>
    exit();
    16e0:	e8 23 1c 00 00       	call   3308 <exit>
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    exit();
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    16e5:	c7 44 24 04 cc 48 00 	movl   $0x48cc,0x4(%esp)
    16ec:	00 
    16ed:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16f4:	e8 67 1d 00 00       	call   3460 <printf>
    exit();
    16f9:	e8 0a 1c 00 00       	call   3308 <exit>
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    exit();
  }
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    16fe:	c7 44 24 04 d8 3d 00 	movl   $0x3dd8,0x4(%esp)
    1705:	00 
    1706:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    170d:	e8 4e 1d 00 00       	call   3460 <printf>
    exit();
    1712:	e8 f1 1b 00 00       	call   3308 <exit>
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    exit();
  }
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    1717:	c7 44 24 04 bf 3d 00 	movl   $0x3dbf,0x4(%esp)
    171e:	00 
    171f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1726:	e8 35 1d 00 00       	call   3460 <printf>
    exit();
    172b:	e8 d8 1b 00 00       	call   3308 <exit>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    exit();
  }
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    1730:	c7 44 24 04 a9 3d 00 	movl   $0x3da9,0x4(%esp)
    1737:	00 
    1738:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    173f:	e8 1c 1d 00 00       	call   3460 <printf>
    exit();
    1744:	e8 bf 1b 00 00       	call   3308 <exit>
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    1749:	c7 44 24 04 17 3e 00 	movl   $0x3e17,0x4(%esp)
    1750:	00 
    1751:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1758:	e8 03 1d 00 00       	call   3460 <printf>
    exit();
    175d:	e8 a6 1b 00 00       	call   3308 <exit>
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    exit();
  }
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    1762:	c7 44 24 04 38 49 00 	movl   $0x4938,0x4(%esp)
    1769:	00 
    176a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1771:	e8 ea 1c 00 00       	call   3460 <printf>
    exit();
    1776:	e8 8d 1b 00 00       	call   3308 <exit>
  if(unlink("dd/dd/ffff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    177b:	c7 44 24 04 b7 3e 00 	movl   $0x3eb7,0x4(%esp)
    1782:	00 
    1783:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    178a:	e8 d1 1c 00 00       	call   3460 <printf>
    exit();
    178f:	e8 74 1b 00 00       	call   3308 <exit>
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/xx") == 0){
    printf(1, "chdir dd/xx succeeded!\n");
    1794:	c7 44 24 04 9f 3e 00 	movl   $0x3e9f,0x4(%esp)
    179b:	00 
    179c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17a3:	e8 b8 1c 00 00       	call   3460 <printf>
    exit();
    17a8:	e8 5b 1b 00 00       	call   3308 <exit>
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    17ad:	c7 44 24 04 87 3e 00 	movl   $0x3e87,0x4(%esp)
    17b4:	00 
    17b5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17bc:	e8 9f 1c 00 00       	call   3460 <printf>
    exit();
    17c1:	e8 42 1b 00 00       	call   3308 <exit>
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit();
  }
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    17c6:	c7 44 24 04 6b 3e 00 	movl   $0x3e6b,0x4(%esp)
    17cd:	00 
    17ce:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17d5:	e8 86 1c 00 00       	call   3460 <printf>
    exit();
    17da:	e8 29 1b 00 00       	call   3308 <exit>
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit();
  }
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    17df:	c7 44 24 04 4f 3e 00 	movl   $0x3e4f,0x4(%esp)
    17e6:	00 
    17e7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17ee:	e8 6d 1c 00 00       	call   3460 <printf>
    exit();
    17f3:	e8 10 1b 00 00       	call   3308 <exit>
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    17f8:	c7 44 24 04 32 3e 00 	movl   $0x3e32,0x4(%esp)
    17ff:	00 
    1800:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1807:	e8 54 1c 00 00       	call   3460 <printf>
    exit();
    180c:	e8 f7 1a 00 00       	call   3308 <exit>
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    exit();
  }
  if(unlink("dd") < 0){
    printf(1, "unlink dd failed\n");
    1811:	c7 44 24 04 e1 3e 00 	movl   $0x3ee1,0x4(%esp)
    1818:	00 
    1819:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1820:	e8 3b 1c 00 00       	call   3460 <printf>
    exit();
    1825:	e8 de 1a 00 00       	call   3308 <exit>
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    exit();
  }
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    182a:	c7 44 24 04 cc 3e 00 	movl   $0x3ecc,0x4(%esp)
    1831:	00 
    1832:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1839:	e8 22 1c 00 00       	call   3460 <printf>
    exit();
    183e:	e8 c5 1a 00 00       	call   3308 <exit>
    1843:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1849:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00001850 <bigdir>:
}

// directory that uses indirect blocks
void
bigdir(void)
{
    1850:	55                   	push   %ebp
    1851:	89 e5                	mov    %esp,%ebp
    1853:	56                   	push   %esi
    1854:	53                   	push   %ebx
    1855:	83 ec 20             	sub    $0x20,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    1858:	c7 44 24 04 fe 3e 00 	movl   $0x3efe,0x4(%esp)
    185f:	00 
    1860:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1867:	e8 f4 1b 00 00       	call   3460 <printf>
  unlink("bd");
    186c:	c7 04 24 0b 3f 00 00 	movl   $0x3f0b,(%esp)
    1873:	e8 e0 1a 00 00       	call   3358 <unlink>

  fd = open("bd", O_CREATE);
    1878:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    187f:	00 
    1880:	c7 04 24 0b 3f 00 00 	movl   $0x3f0b,(%esp)
    1887:	e8 bc 1a 00 00       	call   3348 <open>
  if(fd < 0){
    188c:	85 c0                	test   %eax,%eax
    188e:	0f 88 f5 00 00 00    	js     1989 <bigdir+0x139>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);
    1894:	89 04 24             	mov    %eax,(%esp)
    1897:	31 db                	xor    %ebx,%ebx
    1899:	e8 92 1a 00 00       	call   3330 <close>
    189e:	8d 75 ee             	lea    -0x12(%ebp),%esi
    18a1:	eb 0b                	jmp    18ae <bigdir+0x5e>

  for(i = 0; i < 500; i++){
    18a3:	83 c3 01             	add    $0x1,%ebx
    18a6:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    18ac:	74 56                	je     1904 <bigdir+0xb4>
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    18ae:	89 d9                	mov    %ebx,%ecx
    18b0:	c1 f9 1f             	sar    $0x1f,%ecx
    18b3:	c1 e9 1a             	shr    $0x1a,%ecx
    18b6:	8d 14 19             	lea    (%ecx,%ebx,1),%edx
    18b9:	89 d0                	mov    %edx,%eax
    name[2] = '0' + (i % 64);
    18bb:	83 e2 3f             	and    $0x3f,%edx
    18be:	29 ca                	sub    %ecx,%edx
  }
  close(fd);

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    18c0:	c1 f8 06             	sar    $0x6,%eax
    name[2] = '0' + (i % 64);
    18c3:	83 c2 30             	add    $0x30,%edx
  }
  close(fd);

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    18c6:	83 c0 30             	add    $0x30,%eax
    exit();
  }
  close(fd);

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    18c9:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    18cd:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    18d0:	88 55 f0             	mov    %dl,-0x10(%ebp)
    name[3] = '\0';
    18d3:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(link("bd", name) != 0){
    18d7:	89 74 24 04          	mov    %esi,0x4(%esp)
    18db:	c7 04 24 0b 3f 00 00 	movl   $0x3f0b,(%esp)
    18e2:	e8 81 1a 00 00       	call   3368 <link>
    18e7:	85 c0                	test   %eax,%eax
    18e9:	74 b8                	je     18a3 <bigdir+0x53>
      printf(1, "bigdir link failed\n");
    18eb:	c7 44 24 04 24 3f 00 	movl   $0x3f24,0x4(%esp)
    18f2:	00 
    18f3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18fa:	e8 61 1b 00 00       	call   3460 <printf>
      exit();
    18ff:	e8 04 1a 00 00       	call   3308 <exit>
    }
  }

  unlink("bd");
    1904:	c7 04 24 0b 3f 00 00 	movl   $0x3f0b,(%esp)
    190b:	66 31 db             	xor    %bx,%bx
    190e:	e8 45 1a 00 00       	call   3358 <unlink>
    1913:	eb 0b                	jmp    1920 <bigdir+0xd0>
  for(i = 0; i < 500; i++){
    1915:	83 c3 01             	add    $0x1,%ebx
    1918:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    191e:	74 4e                	je     196e <bigdir+0x11e>
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1920:	89 d9                	mov    %ebx,%ecx
    1922:	c1 f9 1f             	sar    $0x1f,%ecx
    1925:	c1 e9 1a             	shr    $0x1a,%ecx
    1928:	8d 14 19             	lea    (%ecx,%ebx,1),%edx
    192b:	89 d0                	mov    %edx,%eax
    name[2] = '0' + (i % 64);
    192d:	83 e2 3f             	and    $0x3f,%edx
    1930:	29 ca                	sub    %ecx,%edx
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1932:	c1 f8 06             	sar    $0x6,%eax
    name[2] = '0' + (i % 64);
    1935:	83 c2 30             	add    $0x30,%edx
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1938:	83 c0 30             	add    $0x30,%eax
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    193b:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    193f:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    1942:	88 55 f0             	mov    %dl,-0x10(%ebp)
    name[3] = '\0';
    1945:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(unlink(name) != 0){
    1949:	89 34 24             	mov    %esi,(%esp)
    194c:	e8 07 1a 00 00       	call   3358 <unlink>
    1951:	85 c0                	test   %eax,%eax
    1953:	74 c0                	je     1915 <bigdir+0xc5>
      printf(1, "bigdir unlink failed");
    1955:	c7 44 24 04 38 3f 00 	movl   $0x3f38,0x4(%esp)
    195c:	00 
    195d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1964:	e8 f7 1a 00 00       	call   3460 <printf>
      exit();
    1969:	e8 9a 19 00 00       	call   3308 <exit>
    }
  }

  printf(1, "bigdir ok\n");
    196e:	c7 44 24 04 4d 3f 00 	movl   $0x3f4d,0x4(%esp)
    1975:	00 
    1976:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    197d:	e8 de 1a 00 00       	call   3460 <printf>
}
    1982:	83 c4 20             	add    $0x20,%esp
    1985:	5b                   	pop    %ebx
    1986:	5e                   	pop    %esi
    1987:	5d                   	pop    %ebp
    1988:	c3                   	ret    
  printf(1, "bigdir test\n");
  unlink("bd");

  fd = open("bd", O_CREATE);
  if(fd < 0){
    printf(1, "bigdir create failed\n");
    1989:	c7 44 24 04 0e 3f 00 	movl   $0x3f0e,0x4(%esp)
    1990:	00 
    1991:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1998:	e8 c3 1a 00 00       	call   3460 <printf>
    exit();
    199d:	e8 66 19 00 00       	call   3308 <exit>
    19a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
    19a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000019b0 <linktest>:
  printf(1, "unlinkread ok\n");
}

void
linktest(void)
{
    19b0:	55                   	push   %ebp
    19b1:	89 e5                	mov    %esp,%ebp
    19b3:	53                   	push   %ebx
    19b4:	83 ec 14             	sub    $0x14,%esp
  int fd;

  printf(1, "linktest\n");
    19b7:	c7 44 24 04 58 3f 00 	movl   $0x3f58,0x4(%esp)
    19be:	00 
    19bf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19c6:	e8 95 1a 00 00       	call   3460 <printf>

  unlink("lf1");
    19cb:	c7 04 24 62 3f 00 00 	movl   $0x3f62,(%esp)
    19d2:	e8 81 19 00 00       	call   3358 <unlink>
  unlink("lf2");
    19d7:	c7 04 24 66 3f 00 00 	movl   $0x3f66,(%esp)
    19de:	e8 75 19 00 00       	call   3358 <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    19e3:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    19ea:	00 
    19eb:	c7 04 24 62 3f 00 00 	movl   $0x3f62,(%esp)
    19f2:	e8 51 19 00 00       	call   3348 <open>
  if(fd < 0){
    19f7:	85 c0                	test   %eax,%eax
  printf(1, "linktest\n");

  unlink("lf1");
  unlink("lf2");

  fd = open("lf1", O_CREATE|O_RDWR);
    19f9:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    19fb:	0f 88 2e 01 00 00    	js     1b2f <linktest+0x17f>
    printf(1, "create lf1 failed\n");
    exit();
  }
  if(write(fd, "hello", 5) != 5){
    1a01:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
    1a08:	00 
    1a09:	c7 44 24 04 7d 3f 00 	movl   $0x3f7d,0x4(%esp)
    1a10:	00 
    1a11:	89 04 24             	mov    %eax,(%esp)
    1a14:	e8 0f 19 00 00       	call   3328 <write>
    1a19:	83 f8 05             	cmp    $0x5,%eax
    1a1c:	0f 85 26 01 00 00    	jne    1b48 <linktest+0x198>
    printf(1, "write lf1 failed\n");
    exit();
  }
  close(fd);
    1a22:	89 1c 24             	mov    %ebx,(%esp)
    1a25:	e8 06 19 00 00       	call   3330 <close>

  if(link("lf1", "lf2") < 0){
    1a2a:	c7 44 24 04 66 3f 00 	movl   $0x3f66,0x4(%esp)
    1a31:	00 
    1a32:	c7 04 24 62 3f 00 00 	movl   $0x3f62,(%esp)
    1a39:	e8 2a 19 00 00       	call   3368 <link>
    1a3e:	85 c0                	test   %eax,%eax
    1a40:	0f 88 1b 01 00 00    	js     1b61 <linktest+0x1b1>
    printf(1, "link lf1 lf2 failed\n");
    exit();
  }
  unlink("lf1");
    1a46:	c7 04 24 62 3f 00 00 	movl   $0x3f62,(%esp)
    1a4d:	e8 06 19 00 00       	call   3358 <unlink>

  if(open("lf1", 0) >= 0){
    1a52:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1a59:	00 
    1a5a:	c7 04 24 62 3f 00 00 	movl   $0x3f62,(%esp)
    1a61:	e8 e2 18 00 00       	call   3348 <open>
    1a66:	85 c0                	test   %eax,%eax
    1a68:	0f 89 0c 01 00 00    	jns    1b7a <linktest+0x1ca>
    printf(1, "unlinked lf1 but it is still there!\n");
    exit();
  }

  fd = open("lf2", 0);
    1a6e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1a75:	00 
    1a76:	c7 04 24 66 3f 00 00 	movl   $0x3f66,(%esp)
    1a7d:	e8 c6 18 00 00       	call   3348 <open>
  if(fd < 0){
    1a82:	85 c0                	test   %eax,%eax
  if(open("lf1", 0) >= 0){
    printf(1, "unlinked lf1 but it is still there!\n");
    exit();
  }

  fd = open("lf2", 0);
    1a84:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1a86:	0f 88 07 01 00 00    	js     1b93 <linktest+0x1e3>
    printf(1, "open lf2 failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    1a8c:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    1a93:	00 
    1a94:	c7 44 24 04 e0 4b 00 	movl   $0x4be0,0x4(%esp)
    1a9b:	00 
    1a9c:	89 04 24             	mov    %eax,(%esp)
    1a9f:	e8 7c 18 00 00       	call   3320 <read>
    1aa4:	83 f8 05             	cmp    $0x5,%eax
    1aa7:	0f 85 ff 00 00 00    	jne    1bac <linktest+0x1fc>
    printf(1, "read lf2 failed\n");
    exit();
  }
  close(fd);
    1aad:	89 1c 24             	mov    %ebx,(%esp)
    1ab0:	e8 7b 18 00 00       	call   3330 <close>

  if(link("lf2", "lf2") >= 0){
    1ab5:	c7 44 24 04 66 3f 00 	movl   $0x3f66,0x4(%esp)
    1abc:	00 
    1abd:	c7 04 24 66 3f 00 00 	movl   $0x3f66,(%esp)
    1ac4:	e8 9f 18 00 00       	call   3368 <link>
    1ac9:	85 c0                	test   %eax,%eax
    1acb:	0f 89 f4 00 00 00    	jns    1bc5 <linktest+0x215>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    exit();
  }

  unlink("lf2");
    1ad1:	c7 04 24 66 3f 00 00 	movl   $0x3f66,(%esp)
    1ad8:	e8 7b 18 00 00       	call   3358 <unlink>
  if(link("lf2", "lf1") >= 0){
    1add:	c7 44 24 04 62 3f 00 	movl   $0x3f62,0x4(%esp)
    1ae4:	00 
    1ae5:	c7 04 24 66 3f 00 00 	movl   $0x3f66,(%esp)
    1aec:	e8 77 18 00 00       	call   3368 <link>
    1af1:	85 c0                	test   %eax,%eax
    1af3:	0f 89 e5 00 00 00    	jns    1bde <linktest+0x22e>
    printf(1, "link non-existant succeeded! oops\n");
    exit();
  }

  if(link(".", "lf1") >= 0){
    1af9:	c7 44 24 04 62 3f 00 	movl   $0x3f62,0x4(%esp)
    1b00:	00 
    1b01:	c7 04 24 17 3d 00 00 	movl   $0x3d17,(%esp)
    1b08:	e8 5b 18 00 00       	call   3368 <link>
    1b0d:	85 c0                	test   %eax,%eax
    1b0f:	0f 89 e2 00 00 00    	jns    1bf7 <linktest+0x247>
    printf(1, "link . lf1 succeeded! oops\n");
    exit();
  }

  printf(1, "linktest ok\n");
    1b15:	c7 44 24 04 06 40 00 	movl   $0x4006,0x4(%esp)
    1b1c:	00 
    1b1d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b24:	e8 37 19 00 00       	call   3460 <printf>
}
    1b29:	83 c4 14             	add    $0x14,%esp
    1b2c:	5b                   	pop    %ebx
    1b2d:	5d                   	pop    %ebp
    1b2e:	c3                   	ret    
  unlink("lf1");
  unlink("lf2");

  fd = open("lf1", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    1b2f:	c7 44 24 04 6a 3f 00 	movl   $0x3f6a,0x4(%esp)
    1b36:	00 
    1b37:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b3e:	e8 1d 19 00 00       	call   3460 <printf>
    exit();
    1b43:	e8 c0 17 00 00       	call   3308 <exit>
  }
  if(write(fd, "hello", 5) != 5){
    printf(1, "write lf1 failed\n");
    1b48:	c7 44 24 04 83 3f 00 	movl   $0x3f83,0x4(%esp)
    1b4f:	00 
    1b50:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b57:	e8 04 19 00 00       	call   3460 <printf>
    exit();
    1b5c:	e8 a7 17 00 00       	call   3308 <exit>
  }
  close(fd);

  if(link("lf1", "lf2") < 0){
    printf(1, "link lf1 lf2 failed\n");
    1b61:	c7 44 24 04 95 3f 00 	movl   $0x3f95,0x4(%esp)
    1b68:	00 
    1b69:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b70:	e8 eb 18 00 00       	call   3460 <printf>
    exit();
    1b75:	e8 8e 17 00 00       	call   3308 <exit>
  }
  unlink("lf1");

  if(open("lf1", 0) >= 0){
    printf(1, "unlinked lf1 but it is still there!\n");
    1b7a:	c7 44 24 04 58 49 00 	movl   $0x4958,0x4(%esp)
    1b81:	00 
    1b82:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b89:	e8 d2 18 00 00       	call   3460 <printf>
    exit();
    1b8e:	e8 75 17 00 00       	call   3308 <exit>
  }

  fd = open("lf2", 0);
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    1b93:	c7 44 24 04 aa 3f 00 	movl   $0x3faa,0x4(%esp)
    1b9a:	00 
    1b9b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ba2:	e8 b9 18 00 00       	call   3460 <printf>
    exit();
    1ba7:	e8 5c 17 00 00       	call   3308 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "read lf2 failed\n");
    1bac:	c7 44 24 04 bb 3f 00 	movl   $0x3fbb,0x4(%esp)
    1bb3:	00 
    1bb4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1bbb:	e8 a0 18 00 00       	call   3460 <printf>
    exit();
    1bc0:	e8 43 17 00 00       	call   3308 <exit>
  }
  close(fd);

  if(link("lf2", "lf2") >= 0){
    printf(1, "link lf2 lf2 succeeded! oops\n");
    1bc5:	c7 44 24 04 cc 3f 00 	movl   $0x3fcc,0x4(%esp)
    1bcc:	00 
    1bcd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1bd4:	e8 87 18 00 00       	call   3460 <printf>
    exit();
    1bd9:	e8 2a 17 00 00       	call   3308 <exit>
  }

  unlink("lf2");
  if(link("lf2", "lf1") >= 0){
    printf(1, "link non-existant succeeded! oops\n");
    1bde:	c7 44 24 04 80 49 00 	movl   $0x4980,0x4(%esp)
    1be5:	00 
    1be6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1bed:	e8 6e 18 00 00       	call   3460 <printf>
    exit();
    1bf2:	e8 11 17 00 00       	call   3308 <exit>
  }

  if(link(".", "lf1") >= 0){
    printf(1, "link . lf1 succeeded! oops\n");
    1bf7:	c7 44 24 04 ea 3f 00 	movl   $0x3fea,0x4(%esp)
    1bfe:	00 
    1bff:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c06:	e8 55 18 00 00       	call   3460 <printf>
    exit();
    1c0b:	e8 f8 16 00 00       	call   3308 <exit>

00001c10 <unlinkread>:
}

// can I unlink a file and still read it?
void
unlinkread(void)
{
    1c10:	55                   	push   %ebp
    1c11:	89 e5                	mov    %esp,%ebp
    1c13:	56                   	push   %esi
    1c14:	53                   	push   %ebx
    1c15:	83 ec 10             	sub    $0x10,%esp
  int fd, fd1;

  printf(1, "unlinkread test\n");
    1c18:	c7 44 24 04 13 40 00 	movl   $0x4013,0x4(%esp)
    1c1f:	00 
    1c20:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c27:	e8 34 18 00 00       	call   3460 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1c2c:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1c33:	00 
    1c34:	c7 04 24 24 40 00 00 	movl   $0x4024,(%esp)
    1c3b:	e8 08 17 00 00       	call   3348 <open>
  if(fd < 0){
    1c40:	85 c0                	test   %eax,%eax
unlinkread(void)
{
  int fd, fd1;

  printf(1, "unlinkread test\n");
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1c42:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1c44:	0f 88 06 01 00 00    	js     1d50 <unlinkread+0x140>
    printf(1, "create unlinkread failed\n");
    exit();
  }
  write(fd, "hello", 5);
    1c4a:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
    1c51:	00 
    1c52:	c7 44 24 04 7d 3f 00 	movl   $0x3f7d,0x4(%esp)
    1c59:	00 
    1c5a:	89 04 24             	mov    %eax,(%esp)
    1c5d:	e8 c6 16 00 00       	call   3328 <write>
  close(fd);
    1c62:	89 1c 24             	mov    %ebx,(%esp)
    1c65:	e8 c6 16 00 00       	call   3330 <close>

  fd = open("unlinkread", O_RDWR);
    1c6a:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    1c71:	00 
    1c72:	c7 04 24 24 40 00 00 	movl   $0x4024,(%esp)
    1c79:	e8 ca 16 00 00       	call   3348 <open>
  if(fd < 0){
    1c7e:	85 c0                	test   %eax,%eax
    exit();
  }
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
    1c80:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    1c82:	0f 88 e1 00 00 00    	js     1d69 <unlinkread+0x159>
    printf(1, "open unlinkread failed\n");
    exit();
  }
  if(unlink("unlinkread") != 0){
    1c88:	c7 04 24 24 40 00 00 	movl   $0x4024,(%esp)
    1c8f:	e8 c4 16 00 00       	call   3358 <unlink>
    1c94:	85 c0                	test   %eax,%eax
    1c96:	0f 85 e6 00 00 00    	jne    1d82 <unlinkread+0x172>
    printf(1, "unlink unlinkread failed\n");
    exit();
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    1c9c:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1ca3:	00 
    1ca4:	c7 04 24 24 40 00 00 	movl   $0x4024,(%esp)
    1cab:	e8 98 16 00 00       	call   3348 <open>
  write(fd1, "yyy", 3);
    1cb0:	c7 44 24 08 03 00 00 	movl   $0x3,0x8(%esp)
    1cb7:	00 
    1cb8:	c7 44 24 04 7b 40 00 	movl   $0x407b,0x4(%esp)
    1cbf:	00 
  if(unlink("unlinkread") != 0){
    printf(1, "unlink unlinkread failed\n");
    exit();
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    1cc0:	89 c3                	mov    %eax,%ebx
  write(fd1, "yyy", 3);
    1cc2:	89 04 24             	mov    %eax,(%esp)
    1cc5:	e8 5e 16 00 00       	call   3328 <write>
  close(fd1);
    1cca:	89 1c 24             	mov    %ebx,(%esp)
    1ccd:	e8 5e 16 00 00       	call   3330 <close>

  if(read(fd, buf, sizeof(buf)) != 5){
    1cd2:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    1cd9:	00 
    1cda:	c7 44 24 04 e0 4b 00 	movl   $0x4be0,0x4(%esp)
    1ce1:	00 
    1ce2:	89 34 24             	mov    %esi,(%esp)
    1ce5:	e8 36 16 00 00       	call   3320 <read>
    1cea:	83 f8 05             	cmp    $0x5,%eax
    1ced:	0f 85 a8 00 00 00    	jne    1d9b <unlinkread+0x18b>
    printf(1, "unlinkread read failed");
    exit();
  }
  if(buf[0] != 'h'){
    1cf3:	80 3d e0 4b 00 00 68 	cmpb   $0x68,0x4be0
    1cfa:	0f 85 b4 00 00 00    	jne    1db4 <unlinkread+0x1a4>
    printf(1, "unlinkread wrong data\n");
    exit();
  }
  if(write(fd, buf, 10) != 10){
    1d00:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1d07:	00 
    1d08:	c7 44 24 04 e0 4b 00 	movl   $0x4be0,0x4(%esp)
    1d0f:	00 
    1d10:	89 34 24             	mov    %esi,(%esp)
    1d13:	e8 10 16 00 00       	call   3328 <write>
    1d18:	83 f8 0a             	cmp    $0xa,%eax
    1d1b:	0f 85 ac 00 00 00    	jne    1dcd <unlinkread+0x1bd>
    printf(1, "unlinkread write failed\n");
    exit();
  }
  close(fd);
    1d21:	89 34 24             	mov    %esi,(%esp)
    1d24:	e8 07 16 00 00       	call   3330 <close>
  unlink("unlinkread");
    1d29:	c7 04 24 24 40 00 00 	movl   $0x4024,(%esp)
    1d30:	e8 23 16 00 00       	call   3358 <unlink>
  printf(1, "unlinkread ok\n");
    1d35:	c7 44 24 04 c6 40 00 	movl   $0x40c6,0x4(%esp)
    1d3c:	00 
    1d3d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d44:	e8 17 17 00 00       	call   3460 <printf>
}
    1d49:	83 c4 10             	add    $0x10,%esp
    1d4c:	5b                   	pop    %ebx
    1d4d:	5e                   	pop    %esi
    1d4e:	5d                   	pop    %ebp
    1d4f:	c3                   	ret    
  int fd, fd1;

  printf(1, "unlinkread test\n");
  fd = open("unlinkread", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create unlinkread failed\n");
    1d50:	c7 44 24 04 2f 40 00 	movl   $0x402f,0x4(%esp)
    1d57:	00 
    1d58:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d5f:	e8 fc 16 00 00       	call   3460 <printf>
    exit();
    1d64:	e8 9f 15 00 00       	call   3308 <exit>
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    1d69:	c7 44 24 04 49 40 00 	movl   $0x4049,0x4(%esp)
    1d70:	00 
    1d71:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d78:	e8 e3 16 00 00       	call   3460 <printf>
    exit();
    1d7d:	e8 86 15 00 00       	call   3308 <exit>
  }
  if(unlink("unlinkread") != 0){
    printf(1, "unlink unlinkread failed\n");
    1d82:	c7 44 24 04 61 40 00 	movl   $0x4061,0x4(%esp)
    1d89:	00 
    1d8a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d91:	e8 ca 16 00 00       	call   3460 <printf>
    exit();
    1d96:	e8 6d 15 00 00       	call   3308 <exit>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
  write(fd1, "yyy", 3);
  close(fd1);

  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    1d9b:	c7 44 24 04 7f 40 00 	movl   $0x407f,0x4(%esp)
    1da2:	00 
    1da3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1daa:	e8 b1 16 00 00       	call   3460 <printf>
    exit();
    1daf:	e8 54 15 00 00       	call   3308 <exit>
  }
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    1db4:	c7 44 24 04 96 40 00 	movl   $0x4096,0x4(%esp)
    1dbb:	00 
    1dbc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1dc3:	e8 98 16 00 00       	call   3460 <printf>
    exit();
    1dc8:	e8 3b 15 00 00       	call   3308 <exit>
  }
  if(write(fd, buf, 10) != 10){
    printf(1, "unlinkread write failed\n");
    1dcd:	c7 44 24 04 ad 40 00 	movl   $0x40ad,0x4(%esp)
    1dd4:	00 
    1dd5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ddc:	e8 7f 16 00 00       	call   3460 <printf>
    exit();
    1de1:	e8 22 15 00 00       	call   3308 <exit>
    1de6:	8d 76 00             	lea    0x0(%esi),%esi
    1de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00001df0 <createdelete>:
}

// two processes create and delete different files in same directory
void
createdelete(void)
{
    1df0:	55                   	push   %ebp
    1df1:	89 e5                	mov    %esp,%ebp
    1df3:	57                   	push   %edi
    1df4:	56                   	push   %esi
    1df5:	53                   	push   %ebx
    1df6:	83 ec 3c             	sub    $0x3c,%esp
  enum { N = 20 };
  int pid, i, fd;
  char name[32];

  printf(1, "createdelete test\n");
    1df9:	c7 44 24 04 d5 40 00 	movl   $0x40d5,0x4(%esp)
    1e00:	00 
    1e01:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e08:	e8 53 16 00 00       	call   3460 <printf>
  pid = fork();
    1e0d:	e8 ee 14 00 00       	call   3300 <fork>
  if(pid < 0){
    1e12:	83 f8 00             	cmp    $0x0,%eax
  enum { N = 20 };
  int pid, i, fd;
  char name[32];

  printf(1, "createdelete test\n");
  pid = fork();
    1e15:	89 c7                	mov    %eax,%edi
  if(pid < 0){
    1e17:	0f 8c 64 02 00 00    	jl     2081 <createdelete+0x291>
    printf(1, "fork failed\n");
    exit();
  }

  name[0] = pid ? 'p' : 'c';
    1e1d:	83 f8 01             	cmp    $0x1,%eax
  name[2] = '\0';
    1e20:	be 01 00 00 00       	mov    $0x1,%esi
  if(pid < 0){
    printf(1, "fork failed\n");
    exit();
  }

  name[0] = pid ? 'p' : 'c';
    1e25:	19 c0                	sbb    %eax,%eax
  name[2] = '\0';
    1e27:	31 db                	xor    %ebx,%ebx
  if(pid < 0){
    printf(1, "fork failed\n");
    exit();
  }

  name[0] = pid ? 'p' : 'c';
    1e29:	83 e0 f3             	and    $0xfffffff3,%eax
    1e2c:	83 c0 70             	add    $0x70,%eax
    1e2f:	88 45 d4             	mov    %al,-0x2c(%ebp)
  name[2] = '\0';
    1e32:	c6 45 d6 00          	movb   $0x0,-0x2a(%ebp)
    1e36:	eb 0b                	jmp    1e43 <createdelete+0x53>
  for(i = 0; i < N; i++){
    1e38:	83 fe 13             	cmp    $0x13,%esi
    1e3b:	7f 73                	jg     1eb0 <createdelete+0xc0>
    1e3d:	83 c3 01             	add    $0x1,%ebx
    1e40:	83 c6 01             	add    $0x1,%esi
    name[1] = '0' + i;
    1e43:	8d 43 30             	lea    0x30(%ebx),%eax
    1e46:	88 45 d5             	mov    %al,-0x2b(%ebp)
    fd = open(name, O_CREATE | O_RDWR);
    1e49:	8d 45 d4             	lea    -0x2c(%ebp),%eax
    1e4c:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1e53:	00 
    1e54:	89 04 24             	mov    %eax,(%esp)
    1e57:	e8 ec 14 00 00       	call   3348 <open>
    if(fd < 0){
    1e5c:	85 c0                	test   %eax,%eax
    1e5e:	0f 88 c4 01 00 00    	js     2028 <createdelete+0x238>
      printf(1, "create failed\n");
      exit();
    }
    close(fd);
    1e64:	89 04 24             	mov    %eax,(%esp)
    1e67:	e8 c4 14 00 00       	call   3330 <close>
    if(i > 0 && (i % 2 ) == 0){
    1e6c:	85 db                	test   %ebx,%ebx
    1e6e:	66 90                	xchg   %ax,%ax
    1e70:	74 cb                	je     1e3d <createdelete+0x4d>
    1e72:	f6 c3 01             	test   $0x1,%bl
    1e75:	75 c1                	jne    1e38 <createdelete+0x48>
      name[1] = '0' + (i / 2);
    1e77:	89 d8                	mov    %ebx,%eax
    1e79:	d1 f8                	sar    %eax
    1e7b:	83 c0 30             	add    $0x30,%eax
      if(unlink(name) < 0){
    1e7e:	8d 55 d4             	lea    -0x2c(%ebp),%edx
      printf(1, "create failed\n");
      exit();
    }
    close(fd);
    if(i > 0 && (i % 2 ) == 0){
      name[1] = '0' + (i / 2);
    1e81:	88 45 d5             	mov    %al,-0x2b(%ebp)
      if(unlink(name) < 0){
    1e84:	89 14 24             	mov    %edx,(%esp)
    1e87:	e8 cc 14 00 00       	call   3358 <unlink>
    1e8c:	85 c0                	test   %eax,%eax
    1e8e:	79 a8                	jns    1e38 <createdelete+0x48>
        printf(1, "unlink failed\n");
    1e90:	c7 44 24 04 e8 40 00 	movl   $0x40e8,0x4(%esp)
    1e97:	00 
    1e98:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e9f:	e8 bc 15 00 00       	call   3460 <printf>
        exit();
    1ea4:	e8 5f 14 00 00       	call   3308 <exit>
    1ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
      }
    }
  }

  if(pid==0)
    1eb0:	85 ff                	test   %edi,%edi
    1eb2:	74 7e                	je     1f32 <createdelete+0x142>
    exit();
  else
    wait();
    1eb4:	e8 57 14 00 00       	call   3310 <wait>
    1eb9:	31 db                	xor    %ebx,%ebx
    1ebb:	90                   	nop    
    1ebc:	8d 74 26 00          	lea    0x0(%esi),%esi

  for(i = 0; i < N; i++){
    name[0] = 'p';
    1ec0:	8d 7b 30             	lea    0x30(%ebx),%edi
    name[1] = '0' + i;
    1ec3:	89 f9                	mov    %edi,%ecx
    fd = open(name, 0);
    1ec5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  else
    wait();

  for(i = 0; i < N; i++){
    name[0] = 'p';
    name[1] = '0' + i;
    1ec8:	88 4d d5             	mov    %cl,-0x2b(%ebp)
    exit();
  else
    wait();

  for(i = 0; i < N; i++){
    name[0] = 'p';
    1ecb:	c6 45 d4 70          	movb   $0x70,-0x2c(%ebp)
    name[1] = '0' + i;
    fd = open(name, 0);
    1ecf:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1ed6:	00 
    1ed7:	89 04 24             	mov    %eax,(%esp)
    1eda:	e8 69 14 00 00       	call   3348 <open>
    if((i == 0 || i >= N/2) && fd < 0){
    1edf:	85 db                	test   %ebx,%ebx
    1ee1:	0f 94 c2             	sete   %dl
    1ee4:	83 fb 09             	cmp    $0x9,%ebx
    wait();

  for(i = 0; i < N; i++){
    name[0] = 'p';
    name[1] = '0' + i;
    fd = open(name, 0);
    1ee7:	89 c1                	mov    %eax,%ecx
    if((i == 0 || i >= N/2) && fd < 0){
    1ee9:	0f 9f c0             	setg   %al
    1eec:	08 c2                	or     %al,%dl
    1eee:	88 55 d3             	mov    %dl,-0x2d(%ebp)
    1ef1:	74 08                	je     1efb <createdelete+0x10b>
    1ef3:	85 c9                	test   %ecx,%ecx
    1ef5:	0f 88 66 01 00 00    	js     2061 <createdelete+0x271>
      printf(1, "oops createdelete %s didn't exist\n", name);
      exit();
    } else if((i >= 1 && i < N/2) && fd >= 0){
    1efb:	8d 43 ff             	lea    -0x1(%ebx),%eax
    1efe:	83 f8 08             	cmp    $0x8,%eax
    1f01:	0f 96 c0             	setbe  %al
    1f04:	89 c6                	mov    %eax,%esi
    1f06:	89 c8                	mov    %ecx,%eax
    1f08:	f7 d0                	not    %eax
    1f0a:	89 f2                	mov    %esi,%edx
    1f0c:	c1 e8 1f             	shr    $0x1f,%eax
    1f0f:	84 d2                	test   %dl,%dl
    1f11:	74 24                	je     1f37 <createdelete+0x147>
    1f13:	84 c0                	test   %al,%al
    1f15:	74 2c                	je     1f43 <createdelete+0x153>
      printf(1, "oops createdelete %s did exist\n", name);
    1f17:	8d 4d d4             	lea    -0x2c(%ebp),%ecx
    1f1a:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    1f1e:	c7 44 24 04 c8 49 00 	movl   $0x49c8,0x4(%esp)
    1f25:	00 
    1f26:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f2d:	e8 2e 15 00 00       	call   3460 <printf>
      exit();
    1f32:	e8 d1 13 00 00       	call   3308 <exit>
    }
    if(fd >= 0)
    1f37:	84 c0                	test   %al,%al
    1f39:	74 08                	je     1f43 <createdelete+0x153>
      close(fd);
    1f3b:	89 0c 24             	mov    %ecx,(%esp)
    1f3e:	e8 ed 13 00 00       	call   3330 <close>

    name[0] = 'c';
    name[1] = '0' + i;
    fd = open(name, 0);
    1f43:	8d 55 d4             	lea    -0x2c(%ebp),%edx
    }
    if(fd >= 0)
      close(fd);

    name[0] = 'c';
    name[1] = '0' + i;
    1f46:	89 f8                	mov    %edi,%eax
    fd = open(name, 0);
    1f48:	89 14 24             	mov    %edx,(%esp)
      exit();
    }
    if(fd >= 0)
      close(fd);

    name[0] = 'c';
    1f4b:	c6 45 d4 63          	movb   $0x63,-0x2c(%ebp)
    name[1] = '0' + i;
    1f4f:	88 45 d5             	mov    %al,-0x2b(%ebp)
    fd = open(name, 0);
    1f52:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1f59:	00 
    1f5a:	e8 e9 13 00 00       	call   3348 <open>
    if((i == 0 || i >= N/2) && fd < 0){
    1f5f:	80 7d d3 00          	cmpb   $0x0,-0x2d(%ebp)
    if(fd >= 0)
      close(fd);

    name[0] = 'c';
    name[1] = '0' + i;
    fd = open(name, 0);
    1f63:	89 c2                	mov    %eax,%edx
    if((i == 0 || i >= N/2) && fd < 0){
    1f65:	74 08                	je     1f6f <createdelete+0x17f>
    1f67:	85 c0                	test   %eax,%eax
    1f69:	0f 88 d2 00 00 00    	js     2041 <createdelete+0x251>
      printf(1, "oops createdelete %s didn't exist\n", name);
      exit();
    } else if((i >= 1 && i < N/2) && fd >= 0){
    1f6f:	89 d0                	mov    %edx,%eax
    1f71:	89 f1                	mov    %esi,%ecx
    1f73:	f7 d0                	not    %eax
    1f75:	c1 e8 1f             	shr    $0x1f,%eax
    1f78:	84 c9                	test   %cl,%cl
    1f7a:	74 24                	je     1fa0 <createdelete+0x1b0>
    1f7c:	84 c0                	test   %al,%al
    1f7e:	74 30                	je     1fb0 <createdelete+0x1c0>
      printf(1, "oops createdelete %s did exist\n", name);
    1f80:	8d 45 d4             	lea    -0x2c(%ebp),%eax
    1f83:	89 44 24 08          	mov    %eax,0x8(%esp)
    1f87:	c7 44 24 04 c8 49 00 	movl   $0x49c8,0x4(%esp)
    1f8e:	00 
    1f8f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f96:	e8 c5 14 00 00       	call   3460 <printf>
      exit();
    1f9b:	e8 68 13 00 00       	call   3308 <exit>
    }
    if(fd >= 0)
    1fa0:	84 c0                	test   %al,%al
    1fa2:	74 0c                	je     1fb0 <createdelete+0x1c0>
      close(fd);
    1fa4:	89 14 24             	mov    %edx,(%esp)
    1fa7:	e8 84 13 00 00       	call   3330 <close>
    1fac:	8d 74 26 00          	lea    0x0(%esi),%esi
  if(pid==0)
    exit();
  else
    wait();

  for(i = 0; i < N; i++){
    1fb0:	83 c3 01             	add    $0x1,%ebx
    1fb3:	83 fb 14             	cmp    $0x14,%ebx
    1fb6:	0f 85 04 ff ff ff    	jne    1ec0 <createdelete+0xd0>
  }

  for(i = 0; i < N; i++){
    name[0] = 'p';
    name[1] = '0' + i;
    unlink(name);
    1fbc:	8d 55 d4             	lea    -0x2c(%ebp),%edx
    name[0] = 'c';
    unlink(name);
    1fbf:	b3 01                	mov    $0x1,%bl
  }

  for(i = 0; i < N; i++){
    name[0] = 'p';
    name[1] = '0' + i;
    unlink(name);
    1fc1:	89 14 24             	mov    %edx,(%esp)
    if(fd >= 0)
      close(fd);
  }

  for(i = 0; i < N; i++){
    name[0] = 'p';
    1fc4:	c6 45 d4 70          	movb   $0x70,-0x2c(%ebp)
    name[1] = '0' + i;
    1fc8:	c6 45 d5 30          	movb   $0x30,-0x2b(%ebp)
    unlink(name);
    1fcc:	e8 87 13 00 00       	call   3358 <unlink>
    name[0] = 'c';
    unlink(name);
    1fd1:	8d 4d d4             	lea    -0x2c(%ebp),%ecx

  for(i = 0; i < N; i++){
    name[0] = 'p';
    name[1] = '0' + i;
    unlink(name);
    name[0] = 'c';
    1fd4:	c6 45 d4 63          	movb   $0x63,-0x2c(%ebp)
    unlink(name);
    1fd8:	89 0c 24             	mov    %ecx,(%esp)
    1fdb:	e8 78 13 00 00       	call   3358 <unlink>
      close(fd);
  }

  for(i = 0; i < N; i++){
    name[0] = 'p';
    name[1] = '0' + i;
    1fe0:	8d 43 30             	lea    0x30(%ebx),%eax
    }
    if(fd >= 0)
      close(fd);
  }

  for(i = 0; i < N; i++){
    1fe3:	83 c3 01             	add    $0x1,%ebx
    name[0] = 'p';
    name[1] = '0' + i;
    1fe6:	88 45 d5             	mov    %al,-0x2b(%ebp)
    unlink(name);
    1fe9:	8d 45 d4             	lea    -0x2c(%ebp),%eax
    if(fd >= 0)
      close(fd);
  }

  for(i = 0; i < N; i++){
    name[0] = 'p';
    1fec:	c6 45 d4 70          	movb   $0x70,-0x2c(%ebp)
    name[1] = '0' + i;
    unlink(name);
    1ff0:	89 04 24             	mov    %eax,(%esp)
    1ff3:	e8 60 13 00 00       	call   3358 <unlink>
    name[0] = 'c';
    unlink(name);
    1ff8:	8d 55 d4             	lea    -0x2c(%ebp),%edx

  for(i = 0; i < N; i++){
    name[0] = 'p';
    name[1] = '0' + i;
    unlink(name);
    name[0] = 'c';
    1ffb:	c6 45 d4 63          	movb   $0x63,-0x2c(%ebp)
    unlink(name);
    1fff:	89 14 24             	mov    %edx,(%esp)
    2002:	e8 51 13 00 00       	call   3358 <unlink>
    }
    if(fd >= 0)
      close(fd);
  }

  for(i = 0; i < N; i++){
    2007:	83 fb 14             	cmp    $0x14,%ebx
    200a:	75 d4                	jne    1fe0 <createdelete+0x1f0>
    unlink(name);
    name[0] = 'c';
    unlink(name);
  }

  printf(1, "createdelete ok\n");
    200c:	c7 44 24 04 f7 40 00 	movl   $0x40f7,0x4(%esp)
    2013:	00 
    2014:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    201b:	e8 40 14 00 00       	call   3460 <printf>
}
    2020:	83 c4 3c             	add    $0x3c,%esp
    2023:	5b                   	pop    %ebx
    2024:	5e                   	pop    %esi
    2025:	5f                   	pop    %edi
    2026:	5d                   	pop    %ebp
    2027:	c3                   	ret    
  name[2] = '\0';
  for(i = 0; i < N; i++){
    name[1] = '0' + i;
    fd = open(name, O_CREATE | O_RDWR);
    if(fd < 0){
      printf(1, "create failed\n");
    2028:	c7 44 24 04 15 3f 00 	movl   $0x3f15,0x4(%esp)
    202f:	00 
    2030:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2037:	e8 24 14 00 00       	call   3460 <printf>
      exit();
    203c:	e8 c7 12 00 00       	call   3308 <exit>

    name[0] = 'c';
    name[1] = '0' + i;
    fd = open(name, 0);
    if((i == 0 || i >= N/2) && fd < 0){
      printf(1, "oops createdelete %s didn't exist\n", name);
    2041:	8d 4d d4             	lea    -0x2c(%ebp),%ecx
    2044:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    2048:	c7 44 24 04 a4 49 00 	movl   $0x49a4,0x4(%esp)
    204f:	00 
    2050:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2057:	e8 04 14 00 00       	call   3460 <printf>
      exit();
    205c:	e8 a7 12 00 00       	call   3308 <exit>
  for(i = 0; i < N; i++){
    name[0] = 'p';
    name[1] = '0' + i;
    fd = open(name, 0);
    if((i == 0 || i >= N/2) && fd < 0){
      printf(1, "oops createdelete %s didn't exist\n", name);
    2061:	8d 55 d4             	lea    -0x2c(%ebp),%edx
    2064:	89 54 24 08          	mov    %edx,0x8(%esp)
    2068:	c7 44 24 04 a4 49 00 	movl   $0x49a4,0x4(%esp)
    206f:	00 
    2070:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2077:	e8 e4 13 00 00       	call   3460 <printf>
    207c:	e9 b1 fe ff ff       	jmp    1f32 <createdelete+0x142>
  char name[32];

  printf(1, "createdelete test\n");
  pid = fork();
  if(pid < 0){
    printf(1, "fork failed\n");
    2081:	c7 44 24 04 61 38 00 	movl   $0x3861,0x4(%esp)
    2088:	00 
    2089:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2090:	e8 cb 13 00 00       	call   3460 <printf>
    exit();
    2095:	e8 6e 12 00 00       	call   3308 <exit>
    209a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000020a0 <dirtest>:
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
}

void dirtest(void)
{
    20a0:	55                   	push   %ebp
    20a1:	89 e5                	mov    %esp,%ebp
    20a3:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "mkdir test\n");
    20a6:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    20ab:	c7 44 24 04 08 41 00 	movl   $0x4108,0x4(%esp)
    20b2:	00 
    20b3:	89 04 24             	mov    %eax,(%esp)
    20b6:	e8 a5 13 00 00       	call   3460 <printf>

  if(mkdir("dir0") < 0) {
    20bb:	c7 04 24 14 41 00 00 	movl   $0x4114,(%esp)
    20c2:	e8 a9 12 00 00       	call   3370 <mkdir>
    20c7:	85 c0                	test   %eax,%eax
    20c9:	78 47                	js     2112 <dirtest+0x72>
    printf(stdout, "mkdir failed\n");
    exit();
  }

  if(chdir("dir0") < 0) {
    20cb:	c7 04 24 14 41 00 00 	movl   $0x4114,(%esp)
    20d2:	e8 a1 12 00 00       	call   3378 <chdir>
    20d7:	85 c0                	test   %eax,%eax
    20d9:	78 51                	js     212c <dirtest+0x8c>
    printf(stdout, "chdir dir0 failed\n");
    exit();
  }

  if(chdir("..") < 0) {
    20db:	c7 04 24 16 3d 00 00 	movl   $0x3d16,(%esp)
    20e2:	e8 91 12 00 00       	call   3378 <chdir>
    20e7:	85 c0                	test   %eax,%eax
    20e9:	78 5b                	js     2146 <dirtest+0xa6>
    printf(stdout, "chdir .. failed\n");
    exit();
  }

  if(unlink("dir0") < 0) {
    20eb:	c7 04 24 14 41 00 00 	movl   $0x4114,(%esp)
    20f2:	e8 61 12 00 00       	call   3358 <unlink>
    20f7:	85 c0                	test   %eax,%eax
    20f9:	78 65                	js     2160 <dirtest+0xc0>
    printf(stdout, "unlink dir0 failed\n");
    exit();
  }
  printf(stdout, "mkdir test\n");
    20fb:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    2100:	c7 44 24 04 08 41 00 	movl   $0x4108,0x4(%esp)
    2107:	00 
    2108:	89 04 24             	mov    %eax,(%esp)
    210b:	e8 50 13 00 00       	call   3460 <printf>
}
    2110:	c9                   	leave  
    2111:	c3                   	ret    
void dirtest(void)
{
  printf(stdout, "mkdir test\n");

  if(mkdir("dir0") < 0) {
    printf(stdout, "mkdir failed\n");
    2112:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    2117:	c7 44 24 04 19 41 00 	movl   $0x4119,0x4(%esp)
    211e:	00 
    211f:	89 04 24             	mov    %eax,(%esp)
    2122:	e8 39 13 00 00       	call   3460 <printf>
    exit();
    2127:	e8 dc 11 00 00       	call   3308 <exit>
  }

  if(chdir("dir0") < 0) {
    printf(stdout, "chdir dir0 failed\n");
    212c:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    2131:	c7 44 24 04 27 41 00 	movl   $0x4127,0x4(%esp)
    2138:	00 
    2139:	89 04 24             	mov    %eax,(%esp)
    213c:	e8 1f 13 00 00       	call   3460 <printf>
    exit();
    2141:	e8 c2 11 00 00       	call   3308 <exit>
  }

  if(chdir("..") < 0) {
    printf(stdout, "chdir .. failed\n");
    2146:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    214b:	c7 44 24 04 3a 41 00 	movl   $0x413a,0x4(%esp)
    2152:	00 
    2153:	89 04 24             	mov    %eax,(%esp)
    2156:	e8 05 13 00 00       	call   3460 <printf>
    exit();
    215b:	e8 a8 11 00 00       	call   3308 <exit>
  }

  if(unlink("dir0") < 0) {
    printf(stdout, "unlink dir0 failed\n");
    2160:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    2165:	c7 44 24 04 4b 41 00 	movl   $0x414b,0x4(%esp)
    216c:	00 
    216d:	89 04 24             	mov    %eax,(%esp)
    2170:	e8 eb 12 00 00       	call   3460 <printf>
    exit();
    2175:	e8 8e 11 00 00       	call   3308 <exit>
    217a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00002180 <createtest>:
  printf(stdout, "big files ok\n");
}

void
createtest(void)
{
    2180:	55                   	push   %ebp
    2181:	89 e5                	mov    %esp,%ebp
    2183:	53                   	push   %ebx
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++) {
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
    2184:	bb 01 00 00 00       	mov    $0x1,%ebx
  printf(stdout, "big files ok\n");
}

void
createtest(void)
{
    2189:	83 ec 14             	sub    $0x14,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
    218c:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    2191:	c7 44 24 04 e8 49 00 	movl   $0x49e8,0x4(%esp)
    2198:	00 
    2199:	89 04 24             	mov    %eax,(%esp)
    219c:	e8 bf 12 00 00       	call   3460 <printf>

  name[0] = 'a';
    21a1:	c6 05 e0 53 00 00 61 	movb   $0x61,0x53e0
  name[2] = '\0';
    21a8:	c6 05 e2 53 00 00 00 	movb   $0x0,0x53e2
  for(i = 0; i < 52; i++) {
    name[1] = '0' + i;
    21af:	c6 05 e1 53 00 00 30 	movb   $0x30,0x53e1
    fd = open(name, O_CREATE|O_RDWR);
    21b6:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    21bd:	00 
    21be:	c7 04 24 e0 53 00 00 	movl   $0x53e0,(%esp)
    21c5:	e8 7e 11 00 00       	call   3348 <open>
    close(fd);
    21ca:	89 04 24             	mov    %eax,(%esp)
    21cd:	e8 5e 11 00 00       	call   3330 <close>
  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++) {
    name[1] = '0' + i;
    21d2:	8d 43 30             	lea    0x30(%ebx),%eax

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++) {
    21d5:	83 c3 01             	add    $0x1,%ebx
    name[1] = '0' + i;
    21d8:	a2 e1 53 00 00       	mov    %al,0x53e1
    fd = open(name, O_CREATE|O_RDWR);
    21dd:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    21e4:	00 
    21e5:	c7 04 24 e0 53 00 00 	movl   $0x53e0,(%esp)
    21ec:	e8 57 11 00 00       	call   3348 <open>
    close(fd);
    21f1:	89 04 24             	mov    %eax,(%esp)
    21f4:	e8 37 11 00 00       	call   3330 <close>

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++) {
    21f9:	83 fb 34             	cmp    $0x34,%ebx
    21fc:	75 d4                	jne    21d2 <createtest+0x52>
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
    21fe:	c6 05 e0 53 00 00 61 	movb   $0x61,0x53e0
  name[2] = '\0';
  for(i = 0; i < 52; i++) {
    name[1] = '0' + i;
    unlink(name);
    2205:	b3 01                	mov    $0x1,%bl
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
    2207:	c6 05 e2 53 00 00 00 	movb   $0x0,0x53e2
  for(i = 0; i < 52; i++) {
    name[1] = '0' + i;
    220e:	c6 05 e1 53 00 00 30 	movb   $0x30,0x53e1
    unlink(name);
    2215:	c7 04 24 e0 53 00 00 	movl   $0x53e0,(%esp)
    221c:	e8 37 11 00 00       	call   3358 <unlink>
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++) {
    name[1] = '0' + i;
    2221:	8d 43 30             	lea    0x30(%ebx),%eax
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++) {
    2224:	83 c3 01             	add    $0x1,%ebx
    name[1] = '0' + i;
    2227:	a2 e1 53 00 00       	mov    %al,0x53e1
    unlink(name);
    222c:	c7 04 24 e0 53 00 00 	movl   $0x53e0,(%esp)
    2233:	e8 20 11 00 00       	call   3358 <unlink>
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++) {
    2238:	83 fb 34             	cmp    $0x34,%ebx
    223b:	75 e4                	jne    2221 <createtest+0xa1>
    name[1] = '0' + i;
    unlink(name);
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
    223d:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    2242:	c7 44 24 04 10 4a 00 	movl   $0x4a10,0x4(%esp)
    2249:	00 
    224a:	89 04 24             	mov    %eax,(%esp)
    224d:	e8 0e 12 00 00       	call   3460 <printf>
}
    2252:	83 c4 14             	add    $0x14,%esp
    2255:	5b                   	pop    %ebx
    2256:	5d                   	pop    %ebp
    2257:	c3                   	ret    
    2258:	90                   	nop    
    2259:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00002260 <writetest1>:
  printf(stdout, "small file test ok\n");
}

void
writetest1(void)
{
    2260:	55                   	push   %ebp
    2261:	89 e5                	mov    %esp,%ebp
    2263:	56                   	push   %esi
    2264:	53                   	push   %ebx
  printf(stdout, "big files test\n");

  fd = open("big", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
    exit();
    2265:	31 db                	xor    %ebx,%ebx
  printf(stdout, "small file test ok\n");
}

void
writetest1(void)
{
    2267:	83 ec 10             	sub    $0x10,%esp
  int i, fd, n;

  printf(stdout, "big files test\n");
    226a:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    226f:	c7 44 24 04 5f 41 00 	movl   $0x415f,0x4(%esp)
    2276:	00 
    2277:	89 04 24             	mov    %eax,(%esp)
    227a:	e8 e1 11 00 00       	call   3460 <printf>

  fd = open("big", O_CREATE|O_RDWR);
    227f:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    2286:	00 
    2287:	c7 04 24 d9 41 00 00 	movl   $0x41d9,(%esp)
    228e:	e8 b5 10 00 00       	call   3348 <open>
  if(fd < 0){
    2293:	85 c0                	test   %eax,%eax
{
  int i, fd, n;

  printf(stdout, "big files test\n");

  fd = open("big", O_CREATE|O_RDWR);
    2295:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2297:	79 12                	jns    22ab <writetest1+0x4b>
    2299:	e9 37 01 00 00       	jmp    23d5 <writetest1+0x175>
    229e:	66 90                	xchg   %ax,%ax
    printf(stdout, "error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++) {
    22a0:	83 c3 01             	add    $0x1,%ebx
    22a3:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
    22a9:	74 43                	je     22ee <writetest1+0x8e>
    ((int*) buf)[0] = i;
    22ab:	89 1d e0 4b 00 00    	mov    %ebx,0x4be0
    if(write(fd, buf, 512) != 512) {
    22b1:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    22b8:	00 
    22b9:	c7 44 24 04 e0 4b 00 	movl   $0x4be0,0x4(%esp)
    22c0:	00 
    22c1:	89 34 24             	mov    %esi,(%esp)
    22c4:	e8 5f 10 00 00       	call   3328 <write>
    22c9:	3d 00 02 00 00       	cmp    $0x200,%eax
    22ce:	74 d0                	je     22a0 <writetest1+0x40>
      printf(stdout, "error: write big file failed\n", i);
    22d0:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    22d5:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    22d9:	c7 44 24 04 89 41 00 	movl   $0x4189,0x4(%esp)
    22e0:	00 
    22e1:	89 04 24             	mov    %eax,(%esp)
    22e4:	e8 77 11 00 00       	call   3460 <printf>
      exit();
    22e9:	e8 1a 10 00 00       	call   3308 <exit>
    }
  }

  close(fd);
    22ee:	89 34 24             	mov    %esi,(%esp)

  fd = open("big", O_RDONLY);
  if(fd < 0){
    printf(stdout, "error: open big failed!\n");
    exit();
    22f1:	31 f6                	xor    %esi,%esi
      printf(stdout, "error: write big file failed\n", i);
      exit();
    }
  }

  close(fd);
    22f3:	e8 38 10 00 00       	call   3330 <close>

  fd = open("big", O_RDONLY);
    22f8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    22ff:	00 
    2300:	c7 04 24 d9 41 00 00 	movl   $0x41d9,(%esp)
    2307:	e8 3c 10 00 00       	call   3348 <open>
  if(fd < 0){
    230c:	85 c0                	test   %eax,%eax
    }
  }

  close(fd);

  fd = open("big", O_RDONLY);
    230e:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    2310:	79 20                	jns    2332 <writetest1+0xd2>
    2312:	e9 fa 00 00 00       	jmp    2411 <writetest1+0x1b1>
      if(n == MAXFILE - 1) {
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512) {
    2317:	3d 00 02 00 00       	cmp    $0x200,%eax
    231c:	8d 74 26 00          	lea    0x0(%esi),%esi
    2320:	75 73                	jne    2395 <writetest1+0x135>
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n) {
    2322:	a1 e0 4b 00 00       	mov    0x4be0,%eax
    2327:	39 f0                	cmp    %esi,%eax
    2329:	0f 85 84 00 00 00    	jne    23b3 <writetest1+0x153>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
    232f:	8d 70 01             	lea    0x1(%eax),%esi
    exit();
  }

  n = 0;
  for(;;) {
    i = read(fd, buf, 512);
    2332:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    2339:	00 
    233a:	c7 44 24 04 e0 4b 00 	movl   $0x4be0,0x4(%esp)
    2341:	00 
    2342:	89 1c 24             	mov    %ebx,(%esp)
    2345:	e8 d6 0f 00 00       	call   3320 <read>
    if(i == 0) {
    234a:	85 c0                	test   %eax,%eax
    234c:	75 c9                	jne    2317 <writetest1+0xb7>
      if(n == MAXFILE - 1) {
    234e:	81 fe 8b 00 00 00    	cmp    $0x8b,%esi
    2354:	0f 84 95 00 00 00    	je     23ef <writetest1+0x18f>
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
  }
  close(fd);
    235a:	89 1c 24             	mov    %ebx,(%esp)
    235d:	8d 76 00             	lea    0x0(%esi),%esi
    2360:	e8 cb 0f 00 00       	call   3330 <close>
  if(unlink("big") < 0) {
    2365:	c7 04 24 d9 41 00 00 	movl   $0x41d9,(%esp)
    236c:	e8 e7 0f 00 00       	call   3358 <unlink>
    2371:	85 c0                	test   %eax,%eax
    2373:	0f 88 b2 00 00 00    	js     242b <writetest1+0x1cb>
    printf(stdout, "unlink big failed\n");
    exit();
  }
  printf(stdout, "big files ok\n");
    2379:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    237e:	c7 44 24 04 00 42 00 	movl   $0x4200,0x4(%esp)
    2385:	00 
    2386:	89 04 24             	mov    %eax,(%esp)
    2389:	e8 d2 10 00 00       	call   3460 <printf>
}
    238e:	83 c4 10             	add    $0x10,%esp
    2391:	5b                   	pop    %ebx
    2392:	5e                   	pop    %esi
    2393:	5d                   	pop    %ebp
    2394:	c3                   	ret    
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512) {
      printf(stdout, "read failed %d\n", i);
    2395:	89 44 24 08          	mov    %eax,0x8(%esp)
    2399:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    239e:	c7 44 24 04 dd 41 00 	movl   $0x41dd,0x4(%esp)
    23a5:	00 
    23a6:	89 04 24             	mov    %eax,(%esp)
    23a9:	e8 b2 10 00 00       	call   3460 <printf>
      exit();
    23ae:	e8 55 0f 00 00       	call   3308 <exit>
    }
    if(((int*)buf)[0] != n) {
      printf(stdout, "read content of block %d is %d\n",
    23b3:	89 44 24 0c          	mov    %eax,0xc(%esp)
    23b7:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    23bc:	89 74 24 08          	mov    %esi,0x8(%esp)
    23c0:	c7 44 24 04 38 4a 00 	movl   $0x4a38,0x4(%esp)
    23c7:	00 
    23c8:	89 04 24             	mov    %eax,(%esp)
    23cb:	e8 90 10 00 00       	call   3460 <printf>
             n, ((int*)buf)[0]);
      exit();
    23d0:	e8 33 0f 00 00       	call   3308 <exit>

  printf(stdout, "big files test\n");

  fd = open("big", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
    23d5:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    23da:	c7 44 24 04 6f 41 00 	movl   $0x416f,0x4(%esp)
    23e1:	00 
    23e2:	89 04 24             	mov    %eax,(%esp)
    23e5:	e8 76 10 00 00       	call   3460 <printf>
    exit();
    23ea:	e8 19 0f 00 00       	call   3308 <exit>
  n = 0;
  for(;;) {
    i = read(fd, buf, 512);
    if(i == 0) {
      if(n == MAXFILE - 1) {
        printf(stdout, "read only %d blocks from big", n);
    23ef:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    23f4:	c7 44 24 08 8b 00 00 	movl   $0x8b,0x8(%esp)
    23fb:	00 
    23fc:	c7 44 24 04 c0 41 00 	movl   $0x41c0,0x4(%esp)
    2403:	00 
    2404:	89 04 24             	mov    %eax,(%esp)
    2407:	e8 54 10 00 00       	call   3460 <printf>
        exit();
    240c:	e8 f7 0e 00 00       	call   3308 <exit>

  close(fd);

  fd = open("big", O_RDONLY);
  if(fd < 0){
    printf(stdout, "error: open big failed!\n");
    2411:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    2416:	c7 44 24 04 a7 41 00 	movl   $0x41a7,0x4(%esp)
    241d:	00 
    241e:	89 04 24             	mov    %eax,(%esp)
    2421:	e8 3a 10 00 00       	call   3460 <printf>
    exit();
    2426:	e8 dd 0e 00 00       	call   3308 <exit>
    }
    n++;
  }
  close(fd);
  if(unlink("big") < 0) {
    printf(stdout, "unlink big failed\n");
    242b:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    2430:	c7 44 24 04 ed 41 00 	movl   $0x41ed,0x4(%esp)
    2437:	00 
    2438:	89 04 24             	mov    %eax,(%esp)
    243b:	e8 20 10 00 00       	call   3460 <printf>
    exit();
    2440:	e8 c3 0e 00 00       	call   3308 <exit>
    2445:	8d 74 26 00          	lea    0x0(%esi),%esi
    2449:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00002450 <writetest>:
  printf(stdout, "open test ok\n");
}

void
writetest(void)
{
    2450:	55                   	push   %ebp
    2451:	89 e5                	mov    %esp,%ebp
    2453:	56                   	push   %esi
    2454:	53                   	push   %ebx
    2455:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int i;

  printf(stdout, "small file test\n");
    2458:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    245d:	c7 44 24 04 0e 42 00 	movl   $0x420e,0x4(%esp)
    2464:	00 
    2465:	89 04 24             	mov    %eax,(%esp)
    2468:	e8 f3 0f 00 00       	call   3460 <printf>
  fd = open("small", O_CREATE|O_RDWR);
    246d:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    2474:	00 
    2475:	c7 04 24 1f 42 00 00 	movl   $0x421f,(%esp)
    247c:	e8 c7 0e 00 00       	call   3348 <open>
  if(fd >= 0){
    2481:	85 c0                	test   %eax,%eax
{
  int fd;
  int i;

  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
    2483:	89 c6                	mov    %eax,%esi
  if(fd >= 0){
    2485:	0f 88 4f 01 00 00    	js     25da <writetest+0x18a>
    printf(stdout, "creat small succeeded; ok\n");
    248b:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    2490:	31 db                	xor    %ebx,%ebx
    2492:	c7 44 24 04 25 42 00 	movl   $0x4225,0x4(%esp)
    2499:	00 
    249a:	89 04 24             	mov    %eax,(%esp)
    249d:	e8 be 0f 00 00       	call   3460 <printf>
    24a2:	eb 25                	jmp    24c9 <writetest+0x79>
  for(i = 0; i < 100; i++) {
    if(write(fd, "aaaaaaaaaa", 10) != 10) {
      printf(stdout, "error: write aa %d new file failed\n", i);
      exit();
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10) {
    24a4:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    24ab:	00 
    24ac:	c7 44 24 04 67 42 00 	movl   $0x4267,0x4(%esp)
    24b3:	00 
    24b4:	89 34 24             	mov    %esi,(%esp)
    24b7:	e8 6c 0e 00 00       	call   3328 <write>
    24bc:	83 f8 0a             	cmp    $0xa,%eax
    24bf:	75 43                	jne    2504 <writetest+0xb4>
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++) {
    24c1:	83 c3 01             	add    $0x1,%ebx
    24c4:	83 fb 64             	cmp    $0x64,%ebx
    24c7:	74 59                	je     2522 <writetest+0xd2>
    if(write(fd, "aaaaaaaaaa", 10) != 10) {
    24c9:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    24d0:	00 
    24d1:	c7 44 24 04 5c 42 00 	movl   $0x425c,0x4(%esp)
    24d8:	00 
    24d9:	89 34 24             	mov    %esi,(%esp)
    24dc:	e8 47 0e 00 00       	call   3328 <write>
    24e1:	83 f8 0a             	cmp    $0xa,%eax
    24e4:	74 be                	je     24a4 <writetest+0x54>
      printf(stdout, "error: write aa %d new file failed\n", i);
    24e6:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    24eb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    24ef:	c7 44 24 04 58 4a 00 	movl   $0x4a58,0x4(%esp)
    24f6:	00 
    24f7:	89 04 24             	mov    %eax,(%esp)
    24fa:	e8 61 0f 00 00       	call   3460 <printf>
      exit();
    24ff:	e8 04 0e 00 00       	call   3308 <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10) {
      printf(stdout, "error: write bb %d new file failed\n", i);
    2504:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    2509:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    250d:	c7 44 24 04 7c 4a 00 	movl   $0x4a7c,0x4(%esp)
    2514:	00 
    2515:	89 04 24             	mov    %eax,(%esp)
    2518:	e8 43 0f 00 00       	call   3460 <printf>
      exit();
    251d:	e8 e6 0d 00 00       	call   3308 <exit>
    }
  }
  printf(stdout, "writes ok\n");
    2522:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    2527:	c7 44 24 04 72 42 00 	movl   $0x4272,0x4(%esp)
    252e:	00 
    252f:	89 04 24             	mov    %eax,(%esp)
    2532:	e8 29 0f 00 00       	call   3460 <printf>
  close(fd);
    2537:	89 34 24             	mov    %esi,(%esp)
    253a:	e8 f1 0d 00 00       	call   3330 <close>
  fd = open("small", O_RDONLY);
    253f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2546:	00 
    2547:	c7 04 24 1f 42 00 00 	movl   $0x421f,(%esp)
    254e:	e8 f5 0d 00 00       	call   3348 <open>
  if(fd >= 0){
    2553:	85 c0                	test   %eax,%eax
      exit();
    }
  }
  printf(stdout, "writes ok\n");
  close(fd);
  fd = open("small", O_RDONLY);
    2555:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
    2557:	0f 88 97 00 00 00    	js     25f4 <writetest+0x1a4>
    printf(stdout, "open small succeeded ok\n");
    255d:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    2562:	c7 44 24 04 7d 42 00 	movl   $0x427d,0x4(%esp)
    2569:	00 
    256a:	89 04 24             	mov    %eax,(%esp)
    256d:	e8 ee 0e 00 00       	call   3460 <printf>
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
    2572:	c7 44 24 08 d0 07 00 	movl   $0x7d0,0x8(%esp)
    2579:	00 
    257a:	c7 44 24 04 e0 4b 00 	movl   $0x4be0,0x4(%esp)
    2581:	00 
    2582:	89 1c 24             	mov    %ebx,(%esp)
    2585:	e8 96 0d 00 00       	call   3320 <read>
  if(i == 2000) {
    258a:	3d d0 07 00 00       	cmp    $0x7d0,%eax
    258f:	75 7d                	jne    260e <writetest+0x1be>
    printf(stdout, "read succeeded ok\n");
    2591:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    2596:	c7 44 24 04 b1 42 00 	movl   $0x42b1,0x4(%esp)
    259d:	00 
    259e:	89 04 24             	mov    %eax,(%esp)
    25a1:	e8 ba 0e 00 00       	call   3460 <printf>
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
    25a6:	89 1c 24             	mov    %ebx,(%esp)
    25a9:	e8 82 0d 00 00       	call   3330 <close>

  if(unlink("small") < 0) {
    25ae:	c7 04 24 1f 42 00 00 	movl   $0x421f,(%esp)
    25b5:	e8 9e 0d 00 00       	call   3358 <unlink>
    25ba:	85 c0                	test   %eax,%eax
    25bc:	78 6a                	js     2628 <writetest+0x1d8>
    printf(stdout, "unlink small failed\n");
    exit();
  }
  printf(stdout, "small file test ok\n");
    25be:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    25c3:	c7 44 24 04 d9 42 00 	movl   $0x42d9,0x4(%esp)
    25ca:	00 
    25cb:	89 04 24             	mov    %eax,(%esp)
    25ce:	e8 8d 0e 00 00       	call   3460 <printf>
}
    25d3:	83 c4 10             	add    $0x10,%esp
    25d6:	5b                   	pop    %ebx
    25d7:	5e                   	pop    %esi
    25d8:	5d                   	pop    %ebp
    25d9:	c3                   	ret    
  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
    25da:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    25df:	c7 44 24 04 40 42 00 	movl   $0x4240,0x4(%esp)
    25e6:	00 
    25e7:	89 04 24             	mov    %eax,(%esp)
    25ea:	e8 71 0e 00 00       	call   3460 <printf>
    exit();
    25ef:	e8 14 0d 00 00       	call   3308 <exit>
  close(fd);
  fd = open("small", O_RDONLY);
  if(fd >= 0){
    printf(stdout, "open small succeeded ok\n");
  } else {
    printf(stdout, "error: open small failed!\n");
    25f4:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    25f9:	c7 44 24 04 96 42 00 	movl   $0x4296,0x4(%esp)
    2600:	00 
    2601:	89 04 24             	mov    %eax,(%esp)
    2604:	e8 57 0e 00 00       	call   3460 <printf>
    exit();
    2609:	e8 fa 0c 00 00       	call   3308 <exit>
  }
  i = read(fd, buf, 2000);
  if(i == 2000) {
    printf(stdout, "read succeeded ok\n");
  } else {
    printf(stdout, "read failed\n");
    260e:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    2613:	c7 44 24 04 3c 40 00 	movl   $0x403c,0x4(%esp)
    261a:	00 
    261b:	89 04 24             	mov    %eax,(%esp)
    261e:	e8 3d 0e 00 00       	call   3460 <printf>
    exit();
    2623:	e8 e0 0c 00 00       	call   3308 <exit>
  }
  close(fd);

  if(unlink("small") < 0) {
    printf(stdout, "unlink small failed\n");
    2628:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    262d:	c7 44 24 04 c4 42 00 	movl   $0x42c4,0x4(%esp)
    2634:	00 
    2635:	89 04 24             	mov    %eax,(%esp)
    2638:	e8 23 0e 00 00       	call   3460 <printf>
    exit();
    263d:	e8 c6 0c 00 00       	call   3308 <exit>
    2642:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
    2649:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00002650 <bigfile>:
  printf(1, "subdir ok\n");
}

void
bigfile(void)
{
    2650:	55                   	push   %ebp
    2651:	89 e5                	mov    %esp,%ebp
    2653:	57                   	push   %edi
    2654:	56                   	push   %esi
    2655:	53                   	push   %ebx

  unlink("bigfile");
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    exit();
    2656:	31 db                	xor    %ebx,%ebx
  printf(1, "subdir ok\n");
}

void
bigfile(void)
{
    2658:	83 ec 0c             	sub    $0xc,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    265b:	c7 44 24 04 ed 42 00 	movl   $0x42ed,0x4(%esp)
    2662:	00 
    2663:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    266a:	e8 f1 0d 00 00       	call   3460 <printf>

  unlink("bigfile");
    266f:	c7 04 24 09 43 00 00 	movl   $0x4309,(%esp)
    2676:	e8 dd 0c 00 00       	call   3358 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    267b:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    2682:	00 
    2683:	c7 04 24 09 43 00 00 	movl   $0x4309,(%esp)
    268a:	e8 b9 0c 00 00       	call   3348 <open>
  if(fd < 0){
    268f:	85 c0                	test   %eax,%eax
  int fd, i, total, cc;

  printf(1, "bigfile test\n");

  unlink("bigfile");
  fd = open("bigfile", O_CREATE | O_RDWR);
    2691:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2693:	0f 88 69 01 00 00    	js     2802 <bigfile+0x1b2>
    2699:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    26a0:	c7 44 24 08 58 02 00 	movl   $0x258,0x8(%esp)
    26a7:	00 
    26a8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    26ac:	c7 04 24 e0 4b 00 00 	movl   $0x4be0,(%esp)
    26b3:	e8 e8 0a 00 00       	call   31a0 <memset>
    if(write(fd, buf, 600) != 600){
    26b8:	c7 44 24 08 58 02 00 	movl   $0x258,0x8(%esp)
    26bf:	00 
    26c0:	c7 44 24 04 e0 4b 00 	movl   $0x4be0,0x4(%esp)
    26c7:	00 
    26c8:	89 34 24             	mov    %esi,(%esp)
    26cb:	e8 58 0c 00 00       	call   3328 <write>
    26d0:	3d 58 02 00 00       	cmp    $0x258,%eax
    26d5:	0f 85 dc 00 00 00    	jne    27b7 <bigfile+0x167>
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    26db:	83 c3 01             	add    $0x1,%ebx
    26de:	83 fb 14             	cmp    $0x14,%ebx
    26e1:	75 bd                	jne    26a0 <bigfile+0x50>
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
      exit();
    }
  }
  close(fd);
    26e3:	89 34 24             	mov    %esi,(%esp)

  fd = open("bigfile", 0);
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    exit();
    26e6:	30 db                	xor    %bl,%bl
    26e8:	31 ff                	xor    %edi,%edi
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
      exit();
    }
  }
  close(fd);
    26ea:	e8 41 0c 00 00       	call   3330 <close>

  fd = open("bigfile", 0);
    26ef:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    26f6:	00 
    26f7:	c7 04 24 09 43 00 00 	movl   $0x4309,(%esp)
    26fe:	e8 45 0c 00 00       	call   3348 <open>
  if(fd < 0){
    2703:	85 c0                	test   %eax,%eax
      exit();
    }
  }
  close(fd);

  fd = open("bigfile", 0);
    2705:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2707:	79 3a                	jns    2743 <bigfile+0xf3>
    2709:	e9 0d 01 00 00       	jmp    281b <bigfile+0x1cb>
    270e:	66 90                	xchg   %ax,%ax
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
      break;
    if(cc != 300){
    2710:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    2715:	0f 85 ce 00 00 00    	jne    27e9 <bigfile+0x199>
      printf(1, "short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    271b:	0f be 15 e0 4b 00 00 	movsbl 0x4be0,%edx
    2722:	89 d8                	mov    %ebx,%eax
    2724:	c1 e8 1f             	shr    $0x1f,%eax
    2727:	01 d8                	add    %ebx,%eax
    2729:	d1 f8                	sar    %eax
    272b:	39 c2                	cmp    %eax,%edx
    272d:	75 6f                	jne    279e <bigfile+0x14e>
    272f:	0f be 05 0b 4d 00 00 	movsbl 0x4d0b,%eax
    2736:	39 c2                	cmp    %eax,%edx
    2738:	75 64                	jne    279e <bigfile+0x14e>
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
    273a:	81 c7 2c 01 00 00    	add    $0x12c,%edi
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    exit();
  }
  total = 0;
  for(i = 0; ; i++){
    2740:	83 c3 01             	add    $0x1,%ebx
    cc = read(fd, buf, 300);
    2743:	c7 44 24 08 2c 01 00 	movl   $0x12c,0x8(%esp)
    274a:	00 
    274b:	c7 44 24 04 e0 4b 00 	movl   $0x4be0,0x4(%esp)
    2752:	00 
    2753:	89 34 24             	mov    %esi,(%esp)
    2756:	e8 c5 0b 00 00       	call   3320 <read>
    if(cc < 0){
    275b:	83 f8 00             	cmp    $0x0,%eax
    275e:	7c 70                	jl     27d0 <bigfile+0x180>
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
    2760:	75 ae                	jne    2710 <bigfile+0xc0>
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
  }
  close(fd);
    2762:	89 34 24             	mov    %esi,(%esp)
    2765:	e8 c6 0b 00 00       	call   3330 <close>
  if(total != 20*600){
    276a:	81 ff e0 2e 00 00    	cmp    $0x2ee0,%edi
    2770:	0f 85 be 00 00 00    	jne    2834 <bigfile+0x1e4>
    printf(1, "read bigfile wrong total\n");
    exit();
  }
  unlink("bigfile");
    2776:	c7 04 24 09 43 00 00 	movl   $0x4309,(%esp)
    277d:	e8 d6 0b 00 00       	call   3358 <unlink>

  printf(1, "bigfile test ok\n");
    2782:	c7 44 24 04 98 43 00 	movl   $0x4398,0x4(%esp)
    2789:	00 
    278a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2791:	e8 ca 0c 00 00       	call   3460 <printf>
}
    2796:	83 c4 0c             	add    $0xc,%esp
    2799:	5b                   	pop    %ebx
    279a:	5e                   	pop    %esi
    279b:	5f                   	pop    %edi
    279c:	5d                   	pop    %ebp
    279d:	c3                   	ret    
    if(cc != 300){
      printf(1, "short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
      printf(1, "read bigfile wrong data\n");
    279e:	c7 44 24 04 65 43 00 	movl   $0x4365,0x4(%esp)
    27a5:	00 
    27a6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27ad:	e8 ae 0c 00 00       	call   3460 <printf>
      exit();
    27b2:	e8 51 0b 00 00       	call   3308 <exit>
    exit();
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
    27b7:	c7 44 24 04 11 43 00 	movl   $0x4311,0x4(%esp)
    27be:	00 
    27bf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27c6:	e8 95 0c 00 00       	call   3460 <printf>
      exit();
    27cb:	e8 38 0b 00 00       	call   3308 <exit>
  }
  total = 0;
  for(i = 0; ; i++){
    cc = read(fd, buf, 300);
    if(cc < 0){
      printf(1, "read bigfile failed\n");
    27d0:	c7 44 24 04 3c 43 00 	movl   $0x433c,0x4(%esp)
    27d7:	00 
    27d8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27df:	e8 7c 0c 00 00       	call   3460 <printf>
      exit();
    27e4:	e8 1f 0b 00 00       	call   3308 <exit>
    }
    if(cc == 0)
      break;
    if(cc != 300){
      printf(1, "short read bigfile\n");
    27e9:	c7 44 24 04 51 43 00 	movl   $0x4351,0x4(%esp)
    27f0:	00 
    27f1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27f8:	e8 63 0c 00 00       	call   3460 <printf>
      exit();
    27fd:	e8 06 0b 00 00       	call   3308 <exit>
  printf(1, "bigfile test\n");

  unlink("bigfile");
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    2802:	c7 44 24 04 fb 42 00 	movl   $0x42fb,0x4(%esp)
    2809:	00 
    280a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2811:	e8 4a 0c 00 00       	call   3460 <printf>
    exit();
    2816:	e8 ed 0a 00 00       	call   3308 <exit>
  }
  close(fd);

  fd = open("bigfile", 0);
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    281b:	c7 44 24 04 27 43 00 	movl   $0x4327,0x4(%esp)
    2822:	00 
    2823:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    282a:	e8 31 0c 00 00       	call   3460 <printf>
    exit();
    282f:	e8 d4 0a 00 00       	call   3308 <exit>
    }
    total += cc;
  }
  close(fd);
  if(total != 20*600){
    printf(1, "read bigfile wrong total\n");
    2834:	c7 44 24 04 7e 43 00 	movl   $0x437e,0x4(%esp)
    283b:	00 
    283c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2843:	e8 18 0c 00 00       	call   3460 <printf>
    exit();
    2848:	e8 bb 0a 00 00       	call   3308 <exit>
    284d:	8d 76 00             	lea    0x0(%esi),%esi

00002850 <concreate>:
}

// test concurrent create and unlink of the same file
void
concreate(void)
{
    2850:	55                   	push   %ebp
    2851:	89 e5                	mov    %esp,%ebp
    2853:	57                   	push   %edi
    2854:	56                   	push   %esi
    2855:	53                   	push   %ebx
    char name[14];
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
    2856:	31 db                	xor    %ebx,%ebx
}

// test concurrent create and unlink of the same file
void
concreate(void)
{
    2858:	83 ec 5c             	sub    $0x5c,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    285b:	c7 44 24 04 a9 43 00 	movl   $0x43a9,0x4(%esp)
    2862:	00 
    2863:	8d 7d f1             	lea    -0xf(%ebp),%edi
    2866:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    286d:	e8 ee 0b 00 00       	call   3460 <printf>
  file[0] = 'C';
    2872:	c6 45 f1 43          	movb   $0x43,-0xf(%ebp)
  file[2] = '\0';
    2876:	c6 45 f3 00          	movb   $0x0,-0xd(%ebp)
    287a:	eb 53                	jmp    28cf <concreate+0x7f>
    287c:	8d 74 26 00          	lea    0x0(%esi),%esi
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
    2880:	89 d8                	mov    %ebx,%eax
    2882:	ba 56 55 55 55       	mov    $0x55555556,%edx
    2887:	f7 ea                	imul   %edx
    2889:	89 d8                	mov    %ebx,%eax
    288b:	c1 f8 1f             	sar    $0x1f,%eax
    288e:	29 c2                	sub    %eax,%edx
    2890:	89 d8                	mov    %ebx,%eax
    2892:	8d 14 52             	lea    (%edx,%edx,2),%edx
    2895:	29 d0                	sub    %edx,%eax
    2897:	83 e8 01             	sub    $0x1,%eax
    289a:	74 7f                	je     291b <concreate+0xcb>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    289c:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    28a3:	00 
    28a4:	89 3c 24             	mov    %edi,(%esp)
    28a7:	e8 9c 0a 00 00       	call   3348 <open>
      if(fd < 0){
    28ac:	85 c0                	test   %eax,%eax
    28ae:	0f 88 be 01 00 00    	js     2a72 <concreate+0x222>
        printf(1, "concreate create %s failed\n", file);
        exit();
      }
      close(fd);
    28b4:	89 04 24             	mov    %eax,(%esp)
    28b7:	e8 74 0a 00 00       	call   3330 <close>
    }
    if(pid == 0)
    28bc:	85 f6                	test   %esi,%esi
    28be:	66 90                	xchg   %ax,%ax
    28c0:	74 54                	je     2916 <concreate+0xc6>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    28c2:	83 c3 01             	add    $0x1,%ebx
      close(fd);
    }
    if(pid == 0)
      exit();
    else
      wait();
    28c5:	e8 46 0a 00 00       	call   3310 <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    28ca:	83 fb 28             	cmp    $0x28,%ebx
    28cd:	74 69                	je     2938 <concreate+0xe8>
    file[1] = '0' + i;
    28cf:	8d 43 30             	lea    0x30(%ebx),%eax
    28d2:	88 45 f2             	mov    %al,-0xe(%ebp)
    unlink(file);
    28d5:	89 3c 24             	mov    %edi,(%esp)
    28d8:	e8 7b 0a 00 00       	call   3358 <unlink>
    pid = fork();
    28dd:	e8 1e 0a 00 00       	call   3300 <fork>
    if(pid && (i % 3) == 1){
    28e2:	85 c0                	test   %eax,%eax
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    28e4:	89 c6                	mov    %eax,%esi
    if(pid && (i % 3) == 1){
    28e6:	75 98                	jne    2880 <concreate+0x30>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
    28e8:	89 d8                	mov    %ebx,%eax
    28ea:	ba 67 66 66 66       	mov    $0x66666667,%edx
    28ef:	f7 ea                	imul   %edx
    28f1:	89 d8                	mov    %ebx,%eax
    28f3:	c1 f8 1f             	sar    $0x1f,%eax
    28f6:	d1 fa                	sar    %edx
    28f8:	29 c2                	sub    %eax,%edx
    28fa:	89 d8                	mov    %ebx,%eax
    28fc:	8d 14 92             	lea    (%edx,%edx,4),%edx
    28ff:	29 d0                	sub    %edx,%eax
    2901:	83 e8 01             	sub    $0x1,%eax
    2904:	75 96                	jne    289c <concreate+0x4c>
      link("C0", file);
    2906:	89 7c 24 04          	mov    %edi,0x4(%esp)
    290a:	c7 04 24 b9 43 00 00 	movl   $0x43b9,(%esp)
    2911:	e8 52 0a 00 00       	call   3368 <link>
        printf(1, "concreate weird file %s\n", de.name);
        exit();
      }
      if(fa[i]){
        printf(1, "concreate duplicate file %s\n", de.name);
        exit();
    2916:	e8 ed 09 00 00       	call   3308 <exit>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    291b:	83 c3 01             	add    $0x1,%ebx
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
      link("C0", file);
    291e:	89 7c 24 04          	mov    %edi,0x4(%esp)
    2922:	c7 04 24 b9 43 00 00 	movl   $0x43b9,(%esp)
    2929:	e8 3a 0a 00 00       	call   3368 <link>
      close(fd);
    }
    if(pid == 0)
      exit();
    else
      wait();
    292e:	e8 dd 09 00 00       	call   3310 <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    2933:	83 fb 28             	cmp    $0x28,%ebx
    2936:	75 97                	jne    28cf <concreate+0x7f>
      exit();
    else
      wait();
  }

  memset(fa, 0, sizeof(fa));
    2938:	8d 45 b8             	lea    -0x48(%ebp),%eax
    293b:	c7 44 24 08 28 00 00 	movl   $0x28,0x8(%esp)
    2942:	00 
    2943:	8d 75 e0             	lea    -0x20(%ebp),%esi
    2946:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    294d:	00 
    294e:	89 04 24             	mov    %eax,(%esp)
    2951:	e8 4a 08 00 00       	call   31a0 <memset>
  fd = open(".", 0);
    2956:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    295d:	00 
    295e:	c7 04 24 17 3d 00 00 	movl   $0x3d17,(%esp)
    2965:	e8 de 09 00 00       	call   3348 <open>
    296a:	c7 45 b0 00 00 00 00 	movl   $0x0,-0x50(%ebp)
    2971:	89 c3                	mov    %eax,%ebx
  n = 0;
  while(read(fd, &de, sizeof(de)) > 0){
    2973:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    297a:	00 
    297b:	89 74 24 04          	mov    %esi,0x4(%esp)
    297f:	89 1c 24             	mov    %ebx,(%esp)
    2982:	e8 99 09 00 00       	call   3320 <read>
    2987:	85 c0                	test   %eax,%eax
    2989:	7e 3d                	jle    29c8 <concreate+0x178>
    if(de.inum == 0)
    298b:	66 83 7d e0 00       	cmpw   $0x0,-0x20(%ebp)
    2990:	74 e1                	je     2973 <concreate+0x123>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    2992:	80 7d e2 43          	cmpb   $0x43,-0x1e(%ebp)
    2996:	75 db                	jne    2973 <concreate+0x123>
    2998:	80 7d e4 00          	cmpb   $0x0,-0x1c(%ebp)
    299c:	8d 74 26 00          	lea    0x0(%esi),%esi
    29a0:	75 d1                	jne    2973 <concreate+0x123>
      i = de.name[1] - '0';
    29a2:	0f be 45 e3          	movsbl -0x1d(%ebp),%eax
    29a6:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    29a9:	83 f8 27             	cmp    $0x27,%eax
    29ac:	0f 87 16 01 00 00    	ja     2ac8 <concreate+0x278>
        printf(1, "concreate weird file %s\n", de.name);
        exit();
      }
      if(fa[i]){
    29b2:	80 7c 05 b8 00       	cmpb   $0x0,-0x48(%ebp,%eax,1)
    29b7:	0f 85 eb 00 00 00    	jne    2aa8 <concreate+0x258>
        printf(1, "concreate duplicate file %s\n", de.name);
        exit();
      }
      fa[i] = 1;
    29bd:	c6 44 05 b8 01       	movb   $0x1,-0x48(%ebp,%eax,1)
      n++;
    29c2:	83 45 b0 01          	addl   $0x1,-0x50(%ebp)
    29c6:	eb ab                	jmp    2973 <concreate+0x123>
    }
  }
  close(fd);
    29c8:	89 1c 24             	mov    %ebx,(%esp)

  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit();
    29cb:	31 f6                	xor    %esi,%esi
      }
      fa[i] = 1;
      n++;
    }
  }
  close(fd);
    29cd:	e8 5e 09 00 00       	call   3330 <close>

  if(n != 40){
    29d2:	83 7d b0 28          	cmpl   $0x28,-0x50(%ebp)
    29d6:	74 2d                	je     2a05 <concreate+0x1b5>
    29d8:	e9 0b 01 00 00       	jmp    2ae8 <concreate+0x298>
    29dd:	8d 76 00             	lea    0x0(%esi),%esi
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
    29e0:	83 e8 01             	sub    $0x1,%eax
    29e3:	74 6b                	je     2a50 <concreate+0x200>
       ((i % 3) == 1 && pid != 0)){
      fd = open(file, 0);
      close(fd);
    } else {
      unlink(file);
    29e5:	89 3c 24             	mov    %edi,(%esp)
    29e8:	e8 6b 09 00 00       	call   3358 <unlink>
    29ed:	8d 76 00             	lea    0x0(%esi),%esi
    }
    if(pid == 0)
    29f0:	85 db                	test   %ebx,%ebx
    29f2:	0f 84 1e ff ff ff    	je     2916 <concreate+0xc6>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    29f8:	83 c6 01             	add    $0x1,%esi
      unlink(file);
    }
    if(pid == 0)
      exit();
    else
      wait();
    29fb:	e8 10 09 00 00       	call   3310 <wait>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    2a00:	83 fe 28             	cmp    $0x28,%esi
    2a03:	74 51                	je     2a56 <concreate+0x206>
    file[1] = '0' + i;
    2a05:	8d 46 30             	lea    0x30(%esi),%eax
    2a08:	88 45 f2             	mov    %al,-0xe(%ebp)
    pid = fork();
    2a0b:	e8 f0 08 00 00       	call   3300 <fork>
    if(pid < 0){
    2a10:	85 c0                	test   %eax,%eax
    exit();
  }

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    2a12:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
    2a14:	78 79                	js     2a8f <concreate+0x23f>
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
    2a16:	89 f0                	mov    %esi,%eax
    2a18:	ba 56 55 55 55       	mov    $0x55555556,%edx
    2a1d:	f7 ea                	imul   %edx
    2a1f:	89 f0                	mov    %esi,%eax
    2a21:	c1 f8 1f             	sar    $0x1f,%eax
    2a24:	29 c2                	sub    %eax,%edx
    2a26:	89 f0                	mov    %esi,%eax
    2a28:	8d 14 52             	lea    (%edx,%edx,2),%edx
    2a2b:	29 d0                	sub    %edx,%eax
    2a2d:	89 c2                	mov    %eax,%edx
    2a2f:	09 da                	or     %ebx,%edx
    2a31:	75 ad                	jne    29e0 <concreate+0x190>
       ((i % 3) == 1 && pid != 0)){
      fd = open(file, 0);
    2a33:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2a3a:	00 
    2a3b:	89 3c 24             	mov    %edi,(%esp)
    2a3e:	e8 05 09 00 00       	call   3348 <open>
      close(fd);
    2a43:	89 04 24             	mov    %eax,(%esp)
    2a46:	e8 e5 08 00 00       	call   3330 <close>
    2a4b:	eb a3                	jmp    29f0 <concreate+0x1a0>
    2a4d:	8d 76 00             	lea    0x0(%esi),%esi
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
    2a50:	85 db                	test   %ebx,%ebx
    2a52:	74 91                	je     29e5 <concreate+0x195>
    2a54:	eb dd                	jmp    2a33 <concreate+0x1e3>
      exit();
    else
      wait();
  }

  printf(1, "concreate ok\n");
    2a56:	c7 44 24 04 0e 44 00 	movl   $0x440e,0x4(%esp)
    2a5d:	00 
    2a5e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a65:	e8 f6 09 00 00       	call   3460 <printf>
}
    2a6a:	83 c4 5c             	add    $0x5c,%esp
    2a6d:	5b                   	pop    %ebx
    2a6e:	5e                   	pop    %esi
    2a6f:	5f                   	pop    %edi
    2a70:	5d                   	pop    %ebp
    2a71:	c3                   	ret    
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "concreate create %s failed\n", file);
    2a72:	89 7c 24 08          	mov    %edi,0x8(%esp)
    2a76:	c7 44 24 04 bc 43 00 	movl   $0x43bc,0x4(%esp)
    2a7d:	00 
    2a7e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a85:	e8 d6 09 00 00       	call   3460 <printf>
        exit();
    2a8a:	e8 79 08 00 00       	call   3308 <exit>

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    2a8f:	c7 44 24 04 61 38 00 	movl   $0x3861,0x4(%esp)
    2a96:	00 
    2a97:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a9e:	e8 bd 09 00 00       	call   3460 <printf>
      exit();
    2aa3:	e8 60 08 00 00       	call   3308 <exit>
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
        exit();
      }
      if(fa[i]){
        printf(1, "concreate duplicate file %s\n", de.name);
    2aa8:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    2aab:	89 44 24 08          	mov    %eax,0x8(%esp)
    2aaf:	c7 44 24 04 f1 43 00 	movl   $0x43f1,0x4(%esp)
    2ab6:	00 
    2ab7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2abe:	e8 9d 09 00 00       	call   3460 <printf>
    2ac3:	e9 4e fe ff ff       	jmp    2916 <concreate+0xc6>
    if(de.inum == 0)
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
      i = de.name[1] - '0';
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
    2ac8:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    2acb:	89 44 24 08          	mov    %eax,0x8(%esp)
    2acf:	c7 44 24 04 d8 43 00 	movl   $0x43d8,0x4(%esp)
    2ad6:	00 
    2ad7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ade:	e8 7d 09 00 00       	call   3460 <printf>
    2ae3:	e9 2e fe ff ff       	jmp    2916 <concreate+0xc6>
    }
  }
  close(fd);

  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    2ae8:	c7 44 24 04 a0 4a 00 	movl   $0x4aa0,0x4(%esp)
    2aef:	00 
    2af0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2af7:	e8 64 09 00 00       	call   3460 <printf>
    exit();
    2afc:	e8 07 08 00 00       	call   3308 <exit>
    2b01:	eb 0d                	jmp    2b10 <twofiles>
    2b03:	90                   	nop    
    2b04:	90                   	nop    
    2b05:	90                   	nop    
    2b06:	90                   	nop    
    2b07:	90                   	nop    
    2b08:	90                   	nop    
    2b09:	90                   	nop    
    2b0a:	90                   	nop    
    2b0b:	90                   	nop    
    2b0c:	90                   	nop    
    2b0d:	90                   	nop    
    2b0e:	90                   	nop    
    2b0f:	90                   	nop    

00002b10 <twofiles>:

// two processes write two different files at the same
// time, to test block allocation.
void
twofiles(void)
{
    2b10:	55                   	push   %ebp
    2b11:	89 e5                	mov    %esp,%ebp
    2b13:	57                   	push   %edi
    2b14:	56                   	push   %esi
    2b15:	53                   	push   %ebx
    2b16:	83 ec 1c             	sub    $0x1c,%esp
  int fd, pid, i, j, n, total;
  char *fname;

  printf(1, "twofiles test\n");
    2b19:	c7 44 24 04 1c 44 00 	movl   $0x441c,0x4(%esp)
    2b20:	00 
    2b21:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b28:	e8 33 09 00 00       	call   3460 <printf>

  unlink("f1");
    2b2d:	c7 04 24 63 3f 00 00 	movl   $0x3f63,(%esp)
    2b34:	e8 1f 08 00 00       	call   3358 <unlink>
  unlink("f2");
    2b39:	c7 04 24 67 3f 00 00 	movl   $0x3f67,(%esp)
    2b40:	e8 13 08 00 00       	call   3358 <unlink>

  pid = fork();
    2b45:	e8 b6 07 00 00       	call   3300 <fork>
  if(pid < 0){
    2b4a:	83 f8 00             	cmp    $0x0,%eax
  printf(1, "twofiles test\n");

  unlink("f1");
  unlink("f2");

  pid = fork();
    2b4d:	89 c7                	mov    %eax,%edi
  if(pid < 0){
    2b4f:	0f 8c 87 01 00 00    	jl     2cdc <twofiles+0x1cc>
    printf(1, "fork failed\n");
    return;
  }

  fname = pid ? "f1" : "f2";
    2b55:	0f 85 ee 00 00 00    	jne    2c49 <twofiles+0x139>
    2b5b:	b8 67 3f 00 00       	mov    $0x3f67,%eax
  fd = open(fname, O_CREATE | O_RDWR);
    2b60:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    2b67:	00 
    2b68:	89 04 24             	mov    %eax,(%esp)
    2b6b:	e8 d8 07 00 00       	call   3348 <open>
  if(fd < 0){
    2b70:	85 c0                	test   %eax,%eax
    printf(1, "fork failed\n");
    return;
  }

  fname = pid ? "f1" : "f2";
  fd = open(fname, O_CREATE | O_RDWR);
    2b72:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2b74:	0f 88 9b 01 00 00    	js     2d15 <twofiles+0x205>
    printf(1, "create failed\n");
    exit();
  }

  memset(buf, pid?'p':'c', 512);
    2b7a:	83 ff 01             	cmp    $0x1,%edi
    2b7d:	19 c0                	sbb    %eax,%eax
    2b7f:	31 db                	xor    %ebx,%ebx
    2b81:	83 e0 f3             	and    $0xfffffff3,%eax
    2b84:	83 c0 70             	add    $0x70,%eax
    2b87:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    2b8e:	00 
    2b8f:	89 44 24 04          	mov    %eax,0x4(%esp)
    2b93:	c7 04 24 e0 4b 00 00 	movl   $0x4be0,(%esp)
    2b9a:	e8 01 06 00 00       	call   31a0 <memset>
    2b9f:	90                   	nop    
  for(i = 0; i < 12; i++){
    if((n = write(fd, buf, 500)) != 500){
    2ba0:	c7 44 24 08 f4 01 00 	movl   $0x1f4,0x8(%esp)
    2ba7:	00 
    2ba8:	c7 44 24 04 e0 4b 00 	movl   $0x4be0,0x4(%esp)
    2baf:	00 
    2bb0:	89 34 24             	mov    %esi,(%esp)
    2bb3:	e8 70 07 00 00       	call   3328 <write>
    2bb8:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    2bbd:	0f 85 35 01 00 00    	jne    2cf8 <twofiles+0x1e8>
    printf(1, "create failed\n");
    exit();
  }

  memset(buf, pid?'p':'c', 512);
  for(i = 0; i < 12; i++){
    2bc3:	83 c3 01             	add    $0x1,%ebx
    2bc6:	83 fb 0c             	cmp    $0xc,%ebx
    2bc9:	75 d5                	jne    2ba0 <twofiles+0x90>
    if((n = write(fd, buf, 500)) != 500){
      printf(1, "write failed %d\n", n);
      exit();
    }
  }
  close(fd);
    2bcb:	89 34 24             	mov    %esi,(%esp)
    2bce:	e8 5d 07 00 00       	call   3330 <close>
  if(pid)
    2bd3:	85 ff                	test   %edi,%edi
    2bd5:	0f 84 90 00 00 00    	je     2c6b <twofiles+0x15b>
    wait();
    2bdb:	e8 30 07 00 00       	call   3310 <wait>
    2be0:	31 f6                	xor    %esi,%esi
  else
    exit();

  for(i = 0; i < 2; i++){
    fd = open(i?"f1":"f2", 0);
    2be2:	85 f6                	test   %esi,%esi
    2be4:	b8 63 3f 00 00       	mov    $0x3f63,%eax
    2be9:	75 05                	jne    2bf0 <twofiles+0xe0>
    2beb:	b8 67 3f 00 00       	mov    $0x3f67,%eax
    2bf0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2bf7:	00 
    2bf8:	31 ff                	xor    %edi,%edi
    2bfa:	89 04 24             	mov    %eax,(%esp)
    2bfd:	e8 46 07 00 00       	call   3348 <open>
    2c02:	89 45 f0             	mov    %eax,-0x10(%ebp)
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
    2c05:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    2c0c:	00 
    2c0d:	c7 44 24 04 e0 4b 00 	movl   $0x4be0,0x4(%esp)
    2c14:	00 
    2c15:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2c18:	89 04 24             	mov    %eax,(%esp)
    2c1b:	e8 00 07 00 00       	call   3320 <read>
    2c20:	85 c0                	test   %eax,%eax
    2c22:	89 c3                	mov    %eax,%ebx
    2c24:	7e 63                	jle    2c89 <twofiles+0x179>
    2c26:	31 c9                	xor    %ecx,%ecx
      for(j = 0; j < n; j++){
        if(buf[j] != (i?'p':'c')){
    2c28:	83 fe 01             	cmp    $0x1,%esi
    2c2b:	0f be 91 e0 4b 00 00 	movsbl 0x4be0(%ecx),%edx
    2c32:	19 c0                	sbb    %eax,%eax
    2c34:	83 e0 f3             	and    $0xfffffff3,%eax
    2c37:	83 c0 70             	add    $0x70,%eax
    2c3a:	39 c2                	cmp    %eax,%edx
    2c3c:	75 32                	jne    2c70 <twofiles+0x160>

  for(i = 0; i < 2; i++){
    fd = open(i?"f1":"f2", 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
    2c3e:	83 c1 01             	add    $0x1,%ecx
    2c41:	39 d9                	cmp    %ebx,%ecx
    2c43:	75 e3                	jne    2c28 <twofiles+0x118>
        if(buf[j] != (i?'p':'c')){
          printf(1, "wrong char\n");
          exit();
        }
      }
      total += n;
    2c45:	01 df                	add    %ebx,%edi
    2c47:	eb bc                	jmp    2c05 <twofiles+0xf5>
  if(pid < 0){
    printf(1, "fork failed\n");
    return;
  }

  fname = pid ? "f1" : "f2";
    2c49:	b8 63 3f 00 00       	mov    $0x3f63,%eax
    2c4e:	e9 0d ff ff ff       	jmp    2b60 <twofiles+0x50>
      }
      total += n;
    }
    close(fd);
    if(total != 12*500){
      printf(1, "wrong length %d\n", total);
    2c53:	89 7c 24 08          	mov    %edi,0x8(%esp)
    2c57:	c7 44 24 04 48 44 00 	movl   $0x4448,0x4(%esp)
    2c5e:	00 
    2c5f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c66:	e8 f5 07 00 00       	call   3460 <printf>
      exit();
    2c6b:	e8 98 06 00 00       	call   3308 <exit>
    fd = open(i?"f1":"f2", 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
        if(buf[j] != (i?'p':'c')){
          printf(1, "wrong char\n");
    2c70:	c7 44 24 04 3c 44 00 	movl   $0x443c,0x4(%esp)
    2c77:	00 
    2c78:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c7f:	e8 dc 07 00 00       	call   3460 <printf>
      total += n;
    }
    close(fd);
    if(total != 12*500){
      printf(1, "wrong length %d\n", total);
      exit();
    2c84:	e8 7f 06 00 00       	call   3308 <exit>
          exit();
        }
      }
      total += n;
    }
    close(fd);
    2c89:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2c8c:	89 04 24             	mov    %eax,(%esp)
    2c8f:	e8 9c 06 00 00       	call   3330 <close>
    if(total != 12*500){
    2c94:	81 ff 70 17 00 00    	cmp    $0x1770,%edi
    2c9a:	75 b7                	jne    2c53 <twofiles+0x143>
  if(pid)
    wait();
  else
    exit();

  for(i = 0; i < 2; i++){
    2c9c:	83 c6 01             	add    $0x1,%esi
    2c9f:	83 fe 02             	cmp    $0x2,%esi
    2ca2:	0f 85 3a ff ff ff    	jne    2be2 <twofiles+0xd2>
      printf(1, "wrong length %d\n", total);
      exit();
    }
  }

  unlink("f1");
    2ca8:	c7 04 24 63 3f 00 00 	movl   $0x3f63,(%esp)
    2caf:	e8 a4 06 00 00       	call   3358 <unlink>
  unlink("f2");
    2cb4:	c7 04 24 67 3f 00 00 	movl   $0x3f67,(%esp)
    2cbb:	e8 98 06 00 00       	call   3358 <unlink>

  printf(1, "twofiles ok\n");
    2cc0:	c7 44 24 04 59 44 00 	movl   $0x4459,0x4(%esp)
    2cc7:	00 
    2cc8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ccf:	e8 8c 07 00 00       	call   3460 <printf>
}
    2cd4:	83 c4 1c             	add    $0x1c,%esp
    2cd7:	5b                   	pop    %ebx
    2cd8:	5e                   	pop    %esi
    2cd9:	5f                   	pop    %edi
    2cda:	5d                   	pop    %ebp
    2cdb:	c3                   	ret    
  unlink("f1");
  unlink("f2");

  pid = fork();
  if(pid < 0){
    printf(1, "fork failed\n");
    2cdc:	c7 44 24 04 61 38 00 	movl   $0x3861,0x4(%esp)
    2ce3:	00 
    2ce4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ceb:	e8 70 07 00 00       	call   3460 <printf>

  unlink("f1");
  unlink("f2");

  printf(1, "twofiles ok\n");
}
    2cf0:	83 c4 1c             	add    $0x1c,%esp
    2cf3:	5b                   	pop    %ebx
    2cf4:	5e                   	pop    %esi
    2cf5:	5f                   	pop    %edi
    2cf6:	5d                   	pop    %ebp
    2cf7:	c3                   	ret    
  }

  memset(buf, pid?'p':'c', 512);
  for(i = 0; i < 12; i++){
    if((n = write(fd, buf, 500)) != 500){
      printf(1, "write failed %d\n", n);
    2cf8:	89 44 24 08          	mov    %eax,0x8(%esp)
    2cfc:	c7 44 24 04 2b 44 00 	movl   $0x442b,0x4(%esp)
    2d03:	00 
    2d04:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d0b:	e8 50 07 00 00       	call   3460 <printf>
      exit();
    2d10:	e8 f3 05 00 00       	call   3308 <exit>
  }

  fname = pid ? "f1" : "f2";
  fd = open(fname, O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create failed\n");
    2d15:	c7 44 24 04 15 3f 00 	movl   $0x3f15,0x4(%esp)
    2d1c:	00 
    2d1d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d24:	e8 37 07 00 00       	call   3460 <printf>
    exit();
    2d29:	e8 da 05 00 00       	call   3308 <exit>
    2d2e:	66 90                	xchg   %ax,%ax

00002d30 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
    2d30:	55                   	push   %ebp
    2d31:	89 e5                	mov    %esp,%ebp
    2d33:	57                   	push   %edi
    2d34:	56                   	push   %esi
    2d35:	53                   	push   %ebx
    2d36:	83 ec 2c             	sub    $0x2c,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  unlink("sharedfd");
    2d39:	c7 04 24 66 44 00 00 	movl   $0x4466,(%esp)
    2d40:	e8 13 06 00 00       	call   3358 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    2d45:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    2d4c:	00 
    2d4d:	c7 04 24 66 44 00 00 	movl   $0x4466,(%esp)
    2d54:	e8 ef 05 00 00       	call   3348 <open>
  if(fd < 0){
    2d59:	85 c0                	test   %eax,%eax
{
  int fd, pid, i, n, nc, np;
  char buf[10];

  unlink("sharedfd");
  fd = open("sharedfd", O_CREATE|O_RDWR);
    2d5b:	89 c7                	mov    %eax,%edi
  if(fd < 0){
    2d5d:	0f 88 26 01 00 00    	js     2e89 <sharedfd+0x159>
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
    2d63:	e8 98 05 00 00       	call   3300 <fork>
  memset(buf, pid==0?'c':'p', sizeof(buf));
    2d68:	8d 75 ea             	lea    -0x16(%ebp),%esi
    2d6b:	83 f8 01             	cmp    $0x1,%eax
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
    2d6e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
    2d71:	19 c0                	sbb    %eax,%eax
    2d73:	31 db                	xor    %ebx,%ebx
    2d75:	83 e0 f3             	and    $0xfffffff3,%eax
    2d78:	83 c0 70             	add    $0x70,%eax
    2d7b:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    2d82:	00 
    2d83:	89 44 24 04          	mov    %eax,0x4(%esp)
    2d87:	89 34 24             	mov    %esi,(%esp)
    2d8a:	e8 11 04 00 00       	call   31a0 <memset>
    2d8f:	eb 0b                	jmp    2d9c <sharedfd+0x6c>
  for(i = 0; i < 1000; i++){
    2d91:	83 c3 01             	add    $0x1,%ebx
    2d94:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2d9a:	74 2d                	je     2dc9 <sharedfd+0x99>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    2d9c:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    2da3:	00 
    2da4:	89 74 24 04          	mov    %esi,0x4(%esp)
    2da8:	89 3c 24             	mov    %edi,(%esp)
    2dab:	e8 78 05 00 00       	call   3328 <write>
    2db0:	83 f8 0a             	cmp    $0xa,%eax
    2db3:	74 dc                	je     2d91 <sharedfd+0x61>
      printf(1, "fstests: write sharedfd failed\n");
    2db5:	c7 44 24 04 00 4b 00 	movl   $0x4b00,0x4(%esp)
    2dbc:	00 
    2dbd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2dc4:	e8 97 06 00 00       	call   3460 <printf>
      break;
    }
  }
  if(pid == 0)
    2dc9:	8b 45 dc             	mov    -0x24(%ebp),%eax
    2dcc:	85 c0                	test   %eax,%eax
    2dce:	0f 84 11 01 00 00    	je     2ee5 <sharedfd+0x1b5>
    exit();
  else
    wait();
    2dd4:	e8 37 05 00 00       	call   3310 <wait>
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    2dd9:	31 db                	xor    %ebx,%ebx
  }
  if(pid == 0)
    exit();
  else
    wait();
  close(fd);
    2ddb:	89 3c 24             	mov    %edi,(%esp)
  fd = open("sharedfd", 0);
  if(fd < 0){
    2dde:	31 ff                	xor    %edi,%edi
  }
  if(pid == 0)
    exit();
  else
    wait();
  close(fd);
    2de0:	e8 4b 05 00 00       	call   3330 <close>
  fd = open("sharedfd", 0);
    2de5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2dec:	00 
    2ded:	c7 04 24 66 44 00 00 	movl   $0x4466,(%esp)
    2df4:	e8 4f 05 00 00       	call   3348 <open>
  if(fd < 0){
    2df9:	85 c0                	test   %eax,%eax
  if(pid == 0)
    exit();
  else
    wait();
  close(fd);
  fd = open("sharedfd", 0);
    2dfb:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(fd < 0){
    2dfe:	0f 88 c5 00 00 00    	js     2ec9 <sharedfd+0x199>
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    2e04:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    2e0b:	00 
    2e0c:	89 74 24 04          	mov    %esi,0x4(%esp)
    2e10:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2e13:	89 04 24             	mov    %eax,(%esp)
    2e16:	e8 05 05 00 00       	call   3320 <read>
    2e1b:	85 c0                	test   %eax,%eax
    2e1d:	7e 27                	jle    2e46 <sharedfd+0x116>
    wait();
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
    2e1f:	ba 01 00 00 00       	mov    $0x1,%edx
    2e24:	eb 12                	jmp    2e38 <sharedfd+0x108>
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
      if(buf[i] == 'c')
        nc++;
      if(buf[i] == 'p')
        np++;
    2e26:	3c 70                	cmp    $0x70,%al
    2e28:	0f 94 c0             	sete   %al
    2e2b:	0f b6 c0             	movzbl %al,%eax
    2e2e:	01 c3                	add    %eax,%ebx
    2e30:	83 c2 01             	add    $0x1,%edx
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
    2e33:	83 fa 0b             	cmp    $0xb,%edx
    2e36:	74 cc                	je     2e04 <sharedfd+0xd4>
      if(buf[i] == 'c')
    2e38:	0f b6 44 32 ff       	movzbl -0x1(%edx,%esi,1),%eax
    2e3d:	3c 63                	cmp    $0x63,%al
    2e3f:	75 e5                	jne    2e26 <sharedfd+0xf6>
        nc++;
    2e41:	83 c7 01             	add    $0x1,%edi
    2e44:	eb ea                	jmp    2e30 <sharedfd+0x100>
      if(buf[i] == 'p')
        np++;
    }
  }
  close(fd);
    2e46:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2e49:	89 04 24             	mov    %eax,(%esp)
    2e4c:	e8 df 04 00 00       	call   3330 <close>
  unlink("sharedfd");
    2e51:	c7 04 24 66 44 00 00 	movl   $0x4466,(%esp)
    2e58:	e8 fb 04 00 00       	call   3358 <unlink>
  if(nc == 10000 && np == 10000)
    2e5d:	81 ff 10 27 00 00    	cmp    $0x2710,%edi
    2e63:	74 40                	je     2ea5 <sharedfd+0x175>
    printf(1, "sharedfd ok\n");
  else
    printf(1, "sharedfd oops %d %d\n", nc, np);
    2e65:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    2e69:	89 7c 24 08          	mov    %edi,0x8(%esp)
    2e6d:	c7 44 24 04 7c 44 00 	movl   $0x447c,0x4(%esp)
    2e74:	00 
    2e75:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e7c:	e8 df 05 00 00       	call   3460 <printf>
}
    2e81:	83 c4 2c             	add    $0x2c,%esp
    2e84:	5b                   	pop    %ebx
    2e85:	5e                   	pop    %esi
    2e86:	5f                   	pop    %edi
    2e87:	5d                   	pop    %ebp
    2e88:	c3                   	ret    
  char buf[10];

  unlink("sharedfd");
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
    2e89:	c7 44 24 04 d4 4a 00 	movl   $0x4ad4,0x4(%esp)
    2e90:	00 
    2e91:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e98:	e8 c3 05 00 00       	call   3460 <printf>
  unlink("sharedfd");
  if(nc == 10000 && np == 10000)
    printf(1, "sharedfd ok\n");
  else
    printf(1, "sharedfd oops %d %d\n", nc, np);
}
    2e9d:	83 c4 2c             	add    $0x2c,%esp
    2ea0:	5b                   	pop    %ebx
    2ea1:	5e                   	pop    %esi
    2ea2:	5f                   	pop    %edi
    2ea3:	5d                   	pop    %ebp
    2ea4:	c3                   	ret    
        np++;
    }
  }
  close(fd);
  unlink("sharedfd");
  if(nc == 10000 && np == 10000)
    2ea5:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
    2eab:	75 b8                	jne    2e65 <sharedfd+0x135>
    printf(1, "sharedfd ok\n");
    2ead:	c7 44 24 04 6f 44 00 	movl   $0x446f,0x4(%esp)
    2eb4:	00 
    2eb5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ebc:	e8 9f 05 00 00       	call   3460 <printf>
  else
    printf(1, "sharedfd oops %d %d\n", nc, np);
}
    2ec1:	83 c4 2c             	add    $0x2c,%esp
    2ec4:	5b                   	pop    %ebx
    2ec5:	5e                   	pop    %esi
    2ec6:	5f                   	pop    %edi
    2ec7:	5d                   	pop    %ebp
    2ec8:	c3                   	ret    
  else
    wait();
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for reading\n");
    2ec9:	c7 44 24 04 20 4b 00 	movl   $0x4b20,0x4(%esp)
    2ed0:	00 
    2ed1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ed8:	e8 83 05 00 00       	call   3460 <printf>
  unlink("sharedfd");
  if(nc == 10000 && np == 10000)
    printf(1, "sharedfd ok\n");
  else
    printf(1, "sharedfd oops %d %d\n", nc, np);
}
    2edd:	83 c4 2c             	add    $0x2c,%esp
    2ee0:	5b                   	pop    %ebx
    2ee1:	5e                   	pop    %esi
    2ee2:	5f                   	pop    %edi
    2ee3:	5d                   	pop    %ebp
    2ee4:	c3                   	ret    
      printf(1, "fstests: write sharedfd failed\n");
      break;
    }
  }
  if(pid == 0)
    exit();
    2ee5:	e8 1e 04 00 00       	call   3308 <exit>
    2eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00002ef0 <mem>:
  printf(1, "exitwait ok\n");
}

void
mem(void)
{
    2ef0:	55                   	push   %ebp
    2ef1:	89 e5                	mov    %esp,%ebp
    2ef3:	57                   	push   %edi
    2ef4:	56                   	push   %esi
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
  ppid = getpid();
  if((pid = fork()) == 0){
    2ef5:	31 f6                	xor    %esi,%esi
  printf(1, "exitwait ok\n");
}

void
mem(void)
{
    2ef7:	53                   	push   %ebx
    2ef8:	83 ec 0c             	sub    $0xc,%esp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
    2efb:	c7 44 24 04 91 44 00 	movl   $0x4491,0x4(%esp)
    2f02:	00 
    2f03:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f0a:	e8 51 05 00 00       	call   3460 <printf>
  ppid = getpid();
    2f0f:	e8 74 04 00 00       	call   3388 <getpid>
    2f14:	89 c7                	mov    %eax,%edi
  if((pid = fork()) == 0){
    2f16:	e8 e5 03 00 00       	call   3300 <fork>
    2f1b:	85 c0                	test   %eax,%eax
    2f1d:	74 15                	je     2f34 <mem+0x44>
    printf(1, "mem ok\n");
    exit();
  } else {
    wait();
  }
}
    2f1f:	83 c4 0c             	add    $0xc,%esp
    2f22:	5b                   	pop    %ebx
    2f23:	5e                   	pop    %esi
    2f24:	5f                   	pop    %edi
    2f25:	5d                   	pop    %ebp
    }
    free(m1);
    printf(1, "mem ok\n");
    exit();
  } else {
    wait();
    2f26:	e9 e5 03 00 00       	jmp    3310 <wait>
    2f2b:	90                   	nop    
    2f2c:	8d 74 26 00          	lea    0x0(%esi),%esi
  printf(1, "mem test\n");
  ppid = getpid();
  if((pid = fork()) == 0){
    m1 = 0;
    while((m2 = malloc(10001)) != 0) {
      *(char**) m2 = m1;
    2f30:	89 30                	mov    %esi,(%eax)
    2f32:	89 c6                	mov    %eax,%esi

  printf(1, "mem test\n");
  ppid = getpid();
  if((pid = fork()) == 0){
    m1 = 0;
    while((m2 = malloc(10001)) != 0) {
    2f34:	c7 04 24 11 27 00 00 	movl   $0x2711,(%esp)
    2f3b:	e8 20 07 00 00       	call   3660 <malloc>
    2f40:	85 c0                	test   %eax,%eax
    2f42:	75 ec                	jne    2f30 <mem+0x40>
      *(char**) m2 = m1;
      m1 = m2;
    }
    while(m1) {
    2f44:	85 f6                	test   %esi,%esi
    2f46:	74 10                	je     2f58 <mem+0x68>
      m2 = *(char**)m1;
    2f48:	8b 1e                	mov    (%esi),%ebx
      free(m1);
    2f4a:	89 34 24             	mov    %esi,(%esp)
    2f4d:	e8 8e 06 00 00       	call   35e0 <free>
    2f52:	89 de                	mov    %ebx,%esi
    m1 = 0;
    while((m2 = malloc(10001)) != 0) {
      *(char**) m2 = m1;
      m1 = m2;
    }
    while(m1) {
    2f54:	85 f6                	test   %esi,%esi
    2f56:	75 f0                	jne    2f48 <mem+0x58>
      m2 = *(char**)m1;
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
    2f58:	c7 04 24 00 50 00 00 	movl   $0x5000,(%esp)
    2f5f:	e8 fc 06 00 00       	call   3660 <malloc>
    if(m1 == 0) {
    2f64:	85 c0                	test   %eax,%eax
    2f66:	75 21                	jne    2f89 <mem+0x99>
      printf(1, "couldn't allocate mem?!!\n");
    2f68:	c7 44 24 04 9b 44 00 	movl   $0x449b,0x4(%esp)
    2f6f:	00 
    2f70:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f77:	e8 e4 04 00 00       	call   3460 <printf>
      kill(ppid);
    2f7c:	89 3c 24             	mov    %edi,(%esp)
    2f7f:	e8 b4 03 00 00       	call   3338 <kill>
      exit();
    2f84:	e8 7f 03 00 00       	call   3308 <exit>
    }
    free(m1);
    2f89:	89 04 24             	mov    %eax,(%esp)
    2f8c:	e8 4f 06 00 00       	call   35e0 <free>
    printf(1, "mem ok\n");
    2f91:	c7 44 24 04 b5 44 00 	movl   $0x44b5,0x4(%esp)
    2f98:	00 
    2f99:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2fa0:	e8 bb 04 00 00       	call   3460 <printf>
    exit();
    2fa5:	e8 5e 03 00 00       	call   3308 <exit>
    2faa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00002fb0 <exectest>:
  printf(stdout, "mkdir test\n");
}

void
exectest(void)
{
    2fb0:	55                   	push   %ebp
    2fb1:	89 e5                	mov    %esp,%ebp
    2fb3:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "exec test\n");
    2fb6:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    2fbb:	c7 44 24 04 bd 44 00 	movl   $0x44bd,0x4(%esp)
    2fc2:	00 
    2fc3:	89 04 24             	mov    %eax,(%esp)
    2fc6:	e8 95 04 00 00       	call   3460 <printf>
  if(exec("echo", echoargv) < 0) {
    2fcb:	c7 44 24 04 90 4b 00 	movl   $0x4b90,0x4(%esp)
    2fd2:	00 
    2fd3:	c7 04 24 43 37 00 00 	movl   $0x3743,(%esp)
    2fda:	e8 61 03 00 00       	call   3340 <exec>
    2fdf:	85 c0                	test   %eax,%eax
    2fe1:	78 02                	js     2fe5 <exectest+0x35>
    printf(stdout, "exec echo failed\n");
    exit();
  }
}
    2fe3:	c9                   	leave  
    2fe4:	c3                   	ret    
void
exectest(void)
{
  printf(stdout, "exec test\n");
  if(exec("echo", echoargv) < 0) {
    printf(stdout, "exec echo failed\n");
    2fe5:	a1 a4 4b 00 00       	mov    0x4ba4,%eax
    2fea:	c7 44 24 04 c8 44 00 	movl   $0x44c8,0x4(%esp)
    2ff1:	00 
    2ff2:	89 04 24             	mov    %eax,(%esp)
    2ff5:	e8 66 04 00 00       	call   3460 <printf>
    exit();
    2ffa:	e8 09 03 00 00       	call   3308 <exit>
    2fff:	90                   	nop    

00003000 <main>:
  printf(stdout, "validate ok\n");
}

int
main(int argc, char *argv[])
{
    3000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    3004:	83 e4 f0             	and    $0xfffffff0,%esp
    3007:	ff 71 fc             	pushl  -0x4(%ecx)
    300a:	55                   	push   %ebp
    300b:	89 e5                	mov    %esp,%ebp
    300d:	51                   	push   %ecx
    300e:	83 ec 14             	sub    $0x14,%esp
  printf(1, "usertests starting\n");
    3011:	c7 44 24 04 da 44 00 	movl   $0x44da,0x4(%esp)
    3018:	00 
    3019:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3020:	e8 3b 04 00 00       	call   3460 <printf>

  if(open("usertests.ran", 0) >= 0){
    3025:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    302c:	00 
    302d:	c7 04 24 ee 44 00 00 	movl   $0x44ee,(%esp)
    3034:	e8 0f 03 00 00       	call   3348 <open>
    3039:	85 c0                	test   %eax,%eax
    303b:	78 19                	js     3056 <main+0x56>
    printf(1, "already ran user tests -- rebuild fs.img\n");
    303d:	c7 44 24 04 4c 4b 00 	movl   $0x4b4c,0x4(%esp)
    3044:	00 
    3045:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    304c:	e8 0f 04 00 00       	call   3460 <printf>
    exit();
    3051:	e8 b2 02 00 00       	call   3308 <exit>
  }
  close(open("usertests.ran", O_CREATE));
    3056:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    305d:	00 
    305e:	c7 04 24 ee 44 00 00 	movl   $0x44ee,(%esp)
    3065:	e8 de 02 00 00       	call   3348 <open>
    306a:	89 04 24             	mov    %eax,(%esp)
    306d:	e8 be 02 00 00       	call   3330 <close>

  sbrktest();
    3072:	e8 49 d2 ff ff       	call   2c0 <sbrktest>
  validatetest();
    3077:	e8 94 d1 ff ff       	call   210 <validatetest>
    307c:	8d 74 26 00          	lea    0x0(%esi),%esi

  opentest();
    3080:	e8 8b cf ff ff       	call   10 <opentest>
  writetest();
    3085:	e8 c6 f3 ff ff       	call   2450 <writetest>
  writetest1();
    308a:	e8 d1 f1 ff ff       	call   2260 <writetest1>
    308f:	90                   	nop    
  createtest();
    3090:	e8 eb f0 ff ff       	call   2180 <createtest>

  mem();
    3095:	e8 56 fe ff ff       	call   2ef0 <mem>
  pipe1();
    309a:	e8 11 d8 ff ff       	call   8b0 <pipe1>
    309f:	90                   	nop    
  preempt();
    30a0:	e8 ab d6 ff ff       	call   750 <preempt>
  exitwait();
    30a5:	e8 d6 d0 ff ff       	call   180 <exitwait>

  rmdot();
    30aa:	e8 71 de ff ff       	call   f20 <rmdot>
    30af:	90                   	nop    
  fourteen();
    30b0:	e8 ab d9 ff ff       	call   a60 <fourteen>
  bigfile();
    30b5:	e8 96 f5 ff ff       	call   2650 <bigfile>
  subdir();
    30ba:	e8 01 e0 ff ff       	call   10c0 <subdir>
    30bf:	90                   	nop    
  concreate();
    30c0:	e8 8b f7 ff ff       	call   2850 <concreate>
  linktest();
    30c5:	e8 e6 e8 ff ff       	call   19b0 <linktest>
  unlinkread();
    30ca:	e8 41 eb ff ff       	call   1c10 <unlinkread>
    30cf:	90                   	nop    
  createdelete();
    30d0:	e8 1b ed ff ff       	call   1df0 <createdelete>
  twofiles();
    30d5:	e8 36 fa ff ff       	call   2b10 <twofiles>
  sharedfd();
    30da:	e8 51 fc ff ff       	call   2d30 <sharedfd>
    30df:	90                   	nop    
  dirfile();
    30e0:	e8 fb db ff ff       	call   ce0 <dirfile>
  iref();
    30e5:	e8 d6 da ff ff       	call   bc0 <iref>
  forktest();
    30ea:	e8 c1 cf ff ff       	call   b0 <forktest>
    30ef:	90                   	nop    
  bigdir(); // slow
    30f0:	e8 5b e7 ff ff       	call   1850 <bigdir>

  exectest();
    30f5:	e8 b6 fe ff ff       	call   2fb0 <exectest>

  exit();
    30fa:	e8 09 02 00 00       	call   3308 <exit>
    30ff:	90                   	nop    

00003100 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    3100:	55                   	push   %ebp
    3101:	89 e5                	mov    %esp,%ebp
    3103:	53                   	push   %ebx
    3104:	8b 5d 08             	mov    0x8(%ebp),%ebx
    3107:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    310a:	89 da                	mov    %ebx,%edx
    310c:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3110:	0f b6 01             	movzbl (%ecx),%eax
    3113:	83 c1 01             	add    $0x1,%ecx
    3116:	88 02                	mov    %al,(%edx)
    3118:	83 c2 01             	add    $0x1,%edx
    311b:	84 c0                	test   %al,%al
    311d:	75 f1                	jne    3110 <strcpy+0x10>
    ;
  return os;
}
    311f:	89 d8                	mov    %ebx,%eax
    3121:	5b                   	pop    %ebx
    3122:	5d                   	pop    %ebp
    3123:	c3                   	ret    
    3124:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    312a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00003130 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3130:	55                   	push   %ebp
    3131:	89 e5                	mov    %esp,%ebp
    3133:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3136:	53                   	push   %ebx
    3137:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
    313a:	0f b6 01             	movzbl (%ecx),%eax
    313d:	84 c0                	test   %al,%al
    313f:	74 24                	je     3165 <strcmp+0x35>
    3141:	0f b6 13             	movzbl (%ebx),%edx
    3144:	38 d0                	cmp    %dl,%al
    3146:	74 12                	je     315a <strcmp+0x2a>
    3148:	eb 1e                	jmp    3168 <strcmp+0x38>
    314a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3150:	0f b6 13             	movzbl (%ebx),%edx
    3153:	83 c1 01             	add    $0x1,%ecx
    3156:	38 d0                	cmp    %dl,%al
    3158:	75 0e                	jne    3168 <strcmp+0x38>
    315a:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
    315e:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    3161:	84 c0                	test   %al,%al
    3163:	75 eb                	jne    3150 <strcmp+0x20>
    3165:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    3168:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    3169:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    316c:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    316d:	0f b6 d2             	movzbl %dl,%edx
    3170:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    3172:	c3                   	ret    
    3173:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3179:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00003180 <strlen>:

uint
strlen(char *s)
{
    3180:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
    3181:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    3183:	89 e5                	mov    %esp,%ebp
    3185:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    3188:	80 39 00             	cmpb   $0x0,(%ecx)
    318b:	74 0e                	je     319b <strlen+0x1b>
    318d:	31 d2                	xor    %edx,%edx
    318f:	90                   	nop    
    3190:	83 c2 01             	add    $0x1,%edx
    3193:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
    3197:	89 d0                	mov    %edx,%eax
    3199:	75 f5                	jne    3190 <strlen+0x10>
    ;
  return n;
}
    319b:	5d                   	pop    %ebp
    319c:	c3                   	ret    
    319d:	8d 76 00             	lea    0x0(%esi),%esi

000031a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    31a0:	55                   	push   %ebp
    31a1:	89 e5                	mov    %esp,%ebp
    31a3:	8b 55 08             	mov    0x8(%ebp),%edx
    31a6:	57                   	push   %edi
    31a7:	8b 45 0c             	mov    0xc(%ebp),%eax
    31aa:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    31ad:	89 d7                	mov    %edx,%edi
    31af:	fc                   	cld    
    31b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    31b2:	5f                   	pop    %edi
    31b3:	89 d0                	mov    %edx,%eax
    31b5:	5d                   	pop    %ebp
    31b6:	c3                   	ret    
    31b7:	89 f6                	mov    %esi,%esi
    31b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000031c0 <strchr>:

char*
strchr(const char *s, char c)
{
    31c0:	55                   	push   %ebp
    31c1:	89 e5                	mov    %esp,%ebp
    31c3:	8b 45 08             	mov    0x8(%ebp),%eax
    31c6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    31ca:	0f b6 10             	movzbl (%eax),%edx
    31cd:	84 d2                	test   %dl,%dl
    31cf:	75 0c                	jne    31dd <strchr+0x1d>
    31d1:	eb 11                	jmp    31e4 <strchr+0x24>
    31d3:	83 c0 01             	add    $0x1,%eax
    31d6:	0f b6 10             	movzbl (%eax),%edx
    31d9:	84 d2                	test   %dl,%dl
    31db:	74 07                	je     31e4 <strchr+0x24>
    if(*s == c)
    31dd:	38 ca                	cmp    %cl,%dl
    31df:	90                   	nop    
    31e0:	75 f1                	jne    31d3 <strchr+0x13>
      return (char*) s;
  return 0;
}
    31e2:	5d                   	pop    %ebp
    31e3:	c3                   	ret    
    31e4:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    31e5:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
    31e7:	c3                   	ret    
    31e8:	90                   	nop    
    31e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000031f0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    31f0:	55                   	push   %ebp
    31f1:	89 e5                	mov    %esp,%ebp
    31f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
    31f6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    31f7:	31 db                	xor    %ebx,%ebx
    31f9:	0f b6 11             	movzbl (%ecx),%edx
    31fc:	8d 42 d0             	lea    -0x30(%edx),%eax
    31ff:	3c 09                	cmp    $0x9,%al
    3201:	77 18                	ja     321b <atoi+0x2b>
    n = n*10 + *s++ - '0';
    3203:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
    3206:	0f be d2             	movsbl %dl,%edx
    3209:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    320d:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
    3211:	83 c1 01             	add    $0x1,%ecx
    3214:	8d 42 d0             	lea    -0x30(%edx),%eax
    3217:	3c 09                	cmp    $0x9,%al
    3219:	76 e8                	jbe    3203 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
    321b:	89 d8                	mov    %ebx,%eax
    321d:	5b                   	pop    %ebx
    321e:	5d                   	pop    %ebp
    321f:	c3                   	ret    

00003220 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    3220:	55                   	push   %ebp
    3221:	89 e5                	mov    %esp,%ebp
    3223:	8b 4d 10             	mov    0x10(%ebp),%ecx
    3226:	56                   	push   %esi
    3227:	8b 75 08             	mov    0x8(%ebp),%esi
    322a:	53                   	push   %ebx
    322b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    322e:	85 c9                	test   %ecx,%ecx
    3230:	7e 10                	jle    3242 <memmove+0x22>
    3232:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
    3234:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
    3238:	88 04 32             	mov    %al,(%edx,%esi,1)
    323b:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    323e:	39 ca                	cmp    %ecx,%edx
    3240:	75 f2                	jne    3234 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
    3242:	89 f0                	mov    %esi,%eax
    3244:	5b                   	pop    %ebx
    3245:	5e                   	pop    %esi
    3246:	5d                   	pop    %ebp
    3247:	c3                   	ret    
    3248:	90                   	nop    
    3249:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00003250 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
    3250:	55                   	push   %ebp
    3251:	89 e5                	mov    %esp,%ebp
    3253:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3256:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
    3259:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    325c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    325f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3264:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    326b:	00 
    326c:	89 04 24             	mov    %eax,(%esp)
    326f:	e8 d4 00 00 00       	call   3348 <open>
  if(fd < 0)
    3274:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3276:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
    3278:	78 19                	js     3293 <stat+0x43>
    return -1;
  r = fstat(fd, st);
    327a:	8b 45 0c             	mov    0xc(%ebp),%eax
    327d:	89 1c 24             	mov    %ebx,(%esp)
    3280:	89 44 24 04          	mov    %eax,0x4(%esp)
    3284:	e8 d7 00 00 00       	call   3360 <fstat>
  close(fd);
    3289:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
    328c:	89 c6                	mov    %eax,%esi
  close(fd);
    328e:	e8 9d 00 00 00       	call   3330 <close>
  return r;
}
    3293:	89 f0                	mov    %esi,%eax
    3295:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    3298:	8b 75 fc             	mov    -0x4(%ebp),%esi
    329b:	89 ec                	mov    %ebp,%esp
    329d:	5d                   	pop    %ebp
    329e:	c3                   	ret    
    329f:	90                   	nop    

000032a0 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
    32a0:	55                   	push   %ebp
    32a1:	89 e5                	mov    %esp,%ebp
    32a3:	57                   	push   %edi
    32a4:	56                   	push   %esi
    32a5:	31 f6                	xor    %esi,%esi
    32a7:	53                   	push   %ebx
    32a8:	83 ec 1c             	sub    $0x1c,%esp
    32ab:	8b 7d 08             	mov    0x8(%ebp),%edi
    32ae:	eb 06                	jmp    32b6 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    32b0:	3c 0d                	cmp    $0xd,%al
    32b2:	74 39                	je     32ed <gets+0x4d>
    32b4:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    32b6:	8d 5e 01             	lea    0x1(%esi),%ebx
    32b9:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    32bc:	7d 31                	jge    32ef <gets+0x4f>
    cc = read(0, &c, 1);
    32be:	8d 45 f3             	lea    -0xd(%ebp),%eax
    32c1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    32c8:	00 
    32c9:	89 44 24 04          	mov    %eax,0x4(%esp)
    32cd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    32d4:	e8 47 00 00 00       	call   3320 <read>
    if(cc < 1)
    32d9:	85 c0                	test   %eax,%eax
    32db:	7e 12                	jle    32ef <gets+0x4f>
      break;
    buf[i++] = c;
    32dd:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
    32e1:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
    32e5:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
    32e9:	3c 0a                	cmp    $0xa,%al
    32eb:	75 c3                	jne    32b0 <gets+0x10>
    32ed:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    32ef:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    32f3:	89 f8                	mov    %edi,%eax
    32f5:	83 c4 1c             	add    $0x1c,%esp
    32f8:	5b                   	pop    %ebx
    32f9:	5e                   	pop    %esi
    32fa:	5f                   	pop    %edi
    32fb:	5d                   	pop    %ebp
    32fc:	c3                   	ret    
    32fd:	90                   	nop    
    32fe:	90                   	nop    
    32ff:	90                   	nop    

00003300 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    3300:	b8 01 00 00 00       	mov    $0x1,%eax
    3305:	cd 40                	int    $0x40
    3307:	c3                   	ret    

00003308 <exit>:
SYSCALL(exit)
    3308:	b8 02 00 00 00       	mov    $0x2,%eax
    330d:	cd 40                	int    $0x40
    330f:	c3                   	ret    

00003310 <wait>:
SYSCALL(wait)
    3310:	b8 03 00 00 00       	mov    $0x3,%eax
    3315:	cd 40                	int    $0x40
    3317:	c3                   	ret    

00003318 <pipe>:
SYSCALL(pipe)
    3318:	b8 04 00 00 00       	mov    $0x4,%eax
    331d:	cd 40                	int    $0x40
    331f:	c3                   	ret    

00003320 <read>:
SYSCALL(read)
    3320:	b8 06 00 00 00       	mov    $0x6,%eax
    3325:	cd 40                	int    $0x40
    3327:	c3                   	ret    

00003328 <write>:
SYSCALL(write)
    3328:	b8 05 00 00 00       	mov    $0x5,%eax
    332d:	cd 40                	int    $0x40
    332f:	c3                   	ret    

00003330 <close>:
SYSCALL(close)
    3330:	b8 07 00 00 00       	mov    $0x7,%eax
    3335:	cd 40                	int    $0x40
    3337:	c3                   	ret    

00003338 <kill>:
SYSCALL(kill)
    3338:	b8 08 00 00 00       	mov    $0x8,%eax
    333d:	cd 40                	int    $0x40
    333f:	c3                   	ret    

00003340 <exec>:
SYSCALL(exec)
    3340:	b8 09 00 00 00       	mov    $0x9,%eax
    3345:	cd 40                	int    $0x40
    3347:	c3                   	ret    

00003348 <open>:
SYSCALL(open)
    3348:	b8 0a 00 00 00       	mov    $0xa,%eax
    334d:	cd 40                	int    $0x40
    334f:	c3                   	ret    

00003350 <mknod>:
SYSCALL(mknod)
    3350:	b8 0b 00 00 00       	mov    $0xb,%eax
    3355:	cd 40                	int    $0x40
    3357:	c3                   	ret    

00003358 <unlink>:
SYSCALL(unlink)
    3358:	b8 0c 00 00 00       	mov    $0xc,%eax
    335d:	cd 40                	int    $0x40
    335f:	c3                   	ret    

00003360 <fstat>:
SYSCALL(fstat)
    3360:	b8 0d 00 00 00       	mov    $0xd,%eax
    3365:	cd 40                	int    $0x40
    3367:	c3                   	ret    

00003368 <link>:
SYSCALL(link)
    3368:	b8 0e 00 00 00       	mov    $0xe,%eax
    336d:	cd 40                	int    $0x40
    336f:	c3                   	ret    

00003370 <mkdir>:
SYSCALL(mkdir)
    3370:	b8 0f 00 00 00       	mov    $0xf,%eax
    3375:	cd 40                	int    $0x40
    3377:	c3                   	ret    

00003378 <chdir>:
SYSCALL(chdir)
    3378:	b8 10 00 00 00       	mov    $0x10,%eax
    337d:	cd 40                	int    $0x40
    337f:	c3                   	ret    

00003380 <dup>:
SYSCALL(dup)
    3380:	b8 11 00 00 00       	mov    $0x11,%eax
    3385:	cd 40                	int    $0x40
    3387:	c3                   	ret    

00003388 <getpid>:
SYSCALL(getpid)
    3388:	b8 12 00 00 00       	mov    $0x12,%eax
    338d:	cd 40                	int    $0x40
    338f:	c3                   	ret    

00003390 <sbrk>:
SYSCALL(sbrk)
    3390:	b8 13 00 00 00       	mov    $0x13,%eax
    3395:	cd 40                	int    $0x40
    3397:	c3                   	ret    

00003398 <sleep>:
SYSCALL(sleep)
    3398:	b8 14 00 00 00       	mov    $0x14,%eax
    339d:	cd 40                	int    $0x40
    339f:	c3                   	ret    

000033a0 <uptime>:
SYSCALL(uptime)
    33a0:	b8 15 00 00 00       	mov    $0x15,%eax
    33a5:	cd 40                	int    $0x40
    33a7:	c3                   	ret    

000033a8 <freepages>:
// Added by Jingyue
SYSCALL(freepages)
    33a8:	b8 16 00 00 00       	mov    $0x16,%eax
    33ad:	cd 40                	int    $0x40
    33af:	c3                   	ret    

000033b0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    33b0:	55                   	push   %ebp
    33b1:	89 e5                	mov    %esp,%ebp
    33b3:	83 ec 18             	sub    $0x18,%esp
    33b6:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
    33b9:	8d 55 fc             	lea    -0x4(%ebp),%edx
    33bc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    33c3:	00 
    33c4:	89 54 24 04          	mov    %edx,0x4(%esp)
    33c8:	89 04 24             	mov    %eax,(%esp)
    33cb:	e8 58 ff ff ff       	call   3328 <write>
}
    33d0:	c9                   	leave  
    33d1:	c3                   	ret    
    33d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
    33d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000033e0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    33e0:	55                   	push   %ebp
    33e1:	89 e5                	mov    %esp,%ebp
    33e3:	57                   	push   %edi
    33e4:	56                   	push   %esi
    33e5:	89 ce                	mov    %ecx,%esi
    33e7:	53                   	push   %ebx
    33e8:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    33eb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    33ee:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    33f1:	85 c9                	test   %ecx,%ecx
    33f3:	74 04                	je     33f9 <printint+0x19>
    33f5:	85 d2                	test   %edx,%edx
    33f7:	78 54                	js     344d <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    33f9:	89 d0                	mov    %edx,%eax
    33fb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    3402:	31 db                	xor    %ebx,%ebx
    3404:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    3407:	31 d2                	xor    %edx,%edx
    3409:	f7 f6                	div    %esi
    340b:	89 c1                	mov    %eax,%ecx
    340d:	0f b6 82 7f 4b 00 00 	movzbl 0x4b7f(%edx),%eax
    3414:	88 04 3b             	mov    %al,(%ebx,%edi,1)
    3417:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
    341a:	85 c9                	test   %ecx,%ecx
    341c:	89 c8                	mov    %ecx,%eax
    341e:	75 e7                	jne    3407 <printint+0x27>
  if(neg)
    3420:	8b 45 e0             	mov    -0x20(%ebp),%eax
    3423:	85 c0                	test   %eax,%eax
    3425:	74 08                	je     342f <printint+0x4f>
    buf[i++] = '-';
    3427:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
    342c:	83 c3 01             	add    $0x1,%ebx
    342f:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
    3432:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
    3436:	83 eb 01             	sub    $0x1,%ebx
    3439:	8b 45 dc             	mov    -0x24(%ebp),%eax
    343c:	e8 6f ff ff ff       	call   33b0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    3441:	39 fb                	cmp    %edi,%ebx
    3443:	75 ed                	jne    3432 <printint+0x52>
    putc(fd, buf[i]);
}
    3445:	83 c4 1c             	add    $0x1c,%esp
    3448:	5b                   	pop    %ebx
    3449:	5e                   	pop    %esi
    344a:	5f                   	pop    %edi
    344b:	5d                   	pop    %ebp
    344c:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    344d:	89 d0                	mov    %edx,%eax
    344f:	f7 d8                	neg    %eax
    3451:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
    3458:	eb a8                	jmp    3402 <printint+0x22>
    345a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00003460 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    3460:	55                   	push   %ebp
    3461:	89 e5                	mov    %esp,%ebp
    3463:	57                   	push   %edi
    3464:	56                   	push   %esi
    3465:	53                   	push   %ebx
    3466:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3469:	8b 55 0c             	mov    0xc(%ebp),%edx
    346c:	0f b6 02             	movzbl (%edx),%eax
    346f:	84 c0                	test   %al,%al
    3471:	0f 84 87 00 00 00    	je     34fe <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    3477:	8d 4d 10             	lea    0x10(%ebp),%ecx
    347a:	31 ff                	xor    %edi,%edi
    347c:	31 f6                	xor    %esi,%esi
    347e:	89 4d f0             	mov    %ecx,-0x10(%ebp)
    3481:	eb 18                	jmp    349b <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    3483:	83 fb 25             	cmp    $0x25,%ebx
    3486:	0f 85 7a 00 00 00    	jne    3506 <printf+0xa6>
    348c:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3490:	83 c7 01             	add    $0x1,%edi
    3493:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
    3497:	84 c0                	test   %al,%al
    3499:	74 63                	je     34fe <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
    349b:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    349d:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
    34a0:	74 e1                	je     3483 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    34a2:	83 fe 25             	cmp    $0x25,%esi
    34a5:	75 e9                	jne    3490 <printf+0x30>
      if(c == 'd'){
    34a7:	83 fb 64             	cmp    $0x64,%ebx
    34aa:	0f 84 f0 00 00 00    	je     35a0 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    34b0:	83 fb 78             	cmp    $0x78,%ebx
    34b3:	74 64                	je     3519 <printf+0xb9>
    34b5:	83 fb 70             	cmp    $0x70,%ebx
    34b8:	74 5f                	je     3519 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    34ba:	83 fb 73             	cmp    $0x73,%ebx
    34bd:	8d 76 00             	lea    0x0(%esi),%esi
    34c0:	74 7e                	je     3540 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    34c2:	83 fb 63             	cmp    $0x63,%ebx
    34c5:	0f 84 b9 00 00 00    	je     3584 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    34cb:	83 fb 25             	cmp    $0x25,%ebx
    34ce:	66 90                	xchg   %ax,%ax
    34d0:	0f 84 f2 00 00 00    	je     35c8 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    34d6:	8b 45 08             	mov    0x8(%ebp),%eax
    34d9:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    34de:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    34e1:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    34e3:	e8 c8 fe ff ff       	call   33b0 <putc>
        putc(fd, c);
    34e8:	8b 45 08             	mov    0x8(%ebp),%eax
    34eb:	0f be d3             	movsbl %bl,%edx
    34ee:	e8 bd fe ff ff       	call   33b0 <putc>
    34f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    34f6:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
    34fa:	84 c0                	test   %al,%al
    34fc:	75 9d                	jne    349b <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    34fe:	83 c4 0c             	add    $0xc,%esp
    3501:	5b                   	pop    %ebx
    3502:	5e                   	pop    %esi
    3503:	5f                   	pop    %edi
    3504:	5d                   	pop    %ebp
    3505:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    3506:	8b 45 08             	mov    0x8(%ebp),%eax
    3509:	0f be d3             	movsbl %bl,%edx
    350c:	e8 9f fe ff ff       	call   33b0 <putc>
    3511:	8b 55 0c             	mov    0xc(%ebp),%edx
    3514:	e9 77 ff ff ff       	jmp    3490 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    3519:	8b 45 f0             	mov    -0x10(%ebp),%eax
    351c:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
    3521:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    3523:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    352a:	8b 10                	mov    (%eax),%edx
    352c:	8b 45 08             	mov    0x8(%ebp),%eax
    352f:	e8 ac fe ff ff       	call   33e0 <printint>
    3534:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
    3537:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
    353b:	e9 50 ff ff ff       	jmp    3490 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
    3540:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    3543:	8b 01                	mov    (%ecx),%eax
        ap++;
    3545:	83 c1 04             	add    $0x4,%ecx
    3548:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
    354b:	b9 78 4b 00 00       	mov    $0x4b78,%ecx
    3550:	85 c0                	test   %eax,%eax
    3552:	75 2c                	jne    3580 <printf+0x120>
          s = "(null)";
        while(*s != 0){
    3554:	0f b6 01             	movzbl (%ecx),%eax
    3557:	84 c0                	test   %al,%al
    3559:	74 1e                	je     3579 <printf+0x119>
    355b:	89 cb                	mov    %ecx,%ebx
    355d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
    3560:	0f be d0             	movsbl %al,%edx
    3563:	8b 45 08             	mov    0x8(%ebp),%eax
    3566:	e8 45 fe ff ff       	call   33b0 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    356b:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
    356f:	83 c3 01             	add    $0x1,%ebx
    3572:	84 c0                	test   %al,%al
    3574:	75 ea                	jne    3560 <printf+0x100>
    3576:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    3579:	31 f6                	xor    %esi,%esi
    357b:	e9 10 ff ff ff       	jmp    3490 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
    3580:	89 c1                	mov    %eax,%ecx
    3582:	eb d0                	jmp    3554 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    3584:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
    3587:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    3589:	0f be 10             	movsbl (%eax),%edx
    358c:	8b 45 08             	mov    0x8(%ebp),%eax
    358f:	e8 1c fe ff ff       	call   33b0 <putc>
    3594:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
    3597:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
    359b:	e9 f0 fe ff ff       	jmp    3490 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    35a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    35a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
    35a8:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    35ab:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    35b2:	8b 10                	mov    (%eax),%edx
    35b4:	8b 45 08             	mov    0x8(%ebp),%eax
    35b7:	e8 24 fe ff ff       	call   33e0 <printint>
    35bc:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
    35bf:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
    35c3:	e9 c8 fe ff ff       	jmp    3490 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
    35c8:	8b 45 08             	mov    0x8(%ebp),%eax
    35cb:	ba 25 00 00 00       	mov    $0x25,%edx
    35d0:	31 f6                	xor    %esi,%esi
    35d2:	e8 d9 fd ff ff       	call   33b0 <putc>
    35d7:	8b 55 0c             	mov    0xc(%ebp),%edx
    35da:	e9 b1 fe ff ff       	jmp    3490 <printf+0x30>
    35df:	90                   	nop    

000035e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    35e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    35e1:	8b 0d c8 4b 00 00    	mov    0x4bc8,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
    35e7:	89 e5                	mov    %esp,%ebp
    35e9:	56                   	push   %esi
    35ea:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
    35eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    35ee:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    35f1:	39 d9                	cmp    %ebx,%ecx
    35f3:	73 18                	jae    360d <free+0x2d>
    35f5:	8b 11                	mov    (%ecx),%edx
    35f7:	39 d3                	cmp    %edx,%ebx
    35f9:	72 17                	jb     3612 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    35fb:	39 d1                	cmp    %edx,%ecx
    35fd:	72 08                	jb     3607 <free+0x27>
    35ff:	39 d9                	cmp    %ebx,%ecx
    3601:	72 0f                	jb     3612 <free+0x32>
    3603:	39 d3                	cmp    %edx,%ebx
    3605:	72 0b                	jb     3612 <free+0x32>
    3607:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3609:	39 d9                	cmp    %ebx,%ecx
    360b:	72 e8                	jb     35f5 <free+0x15>
    360d:	8b 11                	mov    (%ecx),%edx
    360f:	90                   	nop    
    3610:	eb e9                	jmp    35fb <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    3612:	8b 73 04             	mov    0x4(%ebx),%esi
    3615:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
    3618:	39 d0                	cmp    %edx,%eax
    361a:	74 18                	je     3634 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    361c:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
    361e:	8b 51 04             	mov    0x4(%ecx),%edx
    3621:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
    3624:	39 d8                	cmp    %ebx,%eax
    3626:	74 20                	je     3648 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    3628:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
    362a:	5b                   	pop    %ebx
    362b:	5e                   	pop    %esi
    362c:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
    362d:	89 0d c8 4b 00 00    	mov    %ecx,0x4bc8
}
    3633:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    3634:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
    3637:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    3639:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    363c:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    363f:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    3641:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
    3644:	39 d8                	cmp    %ebx,%eax
    3646:	75 e0                	jne    3628 <free+0x48>
    p->s.size += bp->s.size;
    3648:	03 53 04             	add    0x4(%ebx),%edx
    364b:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
    364e:	8b 13                	mov    (%ebx),%edx
    3650:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
    3652:	5b                   	pop    %ebx
    3653:	5e                   	pop    %esi
    3654:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
    3655:	89 0d c8 4b 00 00    	mov    %ecx,0x4bc8
}
    365b:	c3                   	ret    
    365c:	8d 74 26 00          	lea    0x0(%esi),%esi

00003660 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3660:	55                   	push   %ebp
    3661:	89 e5                	mov    %esp,%ebp
    3663:	57                   	push   %edi
    3664:	56                   	push   %esi
    3665:	53                   	push   %ebx
    3666:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3669:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    366c:	8b 15 c8 4b 00 00    	mov    0x4bc8,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3672:	83 c0 07             	add    $0x7,%eax
    3675:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
    3678:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    367a:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
    367d:	0f 84 8a 00 00 00    	je     370d <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3683:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
    3685:	8b 41 04             	mov    0x4(%ecx),%eax
    3688:	39 c3                	cmp    %eax,%ebx
    368a:	76 1a                	jbe    36a6 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    368c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
    3693:	3b 0d c8 4b 00 00    	cmp    0x4bc8,%ecx
    3699:	89 ca                	mov    %ecx,%edx
    369b:	74 29                	je     36c6 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    369d:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
    369f:	8b 41 04             	mov    0x4(%ecx),%eax
    36a2:	39 c3                	cmp    %eax,%ebx
    36a4:	77 ed                	ja     3693 <malloc+0x33>
      if(p->s.size == nunits)
    36a6:	39 c3                	cmp    %eax,%ebx
    36a8:	74 5d                	je     3707 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    36aa:	29 d8                	sub    %ebx,%eax
    36ac:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
    36af:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
    36b2:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
    36b5:	89 15 c8 4b 00 00    	mov    %edx,0x4bc8
      return (void*) (p + 1);
    36bb:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    36be:	83 c4 0c             	add    $0xc,%esp
    36c1:	5b                   	pop    %ebx
    36c2:	5e                   	pop    %esi
    36c3:	5f                   	pop    %edi
    36c4:	5d                   	pop    %ebp
    36c5:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    36c6:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
    36cc:	89 de                	mov    %ebx,%esi
    36ce:	89 f8                	mov    %edi,%eax
    36d0:	76 29                	jbe    36fb <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    36d2:	89 04 24             	mov    %eax,(%esp)
    36d5:	e8 b6 fc ff ff       	call   3390 <sbrk>
  if(p == (char*) -1)
    36da:	83 f8 ff             	cmp    $0xffffffff,%eax
    36dd:	74 18                	je     36f7 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    36df:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
    36e2:	83 c0 08             	add    $0x8,%eax
    36e5:	89 04 24             	mov    %eax,(%esp)
    36e8:	e8 f3 fe ff ff       	call   35e0 <free>
  return freep;
    36ed:	8b 15 c8 4b 00 00    	mov    0x4bc8,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    36f3:	85 d2                	test   %edx,%edx
    36f5:	75 a6                	jne    369d <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    36f7:	31 c0                	xor    %eax,%eax
    36f9:	eb c3                	jmp    36be <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    36fb:	be 00 10 00 00       	mov    $0x1000,%esi
    3700:	b8 00 80 00 00       	mov    $0x8000,%eax
    3705:	eb cb                	jmp    36d2 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    3707:	8b 01                	mov    (%ecx),%eax
    3709:	89 02                	mov    %eax,(%edx)
    370b:	eb a8                	jmp    36b5 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
    370d:	ba c0 4b 00 00       	mov    $0x4bc0,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    3712:	c7 05 c8 4b 00 00 c0 	movl   $0x4bc0,0x4bc8
    3719:	4b 00 00 
    371c:	c7 05 c0 4b 00 00 c0 	movl   $0x4bc0,0x4bc0
    3723:	4b 00 00 
    base.s.size = 0;
    3726:	c7 05 c4 4b 00 00 00 	movl   $0x0,0x4bc4
    372d:	00 00 00 
    3730:	e9 4e ff ff ff       	jmp    3683 <malloc+0x23>
