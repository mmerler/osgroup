
_ln:     file format elf32-i386

Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	83 ec 18             	sub    $0x18,%esp
  if(argc != 3){
  10:	83 39 03             	cmpl   $0x3,(%ecx)
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  13:	89 4d f8             	mov    %ecx,-0x8(%ebp)
  16:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  19:	8b 59 04             	mov    0x4(%ecx),%ebx
  if(argc != 3){
  1c:	74 19                	je     37 <main+0x37>
    printf(2, "Usage: ln old new\n");
  1e:	c7 44 24 04 d5 06 00 	movl   $0x6d5,0x4(%esp)
  25:	00 
  26:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  2d:	e8 ce 03 00 00       	call   400 <printf>
    exit();
  32:	e8 51 02 00 00       	call   288 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  37:	8b 43 08             	mov    0x8(%ebx),%eax
  3a:	89 44 24 04          	mov    %eax,0x4(%esp)
  3e:	8b 43 04             	mov    0x4(%ebx),%eax
  41:	89 04 24             	mov    %eax,(%esp)
  44:	e8 9f 02 00 00       	call   2e8 <link>
  49:	85 c0                	test   %eax,%eax
  4b:	78 05                	js     52 <main+0x52>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit();
  4d:	e8 36 02 00 00       	call   288 <exit>
  if(argc != 3){
    printf(2, "Usage: ln old new\n");
    exit();
  }
  if(link(argv[1], argv[2]) < 0)
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  52:	8b 43 08             	mov    0x8(%ebx),%eax
  55:	89 44 24 0c          	mov    %eax,0xc(%esp)
  59:	8b 43 04             	mov    0x4(%ebx),%eax
  5c:	c7 44 24 04 e8 06 00 	movl   $0x6e8,0x4(%esp)
  63:	00 
  64:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  6b:	89 44 24 08          	mov    %eax,0x8(%esp)
  6f:	e8 8c 03 00 00       	call   400 <printf>
  74:	eb d7                	jmp    4d <main+0x4d>
  76:	90                   	nop    
  77:	90                   	nop    
  78:	90                   	nop    
  79:	90                   	nop    
  7a:	90                   	nop    
  7b:	90                   	nop    
  7c:	90                   	nop    
  7d:	90                   	nop    
  7e:	90                   	nop    
  7f:	90                   	nop    

00000080 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  83:	53                   	push   %ebx
  84:	8b 5d 08             	mov    0x8(%ebp),%ebx
  87:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8a:	89 da                	mov    %ebx,%edx
  8c:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  90:	0f b6 01             	movzbl (%ecx),%eax
  93:	83 c1 01             	add    $0x1,%ecx
  96:	88 02                	mov    %al,(%edx)
  98:	83 c2 01             	add    $0x1,%edx
  9b:	84 c0                	test   %al,%al
  9d:	75 f1                	jne    90 <strcpy+0x10>
    ;
  return os;
}
  9f:	89 d8                	mov    %ebx,%eax
  a1:	5b                   	pop    %ebx
  a2:	5d                   	pop    %ebp
  a3:	c3                   	ret    
  a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  b6:	53                   	push   %ebx
  b7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  ba:	0f b6 01             	movzbl (%ecx),%eax
  bd:	84 c0                	test   %al,%al
  bf:	74 24                	je     e5 <strcmp+0x35>
  c1:	0f b6 13             	movzbl (%ebx),%edx
  c4:	38 d0                	cmp    %dl,%al
  c6:	74 12                	je     da <strcmp+0x2a>
  c8:	eb 1e                	jmp    e8 <strcmp+0x38>
  ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  d0:	0f b6 13             	movzbl (%ebx),%edx
  d3:	83 c1 01             	add    $0x1,%ecx
  d6:	38 d0                	cmp    %dl,%al
  d8:	75 0e                	jne    e8 <strcmp+0x38>
  da:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
  de:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  e1:	84 c0                	test   %al,%al
  e3:	75 eb                	jne    d0 <strcmp+0x20>
  e5:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  e8:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  e9:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  ec:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  ed:	0f b6 d2             	movzbl %dl,%edx
  f0:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  f2:	c3                   	ret    
  f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000100 <strlen>:

uint
strlen(char *s)
{
 100:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 101:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 103:	89 e5                	mov    %esp,%ebp
 105:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 108:	80 39 00             	cmpb   $0x0,(%ecx)
 10b:	74 0e                	je     11b <strlen+0x1b>
 10d:	31 d2                	xor    %edx,%edx
 10f:	90                   	nop    
 110:	83 c2 01             	add    $0x1,%edx
 113:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
 117:	89 d0                	mov    %edx,%eax
 119:	75 f5                	jne    110 <strlen+0x10>
    ;
  return n;
}
 11b:	5d                   	pop    %ebp
 11c:	c3                   	ret    
 11d:	8d 76 00             	lea    0x0(%esi),%esi

00000120 <memset>:

void*
memset(void *dst, int c, uint n)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	8b 55 08             	mov    0x8(%ebp),%edx
 126:	57                   	push   %edi
 127:	8b 45 0c             	mov    0xc(%ebp),%eax
 12a:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 12d:	89 d7                	mov    %edx,%edi
 12f:	fc                   	cld    
 130:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 132:	5f                   	pop    %edi
 133:	89 d0                	mov    %edx,%eax
 135:	5d                   	pop    %ebp
 136:	c3                   	ret    
 137:	89 f6                	mov    %esi,%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000140 <strchr>:

char*
strchr(const char *s, char c)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	8b 45 08             	mov    0x8(%ebp),%eax
 146:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 14a:	0f b6 10             	movzbl (%eax),%edx
 14d:	84 d2                	test   %dl,%dl
 14f:	75 0c                	jne    15d <strchr+0x1d>
 151:	eb 11                	jmp    164 <strchr+0x24>
 153:	83 c0 01             	add    $0x1,%eax
 156:	0f b6 10             	movzbl (%eax),%edx
 159:	84 d2                	test   %dl,%dl
 15b:	74 07                	je     164 <strchr+0x24>
    if(*s == c)
 15d:	38 ca                	cmp    %cl,%dl
 15f:	90                   	nop    
 160:	75 f1                	jne    153 <strchr+0x13>
      return (char*) s;
  return 0;
}
 162:	5d                   	pop    %ebp
 163:	c3                   	ret    
 164:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 165:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 167:	c3                   	ret    
 168:	90                   	nop    
 169:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000170 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	8b 4d 08             	mov    0x8(%ebp),%ecx
 176:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 177:	31 db                	xor    %ebx,%ebx
 179:	0f b6 11             	movzbl (%ecx),%edx
 17c:	8d 42 d0             	lea    -0x30(%edx),%eax
 17f:	3c 09                	cmp    $0x9,%al
 181:	77 18                	ja     19b <atoi+0x2b>
    n = n*10 + *s++ - '0';
 183:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 186:	0f be d2             	movsbl %dl,%edx
 189:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 18d:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 191:	83 c1 01             	add    $0x1,%ecx
 194:	8d 42 d0             	lea    -0x30(%edx),%eax
 197:	3c 09                	cmp    $0x9,%al
 199:	76 e8                	jbe    183 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 19b:	89 d8                	mov    %ebx,%eax
 19d:	5b                   	pop    %ebx
 19e:	5d                   	pop    %ebp
 19f:	c3                   	ret    

000001a0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1a6:	56                   	push   %esi
 1a7:	8b 75 08             	mov    0x8(%ebp),%esi
 1aa:	53                   	push   %ebx
 1ab:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1ae:	85 c9                	test   %ecx,%ecx
 1b0:	7e 10                	jle    1c2 <memmove+0x22>
 1b2:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 1b4:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 1b8:	88 04 32             	mov    %al,(%edx,%esi,1)
 1bb:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1be:	39 ca                	cmp    %ecx,%edx
 1c0:	75 f2                	jne    1b4 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 1c2:	89 f0                	mov    %esi,%eax
 1c4:	5b                   	pop    %ebx
 1c5:	5e                   	pop    %esi
 1c6:	5d                   	pop    %ebp
 1c7:	c3                   	ret    
 1c8:	90                   	nop    
 1c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000001d0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 1d9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1dc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 1df:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1eb:	00 
 1ec:	89 04 24             	mov    %eax,(%esp)
 1ef:	e8 d4 00 00 00       	call   2c8 <open>
  if(fd < 0)
 1f4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 1f8:	78 19                	js     213 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 1fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 1fd:	89 1c 24             	mov    %ebx,(%esp)
 200:	89 44 24 04          	mov    %eax,0x4(%esp)
 204:	e8 d7 00 00 00       	call   2e0 <fstat>
  close(fd);
 209:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 20c:	89 c6                	mov    %eax,%esi
  close(fd);
 20e:	e8 9d 00 00 00       	call   2b0 <close>
  return r;
}
 213:	89 f0                	mov    %esi,%eax
 215:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 218:	8b 75 fc             	mov    -0x4(%ebp),%esi
 21b:	89 ec                	mov    %ebp,%esp
 21d:	5d                   	pop    %ebp
 21e:	c3                   	ret    
 21f:	90                   	nop    

00000220 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
 224:	56                   	push   %esi
 225:	31 f6                	xor    %esi,%esi
 227:	53                   	push   %ebx
 228:	83 ec 1c             	sub    $0x1c,%esp
 22b:	8b 7d 08             	mov    0x8(%ebp),%edi
 22e:	eb 06                	jmp    236 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 230:	3c 0d                	cmp    $0xd,%al
 232:	74 39                	je     26d <gets+0x4d>
 234:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 236:	8d 5e 01             	lea    0x1(%esi),%ebx
 239:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 23c:	7d 31                	jge    26f <gets+0x4f>
    cc = read(0, &c, 1);
 23e:	8d 45 f3             	lea    -0xd(%ebp),%eax
 241:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 248:	00 
 249:	89 44 24 04          	mov    %eax,0x4(%esp)
 24d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 254:	e8 47 00 00 00       	call   2a0 <read>
    if(cc < 1)
 259:	85 c0                	test   %eax,%eax
 25b:	7e 12                	jle    26f <gets+0x4f>
      break;
    buf[i++] = c;
 25d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 261:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 265:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 269:	3c 0a                	cmp    $0xa,%al
 26b:	75 c3                	jne    230 <gets+0x10>
 26d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 26f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 273:	89 f8                	mov    %edi,%eax
 275:	83 c4 1c             	add    $0x1c,%esp
 278:	5b                   	pop    %ebx
 279:	5e                   	pop    %esi
 27a:	5f                   	pop    %edi
 27b:	5d                   	pop    %ebp
 27c:	c3                   	ret    
 27d:	90                   	nop    
 27e:	90                   	nop    
 27f:	90                   	nop    

00000280 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 280:	b8 01 00 00 00       	mov    $0x1,%eax
 285:	cd 40                	int    $0x40
 287:	c3                   	ret    

00000288 <exit>:
SYSCALL(exit)
 288:	b8 02 00 00 00       	mov    $0x2,%eax
 28d:	cd 40                	int    $0x40
 28f:	c3                   	ret    

00000290 <wait>:
SYSCALL(wait)
 290:	b8 03 00 00 00       	mov    $0x3,%eax
 295:	cd 40                	int    $0x40
 297:	c3                   	ret    

00000298 <pipe>:
SYSCALL(pipe)
 298:	b8 04 00 00 00       	mov    $0x4,%eax
 29d:	cd 40                	int    $0x40
 29f:	c3                   	ret    

000002a0 <read>:
SYSCALL(read)
 2a0:	b8 06 00 00 00       	mov    $0x6,%eax
 2a5:	cd 40                	int    $0x40
 2a7:	c3                   	ret    

000002a8 <write>:
SYSCALL(write)
 2a8:	b8 05 00 00 00       	mov    $0x5,%eax
 2ad:	cd 40                	int    $0x40
 2af:	c3                   	ret    

000002b0 <close>:
SYSCALL(close)
 2b0:	b8 07 00 00 00       	mov    $0x7,%eax
 2b5:	cd 40                	int    $0x40
 2b7:	c3                   	ret    

000002b8 <kill>:
SYSCALL(kill)
 2b8:	b8 08 00 00 00       	mov    $0x8,%eax
 2bd:	cd 40                	int    $0x40
 2bf:	c3                   	ret    

000002c0 <exec>:
SYSCALL(exec)
 2c0:	b8 09 00 00 00       	mov    $0x9,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <open>:
SYSCALL(open)
 2c8:	b8 0a 00 00 00       	mov    $0xa,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <mknod>:
SYSCALL(mknod)
 2d0:	b8 0b 00 00 00       	mov    $0xb,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <unlink>:
SYSCALL(unlink)
 2d8:	b8 0c 00 00 00       	mov    $0xc,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <fstat>:
SYSCALL(fstat)
 2e0:	b8 0d 00 00 00       	mov    $0xd,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <link>:
SYSCALL(link)
 2e8:	b8 0e 00 00 00       	mov    $0xe,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <mkdir>:
SYSCALL(mkdir)
 2f0:	b8 0f 00 00 00       	mov    $0xf,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <chdir>:
SYSCALL(chdir)
 2f8:	b8 10 00 00 00       	mov    $0x10,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <dup>:
SYSCALL(dup)
 300:	b8 11 00 00 00       	mov    $0x11,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <getpid>:
SYSCALL(getpid)
 308:	b8 12 00 00 00       	mov    $0x12,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <sbrk>:
SYSCALL(sbrk)
 310:	b8 13 00 00 00       	mov    $0x13,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <sleep>:
SYSCALL(sleep)
 318:	b8 14 00 00 00       	mov    $0x14,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <uptime>:
SYSCALL(uptime)
 320:	b8 15 00 00 00       	mov    $0x15,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <nice>:
SYSCALL(nice)
 328:	b8 16 00 00 00       	mov    $0x16,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <getpriority>:
SYSCALL(getpriority)
 330:	b8 17 00 00 00       	mov    $0x17,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <setpriority>:
SYSCALL(setpriority)
 338:	b8 18 00 00 00       	mov    $0x18,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <getaffinity>:
SYSCALL(getaffinity)
 340:	b8 19 00 00 00       	mov    $0x19,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <setaffinity>:
SYSCALL(setaffinity)
 348:	b8 1a 00 00 00       	mov    $0x1a,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	83 ec 18             	sub    $0x18,%esp
 356:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 359:	8d 55 fc             	lea    -0x4(%ebp),%edx
 35c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 363:	00 
 364:	89 54 24 04          	mov    %edx,0x4(%esp)
 368:	89 04 24             	mov    %eax,(%esp)
 36b:	e8 38 ff ff ff       	call   2a8 <write>
}
 370:	c9                   	leave  
 371:	c3                   	ret    
 372:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 379:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000380 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	56                   	push   %esi
 385:	89 ce                	mov    %ecx,%esi
 387:	53                   	push   %ebx
 388:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 38b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 38e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 391:	85 c9                	test   %ecx,%ecx
 393:	74 04                	je     399 <printint+0x19>
 395:	85 d2                	test   %edx,%edx
 397:	78 54                	js     3ed <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 399:	89 d0                	mov    %edx,%eax
 39b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 3a2:	31 db                	xor    %ebx,%ebx
 3a4:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 3a7:	31 d2                	xor    %edx,%edx
 3a9:	f7 f6                	div    %esi
 3ab:	89 c1                	mov    %eax,%ecx
 3ad:	0f b6 82 03 07 00 00 	movzbl 0x703(%edx),%eax
 3b4:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 3b7:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 3ba:	85 c9                	test   %ecx,%ecx
 3bc:	89 c8                	mov    %ecx,%eax
 3be:	75 e7                	jne    3a7 <printint+0x27>
  if(neg)
 3c0:	8b 45 e0             	mov    -0x20(%ebp),%eax
 3c3:	85 c0                	test   %eax,%eax
 3c5:	74 08                	je     3cf <printint+0x4f>
    buf[i++] = '-';
 3c7:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 3cc:	83 c3 01             	add    $0x1,%ebx
 3cf:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 3d2:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 3d6:	83 eb 01             	sub    $0x1,%ebx
 3d9:	8b 45 dc             	mov    -0x24(%ebp),%eax
 3dc:	e8 6f ff ff ff       	call   350 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3e1:	39 fb                	cmp    %edi,%ebx
 3e3:	75 ed                	jne    3d2 <printint+0x52>
    putc(fd, buf[i]);
}
 3e5:	83 c4 1c             	add    $0x1c,%esp
 3e8:	5b                   	pop    %ebx
 3e9:	5e                   	pop    %esi
 3ea:	5f                   	pop    %edi
 3eb:	5d                   	pop    %ebp
 3ec:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3ed:	89 d0                	mov    %edx,%eax
 3ef:	f7 d8                	neg    %eax
 3f1:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 3f8:	eb a8                	jmp    3a2 <printint+0x22>
 3fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000400 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	56                   	push   %esi
 405:	53                   	push   %ebx
 406:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 409:	8b 55 0c             	mov    0xc(%ebp),%edx
 40c:	0f b6 02             	movzbl (%edx),%eax
 40f:	84 c0                	test   %al,%al
 411:	0f 84 87 00 00 00    	je     49e <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 417:	8d 4d 10             	lea    0x10(%ebp),%ecx
 41a:	31 ff                	xor    %edi,%edi
 41c:	31 f6                	xor    %esi,%esi
 41e:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 421:	eb 18                	jmp    43b <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 423:	83 fb 25             	cmp    $0x25,%ebx
 426:	0f 85 7a 00 00 00    	jne    4a6 <printf+0xa6>
 42c:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 430:	83 c7 01             	add    $0x1,%edi
 433:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 437:	84 c0                	test   %al,%al
 439:	74 63                	je     49e <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 43b:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 43d:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 440:	74 e1                	je     423 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 442:	83 fe 25             	cmp    $0x25,%esi
 445:	75 e9                	jne    430 <printf+0x30>
      if(c == 'd'){
 447:	83 fb 64             	cmp    $0x64,%ebx
 44a:	0f 84 f0 00 00 00    	je     540 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 450:	83 fb 78             	cmp    $0x78,%ebx
 453:	74 64                	je     4b9 <printf+0xb9>
 455:	83 fb 70             	cmp    $0x70,%ebx
 458:	74 5f                	je     4b9 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 45a:	83 fb 73             	cmp    $0x73,%ebx
 45d:	8d 76 00             	lea    0x0(%esi),%esi
 460:	74 7e                	je     4e0 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 462:	83 fb 63             	cmp    $0x63,%ebx
 465:	0f 84 b9 00 00 00    	je     524 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 46b:	83 fb 25             	cmp    $0x25,%ebx
 46e:	66 90                	xchg   %ax,%ax
 470:	0f 84 f2 00 00 00    	je     568 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 476:	8b 45 08             	mov    0x8(%ebp),%eax
 479:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 47e:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 481:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 483:	e8 c8 fe ff ff       	call   350 <putc>
        putc(fd, c);
 488:	8b 45 08             	mov    0x8(%ebp),%eax
 48b:	0f be d3             	movsbl %bl,%edx
 48e:	e8 bd fe ff ff       	call   350 <putc>
 493:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 496:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 49a:	84 c0                	test   %al,%al
 49c:	75 9d                	jne    43b <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 49e:	83 c4 0c             	add    $0xc,%esp
 4a1:	5b                   	pop    %ebx
 4a2:	5e                   	pop    %esi
 4a3:	5f                   	pop    %edi
 4a4:	5d                   	pop    %ebp
 4a5:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 4a6:	8b 45 08             	mov    0x8(%ebp),%eax
 4a9:	0f be d3             	movsbl %bl,%edx
 4ac:	e8 9f fe ff ff       	call   350 <putc>
 4b1:	8b 55 0c             	mov    0xc(%ebp),%edx
 4b4:	e9 77 ff ff ff       	jmp    430 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4bc:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 4c1:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4c3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4ca:	8b 10                	mov    (%eax),%edx
 4cc:	8b 45 08             	mov    0x8(%ebp),%eax
 4cf:	e8 ac fe ff ff       	call   380 <printint>
 4d4:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 4d7:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 4db:	e9 50 ff ff ff       	jmp    430 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 4e0:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 4e3:	8b 01                	mov    (%ecx),%eax
        ap++;
 4e5:	83 c1 04             	add    $0x4,%ecx
 4e8:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 4eb:	b9 fc 06 00 00       	mov    $0x6fc,%ecx
 4f0:	85 c0                	test   %eax,%eax
 4f2:	75 2c                	jne    520 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 4f4:	0f b6 01             	movzbl (%ecx),%eax
 4f7:	84 c0                	test   %al,%al
 4f9:	74 1e                	je     519 <printf+0x119>
 4fb:	89 cb                	mov    %ecx,%ebx
 4fd:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 500:	0f be d0             	movsbl %al,%edx
 503:	8b 45 08             	mov    0x8(%ebp),%eax
 506:	e8 45 fe ff ff       	call   350 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 50b:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 50f:	83 c3 01             	add    $0x1,%ebx
 512:	84 c0                	test   %al,%al
 514:	75 ea                	jne    500 <printf+0x100>
 516:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 519:	31 f6                	xor    %esi,%esi
 51b:	e9 10 ff ff ff       	jmp    430 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 520:	89 c1                	mov    %eax,%ecx
 522:	eb d0                	jmp    4f4 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 524:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 527:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 529:	0f be 10             	movsbl (%eax),%edx
 52c:	8b 45 08             	mov    0x8(%ebp),%eax
 52f:	e8 1c fe ff ff       	call   350 <putc>
 534:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 537:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 53b:	e9 f0 fe ff ff       	jmp    430 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 540:	8b 45 f0             	mov    -0x10(%ebp),%eax
 543:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 548:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 54b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 552:	8b 10                	mov    (%eax),%edx
 554:	8b 45 08             	mov    0x8(%ebp),%eax
 557:	e8 24 fe ff ff       	call   380 <printint>
 55c:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 55f:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 563:	e9 c8 fe ff ff       	jmp    430 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 568:	8b 45 08             	mov    0x8(%ebp),%eax
 56b:	ba 25 00 00 00       	mov    $0x25,%edx
 570:	31 f6                	xor    %esi,%esi
 572:	e8 d9 fd ff ff       	call   350 <putc>
 577:	8b 55 0c             	mov    0xc(%ebp),%edx
 57a:	e9 b1 fe ff ff       	jmp    430 <printf+0x30>
 57f:	90                   	nop    

00000580 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 580:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 581:	8b 0d 1c 07 00 00    	mov    0x71c,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 587:	89 e5                	mov    %esp,%ebp
 589:	56                   	push   %esi
 58a:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 58b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 58e:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 591:	39 d9                	cmp    %ebx,%ecx
 593:	73 18                	jae    5ad <free+0x2d>
 595:	8b 11                	mov    (%ecx),%edx
 597:	39 d3                	cmp    %edx,%ebx
 599:	72 17                	jb     5b2 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 59b:	39 d1                	cmp    %edx,%ecx
 59d:	72 08                	jb     5a7 <free+0x27>
 59f:	39 d9                	cmp    %ebx,%ecx
 5a1:	72 0f                	jb     5b2 <free+0x32>
 5a3:	39 d3                	cmp    %edx,%ebx
 5a5:	72 0b                	jb     5b2 <free+0x32>
 5a7:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5a9:	39 d9                	cmp    %ebx,%ecx
 5ab:	72 e8                	jb     595 <free+0x15>
 5ad:	8b 11                	mov    (%ecx),%edx
 5af:	90                   	nop    
 5b0:	eb e9                	jmp    59b <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 5b2:	8b 73 04             	mov    0x4(%ebx),%esi
 5b5:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 5b8:	39 d0                	cmp    %edx,%eax
 5ba:	74 18                	je     5d4 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5bc:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 5be:	8b 51 04             	mov    0x4(%ecx),%edx
 5c1:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 5c4:	39 d8                	cmp    %ebx,%eax
 5c6:	74 20                	je     5e8 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5c8:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 5ca:	5b                   	pop    %ebx
 5cb:	5e                   	pop    %esi
 5cc:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 5cd:	89 0d 1c 07 00 00    	mov    %ecx,0x71c
}
 5d3:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 5d4:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 5d7:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 5d9:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5dc:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 5df:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5e1:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 5e4:	39 d8                	cmp    %ebx,%eax
 5e6:	75 e0                	jne    5c8 <free+0x48>
    p->s.size += bp->s.size;
 5e8:	03 53 04             	add    0x4(%ebx),%edx
 5eb:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 5ee:	8b 13                	mov    (%ebx),%edx
 5f0:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 5f2:	5b                   	pop    %ebx
 5f3:	5e                   	pop    %esi
 5f4:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 5f5:	89 0d 1c 07 00 00    	mov    %ecx,0x71c
}
 5fb:	c3                   	ret    
 5fc:	8d 74 26 00          	lea    0x0(%esi),%esi

00000600 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 600:	55                   	push   %ebp
 601:	89 e5                	mov    %esp,%ebp
 603:	57                   	push   %edi
 604:	56                   	push   %esi
 605:	53                   	push   %ebx
 606:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 609:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 60c:	8b 15 1c 07 00 00    	mov    0x71c,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 612:	83 c0 07             	add    $0x7,%eax
 615:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 618:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 61a:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 61d:	0f 84 8a 00 00 00    	je     6ad <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 623:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 625:	8b 41 04             	mov    0x4(%ecx),%eax
 628:	39 c3                	cmp    %eax,%ebx
 62a:	76 1a                	jbe    646 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 62c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 633:	3b 0d 1c 07 00 00    	cmp    0x71c,%ecx
 639:	89 ca                	mov    %ecx,%edx
 63b:	74 29                	je     666 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 63d:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 63f:	8b 41 04             	mov    0x4(%ecx),%eax
 642:	39 c3                	cmp    %eax,%ebx
 644:	77 ed                	ja     633 <malloc+0x33>
      if(p->s.size == nunits)
 646:	39 c3                	cmp    %eax,%ebx
 648:	74 5d                	je     6a7 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 64a:	29 d8                	sub    %ebx,%eax
 64c:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 64f:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 652:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 655:	89 15 1c 07 00 00    	mov    %edx,0x71c
      return (void*) (p + 1);
 65b:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 65e:	83 c4 0c             	add    $0xc,%esp
 661:	5b                   	pop    %ebx
 662:	5e                   	pop    %esi
 663:	5f                   	pop    %edi
 664:	5d                   	pop    %ebp
 665:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 666:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 66c:	89 de                	mov    %ebx,%esi
 66e:	89 f8                	mov    %edi,%eax
 670:	76 29                	jbe    69b <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 672:	89 04 24             	mov    %eax,(%esp)
 675:	e8 96 fc ff ff       	call   310 <sbrk>
  if(p == (char*) -1)
 67a:	83 f8 ff             	cmp    $0xffffffff,%eax
 67d:	74 18                	je     697 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 67f:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 682:	83 c0 08             	add    $0x8,%eax
 685:	89 04 24             	mov    %eax,(%esp)
 688:	e8 f3 fe ff ff       	call   580 <free>
  return freep;
 68d:	8b 15 1c 07 00 00    	mov    0x71c,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 693:	85 d2                	test   %edx,%edx
 695:	75 a6                	jne    63d <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 697:	31 c0                	xor    %eax,%eax
 699:	eb c3                	jmp    65e <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 69b:	be 00 10 00 00       	mov    $0x1000,%esi
 6a0:	b8 00 80 00 00       	mov    $0x8000,%eax
 6a5:	eb cb                	jmp    672 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 6a7:	8b 01                	mov    (%ecx),%eax
 6a9:	89 02                	mov    %eax,(%edx)
 6ab:	eb a8                	jmp    655 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 6ad:	ba 14 07 00 00       	mov    $0x714,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 6b2:	c7 05 1c 07 00 00 14 	movl   $0x714,0x71c
 6b9:	07 00 00 
 6bc:	c7 05 14 07 00 00 14 	movl   $0x714,0x714
 6c3:	07 00 00 
    base.s.size = 0;
 6c6:	c7 05 18 07 00 00 00 	movl   $0x0,0x718
 6cd:	00 00 00 
 6d0:	e9 4e ff ff ff       	jmp    623 <malloc+0x23>
