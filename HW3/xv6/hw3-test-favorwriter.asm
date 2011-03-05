
_hw3-test-favorwriter:     file format elf32-i386

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
  49:	c7 44 24 04 18 0a 00 	movl   $0xa18,0x4(%esp)
  50:	00 
  51:	89 44 24 08          	mov    %eax,0x8(%esp)
  55:	a1 d4 0a 00 00       	mov    0xad4,%eax
  5a:	89 04 24             	mov    %eax,(%esp)
  5d:	e8 de 06 00 00       	call   740 <printf>
  exit();
  62:	e8 61 05 00 00       	call   5c8 <exit>
  67:	89 f6                	mov    %esi,%esi
  69:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000070 <writer_main>:
  sleep(SLEEP_TIME);
  rwlock(m, OP_READUNLOCK);
  texit();
}

void writer_main(void *arg) {
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	53                   	push   %ebx
  74:	83 ec 14             	sub    $0x14,%esp
  77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct rwlock *m = arg;
  rwlock(m, OP_WRITELOCK);
  7a:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
  81:	00 
  82:	89 1c 24             	mov    %ebx,(%esp)
  85:	e8 e6 05 00 00       	call   670 <rwlock>
  sleep(SLEEP_TIME);
  8a:	c7 04 24 2c 01 00 00 	movl   $0x12c,(%esp)
  91:	e8 c2 05 00 00       	call   658 <sleep>
  rwlock(m, OP_WRITEUNLOCK);
  96:	89 1c 24             	mov    %ebx,(%esp)
  99:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
  a0:	00 
  a1:	e8 ca 05 00 00       	call   670 <rwlock>
  texit();
}
  a6:	83 c4 14             	add    $0x14,%esp
  a9:	5b                   	pop    %ebx
  aa:	5d                   	pop    %ebp
void writer_main(void *arg) {
  struct rwlock *m = arg;
  rwlock(m, OP_WRITELOCK);
  sleep(SLEEP_TIME);
  rwlock(m, OP_WRITEUNLOCK);
  texit();
  ab:	e9 d0 05 00 00       	jmp    680 <texit>

000000b0 <reader_main>:

#define N (5)
#define SLEEP_TIME (ONE_SEC * 3) // Must be a multiple of ONE_SEC
#define STACK_SIZE (4096)

void reader_main(void *arg) {
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	53                   	push   %ebx
  b4:	83 ec 14             	sub    $0x14,%esp
  b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct rwlock *m = arg;
  rwlock(m, OP_READLOCK);
  ba:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  c1:	00 
  c2:	89 1c 24             	mov    %ebx,(%esp)
  c5:	e8 a6 05 00 00       	call   670 <rwlock>
  sleep(SLEEP_TIME);
  ca:	c7 04 24 2c 01 00 00 	movl   $0x12c,(%esp)
  d1:	e8 82 05 00 00       	call   658 <sleep>
  rwlock(m, OP_READUNLOCK);
  d6:	89 1c 24             	mov    %ebx,(%esp)
  d9:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  e0:	00 
  e1:	e8 8a 05 00 00       	call   670 <rwlock>
  texit();
}
  e6:	83 c4 14             	add    $0x14,%esp
  e9:	5b                   	pop    %ebx
  ea:	5d                   	pop    %ebp
void reader_main(void *arg) {
  struct rwlock *m = arg;
  rwlock(m, OP_READLOCK);
  sleep(SLEEP_TIME);
  rwlock(m, OP_READUNLOCK);
  texit();
  eb:	e9 90 05 00 00       	jmp    680 <texit>

000000f0 <main>:
  sleep(SLEEP_TIME);
  rwlock(m, OP_WRITEUNLOCK);
  texit();
}

int main() {
  f0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  f4:	83 e4 f0             	and    $0xfffffff0,%esp
  f7:	ff 71 fc             	pushl  -0x4(%ecx)
  fa:	55                   	push   %ebp
  fb:	89 e5                	mov    %esp,%ebp
  fd:	57                   	push   %edi
  fe:	56                   	push   %esi
  ff:	53                   	push   %ebx
  char *reader_stacks[N], *writer_stacks[N];
  int reader_tids[N], writer_tids[N];

  for (j = 0; j < N; j++) {
    writer_stacks[j] = malloc(STACK_SIZE);
    reader_stacks[j] = malloc(STACK_SIZE);
 100:	bb 02 00 00 00       	mov    $0x2,%ebx
  sleep(SLEEP_TIME);
  rwlock(m, OP_WRITEUNLOCK);
  texit();
}

int main() {
 105:	51                   	push   %ecx
 106:	83 ec 68             	sub    $0x68,%esp
  
  struct rwlock m;
  int t, j;
  int start = uptime();
 109:	e8 52 05 00 00       	call   660 <uptime>
  char *reader_stacks[N], *writer_stacks[N];
  int reader_tids[N], writer_tids[N];

  for (j = 0; j < N; j++) {
    writer_stacks[j] = malloc(STACK_SIZE);
 10e:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)

int main() {
  
  struct rwlock m;
  int t, j;
  int start = uptime();
 115:	89 45 9c             	mov    %eax,-0x64(%ebp)
  char *reader_stacks[N], *writer_stacks[N];
  int reader_tids[N], writer_tids[N];

  for (j = 0; j < N; j++) {
    writer_stacks[j] = malloc(STACK_SIZE);
 118:	e8 23 08 00 00       	call   940 <malloc>
    reader_stacks[j] = malloc(STACK_SIZE);
 11d:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  int start = uptime();
  char *reader_stacks[N], *writer_stacks[N];
  int reader_tids[N], writer_tids[N];

  for (j = 0; j < N; j++) {
    writer_stacks[j] = malloc(STACK_SIZE);
 124:	89 45 c8             	mov    %eax,-0x38(%ebp)
    reader_stacks[j] = malloc(STACK_SIZE);
 127:	e8 14 08 00 00       	call   940 <malloc>
 12c:	89 45 dc             	mov    %eax,-0x24(%ebp)
 12f:	90                   	nop    
  int start = uptime();
  char *reader_stacks[N], *writer_stacks[N];
  int reader_tids[N], writer_tids[N];

  for (j = 0; j < N; j++) {
    writer_stacks[j] = malloc(STACK_SIZE);
 130:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 137:	e8 04 08 00 00       	call   940 <malloc>
    reader_stacks[j] = malloc(STACK_SIZE);
 13c:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  int start = uptime();
  char *reader_stacks[N], *writer_stacks[N];
  int reader_tids[N], writer_tids[N];

  for (j = 0; j < N; j++) {
    writer_stacks[j] = malloc(STACK_SIZE);
 143:	89 44 9d c4          	mov    %eax,-0x3c(%ebp,%ebx,4)
    reader_stacks[j] = malloc(STACK_SIZE);
 147:	e8 f4 07 00 00       	call   940 <malloc>
 14c:	89 44 9d d8          	mov    %eax,-0x28(%ebp,%ebx,4)
 150:	83 c3 01             	add    $0x1,%ebx
  int t, j;
  int start = uptime();
  char *reader_stacks[N], *writer_stacks[N];
  int reader_tids[N], writer_tids[N];

  for (j = 0; j < N; j++) {
 153:	83 fb 06             	cmp    $0x6,%ebx
 156:	75 d8                	jne    130 <main+0x40>
    writer_stacks[j] = malloc(STACK_SIZE);
    reader_stacks[j] = malloc(STACK_SIZE);
  }

  rwlock(&m, OP_INIT);
 158:	8d 45 f0             	lea    -0x10(%ebp),%eax
 15b:	31 f6                	xor    %esi,%esi
 15d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 164:	00 
 165:	89 04 24             	mov    %eax,(%esp)
 168:	e8 03 05 00 00       	call   670 <rwlock>
 16d:	eb 5c                	jmp    1cb <main+0xdb>
 16f:	90                   	nop    

  for (t = 0; t <= (N - 1) * SLEEP_TIME; t += ONE_SEC) {
    printf(stderr, "Time: %d / %d\n", t, (N - 1) * SLEEP_TIME);
    if (t == 0 || t % SLEEP_TIME == ONE_SEC * 2) {
 170:	89 f0                	mov    %esi,%eax
 172:	b9 b5 81 4e 1b       	mov    $0x1b4e81b5,%ecx
 177:	f7 e9                	imul   %ecx
 179:	89 f0                	mov    %esi,%eax
 17b:	c1 f8 1f             	sar    $0x1f,%eax
 17e:	c1 fa 05             	sar    $0x5,%edx
 181:	29 c2                	sub    %eax,%edx
 183:	89 f0                	mov    %esi,%eax
 185:	69 d2 2c 01 00 00    	imul   $0x12c,%edx,%edx
 18b:	29 d0                	sub    %edx,%eax
 18d:	3d c8 00 00 00       	cmp    $0xc8,%eax
 192:	0f 84 8c 00 00 00    	je     224 <main+0x134>
          writer_main,
          &m,
          writer_stacks[i] + STACK_SIZE);
      if (writer_tids[i] < 0)
        handle_error("error on tfork()");
    } else if (t % SLEEP_TIME == ONE_SEC || t == (N - 1) * SLEEP_TIME) {
 198:	83 f8 64             	cmp    $0x64,%eax
 19b:	0f 84 96 00 00 00    	je     237 <main+0x147>
 1a1:	81 fe b0 04 00 00    	cmp    $0x4b0,%esi
 1a7:	0f 84 93 01 00 00    	je     340 <main+0x250>
 1ad:	8d 76 00             	lea    0x0(%esi),%esi
    reader_stacks[j] = malloc(STACK_SIZE);
  }

  rwlock(&m, OP_INIT);

  for (t = 0; t <= (N - 1) * SLEEP_TIME; t += ONE_SEC) {
 1b0:	83 c6 64             	add    $0x64,%esi
          &m,
          reader_stacks[i] + STACK_SIZE);
      if (reader_tids[i] < 0)
        handle_error("error on tfork()");
    }
    sleep(ONE_SEC);
 1b3:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 1ba:	e8 99 04 00 00       	call   658 <sleep>
    reader_stacks[j] = malloc(STACK_SIZE);
  }

  rwlock(&m, OP_INIT);

  for (t = 0; t <= (N - 1) * SLEEP_TIME; t += ONE_SEC) {
 1bf:	81 fe 14 05 00 00    	cmp    $0x514,%esi
 1c5:	0f 84 ba 00 00 00    	je     285 <main+0x195>
    printf(stderr, "Time: %d / %d\n", t, (N - 1) * SLEEP_TIME);
 1cb:	a1 d4 0a 00 00       	mov    0xad4,%eax
    if (t == 0 || t % SLEEP_TIME == ONE_SEC * 2) {
 1d0:	31 db                	xor    %ebx,%ebx
  }

  rwlock(&m, OP_INIT);

  for (t = 0; t <= (N - 1) * SLEEP_TIME; t += ONE_SEC) {
    printf(stderr, "Time: %d / %d\n", t, (N - 1) * SLEEP_TIME);
 1d2:	c7 44 24 0c b0 04 00 	movl   $0x4b0,0xc(%esp)
 1d9:	00 
 1da:	89 74 24 08          	mov    %esi,0x8(%esp)
 1de:	c7 44 24 04 1c 0a 00 	movl   $0xa1c,0x4(%esp)
 1e5:	00 
 1e6:	89 04 24             	mov    %eax,(%esp)
 1e9:	e8 52 05 00 00       	call   740 <printf>
    if (t == 0 || t % SLEEP_TIME == ONE_SEC * 2) {
 1ee:	85 f6                	test   %esi,%esi
 1f0:	0f 85 7a ff ff ff    	jne    170 <main+0x80>
      int i = (t == 0 ? 0 : (t + ONE_SEC) / SLEEP_TIME);
      writer_tids[i] = tfork(
 1f6:	8b 44 9d c8          	mov    -0x38(%ebp,%ebx,4),%eax
 1fa:	8d 4d f0             	lea    -0x10(%ebp),%ecx
 1fd:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 201:	c7 04 24 70 00 00 00 	movl   $0x70,(%esp)
 208:	05 00 10 00 00       	add    $0x1000,%eax
 20d:	89 44 24 08          	mov    %eax,0x8(%esp)
 211:	e8 62 04 00 00       	call   678 <tfork>
          writer_main,
          &m,
          writer_stacks[i] + STACK_SIZE);
      if (writer_tids[i] < 0)
 216:	85 c0                	test   %eax,%eax
 218:	0f 88 35 01 00 00    	js     353 <main+0x263>

  for (t = 0; t <= (N - 1) * SLEEP_TIME; t += ONE_SEC) {
    printf(stderr, "Time: %d / %d\n", t, (N - 1) * SLEEP_TIME);
    if (t == 0 || t % SLEEP_TIME == ONE_SEC * 2) {
      int i = (t == 0 ? 0 : (t + ONE_SEC) / SLEEP_TIME);
      writer_tids[i] = tfork(
 21e:	89 44 9d a0          	mov    %eax,-0x60(%ebp,%ebx,4)
 222:	eb 8c                	jmp    1b0 <main+0xc0>
  rwlock(&m, OP_INIT);

  for (t = 0; t <= (N - 1) * SLEEP_TIME; t += ONE_SEC) {
    printf(stderr, "Time: %d / %d\n", t, (N - 1) * SLEEP_TIME);
    if (t == 0 || t % SLEEP_TIME == ONE_SEC * 2) {
      int i = (t == 0 ? 0 : (t + ONE_SEC) / SLEEP_TIME);
 224:	8d 7e 64             	lea    0x64(%esi),%edi
 227:	89 f8                	mov    %edi,%eax
 229:	f7 e9                	imul   %ecx
 22b:	c1 ff 1f             	sar    $0x1f,%edi
 22e:	89 d3                	mov    %edx,%ebx
 230:	c1 fb 05             	sar    $0x5,%ebx
 233:	29 fb                	sub    %edi,%ebx
 235:	eb bf                	jmp    1f6 <main+0x106>
          &m,
          writer_stacks[i] + STACK_SIZE);
      if (writer_tids[i] < 0)
        handle_error("error on tfork()");
    } else if (t % SLEEP_TIME == ONE_SEC || t == (N - 1) * SLEEP_TIME) {
      int i = (t == (N - 1) * SLEEP_TIME ? N - 1 : (t - ONE_SEC) / SLEEP_TIME);
 237:	81 fe b0 04 00 00    	cmp    $0x4b0,%esi
 23d:	0f 84 fd 00 00 00    	je     340 <main+0x250>
 243:	8d 7e 9c             	lea    -0x64(%esi),%edi
 246:	89 f8                	mov    %edi,%eax
 248:	f7 e9                	imul   %ecx
 24a:	c1 ff 1f             	sar    $0x1f,%edi
 24d:	89 d3                	mov    %edx,%ebx
 24f:	c1 fb 05             	sar    $0x5,%ebx
 252:	29 fb                	sub    %edi,%ebx
      reader_tids[i] = tfork(
 254:	8b 44 9d dc          	mov    -0x24(%ebp,%ebx,4),%eax
 258:	8d 4d f0             	lea    -0x10(%ebp),%ecx
 25b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 25f:	c7 04 24 b0 00 00 00 	movl   $0xb0,(%esp)
 266:	05 00 10 00 00       	add    $0x1000,%eax
 26b:	89 44 24 08          	mov    %eax,0x8(%esp)
 26f:	e8 04 04 00 00       	call   678 <tfork>
          reader_main,
          &m,
          reader_stacks[i] + STACK_SIZE);
      if (reader_tids[i] < 0)
 274:	85 c0                	test   %eax,%eax
 276:	0f 88 d7 00 00 00    	js     353 <main+0x263>
          writer_stacks[i] + STACK_SIZE);
      if (writer_tids[i] < 0)
        handle_error("error on tfork()");
    } else if (t % SLEEP_TIME == ONE_SEC || t == (N - 1) * SLEEP_TIME) {
      int i = (t == (N - 1) * SLEEP_TIME ? N - 1 : (t - ONE_SEC) / SLEEP_TIME);
      reader_tids[i] = tfork(
 27c:	89 44 9d b4          	mov    %eax,-0x4c(%ebp,%ebx,4)
 280:	e9 2b ff ff ff       	jmp    1b0 <main+0xc0>
    reader_stacks[j] = malloc(STACK_SIZE);
  }

  rwlock(&m, OP_INIT);

  for (t = 0; t <= (N - 1) * SLEEP_TIME; t += ONE_SEC) {
 285:	bb 01 00 00 00       	mov    $0x1,%ebx
 28a:	8d 7d b4             	lea    -0x4c(%ebp),%edi
  }

  for (j = 0; j < N; j++) {
    if (twait(reader_tids[j]) < 0)
      handle_error("error on twait()");
    if (twait(writer_tids[j]) < 0)
 28d:	8d 75 a0             	lea    -0x60(%ebp),%esi
    }
    sleep(ONE_SEC);
  }

  for (j = 0; j < N; j++) {
    if (twait(reader_tids[j]) < 0)
 290:	8b 44 9f fc          	mov    -0x4(%edi,%ebx,4),%eax
 294:	89 04 24             	mov    %eax,(%esp)
 297:	e8 ec 03 00 00       	call   688 <twait>
 29c:	85 c0                	test   %eax,%eax
 29e:	0f 88 b9 00 00 00    	js     35d <main+0x26d>
      handle_error("error on twait()");
    if (twait(writer_tids[j]) < 0)
 2a4:	8b 44 9e fc          	mov    -0x4(%esi,%ebx,4),%eax
 2a8:	89 04 24             	mov    %eax,(%esp)
 2ab:	e8 d8 03 00 00       	call   688 <twait>
 2b0:	85 c0                	test   %eax,%eax
 2b2:	0f 88 a5 00 00 00    	js     35d <main+0x26d>
 2b8:	83 c3 01             	add    $0x1,%ebx
        handle_error("error on tfork()");
    }
    sleep(ONE_SEC);
  }

  for (j = 0; j < N; j++) {
 2bb:	83 fb 06             	cmp    $0x6,%ebx
 2be:	75 d0                	jne    290 <main+0x1a0>
      handle_error("error on twait()");
    if (twait(writer_tids[j]) < 0)
      handle_error("error on twait()");
  }

  rwlock(&m, OP_DESTROY);
 2c0:	8d 45 f0             	lea    -0x10(%ebp),%eax
 2c3:	c7 44 24 04 05 00 00 	movl   $0x5,0x4(%esp)
 2ca:	00 
 2cb:	89 04 24             	mov    %eax,(%esp)
 2ce:	e8 9d 03 00 00       	call   670 <rwlock>
  
  printf(stderr, "Program finished in %d tick(s).\n", uptime() - start);
 2d3:	e8 88 03 00 00       	call   660 <uptime>
 2d8:	c7 44 24 04 50 0a 00 	movl   $0xa50,0x4(%esp)
 2df:	00 
 2e0:	2b 45 9c             	sub    -0x64(%ebp),%eax
 2e3:	89 44 24 08          	mov    %eax,0x8(%esp)
 2e7:	a1 d4 0a 00 00       	mov    0xad4,%eax
 2ec:	89 04 24             	mov    %eax,(%esp)
 2ef:	e8 4c 04 00 00       	call   740 <printf>
  if (!time_equal(uptime() - start, SLEEP_TIME * (N + 1)))
 2f4:	e8 67 03 00 00       	call   660 <uptime>
int stdout = 1;
int stderr = 2;

// Return true if <a> and <b> differ in at most 5%. 
inline int time_equal(int a, int b) {
  if (a < 0 || b < 0)
 2f9:	2b 45 9c             	sub    -0x64(%ebp),%eax
 2fc:	78 19                	js     317 <main+0x227>
    return 0;
  if (a > b) {
 2fe:	3d 08 07 00 00       	cmp    $0x708,%eax
 303:	ba 08 07 00 00       	mov    $0x708,%edx
 308:	7f 40                	jg     34a <main+0x25a>
 30a:	89 d1                	mov    %edx,%ecx
 30c:	29 c1                	sub    %eax,%ecx
 30e:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
 311:	01 c0                	add    %eax,%eax
 313:	39 c2                	cmp    %eax,%edx
 315:	7d 50                	jge    367 <main+0x277>
  }
  return 10 * (b - a) <= b;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 317:	c7 44 24 08 74 0a 00 	movl   $0xa74,0x8(%esp)
 31e:	00 
  exit();
 31f:	a1 d4 0a 00 00       	mov    0xad4,%eax
 324:	c7 44 24 04 18 0a 00 	movl   $0xa18,0x4(%esp)
 32b:	00 
 32c:	89 04 24             	mov    %eax,(%esp)
 32f:	e8 0c 04 00 00       	call   740 <printf>
 334:	e8 8f 02 00 00       	call   5c8 <exit>
 339:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
          &m,
          writer_stacks[i] + STACK_SIZE);
      if (writer_tids[i] < 0)
        handle_error("error on tfork()");
    } else if (t % SLEEP_TIME == ONE_SEC || t == (N - 1) * SLEEP_TIME) {
      int i = (t == (N - 1) * SLEEP_TIME ? N - 1 : (t - ONE_SEC) / SLEEP_TIME);
 340:	bb 04 00 00 00       	mov    $0x4,%ebx
 345:	e9 0a ff ff ff       	jmp    254 <main+0x164>

// Return true if <a> and <b> differ in at most 5%. 
inline int time_equal(int a, int b) {
  if (a < 0 || b < 0)
    return 0;
  if (a > b) {
 34a:	89 c2                	mov    %eax,%edx
 34c:	b8 08 07 00 00       	mov    $0x708,%eax
 351:	eb b7                	jmp    30a <main+0x21a>
  }
  return 10 * (b - a) <= b;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 353:	c7 44 24 08 2b 0a 00 	movl   $0xa2b,0x8(%esp)
 35a:	00 
 35b:	eb c2                	jmp    31f <main+0x22f>
 35d:	c7 44 24 08 3c 0a 00 	movl   $0xa3c,0x8(%esp)
 364:	00 
 365:	eb b8                	jmp    31f <main+0x22f>
  printf(stderr, "Program finished in %d tick(s).\n", uptime() - start);
  if (!time_equal(uptime() - start, SLEEP_TIME * (N + 1)))
    handle_error("Did not finish in a correct time.");

  for (j = 0; j < N; j++) {
    free(reader_stacks[j]);
 367:	8b 45 dc             	mov    -0x24(%ebp),%eax
    free(writer_stacks[j]);
 36a:	bb 02 00 00 00       	mov    $0x2,%ebx
  printf(stderr, "Program finished in %d tick(s).\n", uptime() - start);
  if (!time_equal(uptime() - start, SLEEP_TIME * (N + 1)))
    handle_error("Did not finish in a correct time.");

  for (j = 0; j < N; j++) {
    free(reader_stacks[j]);
 36f:	89 04 24             	mov    %eax,(%esp)
 372:	e8 49 05 00 00       	call   8c0 <free>
    free(writer_stacks[j]);
 377:	8b 45 c8             	mov    -0x38(%ebp),%eax
 37a:	89 04 24             	mov    %eax,(%esp)
 37d:	e8 3e 05 00 00       	call   8c0 <free>
  printf(stderr, "Program finished in %d tick(s).\n", uptime() - start);
  if (!time_equal(uptime() - start, SLEEP_TIME * (N + 1)))
    handle_error("Did not finish in a correct time.");

  for (j = 0; j < N; j++) {
    free(reader_stacks[j]);
 382:	8b 44 9d d8          	mov    -0x28(%ebp,%ebx,4),%eax
 386:	89 04 24             	mov    %eax,(%esp)
 389:	e8 32 05 00 00       	call   8c0 <free>
    free(writer_stacks[j]);
 38e:	8b 44 9d c4          	mov    -0x3c(%ebp,%ebx,4),%eax
 392:	83 c3 01             	add    $0x1,%ebx
 395:	89 04 24             	mov    %eax,(%esp)
 398:	e8 23 05 00 00       	call   8c0 <free>
  
  printf(stderr, "Program finished in %d tick(s).\n", uptime() - start);
  if (!time_equal(uptime() - start, SLEEP_TIME * (N + 1)))
    handle_error("Did not finish in a correct time.");

  for (j = 0; j < N; j++) {
 39d:	83 fb 06             	cmp    $0x6,%ebx
 3a0:	75 e0                	jne    382 <main+0x292>
    free(reader_stacks[j]);
    free(writer_stacks[j]);
  }

  printf(stdout, "hw3-test-favorwriter succeeded\n");
 3a2:	a1 d0 0a 00 00       	mov    0xad0,%eax
 3a7:	c7 44 24 04 98 0a 00 	movl   $0xa98,0x4(%esp)
 3ae:	00 
 3af:	89 04 24             	mov    %eax,(%esp)
 3b2:	e8 89 03 00 00       	call   740 <printf>
 
  exit();
 3b7:	e8 0c 02 00 00       	call   5c8 <exit>
 3bc:	90                   	nop    
 3bd:	90                   	nop    
 3be:	90                   	nop    
 3bf:	90                   	nop    

000003c0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	53                   	push   %ebx
 3c4:	8b 5d 08             	mov    0x8(%ebp),%ebx
 3c7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 3ca:	89 da                	mov    %ebx,%edx
 3cc:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 3d0:	0f b6 01             	movzbl (%ecx),%eax
 3d3:	83 c1 01             	add    $0x1,%ecx
 3d6:	88 02                	mov    %al,(%edx)
 3d8:	83 c2 01             	add    $0x1,%edx
 3db:	84 c0                	test   %al,%al
 3dd:	75 f1                	jne    3d0 <strcpy+0x10>
    ;
  return os;
}
 3df:	89 d8                	mov    %ebx,%eax
 3e1:	5b                   	pop    %ebx
 3e2:	5d                   	pop    %ebp
 3e3:	c3                   	ret    
 3e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000003f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3f6:	53                   	push   %ebx
 3f7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 3fa:	0f b6 01             	movzbl (%ecx),%eax
 3fd:	84 c0                	test   %al,%al
 3ff:	74 24                	je     425 <strcmp+0x35>
 401:	0f b6 13             	movzbl (%ebx),%edx
 404:	38 d0                	cmp    %dl,%al
 406:	74 12                	je     41a <strcmp+0x2a>
 408:	eb 1e                	jmp    428 <strcmp+0x38>
 40a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 410:	0f b6 13             	movzbl (%ebx),%edx
 413:	83 c1 01             	add    $0x1,%ecx
 416:	38 d0                	cmp    %dl,%al
 418:	75 0e                	jne    428 <strcmp+0x38>
 41a:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 41e:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 421:	84 c0                	test   %al,%al
 423:	75 eb                	jne    410 <strcmp+0x20>
 425:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 428:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 429:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 42c:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 42d:	0f b6 d2             	movzbl %dl,%edx
 430:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 432:	c3                   	ret    
 433:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 439:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000440 <strlen>:

uint
strlen(char *s)
{
 440:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 441:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 443:	89 e5                	mov    %esp,%ebp
 445:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 448:	80 39 00             	cmpb   $0x0,(%ecx)
 44b:	74 0e                	je     45b <strlen+0x1b>
 44d:	31 d2                	xor    %edx,%edx
 44f:	90                   	nop    
 450:	83 c2 01             	add    $0x1,%edx
 453:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
 457:	89 d0                	mov    %edx,%eax
 459:	75 f5                	jne    450 <strlen+0x10>
    ;
  return n;
}
 45b:	5d                   	pop    %ebp
 45c:	c3                   	ret    
 45d:	8d 76 00             	lea    0x0(%esi),%esi

00000460 <memset>:

void*
memset(void *dst, int c, uint n)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	8b 55 08             	mov    0x8(%ebp),%edx
 466:	57                   	push   %edi
 467:	8b 45 0c             	mov    0xc(%ebp),%eax
 46a:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 46d:	89 d7                	mov    %edx,%edi
 46f:	fc                   	cld    
 470:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 472:	5f                   	pop    %edi
 473:	89 d0                	mov    %edx,%eax
 475:	5d                   	pop    %ebp
 476:	c3                   	ret    
 477:	89 f6                	mov    %esi,%esi
 479:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000480 <strchr>:

char*
strchr(const char *s, char c)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	8b 45 08             	mov    0x8(%ebp),%eax
 486:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 48a:	0f b6 10             	movzbl (%eax),%edx
 48d:	84 d2                	test   %dl,%dl
 48f:	75 0c                	jne    49d <strchr+0x1d>
 491:	eb 11                	jmp    4a4 <strchr+0x24>
 493:	83 c0 01             	add    $0x1,%eax
 496:	0f b6 10             	movzbl (%eax),%edx
 499:	84 d2                	test   %dl,%dl
 49b:	74 07                	je     4a4 <strchr+0x24>
    if(*s == c)
 49d:	38 ca                	cmp    %cl,%dl
 49f:	90                   	nop    
 4a0:	75 f1                	jne    493 <strchr+0x13>
      return (char*) s;
  return 0;
}
 4a2:	5d                   	pop    %ebp
 4a3:	c3                   	ret    
 4a4:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 4a5:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 4a7:	c3                   	ret    
 4a8:	90                   	nop    
 4a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000004b0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 4b6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4b7:	31 db                	xor    %ebx,%ebx
 4b9:	0f b6 11             	movzbl (%ecx),%edx
 4bc:	8d 42 d0             	lea    -0x30(%edx),%eax
 4bf:	3c 09                	cmp    $0x9,%al
 4c1:	77 18                	ja     4db <atoi+0x2b>
    n = n*10 + *s++ - '0';
 4c3:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 4c6:	0f be d2             	movsbl %dl,%edx
 4c9:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4cd:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 4d1:	83 c1 01             	add    $0x1,%ecx
 4d4:	8d 42 d0             	lea    -0x30(%edx),%eax
 4d7:	3c 09                	cmp    $0x9,%al
 4d9:	76 e8                	jbe    4c3 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 4db:	89 d8                	mov    %ebx,%eax
 4dd:	5b                   	pop    %ebx
 4de:	5d                   	pop    %ebp
 4df:	c3                   	ret    

000004e0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	8b 4d 10             	mov    0x10(%ebp),%ecx
 4e6:	56                   	push   %esi
 4e7:	8b 75 08             	mov    0x8(%ebp),%esi
 4ea:	53                   	push   %ebx
 4eb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4ee:	85 c9                	test   %ecx,%ecx
 4f0:	7e 10                	jle    502 <memmove+0x22>
 4f2:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 4f4:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 4f8:	88 04 32             	mov    %al,(%edx,%esi,1)
 4fb:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4fe:	39 ca                	cmp    %ecx,%edx
 500:	75 f2                	jne    4f4 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 502:	89 f0                	mov    %esi,%eax
 504:	5b                   	pop    %ebx
 505:	5e                   	pop    %esi
 506:	5d                   	pop    %ebp
 507:	c3                   	ret    
 508:	90                   	nop    
 509:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000510 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 516:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 519:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 51c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 51f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 524:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 52b:	00 
 52c:	89 04 24             	mov    %eax,(%esp)
 52f:	e8 d4 00 00 00       	call   608 <open>
  if(fd < 0)
 534:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 536:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 538:	78 19                	js     553 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 53a:	8b 45 0c             	mov    0xc(%ebp),%eax
 53d:	89 1c 24             	mov    %ebx,(%esp)
 540:	89 44 24 04          	mov    %eax,0x4(%esp)
 544:	e8 d7 00 00 00       	call   620 <fstat>
  close(fd);
 549:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 54c:	89 c6                	mov    %eax,%esi
  close(fd);
 54e:	e8 9d 00 00 00       	call   5f0 <close>
  return r;
}
 553:	89 f0                	mov    %esi,%eax
 555:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 558:	8b 75 fc             	mov    -0x4(%ebp),%esi
 55b:	89 ec                	mov    %ebp,%esp
 55d:	5d                   	pop    %ebp
 55e:	c3                   	ret    
 55f:	90                   	nop    

00000560 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	57                   	push   %edi
 564:	56                   	push   %esi
 565:	31 f6                	xor    %esi,%esi
 567:	53                   	push   %ebx
 568:	83 ec 1c             	sub    $0x1c,%esp
 56b:	8b 7d 08             	mov    0x8(%ebp),%edi
 56e:	eb 06                	jmp    576 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 570:	3c 0d                	cmp    $0xd,%al
 572:	74 39                	je     5ad <gets+0x4d>
 574:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 576:	8d 5e 01             	lea    0x1(%esi),%ebx
 579:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 57c:	7d 31                	jge    5af <gets+0x4f>
    cc = read(0, &c, 1);
 57e:	8d 45 f3             	lea    -0xd(%ebp),%eax
 581:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 588:	00 
 589:	89 44 24 04          	mov    %eax,0x4(%esp)
 58d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 594:	e8 47 00 00 00       	call   5e0 <read>
    if(cc < 1)
 599:	85 c0                	test   %eax,%eax
 59b:	7e 12                	jle    5af <gets+0x4f>
      break;
    buf[i++] = c;
 59d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 5a1:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 5a5:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 5a9:	3c 0a                	cmp    $0xa,%al
 5ab:	75 c3                	jne    570 <gets+0x10>
 5ad:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 5af:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 5b3:	89 f8                	mov    %edi,%eax
 5b5:	83 c4 1c             	add    $0x1c,%esp
 5b8:	5b                   	pop    %ebx
 5b9:	5e                   	pop    %esi
 5ba:	5f                   	pop    %edi
 5bb:	5d                   	pop    %ebp
 5bc:	c3                   	ret    
 5bd:	90                   	nop    
 5be:	90                   	nop    
 5bf:	90                   	nop    

000005c0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5c0:	b8 01 00 00 00       	mov    $0x1,%eax
 5c5:	cd 40                	int    $0x40
 5c7:	c3                   	ret    

000005c8 <exit>:
SYSCALL(exit)
 5c8:	b8 02 00 00 00       	mov    $0x2,%eax
 5cd:	cd 40                	int    $0x40
 5cf:	c3                   	ret    

000005d0 <wait>:
SYSCALL(wait)
 5d0:	b8 03 00 00 00       	mov    $0x3,%eax
 5d5:	cd 40                	int    $0x40
 5d7:	c3                   	ret    

000005d8 <pipe>:
SYSCALL(pipe)
 5d8:	b8 04 00 00 00       	mov    $0x4,%eax
 5dd:	cd 40                	int    $0x40
 5df:	c3                   	ret    

000005e0 <read>:
SYSCALL(read)
 5e0:	b8 06 00 00 00       	mov    $0x6,%eax
 5e5:	cd 40                	int    $0x40
 5e7:	c3                   	ret    

000005e8 <write>:
SYSCALL(write)
 5e8:	b8 05 00 00 00       	mov    $0x5,%eax
 5ed:	cd 40                	int    $0x40
 5ef:	c3                   	ret    

000005f0 <close>:
SYSCALL(close)
 5f0:	b8 07 00 00 00       	mov    $0x7,%eax
 5f5:	cd 40                	int    $0x40
 5f7:	c3                   	ret    

000005f8 <kill>:
SYSCALL(kill)
 5f8:	b8 08 00 00 00       	mov    $0x8,%eax
 5fd:	cd 40                	int    $0x40
 5ff:	c3                   	ret    

00000600 <exec>:
SYSCALL(exec)
 600:	b8 09 00 00 00       	mov    $0x9,%eax
 605:	cd 40                	int    $0x40
 607:	c3                   	ret    

00000608 <open>:
SYSCALL(open)
 608:	b8 0a 00 00 00       	mov    $0xa,%eax
 60d:	cd 40                	int    $0x40
 60f:	c3                   	ret    

00000610 <mknod>:
SYSCALL(mknod)
 610:	b8 0b 00 00 00       	mov    $0xb,%eax
 615:	cd 40                	int    $0x40
 617:	c3                   	ret    

00000618 <unlink>:
SYSCALL(unlink)
 618:	b8 0c 00 00 00       	mov    $0xc,%eax
 61d:	cd 40                	int    $0x40
 61f:	c3                   	ret    

00000620 <fstat>:
SYSCALL(fstat)
 620:	b8 0d 00 00 00       	mov    $0xd,%eax
 625:	cd 40                	int    $0x40
 627:	c3                   	ret    

00000628 <link>:
SYSCALL(link)
 628:	b8 0e 00 00 00       	mov    $0xe,%eax
 62d:	cd 40                	int    $0x40
 62f:	c3                   	ret    

00000630 <mkdir>:
SYSCALL(mkdir)
 630:	b8 0f 00 00 00       	mov    $0xf,%eax
 635:	cd 40                	int    $0x40
 637:	c3                   	ret    

00000638 <chdir>:
SYSCALL(chdir)
 638:	b8 10 00 00 00       	mov    $0x10,%eax
 63d:	cd 40                	int    $0x40
 63f:	c3                   	ret    

00000640 <dup>:
SYSCALL(dup)
 640:	b8 11 00 00 00       	mov    $0x11,%eax
 645:	cd 40                	int    $0x40
 647:	c3                   	ret    

00000648 <getpid>:
SYSCALL(getpid)
 648:	b8 12 00 00 00       	mov    $0x12,%eax
 64d:	cd 40                	int    $0x40
 64f:	c3                   	ret    

00000650 <sbrk>:
SYSCALL(sbrk)
 650:	b8 13 00 00 00       	mov    $0x13,%eax
 655:	cd 40                	int    $0x40
 657:	c3                   	ret    

00000658 <sleep>:
SYSCALL(sleep)
 658:	b8 14 00 00 00       	mov    $0x14,%eax
 65d:	cd 40                	int    $0x40
 65f:	c3                   	ret    

00000660 <uptime>:
SYSCALL(uptime)
 660:	b8 15 00 00 00       	mov    $0x15,%eax
 665:	cd 40                	int    $0x40
 667:	c3                   	ret    

00000668 <pschk>:
SYSCALL(pschk)
 668:	b8 17 00 00 00       	mov    $0x17,%eax
 66d:	cd 40                	int    $0x40
 66f:	c3                   	ret    

00000670 <rwlock>:
SYSCALL(rwlock)
 670:	b8 16 00 00 00       	mov    $0x16,%eax
 675:	cd 40                	int    $0x40
 677:	c3                   	ret    

00000678 <tfork>:
SYSCALL(tfork)
 678:	b8 18 00 00 00       	mov    $0x18,%eax
 67d:	cd 40                	int    $0x40
 67f:	c3                   	ret    

00000680 <texit>:
SYSCALL(texit)
 680:	b8 19 00 00 00       	mov    $0x19,%eax
 685:	cd 40                	int    $0x40
 687:	c3                   	ret    

00000688 <twait>:
SYSCALL(twait)
 688:	b8 1a 00 00 00       	mov    $0x1a,%eax
 68d:	cd 40                	int    $0x40
 68f:	c3                   	ret    

00000690 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	83 ec 18             	sub    $0x18,%esp
 696:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 699:	8d 55 fc             	lea    -0x4(%ebp),%edx
 69c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6a3:	00 
 6a4:	89 54 24 04          	mov    %edx,0x4(%esp)
 6a8:	89 04 24             	mov    %eax,(%esp)
 6ab:	e8 38 ff ff ff       	call   5e8 <write>
}
 6b0:	c9                   	leave  
 6b1:	c3                   	ret    
 6b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 6b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000006c0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	57                   	push   %edi
 6c4:	56                   	push   %esi
 6c5:	89 ce                	mov    %ecx,%esi
 6c7:	53                   	push   %ebx
 6c8:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6cb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 6ce:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6d1:	85 c9                	test   %ecx,%ecx
 6d3:	74 04                	je     6d9 <printint+0x19>
 6d5:	85 d2                	test   %edx,%edx
 6d7:	78 54                	js     72d <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6d9:	89 d0                	mov    %edx,%eax
 6db:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 6e2:	31 db                	xor    %ebx,%ebx
 6e4:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 6e7:	31 d2                	xor    %edx,%edx
 6e9:	f7 f6                	div    %esi
 6eb:	89 c1                	mov    %eax,%ecx
 6ed:	0f b6 82 bf 0a 00 00 	movzbl 0xabf(%edx),%eax
 6f4:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 6f7:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 6fa:	85 c9                	test   %ecx,%ecx
 6fc:	89 c8                	mov    %ecx,%eax
 6fe:	75 e7                	jne    6e7 <printint+0x27>
  if(neg)
 700:	8b 45 e0             	mov    -0x20(%ebp),%eax
 703:	85 c0                	test   %eax,%eax
 705:	74 08                	je     70f <printint+0x4f>
    buf[i++] = '-';
 707:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 70c:	83 c3 01             	add    $0x1,%ebx
 70f:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 712:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 716:	83 eb 01             	sub    $0x1,%ebx
 719:	8b 45 dc             	mov    -0x24(%ebp),%eax
 71c:	e8 6f ff ff ff       	call   690 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 721:	39 fb                	cmp    %edi,%ebx
 723:	75 ed                	jne    712 <printint+0x52>
    putc(fd, buf[i]);
}
 725:	83 c4 1c             	add    $0x1c,%esp
 728:	5b                   	pop    %ebx
 729:	5e                   	pop    %esi
 72a:	5f                   	pop    %edi
 72b:	5d                   	pop    %ebp
 72c:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 72d:	89 d0                	mov    %edx,%eax
 72f:	f7 d8                	neg    %eax
 731:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 738:	eb a8                	jmp    6e2 <printint+0x22>
 73a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000740 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	57                   	push   %edi
 744:	56                   	push   %esi
 745:	53                   	push   %ebx
 746:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 749:	8b 55 0c             	mov    0xc(%ebp),%edx
 74c:	0f b6 02             	movzbl (%edx),%eax
 74f:	84 c0                	test   %al,%al
 751:	0f 84 87 00 00 00    	je     7de <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 757:	8d 4d 10             	lea    0x10(%ebp),%ecx
 75a:	31 ff                	xor    %edi,%edi
 75c:	31 f6                	xor    %esi,%esi
 75e:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 761:	eb 18                	jmp    77b <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 763:	83 fb 25             	cmp    $0x25,%ebx
 766:	0f 85 7a 00 00 00    	jne    7e6 <printf+0xa6>
 76c:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 770:	83 c7 01             	add    $0x1,%edi
 773:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 777:	84 c0                	test   %al,%al
 779:	74 63                	je     7de <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 77b:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 77d:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 780:	74 e1                	je     763 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 782:	83 fe 25             	cmp    $0x25,%esi
 785:	75 e9                	jne    770 <printf+0x30>
      if(c == 'd'){
 787:	83 fb 64             	cmp    $0x64,%ebx
 78a:	0f 84 f0 00 00 00    	je     880 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 790:	83 fb 78             	cmp    $0x78,%ebx
 793:	74 64                	je     7f9 <printf+0xb9>
 795:	83 fb 70             	cmp    $0x70,%ebx
 798:	74 5f                	je     7f9 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 79a:	83 fb 73             	cmp    $0x73,%ebx
 79d:	8d 76 00             	lea    0x0(%esi),%esi
 7a0:	74 7e                	je     820 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7a2:	83 fb 63             	cmp    $0x63,%ebx
 7a5:	0f 84 b9 00 00 00    	je     864 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 7ab:	83 fb 25             	cmp    $0x25,%ebx
 7ae:	66 90                	xchg   %ax,%ax
 7b0:	0f 84 f2 00 00 00    	je     8a8 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7b6:	8b 45 08             	mov    0x8(%ebp),%eax
 7b9:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7be:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 7c1:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7c3:	e8 c8 fe ff ff       	call   690 <putc>
        putc(fd, c);
 7c8:	8b 45 08             	mov    0x8(%ebp),%eax
 7cb:	0f be d3             	movsbl %bl,%edx
 7ce:	e8 bd fe ff ff       	call   690 <putc>
 7d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7d6:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 7da:	84 c0                	test   %al,%al
 7dc:	75 9d                	jne    77b <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 7de:	83 c4 0c             	add    $0xc,%esp
 7e1:	5b                   	pop    %ebx
 7e2:	5e                   	pop    %esi
 7e3:	5f                   	pop    %edi
 7e4:	5d                   	pop    %ebp
 7e5:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 7e6:	8b 45 08             	mov    0x8(%ebp),%eax
 7e9:	0f be d3             	movsbl %bl,%edx
 7ec:	e8 9f fe ff ff       	call   690 <putc>
 7f1:	8b 55 0c             	mov    0xc(%ebp),%edx
 7f4:	e9 77 ff ff ff       	jmp    770 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 7f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7fc:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 801:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 803:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 80a:	8b 10                	mov    (%eax),%edx
 80c:	8b 45 08             	mov    0x8(%ebp),%eax
 80f:	e8 ac fe ff ff       	call   6c0 <printint>
 814:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 817:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 81b:	e9 50 ff ff ff       	jmp    770 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 820:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 823:	8b 01                	mov    (%ecx),%eax
        ap++;
 825:	83 c1 04             	add    $0x4,%ecx
 828:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 82b:	b9 b8 0a 00 00       	mov    $0xab8,%ecx
 830:	85 c0                	test   %eax,%eax
 832:	75 2c                	jne    860 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 834:	0f b6 01             	movzbl (%ecx),%eax
 837:	84 c0                	test   %al,%al
 839:	74 1e                	je     859 <printf+0x119>
 83b:	89 cb                	mov    %ecx,%ebx
 83d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 840:	0f be d0             	movsbl %al,%edx
 843:	8b 45 08             	mov    0x8(%ebp),%eax
 846:	e8 45 fe ff ff       	call   690 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 84b:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 84f:	83 c3 01             	add    $0x1,%ebx
 852:	84 c0                	test   %al,%al
 854:	75 ea                	jne    840 <printf+0x100>
 856:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 859:	31 f6                	xor    %esi,%esi
 85b:	e9 10 ff ff ff       	jmp    770 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 860:	89 c1                	mov    %eax,%ecx
 862:	eb d0                	jmp    834 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 864:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 867:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 869:	0f be 10             	movsbl (%eax),%edx
 86c:	8b 45 08             	mov    0x8(%ebp),%eax
 86f:	e8 1c fe ff ff       	call   690 <putc>
 874:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 877:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 87b:	e9 f0 fe ff ff       	jmp    770 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 880:	8b 45 f0             	mov    -0x10(%ebp),%eax
 883:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 888:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 88b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 892:	8b 10                	mov    (%eax),%edx
 894:	8b 45 08             	mov    0x8(%ebp),%eax
 897:	e8 24 fe ff ff       	call   6c0 <printint>
 89c:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 89f:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 8a3:	e9 c8 fe ff ff       	jmp    770 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 8a8:	8b 45 08             	mov    0x8(%ebp),%eax
 8ab:	ba 25 00 00 00       	mov    $0x25,%edx
 8b0:	31 f6                	xor    %esi,%esi
 8b2:	e8 d9 fd ff ff       	call   690 <putc>
 8b7:	8b 55 0c             	mov    0xc(%ebp),%edx
 8ba:	e9 b1 fe ff ff       	jmp    770 <printf+0x30>
 8bf:	90                   	nop    

000008c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8c1:	8b 0d e0 0a 00 00    	mov    0xae0,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 8c7:	89 e5                	mov    %esp,%ebp
 8c9:	56                   	push   %esi
 8ca:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 8cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 8ce:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d1:	39 d9                	cmp    %ebx,%ecx
 8d3:	73 18                	jae    8ed <free+0x2d>
 8d5:	8b 11                	mov    (%ecx),%edx
 8d7:	39 d3                	cmp    %edx,%ebx
 8d9:	72 17                	jb     8f2 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8db:	39 d1                	cmp    %edx,%ecx
 8dd:	72 08                	jb     8e7 <free+0x27>
 8df:	39 d9                	cmp    %ebx,%ecx
 8e1:	72 0f                	jb     8f2 <free+0x32>
 8e3:	39 d3                	cmp    %edx,%ebx
 8e5:	72 0b                	jb     8f2 <free+0x32>
 8e7:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8e9:	39 d9                	cmp    %ebx,%ecx
 8eb:	72 e8                	jb     8d5 <free+0x15>
 8ed:	8b 11                	mov    (%ecx),%edx
 8ef:	90                   	nop    
 8f0:	eb e9                	jmp    8db <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 8f2:	8b 73 04             	mov    0x4(%ebx),%esi
 8f5:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 8f8:	39 d0                	cmp    %edx,%eax
 8fa:	74 18                	je     914 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 8fc:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 8fe:	8b 51 04             	mov    0x4(%ecx),%edx
 901:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 904:	39 d8                	cmp    %ebx,%eax
 906:	74 20                	je     928 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 908:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 90a:	5b                   	pop    %ebx
 90b:	5e                   	pop    %esi
 90c:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 90d:	89 0d e0 0a 00 00    	mov    %ecx,0xae0
}
 913:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 914:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 917:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 919:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 91c:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 91f:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 921:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 924:	39 d8                	cmp    %ebx,%eax
 926:	75 e0                	jne    908 <free+0x48>
    p->s.size += bp->s.size;
 928:	03 53 04             	add    0x4(%ebx),%edx
 92b:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 92e:	8b 13                	mov    (%ebx),%edx
 930:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 932:	5b                   	pop    %ebx
 933:	5e                   	pop    %esi
 934:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 935:	89 0d e0 0a 00 00    	mov    %ecx,0xae0
}
 93b:	c3                   	ret    
 93c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000940 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 940:	55                   	push   %ebp
 941:	89 e5                	mov    %esp,%ebp
 943:	57                   	push   %edi
 944:	56                   	push   %esi
 945:	53                   	push   %ebx
 946:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 949:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 94c:	8b 15 e0 0a 00 00    	mov    0xae0,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 952:	83 c0 07             	add    $0x7,%eax
 955:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 958:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 95a:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 95d:	0f 84 8a 00 00 00    	je     9ed <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 963:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 965:	8b 41 04             	mov    0x4(%ecx),%eax
 968:	39 c3                	cmp    %eax,%ebx
 96a:	76 1a                	jbe    986 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 96c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 973:	3b 0d e0 0a 00 00    	cmp    0xae0,%ecx
 979:	89 ca                	mov    %ecx,%edx
 97b:	74 29                	je     9a6 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 97d:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 97f:	8b 41 04             	mov    0x4(%ecx),%eax
 982:	39 c3                	cmp    %eax,%ebx
 984:	77 ed                	ja     973 <malloc+0x33>
      if(p->s.size == nunits)
 986:	39 c3                	cmp    %eax,%ebx
 988:	74 5d                	je     9e7 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 98a:	29 d8                	sub    %ebx,%eax
 98c:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 98f:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 992:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 995:	89 15 e0 0a 00 00    	mov    %edx,0xae0
      return (void*) (p + 1);
 99b:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 99e:	83 c4 0c             	add    $0xc,%esp
 9a1:	5b                   	pop    %ebx
 9a2:	5e                   	pop    %esi
 9a3:	5f                   	pop    %edi
 9a4:	5d                   	pop    %ebp
 9a5:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 9a6:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 9ac:	89 de                	mov    %ebx,%esi
 9ae:	89 f8                	mov    %edi,%eax
 9b0:	76 29                	jbe    9db <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 9b2:	89 04 24             	mov    %eax,(%esp)
 9b5:	e8 96 fc ff ff       	call   650 <sbrk>
  if(p == (char*) -1)
 9ba:	83 f8 ff             	cmp    $0xffffffff,%eax
 9bd:	74 18                	je     9d7 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 9bf:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 9c2:	83 c0 08             	add    $0x8,%eax
 9c5:	89 04 24             	mov    %eax,(%esp)
 9c8:	e8 f3 fe ff ff       	call   8c0 <free>
  return freep;
 9cd:	8b 15 e0 0a 00 00    	mov    0xae0,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 9d3:	85 d2                	test   %edx,%edx
 9d5:	75 a6                	jne    97d <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 9d7:	31 c0                	xor    %eax,%eax
 9d9:	eb c3                	jmp    99e <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 9db:	be 00 10 00 00       	mov    $0x1000,%esi
 9e0:	b8 00 80 00 00       	mov    $0x8000,%eax
 9e5:	eb cb                	jmp    9b2 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 9e7:	8b 01                	mov    (%ecx),%eax
 9e9:	89 02                	mov    %eax,(%edx)
 9eb:	eb a8                	jmp    995 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 9ed:	ba d8 0a 00 00       	mov    $0xad8,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 9f2:	c7 05 e0 0a 00 00 d8 	movl   $0xad8,0xae0
 9f9:	0a 00 00 
 9fc:	c7 05 d8 0a 00 00 d8 	movl   $0xad8,0xad8
 a03:	0a 00 00 
    base.s.size = 0;
 a06:	c7 05 dc 0a 00 00 00 	movl   $0x0,0xadc
 a0d:	00 00 00 
 a10:	e9 4e ff ff ff       	jmp    963 <malloc+0x23>
