
_zombie:     file format elf32-i386

Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
  11:	e8 1a 02 00 00       	call   230 <fork>
  16:	85 c0                	test   %eax,%eax
  18:	7e 0c                	jle    26 <main+0x26>
    sleep(5);  // Let child exit before parent.
  1a:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  21:	e8 a2 02 00 00       	call   2c8 <sleep>
  exit();
  26:	e8 0d 02 00 00       	call   238 <exit>
  2b:	90                   	nop    
  2c:	90                   	nop    
  2d:	90                   	nop    
  2e:	90                   	nop    
  2f:	90                   	nop    

00000030 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	53                   	push   %ebx
  34:	8b 5d 08             	mov    0x8(%ebp),%ebx
  37:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  3a:	89 da                	mov    %ebx,%edx
  3c:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  40:	0f b6 01             	movzbl (%ecx),%eax
  43:	83 c1 01             	add    $0x1,%ecx
  46:	88 02                	mov    %al,(%edx)
  48:	83 c2 01             	add    $0x1,%edx
  4b:	84 c0                	test   %al,%al
  4d:	75 f1                	jne    40 <strcpy+0x10>
    ;
  return os;
}
  4f:	89 d8                	mov    %ebx,%eax
  51:	5b                   	pop    %ebx
  52:	5d                   	pop    %ebp
  53:	c3                   	ret    
  54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	8b 4d 08             	mov    0x8(%ebp),%ecx
  66:	53                   	push   %ebx
  67:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  6a:	0f b6 01             	movzbl (%ecx),%eax
  6d:	84 c0                	test   %al,%al
  6f:	74 24                	je     95 <strcmp+0x35>
  71:	0f b6 13             	movzbl (%ebx),%edx
  74:	38 d0                	cmp    %dl,%al
  76:	74 12                	je     8a <strcmp+0x2a>
  78:	eb 1e                	jmp    98 <strcmp+0x38>
  7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  80:	0f b6 13             	movzbl (%ebx),%edx
  83:	83 c1 01             	add    $0x1,%ecx
  86:	38 d0                	cmp    %dl,%al
  88:	75 0e                	jne    98 <strcmp+0x38>
  8a:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
  8e:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  91:	84 c0                	test   %al,%al
  93:	75 eb                	jne    80 <strcmp+0x20>
  95:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  98:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  99:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  9c:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  9d:	0f b6 d2             	movzbl %dl,%edx
  a0:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  a2:	c3                   	ret    
  a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000000b0 <strlen>:

uint
strlen(char *s)
{
  b0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
  b1:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
  b3:	89 e5                	mov    %esp,%ebp
  b5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  b8:	80 39 00             	cmpb   $0x0,(%ecx)
  bb:	74 0e                	je     cb <strlen+0x1b>
  bd:	31 d2                	xor    %edx,%edx
  bf:	90                   	nop    
  c0:	83 c2 01             	add    $0x1,%edx
  c3:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
  c7:	89 d0                	mov    %edx,%eax
  c9:	75 f5                	jne    c0 <strlen+0x10>
    ;
  return n;
}
  cb:	5d                   	pop    %ebp
  cc:	c3                   	ret    
  cd:	8d 76 00             	lea    0x0(%esi),%esi

000000d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	8b 55 08             	mov    0x8(%ebp),%edx
  d6:	57                   	push   %edi
  d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  da:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  dd:	89 d7                	mov    %edx,%edi
  df:	fc                   	cld    
  e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  e2:	5f                   	pop    %edi
  e3:	89 d0                	mov    %edx,%eax
  e5:	5d                   	pop    %ebp
  e6:	c3                   	ret    
  e7:	89 f6                	mov    %esi,%esi
  e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000000f0 <strchr>:

char*
strchr(const char *s, char c)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	8b 45 08             	mov    0x8(%ebp),%eax
  f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
  fa:	0f b6 10             	movzbl (%eax),%edx
  fd:	84 d2                	test   %dl,%dl
  ff:	75 0c                	jne    10d <strchr+0x1d>
 101:	eb 11                	jmp    114 <strchr+0x24>
 103:	83 c0 01             	add    $0x1,%eax
 106:	0f b6 10             	movzbl (%eax),%edx
 109:	84 d2                	test   %dl,%dl
 10b:	74 07                	je     114 <strchr+0x24>
    if(*s == c)
 10d:	38 ca                	cmp    %cl,%dl
 10f:	90                   	nop    
 110:	75 f1                	jne    103 <strchr+0x13>
      return (char*) s;
  return 0;
}
 112:	5d                   	pop    %ebp
 113:	c3                   	ret    
 114:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 115:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 117:	c3                   	ret    
 118:	90                   	nop    
 119:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000120 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	8b 4d 08             	mov    0x8(%ebp),%ecx
 126:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 127:	31 db                	xor    %ebx,%ebx
 129:	0f b6 11             	movzbl (%ecx),%edx
 12c:	8d 42 d0             	lea    -0x30(%edx),%eax
 12f:	3c 09                	cmp    $0x9,%al
 131:	77 18                	ja     14b <atoi+0x2b>
    n = n*10 + *s++ - '0';
 133:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 136:	0f be d2             	movsbl %dl,%edx
 139:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 13d:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 141:	83 c1 01             	add    $0x1,%ecx
 144:	8d 42 d0             	lea    -0x30(%edx),%eax
 147:	3c 09                	cmp    $0x9,%al
 149:	76 e8                	jbe    133 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 14b:	89 d8                	mov    %ebx,%eax
 14d:	5b                   	pop    %ebx
 14e:	5d                   	pop    %ebp
 14f:	c3                   	ret    

00000150 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	8b 4d 10             	mov    0x10(%ebp),%ecx
 156:	56                   	push   %esi
 157:	8b 75 08             	mov    0x8(%ebp),%esi
 15a:	53                   	push   %ebx
 15b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 15e:	85 c9                	test   %ecx,%ecx
 160:	7e 10                	jle    172 <memmove+0x22>
 162:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 164:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 168:	88 04 32             	mov    %al,(%edx,%esi,1)
 16b:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 16e:	39 ca                	cmp    %ecx,%edx
 170:	75 f2                	jne    164 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 172:	89 f0                	mov    %esi,%eax
 174:	5b                   	pop    %ebx
 175:	5e                   	pop    %esi
 176:	5d                   	pop    %ebp
 177:	c3                   	ret    
 178:	90                   	nop    
 179:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000180 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 186:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 189:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 18c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 18f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 194:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 19b:	00 
 19c:	89 04 24             	mov    %eax,(%esp)
 19f:	e8 d4 00 00 00       	call   278 <open>
  if(fd < 0)
 1a4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1a6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 1a8:	78 19                	js     1c3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 1aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ad:	89 1c 24             	mov    %ebx,(%esp)
 1b0:	89 44 24 04          	mov    %eax,0x4(%esp)
 1b4:	e8 d7 00 00 00       	call   290 <fstat>
  close(fd);
 1b9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 1bc:	89 c6                	mov    %eax,%esi
  close(fd);
 1be:	e8 9d 00 00 00       	call   260 <close>
  return r;
}
 1c3:	89 f0                	mov    %esi,%eax
 1c5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 1c8:	8b 75 fc             	mov    -0x4(%ebp),%esi
 1cb:	89 ec                	mov    %ebp,%esp
 1cd:	5d                   	pop    %ebp
 1ce:	c3                   	ret    
 1cf:	90                   	nop    

000001d0 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	57                   	push   %edi
 1d4:	56                   	push   %esi
 1d5:	31 f6                	xor    %esi,%esi
 1d7:	53                   	push   %ebx
 1d8:	83 ec 1c             	sub    $0x1c,%esp
 1db:	8b 7d 08             	mov    0x8(%ebp),%edi
 1de:	eb 06                	jmp    1e6 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1e0:	3c 0d                	cmp    $0xd,%al
 1e2:	74 39                	je     21d <gets+0x4d>
 1e4:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e6:	8d 5e 01             	lea    0x1(%esi),%ebx
 1e9:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1ec:	7d 31                	jge    21f <gets+0x4f>
    cc = read(0, &c, 1);
 1ee:	8d 45 f3             	lea    -0xd(%ebp),%eax
 1f1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1f8:	00 
 1f9:	89 44 24 04          	mov    %eax,0x4(%esp)
 1fd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 204:	e8 47 00 00 00       	call   250 <read>
    if(cc < 1)
 209:	85 c0                	test   %eax,%eax
 20b:	7e 12                	jle    21f <gets+0x4f>
      break;
    buf[i++] = c;
 20d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 211:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 215:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 219:	3c 0a                	cmp    $0xa,%al
 21b:	75 c3                	jne    1e0 <gets+0x10>
 21d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 21f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 223:	89 f8                	mov    %edi,%eax
 225:	83 c4 1c             	add    $0x1c,%esp
 228:	5b                   	pop    %ebx
 229:	5e                   	pop    %esi
 22a:	5f                   	pop    %edi
 22b:	5d                   	pop    %ebp
 22c:	c3                   	ret    
 22d:	90                   	nop    
 22e:	90                   	nop    
 22f:	90                   	nop    

00000230 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 230:	b8 01 00 00 00       	mov    $0x1,%eax
 235:	cd 40                	int    $0x40
 237:	c3                   	ret    

00000238 <exit>:
SYSCALL(exit)
 238:	b8 02 00 00 00       	mov    $0x2,%eax
 23d:	cd 40                	int    $0x40
 23f:	c3                   	ret    

00000240 <wait>:
SYSCALL(wait)
 240:	b8 03 00 00 00       	mov    $0x3,%eax
 245:	cd 40                	int    $0x40
 247:	c3                   	ret    

00000248 <pipe>:
SYSCALL(pipe)
 248:	b8 04 00 00 00       	mov    $0x4,%eax
 24d:	cd 40                	int    $0x40
 24f:	c3                   	ret    

00000250 <read>:
SYSCALL(read)
 250:	b8 06 00 00 00       	mov    $0x6,%eax
 255:	cd 40                	int    $0x40
 257:	c3                   	ret    

00000258 <write>:
SYSCALL(write)
 258:	b8 05 00 00 00       	mov    $0x5,%eax
 25d:	cd 40                	int    $0x40
 25f:	c3                   	ret    

00000260 <close>:
SYSCALL(close)
 260:	b8 07 00 00 00       	mov    $0x7,%eax
 265:	cd 40                	int    $0x40
 267:	c3                   	ret    

00000268 <kill>:
SYSCALL(kill)
 268:	b8 08 00 00 00       	mov    $0x8,%eax
 26d:	cd 40                	int    $0x40
 26f:	c3                   	ret    

00000270 <exec>:
SYSCALL(exec)
 270:	b8 09 00 00 00       	mov    $0x9,%eax
 275:	cd 40                	int    $0x40
 277:	c3                   	ret    

00000278 <open>:
SYSCALL(open)
 278:	b8 0a 00 00 00       	mov    $0xa,%eax
 27d:	cd 40                	int    $0x40
 27f:	c3                   	ret    

00000280 <mknod>:
SYSCALL(mknod)
 280:	b8 0b 00 00 00       	mov    $0xb,%eax
 285:	cd 40                	int    $0x40
 287:	c3                   	ret    

00000288 <unlink>:
SYSCALL(unlink)
 288:	b8 0c 00 00 00       	mov    $0xc,%eax
 28d:	cd 40                	int    $0x40
 28f:	c3                   	ret    

00000290 <fstat>:
SYSCALL(fstat)
 290:	b8 0d 00 00 00       	mov    $0xd,%eax
 295:	cd 40                	int    $0x40
 297:	c3                   	ret    

00000298 <link>:
SYSCALL(link)
 298:	b8 0e 00 00 00       	mov    $0xe,%eax
 29d:	cd 40                	int    $0x40
 29f:	c3                   	ret    

000002a0 <mkdir>:
SYSCALL(mkdir)
 2a0:	b8 0f 00 00 00       	mov    $0xf,%eax
 2a5:	cd 40                	int    $0x40
 2a7:	c3                   	ret    

000002a8 <chdir>:
SYSCALL(chdir)
 2a8:	b8 10 00 00 00       	mov    $0x10,%eax
 2ad:	cd 40                	int    $0x40
 2af:	c3                   	ret    

000002b0 <dup>:
SYSCALL(dup)
 2b0:	b8 11 00 00 00       	mov    $0x11,%eax
 2b5:	cd 40                	int    $0x40
 2b7:	c3                   	ret    

000002b8 <getpid>:
SYSCALL(getpid)
 2b8:	b8 12 00 00 00       	mov    $0x12,%eax
 2bd:	cd 40                	int    $0x40
 2bf:	c3                   	ret    

000002c0 <sbrk>:
SYSCALL(sbrk)
 2c0:	b8 13 00 00 00       	mov    $0x13,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <sleep>:
SYSCALL(sleep)
 2c8:	b8 14 00 00 00       	mov    $0x14,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <uptime>:
SYSCALL(uptime)
 2d0:	b8 15 00 00 00       	mov    $0x15,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <freepages>:
// Added by Jingyue
SYSCALL(freepages)
 2d8:	b8 16 00 00 00       	mov    $0x16,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	83 ec 18             	sub    $0x18,%esp
 2e6:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 2e9:	8d 55 fc             	lea    -0x4(%ebp),%edx
 2ec:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2f3:	00 
 2f4:	89 54 24 04          	mov    %edx,0x4(%esp)
 2f8:	89 04 24             	mov    %eax,(%esp)
 2fb:	e8 58 ff ff ff       	call   258 <write>
}
 300:	c9                   	leave  
 301:	c3                   	ret    
 302:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 309:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000310 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	57                   	push   %edi
 314:	56                   	push   %esi
 315:	89 ce                	mov    %ecx,%esi
 317:	53                   	push   %ebx
 318:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 31b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 31e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 321:	85 c9                	test   %ecx,%ecx
 323:	74 04                	je     329 <printint+0x19>
 325:	85 d2                	test   %edx,%edx
 327:	78 54                	js     37d <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 329:	89 d0                	mov    %edx,%eax
 32b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 332:	31 db                	xor    %ebx,%ebx
 334:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 337:	31 d2                	xor    %edx,%edx
 339:	f7 f6                	div    %esi
 33b:	89 c1                	mov    %eax,%ecx
 33d:	0f b6 82 6c 06 00 00 	movzbl 0x66c(%edx),%eax
 344:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 347:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 34a:	85 c9                	test   %ecx,%ecx
 34c:	89 c8                	mov    %ecx,%eax
 34e:	75 e7                	jne    337 <printint+0x27>
  if(neg)
 350:	8b 45 e0             	mov    -0x20(%ebp),%eax
 353:	85 c0                	test   %eax,%eax
 355:	74 08                	je     35f <printint+0x4f>
    buf[i++] = '-';
 357:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 35c:	83 c3 01             	add    $0x1,%ebx
 35f:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 362:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 366:	83 eb 01             	sub    $0x1,%ebx
 369:	8b 45 dc             	mov    -0x24(%ebp),%eax
 36c:	e8 6f ff ff ff       	call   2e0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 371:	39 fb                	cmp    %edi,%ebx
 373:	75 ed                	jne    362 <printint+0x52>
    putc(fd, buf[i]);
}
 375:	83 c4 1c             	add    $0x1c,%esp
 378:	5b                   	pop    %ebx
 379:	5e                   	pop    %esi
 37a:	5f                   	pop    %edi
 37b:	5d                   	pop    %ebp
 37c:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 37d:	89 d0                	mov    %edx,%eax
 37f:	f7 d8                	neg    %eax
 381:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 388:	eb a8                	jmp    332 <printint+0x22>
 38a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000390 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	57                   	push   %edi
 394:	56                   	push   %esi
 395:	53                   	push   %ebx
 396:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 399:	8b 55 0c             	mov    0xc(%ebp),%edx
 39c:	0f b6 02             	movzbl (%edx),%eax
 39f:	84 c0                	test   %al,%al
 3a1:	0f 84 87 00 00 00    	je     42e <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 3a7:	8d 4d 10             	lea    0x10(%ebp),%ecx
 3aa:	31 ff                	xor    %edi,%edi
 3ac:	31 f6                	xor    %esi,%esi
 3ae:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 3b1:	eb 18                	jmp    3cb <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3b3:	83 fb 25             	cmp    $0x25,%ebx
 3b6:	0f 85 7a 00 00 00    	jne    436 <printf+0xa6>
 3bc:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3c0:	83 c7 01             	add    $0x1,%edi
 3c3:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 3c7:	84 c0                	test   %al,%al
 3c9:	74 63                	je     42e <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 3cb:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 3cd:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 3d0:	74 e1                	je     3b3 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 3d2:	83 fe 25             	cmp    $0x25,%esi
 3d5:	75 e9                	jne    3c0 <printf+0x30>
      if(c == 'd'){
 3d7:	83 fb 64             	cmp    $0x64,%ebx
 3da:	0f 84 f0 00 00 00    	je     4d0 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 3e0:	83 fb 78             	cmp    $0x78,%ebx
 3e3:	74 64                	je     449 <printf+0xb9>
 3e5:	83 fb 70             	cmp    $0x70,%ebx
 3e8:	74 5f                	je     449 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 3ea:	83 fb 73             	cmp    $0x73,%ebx
 3ed:	8d 76 00             	lea    0x0(%esi),%esi
 3f0:	74 7e                	je     470 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 3f2:	83 fb 63             	cmp    $0x63,%ebx
 3f5:	0f 84 b9 00 00 00    	je     4b4 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3fb:	83 fb 25             	cmp    $0x25,%ebx
 3fe:	66 90                	xchg   %ax,%ax
 400:	0f 84 f2 00 00 00    	je     4f8 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 406:	8b 45 08             	mov    0x8(%ebp),%eax
 409:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 40e:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 411:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 413:	e8 c8 fe ff ff       	call   2e0 <putc>
        putc(fd, c);
 418:	8b 45 08             	mov    0x8(%ebp),%eax
 41b:	0f be d3             	movsbl %bl,%edx
 41e:	e8 bd fe ff ff       	call   2e0 <putc>
 423:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 426:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 42a:	84 c0                	test   %al,%al
 42c:	75 9d                	jne    3cb <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 42e:	83 c4 0c             	add    $0xc,%esp
 431:	5b                   	pop    %ebx
 432:	5e                   	pop    %esi
 433:	5f                   	pop    %edi
 434:	5d                   	pop    %ebp
 435:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 436:	8b 45 08             	mov    0x8(%ebp),%eax
 439:	0f be d3             	movsbl %bl,%edx
 43c:	e8 9f fe ff ff       	call   2e0 <putc>
 441:	8b 55 0c             	mov    0xc(%ebp),%edx
 444:	e9 77 ff ff ff       	jmp    3c0 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 449:	8b 45 f0             	mov    -0x10(%ebp),%eax
 44c:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 451:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 453:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 45a:	8b 10                	mov    (%eax),%edx
 45c:	8b 45 08             	mov    0x8(%ebp),%eax
 45f:	e8 ac fe ff ff       	call   310 <printint>
 464:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 467:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 46b:	e9 50 ff ff ff       	jmp    3c0 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 470:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 473:	8b 01                	mov    (%ecx),%eax
        ap++;
 475:	83 c1 04             	add    $0x4,%ecx
 478:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 47b:	b9 65 06 00 00       	mov    $0x665,%ecx
 480:	85 c0                	test   %eax,%eax
 482:	75 2c                	jne    4b0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 484:	0f b6 01             	movzbl (%ecx),%eax
 487:	84 c0                	test   %al,%al
 489:	74 1e                	je     4a9 <printf+0x119>
 48b:	89 cb                	mov    %ecx,%ebx
 48d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 490:	0f be d0             	movsbl %al,%edx
 493:	8b 45 08             	mov    0x8(%ebp),%eax
 496:	e8 45 fe ff ff       	call   2e0 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 49b:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 49f:	83 c3 01             	add    $0x1,%ebx
 4a2:	84 c0                	test   %al,%al
 4a4:	75 ea                	jne    490 <printf+0x100>
 4a6:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4a9:	31 f6                	xor    %esi,%esi
 4ab:	e9 10 ff ff ff       	jmp    3c0 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 4b0:	89 c1                	mov    %eax,%ecx
 4b2:	eb d0                	jmp    484 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 4b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 4b7:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 4b9:	0f be 10             	movsbl (%eax),%edx
 4bc:	8b 45 08             	mov    0x8(%ebp),%eax
 4bf:	e8 1c fe ff ff       	call   2e0 <putc>
 4c4:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 4c7:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 4cb:	e9 f0 fe ff ff       	jmp    3c0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 4d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 4d8:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 4db:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 4e2:	8b 10                	mov    (%eax),%edx
 4e4:	8b 45 08             	mov    0x8(%ebp),%eax
 4e7:	e8 24 fe ff ff       	call   310 <printint>
 4ec:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 4ef:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 4f3:	e9 c8 fe ff ff       	jmp    3c0 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 4f8:	8b 45 08             	mov    0x8(%ebp),%eax
 4fb:	ba 25 00 00 00       	mov    $0x25,%edx
 500:	31 f6                	xor    %esi,%esi
 502:	e8 d9 fd ff ff       	call   2e0 <putc>
 507:	8b 55 0c             	mov    0xc(%ebp),%edx
 50a:	e9 b1 fe ff ff       	jmp    3c0 <printf+0x30>
 50f:	90                   	nop    

00000510 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 510:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 511:	8b 0d 88 06 00 00    	mov    0x688,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 517:	89 e5                	mov    %esp,%ebp
 519:	56                   	push   %esi
 51a:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 51b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 51e:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 521:	39 d9                	cmp    %ebx,%ecx
 523:	73 18                	jae    53d <free+0x2d>
 525:	8b 11                	mov    (%ecx),%edx
 527:	39 d3                	cmp    %edx,%ebx
 529:	72 17                	jb     542 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 52b:	39 d1                	cmp    %edx,%ecx
 52d:	72 08                	jb     537 <free+0x27>
 52f:	39 d9                	cmp    %ebx,%ecx
 531:	72 0f                	jb     542 <free+0x32>
 533:	39 d3                	cmp    %edx,%ebx
 535:	72 0b                	jb     542 <free+0x32>
 537:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 539:	39 d9                	cmp    %ebx,%ecx
 53b:	72 e8                	jb     525 <free+0x15>
 53d:	8b 11                	mov    (%ecx),%edx
 53f:	90                   	nop    
 540:	eb e9                	jmp    52b <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 542:	8b 73 04             	mov    0x4(%ebx),%esi
 545:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 548:	39 d0                	cmp    %edx,%eax
 54a:	74 18                	je     564 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 54c:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 54e:	8b 51 04             	mov    0x4(%ecx),%edx
 551:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 554:	39 d8                	cmp    %ebx,%eax
 556:	74 20                	je     578 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 558:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 55a:	5b                   	pop    %ebx
 55b:	5e                   	pop    %esi
 55c:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 55d:	89 0d 88 06 00 00    	mov    %ecx,0x688
}
 563:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 564:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 567:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 569:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 56c:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 56f:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 571:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 574:	39 d8                	cmp    %ebx,%eax
 576:	75 e0                	jne    558 <free+0x48>
    p->s.size += bp->s.size;
 578:	03 53 04             	add    0x4(%ebx),%edx
 57b:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 57e:	8b 13                	mov    (%ebx),%edx
 580:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 582:	5b                   	pop    %ebx
 583:	5e                   	pop    %esi
 584:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 585:	89 0d 88 06 00 00    	mov    %ecx,0x688
}
 58b:	c3                   	ret    
 58c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000590 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	57                   	push   %edi
 594:	56                   	push   %esi
 595:	53                   	push   %ebx
 596:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 599:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 59c:	8b 15 88 06 00 00    	mov    0x688,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5a2:	83 c0 07             	add    $0x7,%eax
 5a5:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 5a8:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5aa:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 5ad:	0f 84 8a 00 00 00    	je     63d <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5b3:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 5b5:	8b 41 04             	mov    0x4(%ecx),%eax
 5b8:	39 c3                	cmp    %eax,%ebx
 5ba:	76 1a                	jbe    5d6 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 5bc:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 5c3:	3b 0d 88 06 00 00    	cmp    0x688,%ecx
 5c9:	89 ca                	mov    %ecx,%edx
 5cb:	74 29                	je     5f6 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5cd:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 5cf:	8b 41 04             	mov    0x4(%ecx),%eax
 5d2:	39 c3                	cmp    %eax,%ebx
 5d4:	77 ed                	ja     5c3 <malloc+0x33>
      if(p->s.size == nunits)
 5d6:	39 c3                	cmp    %eax,%ebx
 5d8:	74 5d                	je     637 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 5da:	29 d8                	sub    %ebx,%eax
 5dc:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 5df:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 5e2:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 5e5:	89 15 88 06 00 00    	mov    %edx,0x688
      return (void*) (p + 1);
 5eb:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 5ee:	83 c4 0c             	add    $0xc,%esp
 5f1:	5b                   	pop    %ebx
 5f2:	5e                   	pop    %esi
 5f3:	5f                   	pop    %edi
 5f4:	5d                   	pop    %ebp
 5f5:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 5f6:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 5fc:	89 de                	mov    %ebx,%esi
 5fe:	89 f8                	mov    %edi,%eax
 600:	76 29                	jbe    62b <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 602:	89 04 24             	mov    %eax,(%esp)
 605:	e8 b6 fc ff ff       	call   2c0 <sbrk>
  if(p == (char*) -1)
 60a:	83 f8 ff             	cmp    $0xffffffff,%eax
 60d:	74 18                	je     627 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 60f:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 612:	83 c0 08             	add    $0x8,%eax
 615:	89 04 24             	mov    %eax,(%esp)
 618:	e8 f3 fe ff ff       	call   510 <free>
  return freep;
 61d:	8b 15 88 06 00 00    	mov    0x688,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 623:	85 d2                	test   %edx,%edx
 625:	75 a6                	jne    5cd <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 627:	31 c0                	xor    %eax,%eax
 629:	eb c3                	jmp    5ee <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 62b:	be 00 10 00 00       	mov    $0x1000,%esi
 630:	b8 00 80 00 00       	mov    $0x8000,%eax
 635:	eb cb                	jmp    602 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 637:	8b 01                	mov    (%ecx),%eax
 639:	89 02                	mov    %eax,(%edx)
 63b:	eb a8                	jmp    5e5 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 63d:	ba 80 06 00 00       	mov    $0x680,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 642:	c7 05 88 06 00 00 80 	movl   $0x680,0x688
 649:	06 00 00 
 64c:	c7 05 80 06 00 00 80 	movl   $0x680,0x680
 653:	06 00 00 
    base.s.size = 0;
 656:	c7 05 84 06 00 00 00 	movl   $0x0,0x684
 65d:	00 00 00 
 660:	e9 4e ff ff ff       	jmp    5b3 <malloc+0x23>
