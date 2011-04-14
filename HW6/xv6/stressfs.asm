
_stressfs:     file format elf32-i386

Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
  int i;
  printf(1, "stressfs starting\n");
   f:	31 db                	xor    %ebx,%ebx
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
  11:	51                   	push   %ecx
  12:	83 ec 1c             	sub    $0x1c,%esp
  int i;
  printf(1, "stressfs starting\n");
  15:	c7 44 24 04 05 07 00 	movl   $0x705,0x4(%esp)
  1c:	00 
  1d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  24:	e8 07 04 00 00       	call   430 <printf>

  for(i = 0; i < 4; i++){
    if(fork() > 0){
  29:	e8 a2 02 00 00       	call   2d0 <fork>
  2e:	85 c0                	test   %eax,%eax
  30:	7f 08                	jg     3a <main+0x3a>
main(int argc, char *argv[])
{
  int i;
  printf(1, "stressfs starting\n");

  for(i = 0; i < 4; i++){
  32:	83 c3 01             	add    $0x1,%ebx
  35:	83 fb 04             	cmp    $0x4,%ebx
  38:	75 ef                	jne    29 <main+0x29>
    if(fork() > 0){
      break;
    }
  }

  printf(1, "%d\n", i);
  3a:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  3e:	c7 44 24 04 18 07 00 	movl   $0x718,0x4(%esp)
  45:	00 
  46:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  4d:	e8 de 03 00 00       	call   430 <printf>

  char path[] = "stressfs0";
  52:	a1 1c 07 00 00       	mov    0x71c,%eax
  path[8] += i;
  int fd = open(path, O_CREATE | O_RDWR);
  57:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
  5e:	00 
    }
  }

  printf(1, "%d\n", i);

  char path[] = "stressfs0";
  5f:	89 45 ea             	mov    %eax,-0x16(%ebp)
  62:	a1 20 07 00 00       	mov    0x720,%eax
  67:	89 45 ee             	mov    %eax,-0x12(%ebp)
  6a:	0f b7 05 24 07 00 00 	movzwl 0x724,%eax
  71:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
  path[8] += i;
  int fd = open(path, O_CREATE | O_RDWR);
  75:	8d 45 ea             	lea    -0x16(%ebp),%eax
  }

  printf(1, "%d\n", i);

  char path[] = "stressfs0";
  path[8] += i;
  78:	00 5d f2             	add    %bl,-0xe(%ebp)
  int fd = open(path, O_CREATE | O_RDWR);
  for(i = 0; i < 100; i++)
    printf(fd, "%d\n", i);
  7b:	bb 01 00 00 00       	mov    $0x1,%ebx

  printf(1, "%d\n", i);

  char path[] = "stressfs0";
  path[8] += i;
  int fd = open(path, O_CREATE | O_RDWR);
  80:	89 04 24             	mov    %eax,(%esp)
  83:	e8 90 02 00 00       	call   318 <open>
  for(i = 0; i < 100; i++)
    printf(fd, "%d\n", i);
  88:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  8f:	00 
  90:	c7 44 24 04 18 07 00 	movl   $0x718,0x4(%esp)
  97:	00 

  printf(1, "%d\n", i);

  char path[] = "stressfs0";
  path[8] += i;
  int fd = open(path, O_CREATE | O_RDWR);
  98:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 100; i++)
    printf(fd, "%d\n", i);
  9a:	89 04 24             	mov    %eax,(%esp)
  9d:	e8 8e 03 00 00       	call   430 <printf>
  a2:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  printf(1, "%d\n", i);

  char path[] = "stressfs0";
  path[8] += i;
  int fd = open(path, O_CREATE | O_RDWR);
  for(i = 0; i < 100; i++)
  a6:	83 c3 01             	add    $0x1,%ebx
    printf(fd, "%d\n", i);
  a9:	c7 44 24 04 18 07 00 	movl   $0x718,0x4(%esp)
  b0:	00 
  b1:	89 34 24             	mov    %esi,(%esp)
  b4:	e8 77 03 00 00       	call   430 <printf>
  printf(1, "%d\n", i);

  char path[] = "stressfs0";
  path[8] += i;
  int fd = open(path, O_CREATE | O_RDWR);
  for(i = 0; i < 100; i++)
  b9:	83 fb 64             	cmp    $0x64,%ebx
  bc:	75 e4                	jne    a2 <main+0xa2>
    printf(fd, "%d\n", i);
  close(fd);
  be:	89 34 24             	mov    %esi,(%esp)
  c1:	e8 3a 02 00 00       	call   300 <close>

  wait();
  c6:	e8 15 02 00 00       	call   2e0 <wait>
  
  exit();
  cb:	e8 08 02 00 00       	call   2d8 <exit>

000000d0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	53                   	push   %ebx
  d4:	8b 5d 08             	mov    0x8(%ebp),%ebx
  d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  da:	89 da                	mov    %ebx,%edx
  dc:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  e0:	0f b6 01             	movzbl (%ecx),%eax
  e3:	83 c1 01             	add    $0x1,%ecx
  e6:	88 02                	mov    %al,(%edx)
  e8:	83 c2 01             	add    $0x1,%edx
  eb:	84 c0                	test   %al,%al
  ed:	75 f1                	jne    e0 <strcpy+0x10>
    ;
  return os;
}
  ef:	89 d8                	mov    %ebx,%eax
  f1:	5b                   	pop    %ebx
  f2:	5d                   	pop    %ebp
  f3:	c3                   	ret    
  f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000100 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 4d 08             	mov    0x8(%ebp),%ecx
 106:	53                   	push   %ebx
 107:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 10a:	0f b6 01             	movzbl (%ecx),%eax
 10d:	84 c0                	test   %al,%al
 10f:	74 24                	je     135 <strcmp+0x35>
 111:	0f b6 13             	movzbl (%ebx),%edx
 114:	38 d0                	cmp    %dl,%al
 116:	74 12                	je     12a <strcmp+0x2a>
 118:	eb 1e                	jmp    138 <strcmp+0x38>
 11a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 120:	0f b6 13             	movzbl (%ebx),%edx
 123:	83 c1 01             	add    $0x1,%ecx
 126:	38 d0                	cmp    %dl,%al
 128:	75 0e                	jne    138 <strcmp+0x38>
 12a:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 12e:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 131:	84 c0                	test   %al,%al
 133:	75 eb                	jne    120 <strcmp+0x20>
 135:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 138:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 139:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 13c:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 13d:	0f b6 d2             	movzbl %dl,%edx
 140:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 142:	c3                   	ret    
 143:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 149:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000150 <strlen>:

uint
strlen(char *s)
{
 150:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 151:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 153:	89 e5                	mov    %esp,%ebp
 155:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 158:	80 39 00             	cmpb   $0x0,(%ecx)
 15b:	74 0e                	je     16b <strlen+0x1b>
 15d:	31 d2                	xor    %edx,%edx
 15f:	90                   	nop    
 160:	83 c2 01             	add    $0x1,%edx
 163:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
 167:	89 d0                	mov    %edx,%eax
 169:	75 f5                	jne    160 <strlen+0x10>
    ;
  return n;
}
 16b:	5d                   	pop    %ebp
 16c:	c3                   	ret    
 16d:	8d 76 00             	lea    0x0(%esi),%esi

00000170 <memset>:

void*
memset(void *dst, int c, uint n)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	8b 55 08             	mov    0x8(%ebp),%edx
 176:	57                   	push   %edi
 177:	8b 45 0c             	mov    0xc(%ebp),%eax
 17a:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 17d:	89 d7                	mov    %edx,%edi
 17f:	fc                   	cld    
 180:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 182:	5f                   	pop    %edi
 183:	89 d0                	mov    %edx,%eax
 185:	5d                   	pop    %ebp
 186:	c3                   	ret    
 187:	89 f6                	mov    %esi,%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000190 <strchr>:

char*
strchr(const char *s, char c)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	8b 45 08             	mov    0x8(%ebp),%eax
 196:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 19a:	0f b6 10             	movzbl (%eax),%edx
 19d:	84 d2                	test   %dl,%dl
 19f:	75 0c                	jne    1ad <strchr+0x1d>
 1a1:	eb 11                	jmp    1b4 <strchr+0x24>
 1a3:	83 c0 01             	add    $0x1,%eax
 1a6:	0f b6 10             	movzbl (%eax),%edx
 1a9:	84 d2                	test   %dl,%dl
 1ab:	74 07                	je     1b4 <strchr+0x24>
    if(*s == c)
 1ad:	38 ca                	cmp    %cl,%dl
 1af:	90                   	nop    
 1b0:	75 f1                	jne    1a3 <strchr+0x13>
      return (char*) s;
  return 0;
}
 1b2:	5d                   	pop    %ebp
 1b3:	c3                   	ret    
 1b4:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1b5:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 1b7:	c3                   	ret    
 1b8:	90                   	nop    
 1b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000001c0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1c6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1c7:	31 db                	xor    %ebx,%ebx
 1c9:	0f b6 11             	movzbl (%ecx),%edx
 1cc:	8d 42 d0             	lea    -0x30(%edx),%eax
 1cf:	3c 09                	cmp    $0x9,%al
 1d1:	77 18                	ja     1eb <atoi+0x2b>
    n = n*10 + *s++ - '0';
 1d3:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 1d6:	0f be d2             	movsbl %dl,%edx
 1d9:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1dd:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 1e1:	83 c1 01             	add    $0x1,%ecx
 1e4:	8d 42 d0             	lea    -0x30(%edx),%eax
 1e7:	3c 09                	cmp    $0x9,%al
 1e9:	76 e8                	jbe    1d3 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 1eb:	89 d8                	mov    %ebx,%eax
 1ed:	5b                   	pop    %ebx
 1ee:	5d                   	pop    %ebp
 1ef:	c3                   	ret    

000001f0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1f6:	56                   	push   %esi
 1f7:	8b 75 08             	mov    0x8(%ebp),%esi
 1fa:	53                   	push   %ebx
 1fb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1fe:	85 c9                	test   %ecx,%ecx
 200:	7e 10                	jle    212 <memmove+0x22>
 202:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 204:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 208:	88 04 32             	mov    %al,(%edx,%esi,1)
 20b:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 20e:	39 ca                	cmp    %ecx,%edx
 210:	75 f2                	jne    204 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 212:	89 f0                	mov    %esi,%eax
 214:	5b                   	pop    %ebx
 215:	5e                   	pop    %esi
 216:	5d                   	pop    %ebp
 217:	c3                   	ret    
 218:	90                   	nop    
 219:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000220 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 226:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 229:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 22c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 22f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 234:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 23b:	00 
 23c:	89 04 24             	mov    %eax,(%esp)
 23f:	e8 d4 00 00 00       	call   318 <open>
  if(fd < 0)
 244:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 246:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 248:	78 19                	js     263 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 24a:	8b 45 0c             	mov    0xc(%ebp),%eax
 24d:	89 1c 24             	mov    %ebx,(%esp)
 250:	89 44 24 04          	mov    %eax,0x4(%esp)
 254:	e8 d7 00 00 00       	call   330 <fstat>
  close(fd);
 259:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 25c:	89 c6                	mov    %eax,%esi
  close(fd);
 25e:	e8 9d 00 00 00       	call   300 <close>
  return r;
}
 263:	89 f0                	mov    %esi,%eax
 265:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 268:	8b 75 fc             	mov    -0x4(%ebp),%esi
 26b:	89 ec                	mov    %ebp,%esp
 26d:	5d                   	pop    %ebp
 26e:	c3                   	ret    
 26f:	90                   	nop    

00000270 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	57                   	push   %edi
 274:	56                   	push   %esi
 275:	31 f6                	xor    %esi,%esi
 277:	53                   	push   %ebx
 278:	83 ec 1c             	sub    $0x1c,%esp
 27b:	8b 7d 08             	mov    0x8(%ebp),%edi
 27e:	eb 06                	jmp    286 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 280:	3c 0d                	cmp    $0xd,%al
 282:	74 39                	je     2bd <gets+0x4d>
 284:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 286:	8d 5e 01             	lea    0x1(%esi),%ebx
 289:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 28c:	7d 31                	jge    2bf <gets+0x4f>
    cc = read(0, &c, 1);
 28e:	8d 45 f3             	lea    -0xd(%ebp),%eax
 291:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 298:	00 
 299:	89 44 24 04          	mov    %eax,0x4(%esp)
 29d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2a4:	e8 47 00 00 00       	call   2f0 <read>
    if(cc < 1)
 2a9:	85 c0                	test   %eax,%eax
 2ab:	7e 12                	jle    2bf <gets+0x4f>
      break;
    buf[i++] = c;
 2ad:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 2b1:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 2b5:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 2b9:	3c 0a                	cmp    $0xa,%al
 2bb:	75 c3                	jne    280 <gets+0x10>
 2bd:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 2bf:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 2c3:	89 f8                	mov    %edi,%eax
 2c5:	83 c4 1c             	add    $0x1c,%esp
 2c8:	5b                   	pop    %ebx
 2c9:	5e                   	pop    %esi
 2ca:	5f                   	pop    %edi
 2cb:	5d                   	pop    %ebp
 2cc:	c3                   	ret    
 2cd:	90                   	nop    
 2ce:	90                   	nop    
 2cf:	90                   	nop    

000002d0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2d0:	b8 01 00 00 00       	mov    $0x1,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <exit>:
SYSCALL(exit)
 2d8:	b8 02 00 00 00       	mov    $0x2,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <wait>:
SYSCALL(wait)
 2e0:	b8 03 00 00 00       	mov    $0x3,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <pipe>:
SYSCALL(pipe)
 2e8:	b8 04 00 00 00       	mov    $0x4,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <read>:
SYSCALL(read)
 2f0:	b8 06 00 00 00       	mov    $0x6,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <write>:
SYSCALL(write)
 2f8:	b8 05 00 00 00       	mov    $0x5,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <close>:
SYSCALL(close)
 300:	b8 07 00 00 00       	mov    $0x7,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <kill>:
SYSCALL(kill)
 308:	b8 08 00 00 00       	mov    $0x8,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <exec>:
SYSCALL(exec)
 310:	b8 09 00 00 00       	mov    $0x9,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <open>:
SYSCALL(open)
 318:	b8 0a 00 00 00       	mov    $0xa,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <mknod>:
SYSCALL(mknod)
 320:	b8 0b 00 00 00       	mov    $0xb,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <unlink>:
SYSCALL(unlink)
 328:	b8 0c 00 00 00       	mov    $0xc,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <fstat>:
SYSCALL(fstat)
 330:	b8 0d 00 00 00       	mov    $0xd,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <link>:
SYSCALL(link)
 338:	b8 0e 00 00 00       	mov    $0xe,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <mkdir>:
SYSCALL(mkdir)
 340:	b8 0f 00 00 00       	mov    $0xf,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <chdir>:
SYSCALL(chdir)
 348:	b8 10 00 00 00       	mov    $0x10,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <dup>:
SYSCALL(dup)
 350:	b8 11 00 00 00       	mov    $0x11,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <getpid>:
SYSCALL(getpid)
 358:	b8 12 00 00 00       	mov    $0x12,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <sbrk>:
SYSCALL(sbrk)
 360:	b8 13 00 00 00       	mov    $0x13,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <sleep>:
SYSCALL(sleep)
 368:	b8 14 00 00 00       	mov    $0x14,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <uptime>:
SYSCALL(uptime)
 370:	b8 15 00 00 00       	mov    $0x15,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    
 378:	90                   	nop    
 379:	90                   	nop    
 37a:	90                   	nop    
 37b:	90                   	nop    
 37c:	90                   	nop    
 37d:	90                   	nop    
 37e:	90                   	nop    
 37f:	90                   	nop    

00000380 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	83 ec 18             	sub    $0x18,%esp
 386:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 389:	8d 55 fc             	lea    -0x4(%ebp),%edx
 38c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 393:	00 
 394:	89 54 24 04          	mov    %edx,0x4(%esp)
 398:	89 04 24             	mov    %eax,(%esp)
 39b:	e8 58 ff ff ff       	call   2f8 <write>
}
 3a0:	c9                   	leave  
 3a1:	c3                   	ret    
 3a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 3a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000003b0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	57                   	push   %edi
 3b4:	56                   	push   %esi
 3b5:	89 ce                	mov    %ecx,%esi
 3b7:	53                   	push   %ebx
 3b8:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3bb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3be:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3c1:	85 c9                	test   %ecx,%ecx
 3c3:	74 04                	je     3c9 <printint+0x19>
 3c5:	85 d2                	test   %edx,%edx
 3c7:	78 54                	js     41d <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3c9:	89 d0                	mov    %edx,%eax
 3cb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 3d2:	31 db                	xor    %ebx,%ebx
 3d4:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 3d7:	31 d2                	xor    %edx,%edx
 3d9:	f7 f6                	div    %esi
 3db:	89 c1                	mov    %eax,%ecx
 3dd:	0f b6 82 2d 07 00 00 	movzbl 0x72d(%edx),%eax
 3e4:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 3e7:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 3ea:	85 c9                	test   %ecx,%ecx
 3ec:	89 c8                	mov    %ecx,%eax
 3ee:	75 e7                	jne    3d7 <printint+0x27>
  if(neg)
 3f0:	8b 45 e0             	mov    -0x20(%ebp),%eax
 3f3:	85 c0                	test   %eax,%eax
 3f5:	74 08                	je     3ff <printint+0x4f>
    buf[i++] = '-';
 3f7:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 3fc:	83 c3 01             	add    $0x1,%ebx
 3ff:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 402:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 406:	83 eb 01             	sub    $0x1,%ebx
 409:	8b 45 dc             	mov    -0x24(%ebp),%eax
 40c:	e8 6f ff ff ff       	call   380 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 411:	39 fb                	cmp    %edi,%ebx
 413:	75 ed                	jne    402 <printint+0x52>
    putc(fd, buf[i]);
}
 415:	83 c4 1c             	add    $0x1c,%esp
 418:	5b                   	pop    %ebx
 419:	5e                   	pop    %esi
 41a:	5f                   	pop    %edi
 41b:	5d                   	pop    %ebp
 41c:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 41d:	89 d0                	mov    %edx,%eax
 41f:	f7 d8                	neg    %eax
 421:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 428:	eb a8                	jmp    3d2 <printint+0x22>
 42a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000430 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	57                   	push   %edi
 434:	56                   	push   %esi
 435:	53                   	push   %ebx
 436:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 439:	8b 55 0c             	mov    0xc(%ebp),%edx
 43c:	0f b6 02             	movzbl (%edx),%eax
 43f:	84 c0                	test   %al,%al
 441:	0f 84 87 00 00 00    	je     4ce <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 447:	8d 4d 10             	lea    0x10(%ebp),%ecx
 44a:	31 ff                	xor    %edi,%edi
 44c:	31 f6                	xor    %esi,%esi
 44e:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 451:	eb 18                	jmp    46b <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 453:	83 fb 25             	cmp    $0x25,%ebx
 456:	0f 85 7a 00 00 00    	jne    4d6 <printf+0xa6>
 45c:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 460:	83 c7 01             	add    $0x1,%edi
 463:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 467:	84 c0                	test   %al,%al
 469:	74 63                	je     4ce <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 46b:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 46d:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 470:	74 e1                	je     453 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 472:	83 fe 25             	cmp    $0x25,%esi
 475:	75 e9                	jne    460 <printf+0x30>
      if(c == 'd'){
 477:	83 fb 64             	cmp    $0x64,%ebx
 47a:	0f 84 f0 00 00 00    	je     570 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 480:	83 fb 78             	cmp    $0x78,%ebx
 483:	74 64                	je     4e9 <printf+0xb9>
 485:	83 fb 70             	cmp    $0x70,%ebx
 488:	74 5f                	je     4e9 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 48a:	83 fb 73             	cmp    $0x73,%ebx
 48d:	8d 76 00             	lea    0x0(%esi),%esi
 490:	74 7e                	je     510 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 492:	83 fb 63             	cmp    $0x63,%ebx
 495:	0f 84 b9 00 00 00    	je     554 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 49b:	83 fb 25             	cmp    $0x25,%ebx
 49e:	66 90                	xchg   %ax,%ax
 4a0:	0f 84 f2 00 00 00    	je     598 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 4a6:	8b 45 08             	mov    0x8(%ebp),%eax
 4a9:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4ae:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4b1:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 4b3:	e8 c8 fe ff ff       	call   380 <putc>
        putc(fd, c);
 4b8:	8b 45 08             	mov    0x8(%ebp),%eax
 4bb:	0f be d3             	movsbl %bl,%edx
 4be:	e8 bd fe ff ff       	call   380 <putc>
 4c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4c6:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 4ca:	84 c0                	test   %al,%al
 4cc:	75 9d                	jne    46b <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4ce:	83 c4 0c             	add    $0xc,%esp
 4d1:	5b                   	pop    %ebx
 4d2:	5e                   	pop    %esi
 4d3:	5f                   	pop    %edi
 4d4:	5d                   	pop    %ebp
 4d5:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 4d6:	8b 45 08             	mov    0x8(%ebp),%eax
 4d9:	0f be d3             	movsbl %bl,%edx
 4dc:	e8 9f fe ff ff       	call   380 <putc>
 4e1:	8b 55 0c             	mov    0xc(%ebp),%edx
 4e4:	e9 77 ff ff ff       	jmp    460 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4ec:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 4f1:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4f3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4fa:	8b 10                	mov    (%eax),%edx
 4fc:	8b 45 08             	mov    0x8(%ebp),%eax
 4ff:	e8 ac fe ff ff       	call   3b0 <printint>
 504:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 507:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 50b:	e9 50 ff ff ff       	jmp    460 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 510:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 513:	8b 01                	mov    (%ecx),%eax
        ap++;
 515:	83 c1 04             	add    $0x4,%ecx
 518:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 51b:	b9 26 07 00 00       	mov    $0x726,%ecx
 520:	85 c0                	test   %eax,%eax
 522:	75 2c                	jne    550 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 524:	0f b6 01             	movzbl (%ecx),%eax
 527:	84 c0                	test   %al,%al
 529:	74 1e                	je     549 <printf+0x119>
 52b:	89 cb                	mov    %ecx,%ebx
 52d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 530:	0f be d0             	movsbl %al,%edx
 533:	8b 45 08             	mov    0x8(%ebp),%eax
 536:	e8 45 fe ff ff       	call   380 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 53b:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 53f:	83 c3 01             	add    $0x1,%ebx
 542:	84 c0                	test   %al,%al
 544:	75 ea                	jne    530 <printf+0x100>
 546:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 549:	31 f6                	xor    %esi,%esi
 54b:	e9 10 ff ff ff       	jmp    460 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 550:	89 c1                	mov    %eax,%ecx
 552:	eb d0                	jmp    524 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 554:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 557:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 559:	0f be 10             	movsbl (%eax),%edx
 55c:	8b 45 08             	mov    0x8(%ebp),%eax
 55f:	e8 1c fe ff ff       	call   380 <putc>
 564:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 567:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 56b:	e9 f0 fe ff ff       	jmp    460 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 570:	8b 45 f0             	mov    -0x10(%ebp),%eax
 573:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 578:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 57b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 582:	8b 10                	mov    (%eax),%edx
 584:	8b 45 08             	mov    0x8(%ebp),%eax
 587:	e8 24 fe ff ff       	call   3b0 <printint>
 58c:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 58f:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 593:	e9 c8 fe ff ff       	jmp    460 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 598:	8b 45 08             	mov    0x8(%ebp),%eax
 59b:	ba 25 00 00 00       	mov    $0x25,%edx
 5a0:	31 f6                	xor    %esi,%esi
 5a2:	e8 d9 fd ff ff       	call   380 <putc>
 5a7:	8b 55 0c             	mov    0xc(%ebp),%edx
 5aa:	e9 b1 fe ff ff       	jmp    460 <printf+0x30>
 5af:	90                   	nop    

000005b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5b1:	8b 0d 48 07 00 00    	mov    0x748,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 5b7:	89 e5                	mov    %esp,%ebp
 5b9:	56                   	push   %esi
 5ba:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 5bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5be:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5c1:	39 d9                	cmp    %ebx,%ecx
 5c3:	73 18                	jae    5dd <free+0x2d>
 5c5:	8b 11                	mov    (%ecx),%edx
 5c7:	39 d3                	cmp    %edx,%ebx
 5c9:	72 17                	jb     5e2 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5cb:	39 d1                	cmp    %edx,%ecx
 5cd:	72 08                	jb     5d7 <free+0x27>
 5cf:	39 d9                	cmp    %ebx,%ecx
 5d1:	72 0f                	jb     5e2 <free+0x32>
 5d3:	39 d3                	cmp    %edx,%ebx
 5d5:	72 0b                	jb     5e2 <free+0x32>
 5d7:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5d9:	39 d9                	cmp    %ebx,%ecx
 5db:	72 e8                	jb     5c5 <free+0x15>
 5dd:	8b 11                	mov    (%ecx),%edx
 5df:	90                   	nop    
 5e0:	eb e9                	jmp    5cb <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 5e2:	8b 73 04             	mov    0x4(%ebx),%esi
 5e5:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 5e8:	39 d0                	cmp    %edx,%eax
 5ea:	74 18                	je     604 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5ec:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 5ee:	8b 51 04             	mov    0x4(%ecx),%edx
 5f1:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 5f4:	39 d8                	cmp    %ebx,%eax
 5f6:	74 20                	je     618 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5f8:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 5fa:	5b                   	pop    %ebx
 5fb:	5e                   	pop    %esi
 5fc:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 5fd:	89 0d 48 07 00 00    	mov    %ecx,0x748
}
 603:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 604:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 607:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 609:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 60c:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 60f:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 611:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 614:	39 d8                	cmp    %ebx,%eax
 616:	75 e0                	jne    5f8 <free+0x48>
    p->s.size += bp->s.size;
 618:	03 53 04             	add    0x4(%ebx),%edx
 61b:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 61e:	8b 13                	mov    (%ebx),%edx
 620:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 622:	5b                   	pop    %ebx
 623:	5e                   	pop    %esi
 624:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 625:	89 0d 48 07 00 00    	mov    %ecx,0x748
}
 62b:	c3                   	ret    
 62c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000630 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	57                   	push   %edi
 634:	56                   	push   %esi
 635:	53                   	push   %ebx
 636:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 639:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 63c:	8b 15 48 07 00 00    	mov    0x748,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 642:	83 c0 07             	add    $0x7,%eax
 645:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 648:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 64a:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 64d:	0f 84 8a 00 00 00    	je     6dd <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 653:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 655:	8b 41 04             	mov    0x4(%ecx),%eax
 658:	39 c3                	cmp    %eax,%ebx
 65a:	76 1a                	jbe    676 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 65c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 663:	3b 0d 48 07 00 00    	cmp    0x748,%ecx
 669:	89 ca                	mov    %ecx,%edx
 66b:	74 29                	je     696 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 66d:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 66f:	8b 41 04             	mov    0x4(%ecx),%eax
 672:	39 c3                	cmp    %eax,%ebx
 674:	77 ed                	ja     663 <malloc+0x33>
      if(p->s.size == nunits)
 676:	39 c3                	cmp    %eax,%ebx
 678:	74 5d                	je     6d7 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 67a:	29 d8                	sub    %ebx,%eax
 67c:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 67f:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 682:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 685:	89 15 48 07 00 00    	mov    %edx,0x748
      return (void*) (p + 1);
 68b:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 68e:	83 c4 0c             	add    $0xc,%esp
 691:	5b                   	pop    %ebx
 692:	5e                   	pop    %esi
 693:	5f                   	pop    %edi
 694:	5d                   	pop    %ebp
 695:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 696:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 69c:	89 de                	mov    %ebx,%esi
 69e:	89 f8                	mov    %edi,%eax
 6a0:	76 29                	jbe    6cb <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 6a2:	89 04 24             	mov    %eax,(%esp)
 6a5:	e8 b6 fc ff ff       	call   360 <sbrk>
  if(p == (char*) -1)
 6aa:	83 f8 ff             	cmp    $0xffffffff,%eax
 6ad:	74 18                	je     6c7 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 6af:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 6b2:	83 c0 08             	add    $0x8,%eax
 6b5:	89 04 24             	mov    %eax,(%esp)
 6b8:	e8 f3 fe ff ff       	call   5b0 <free>
  return freep;
 6bd:	8b 15 48 07 00 00    	mov    0x748,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 6c3:	85 d2                	test   %edx,%edx
 6c5:	75 a6                	jne    66d <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6c7:	31 c0                	xor    %eax,%eax
 6c9:	eb c3                	jmp    68e <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 6cb:	be 00 10 00 00       	mov    $0x1000,%esi
 6d0:	b8 00 80 00 00       	mov    $0x8000,%eax
 6d5:	eb cb                	jmp    6a2 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 6d7:	8b 01                	mov    (%ecx),%eax
 6d9:	89 02                	mov    %eax,(%edx)
 6db:	eb a8                	jmp    685 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 6dd:	ba 40 07 00 00       	mov    $0x740,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 6e2:	c7 05 48 07 00 00 40 	movl   $0x740,0x748
 6e9:	07 00 00 
 6ec:	c7 05 40 07 00 00 40 	movl   $0x740,0x740
 6f3:	07 00 00 
    base.s.size = 0;
 6f6:	c7 05 44 07 00 00 00 	movl   $0x0,0x744
 6fd:	00 00 00 
 700:	e9 4e ff ff ff       	jmp    653 <malloc+0x23>
