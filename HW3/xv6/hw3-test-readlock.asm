
_hw3-test-readlock:     file format elf32-i386

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
  49:	c7 44 24 04 98 08 00 	movl   $0x898,0x4(%esp)
  50:	00 
  51:	89 44 24 08          	mov    %eax,0x8(%esp)
  55:	a1 40 09 00 00       	mov    0x940,%eax
  5a:	89 04 24             	mov    %eax,(%esp)
  5d:	e8 5e 05 00 00       	call   5c0 <printf>
  exit();
  62:	e8 e1 03 00 00       	call   448 <exit>
  67:	89 f6                	mov    %esi,%esi
  69:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000070 <child_main>:
#include "hw3-common.h"

#define N_THREADS (10)
#define STACK_SIZE (4096)

void child_main(void *arg) {
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	53                   	push   %ebx
  74:	83 ec 14             	sub    $0x14,%esp
  77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct rwlock *m = arg;
  rwlock(m, OP_READLOCK);
  7a:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  81:	00 
  82:	89 1c 24             	mov    %ebx,(%esp)
  85:	e8 66 04 00 00       	call   4f0 <rwlock>
  sleep(ONE_SEC);
  8a:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
  91:	e8 42 04 00 00       	call   4d8 <sleep>
  rwlock(m, OP_READUNLOCK);
  96:	89 1c 24             	mov    %ebx,(%esp)
  99:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  a0:	00 
  a1:	e8 4a 04 00 00       	call   4f0 <rwlock>
  texit();
}
  a6:	83 c4 14             	add    $0x14,%esp
  a9:	5b                   	pop    %ebx
  aa:	5d                   	pop    %ebp
void child_main(void *arg) {
  struct rwlock *m = arg;
  rwlock(m, OP_READLOCK);
  sleep(ONE_SEC);
  rwlock(m, OP_READUNLOCK);
  texit();
  ab:	e9 50 04 00 00       	jmp    500 <texit>

000000b0 <main>:
}

int main() {
  b0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  b4:	83 e4 f0             	and    $0xfffffff0,%esp
  b7:	ff 71 fc             	pushl  -0x4(%ecx)
  ba:	55                   	push   %ebp
  bb:	89 e5                	mov    %esp,%ebp
  bd:	57                   	push   %edi
  be:	56                   	push   %esi
  bf:	53                   	push   %ebx
  int children[N_THREADS];
  char *stacks[N_THREADS];
  int start = uptime();

  for (i = 0; i < N_THREADS; i++)
    stacks[i] = malloc(STACK_SIZE);
  c0:	bb 02 00 00 00       	mov    $0x2,%ebx
  sleep(ONE_SEC);
  rwlock(m, OP_READUNLOCK);
  texit();
}

int main() {
  c5:	51                   	push   %ecx
  c6:	83 ec 68             	sub    $0x68,%esp
  
  struct rwlock m;
  int i;
  int children[N_THREADS];
  char *stacks[N_THREADS];
  int start = uptime();
  c9:	e8 12 04 00 00       	call   4e0 <uptime>

  for (i = 0; i < N_THREADS; i++)
    stacks[i] = malloc(STACK_SIZE);
  ce:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  
  struct rwlock m;
  int i;
  int children[N_THREADS];
  char *stacks[N_THREADS];
  int start = uptime();
  d5:	89 45 9c             	mov    %eax,-0x64(%ebp)

  for (i = 0; i < N_THREADS; i++)
    stacks[i] = malloc(STACK_SIZE);
  d8:	e8 e3 06 00 00       	call   7c0 <malloc>
  dd:	89 45 a0             	mov    %eax,-0x60(%ebp)
  e0:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  e7:	e8 d4 06 00 00       	call   7c0 <malloc>
  ec:	89 44 9d 9c          	mov    %eax,-0x64(%ebp,%ebx,4)
  f0:	83 c3 01             	add    $0x1,%ebx
  int i;
  int children[N_THREADS];
  char *stacks[N_THREADS];
  int start = uptime();

  for (i = 0; i < N_THREADS; i++)
  f3:	83 fb 0b             	cmp    $0xb,%ebx
  f6:	75 e8                	jne    e0 <main+0x30>
    stacks[i] = malloc(STACK_SIZE);

  rwlock(&m, OP_INIT);
  f8:	8d 45 f0             	lea    -0x10(%ebp),%eax
  fb:	b3 01                	mov    $0x1,%bl
  fd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 104:	00 

  for (i = 0; i < N_THREADS; i++) {
    children[i] = tfork(child_main, &m, stacks[i] + STACK_SIZE);
 105:	8d 7d c8             	lea    -0x38(%ebp),%edi
  int start = uptime();

  for (i = 0; i < N_THREADS; i++)
    stacks[i] = malloc(STACK_SIZE);

  rwlock(&m, OP_INIT);
 108:	89 04 24             	mov    %eax,(%esp)
 10b:	e8 e0 03 00 00       	call   4f0 <rwlock>

  for (i = 0; i < N_THREADS; i++) {
    children[i] = tfork(child_main, &m, stacks[i] + STACK_SIZE);
 110:	8b 44 9d 9c          	mov    -0x64(%ebp,%ebx,4),%eax
 114:	8d 4d f0             	lea    -0x10(%ebp),%ecx
 117:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 11b:	c7 04 24 70 00 00 00 	movl   $0x70,(%esp)
 122:	05 00 10 00 00       	add    $0x1000,%eax
 127:	89 44 24 08          	mov    %eax,0x8(%esp)
 12b:	e8 c8 03 00 00       	call   4f8 <tfork>
    if (children[i] < 0)
 130:	85 c0                	test   %eax,%eax
 132:	0f 88 ab 00 00 00    	js     1e3 <main+0x133>
    stacks[i] = malloc(STACK_SIZE);

  rwlock(&m, OP_INIT);

  for (i = 0; i < N_THREADS; i++) {
    children[i] = tfork(child_main, &m, stacks[i] + STACK_SIZE);
 138:	89 44 9f fc          	mov    %eax,-0x4(%edi,%ebx,4)
 13c:	83 c3 01             	add    $0x1,%ebx
 13f:	89 fe                	mov    %edi,%esi
  for (i = 0; i < N_THREADS; i++)
    stacks[i] = malloc(STACK_SIZE);

  rwlock(&m, OP_INIT);

  for (i = 0; i < N_THREADS; i++) {
 141:	83 fb 0b             	cmp    $0xb,%ebx
 144:	75 ca                	jne    110 <main+0x60>
 146:	30 db                	xor    %bl,%bl
    if (children[i] < 0)
      handle_error("error on tfork()");
  }

  for (i = 0; i < N_THREADS; i++) {
    if (twait(children[i]) < 0)
 148:	8b 04 9e             	mov    (%esi,%ebx,4),%eax
 14b:	89 04 24             	mov    %eax,(%esp)
 14e:	e8 b5 03 00 00       	call   508 <twait>
 153:	85 c0                	test   %eax,%eax
 155:	0f 88 92 00 00 00    	js     1ed <main+0x13d>
    children[i] = tfork(child_main, &m, stacks[i] + STACK_SIZE);
    if (children[i] < 0)
      handle_error("error on tfork()");
  }

  for (i = 0; i < N_THREADS; i++) {
 15b:	83 c3 01             	add    $0x1,%ebx
 15e:	83 fb 0a             	cmp    $0xa,%ebx
 161:	75 e5                	jne    148 <main+0x98>
    if (twait(children[i]) < 0)
      handle_error("error on twait()");
  }

  rwlock(&m, OP_DESTROY);
 163:	8d 45 f0             	lea    -0x10(%ebp),%eax
 166:	c7 44 24 04 05 00 00 	movl   $0x5,0x4(%esp)
 16d:	00 
 16e:	89 04 24             	mov    %eax,(%esp)
 171:	e8 7a 03 00 00       	call   4f0 <rwlock>

  printf(stderr, "Program finished in %d tick(s).\n", uptime() - start);
 176:	e8 65 03 00 00       	call   4e0 <uptime>
 17b:	c7 44 24 04 dc 08 00 	movl   $0x8dc,0x4(%esp)
 182:	00 
 183:	2b 45 9c             	sub    -0x64(%ebp),%eax
 186:	89 44 24 08          	mov    %eax,0x8(%esp)
 18a:	a1 40 09 00 00       	mov    0x940,%eax
 18f:	89 04 24             	mov    %eax,(%esp)
 192:	e8 29 04 00 00       	call   5c0 <printf>
  if (!time_equal(uptime() - start, ONE_SEC))
 197:	e8 44 03 00 00       	call   4e0 <uptime>
int stdout = 1;
int stderr = 2;

// Return true if <a> and <b> differ in at most 5%. 
inline int time_equal(int a, int b) {
  if (a < 0 || b < 0)
 19c:	2b 45 9c             	sub    -0x64(%ebp),%eax
 19f:	78 17                	js     1b8 <main+0x108>
    return 0;
  if (a > b) {
 1a1:	83 f8 64             	cmp    $0x64,%eax
 1a4:	ba 64 00 00 00       	mov    $0x64,%edx
 1a9:	7f 2f                	jg     1da <main+0x12a>
 1ab:	89 d1                	mov    %edx,%ecx
 1ad:	29 c1                	sub    %eax,%ecx
 1af:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
 1b2:	01 c0                	add    %eax,%eax
 1b4:	39 c2                	cmp    %eax,%edx
 1b6:	7d 3f                	jge    1f7 <main+0x147>
  }
  return 10 * (b - a) <= b;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 1b8:	c7 44 24 08 00 09 00 	movl   $0x900,0x8(%esp)
 1bf:	00 
  exit();
 1c0:	a1 40 09 00 00       	mov    0x940,%eax
 1c5:	c7 44 24 04 98 08 00 	movl   $0x898,0x4(%esp)
 1cc:	00 
 1cd:	89 04 24             	mov    %eax,(%esp)
 1d0:	e8 eb 03 00 00       	call   5c0 <printf>
 1d5:	e8 6e 02 00 00       	call   448 <exit>

// Return true if <a> and <b> differ in at most 5%. 
inline int time_equal(int a, int b) {
  if (a < 0 || b < 0)
    return 0;
  if (a > b) {
 1da:	89 c2                	mov    %eax,%edx
 1dc:	b8 64 00 00 00       	mov    $0x64,%eax
 1e1:	eb c8                	jmp    1ab <main+0xfb>
  }
  return 10 * (b - a) <= b;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 1e3:	c7 44 24 08 9c 08 00 	movl   $0x89c,0x8(%esp)
 1ea:	00 
 1eb:	eb d3                	jmp    1c0 <main+0x110>
 1ed:	c7 44 24 08 ad 08 00 	movl   $0x8ad,0x8(%esp)
 1f4:	00 
 1f5:	eb c9                	jmp    1c0 <main+0x110>
    handle_error("Did not finish in a correct time.");

  for (i = 0; i < N_THREADS; i++)
    free(stacks[i]);
 1f7:	8b 45 a0             	mov    -0x60(%ebp),%eax
 1fa:	bb 02 00 00 00       	mov    $0x2,%ebx
 1ff:	89 04 24             	mov    %eax,(%esp)
 202:	e8 39 05 00 00       	call   740 <free>
 207:	8b 44 9d 9c          	mov    -0x64(%ebp,%ebx,4),%eax
 20b:	83 c3 01             	add    $0x1,%ebx
 20e:	89 04 24             	mov    %eax,(%esp)
 211:	e8 2a 05 00 00       	call   740 <free>

  printf(stderr, "Program finished in %d tick(s).\n", uptime() - start);
  if (!time_equal(uptime() - start, ONE_SEC))
    handle_error("Did not finish in a correct time.");

  for (i = 0; i < N_THREADS; i++)
 216:	83 fb 0b             	cmp    $0xb,%ebx
 219:	75 ec                	jne    207 <main+0x157>
    free(stacks[i]);

  printf(stdout, "hw3-test-readlock succeeded\n");
 21b:	a1 3c 09 00 00       	mov    0x93c,%eax
 220:	c7 44 24 04 be 08 00 	movl   $0x8be,0x4(%esp)
 227:	00 
 228:	89 04 24             	mov    %eax,(%esp)
 22b:	e8 90 03 00 00       	call   5c0 <printf>
  
  exit();
 230:	e8 13 02 00 00       	call   448 <exit>
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

00000240 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	53                   	push   %ebx
 244:	8b 5d 08             	mov    0x8(%ebp),%ebx
 247:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 24a:	89 da                	mov    %ebx,%edx
 24c:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 250:	0f b6 01             	movzbl (%ecx),%eax
 253:	83 c1 01             	add    $0x1,%ecx
 256:	88 02                	mov    %al,(%edx)
 258:	83 c2 01             	add    $0x1,%edx
 25b:	84 c0                	test   %al,%al
 25d:	75 f1                	jne    250 <strcpy+0x10>
    ;
  return os;
}
 25f:	89 d8                	mov    %ebx,%eax
 261:	5b                   	pop    %ebx
 262:	5d                   	pop    %ebp
 263:	c3                   	ret    
 264:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 26a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000270 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	8b 4d 08             	mov    0x8(%ebp),%ecx
 276:	53                   	push   %ebx
 277:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 27a:	0f b6 01             	movzbl (%ecx),%eax
 27d:	84 c0                	test   %al,%al
 27f:	74 24                	je     2a5 <strcmp+0x35>
 281:	0f b6 13             	movzbl (%ebx),%edx
 284:	38 d0                	cmp    %dl,%al
 286:	74 12                	je     29a <strcmp+0x2a>
 288:	eb 1e                	jmp    2a8 <strcmp+0x38>
 28a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 290:	0f b6 13             	movzbl (%ebx),%edx
 293:	83 c1 01             	add    $0x1,%ecx
 296:	38 d0                	cmp    %dl,%al
 298:	75 0e                	jne    2a8 <strcmp+0x38>
 29a:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 29e:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2a1:	84 c0                	test   %al,%al
 2a3:	75 eb                	jne    290 <strcmp+0x20>
 2a5:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 2a8:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2a9:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 2ac:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2ad:	0f b6 d2             	movzbl %dl,%edx
 2b0:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 2b2:	c3                   	ret    
 2b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000002c0 <strlen>:

uint
strlen(char *s)
{
 2c0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 2c1:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 2c3:	89 e5                	mov    %esp,%ebp
 2c5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 2c8:	80 39 00             	cmpb   $0x0,(%ecx)
 2cb:	74 0e                	je     2db <strlen+0x1b>
 2cd:	31 d2                	xor    %edx,%edx
 2cf:	90                   	nop    
 2d0:	83 c2 01             	add    $0x1,%edx
 2d3:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
 2d7:	89 d0                	mov    %edx,%eax
 2d9:	75 f5                	jne    2d0 <strlen+0x10>
    ;
  return n;
}
 2db:	5d                   	pop    %ebp
 2dc:	c3                   	ret    
 2dd:	8d 76 00             	lea    0x0(%esi),%esi

000002e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	8b 55 08             	mov    0x8(%ebp),%edx
 2e6:	57                   	push   %edi
 2e7:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ea:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 2ed:	89 d7                	mov    %edx,%edi
 2ef:	fc                   	cld    
 2f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 2f2:	5f                   	pop    %edi
 2f3:	89 d0                	mov    %edx,%eax
 2f5:	5d                   	pop    %ebp
 2f6:	c3                   	ret    
 2f7:	89 f6                	mov    %esi,%esi
 2f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000300 <strchr>:

char*
strchr(const char *s, char c)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	8b 45 08             	mov    0x8(%ebp),%eax
 306:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 30a:	0f b6 10             	movzbl (%eax),%edx
 30d:	84 d2                	test   %dl,%dl
 30f:	75 0c                	jne    31d <strchr+0x1d>
 311:	eb 11                	jmp    324 <strchr+0x24>
 313:	83 c0 01             	add    $0x1,%eax
 316:	0f b6 10             	movzbl (%eax),%edx
 319:	84 d2                	test   %dl,%dl
 31b:	74 07                	je     324 <strchr+0x24>
    if(*s == c)
 31d:	38 ca                	cmp    %cl,%dl
 31f:	90                   	nop    
 320:	75 f1                	jne    313 <strchr+0x13>
      return (char*) s;
  return 0;
}
 322:	5d                   	pop    %ebp
 323:	c3                   	ret    
 324:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 325:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 327:	c3                   	ret    
 328:	90                   	nop    
 329:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000330 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	8b 4d 08             	mov    0x8(%ebp),%ecx
 336:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 337:	31 db                	xor    %ebx,%ebx
 339:	0f b6 11             	movzbl (%ecx),%edx
 33c:	8d 42 d0             	lea    -0x30(%edx),%eax
 33f:	3c 09                	cmp    $0x9,%al
 341:	77 18                	ja     35b <atoi+0x2b>
    n = n*10 + *s++ - '0';
 343:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 346:	0f be d2             	movsbl %dl,%edx
 349:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 34d:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 351:	83 c1 01             	add    $0x1,%ecx
 354:	8d 42 d0             	lea    -0x30(%edx),%eax
 357:	3c 09                	cmp    $0x9,%al
 359:	76 e8                	jbe    343 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 35b:	89 d8                	mov    %ebx,%eax
 35d:	5b                   	pop    %ebx
 35e:	5d                   	pop    %ebp
 35f:	c3                   	ret    

00000360 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	8b 4d 10             	mov    0x10(%ebp),%ecx
 366:	56                   	push   %esi
 367:	8b 75 08             	mov    0x8(%ebp),%esi
 36a:	53                   	push   %ebx
 36b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 36e:	85 c9                	test   %ecx,%ecx
 370:	7e 10                	jle    382 <memmove+0x22>
 372:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 374:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 378:	88 04 32             	mov    %al,(%edx,%esi,1)
 37b:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 37e:	39 ca                	cmp    %ecx,%edx
 380:	75 f2                	jne    374 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 382:	89 f0                	mov    %esi,%eax
 384:	5b                   	pop    %ebx
 385:	5e                   	pop    %esi
 386:	5d                   	pop    %ebp
 387:	c3                   	ret    
 388:	90                   	nop    
 389:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000390 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 396:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 399:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 39c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 39f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3a4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 3ab:	00 
 3ac:	89 04 24             	mov    %eax,(%esp)
 3af:	e8 d4 00 00 00       	call   488 <open>
  if(fd < 0)
 3b4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3b6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 3b8:	78 19                	js     3d3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 3ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 3bd:	89 1c 24             	mov    %ebx,(%esp)
 3c0:	89 44 24 04          	mov    %eax,0x4(%esp)
 3c4:	e8 d7 00 00 00       	call   4a0 <fstat>
  close(fd);
 3c9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 3cc:	89 c6                	mov    %eax,%esi
  close(fd);
 3ce:	e8 9d 00 00 00       	call   470 <close>
  return r;
}
 3d3:	89 f0                	mov    %esi,%eax
 3d5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 3d8:	8b 75 fc             	mov    -0x4(%ebp),%esi
 3db:	89 ec                	mov    %ebp,%esp
 3dd:	5d                   	pop    %ebp
 3de:	c3                   	ret    
 3df:	90                   	nop    

000003e0 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	56                   	push   %esi
 3e5:	31 f6                	xor    %esi,%esi
 3e7:	53                   	push   %ebx
 3e8:	83 ec 1c             	sub    $0x1c,%esp
 3eb:	8b 7d 08             	mov    0x8(%ebp),%edi
 3ee:	eb 06                	jmp    3f6 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3f0:	3c 0d                	cmp    $0xd,%al
 3f2:	74 39                	je     42d <gets+0x4d>
 3f4:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3f6:	8d 5e 01             	lea    0x1(%esi),%ebx
 3f9:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3fc:	7d 31                	jge    42f <gets+0x4f>
    cc = read(0, &c, 1);
 3fe:	8d 45 f3             	lea    -0xd(%ebp),%eax
 401:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 408:	00 
 409:	89 44 24 04          	mov    %eax,0x4(%esp)
 40d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 414:	e8 47 00 00 00       	call   460 <read>
    if(cc < 1)
 419:	85 c0                	test   %eax,%eax
 41b:	7e 12                	jle    42f <gets+0x4f>
      break;
    buf[i++] = c;
 41d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 421:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 425:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 429:	3c 0a                	cmp    $0xa,%al
 42b:	75 c3                	jne    3f0 <gets+0x10>
 42d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 42f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 433:	89 f8                	mov    %edi,%eax
 435:	83 c4 1c             	add    $0x1c,%esp
 438:	5b                   	pop    %ebx
 439:	5e                   	pop    %esi
 43a:	5f                   	pop    %edi
 43b:	5d                   	pop    %ebp
 43c:	c3                   	ret    
 43d:	90                   	nop    
 43e:	90                   	nop    
 43f:	90                   	nop    

00000440 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 440:	b8 01 00 00 00       	mov    $0x1,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <exit>:
SYSCALL(exit)
 448:	b8 02 00 00 00       	mov    $0x2,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <wait>:
SYSCALL(wait)
 450:	b8 03 00 00 00       	mov    $0x3,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    

00000458 <pipe>:
SYSCALL(pipe)
 458:	b8 04 00 00 00       	mov    $0x4,%eax
 45d:	cd 40                	int    $0x40
 45f:	c3                   	ret    

00000460 <read>:
SYSCALL(read)
 460:	b8 06 00 00 00       	mov    $0x6,%eax
 465:	cd 40                	int    $0x40
 467:	c3                   	ret    

00000468 <write>:
SYSCALL(write)
 468:	b8 05 00 00 00       	mov    $0x5,%eax
 46d:	cd 40                	int    $0x40
 46f:	c3                   	ret    

00000470 <close>:
SYSCALL(close)
 470:	b8 07 00 00 00       	mov    $0x7,%eax
 475:	cd 40                	int    $0x40
 477:	c3                   	ret    

00000478 <kill>:
SYSCALL(kill)
 478:	b8 08 00 00 00       	mov    $0x8,%eax
 47d:	cd 40                	int    $0x40
 47f:	c3                   	ret    

00000480 <exec>:
SYSCALL(exec)
 480:	b8 09 00 00 00       	mov    $0x9,%eax
 485:	cd 40                	int    $0x40
 487:	c3                   	ret    

00000488 <open>:
SYSCALL(open)
 488:	b8 0a 00 00 00       	mov    $0xa,%eax
 48d:	cd 40                	int    $0x40
 48f:	c3                   	ret    

00000490 <mknod>:
SYSCALL(mknod)
 490:	b8 0b 00 00 00       	mov    $0xb,%eax
 495:	cd 40                	int    $0x40
 497:	c3                   	ret    

00000498 <unlink>:
SYSCALL(unlink)
 498:	b8 0c 00 00 00       	mov    $0xc,%eax
 49d:	cd 40                	int    $0x40
 49f:	c3                   	ret    

000004a0 <fstat>:
SYSCALL(fstat)
 4a0:	b8 0d 00 00 00       	mov    $0xd,%eax
 4a5:	cd 40                	int    $0x40
 4a7:	c3                   	ret    

000004a8 <link>:
SYSCALL(link)
 4a8:	b8 0e 00 00 00       	mov    $0xe,%eax
 4ad:	cd 40                	int    $0x40
 4af:	c3                   	ret    

000004b0 <mkdir>:
SYSCALL(mkdir)
 4b0:	b8 0f 00 00 00       	mov    $0xf,%eax
 4b5:	cd 40                	int    $0x40
 4b7:	c3                   	ret    

000004b8 <chdir>:
SYSCALL(chdir)
 4b8:	b8 10 00 00 00       	mov    $0x10,%eax
 4bd:	cd 40                	int    $0x40
 4bf:	c3                   	ret    

000004c0 <dup>:
SYSCALL(dup)
 4c0:	b8 11 00 00 00       	mov    $0x11,%eax
 4c5:	cd 40                	int    $0x40
 4c7:	c3                   	ret    

000004c8 <getpid>:
SYSCALL(getpid)
 4c8:	b8 12 00 00 00       	mov    $0x12,%eax
 4cd:	cd 40                	int    $0x40
 4cf:	c3                   	ret    

000004d0 <sbrk>:
SYSCALL(sbrk)
 4d0:	b8 13 00 00 00       	mov    $0x13,%eax
 4d5:	cd 40                	int    $0x40
 4d7:	c3                   	ret    

000004d8 <sleep>:
SYSCALL(sleep)
 4d8:	b8 14 00 00 00       	mov    $0x14,%eax
 4dd:	cd 40                	int    $0x40
 4df:	c3                   	ret    

000004e0 <uptime>:
SYSCALL(uptime)
 4e0:	b8 15 00 00 00       	mov    $0x15,%eax
 4e5:	cd 40                	int    $0x40
 4e7:	c3                   	ret    

000004e8 <pschk>:
SYSCALL(pschk)
 4e8:	b8 17 00 00 00       	mov    $0x17,%eax
 4ed:	cd 40                	int    $0x40
 4ef:	c3                   	ret    

000004f0 <rwlock>:
SYSCALL(rwlock)
 4f0:	b8 16 00 00 00       	mov    $0x16,%eax
 4f5:	cd 40                	int    $0x40
 4f7:	c3                   	ret    

000004f8 <tfork>:
SYSCALL(tfork)
 4f8:	b8 18 00 00 00       	mov    $0x18,%eax
 4fd:	cd 40                	int    $0x40
 4ff:	c3                   	ret    

00000500 <texit>:
SYSCALL(texit)
 500:	b8 19 00 00 00       	mov    $0x19,%eax
 505:	cd 40                	int    $0x40
 507:	c3                   	ret    

00000508 <twait>:
SYSCALL(twait)
 508:	b8 1a 00 00 00       	mov    $0x1a,%eax
 50d:	cd 40                	int    $0x40
 50f:	c3                   	ret    

00000510 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	83 ec 18             	sub    $0x18,%esp
 516:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 519:	8d 55 fc             	lea    -0x4(%ebp),%edx
 51c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 523:	00 
 524:	89 54 24 04          	mov    %edx,0x4(%esp)
 528:	89 04 24             	mov    %eax,(%esp)
 52b:	e8 38 ff ff ff       	call   468 <write>
}
 530:	c9                   	leave  
 531:	c3                   	ret    
 532:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 539:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000540 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	57                   	push   %edi
 544:	56                   	push   %esi
 545:	89 ce                	mov    %ecx,%esi
 547:	53                   	push   %ebx
 548:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 54b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 54e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 551:	85 c9                	test   %ecx,%ecx
 553:	74 04                	je     559 <printint+0x19>
 555:	85 d2                	test   %edx,%edx
 557:	78 54                	js     5ad <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 559:	89 d0                	mov    %edx,%eax
 55b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 562:	31 db                	xor    %ebx,%ebx
 564:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 567:	31 d2                	xor    %edx,%edx
 569:	f7 f6                	div    %esi
 56b:	89 c1                	mov    %eax,%ecx
 56d:	0f b6 82 2b 09 00 00 	movzbl 0x92b(%edx),%eax
 574:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 577:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 57a:	85 c9                	test   %ecx,%ecx
 57c:	89 c8                	mov    %ecx,%eax
 57e:	75 e7                	jne    567 <printint+0x27>
  if(neg)
 580:	8b 45 e0             	mov    -0x20(%ebp),%eax
 583:	85 c0                	test   %eax,%eax
 585:	74 08                	je     58f <printint+0x4f>
    buf[i++] = '-';
 587:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 58c:	83 c3 01             	add    $0x1,%ebx
 58f:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 592:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 596:	83 eb 01             	sub    $0x1,%ebx
 599:	8b 45 dc             	mov    -0x24(%ebp),%eax
 59c:	e8 6f ff ff ff       	call   510 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 5a1:	39 fb                	cmp    %edi,%ebx
 5a3:	75 ed                	jne    592 <printint+0x52>
    putc(fd, buf[i]);
}
 5a5:	83 c4 1c             	add    $0x1c,%esp
 5a8:	5b                   	pop    %ebx
 5a9:	5e                   	pop    %esi
 5aa:	5f                   	pop    %edi
 5ab:	5d                   	pop    %ebp
 5ac:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 5ad:	89 d0                	mov    %edx,%eax
 5af:	f7 d8                	neg    %eax
 5b1:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 5b8:	eb a8                	jmp    562 <printint+0x22>
 5ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000005c0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	57                   	push   %edi
 5c4:	56                   	push   %esi
 5c5:	53                   	push   %ebx
 5c6:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5c9:	8b 55 0c             	mov    0xc(%ebp),%edx
 5cc:	0f b6 02             	movzbl (%edx),%eax
 5cf:	84 c0                	test   %al,%al
 5d1:	0f 84 87 00 00 00    	je     65e <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 5d7:	8d 4d 10             	lea    0x10(%ebp),%ecx
 5da:	31 ff                	xor    %edi,%edi
 5dc:	31 f6                	xor    %esi,%esi
 5de:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 5e1:	eb 18                	jmp    5fb <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5e3:	83 fb 25             	cmp    $0x25,%ebx
 5e6:	0f 85 7a 00 00 00    	jne    666 <printf+0xa6>
 5ec:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5f0:	83 c7 01             	add    $0x1,%edi
 5f3:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 5f7:	84 c0                	test   %al,%al
 5f9:	74 63                	je     65e <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 5fb:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 5fd:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 600:	74 e1                	je     5e3 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 602:	83 fe 25             	cmp    $0x25,%esi
 605:	75 e9                	jne    5f0 <printf+0x30>
      if(c == 'd'){
 607:	83 fb 64             	cmp    $0x64,%ebx
 60a:	0f 84 f0 00 00 00    	je     700 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 610:	83 fb 78             	cmp    $0x78,%ebx
 613:	74 64                	je     679 <printf+0xb9>
 615:	83 fb 70             	cmp    $0x70,%ebx
 618:	74 5f                	je     679 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 61a:	83 fb 73             	cmp    $0x73,%ebx
 61d:	8d 76 00             	lea    0x0(%esi),%esi
 620:	74 7e                	je     6a0 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 622:	83 fb 63             	cmp    $0x63,%ebx
 625:	0f 84 b9 00 00 00    	je     6e4 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 62b:	83 fb 25             	cmp    $0x25,%ebx
 62e:	66 90                	xchg   %ax,%ax
 630:	0f 84 f2 00 00 00    	je     728 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 636:	8b 45 08             	mov    0x8(%ebp),%eax
 639:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 63e:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 641:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 643:	e8 c8 fe ff ff       	call   510 <putc>
        putc(fd, c);
 648:	8b 45 08             	mov    0x8(%ebp),%eax
 64b:	0f be d3             	movsbl %bl,%edx
 64e:	e8 bd fe ff ff       	call   510 <putc>
 653:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 656:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 65a:	84 c0                	test   %al,%al
 65c:	75 9d                	jne    5fb <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 65e:	83 c4 0c             	add    $0xc,%esp
 661:	5b                   	pop    %ebx
 662:	5e                   	pop    %esi
 663:	5f                   	pop    %edi
 664:	5d                   	pop    %ebp
 665:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 666:	8b 45 08             	mov    0x8(%ebp),%eax
 669:	0f be d3             	movsbl %bl,%edx
 66c:	e8 9f fe ff ff       	call   510 <putc>
 671:	8b 55 0c             	mov    0xc(%ebp),%edx
 674:	e9 77 ff ff ff       	jmp    5f0 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 679:	8b 45 f0             	mov    -0x10(%ebp),%eax
 67c:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 681:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 683:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 68a:	8b 10                	mov    (%eax),%edx
 68c:	8b 45 08             	mov    0x8(%ebp),%eax
 68f:	e8 ac fe ff ff       	call   540 <printint>
 694:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 697:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 69b:	e9 50 ff ff ff       	jmp    5f0 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 6a0:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 6a3:	8b 01                	mov    (%ecx),%eax
        ap++;
 6a5:	83 c1 04             	add    $0x4,%ecx
 6a8:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 6ab:	b9 24 09 00 00       	mov    $0x924,%ecx
 6b0:	85 c0                	test   %eax,%eax
 6b2:	75 2c                	jne    6e0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 6b4:	0f b6 01             	movzbl (%ecx),%eax
 6b7:	84 c0                	test   %al,%al
 6b9:	74 1e                	je     6d9 <printf+0x119>
 6bb:	89 cb                	mov    %ecx,%ebx
 6bd:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 6c0:	0f be d0             	movsbl %al,%edx
 6c3:	8b 45 08             	mov    0x8(%ebp),%eax
 6c6:	e8 45 fe ff ff       	call   510 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6cb:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 6cf:	83 c3 01             	add    $0x1,%ebx
 6d2:	84 c0                	test   %al,%al
 6d4:	75 ea                	jne    6c0 <printf+0x100>
 6d6:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 6d9:	31 f6                	xor    %esi,%esi
 6db:	e9 10 ff ff ff       	jmp    5f0 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 6e0:	89 c1                	mov    %eax,%ecx
 6e2:	eb d0                	jmp    6b4 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 6e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 6e7:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 6e9:	0f be 10             	movsbl (%eax),%edx
 6ec:	8b 45 08             	mov    0x8(%ebp),%eax
 6ef:	e8 1c fe ff ff       	call   510 <putc>
 6f4:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 6f7:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 6fb:	e9 f0 fe ff ff       	jmp    5f0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 700:	8b 45 f0             	mov    -0x10(%ebp),%eax
 703:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 708:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 70b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 712:	8b 10                	mov    (%eax),%edx
 714:	8b 45 08             	mov    0x8(%ebp),%eax
 717:	e8 24 fe ff ff       	call   540 <printint>
 71c:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 71f:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 723:	e9 c8 fe ff ff       	jmp    5f0 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 728:	8b 45 08             	mov    0x8(%ebp),%eax
 72b:	ba 25 00 00 00       	mov    $0x25,%edx
 730:	31 f6                	xor    %esi,%esi
 732:	e8 d9 fd ff ff       	call   510 <putc>
 737:	8b 55 0c             	mov    0xc(%ebp),%edx
 73a:	e9 b1 fe ff ff       	jmp    5f0 <printf+0x30>
 73f:	90                   	nop    

00000740 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 740:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 741:	8b 0d 4c 09 00 00    	mov    0x94c,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 747:	89 e5                	mov    %esp,%ebp
 749:	56                   	push   %esi
 74a:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 74b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 74e:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 751:	39 d9                	cmp    %ebx,%ecx
 753:	73 18                	jae    76d <free+0x2d>
 755:	8b 11                	mov    (%ecx),%edx
 757:	39 d3                	cmp    %edx,%ebx
 759:	72 17                	jb     772 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 75b:	39 d1                	cmp    %edx,%ecx
 75d:	72 08                	jb     767 <free+0x27>
 75f:	39 d9                	cmp    %ebx,%ecx
 761:	72 0f                	jb     772 <free+0x32>
 763:	39 d3                	cmp    %edx,%ebx
 765:	72 0b                	jb     772 <free+0x32>
 767:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 769:	39 d9                	cmp    %ebx,%ecx
 76b:	72 e8                	jb     755 <free+0x15>
 76d:	8b 11                	mov    (%ecx),%edx
 76f:	90                   	nop    
 770:	eb e9                	jmp    75b <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 772:	8b 73 04             	mov    0x4(%ebx),%esi
 775:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 778:	39 d0                	cmp    %edx,%eax
 77a:	74 18                	je     794 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 77c:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 77e:	8b 51 04             	mov    0x4(%ecx),%edx
 781:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 784:	39 d8                	cmp    %ebx,%eax
 786:	74 20                	je     7a8 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 788:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 78a:	5b                   	pop    %ebx
 78b:	5e                   	pop    %esi
 78c:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 78d:	89 0d 4c 09 00 00    	mov    %ecx,0x94c
}
 793:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 794:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 797:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 799:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 79c:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 79f:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7a1:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 7a4:	39 d8                	cmp    %ebx,%eax
 7a6:	75 e0                	jne    788 <free+0x48>
    p->s.size += bp->s.size;
 7a8:	03 53 04             	add    0x4(%ebx),%edx
 7ab:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 7ae:	8b 13                	mov    (%ebx),%edx
 7b0:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 7b2:	5b                   	pop    %ebx
 7b3:	5e                   	pop    %esi
 7b4:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 7b5:	89 0d 4c 09 00 00    	mov    %ecx,0x94c
}
 7bb:	c3                   	ret    
 7bc:	8d 74 26 00          	lea    0x0(%esi),%esi

000007c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7c0:	55                   	push   %ebp
 7c1:	89 e5                	mov    %esp,%ebp
 7c3:	57                   	push   %edi
 7c4:	56                   	push   %esi
 7c5:	53                   	push   %ebx
 7c6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7cc:	8b 15 4c 09 00 00    	mov    0x94c,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7d2:	83 c0 07             	add    $0x7,%eax
 7d5:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 7d8:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7da:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 7dd:	0f 84 8a 00 00 00    	je     86d <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e3:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 7e5:	8b 41 04             	mov    0x4(%ecx),%eax
 7e8:	39 c3                	cmp    %eax,%ebx
 7ea:	76 1a                	jbe    806 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 7ec:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 7f3:	3b 0d 4c 09 00 00    	cmp    0x94c,%ecx
 7f9:	89 ca                	mov    %ecx,%edx
 7fb:	74 29                	je     826 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7fd:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 7ff:	8b 41 04             	mov    0x4(%ecx),%eax
 802:	39 c3                	cmp    %eax,%ebx
 804:	77 ed                	ja     7f3 <malloc+0x33>
      if(p->s.size == nunits)
 806:	39 c3                	cmp    %eax,%ebx
 808:	74 5d                	je     867 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 80a:	29 d8                	sub    %ebx,%eax
 80c:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 80f:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 812:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 815:	89 15 4c 09 00 00    	mov    %edx,0x94c
      return (void*) (p + 1);
 81b:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 81e:	83 c4 0c             	add    $0xc,%esp
 821:	5b                   	pop    %ebx
 822:	5e                   	pop    %esi
 823:	5f                   	pop    %edi
 824:	5d                   	pop    %ebp
 825:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 826:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 82c:	89 de                	mov    %ebx,%esi
 82e:	89 f8                	mov    %edi,%eax
 830:	76 29                	jbe    85b <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 832:	89 04 24             	mov    %eax,(%esp)
 835:	e8 96 fc ff ff       	call   4d0 <sbrk>
  if(p == (char*) -1)
 83a:	83 f8 ff             	cmp    $0xffffffff,%eax
 83d:	74 18                	je     857 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 83f:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 842:	83 c0 08             	add    $0x8,%eax
 845:	89 04 24             	mov    %eax,(%esp)
 848:	e8 f3 fe ff ff       	call   740 <free>
  return freep;
 84d:	8b 15 4c 09 00 00    	mov    0x94c,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 853:	85 d2                	test   %edx,%edx
 855:	75 a6                	jne    7fd <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 857:	31 c0                	xor    %eax,%eax
 859:	eb c3                	jmp    81e <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 85b:	be 00 10 00 00       	mov    $0x1000,%esi
 860:	b8 00 80 00 00       	mov    $0x8000,%eax
 865:	eb cb                	jmp    832 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 867:	8b 01                	mov    (%ecx),%eax
 869:	89 02                	mov    %eax,(%edx)
 86b:	eb a8                	jmp    815 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 86d:	ba 44 09 00 00       	mov    $0x944,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 872:	c7 05 4c 09 00 00 44 	movl   $0x944,0x94c
 879:	09 00 00 
 87c:	c7 05 44 09 00 00 44 	movl   $0x944,0x944
 883:	09 00 00 
    base.s.size = 0;
 886:	c7 05 48 09 00 00 00 	movl   $0x0,0x948
 88d:	00 00 00 
 890:	e9 4e ff ff ff       	jmp    7e3 <malloc+0x23>
