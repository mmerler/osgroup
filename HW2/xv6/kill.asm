
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
  25:	c7 44 24 04 a5 06 00 	movl   $0x6a5,0x4(%esp)
  2c:	00 
  2d:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  34:	e8 97 03 00 00       	call   3d0 <printf>
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
 318:	90                   	nop    
 319:	90                   	nop    
 31a:	90                   	nop    
 31b:	90                   	nop    
 31c:	90                   	nop    
 31d:	90                   	nop    
 31e:	90                   	nop    
 31f:	90                   	nop    

00000320 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	83 ec 18             	sub    $0x18,%esp
 326:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 329:	8d 55 fc             	lea    -0x4(%ebp),%edx
 32c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 333:	00 
 334:	89 54 24 04          	mov    %edx,0x4(%esp)
 338:	89 04 24             	mov    %eax,(%esp)
 33b:	e8 58 ff ff ff       	call   298 <write>
}
 340:	c9                   	leave  
 341:	c3                   	ret    
 342:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 349:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000350 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	57                   	push   %edi
 354:	56                   	push   %esi
 355:	89 ce                	mov    %ecx,%esi
 357:	53                   	push   %ebx
 358:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 35b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 35e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 361:	85 c9                	test   %ecx,%ecx
 363:	74 04                	je     369 <printint+0x19>
 365:	85 d2                	test   %edx,%edx
 367:	78 54                	js     3bd <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 369:	89 d0                	mov    %edx,%eax
 36b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 372:	31 db                	xor    %ebx,%ebx
 374:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 377:	31 d2                	xor    %edx,%edx
 379:	f7 f6                	div    %esi
 37b:	89 c1                	mov    %eax,%ecx
 37d:	0f b6 82 c0 06 00 00 	movzbl 0x6c0(%edx),%eax
 384:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 387:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 38a:	85 c9                	test   %ecx,%ecx
 38c:	89 c8                	mov    %ecx,%eax
 38e:	75 e7                	jne    377 <printint+0x27>
  if(neg)
 390:	8b 45 e0             	mov    -0x20(%ebp),%eax
 393:	85 c0                	test   %eax,%eax
 395:	74 08                	je     39f <printint+0x4f>
    buf[i++] = '-';
 397:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 39c:	83 c3 01             	add    $0x1,%ebx
 39f:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 3a2:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 3a6:	83 eb 01             	sub    $0x1,%ebx
 3a9:	8b 45 dc             	mov    -0x24(%ebp),%eax
 3ac:	e8 6f ff ff ff       	call   320 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3b1:	39 fb                	cmp    %edi,%ebx
 3b3:	75 ed                	jne    3a2 <printint+0x52>
    putc(fd, buf[i]);
}
 3b5:	83 c4 1c             	add    $0x1c,%esp
 3b8:	5b                   	pop    %ebx
 3b9:	5e                   	pop    %esi
 3ba:	5f                   	pop    %edi
 3bb:	5d                   	pop    %ebp
 3bc:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3bd:	89 d0                	mov    %edx,%eax
 3bf:	f7 d8                	neg    %eax
 3c1:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 3c8:	eb a8                	jmp    372 <printint+0x22>
 3ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003d0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	57                   	push   %edi
 3d4:	56                   	push   %esi
 3d5:	53                   	push   %ebx
 3d6:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3d9:	8b 55 0c             	mov    0xc(%ebp),%edx
 3dc:	0f b6 02             	movzbl (%edx),%eax
 3df:	84 c0                	test   %al,%al
 3e1:	0f 84 87 00 00 00    	je     46e <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 3e7:	8d 4d 10             	lea    0x10(%ebp),%ecx
 3ea:	31 ff                	xor    %edi,%edi
 3ec:	31 f6                	xor    %esi,%esi
 3ee:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 3f1:	eb 18                	jmp    40b <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3f3:	83 fb 25             	cmp    $0x25,%ebx
 3f6:	0f 85 7a 00 00 00    	jne    476 <printf+0xa6>
 3fc:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 400:	83 c7 01             	add    $0x1,%edi
 403:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 407:	84 c0                	test   %al,%al
 409:	74 63                	je     46e <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 40b:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 40d:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 410:	74 e1                	je     3f3 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 412:	83 fe 25             	cmp    $0x25,%esi
 415:	75 e9                	jne    400 <printf+0x30>
      if(c == 'd'){
 417:	83 fb 64             	cmp    $0x64,%ebx
 41a:	0f 84 f0 00 00 00    	je     510 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 420:	83 fb 78             	cmp    $0x78,%ebx
 423:	74 64                	je     489 <printf+0xb9>
 425:	83 fb 70             	cmp    $0x70,%ebx
 428:	74 5f                	je     489 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 42a:	83 fb 73             	cmp    $0x73,%ebx
 42d:	8d 76 00             	lea    0x0(%esi),%esi
 430:	74 7e                	je     4b0 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 432:	83 fb 63             	cmp    $0x63,%ebx
 435:	0f 84 b9 00 00 00    	je     4f4 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 43b:	83 fb 25             	cmp    $0x25,%ebx
 43e:	66 90                	xchg   %ax,%ax
 440:	0f 84 f2 00 00 00    	je     538 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 446:	8b 45 08             	mov    0x8(%ebp),%eax
 449:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 44e:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 451:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 453:	e8 c8 fe ff ff       	call   320 <putc>
        putc(fd, c);
 458:	8b 45 08             	mov    0x8(%ebp),%eax
 45b:	0f be d3             	movsbl %bl,%edx
 45e:	e8 bd fe ff ff       	call   320 <putc>
 463:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 466:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 46a:	84 c0                	test   %al,%al
 46c:	75 9d                	jne    40b <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 46e:	83 c4 0c             	add    $0xc,%esp
 471:	5b                   	pop    %ebx
 472:	5e                   	pop    %esi
 473:	5f                   	pop    %edi
 474:	5d                   	pop    %ebp
 475:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 476:	8b 45 08             	mov    0x8(%ebp),%eax
 479:	0f be d3             	movsbl %bl,%edx
 47c:	e8 9f fe ff ff       	call   320 <putc>
 481:	8b 55 0c             	mov    0xc(%ebp),%edx
 484:	e9 77 ff ff ff       	jmp    400 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 489:	8b 45 f0             	mov    -0x10(%ebp),%eax
 48c:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 491:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 493:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 49a:	8b 10                	mov    (%eax),%edx
 49c:	8b 45 08             	mov    0x8(%ebp),%eax
 49f:	e8 ac fe ff ff       	call   350 <printint>
 4a4:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 4a7:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 4ab:	e9 50 ff ff ff       	jmp    400 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 4b0:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 4b3:	8b 01                	mov    (%ecx),%eax
        ap++;
 4b5:	83 c1 04             	add    $0x4,%ecx
 4b8:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 4bb:	b9 b9 06 00 00       	mov    $0x6b9,%ecx
 4c0:	85 c0                	test   %eax,%eax
 4c2:	75 2c                	jne    4f0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 4c4:	0f b6 01             	movzbl (%ecx),%eax
 4c7:	84 c0                	test   %al,%al
 4c9:	74 1e                	je     4e9 <printf+0x119>
 4cb:	89 cb                	mov    %ecx,%ebx
 4cd:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 4d0:	0f be d0             	movsbl %al,%edx
 4d3:	8b 45 08             	mov    0x8(%ebp),%eax
 4d6:	e8 45 fe ff ff       	call   320 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 4db:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 4df:	83 c3 01             	add    $0x1,%ebx
 4e2:	84 c0                	test   %al,%al
 4e4:	75 ea                	jne    4d0 <printf+0x100>
 4e6:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4e9:	31 f6                	xor    %esi,%esi
 4eb:	e9 10 ff ff ff       	jmp    400 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 4f0:	89 c1                	mov    %eax,%ecx
 4f2:	eb d0                	jmp    4c4 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 4f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 4f7:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 4f9:	0f be 10             	movsbl (%eax),%edx
 4fc:	8b 45 08             	mov    0x8(%ebp),%eax
 4ff:	e8 1c fe ff ff       	call   320 <putc>
 504:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 507:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 50b:	e9 f0 fe ff ff       	jmp    400 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 510:	8b 45 f0             	mov    -0x10(%ebp),%eax
 513:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 518:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 51b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 522:	8b 10                	mov    (%eax),%edx
 524:	8b 45 08             	mov    0x8(%ebp),%eax
 527:	e8 24 fe ff ff       	call   350 <printint>
 52c:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 52f:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 533:	e9 c8 fe ff ff       	jmp    400 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 538:	8b 45 08             	mov    0x8(%ebp),%eax
 53b:	ba 25 00 00 00       	mov    $0x25,%edx
 540:	31 f6                	xor    %esi,%esi
 542:	e8 d9 fd ff ff       	call   320 <putc>
 547:	8b 55 0c             	mov    0xc(%ebp),%edx
 54a:	e9 b1 fe ff ff       	jmp    400 <printf+0x30>
 54f:	90                   	nop    

00000550 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 550:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 551:	8b 0d dc 06 00 00    	mov    0x6dc,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 557:	89 e5                	mov    %esp,%ebp
 559:	56                   	push   %esi
 55a:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 55b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 55e:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 561:	39 d9                	cmp    %ebx,%ecx
 563:	73 18                	jae    57d <free+0x2d>
 565:	8b 11                	mov    (%ecx),%edx
 567:	39 d3                	cmp    %edx,%ebx
 569:	72 17                	jb     582 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 56b:	39 d1                	cmp    %edx,%ecx
 56d:	72 08                	jb     577 <free+0x27>
 56f:	39 d9                	cmp    %ebx,%ecx
 571:	72 0f                	jb     582 <free+0x32>
 573:	39 d3                	cmp    %edx,%ebx
 575:	72 0b                	jb     582 <free+0x32>
 577:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 579:	39 d9                	cmp    %ebx,%ecx
 57b:	72 e8                	jb     565 <free+0x15>
 57d:	8b 11                	mov    (%ecx),%edx
 57f:	90                   	nop    
 580:	eb e9                	jmp    56b <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 582:	8b 73 04             	mov    0x4(%ebx),%esi
 585:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 588:	39 d0                	cmp    %edx,%eax
 58a:	74 18                	je     5a4 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 58c:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 58e:	8b 51 04             	mov    0x4(%ecx),%edx
 591:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 594:	39 d8                	cmp    %ebx,%eax
 596:	74 20                	je     5b8 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 598:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 59a:	5b                   	pop    %ebx
 59b:	5e                   	pop    %esi
 59c:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 59d:	89 0d dc 06 00 00    	mov    %ecx,0x6dc
}
 5a3:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 5a4:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 5a7:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 5a9:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5ac:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 5af:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5b1:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 5b4:	39 d8                	cmp    %ebx,%eax
 5b6:	75 e0                	jne    598 <free+0x48>
    p->s.size += bp->s.size;
 5b8:	03 53 04             	add    0x4(%ebx),%edx
 5bb:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 5be:	8b 13                	mov    (%ebx),%edx
 5c0:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 5c2:	5b                   	pop    %ebx
 5c3:	5e                   	pop    %esi
 5c4:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 5c5:	89 0d dc 06 00 00    	mov    %ecx,0x6dc
}
 5cb:	c3                   	ret    
 5cc:	8d 74 26 00          	lea    0x0(%esi),%esi

000005d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5d0:	55                   	push   %ebp
 5d1:	89 e5                	mov    %esp,%ebp
 5d3:	57                   	push   %edi
 5d4:	56                   	push   %esi
 5d5:	53                   	push   %ebx
 5d6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5d9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 5dc:	8b 15 dc 06 00 00    	mov    0x6dc,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5e2:	83 c0 07             	add    $0x7,%eax
 5e5:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 5e8:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5ea:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 5ed:	0f 84 8a 00 00 00    	je     67d <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5f3:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 5f5:	8b 41 04             	mov    0x4(%ecx),%eax
 5f8:	39 c3                	cmp    %eax,%ebx
 5fa:	76 1a                	jbe    616 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 5fc:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 603:	3b 0d dc 06 00 00    	cmp    0x6dc,%ecx
 609:	89 ca                	mov    %ecx,%edx
 60b:	74 29                	je     636 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 60d:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 60f:	8b 41 04             	mov    0x4(%ecx),%eax
 612:	39 c3                	cmp    %eax,%ebx
 614:	77 ed                	ja     603 <malloc+0x33>
      if(p->s.size == nunits)
 616:	39 c3                	cmp    %eax,%ebx
 618:	74 5d                	je     677 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 61a:	29 d8                	sub    %ebx,%eax
 61c:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 61f:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 622:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 625:	89 15 dc 06 00 00    	mov    %edx,0x6dc
      return (void*) (p + 1);
 62b:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 62e:	83 c4 0c             	add    $0xc,%esp
 631:	5b                   	pop    %ebx
 632:	5e                   	pop    %esi
 633:	5f                   	pop    %edi
 634:	5d                   	pop    %ebp
 635:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 636:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 63c:	89 de                	mov    %ebx,%esi
 63e:	89 f8                	mov    %edi,%eax
 640:	76 29                	jbe    66b <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 642:	89 04 24             	mov    %eax,(%esp)
 645:	e8 b6 fc ff ff       	call   300 <sbrk>
  if(p == (char*) -1)
 64a:	83 f8 ff             	cmp    $0xffffffff,%eax
 64d:	74 18                	je     667 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 64f:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 652:	83 c0 08             	add    $0x8,%eax
 655:	89 04 24             	mov    %eax,(%esp)
 658:	e8 f3 fe ff ff       	call   550 <free>
  return freep;
 65d:	8b 15 dc 06 00 00    	mov    0x6dc,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 663:	85 d2                	test   %edx,%edx
 665:	75 a6                	jne    60d <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 667:	31 c0                	xor    %eax,%eax
 669:	eb c3                	jmp    62e <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 66b:	be 00 10 00 00       	mov    $0x1000,%esi
 670:	b8 00 80 00 00       	mov    $0x8000,%eax
 675:	eb cb                	jmp    642 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 677:	8b 01                	mov    (%ecx),%eax
 679:	89 02                	mov    %eax,(%edx)
 67b:	eb a8                	jmp    625 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 67d:	ba d4 06 00 00       	mov    $0x6d4,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 682:	c7 05 dc 06 00 00 d4 	movl   $0x6d4,0x6dc
 689:	06 00 00 
 68c:	c7 05 d4 06 00 00 d4 	movl   $0x6d4,0x6d4
 693:	06 00 00 
    base.s.size = 0;
 696:	c7 05 d8 06 00 00 00 	movl   $0x0,0x6d8
 69d:	00 00 00 
 6a0:	e9 4e ff ff ff       	jmp    5f3 <malloc+0x23>
