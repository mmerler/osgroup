
_kill:     file format elf32-i386

Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	83 ec 18             	sub    $0x18,%esp
  10:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  13:	8b 19                	mov    (%ecx),%ebx
  15:	89 4d f0             	mov    %ecx,-0x10(%ebp)
  18:	89 75 f8             	mov    %esi,-0x8(%ebp)
  1b:	89 7d fc             	mov    %edi,-0x4(%ebp)
  1e:	8b 71 04             	mov    0x4(%ecx),%esi
  int i;

  if(argc < 1){
  21:	85 db                	test   %ebx,%ebx
  23:	7f 19                	jg     3e <main+0x3e>
    printf(2, "usage: kill pid...\n");
  25:	c7 44 24 04 c5 06 00 	movl   $0x6c5,0x4(%esp)
  2c:	00 
  2d:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  34:	e8 b7 03 00 00       	call   3f0 <printf>
    exit();
  39:	e8 3a 02 00 00       	call   278 <exit>
  }
  for(i=1; i<argc; i++)
  3e:	83 fb 01             	cmp    $0x1,%ebx
{
  int i;

  if(argc < 1){
    printf(2, "usage: kill pid...\n");
    exit();
  41:	bf 01 00 00 00       	mov    $0x1,%edi
  }
  for(i=1; i<argc; i++)
  46:	74 1a                	je     62 <main+0x62>
    kill(atoi(argv[i]));
  48:	8b 04 be             	mov    (%esi,%edi,4),%eax

  if(argc < 1){
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
  4b:	83 c7 01             	add    $0x1,%edi
    kill(atoi(argv[i]));
  4e:	89 04 24             	mov    %eax,(%esp)
  51:	e8 0a 01 00 00       	call   160 <atoi>
  56:	89 04 24             	mov    %eax,(%esp)
  59:	e8 4a 02 00 00       	call   2a8 <kill>

  if(argc < 1){
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
  5e:	39 df                	cmp    %ebx,%edi
  60:	75 e6                	jne    48 <main+0x48>
    kill(atoi(argv[i]));
  exit();
  62:	e8 11 02 00 00       	call   278 <exit>
  67:	90                   	nop    
  68:	90                   	nop    
  69:	90                   	nop    
  6a:	90                   	nop    
  6b:	90                   	nop    
  6c:	90                   	nop    
  6d:	90                   	nop    
  6e:	90                   	nop    
  6f:	90                   	nop    

00000070 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	53                   	push   %ebx
  74:	8b 5d 08             	mov    0x8(%ebp),%ebx
  77:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  7a:	89 da                	mov    %ebx,%edx
  7c:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  80:	0f b6 01             	movzbl (%ecx),%eax
  83:	83 c1 01             	add    $0x1,%ecx
  86:	88 02                	mov    %al,(%edx)
  88:	83 c2 01             	add    $0x1,%edx
  8b:	84 c0                	test   %al,%al
  8d:	75 f1                	jne    80 <strcpy+0x10>
    ;
  return os;
}
  8f:	89 d8                	mov    %ebx,%eax
  91:	5b                   	pop    %ebx
  92:	5d                   	pop    %ebp
  93:	c3                   	ret    
  94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  a6:	53                   	push   %ebx
  a7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  aa:	0f b6 01             	movzbl (%ecx),%eax
  ad:	84 c0                	test   %al,%al
  af:	74 24                	je     d5 <strcmp+0x35>
  b1:	0f b6 13             	movzbl (%ebx),%edx
  b4:	38 d0                	cmp    %dl,%al
  b6:	74 12                	je     ca <strcmp+0x2a>
  b8:	eb 1e                	jmp    d8 <strcmp+0x38>
  ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  c0:	0f b6 13             	movzbl (%ebx),%edx
  c3:	83 c1 01             	add    $0x1,%ecx
  c6:	38 d0                	cmp    %dl,%al
  c8:	75 0e                	jne    d8 <strcmp+0x38>
  ca:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
  ce:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  d1:	84 c0                	test   %al,%al
  d3:	75 eb                	jne    c0 <strcmp+0x20>
  d5:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  d8:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  d9:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  dc:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  dd:	0f b6 d2             	movzbl %dl,%edx
  e0:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  e2:	c3                   	ret    
  e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000000f0 <strlen>:

uint
strlen(char *s)
{
  f0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
  f1:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
  f3:	89 e5                	mov    %esp,%ebp
  f5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  f8:	80 39 00             	cmpb   $0x0,(%ecx)
  fb:	74 0e                	je     10b <strlen+0x1b>
  fd:	31 d2                	xor    %edx,%edx
  ff:	90                   	nop    
 100:	83 c2 01             	add    $0x1,%edx
 103:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
 107:	89 d0                	mov    %edx,%eax
 109:	75 f5                	jne    100 <strlen+0x10>
    ;
  return n;
}
 10b:	5d                   	pop    %ebp
 10c:	c3                   	ret    
 10d:	8d 76 00             	lea    0x0(%esi),%esi

00000110 <memset>:

void*
memset(void *dst, int c, uint n)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	8b 55 08             	mov    0x8(%ebp),%edx
 116:	57                   	push   %edi
 117:	8b 45 0c             	mov    0xc(%ebp),%eax
 11a:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 11d:	89 d7                	mov    %edx,%edi
 11f:	fc                   	cld    
 120:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 122:	5f                   	pop    %edi
 123:	89 d0                	mov    %edx,%eax
 125:	5d                   	pop    %ebp
 126:	c3                   	ret    
 127:	89 f6                	mov    %esi,%esi
 129:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000130 <strchr>:

char*
strchr(const char *s, char c)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	8b 45 08             	mov    0x8(%ebp),%eax
 136:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 13a:	0f b6 10             	movzbl (%eax),%edx
 13d:	84 d2                	test   %dl,%dl
 13f:	75 0c                	jne    14d <strchr+0x1d>
 141:	eb 11                	jmp    154 <strchr+0x24>
 143:	83 c0 01             	add    $0x1,%eax
 146:	0f b6 10             	movzbl (%eax),%edx
 149:	84 d2                	test   %dl,%dl
 14b:	74 07                	je     154 <strchr+0x24>
    if(*s == c)
 14d:	38 ca                	cmp    %cl,%dl
 14f:	90                   	nop    
 150:	75 f1                	jne    143 <strchr+0x13>
      return (char*) s;
  return 0;
}
 152:	5d                   	pop    %ebp
 153:	c3                   	ret    
 154:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 155:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 157:	c3                   	ret    
 158:	90                   	nop    
 159:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000160 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	8b 4d 08             	mov    0x8(%ebp),%ecx
 166:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 167:	31 db                	xor    %ebx,%ebx
 169:	0f b6 11             	movzbl (%ecx),%edx
 16c:	8d 42 d0             	lea    -0x30(%edx),%eax
 16f:	3c 09                	cmp    $0x9,%al
 171:	77 18                	ja     18b <atoi+0x2b>
    n = n*10 + *s++ - '0';
 173:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 176:	0f be d2             	movsbl %dl,%edx
 179:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 17d:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 181:	83 c1 01             	add    $0x1,%ecx
 184:	8d 42 d0             	lea    -0x30(%edx),%eax
 187:	3c 09                	cmp    $0x9,%al
 189:	76 e8                	jbe    173 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 18b:	89 d8                	mov    %ebx,%eax
 18d:	5b                   	pop    %ebx
 18e:	5d                   	pop    %ebp
 18f:	c3                   	ret    

00000190 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	8b 4d 10             	mov    0x10(%ebp),%ecx
 196:	56                   	push   %esi
 197:	8b 75 08             	mov    0x8(%ebp),%esi
 19a:	53                   	push   %ebx
 19b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 19e:	85 c9                	test   %ecx,%ecx
 1a0:	7e 10                	jle    1b2 <memmove+0x22>
 1a2:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 1a4:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 1a8:	88 04 32             	mov    %al,(%edx,%esi,1)
 1ab:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1ae:	39 ca                	cmp    %ecx,%edx
 1b0:	75 f2                	jne    1a4 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 1b2:	89 f0                	mov    %esi,%eax
 1b4:	5b                   	pop    %ebx
 1b5:	5e                   	pop    %esi
 1b6:	5d                   	pop    %ebp
 1b7:	c3                   	ret    
 1b8:	90                   	nop    
 1b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000001c0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 1c9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1cc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 1cf:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1db:	00 
 1dc:	89 04 24             	mov    %eax,(%esp)
 1df:	e8 d4 00 00 00       	call   2b8 <open>
  if(fd < 0)
 1e4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 1e8:	78 19                	js     203 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 1ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ed:	89 1c 24             	mov    %ebx,(%esp)
 1f0:	89 44 24 04          	mov    %eax,0x4(%esp)
 1f4:	e8 d7 00 00 00       	call   2d0 <fstat>
  close(fd);
 1f9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 1fc:	89 c6                	mov    %eax,%esi
  close(fd);
 1fe:	e8 9d 00 00 00       	call   2a0 <close>
  return r;
}
 203:	89 f0                	mov    %esi,%eax
 205:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 208:	8b 75 fc             	mov    -0x4(%ebp),%esi
 20b:	89 ec                	mov    %ebp,%esp
 20d:	5d                   	pop    %ebp
 20e:	c3                   	ret    
 20f:	90                   	nop    

00000210 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	57                   	push   %edi
 214:	56                   	push   %esi
 215:	31 f6                	xor    %esi,%esi
 217:	53                   	push   %ebx
 218:	83 ec 1c             	sub    $0x1c,%esp
 21b:	8b 7d 08             	mov    0x8(%ebp),%edi
 21e:	eb 06                	jmp    226 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 220:	3c 0d                	cmp    $0xd,%al
 222:	74 39                	je     25d <gets+0x4d>
 224:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 226:	8d 5e 01             	lea    0x1(%esi),%ebx
 229:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 22c:	7d 31                	jge    25f <gets+0x4f>
    cc = read(0, &c, 1);
 22e:	8d 45 f3             	lea    -0xd(%ebp),%eax
 231:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 238:	00 
 239:	89 44 24 04          	mov    %eax,0x4(%esp)
 23d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 244:	e8 47 00 00 00       	call   290 <read>
    if(cc < 1)
 249:	85 c0                	test   %eax,%eax
 24b:	7e 12                	jle    25f <gets+0x4f>
      break;
    buf[i++] = c;
 24d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 251:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 255:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 259:	3c 0a                	cmp    $0xa,%al
 25b:	75 c3                	jne    220 <gets+0x10>
 25d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 25f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 263:	89 f8                	mov    %edi,%eax
 265:	83 c4 1c             	add    $0x1c,%esp
 268:	5b                   	pop    %ebx
 269:	5e                   	pop    %esi
 26a:	5f                   	pop    %edi
 26b:	5d                   	pop    %ebp
 26c:	c3                   	ret    
 26d:	90                   	nop    
 26e:	90                   	nop    
 26f:	90                   	nop    

00000270 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 270:	b8 01 00 00 00       	mov    $0x1,%eax
 275:	cd 40                	int    $0x40
 277:	c3                   	ret    

00000278 <exit>:
SYSCALL(exit)
 278:	b8 02 00 00 00       	mov    $0x2,%eax
 27d:	cd 40                	int    $0x40
 27f:	c3                   	ret    

00000280 <wait>:
SYSCALL(wait)
 280:	b8 03 00 00 00       	mov    $0x3,%eax
 285:	cd 40                	int    $0x40
 287:	c3                   	ret    

00000288 <pipe>:
SYSCALL(pipe)
 288:	b8 04 00 00 00       	mov    $0x4,%eax
 28d:	cd 40                	int    $0x40
 28f:	c3                   	ret    

00000290 <read>:
SYSCALL(read)
 290:	b8 06 00 00 00       	mov    $0x6,%eax
 295:	cd 40                	int    $0x40
 297:	c3                   	ret    

00000298 <write>:
SYSCALL(write)
 298:	b8 05 00 00 00       	mov    $0x5,%eax
 29d:	cd 40                	int    $0x40
 29f:	c3                   	ret    

000002a0 <close>:
SYSCALL(close)
 2a0:	b8 07 00 00 00       	mov    $0x7,%eax
 2a5:	cd 40                	int    $0x40
 2a7:	c3                   	ret    

000002a8 <kill>:
SYSCALL(kill)
 2a8:	b8 08 00 00 00       	mov    $0x8,%eax
 2ad:	cd 40                	int    $0x40
 2af:	c3                   	ret    

000002b0 <exec>:
SYSCALL(exec)
 2b0:	b8 09 00 00 00       	mov    $0x9,%eax
 2b5:	cd 40                	int    $0x40
 2b7:	c3                   	ret    

000002b8 <open>:
SYSCALL(open)
 2b8:	b8 0a 00 00 00       	mov    $0xa,%eax
 2bd:	cd 40                	int    $0x40
 2bf:	c3                   	ret    

000002c0 <mknod>:
SYSCALL(mknod)
 2c0:	b8 0b 00 00 00       	mov    $0xb,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <unlink>:
SYSCALL(unlink)
 2c8:	b8 0c 00 00 00       	mov    $0xc,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <fstat>:
SYSCALL(fstat)
 2d0:	b8 0d 00 00 00       	mov    $0xd,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <link>:
SYSCALL(link)
 2d8:	b8 0e 00 00 00       	mov    $0xe,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <mkdir>:
SYSCALL(mkdir)
 2e0:	b8 0f 00 00 00       	mov    $0xf,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <chdir>:
SYSCALL(chdir)
 2e8:	b8 10 00 00 00       	mov    $0x10,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <dup>:
SYSCALL(dup)
 2f0:	b8 11 00 00 00       	mov    $0x11,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <getpid>:
SYSCALL(getpid)
 2f8:	b8 12 00 00 00       	mov    $0x12,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <sbrk>:
SYSCALL(sbrk)
 300:	b8 13 00 00 00       	mov    $0x13,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <sleep>:
SYSCALL(sleep)
 308:	b8 14 00 00 00       	mov    $0x14,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <uptime>:
SYSCALL(uptime)
 310:	b8 15 00 00 00       	mov    $0x15,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <nice>:
SYSCALL(nice)
 318:	b8 16 00 00 00       	mov    $0x16,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <getpriority>:
SYSCALL(getpriority)
 320:	b8 17 00 00 00       	mov    $0x17,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <setpriority>:
SYSCALL(setpriority)
 328:	b8 18 00 00 00       	mov    $0x18,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <getaffinity>:
SYSCALL(getaffinity)
 330:	b8 19 00 00 00       	mov    $0x19,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <setaffinity>:
SYSCALL(setaffinity)
 338:	b8 1a 00 00 00       	mov    $0x1a,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	83 ec 18             	sub    $0x18,%esp
 346:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 349:	8d 55 fc             	lea    -0x4(%ebp),%edx
 34c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 353:	00 
 354:	89 54 24 04          	mov    %edx,0x4(%esp)
 358:	89 04 24             	mov    %eax,(%esp)
 35b:	e8 38 ff ff ff       	call   298 <write>
}
 360:	c9                   	leave  
 361:	c3                   	ret    
 362:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 369:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000370 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	57                   	push   %edi
 374:	56                   	push   %esi
 375:	89 ce                	mov    %ecx,%esi
 377:	53                   	push   %ebx
 378:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 37b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 37e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 381:	85 c9                	test   %ecx,%ecx
 383:	74 04                	je     389 <printint+0x19>
 385:	85 d2                	test   %edx,%edx
 387:	78 54                	js     3dd <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 389:	89 d0                	mov    %edx,%eax
 38b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 392:	31 db                	xor    %ebx,%ebx
 394:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 397:	31 d2                	xor    %edx,%edx
 399:	f7 f6                	div    %esi
 39b:	89 c1                	mov    %eax,%ecx
 39d:	0f b6 82 e0 06 00 00 	movzbl 0x6e0(%edx),%eax
 3a4:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 3a7:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 3aa:	85 c9                	test   %ecx,%ecx
 3ac:	89 c8                	mov    %ecx,%eax
 3ae:	75 e7                	jne    397 <printint+0x27>
  if(neg)
 3b0:	8b 45 e0             	mov    -0x20(%ebp),%eax
 3b3:	85 c0                	test   %eax,%eax
 3b5:	74 08                	je     3bf <printint+0x4f>
    buf[i++] = '-';
 3b7:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 3bc:	83 c3 01             	add    $0x1,%ebx
 3bf:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 3c2:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 3c6:	83 eb 01             	sub    $0x1,%ebx
 3c9:	8b 45 dc             	mov    -0x24(%ebp),%eax
 3cc:	e8 6f ff ff ff       	call   340 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3d1:	39 fb                	cmp    %edi,%ebx
 3d3:	75 ed                	jne    3c2 <printint+0x52>
    putc(fd, buf[i]);
}
 3d5:	83 c4 1c             	add    $0x1c,%esp
 3d8:	5b                   	pop    %ebx
 3d9:	5e                   	pop    %esi
 3da:	5f                   	pop    %edi
 3db:	5d                   	pop    %ebp
 3dc:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3dd:	89 d0                	mov    %edx,%eax
 3df:	f7 d8                	neg    %eax
 3e1:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 3e8:	eb a8                	jmp    392 <printint+0x22>
 3ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003f0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	56                   	push   %esi
 3f5:	53                   	push   %ebx
 3f6:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3f9:	8b 55 0c             	mov    0xc(%ebp),%edx
 3fc:	0f b6 02             	movzbl (%edx),%eax
 3ff:	84 c0                	test   %al,%al
 401:	0f 84 87 00 00 00    	je     48e <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 407:	8d 4d 10             	lea    0x10(%ebp),%ecx
 40a:	31 ff                	xor    %edi,%edi
 40c:	31 f6                	xor    %esi,%esi
 40e:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 411:	eb 18                	jmp    42b <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 413:	83 fb 25             	cmp    $0x25,%ebx
 416:	0f 85 7a 00 00 00    	jne    496 <printf+0xa6>
 41c:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 420:	83 c7 01             	add    $0x1,%edi
 423:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 427:	84 c0                	test   %al,%al
 429:	74 63                	je     48e <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 42b:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 42d:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 430:	74 e1                	je     413 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 432:	83 fe 25             	cmp    $0x25,%esi
 435:	75 e9                	jne    420 <printf+0x30>
      if(c == 'd'){
 437:	83 fb 64             	cmp    $0x64,%ebx
 43a:	0f 84 f0 00 00 00    	je     530 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 440:	83 fb 78             	cmp    $0x78,%ebx
 443:	74 64                	je     4a9 <printf+0xb9>
 445:	83 fb 70             	cmp    $0x70,%ebx
 448:	74 5f                	je     4a9 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 44a:	83 fb 73             	cmp    $0x73,%ebx
 44d:	8d 76 00             	lea    0x0(%esi),%esi
 450:	74 7e                	je     4d0 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 452:	83 fb 63             	cmp    $0x63,%ebx
 455:	0f 84 b9 00 00 00    	je     514 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 45b:	83 fb 25             	cmp    $0x25,%ebx
 45e:	66 90                	xchg   %ax,%ax
 460:	0f 84 f2 00 00 00    	je     558 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 466:	8b 45 08             	mov    0x8(%ebp),%eax
 469:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 46e:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 471:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 473:	e8 c8 fe ff ff       	call   340 <putc>
        putc(fd, c);
 478:	8b 45 08             	mov    0x8(%ebp),%eax
 47b:	0f be d3             	movsbl %bl,%edx
 47e:	e8 bd fe ff ff       	call   340 <putc>
 483:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 486:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 48a:	84 c0                	test   %al,%al
 48c:	75 9d                	jne    42b <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 48e:	83 c4 0c             	add    $0xc,%esp
 491:	5b                   	pop    %ebx
 492:	5e                   	pop    %esi
 493:	5f                   	pop    %edi
 494:	5d                   	pop    %ebp
 495:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 496:	8b 45 08             	mov    0x8(%ebp),%eax
 499:	0f be d3             	movsbl %bl,%edx
 49c:	e8 9f fe ff ff       	call   340 <putc>
 4a1:	8b 55 0c             	mov    0xc(%ebp),%edx
 4a4:	e9 77 ff ff ff       	jmp    420 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4ac:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 4b1:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4b3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4ba:	8b 10                	mov    (%eax),%edx
 4bc:	8b 45 08             	mov    0x8(%ebp),%eax
 4bf:	e8 ac fe ff ff       	call   370 <printint>
 4c4:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 4c7:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 4cb:	e9 50 ff ff ff       	jmp    420 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 4d0:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 4d3:	8b 01                	mov    (%ecx),%eax
        ap++;
 4d5:	83 c1 04             	add    $0x4,%ecx
 4d8:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 4db:	b9 d9 06 00 00       	mov    $0x6d9,%ecx
 4e0:	85 c0                	test   %eax,%eax
 4e2:	75 2c                	jne    510 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 4e4:	0f b6 01             	movzbl (%ecx),%eax
 4e7:	84 c0                	test   %al,%al
 4e9:	74 1e                	je     509 <printf+0x119>
 4eb:	89 cb                	mov    %ecx,%ebx
 4ed:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 4f0:	0f be d0             	movsbl %al,%edx
 4f3:	8b 45 08             	mov    0x8(%ebp),%eax
 4f6:	e8 45 fe ff ff       	call   340 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 4fb:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 4ff:	83 c3 01             	add    $0x1,%ebx
 502:	84 c0                	test   %al,%al
 504:	75 ea                	jne    4f0 <printf+0x100>
 506:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 509:	31 f6                	xor    %esi,%esi
 50b:	e9 10 ff ff ff       	jmp    420 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 510:	89 c1                	mov    %eax,%ecx
 512:	eb d0                	jmp    4e4 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 514:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 517:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 519:	0f be 10             	movsbl (%eax),%edx
 51c:	8b 45 08             	mov    0x8(%ebp),%eax
 51f:	e8 1c fe ff ff       	call   340 <putc>
 524:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 527:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 52b:	e9 f0 fe ff ff       	jmp    420 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 530:	8b 45 f0             	mov    -0x10(%ebp),%eax
 533:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 538:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 53b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 542:	8b 10                	mov    (%eax),%edx
 544:	8b 45 08             	mov    0x8(%ebp),%eax
 547:	e8 24 fe ff ff       	call   370 <printint>
 54c:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 54f:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 553:	e9 c8 fe ff ff       	jmp    420 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 558:	8b 45 08             	mov    0x8(%ebp),%eax
 55b:	ba 25 00 00 00       	mov    $0x25,%edx
 560:	31 f6                	xor    %esi,%esi
 562:	e8 d9 fd ff ff       	call   340 <putc>
 567:	8b 55 0c             	mov    0xc(%ebp),%edx
 56a:	e9 b1 fe ff ff       	jmp    420 <printf+0x30>
 56f:	90                   	nop    

00000570 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 570:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 571:	8b 0d fc 06 00 00    	mov    0x6fc,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 577:	89 e5                	mov    %esp,%ebp
 579:	56                   	push   %esi
 57a:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 57b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 57e:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 581:	39 d9                	cmp    %ebx,%ecx
 583:	73 18                	jae    59d <free+0x2d>
 585:	8b 11                	mov    (%ecx),%edx
 587:	39 d3                	cmp    %edx,%ebx
 589:	72 17                	jb     5a2 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 58b:	39 d1                	cmp    %edx,%ecx
 58d:	72 08                	jb     597 <free+0x27>
 58f:	39 d9                	cmp    %ebx,%ecx
 591:	72 0f                	jb     5a2 <free+0x32>
 593:	39 d3                	cmp    %edx,%ebx
 595:	72 0b                	jb     5a2 <free+0x32>
 597:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 599:	39 d9                	cmp    %ebx,%ecx
 59b:	72 e8                	jb     585 <free+0x15>
 59d:	8b 11                	mov    (%ecx),%edx
 59f:	90                   	nop    
 5a0:	eb e9                	jmp    58b <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 5a2:	8b 73 04             	mov    0x4(%ebx),%esi
 5a5:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 5a8:	39 d0                	cmp    %edx,%eax
 5aa:	74 18                	je     5c4 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5ac:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 5ae:	8b 51 04             	mov    0x4(%ecx),%edx
 5b1:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 5b4:	39 d8                	cmp    %ebx,%eax
 5b6:	74 20                	je     5d8 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5b8:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 5ba:	5b                   	pop    %ebx
 5bb:	5e                   	pop    %esi
 5bc:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 5bd:	89 0d fc 06 00 00    	mov    %ecx,0x6fc
}
 5c3:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 5c4:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 5c7:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 5c9:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5cc:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 5cf:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5d1:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 5d4:	39 d8                	cmp    %ebx,%eax
 5d6:	75 e0                	jne    5b8 <free+0x48>
    p->s.size += bp->s.size;
 5d8:	03 53 04             	add    0x4(%ebx),%edx
 5db:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 5de:	8b 13                	mov    (%ebx),%edx
 5e0:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 5e2:	5b                   	pop    %ebx
 5e3:	5e                   	pop    %esi
 5e4:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 5e5:	89 0d fc 06 00 00    	mov    %ecx,0x6fc
}
 5eb:	c3                   	ret    
 5ec:	8d 74 26 00          	lea    0x0(%esi),%esi

000005f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	57                   	push   %edi
 5f4:	56                   	push   %esi
 5f5:	53                   	push   %ebx
 5f6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 5fc:	8b 15 fc 06 00 00    	mov    0x6fc,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 602:	83 c0 07             	add    $0x7,%eax
 605:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 608:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 60a:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 60d:	0f 84 8a 00 00 00    	je     69d <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 613:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 615:	8b 41 04             	mov    0x4(%ecx),%eax
 618:	39 c3                	cmp    %eax,%ebx
 61a:	76 1a                	jbe    636 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 61c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 623:	3b 0d fc 06 00 00    	cmp    0x6fc,%ecx
 629:	89 ca                	mov    %ecx,%edx
 62b:	74 29                	je     656 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 62d:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 62f:	8b 41 04             	mov    0x4(%ecx),%eax
 632:	39 c3                	cmp    %eax,%ebx
 634:	77 ed                	ja     623 <malloc+0x33>
      if(p->s.size == nunits)
 636:	39 c3                	cmp    %eax,%ebx
 638:	74 5d                	je     697 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 63a:	29 d8                	sub    %ebx,%eax
 63c:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 63f:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 642:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 645:	89 15 fc 06 00 00    	mov    %edx,0x6fc
      return (void*) (p + 1);
 64b:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 64e:	83 c4 0c             	add    $0xc,%esp
 651:	5b                   	pop    %ebx
 652:	5e                   	pop    %esi
 653:	5f                   	pop    %edi
 654:	5d                   	pop    %ebp
 655:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 656:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 65c:	89 de                	mov    %ebx,%esi
 65e:	89 f8                	mov    %edi,%eax
 660:	76 29                	jbe    68b <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 662:	89 04 24             	mov    %eax,(%esp)
 665:	e8 96 fc ff ff       	call   300 <sbrk>
  if(p == (char*) -1)
 66a:	83 f8 ff             	cmp    $0xffffffff,%eax
 66d:	74 18                	je     687 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 66f:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 672:	83 c0 08             	add    $0x8,%eax
 675:	89 04 24             	mov    %eax,(%esp)
 678:	e8 f3 fe ff ff       	call   570 <free>
  return freep;
 67d:	8b 15 fc 06 00 00    	mov    0x6fc,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 683:	85 d2                	test   %edx,%edx
 685:	75 a6                	jne    62d <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 687:	31 c0                	xor    %eax,%eax
 689:	eb c3                	jmp    64e <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 68b:	be 00 10 00 00       	mov    $0x1000,%esi
 690:	b8 00 80 00 00       	mov    $0x8000,%eax
 695:	eb cb                	jmp    662 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 697:	8b 01                	mov    (%ecx),%eax
 699:	89 02                	mov    %eax,(%edx)
 69b:	eb a8                	jmp    645 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 69d:	ba f4 06 00 00       	mov    $0x6f4,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 6a2:	c7 05 fc 06 00 00 f4 	movl   $0x6f4,0x6fc
 6a9:	06 00 00 
 6ac:	c7 05 f4 06 00 00 f4 	movl   $0x6f4,0x6f4
 6b3:	06 00 00 
    base.s.size = 0;
 6b6:	c7 05 f8 06 00 00 00 	movl   $0x0,0x6f8
 6bd:	00 00 00 
 6c0:	e9 4e ff ff ff       	jmp    613 <malloc+0x23>
