
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

000002d8 <pschk>:
SYSCALL(pschk)
 2d8:	b8 17 00 00 00       	mov    $0x17,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <rwlock>:
SYSCALL(rwlock)
 2e0:	b8 16 00 00 00       	mov    $0x16,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <tfork>:
SYSCALL(tfork)
 2e8:	b8 18 00 00 00       	mov    $0x18,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <texit>:
SYSCALL(texit)
 2f0:	b8 19 00 00 00       	mov    $0x19,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <twait>:
SYSCALL(twait)
 2f8:	b8 1a 00 00 00       	mov    $0x1a,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	83 ec 18             	sub    $0x18,%esp
 306:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 309:	8d 55 fc             	lea    -0x4(%ebp),%edx
 30c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 313:	00 
 314:	89 54 24 04          	mov    %edx,0x4(%esp)
 318:	89 04 24             	mov    %eax,(%esp)
 31b:	e8 38 ff ff ff       	call   258 <write>
}
 320:	c9                   	leave  
 321:	c3                   	ret    
 322:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 329:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000330 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	57                   	push   %edi
 334:	56                   	push   %esi
 335:	89 ce                	mov    %ecx,%esi
 337:	53                   	push   %ebx
 338:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 33b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 33e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 341:	85 c9                	test   %ecx,%ecx
 343:	74 04                	je     349 <printint+0x19>
 345:	85 d2                	test   %edx,%edx
 347:	78 54                	js     39d <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 349:	89 d0                	mov    %edx,%eax
 34b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 352:	31 db                	xor    %ebx,%ebx
 354:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 357:	31 d2                	xor    %edx,%edx
 359:	f7 f6                	div    %esi
 35b:	89 c1                	mov    %eax,%ecx
 35d:	0f b6 82 8c 06 00 00 	movzbl 0x68c(%edx),%eax
 364:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 367:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 36a:	85 c9                	test   %ecx,%ecx
 36c:	89 c8                	mov    %ecx,%eax
 36e:	75 e7                	jne    357 <printint+0x27>
  if(neg)
 370:	8b 45 e0             	mov    -0x20(%ebp),%eax
 373:	85 c0                	test   %eax,%eax
 375:	74 08                	je     37f <printint+0x4f>
    buf[i++] = '-';
 377:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 37c:	83 c3 01             	add    $0x1,%ebx
 37f:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 382:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 386:	83 eb 01             	sub    $0x1,%ebx
 389:	8b 45 dc             	mov    -0x24(%ebp),%eax
 38c:	e8 6f ff ff ff       	call   300 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 391:	39 fb                	cmp    %edi,%ebx
 393:	75 ed                	jne    382 <printint+0x52>
    putc(fd, buf[i]);
}
 395:	83 c4 1c             	add    $0x1c,%esp
 398:	5b                   	pop    %ebx
 399:	5e                   	pop    %esi
 39a:	5f                   	pop    %edi
 39b:	5d                   	pop    %ebp
 39c:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 39d:	89 d0                	mov    %edx,%eax
 39f:	f7 d8                	neg    %eax
 3a1:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 3a8:	eb a8                	jmp    352 <printint+0x22>
 3aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003b0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	57                   	push   %edi
 3b4:	56                   	push   %esi
 3b5:	53                   	push   %ebx
 3b6:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3b9:	8b 55 0c             	mov    0xc(%ebp),%edx
 3bc:	0f b6 02             	movzbl (%edx),%eax
 3bf:	84 c0                	test   %al,%al
 3c1:	0f 84 87 00 00 00    	je     44e <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 3c7:	8d 4d 10             	lea    0x10(%ebp),%ecx
 3ca:	31 ff                	xor    %edi,%edi
 3cc:	31 f6                	xor    %esi,%esi
 3ce:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 3d1:	eb 18                	jmp    3eb <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3d3:	83 fb 25             	cmp    $0x25,%ebx
 3d6:	0f 85 7a 00 00 00    	jne    456 <printf+0xa6>
 3dc:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3e0:	83 c7 01             	add    $0x1,%edi
 3e3:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 3e7:	84 c0                	test   %al,%al
 3e9:	74 63                	je     44e <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 3eb:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 3ed:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 3f0:	74 e1                	je     3d3 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 3f2:	83 fe 25             	cmp    $0x25,%esi
 3f5:	75 e9                	jne    3e0 <printf+0x30>
      if(c == 'd'){
 3f7:	83 fb 64             	cmp    $0x64,%ebx
 3fa:	0f 84 f0 00 00 00    	je     4f0 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 400:	83 fb 78             	cmp    $0x78,%ebx
 403:	74 64                	je     469 <printf+0xb9>
 405:	83 fb 70             	cmp    $0x70,%ebx
 408:	74 5f                	je     469 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 40a:	83 fb 73             	cmp    $0x73,%ebx
 40d:	8d 76 00             	lea    0x0(%esi),%esi
 410:	74 7e                	je     490 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 412:	83 fb 63             	cmp    $0x63,%ebx
 415:	0f 84 b9 00 00 00    	je     4d4 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 41b:	83 fb 25             	cmp    $0x25,%ebx
 41e:	66 90                	xchg   %ax,%ax
 420:	0f 84 f2 00 00 00    	je     518 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 426:	8b 45 08             	mov    0x8(%ebp),%eax
 429:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 42e:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 431:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 433:	e8 c8 fe ff ff       	call   300 <putc>
        putc(fd, c);
 438:	8b 45 08             	mov    0x8(%ebp),%eax
 43b:	0f be d3             	movsbl %bl,%edx
 43e:	e8 bd fe ff ff       	call   300 <putc>
 443:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 446:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 44a:	84 c0                	test   %al,%al
 44c:	75 9d                	jne    3eb <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 44e:	83 c4 0c             	add    $0xc,%esp
 451:	5b                   	pop    %ebx
 452:	5e                   	pop    %esi
 453:	5f                   	pop    %edi
 454:	5d                   	pop    %ebp
 455:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 456:	8b 45 08             	mov    0x8(%ebp),%eax
 459:	0f be d3             	movsbl %bl,%edx
 45c:	e8 9f fe ff ff       	call   300 <putc>
 461:	8b 55 0c             	mov    0xc(%ebp),%edx
 464:	e9 77 ff ff ff       	jmp    3e0 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 469:	8b 45 f0             	mov    -0x10(%ebp),%eax
 46c:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 471:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 473:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 47a:	8b 10                	mov    (%eax),%edx
 47c:	8b 45 08             	mov    0x8(%ebp),%eax
 47f:	e8 ac fe ff ff       	call   330 <printint>
 484:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 487:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 48b:	e9 50 ff ff ff       	jmp    3e0 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 490:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 493:	8b 01                	mov    (%ecx),%eax
        ap++;
 495:	83 c1 04             	add    $0x4,%ecx
 498:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 49b:	b9 85 06 00 00       	mov    $0x685,%ecx
 4a0:	85 c0                	test   %eax,%eax
 4a2:	75 2c                	jne    4d0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 4a4:	0f b6 01             	movzbl (%ecx),%eax
 4a7:	84 c0                	test   %al,%al
 4a9:	74 1e                	je     4c9 <printf+0x119>
 4ab:	89 cb                	mov    %ecx,%ebx
 4ad:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 4b0:	0f be d0             	movsbl %al,%edx
 4b3:	8b 45 08             	mov    0x8(%ebp),%eax
 4b6:	e8 45 fe ff ff       	call   300 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 4bb:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 4bf:	83 c3 01             	add    $0x1,%ebx
 4c2:	84 c0                	test   %al,%al
 4c4:	75 ea                	jne    4b0 <printf+0x100>
 4c6:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4c9:	31 f6                	xor    %esi,%esi
 4cb:	e9 10 ff ff ff       	jmp    3e0 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 4d0:	89 c1                	mov    %eax,%ecx
 4d2:	eb d0                	jmp    4a4 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 4d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 4d7:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 4d9:	0f be 10             	movsbl (%eax),%edx
 4dc:	8b 45 08             	mov    0x8(%ebp),%eax
 4df:	e8 1c fe ff ff       	call   300 <putc>
 4e4:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 4e7:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 4eb:	e9 f0 fe ff ff       	jmp    3e0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 4f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4f3:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 4f8:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 4fb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 502:	8b 10                	mov    (%eax),%edx
 504:	8b 45 08             	mov    0x8(%ebp),%eax
 507:	e8 24 fe ff ff       	call   330 <printint>
 50c:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 50f:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 513:	e9 c8 fe ff ff       	jmp    3e0 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 518:	8b 45 08             	mov    0x8(%ebp),%eax
 51b:	ba 25 00 00 00       	mov    $0x25,%edx
 520:	31 f6                	xor    %esi,%esi
 522:	e8 d9 fd ff ff       	call   300 <putc>
 527:	8b 55 0c             	mov    0xc(%ebp),%edx
 52a:	e9 b1 fe ff ff       	jmp    3e0 <printf+0x30>
 52f:	90                   	nop    

00000530 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 530:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 531:	8b 0d a8 06 00 00    	mov    0x6a8,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 537:	89 e5                	mov    %esp,%ebp
 539:	56                   	push   %esi
 53a:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 53b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 53e:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 541:	39 d9                	cmp    %ebx,%ecx
 543:	73 18                	jae    55d <free+0x2d>
 545:	8b 11                	mov    (%ecx),%edx
 547:	39 d3                	cmp    %edx,%ebx
 549:	72 17                	jb     562 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 54b:	39 d1                	cmp    %edx,%ecx
 54d:	72 08                	jb     557 <free+0x27>
 54f:	39 d9                	cmp    %ebx,%ecx
 551:	72 0f                	jb     562 <free+0x32>
 553:	39 d3                	cmp    %edx,%ebx
 555:	72 0b                	jb     562 <free+0x32>
 557:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 559:	39 d9                	cmp    %ebx,%ecx
 55b:	72 e8                	jb     545 <free+0x15>
 55d:	8b 11                	mov    (%ecx),%edx
 55f:	90                   	nop    
 560:	eb e9                	jmp    54b <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 562:	8b 73 04             	mov    0x4(%ebx),%esi
 565:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 568:	39 d0                	cmp    %edx,%eax
 56a:	74 18                	je     584 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 56c:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 56e:	8b 51 04             	mov    0x4(%ecx),%edx
 571:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 574:	39 d8                	cmp    %ebx,%eax
 576:	74 20                	je     598 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 578:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 57a:	5b                   	pop    %ebx
 57b:	5e                   	pop    %esi
 57c:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 57d:	89 0d a8 06 00 00    	mov    %ecx,0x6a8
}
 583:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 584:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 587:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 589:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 58c:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 58f:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 591:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 594:	39 d8                	cmp    %ebx,%eax
 596:	75 e0                	jne    578 <free+0x48>
    p->s.size += bp->s.size;
 598:	03 53 04             	add    0x4(%ebx),%edx
 59b:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 59e:	8b 13                	mov    (%ebx),%edx
 5a0:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 5a2:	5b                   	pop    %ebx
 5a3:	5e                   	pop    %esi
 5a4:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 5a5:	89 0d a8 06 00 00    	mov    %ecx,0x6a8
}
 5ab:	c3                   	ret    
 5ac:	8d 74 26 00          	lea    0x0(%esi),%esi

000005b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	57                   	push   %edi
 5b4:	56                   	push   %esi
 5b5:	53                   	push   %ebx
 5b6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 5bc:	8b 15 a8 06 00 00    	mov    0x6a8,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5c2:	83 c0 07             	add    $0x7,%eax
 5c5:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 5c8:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5ca:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 5cd:	0f 84 8a 00 00 00    	je     65d <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5d3:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 5d5:	8b 41 04             	mov    0x4(%ecx),%eax
 5d8:	39 c3                	cmp    %eax,%ebx
 5da:	76 1a                	jbe    5f6 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 5dc:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 5e3:	3b 0d a8 06 00 00    	cmp    0x6a8,%ecx
 5e9:	89 ca                	mov    %ecx,%edx
 5eb:	74 29                	je     616 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5ed:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 5ef:	8b 41 04             	mov    0x4(%ecx),%eax
 5f2:	39 c3                	cmp    %eax,%ebx
 5f4:	77 ed                	ja     5e3 <malloc+0x33>
      if(p->s.size == nunits)
 5f6:	39 c3                	cmp    %eax,%ebx
 5f8:	74 5d                	je     657 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 5fa:	29 d8                	sub    %ebx,%eax
 5fc:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 5ff:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 602:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 605:	89 15 a8 06 00 00    	mov    %edx,0x6a8
      return (void*) (p + 1);
 60b:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 60e:	83 c4 0c             	add    $0xc,%esp
 611:	5b                   	pop    %ebx
 612:	5e                   	pop    %esi
 613:	5f                   	pop    %edi
 614:	5d                   	pop    %ebp
 615:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 616:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 61c:	89 de                	mov    %ebx,%esi
 61e:	89 f8                	mov    %edi,%eax
 620:	76 29                	jbe    64b <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 622:	89 04 24             	mov    %eax,(%esp)
 625:	e8 96 fc ff ff       	call   2c0 <sbrk>
  if(p == (char*) -1)
 62a:	83 f8 ff             	cmp    $0xffffffff,%eax
 62d:	74 18                	je     647 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 62f:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 632:	83 c0 08             	add    $0x8,%eax
 635:	89 04 24             	mov    %eax,(%esp)
 638:	e8 f3 fe ff ff       	call   530 <free>
  return freep;
 63d:	8b 15 a8 06 00 00    	mov    0x6a8,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 643:	85 d2                	test   %edx,%edx
 645:	75 a6                	jne    5ed <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 647:	31 c0                	xor    %eax,%eax
 649:	eb c3                	jmp    60e <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 64b:	be 00 10 00 00       	mov    $0x1000,%esi
 650:	b8 00 80 00 00       	mov    $0x8000,%eax
 655:	eb cb                	jmp    622 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 657:	8b 01                	mov    (%ecx),%eax
 659:	89 02                	mov    %eax,(%edx)
 65b:	eb a8                	jmp    605 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 65d:	ba a0 06 00 00       	mov    $0x6a0,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 662:	c7 05 a8 06 00 00 a0 	movl   $0x6a0,0x6a8
 669:	06 00 00 
 66c:	c7 05 a0 06 00 00 a0 	movl   $0x6a0,0x6a0
 673:	06 00 00 
    base.s.size = 0;
 676:	c7 05 a4 06 00 00 00 	movl   $0x0,0x6a4
 67d:	00 00 00 
 680:	e9 4e ff ff ff       	jmp    5d3 <malloc+0x23>
