
_hw5-test-error:     file format elf32-i386

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
   9:	c7 44 24 04 f5 07 00 	movl   $0x7f5,0x4(%esp)
  10:	00 
  11:	89 44 24 08          	mov    %eax,0x8(%esp)
  15:	a1 74 08 00 00       	mov    0x874,%eax
  1a:	89 04 24             	mov    %eax,(%esp)
  1d:	e8 fe 04 00 00       	call   520 <printf>
  exit();
  22:	e8 a1 03 00 00       	call   3c8 <exit>
  27:	89 f6                	mov    %esi,%esi
  29:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000030 <main>:

#include "types.h"
#include "user.h"
#include "hw5-common.h"

int main() {
  30:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  34:	83 e4 f0             	and    $0xfffffff0,%esp
  37:	ff 71 fc             	pushl  -0x4(%ecx)
  3a:	55                   	push   %ebp
  3b:	89 e5                	mov    %esp,%ebp
  3d:	53                   	push   %ebx
  3e:	51                   	push   %ecx
  3f:	83 ec 10             	sub    $0x10,%esp

  int pid;
  int ppid = getpid();
  42:	e8 01 04 00 00       	call   448 <getpid>
  47:	89 c3                	mov    %eax,%ebx

  pid = fork();
  49:	e8 72 03 00 00       	call   3c0 <fork>
  if (pid < 0)
  4e:	83 f8 00             	cmp    $0x0,%eax
  51:	0f 8c 98 00 00 00    	jl     ef <main+0xbf>
    panic("fork");
  if (pid == 0) {
  57:	0f 84 9c 00 00 00    	je     f9 <main+0xc9>
  5d:	8d 76 00             	lea    0x0(%esi),%esi
    char *a = sbrk(0);
    printf(stdout, "oops could read %x = %x\n", a, *a);
    kill(ppid);
    exit();
  }
  if (wait() < 0)
  60:	e8 6b 03 00 00       	call   3d0 <wait>
  65:	85 c0                	test   %eax,%eax
  67:	78 64                	js     cd <main+0x9d>
    panic("wait");

  pid = fork();
  69:	e8 52 03 00 00       	call   3c0 <fork>
  if (pid < 0)
  6e:	83 f8 00             	cmp    $0x0,%eax
  71:	7c 7c                	jl     ef <main+0xbf>
    panic("fork");
  if (pid == 0) {
  73:	0f 84 b9 00 00 00    	je     132 <main+0x102>
  79:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
    *a = '\0';
    printf(stdout, "oops could write %x = %x\n", a, *a);
    kill(ppid);
    exit();
  }
  if (wait() < 0)
  80:	e8 4b 03 00 00       	call   3d0 <wait>
  85:	85 c0                	test   %eax,%eax
  87:	78 44                	js     cd <main+0x9d>
    panic("wait");

  pid = fork();
  89:	e8 32 03 00 00       	call   3c0 <fork>
  if (pid < 0)
  8e:	83 f8 00             	cmp    $0x0,%eax
  91:	7c 5c                	jl     ef <main+0xbf>
    panic("fork");
  if (pid == 0) {
  93:	0f 84 be 00 00 00    	je     157 <main+0x127>
  99:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
    char *a = (char *)(640 * 1024);
    printf(stdout, "oops could read %x = %x\n", a, *a);
    kill(ppid);
    exit();
  }
  if (wait() < 0)
  a0:	e8 2b 03 00 00       	call   3d0 <wait>
  a5:	85 c0                	test   %eax,%eax
  a7:	78 24                	js     cd <main+0x9d>
    panic("wait");

  pid = fork();
  a9:	e8 12 03 00 00       	call   3c0 <fork>
  if (pid < 0)
  ae:	83 f8 00             	cmp    $0x0,%eax
  b1:	7c 3c                	jl     ef <main+0xbf>
    panic("fork");
  if (pid == 0) {
  b3:	0f 84 d5 00 00 00    	je     18e <main+0x15e>
  b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
    *a = '\0';
    printf(stdout, "oops could write %x = %x\n", a, *a);
    kill(ppid);
    exit();
  }
  if (wait() < 0)
  c0:	e8 0b 03 00 00       	call   3d0 <wait>
  c5:	85 c0                	test   %eax,%eax
  c7:	0f 89 a7 00 00 00    	jns    174 <main+0x144>
int stdin = 0;
int stdout = 1;
int stderr = 2;

inline __attribute__((noreturn)) void panic(const char *msg) {
  printf(stderr, "[panic] %s\n", msg);
  cd:	c7 44 24 08 1f 08 00 	movl   $0x81f,0x8(%esp)
  d4:	00 
  d5:	a1 74 08 00 00       	mov    0x874,%eax
  da:	c7 44 24 04 f5 07 00 	movl   $0x7f5,0x4(%esp)
  e1:	00 
  e2:	89 04 24             	mov    %eax,(%esp)
  e5:	e8 36 04 00 00       	call   520 <printf>
  exit();
  ea:	e8 d9 02 00 00       	call   3c8 <exit>
int stdin = 0;
int stdout = 1;
int stderr = 2;

inline __attribute__((noreturn)) void panic(const char *msg) {
  printf(stderr, "[panic] %s\n", msg);
  ef:	c7 44 24 08 01 08 00 	movl   $0x801,0x8(%esp)
  f6:	00 
  f7:	eb dc                	jmp    d5 <main+0xa5>

  pid = fork();
  if (pid < 0)
    panic("fork");
  if (pid == 0) {
    char *a = sbrk(0);
  f9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 100:	e8 4b 03 00 00       	call   450 <sbrk>
    printf(stdout, "oops could read %x = %x\n", a, *a);
 105:	0f be 10             	movsbl (%eax),%edx
 108:	89 44 24 08          	mov    %eax,0x8(%esp)
 10c:	c7 44 24 04 06 08 00 	movl   $0x806,0x4(%esp)
 113:	00 
 114:	89 54 24 0c          	mov    %edx,0xc(%esp)
  if (pid < 0)
    panic("fork");
  if (pid == 0) {
    char *a = sbrk(0);
    *a = '\0';
    printf(stdout, "oops could write %x = %x\n", a, *a);
 118:	a1 70 08 00 00       	mov    0x870,%eax
 11d:	89 04 24             	mov    %eax,(%esp)
 120:	e8 fb 03 00 00       	call   520 <printf>
    kill(ppid);
 125:	89 1c 24             	mov    %ebx,(%esp)
 128:	e8 cb 02 00 00       	call   3f8 <kill>
    exit();
 12d:	e8 96 02 00 00       	call   3c8 <exit>

  pid = fork();
  if (pid < 0)
    panic("fork");
  if (pid == 0) {
    char *a = sbrk(0);
 132:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 139:	e8 12 03 00 00       	call   450 <sbrk>
    *a = '\0';
 13e:	c6 00 00             	movb   $0x0,(%eax)
    printf(stdout, "oops could write %x = %x\n", a, *a);
 141:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 148:	00 
 149:	89 44 24 08          	mov    %eax,0x8(%esp)
 14d:	c7 44 24 04 24 08 00 	movl   $0x824,0x4(%esp)
 154:	00 
 155:	eb c1                	jmp    118 <main+0xe8>
  pid = fork();
  if (pid < 0)
    panic("fork");
  if (pid == 0) {
    char *a = (char *)(640 * 1024);
    printf(stdout, "oops could read %x = %x\n", a, *a);
 157:	0f be 05 00 00 0a 00 	movsbl 0xa0000,%eax
 15e:	c7 44 24 08 00 00 0a 	movl   $0xa0000,0x8(%esp)
 165:	00 
 166:	c7 44 24 04 06 08 00 	movl   $0x806,0x4(%esp)
 16d:	00 
 16e:	89 44 24 0c          	mov    %eax,0xc(%esp)
 172:	eb a4                	jmp    118 <main+0xe8>
    exit();
  }
  if (wait() < 0)
    panic("wait");

  printf(stdout, "hw5-test-error succeeded\n");
 174:	a1 70 08 00 00       	mov    0x870,%eax
 179:	c7 44 24 04 3e 08 00 	movl   $0x83e,0x4(%esp)
 180:	00 
 181:	89 04 24             	mov    %eax,(%esp)
 184:	e8 97 03 00 00       	call   520 <printf>
  exit();
 189:	e8 3a 02 00 00       	call   3c8 <exit>
  pid = fork();
  if (pid < 0)
    panic("fork");
  if (pid == 0) {
    char *a = (char *)(640 * 1024);
    *a = '\0';
 18e:	c6 05 00 00 0a 00 00 	movb   $0x0,0xa0000
    printf(stdout, "oops could write %x = %x\n", a, *a);
 195:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 19c:	00 
 19d:	c7 44 24 08 00 00 0a 	movl   $0xa0000,0x8(%esp)
 1a4:	00 
 1a5:	c7 44 24 04 24 08 00 	movl   $0x824,0x4(%esp)
 1ac:	00 
 1ad:	e9 66 ff ff ff       	jmp    118 <main+0xe8>
 1b2:	90                   	nop    
 1b3:	90                   	nop    
 1b4:	90                   	nop    
 1b5:	90                   	nop    
 1b6:	90                   	nop    
 1b7:	90                   	nop    
 1b8:	90                   	nop    
 1b9:	90                   	nop    
 1ba:	90                   	nop    
 1bb:	90                   	nop    
 1bc:	90                   	nop    
 1bd:	90                   	nop    
 1be:	90                   	nop    
 1bf:	90                   	nop    

000001c0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	53                   	push   %ebx
 1c4:	8b 5d 08             	mov    0x8(%ebp),%ebx
 1c7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1ca:	89 da                	mov    %ebx,%edx
 1cc:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1d0:	0f b6 01             	movzbl (%ecx),%eax
 1d3:	83 c1 01             	add    $0x1,%ecx
 1d6:	88 02                	mov    %al,(%edx)
 1d8:	83 c2 01             	add    $0x1,%edx
 1db:	84 c0                	test   %al,%al
 1dd:	75 f1                	jne    1d0 <strcpy+0x10>
    ;
  return os;
}
 1df:	89 d8                	mov    %ebx,%eax
 1e1:	5b                   	pop    %ebx
 1e2:	5d                   	pop    %ebp
 1e3:	c3                   	ret    
 1e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1f6:	53                   	push   %ebx
 1f7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 1fa:	0f b6 01             	movzbl (%ecx),%eax
 1fd:	84 c0                	test   %al,%al
 1ff:	74 24                	je     225 <strcmp+0x35>
 201:	0f b6 13             	movzbl (%ebx),%edx
 204:	38 d0                	cmp    %dl,%al
 206:	74 12                	je     21a <strcmp+0x2a>
 208:	eb 1e                	jmp    228 <strcmp+0x38>
 20a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 210:	0f b6 13             	movzbl (%ebx),%edx
 213:	83 c1 01             	add    $0x1,%ecx
 216:	38 d0                	cmp    %dl,%al
 218:	75 0e                	jne    228 <strcmp+0x38>
 21a:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 21e:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 221:	84 c0                	test   %al,%al
 223:	75 eb                	jne    210 <strcmp+0x20>
 225:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 228:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 229:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 22c:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 22d:	0f b6 d2             	movzbl %dl,%edx
 230:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 232:	c3                   	ret    
 233:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000240 <strlen>:

uint
strlen(char *s)
{
 240:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 241:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 243:	89 e5                	mov    %esp,%ebp
 245:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 248:	80 39 00             	cmpb   $0x0,(%ecx)
 24b:	74 0e                	je     25b <strlen+0x1b>
 24d:	31 d2                	xor    %edx,%edx
 24f:	90                   	nop    
 250:	83 c2 01             	add    $0x1,%edx
 253:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
 257:	89 d0                	mov    %edx,%eax
 259:	75 f5                	jne    250 <strlen+0x10>
    ;
  return n;
}
 25b:	5d                   	pop    %ebp
 25c:	c3                   	ret    
 25d:	8d 76 00             	lea    0x0(%esi),%esi

00000260 <memset>:

void*
memset(void *dst, int c, uint n)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	8b 55 08             	mov    0x8(%ebp),%edx
 266:	57                   	push   %edi
 267:	8b 45 0c             	mov    0xc(%ebp),%eax
 26a:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 26d:	89 d7                	mov    %edx,%edi
 26f:	fc                   	cld    
 270:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 272:	5f                   	pop    %edi
 273:	89 d0                	mov    %edx,%eax
 275:	5d                   	pop    %ebp
 276:	c3                   	ret    
 277:	89 f6                	mov    %esi,%esi
 279:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000280 <strchr>:

char*
strchr(const char *s, char c)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	8b 45 08             	mov    0x8(%ebp),%eax
 286:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 28a:	0f b6 10             	movzbl (%eax),%edx
 28d:	84 d2                	test   %dl,%dl
 28f:	75 0c                	jne    29d <strchr+0x1d>
 291:	eb 11                	jmp    2a4 <strchr+0x24>
 293:	83 c0 01             	add    $0x1,%eax
 296:	0f b6 10             	movzbl (%eax),%edx
 299:	84 d2                	test   %dl,%dl
 29b:	74 07                	je     2a4 <strchr+0x24>
    if(*s == c)
 29d:	38 ca                	cmp    %cl,%dl
 29f:	90                   	nop    
 2a0:	75 f1                	jne    293 <strchr+0x13>
      return (char*) s;
  return 0;
}
 2a2:	5d                   	pop    %ebp
 2a3:	c3                   	ret    
 2a4:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2a5:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 2a7:	c3                   	ret    
 2a8:	90                   	nop    
 2a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000002b0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2b6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2b7:	31 db                	xor    %ebx,%ebx
 2b9:	0f b6 11             	movzbl (%ecx),%edx
 2bc:	8d 42 d0             	lea    -0x30(%edx),%eax
 2bf:	3c 09                	cmp    $0x9,%al
 2c1:	77 18                	ja     2db <atoi+0x2b>
    n = n*10 + *s++ - '0';
 2c3:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 2c6:	0f be d2             	movsbl %dl,%edx
 2c9:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2cd:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 2d1:	83 c1 01             	add    $0x1,%ecx
 2d4:	8d 42 d0             	lea    -0x30(%edx),%eax
 2d7:	3c 09                	cmp    $0x9,%al
 2d9:	76 e8                	jbe    2c3 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 2db:	89 d8                	mov    %ebx,%eax
 2dd:	5b                   	pop    %ebx
 2de:	5d                   	pop    %ebp
 2df:	c3                   	ret    

000002e0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	8b 4d 10             	mov    0x10(%ebp),%ecx
 2e6:	56                   	push   %esi
 2e7:	8b 75 08             	mov    0x8(%ebp),%esi
 2ea:	53                   	push   %ebx
 2eb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ee:	85 c9                	test   %ecx,%ecx
 2f0:	7e 10                	jle    302 <memmove+0x22>
 2f2:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 2f4:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 2f8:	88 04 32             	mov    %al,(%edx,%esi,1)
 2fb:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2fe:	39 ca                	cmp    %ecx,%edx
 300:	75 f2                	jne    2f4 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 302:	89 f0                	mov    %esi,%eax
 304:	5b                   	pop    %ebx
 305:	5e                   	pop    %esi
 306:	5d                   	pop    %ebp
 307:	c3                   	ret    
 308:	90                   	nop    
 309:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000310 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 316:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 319:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 31c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 31f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 324:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 32b:	00 
 32c:	89 04 24             	mov    %eax,(%esp)
 32f:	e8 d4 00 00 00       	call   408 <open>
  if(fd < 0)
 334:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 336:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 338:	78 19                	js     353 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 33a:	8b 45 0c             	mov    0xc(%ebp),%eax
 33d:	89 1c 24             	mov    %ebx,(%esp)
 340:	89 44 24 04          	mov    %eax,0x4(%esp)
 344:	e8 d7 00 00 00       	call   420 <fstat>
  close(fd);
 349:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 34c:	89 c6                	mov    %eax,%esi
  close(fd);
 34e:	e8 9d 00 00 00       	call   3f0 <close>
  return r;
}
 353:	89 f0                	mov    %esi,%eax
 355:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 358:	8b 75 fc             	mov    -0x4(%ebp),%esi
 35b:	89 ec                	mov    %ebp,%esp
 35d:	5d                   	pop    %ebp
 35e:	c3                   	ret    
 35f:	90                   	nop    

00000360 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	56                   	push   %esi
 365:	31 f6                	xor    %esi,%esi
 367:	53                   	push   %ebx
 368:	83 ec 1c             	sub    $0x1c,%esp
 36b:	8b 7d 08             	mov    0x8(%ebp),%edi
 36e:	eb 06                	jmp    376 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 370:	3c 0d                	cmp    $0xd,%al
 372:	74 39                	je     3ad <gets+0x4d>
 374:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 376:	8d 5e 01             	lea    0x1(%esi),%ebx
 379:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 37c:	7d 31                	jge    3af <gets+0x4f>
    cc = read(0, &c, 1);
 37e:	8d 45 f3             	lea    -0xd(%ebp),%eax
 381:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 388:	00 
 389:	89 44 24 04          	mov    %eax,0x4(%esp)
 38d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 394:	e8 47 00 00 00       	call   3e0 <read>
    if(cc < 1)
 399:	85 c0                	test   %eax,%eax
 39b:	7e 12                	jle    3af <gets+0x4f>
      break;
    buf[i++] = c;
 39d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 3a1:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 3a5:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 3a9:	3c 0a                	cmp    $0xa,%al
 3ab:	75 c3                	jne    370 <gets+0x10>
 3ad:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 3af:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 3b3:	89 f8                	mov    %edi,%eax
 3b5:	83 c4 1c             	add    $0x1c,%esp
 3b8:	5b                   	pop    %ebx
 3b9:	5e                   	pop    %esi
 3ba:	5f                   	pop    %edi
 3bb:	5d                   	pop    %ebp
 3bc:	c3                   	ret    
 3bd:	90                   	nop    
 3be:	90                   	nop    
 3bf:	90                   	nop    

000003c0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3c0:	b8 01 00 00 00       	mov    $0x1,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <exit>:
SYSCALL(exit)
 3c8:	b8 02 00 00 00       	mov    $0x2,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <wait>:
SYSCALL(wait)
 3d0:	b8 03 00 00 00       	mov    $0x3,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <pipe>:
SYSCALL(pipe)
 3d8:	b8 04 00 00 00       	mov    $0x4,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <read>:
SYSCALL(read)
 3e0:	b8 06 00 00 00       	mov    $0x6,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <write>:
SYSCALL(write)
 3e8:	b8 05 00 00 00       	mov    $0x5,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <close>:
SYSCALL(close)
 3f0:	b8 07 00 00 00       	mov    $0x7,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <kill>:
SYSCALL(kill)
 3f8:	b8 08 00 00 00       	mov    $0x8,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <exec>:
SYSCALL(exec)
 400:	b8 09 00 00 00       	mov    $0x9,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <open>:
SYSCALL(open)
 408:	b8 0a 00 00 00       	mov    $0xa,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <mknod>:
SYSCALL(mknod)
 410:	b8 0b 00 00 00       	mov    $0xb,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <unlink>:
SYSCALL(unlink)
 418:	b8 0c 00 00 00       	mov    $0xc,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <fstat>:
SYSCALL(fstat)
 420:	b8 0d 00 00 00       	mov    $0xd,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <link>:
SYSCALL(link)
 428:	b8 0e 00 00 00       	mov    $0xe,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <mkdir>:
SYSCALL(mkdir)
 430:	b8 0f 00 00 00       	mov    $0xf,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    

00000438 <chdir>:
SYSCALL(chdir)
 438:	b8 10 00 00 00       	mov    $0x10,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <dup>:
SYSCALL(dup)
 440:	b8 11 00 00 00       	mov    $0x11,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <getpid>:
SYSCALL(getpid)
 448:	b8 12 00 00 00       	mov    $0x12,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <sbrk>:
SYSCALL(sbrk)
 450:	b8 13 00 00 00       	mov    $0x13,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    

00000458 <sleep>:
SYSCALL(sleep)
 458:	b8 14 00 00 00       	mov    $0x14,%eax
 45d:	cd 40                	int    $0x40
 45f:	c3                   	ret    

00000460 <uptime>:
SYSCALL(uptime)
 460:	b8 15 00 00 00       	mov    $0x15,%eax
 465:	cd 40                	int    $0x40
 467:	c3                   	ret    

00000468 <freepages>:
// Added by Jingyue
SYSCALL(freepages)
 468:	b8 16 00 00 00       	mov    $0x16,%eax
 46d:	cd 40                	int    $0x40
 46f:	c3                   	ret    

00000470 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	83 ec 18             	sub    $0x18,%esp
 476:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 479:	8d 55 fc             	lea    -0x4(%ebp),%edx
 47c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 483:	00 
 484:	89 54 24 04          	mov    %edx,0x4(%esp)
 488:	89 04 24             	mov    %eax,(%esp)
 48b:	e8 58 ff ff ff       	call   3e8 <write>
}
 490:	c9                   	leave  
 491:	c3                   	ret    
 492:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 499:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000004a0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	57                   	push   %edi
 4a4:	56                   	push   %esi
 4a5:	89 ce                	mov    %ecx,%esi
 4a7:	53                   	push   %ebx
 4a8:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4ab:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4ae:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4b1:	85 c9                	test   %ecx,%ecx
 4b3:	74 04                	je     4b9 <printint+0x19>
 4b5:	85 d2                	test   %edx,%edx
 4b7:	78 54                	js     50d <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4b9:	89 d0                	mov    %edx,%eax
 4bb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 4c2:	31 db                	xor    %ebx,%ebx
 4c4:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 4c7:	31 d2                	xor    %edx,%edx
 4c9:	f7 f6                	div    %esi
 4cb:	89 c1                	mov    %eax,%ecx
 4cd:	0f b6 82 5f 08 00 00 	movzbl 0x85f(%edx),%eax
 4d4:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 4d7:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 4da:	85 c9                	test   %ecx,%ecx
 4dc:	89 c8                	mov    %ecx,%eax
 4de:	75 e7                	jne    4c7 <printint+0x27>
  if(neg)
 4e0:	8b 45 e0             	mov    -0x20(%ebp),%eax
 4e3:	85 c0                	test   %eax,%eax
 4e5:	74 08                	je     4ef <printint+0x4f>
    buf[i++] = '-';
 4e7:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 4ec:	83 c3 01             	add    $0x1,%ebx
 4ef:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 4f2:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 4f6:	83 eb 01             	sub    $0x1,%ebx
 4f9:	8b 45 dc             	mov    -0x24(%ebp),%eax
 4fc:	e8 6f ff ff ff       	call   470 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 501:	39 fb                	cmp    %edi,%ebx
 503:	75 ed                	jne    4f2 <printint+0x52>
    putc(fd, buf[i]);
}
 505:	83 c4 1c             	add    $0x1c,%esp
 508:	5b                   	pop    %ebx
 509:	5e                   	pop    %esi
 50a:	5f                   	pop    %edi
 50b:	5d                   	pop    %ebp
 50c:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 50d:	89 d0                	mov    %edx,%eax
 50f:	f7 d8                	neg    %eax
 511:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 518:	eb a8                	jmp    4c2 <printint+0x22>
 51a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000520 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	57                   	push   %edi
 524:	56                   	push   %esi
 525:	53                   	push   %ebx
 526:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 529:	8b 55 0c             	mov    0xc(%ebp),%edx
 52c:	0f b6 02             	movzbl (%edx),%eax
 52f:	84 c0                	test   %al,%al
 531:	0f 84 87 00 00 00    	je     5be <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 537:	8d 4d 10             	lea    0x10(%ebp),%ecx
 53a:	31 ff                	xor    %edi,%edi
 53c:	31 f6                	xor    %esi,%esi
 53e:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 541:	eb 18                	jmp    55b <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 543:	83 fb 25             	cmp    $0x25,%ebx
 546:	0f 85 7a 00 00 00    	jne    5c6 <printf+0xa6>
 54c:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 550:	83 c7 01             	add    $0x1,%edi
 553:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 557:	84 c0                	test   %al,%al
 559:	74 63                	je     5be <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 55b:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 55d:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 560:	74 e1                	je     543 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 562:	83 fe 25             	cmp    $0x25,%esi
 565:	75 e9                	jne    550 <printf+0x30>
      if(c == 'd'){
 567:	83 fb 64             	cmp    $0x64,%ebx
 56a:	0f 84 f0 00 00 00    	je     660 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 570:	83 fb 78             	cmp    $0x78,%ebx
 573:	74 64                	je     5d9 <printf+0xb9>
 575:	83 fb 70             	cmp    $0x70,%ebx
 578:	74 5f                	je     5d9 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 57a:	83 fb 73             	cmp    $0x73,%ebx
 57d:	8d 76 00             	lea    0x0(%esi),%esi
 580:	74 7e                	je     600 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 582:	83 fb 63             	cmp    $0x63,%ebx
 585:	0f 84 b9 00 00 00    	je     644 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 58b:	83 fb 25             	cmp    $0x25,%ebx
 58e:	66 90                	xchg   %ax,%ax
 590:	0f 84 f2 00 00 00    	je     688 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 596:	8b 45 08             	mov    0x8(%ebp),%eax
 599:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 59e:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 5a1:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5a3:	e8 c8 fe ff ff       	call   470 <putc>
        putc(fd, c);
 5a8:	8b 45 08             	mov    0x8(%ebp),%eax
 5ab:	0f be d3             	movsbl %bl,%edx
 5ae:	e8 bd fe ff ff       	call   470 <putc>
 5b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5b6:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 5ba:	84 c0                	test   %al,%al
 5bc:	75 9d                	jne    55b <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5be:	83 c4 0c             	add    $0xc,%esp
 5c1:	5b                   	pop    %ebx
 5c2:	5e                   	pop    %esi
 5c3:	5f                   	pop    %edi
 5c4:	5d                   	pop    %ebp
 5c5:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 5c6:	8b 45 08             	mov    0x8(%ebp),%eax
 5c9:	0f be d3             	movsbl %bl,%edx
 5cc:	e8 9f fe ff ff       	call   470 <putc>
 5d1:	8b 55 0c             	mov    0xc(%ebp),%edx
 5d4:	e9 77 ff ff ff       	jmp    550 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5dc:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 5e1:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5e3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 5ea:	8b 10                	mov    (%eax),%edx
 5ec:	8b 45 08             	mov    0x8(%ebp),%eax
 5ef:	e8 ac fe ff ff       	call   4a0 <printint>
 5f4:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 5f7:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 5fb:	e9 50 ff ff ff       	jmp    550 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 600:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 603:	8b 01                	mov    (%ecx),%eax
        ap++;
 605:	83 c1 04             	add    $0x4,%ecx
 608:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 60b:	b9 58 08 00 00       	mov    $0x858,%ecx
 610:	85 c0                	test   %eax,%eax
 612:	75 2c                	jne    640 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 614:	0f b6 01             	movzbl (%ecx),%eax
 617:	84 c0                	test   %al,%al
 619:	74 1e                	je     639 <printf+0x119>
 61b:	89 cb                	mov    %ecx,%ebx
 61d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 620:	0f be d0             	movsbl %al,%edx
 623:	8b 45 08             	mov    0x8(%ebp),%eax
 626:	e8 45 fe ff ff       	call   470 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 62b:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 62f:	83 c3 01             	add    $0x1,%ebx
 632:	84 c0                	test   %al,%al
 634:	75 ea                	jne    620 <printf+0x100>
 636:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 639:	31 f6                	xor    %esi,%esi
 63b:	e9 10 ff ff ff       	jmp    550 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 640:	89 c1                	mov    %eax,%ecx
 642:	eb d0                	jmp    614 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 644:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 647:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 649:	0f be 10             	movsbl (%eax),%edx
 64c:	8b 45 08             	mov    0x8(%ebp),%eax
 64f:	e8 1c fe ff ff       	call   470 <putc>
 654:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 657:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 65b:	e9 f0 fe ff ff       	jmp    550 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 660:	8b 45 f0             	mov    -0x10(%ebp),%eax
 663:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 668:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 66b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 672:	8b 10                	mov    (%eax),%edx
 674:	8b 45 08             	mov    0x8(%ebp),%eax
 677:	e8 24 fe ff ff       	call   4a0 <printint>
 67c:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 67f:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 683:	e9 c8 fe ff ff       	jmp    550 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 688:	8b 45 08             	mov    0x8(%ebp),%eax
 68b:	ba 25 00 00 00       	mov    $0x25,%edx
 690:	31 f6                	xor    %esi,%esi
 692:	e8 d9 fd ff ff       	call   470 <putc>
 697:	8b 55 0c             	mov    0xc(%ebp),%edx
 69a:	e9 b1 fe ff ff       	jmp    550 <printf+0x30>
 69f:	90                   	nop    

000006a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a1:	8b 0d 84 08 00 00    	mov    0x884,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 6a7:	89 e5                	mov    %esp,%ebp
 6a9:	56                   	push   %esi
 6aa:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 6ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6ae:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b1:	39 d9                	cmp    %ebx,%ecx
 6b3:	73 18                	jae    6cd <free+0x2d>
 6b5:	8b 11                	mov    (%ecx),%edx
 6b7:	39 d3                	cmp    %edx,%ebx
 6b9:	72 17                	jb     6d2 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6bb:	39 d1                	cmp    %edx,%ecx
 6bd:	72 08                	jb     6c7 <free+0x27>
 6bf:	39 d9                	cmp    %ebx,%ecx
 6c1:	72 0f                	jb     6d2 <free+0x32>
 6c3:	39 d3                	cmp    %edx,%ebx
 6c5:	72 0b                	jb     6d2 <free+0x32>
 6c7:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c9:	39 d9                	cmp    %ebx,%ecx
 6cb:	72 e8                	jb     6b5 <free+0x15>
 6cd:	8b 11                	mov    (%ecx),%edx
 6cf:	90                   	nop    
 6d0:	eb e9                	jmp    6bb <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6d2:	8b 73 04             	mov    0x4(%ebx),%esi
 6d5:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 6d8:	39 d0                	cmp    %edx,%eax
 6da:	74 18                	je     6f4 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6dc:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 6de:	8b 51 04             	mov    0x4(%ecx),%edx
 6e1:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 6e4:	39 d8                	cmp    %ebx,%eax
 6e6:	74 20                	je     708 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6e8:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 6ea:	5b                   	pop    %ebx
 6eb:	5e                   	pop    %esi
 6ec:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 6ed:	89 0d 84 08 00 00    	mov    %ecx,0x884
}
 6f3:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6f4:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 6f7:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6f9:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6fc:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 6ff:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 701:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 704:	39 d8                	cmp    %ebx,%eax
 706:	75 e0                	jne    6e8 <free+0x48>
    p->s.size += bp->s.size;
 708:	03 53 04             	add    0x4(%ebx),%edx
 70b:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 70e:	8b 13                	mov    (%ebx),%edx
 710:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 712:	5b                   	pop    %ebx
 713:	5e                   	pop    %esi
 714:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 715:	89 0d 84 08 00 00    	mov    %ecx,0x884
}
 71b:	c3                   	ret    
 71c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000720 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	57                   	push   %edi
 724:	56                   	push   %esi
 725:	53                   	push   %ebx
 726:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 729:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 72c:	8b 15 84 08 00 00    	mov    0x884,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 732:	83 c0 07             	add    $0x7,%eax
 735:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 738:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 73a:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 73d:	0f 84 8a 00 00 00    	je     7cd <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 743:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 745:	8b 41 04             	mov    0x4(%ecx),%eax
 748:	39 c3                	cmp    %eax,%ebx
 74a:	76 1a                	jbe    766 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 74c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 753:	3b 0d 84 08 00 00    	cmp    0x884,%ecx
 759:	89 ca                	mov    %ecx,%edx
 75b:	74 29                	je     786 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 75d:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 75f:	8b 41 04             	mov    0x4(%ecx),%eax
 762:	39 c3                	cmp    %eax,%ebx
 764:	77 ed                	ja     753 <malloc+0x33>
      if(p->s.size == nunits)
 766:	39 c3                	cmp    %eax,%ebx
 768:	74 5d                	je     7c7 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 76a:	29 d8                	sub    %ebx,%eax
 76c:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 76f:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 772:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 775:	89 15 84 08 00 00    	mov    %edx,0x884
      return (void*) (p + 1);
 77b:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 77e:	83 c4 0c             	add    $0xc,%esp
 781:	5b                   	pop    %ebx
 782:	5e                   	pop    %esi
 783:	5f                   	pop    %edi
 784:	5d                   	pop    %ebp
 785:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 786:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 78c:	89 de                	mov    %ebx,%esi
 78e:	89 f8                	mov    %edi,%eax
 790:	76 29                	jbe    7bb <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 792:	89 04 24             	mov    %eax,(%esp)
 795:	e8 b6 fc ff ff       	call   450 <sbrk>
  if(p == (char*) -1)
 79a:	83 f8 ff             	cmp    $0xffffffff,%eax
 79d:	74 18                	je     7b7 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 79f:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 7a2:	83 c0 08             	add    $0x8,%eax
 7a5:	89 04 24             	mov    %eax,(%esp)
 7a8:	e8 f3 fe ff ff       	call   6a0 <free>
  return freep;
 7ad:	8b 15 84 08 00 00    	mov    0x884,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 7b3:	85 d2                	test   %edx,%edx
 7b5:	75 a6                	jne    75d <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7b7:	31 c0                	xor    %eax,%eax
 7b9:	eb c3                	jmp    77e <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 7bb:	be 00 10 00 00       	mov    $0x1000,%esi
 7c0:	b8 00 80 00 00       	mov    $0x8000,%eax
 7c5:	eb cb                	jmp    792 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 7c7:	8b 01                	mov    (%ecx),%eax
 7c9:	89 02                	mov    %eax,(%edx)
 7cb:	eb a8                	jmp    775 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 7cd:	ba 7c 08 00 00       	mov    $0x87c,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 7d2:	c7 05 84 08 00 00 7c 	movl   $0x87c,0x884
 7d9:	08 00 00 
 7dc:	c7 05 7c 08 00 00 7c 	movl   $0x87c,0x87c
 7e3:	08 00 00 
    base.s.size = 0;
 7e6:	c7 05 80 08 00 00 00 	movl   $0x0,0x880
 7ed:	00 00 00 
 7f0:	e9 4e ff ff ff       	jmp    743 <malloc+0x23>
