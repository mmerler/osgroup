
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
  1e:	c7 44 24 04 b5 06 00 	movl   $0x6b5,0x4(%esp)
  25:	00 
  26:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  2d:	e8 ae 03 00 00       	call   3e0 <printf>
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
  5c:	c7 44 24 04 c8 06 00 	movl   $0x6c8,0x4(%esp)
  63:	00 
  64:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  6b:	89 44 24 08          	mov    %eax,0x8(%esp)
  6f:	e8 6c 03 00 00       	call   3e0 <printf>
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

00000328 <freepages>:
// Added by Jingyue
SYSCALL(freepages)
 328:	b8 16 00 00 00       	mov    $0x16,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	83 ec 18             	sub    $0x18,%esp
 336:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 339:	8d 55 fc             	lea    -0x4(%ebp),%edx
 33c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 343:	00 
 344:	89 54 24 04          	mov    %edx,0x4(%esp)
 348:	89 04 24             	mov    %eax,(%esp)
 34b:	e8 58 ff ff ff       	call   2a8 <write>
}
 350:	c9                   	leave  
 351:	c3                   	ret    
 352:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 359:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000360 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	56                   	push   %esi
 365:	89 ce                	mov    %ecx,%esi
 367:	53                   	push   %ebx
 368:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 36b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 36e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 371:	85 c9                	test   %ecx,%ecx
 373:	74 04                	je     379 <printint+0x19>
 375:	85 d2                	test   %edx,%edx
 377:	78 54                	js     3cd <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 379:	89 d0                	mov    %edx,%eax
 37b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 382:	31 db                	xor    %ebx,%ebx
 384:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 387:	31 d2                	xor    %edx,%edx
 389:	f7 f6                	div    %esi
 38b:	89 c1                	mov    %eax,%ecx
 38d:	0f b6 82 e3 06 00 00 	movzbl 0x6e3(%edx),%eax
 394:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 397:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 39a:	85 c9                	test   %ecx,%ecx
 39c:	89 c8                	mov    %ecx,%eax
 39e:	75 e7                	jne    387 <printint+0x27>
  if(neg)
 3a0:	8b 45 e0             	mov    -0x20(%ebp),%eax
 3a3:	85 c0                	test   %eax,%eax
 3a5:	74 08                	je     3af <printint+0x4f>
    buf[i++] = '-';
 3a7:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 3ac:	83 c3 01             	add    $0x1,%ebx
 3af:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 3b2:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 3b6:	83 eb 01             	sub    $0x1,%ebx
 3b9:	8b 45 dc             	mov    -0x24(%ebp),%eax
 3bc:	e8 6f ff ff ff       	call   330 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3c1:	39 fb                	cmp    %edi,%ebx
 3c3:	75 ed                	jne    3b2 <printint+0x52>
    putc(fd, buf[i]);
}
 3c5:	83 c4 1c             	add    $0x1c,%esp
 3c8:	5b                   	pop    %ebx
 3c9:	5e                   	pop    %esi
 3ca:	5f                   	pop    %edi
 3cb:	5d                   	pop    %ebp
 3cc:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3cd:	89 d0                	mov    %edx,%eax
 3cf:	f7 d8                	neg    %eax
 3d1:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 3d8:	eb a8                	jmp    382 <printint+0x22>
 3da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003e0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	56                   	push   %esi
 3e5:	53                   	push   %ebx
 3e6:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3e9:	8b 55 0c             	mov    0xc(%ebp),%edx
 3ec:	0f b6 02             	movzbl (%edx),%eax
 3ef:	84 c0                	test   %al,%al
 3f1:	0f 84 87 00 00 00    	je     47e <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 3f7:	8d 4d 10             	lea    0x10(%ebp),%ecx
 3fa:	31 ff                	xor    %edi,%edi
 3fc:	31 f6                	xor    %esi,%esi
 3fe:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 401:	eb 18                	jmp    41b <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 403:	83 fb 25             	cmp    $0x25,%ebx
 406:	0f 85 7a 00 00 00    	jne    486 <printf+0xa6>
 40c:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 410:	83 c7 01             	add    $0x1,%edi
 413:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 417:	84 c0                	test   %al,%al
 419:	74 63                	je     47e <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 41b:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 41d:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 420:	74 e1                	je     403 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 422:	83 fe 25             	cmp    $0x25,%esi
 425:	75 e9                	jne    410 <printf+0x30>
      if(c == 'd'){
 427:	83 fb 64             	cmp    $0x64,%ebx
 42a:	0f 84 f0 00 00 00    	je     520 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 430:	83 fb 78             	cmp    $0x78,%ebx
 433:	74 64                	je     499 <printf+0xb9>
 435:	83 fb 70             	cmp    $0x70,%ebx
 438:	74 5f                	je     499 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 43a:	83 fb 73             	cmp    $0x73,%ebx
 43d:	8d 76 00             	lea    0x0(%esi),%esi
 440:	74 7e                	je     4c0 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 442:	83 fb 63             	cmp    $0x63,%ebx
 445:	0f 84 b9 00 00 00    	je     504 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 44b:	83 fb 25             	cmp    $0x25,%ebx
 44e:	66 90                	xchg   %ax,%ax
 450:	0f 84 f2 00 00 00    	je     548 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 456:	8b 45 08             	mov    0x8(%ebp),%eax
 459:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 45e:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 461:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 463:	e8 c8 fe ff ff       	call   330 <putc>
        putc(fd, c);
 468:	8b 45 08             	mov    0x8(%ebp),%eax
 46b:	0f be d3             	movsbl %bl,%edx
 46e:	e8 bd fe ff ff       	call   330 <putc>
 473:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 476:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 47a:	84 c0                	test   %al,%al
 47c:	75 9d                	jne    41b <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 47e:	83 c4 0c             	add    $0xc,%esp
 481:	5b                   	pop    %ebx
 482:	5e                   	pop    %esi
 483:	5f                   	pop    %edi
 484:	5d                   	pop    %ebp
 485:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 486:	8b 45 08             	mov    0x8(%ebp),%eax
 489:	0f be d3             	movsbl %bl,%edx
 48c:	e8 9f fe ff ff       	call   330 <putc>
 491:	8b 55 0c             	mov    0xc(%ebp),%edx
 494:	e9 77 ff ff ff       	jmp    410 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 499:	8b 45 f0             	mov    -0x10(%ebp),%eax
 49c:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 4a1:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4a3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4aa:	8b 10                	mov    (%eax),%edx
 4ac:	8b 45 08             	mov    0x8(%ebp),%eax
 4af:	e8 ac fe ff ff       	call   360 <printint>
 4b4:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 4b7:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 4bb:	e9 50 ff ff ff       	jmp    410 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 4c0:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 4c3:	8b 01                	mov    (%ecx),%eax
        ap++;
 4c5:	83 c1 04             	add    $0x4,%ecx
 4c8:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 4cb:	b9 dc 06 00 00       	mov    $0x6dc,%ecx
 4d0:	85 c0                	test   %eax,%eax
 4d2:	75 2c                	jne    500 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 4d4:	0f b6 01             	movzbl (%ecx),%eax
 4d7:	84 c0                	test   %al,%al
 4d9:	74 1e                	je     4f9 <printf+0x119>
 4db:	89 cb                	mov    %ecx,%ebx
 4dd:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 4e0:	0f be d0             	movsbl %al,%edx
 4e3:	8b 45 08             	mov    0x8(%ebp),%eax
 4e6:	e8 45 fe ff ff       	call   330 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 4eb:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 4ef:	83 c3 01             	add    $0x1,%ebx
 4f2:	84 c0                	test   %al,%al
 4f4:	75 ea                	jne    4e0 <printf+0x100>
 4f6:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4f9:	31 f6                	xor    %esi,%esi
 4fb:	e9 10 ff ff ff       	jmp    410 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 500:	89 c1                	mov    %eax,%ecx
 502:	eb d0                	jmp    4d4 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 504:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 507:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 509:	0f be 10             	movsbl (%eax),%edx
 50c:	8b 45 08             	mov    0x8(%ebp),%eax
 50f:	e8 1c fe ff ff       	call   330 <putc>
 514:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 517:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 51b:	e9 f0 fe ff ff       	jmp    410 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 520:	8b 45 f0             	mov    -0x10(%ebp),%eax
 523:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 528:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 52b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 532:	8b 10                	mov    (%eax),%edx
 534:	8b 45 08             	mov    0x8(%ebp),%eax
 537:	e8 24 fe ff ff       	call   360 <printint>
 53c:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 53f:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 543:	e9 c8 fe ff ff       	jmp    410 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 548:	8b 45 08             	mov    0x8(%ebp),%eax
 54b:	ba 25 00 00 00       	mov    $0x25,%edx
 550:	31 f6                	xor    %esi,%esi
 552:	e8 d9 fd ff ff       	call   330 <putc>
 557:	8b 55 0c             	mov    0xc(%ebp),%edx
 55a:	e9 b1 fe ff ff       	jmp    410 <printf+0x30>
 55f:	90                   	nop    

00000560 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 560:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 561:	8b 0d fc 06 00 00    	mov    0x6fc,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 567:	89 e5                	mov    %esp,%ebp
 569:	56                   	push   %esi
 56a:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 56b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 56e:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 571:	39 d9                	cmp    %ebx,%ecx
 573:	73 18                	jae    58d <free+0x2d>
 575:	8b 11                	mov    (%ecx),%edx
 577:	39 d3                	cmp    %edx,%ebx
 579:	72 17                	jb     592 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 57b:	39 d1                	cmp    %edx,%ecx
 57d:	72 08                	jb     587 <free+0x27>
 57f:	39 d9                	cmp    %ebx,%ecx
 581:	72 0f                	jb     592 <free+0x32>
 583:	39 d3                	cmp    %edx,%ebx
 585:	72 0b                	jb     592 <free+0x32>
 587:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 589:	39 d9                	cmp    %ebx,%ecx
 58b:	72 e8                	jb     575 <free+0x15>
 58d:	8b 11                	mov    (%ecx),%edx
 58f:	90                   	nop    
 590:	eb e9                	jmp    57b <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 592:	8b 73 04             	mov    0x4(%ebx),%esi
 595:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 598:	39 d0                	cmp    %edx,%eax
 59a:	74 18                	je     5b4 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 59c:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 59e:	8b 51 04             	mov    0x4(%ecx),%edx
 5a1:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 5a4:	39 d8                	cmp    %ebx,%eax
 5a6:	74 20                	je     5c8 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5a8:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 5aa:	5b                   	pop    %ebx
 5ab:	5e                   	pop    %esi
 5ac:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 5ad:	89 0d fc 06 00 00    	mov    %ecx,0x6fc
}
 5b3:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 5b4:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 5b7:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 5b9:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5bc:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 5bf:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5c1:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 5c4:	39 d8                	cmp    %ebx,%eax
 5c6:	75 e0                	jne    5a8 <free+0x48>
    p->s.size += bp->s.size;
 5c8:	03 53 04             	add    0x4(%ebx),%edx
 5cb:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 5ce:	8b 13                	mov    (%ebx),%edx
 5d0:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 5d2:	5b                   	pop    %ebx
 5d3:	5e                   	pop    %esi
 5d4:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 5d5:	89 0d fc 06 00 00    	mov    %ecx,0x6fc
}
 5db:	c3                   	ret    
 5dc:	8d 74 26 00          	lea    0x0(%esi),%esi

000005e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	57                   	push   %edi
 5e4:	56                   	push   %esi
 5e5:	53                   	push   %ebx
 5e6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 5ec:	8b 15 fc 06 00 00    	mov    0x6fc,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5f2:	83 c0 07             	add    $0x7,%eax
 5f5:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 5f8:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5fa:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 5fd:	0f 84 8a 00 00 00    	je     68d <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 603:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 605:	8b 41 04             	mov    0x4(%ecx),%eax
 608:	39 c3                	cmp    %eax,%ebx
 60a:	76 1a                	jbe    626 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 60c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 613:	3b 0d fc 06 00 00    	cmp    0x6fc,%ecx
 619:	89 ca                	mov    %ecx,%edx
 61b:	74 29                	je     646 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 61d:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 61f:	8b 41 04             	mov    0x4(%ecx),%eax
 622:	39 c3                	cmp    %eax,%ebx
 624:	77 ed                	ja     613 <malloc+0x33>
      if(p->s.size == nunits)
 626:	39 c3                	cmp    %eax,%ebx
 628:	74 5d                	je     687 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 62a:	29 d8                	sub    %ebx,%eax
 62c:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 62f:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 632:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 635:	89 15 fc 06 00 00    	mov    %edx,0x6fc
      return (void*) (p + 1);
 63b:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 63e:	83 c4 0c             	add    $0xc,%esp
 641:	5b                   	pop    %ebx
 642:	5e                   	pop    %esi
 643:	5f                   	pop    %edi
 644:	5d                   	pop    %ebp
 645:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 646:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 64c:	89 de                	mov    %ebx,%esi
 64e:	89 f8                	mov    %edi,%eax
 650:	76 29                	jbe    67b <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 652:	89 04 24             	mov    %eax,(%esp)
 655:	e8 b6 fc ff ff       	call   310 <sbrk>
  if(p == (char*) -1)
 65a:	83 f8 ff             	cmp    $0xffffffff,%eax
 65d:	74 18                	je     677 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 65f:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 662:	83 c0 08             	add    $0x8,%eax
 665:	89 04 24             	mov    %eax,(%esp)
 668:	e8 f3 fe ff ff       	call   560 <free>
  return freep;
 66d:	8b 15 fc 06 00 00    	mov    0x6fc,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 673:	85 d2                	test   %edx,%edx
 675:	75 a6                	jne    61d <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 677:	31 c0                	xor    %eax,%eax
 679:	eb c3                	jmp    63e <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 67b:	be 00 10 00 00       	mov    $0x1000,%esi
 680:	b8 00 80 00 00       	mov    $0x8000,%eax
 685:	eb cb                	jmp    652 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 687:	8b 01                	mov    (%ecx),%eax
 689:	89 02                	mov    %eax,(%edx)
 68b:	eb a8                	jmp    635 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 68d:	ba f4 06 00 00       	mov    $0x6f4,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 692:	c7 05 fc 06 00 00 f4 	movl   $0x6f4,0x6fc
 699:	06 00 00 
 69c:	c7 05 f4 06 00 00 f4 	movl   $0x6f4,0x6f4
 6a3:	06 00 00 
    base.s.size = 0;
 6a6:	c7 05 f8 06 00 00 00 	movl   $0x0,0x6f8
 6ad:	00 00 00 
 6b0:	e9 4e ff ff ff       	jmp    603 <malloc+0x23>
