
_hw5-test-toomany:     file format elf32-i386

Disassembly of section .text:

00000000 <panic>:
int stdin = 0;
int stdout = 1;
int stderr = 2;

inline __attribute__((noreturn)) void panic(const char *msg) {
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  printf(stderr, "[panic] %s\n", msg);
   6:	8b 45 08             	mov    0x8(%ebp),%eax
   9:	c7 44 24 04 65 07 00 	movl   $0x765,0x4(%esp)
  10:	00 
  11:	89 44 24 08          	mov    %eax,0x8(%esp)
  15:	a1 d0 07 00 00       	mov    0x7d0,%eax
  1a:	89 04 24             	mov    %eax,(%esp)
  1d:	e8 6e 04 00 00       	call   490 <printf>
  exit();
  22:	e8 11 03 00 00       	call   338 <exit>
  27:	89 f6                	mov    %esi,%esi
  29:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000030 <main>:
#include "hw5-common.h"

#define MAX_LEN (1024)
#define N_LOOPS (6)

int main() {
  30:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  34:	83 e4 f0             	and    $0xfffffff0,%esp
  37:	ff 71 fc             	pushl  -0x4(%ecx)
  3a:	55                   	push   %ebp
  3b:	89 e5                	mov    %esp,%ebp
  3d:	57                   	push   %edi
  3e:	bf 01 00 00 00       	mov    $0x1,%edi
  43:	56                   	push   %esi
  44:	31 f6                	xor    %esi,%esi
  46:	53                   	push   %ebx
  47:	51                   	push   %ecx
  48:	83 ec 18             	sub    $0x18,%esp
  4b:	90                   	nop    
  4c:	8d 74 26 00          	lea    0x0(%esi),%esi

  int i;
  int root = 1;
  for (i = 0; i < N_LOOPS; i++) {
    int child_pid = fork();
  50:	e8 db 02 00 00       	call   330 <fork>
    if (child_pid < 0) {
  55:	85 c0                	test   %eax,%eax
int main() {

  int i;
  int root = 1;
  for (i = 0; i < N_LOOPS; i++) {
    int child_pid = fork();
  57:	89 c3                	mov    %eax,%ebx
    if (child_pid < 0) {
  59:	78 75                	js     d0 <main+0xa0>
			int fd = open("fork-fail", O_CREATE);
			if (fd < 0)
				panic("open");
			close(fd);
		}
    if (child_pid == 0)
  5b:	83 fb 01             	cmp    $0x1,%ebx
  5e:	19 c0                	sbb    %eax,%eax

int main() {

  int i;
  int root = 1;
  for (i = 0; i < N_LOOPS; i++) {
  60:	83 c6 01             	add    $0x1,%esi
			int fd = open("fork-fail", O_CREATE);
			if (fd < 0)
				panic("open");
			close(fd);
		}
    if (child_pid == 0)
  63:	f7 d0                	not    %eax
  65:	21 c7                	and    %eax,%edi

int main() {

  int i;
  int root = 1;
  for (i = 0; i < N_LOOPS; i++) {
  67:	83 fe 06             	cmp    $0x6,%esi
  6a:	75 e4                	jne    50 <main+0x20>
		}
    if (child_pid == 0)
      root = 0;
  }

  sleep(root ? 4 * 100 : 1 * 100);
  6c:	83 ff 01             	cmp    $0x1,%edi
  6f:	19 c0                	sbb    %eax,%eax
  71:	25 d4 fe ff ff       	and    $0xfffffed4,%eax
  76:	05 90 01 00 00       	add    $0x190,%eax
  7b:	89 04 24             	mov    %eax,(%esp)
  7e:	e8 45 03 00 00       	call   3c8 <sleep>
  // Wait for all children to exit. 
  while (wait() >= 0);
  83:	e8 b8 02 00 00       	call   340 <wait>
  88:	85 c0                	test   %eax,%eax
  8a:	79 f7                	jns    83 <main+0x53>
  // Only the root process decides whether the testcase is passed. 
  if (!root)
  8c:	85 ff                	test   %edi,%edi
  8e:	66 90                	xchg   %ax,%ax
  90:	0f 84 7c 00 00 00    	je     112 <main+0xe2>
    exit();

	int fail = open("fork-fail", O_RDONLY);
  96:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  9d:	00 
  9e:	c7 04 24 71 07 00 00 	movl   $0x771,(%esp)
  a5:	e8 ce 02 00 00       	call   378 <open>
	if (fail < 0)
  aa:	85 c0                	test   %eax,%eax
  ac:	79 47                	jns    f5 <main+0xc5>
int stdin = 0;
int stdout = 1;
int stderr = 2;

inline __attribute__((noreturn)) void panic(const char *msg) {
  printf(stderr, "[panic] %s\n", msg);
  ae:	c7 44 24 08 80 07 00 	movl   $0x780,0x8(%esp)
  b5:	00 
  b6:	a1 d0 07 00 00       	mov    0x7d0,%eax
  bb:	c7 44 24 04 65 07 00 	movl   $0x765,0x4(%esp)
  c2:	00 
  c3:	89 04 24             	mov    %eax,(%esp)
  c6:	e8 c5 03 00 00       	call   490 <printf>
  exit();
  cb:	e8 68 02 00 00       	call   338 <exit>
  int i;
  int root = 1;
  for (i = 0; i < N_LOOPS; i++) {
    int child_pid = fork();
    if (child_pid < 0) {
			int fd = open("fork-fail", O_CREATE);
  d0:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
  d7:	00 
  d8:	c7 04 24 71 07 00 00 	movl   $0x771,(%esp)
  df:	e8 94 02 00 00       	call   378 <open>
			if (fd < 0)
  e4:	85 c0                	test   %eax,%eax
  e6:	78 2f                	js     117 <main+0xe7>
				panic("open");
			close(fd);
  e8:	89 04 24             	mov    %eax,(%esp)
  eb:	e8 70 02 00 00       	call   360 <close>
  f0:	e9 66 ff ff ff       	jmp    5b <main+0x2b>
    exit();

	int fail = open("fork-fail", O_RDONLY);
	if (fail < 0)
		panic("Some forks should fail");
	close(fail);
  f5:	89 04 24             	mov    %eax,(%esp)
  f8:	e8 63 02 00 00       	call   360 <close>

  printf(stdout, "hw5-test-toomany succeeded\n");
  fd:	a1 cc 07 00 00       	mov    0x7cc,%eax
 102:	c7 44 24 04 97 07 00 	movl   $0x797,0x4(%esp)
 109:	00 
 10a:	89 04 24             	mov    %eax,(%esp)
 10d:	e8 7e 03 00 00       	call   490 <printf>
  exit();
 112:	e8 21 02 00 00       	call   338 <exit>
int stdin = 0;
int stdout = 1;
int stderr = 2;

inline __attribute__((noreturn)) void panic(const char *msg) {
  printf(stderr, "[panic] %s\n", msg);
 117:	c7 44 24 08 7b 07 00 	movl   $0x77b,0x8(%esp)
 11e:	00 
 11f:	eb 95                	jmp    b6 <main+0x86>
 121:	90                   	nop    
 122:	90                   	nop    
 123:	90                   	nop    
 124:	90                   	nop    
 125:	90                   	nop    
 126:	90                   	nop    
 127:	90                   	nop    
 128:	90                   	nop    
 129:	90                   	nop    
 12a:	90                   	nop    
 12b:	90                   	nop    
 12c:	90                   	nop    
 12d:	90                   	nop    
 12e:	90                   	nop    
 12f:	90                   	nop    

00000130 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	53                   	push   %ebx
 134:	8b 5d 08             	mov    0x8(%ebp),%ebx
 137:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 13a:	89 da                	mov    %ebx,%edx
 13c:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 140:	0f b6 01             	movzbl (%ecx),%eax
 143:	83 c1 01             	add    $0x1,%ecx
 146:	88 02                	mov    %al,(%edx)
 148:	83 c2 01             	add    $0x1,%edx
 14b:	84 c0                	test   %al,%al
 14d:	75 f1                	jne    140 <strcpy+0x10>
    ;
  return os;
}
 14f:	89 d8                	mov    %ebx,%eax
 151:	5b                   	pop    %ebx
 152:	5d                   	pop    %ebp
 153:	c3                   	ret    
 154:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 15a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000160 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	8b 4d 08             	mov    0x8(%ebp),%ecx
 166:	53                   	push   %ebx
 167:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 16a:	0f b6 01             	movzbl (%ecx),%eax
 16d:	84 c0                	test   %al,%al
 16f:	74 24                	je     195 <strcmp+0x35>
 171:	0f b6 13             	movzbl (%ebx),%edx
 174:	38 d0                	cmp    %dl,%al
 176:	74 12                	je     18a <strcmp+0x2a>
 178:	eb 1e                	jmp    198 <strcmp+0x38>
 17a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 180:	0f b6 13             	movzbl (%ebx),%edx
 183:	83 c1 01             	add    $0x1,%ecx
 186:	38 d0                	cmp    %dl,%al
 188:	75 0e                	jne    198 <strcmp+0x38>
 18a:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 18e:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 191:	84 c0                	test   %al,%al
 193:	75 eb                	jne    180 <strcmp+0x20>
 195:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 198:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 199:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 19c:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 19d:	0f b6 d2             	movzbl %dl,%edx
 1a0:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 1a2:	c3                   	ret    
 1a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000001b0 <strlen>:

uint
strlen(char *s)
{
 1b0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 1b1:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 1b3:	89 e5                	mov    %esp,%ebp
 1b5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1b8:	80 39 00             	cmpb   $0x0,(%ecx)
 1bb:	74 0e                	je     1cb <strlen+0x1b>
 1bd:	31 d2                	xor    %edx,%edx
 1bf:	90                   	nop    
 1c0:	83 c2 01             	add    $0x1,%edx
 1c3:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
 1c7:	89 d0                	mov    %edx,%eax
 1c9:	75 f5                	jne    1c0 <strlen+0x10>
    ;
  return n;
}
 1cb:	5d                   	pop    %ebp
 1cc:	c3                   	ret    
 1cd:	8d 76 00             	lea    0x0(%esi),%esi

000001d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	8b 55 08             	mov    0x8(%ebp),%edx
 1d6:	57                   	push   %edi
 1d7:	8b 45 0c             	mov    0xc(%ebp),%eax
 1da:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1dd:	89 d7                	mov    %edx,%edi
 1df:	fc                   	cld    
 1e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1e2:	5f                   	pop    %edi
 1e3:	89 d0                	mov    %edx,%eax
 1e5:	5d                   	pop    %ebp
 1e6:	c3                   	ret    
 1e7:	89 f6                	mov    %esi,%esi
 1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000001f0 <strchr>:

char*
strchr(const char *s, char c)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1fa:	0f b6 10             	movzbl (%eax),%edx
 1fd:	84 d2                	test   %dl,%dl
 1ff:	75 0c                	jne    20d <strchr+0x1d>
 201:	eb 11                	jmp    214 <strchr+0x24>
 203:	83 c0 01             	add    $0x1,%eax
 206:	0f b6 10             	movzbl (%eax),%edx
 209:	84 d2                	test   %dl,%dl
 20b:	74 07                	je     214 <strchr+0x24>
    if(*s == c)
 20d:	38 ca                	cmp    %cl,%dl
 20f:	90                   	nop    
 210:	75 f1                	jne    203 <strchr+0x13>
      return (char*) s;
  return 0;
}
 212:	5d                   	pop    %ebp
 213:	c3                   	ret    
 214:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 215:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 217:	c3                   	ret    
 218:	90                   	nop    
 219:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000220 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	8b 4d 08             	mov    0x8(%ebp),%ecx
 226:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 227:	31 db                	xor    %ebx,%ebx
 229:	0f b6 11             	movzbl (%ecx),%edx
 22c:	8d 42 d0             	lea    -0x30(%edx),%eax
 22f:	3c 09                	cmp    $0x9,%al
 231:	77 18                	ja     24b <atoi+0x2b>
    n = n*10 + *s++ - '0';
 233:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 236:	0f be d2             	movsbl %dl,%edx
 239:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 23d:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 241:	83 c1 01             	add    $0x1,%ecx
 244:	8d 42 d0             	lea    -0x30(%edx),%eax
 247:	3c 09                	cmp    $0x9,%al
 249:	76 e8                	jbe    233 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 24b:	89 d8                	mov    %ebx,%eax
 24d:	5b                   	pop    %ebx
 24e:	5d                   	pop    %ebp
 24f:	c3                   	ret    

00000250 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	8b 4d 10             	mov    0x10(%ebp),%ecx
 256:	56                   	push   %esi
 257:	8b 75 08             	mov    0x8(%ebp),%esi
 25a:	53                   	push   %ebx
 25b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 25e:	85 c9                	test   %ecx,%ecx
 260:	7e 10                	jle    272 <memmove+0x22>
 262:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 264:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 268:	88 04 32             	mov    %al,(%edx,%esi,1)
 26b:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 26e:	39 ca                	cmp    %ecx,%edx
 270:	75 f2                	jne    264 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 272:	89 f0                	mov    %esi,%eax
 274:	5b                   	pop    %ebx
 275:	5e                   	pop    %esi
 276:	5d                   	pop    %ebp
 277:	c3                   	ret    
 278:	90                   	nop    
 279:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000280 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 286:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 289:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 28c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 28f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 294:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 29b:	00 
 29c:	89 04 24             	mov    %eax,(%esp)
 29f:	e8 d4 00 00 00       	call   378 <open>
  if(fd < 0)
 2a4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 2a8:	78 19                	js     2c3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 2aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ad:	89 1c 24             	mov    %ebx,(%esp)
 2b0:	89 44 24 04          	mov    %eax,0x4(%esp)
 2b4:	e8 d7 00 00 00       	call   390 <fstat>
  close(fd);
 2b9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 2bc:	89 c6                	mov    %eax,%esi
  close(fd);
 2be:	e8 9d 00 00 00       	call   360 <close>
  return r;
}
 2c3:	89 f0                	mov    %esi,%eax
 2c5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 2c8:	8b 75 fc             	mov    -0x4(%ebp),%esi
 2cb:	89 ec                	mov    %ebp,%esp
 2cd:	5d                   	pop    %ebp
 2ce:	c3                   	ret    
 2cf:	90                   	nop    

000002d0 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	57                   	push   %edi
 2d4:	56                   	push   %esi
 2d5:	31 f6                	xor    %esi,%esi
 2d7:	53                   	push   %ebx
 2d8:	83 ec 1c             	sub    $0x1c,%esp
 2db:	8b 7d 08             	mov    0x8(%ebp),%edi
 2de:	eb 06                	jmp    2e6 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2e0:	3c 0d                	cmp    $0xd,%al
 2e2:	74 39                	je     31d <gets+0x4d>
 2e4:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2e6:	8d 5e 01             	lea    0x1(%esi),%ebx
 2e9:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2ec:	7d 31                	jge    31f <gets+0x4f>
    cc = read(0, &c, 1);
 2ee:	8d 45 f3             	lea    -0xd(%ebp),%eax
 2f1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2f8:	00 
 2f9:	89 44 24 04          	mov    %eax,0x4(%esp)
 2fd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 304:	e8 47 00 00 00       	call   350 <read>
    if(cc < 1)
 309:	85 c0                	test   %eax,%eax
 30b:	7e 12                	jle    31f <gets+0x4f>
      break;
    buf[i++] = c;
 30d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 311:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 315:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 319:	3c 0a                	cmp    $0xa,%al
 31b:	75 c3                	jne    2e0 <gets+0x10>
 31d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 31f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 323:	89 f8                	mov    %edi,%eax
 325:	83 c4 1c             	add    $0x1c,%esp
 328:	5b                   	pop    %ebx
 329:	5e                   	pop    %esi
 32a:	5f                   	pop    %edi
 32b:	5d                   	pop    %ebp
 32c:	c3                   	ret    
 32d:	90                   	nop    
 32e:	90                   	nop    
 32f:	90                   	nop    

00000330 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 330:	b8 01 00 00 00       	mov    $0x1,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <exit>:
SYSCALL(exit)
 338:	b8 02 00 00 00       	mov    $0x2,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <wait>:
SYSCALL(wait)
 340:	b8 03 00 00 00       	mov    $0x3,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <pipe>:
SYSCALL(pipe)
 348:	b8 04 00 00 00       	mov    $0x4,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <read>:
SYSCALL(read)
 350:	b8 06 00 00 00       	mov    $0x6,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <write>:
SYSCALL(write)
 358:	b8 05 00 00 00       	mov    $0x5,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <close>:
SYSCALL(close)
 360:	b8 07 00 00 00       	mov    $0x7,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <kill>:
SYSCALL(kill)
 368:	b8 08 00 00 00       	mov    $0x8,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <exec>:
SYSCALL(exec)
 370:	b8 09 00 00 00       	mov    $0x9,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <open>:
SYSCALL(open)
 378:	b8 0a 00 00 00       	mov    $0xa,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <mknod>:
SYSCALL(mknod)
 380:	b8 0b 00 00 00       	mov    $0xb,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <unlink>:
SYSCALL(unlink)
 388:	b8 0c 00 00 00       	mov    $0xc,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <fstat>:
SYSCALL(fstat)
 390:	b8 0d 00 00 00       	mov    $0xd,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <link>:
SYSCALL(link)
 398:	b8 0e 00 00 00       	mov    $0xe,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <mkdir>:
SYSCALL(mkdir)
 3a0:	b8 0f 00 00 00       	mov    $0xf,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <chdir>:
SYSCALL(chdir)
 3a8:	b8 10 00 00 00       	mov    $0x10,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <dup>:
SYSCALL(dup)
 3b0:	b8 11 00 00 00       	mov    $0x11,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <getpid>:
SYSCALL(getpid)
 3b8:	b8 12 00 00 00       	mov    $0x12,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <sbrk>:
SYSCALL(sbrk)
 3c0:	b8 13 00 00 00       	mov    $0x13,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <sleep>:
SYSCALL(sleep)
 3c8:	b8 14 00 00 00       	mov    $0x14,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <uptime>:
SYSCALL(uptime)
 3d0:	b8 15 00 00 00       	mov    $0x15,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <freepages>:
// Added by Jingyue
SYSCALL(freepages)
 3d8:	b8 16 00 00 00       	mov    $0x16,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	83 ec 18             	sub    $0x18,%esp
 3e6:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 3e9:	8d 55 fc             	lea    -0x4(%ebp),%edx
 3ec:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3f3:	00 
 3f4:	89 54 24 04          	mov    %edx,0x4(%esp)
 3f8:	89 04 24             	mov    %eax,(%esp)
 3fb:	e8 58 ff ff ff       	call   358 <write>
}
 400:	c9                   	leave  
 401:	c3                   	ret    
 402:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 409:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000410 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	89 ce                	mov    %ecx,%esi
 417:	53                   	push   %ebx
 418:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 41b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 41e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 421:	85 c9                	test   %ecx,%ecx
 423:	74 04                	je     429 <printint+0x19>
 425:	85 d2                	test   %edx,%edx
 427:	78 54                	js     47d <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 429:	89 d0                	mov    %edx,%eax
 42b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 432:	31 db                	xor    %ebx,%ebx
 434:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 437:	31 d2                	xor    %edx,%edx
 439:	f7 f6                	div    %esi
 43b:	89 c1                	mov    %eax,%ecx
 43d:	0f b6 82 ba 07 00 00 	movzbl 0x7ba(%edx),%eax
 444:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 447:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 44a:	85 c9                	test   %ecx,%ecx
 44c:	89 c8                	mov    %ecx,%eax
 44e:	75 e7                	jne    437 <printint+0x27>
  if(neg)
 450:	8b 45 e0             	mov    -0x20(%ebp),%eax
 453:	85 c0                	test   %eax,%eax
 455:	74 08                	je     45f <printint+0x4f>
    buf[i++] = '-';
 457:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 45c:	83 c3 01             	add    $0x1,%ebx
 45f:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 462:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 466:	83 eb 01             	sub    $0x1,%ebx
 469:	8b 45 dc             	mov    -0x24(%ebp),%eax
 46c:	e8 6f ff ff ff       	call   3e0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 471:	39 fb                	cmp    %edi,%ebx
 473:	75 ed                	jne    462 <printint+0x52>
    putc(fd, buf[i]);
}
 475:	83 c4 1c             	add    $0x1c,%esp
 478:	5b                   	pop    %ebx
 479:	5e                   	pop    %esi
 47a:	5f                   	pop    %edi
 47b:	5d                   	pop    %ebp
 47c:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 47d:	89 d0                	mov    %edx,%eax
 47f:	f7 d8                	neg    %eax
 481:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 488:	eb a8                	jmp    432 <printint+0x22>
 48a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000490 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	56                   	push   %esi
 495:	53                   	push   %ebx
 496:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 499:	8b 55 0c             	mov    0xc(%ebp),%edx
 49c:	0f b6 02             	movzbl (%edx),%eax
 49f:	84 c0                	test   %al,%al
 4a1:	0f 84 87 00 00 00    	je     52e <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 4a7:	8d 4d 10             	lea    0x10(%ebp),%ecx
 4aa:	31 ff                	xor    %edi,%edi
 4ac:	31 f6                	xor    %esi,%esi
 4ae:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 4b1:	eb 18                	jmp    4cb <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 4b3:	83 fb 25             	cmp    $0x25,%ebx
 4b6:	0f 85 7a 00 00 00    	jne    536 <printf+0xa6>
 4bc:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4c0:	83 c7 01             	add    $0x1,%edi
 4c3:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 4c7:	84 c0                	test   %al,%al
 4c9:	74 63                	je     52e <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 4cb:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 4cd:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 4d0:	74 e1                	je     4b3 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4d2:	83 fe 25             	cmp    $0x25,%esi
 4d5:	75 e9                	jne    4c0 <printf+0x30>
      if(c == 'd'){
 4d7:	83 fb 64             	cmp    $0x64,%ebx
 4da:	0f 84 f0 00 00 00    	je     5d0 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4e0:	83 fb 78             	cmp    $0x78,%ebx
 4e3:	74 64                	je     549 <printf+0xb9>
 4e5:	83 fb 70             	cmp    $0x70,%ebx
 4e8:	74 5f                	je     549 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4ea:	83 fb 73             	cmp    $0x73,%ebx
 4ed:	8d 76 00             	lea    0x0(%esi),%esi
 4f0:	74 7e                	je     570 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4f2:	83 fb 63             	cmp    $0x63,%ebx
 4f5:	0f 84 b9 00 00 00    	je     5b4 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4fb:	83 fb 25             	cmp    $0x25,%ebx
 4fe:	66 90                	xchg   %ax,%ax
 500:	0f 84 f2 00 00 00    	je     5f8 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 506:	8b 45 08             	mov    0x8(%ebp),%eax
 509:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 50e:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 511:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 513:	e8 c8 fe ff ff       	call   3e0 <putc>
        putc(fd, c);
 518:	8b 45 08             	mov    0x8(%ebp),%eax
 51b:	0f be d3             	movsbl %bl,%edx
 51e:	e8 bd fe ff ff       	call   3e0 <putc>
 523:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 526:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 52a:	84 c0                	test   %al,%al
 52c:	75 9d                	jne    4cb <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 52e:	83 c4 0c             	add    $0xc,%esp
 531:	5b                   	pop    %ebx
 532:	5e                   	pop    %esi
 533:	5f                   	pop    %edi
 534:	5d                   	pop    %ebp
 535:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 536:	8b 45 08             	mov    0x8(%ebp),%eax
 539:	0f be d3             	movsbl %bl,%edx
 53c:	e8 9f fe ff ff       	call   3e0 <putc>
 541:	8b 55 0c             	mov    0xc(%ebp),%edx
 544:	e9 77 ff ff ff       	jmp    4c0 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 549:	8b 45 f0             	mov    -0x10(%ebp),%eax
 54c:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 551:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 553:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 55a:	8b 10                	mov    (%eax),%edx
 55c:	8b 45 08             	mov    0x8(%ebp),%eax
 55f:	e8 ac fe ff ff       	call   410 <printint>
 564:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 567:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 56b:	e9 50 ff ff ff       	jmp    4c0 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 570:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 573:	8b 01                	mov    (%ecx),%eax
        ap++;
 575:	83 c1 04             	add    $0x4,%ecx
 578:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 57b:	b9 b3 07 00 00       	mov    $0x7b3,%ecx
 580:	85 c0                	test   %eax,%eax
 582:	75 2c                	jne    5b0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 584:	0f b6 01             	movzbl (%ecx),%eax
 587:	84 c0                	test   %al,%al
 589:	74 1e                	je     5a9 <printf+0x119>
 58b:	89 cb                	mov    %ecx,%ebx
 58d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 590:	0f be d0             	movsbl %al,%edx
 593:	8b 45 08             	mov    0x8(%ebp),%eax
 596:	e8 45 fe ff ff       	call   3e0 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 59b:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 59f:	83 c3 01             	add    $0x1,%ebx
 5a2:	84 c0                	test   %al,%al
 5a4:	75 ea                	jne    590 <printf+0x100>
 5a6:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 5a9:	31 f6                	xor    %esi,%esi
 5ab:	e9 10 ff ff ff       	jmp    4c0 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 5b0:	89 c1                	mov    %eax,%ecx
 5b2:	eb d0                	jmp    584 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 5b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 5b7:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 5b9:	0f be 10             	movsbl (%eax),%edx
 5bc:	8b 45 08             	mov    0x8(%ebp),%eax
 5bf:	e8 1c fe ff ff       	call   3e0 <putc>
 5c4:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 5c7:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 5cb:	e9 f0 fe ff ff       	jmp    4c0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 5d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 5d8:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 5db:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5e2:	8b 10                	mov    (%eax),%edx
 5e4:	8b 45 08             	mov    0x8(%ebp),%eax
 5e7:	e8 24 fe ff ff       	call   410 <printint>
 5ec:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 5ef:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 5f3:	e9 c8 fe ff ff       	jmp    4c0 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 5f8:	8b 45 08             	mov    0x8(%ebp),%eax
 5fb:	ba 25 00 00 00       	mov    $0x25,%edx
 600:	31 f6                	xor    %esi,%esi
 602:	e8 d9 fd ff ff       	call   3e0 <putc>
 607:	8b 55 0c             	mov    0xc(%ebp),%edx
 60a:	e9 b1 fe ff ff       	jmp    4c0 <printf+0x30>
 60f:	90                   	nop    

00000610 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 610:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 611:	8b 0d e0 07 00 00    	mov    0x7e0,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 617:	89 e5                	mov    %esp,%ebp
 619:	56                   	push   %esi
 61a:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 61b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 61e:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 621:	39 d9                	cmp    %ebx,%ecx
 623:	73 18                	jae    63d <free+0x2d>
 625:	8b 11                	mov    (%ecx),%edx
 627:	39 d3                	cmp    %edx,%ebx
 629:	72 17                	jb     642 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 62b:	39 d1                	cmp    %edx,%ecx
 62d:	72 08                	jb     637 <free+0x27>
 62f:	39 d9                	cmp    %ebx,%ecx
 631:	72 0f                	jb     642 <free+0x32>
 633:	39 d3                	cmp    %edx,%ebx
 635:	72 0b                	jb     642 <free+0x32>
 637:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 639:	39 d9                	cmp    %ebx,%ecx
 63b:	72 e8                	jb     625 <free+0x15>
 63d:	8b 11                	mov    (%ecx),%edx
 63f:	90                   	nop    
 640:	eb e9                	jmp    62b <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 642:	8b 73 04             	mov    0x4(%ebx),%esi
 645:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 648:	39 d0                	cmp    %edx,%eax
 64a:	74 18                	je     664 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 64c:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 64e:	8b 51 04             	mov    0x4(%ecx),%edx
 651:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 654:	39 d8                	cmp    %ebx,%eax
 656:	74 20                	je     678 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 658:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 65a:	5b                   	pop    %ebx
 65b:	5e                   	pop    %esi
 65c:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 65d:	89 0d e0 07 00 00    	mov    %ecx,0x7e0
}
 663:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 664:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 667:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 669:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 66c:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 66f:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 671:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 674:	39 d8                	cmp    %ebx,%eax
 676:	75 e0                	jne    658 <free+0x48>
    p->s.size += bp->s.size;
 678:	03 53 04             	add    0x4(%ebx),%edx
 67b:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 67e:	8b 13                	mov    (%ebx),%edx
 680:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 682:	5b                   	pop    %ebx
 683:	5e                   	pop    %esi
 684:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 685:	89 0d e0 07 00 00    	mov    %ecx,0x7e0
}
 68b:	c3                   	ret    
 68c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000690 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	57                   	push   %edi
 694:	56                   	push   %esi
 695:	53                   	push   %ebx
 696:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 699:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 69c:	8b 15 e0 07 00 00    	mov    0x7e0,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6a2:	83 c0 07             	add    $0x7,%eax
 6a5:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 6a8:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6aa:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 6ad:	0f 84 8a 00 00 00    	je     73d <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6b3:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 6b5:	8b 41 04             	mov    0x4(%ecx),%eax
 6b8:	39 c3                	cmp    %eax,%ebx
 6ba:	76 1a                	jbe    6d6 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 6bc:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 6c3:	3b 0d e0 07 00 00    	cmp    0x7e0,%ecx
 6c9:	89 ca                	mov    %ecx,%edx
 6cb:	74 29                	je     6f6 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6cd:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 6cf:	8b 41 04             	mov    0x4(%ecx),%eax
 6d2:	39 c3                	cmp    %eax,%ebx
 6d4:	77 ed                	ja     6c3 <malloc+0x33>
      if(p->s.size == nunits)
 6d6:	39 c3                	cmp    %eax,%ebx
 6d8:	74 5d                	je     737 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 6da:	29 d8                	sub    %ebx,%eax
 6dc:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 6df:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 6e2:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 6e5:	89 15 e0 07 00 00    	mov    %edx,0x7e0
      return (void*) (p + 1);
 6eb:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 6ee:	83 c4 0c             	add    $0xc,%esp
 6f1:	5b                   	pop    %ebx
 6f2:	5e                   	pop    %esi
 6f3:	5f                   	pop    %edi
 6f4:	5d                   	pop    %ebp
 6f5:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 6f6:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 6fc:	89 de                	mov    %ebx,%esi
 6fe:	89 f8                	mov    %edi,%eax
 700:	76 29                	jbe    72b <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 702:	89 04 24             	mov    %eax,(%esp)
 705:	e8 b6 fc ff ff       	call   3c0 <sbrk>
  if(p == (char*) -1)
 70a:	83 f8 ff             	cmp    $0xffffffff,%eax
 70d:	74 18                	je     727 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 70f:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 712:	83 c0 08             	add    $0x8,%eax
 715:	89 04 24             	mov    %eax,(%esp)
 718:	e8 f3 fe ff ff       	call   610 <free>
  return freep;
 71d:	8b 15 e0 07 00 00    	mov    0x7e0,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 723:	85 d2                	test   %edx,%edx
 725:	75 a6                	jne    6cd <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 727:	31 c0                	xor    %eax,%eax
 729:	eb c3                	jmp    6ee <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 72b:	be 00 10 00 00       	mov    $0x1000,%esi
 730:	b8 00 80 00 00       	mov    $0x8000,%eax
 735:	eb cb                	jmp    702 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 737:	8b 01                	mov    (%ecx),%eax
 739:	89 02                	mov    %eax,(%edx)
 73b:	eb a8                	jmp    6e5 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 73d:	ba d8 07 00 00       	mov    $0x7d8,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 742:	c7 05 e0 07 00 00 d8 	movl   $0x7d8,0x7e0
 749:	07 00 00 
 74c:	c7 05 d8 07 00 00 d8 	movl   $0x7d8,0x7d8
 753:	07 00 00 
    base.s.size = 0;
 756:	c7 05 dc 07 00 00 00 	movl   $0x0,0x7dc
 75d:	00 00 00 
 760:	e9 4e ff ff ff       	jmp    6b3 <malloc+0x23>
