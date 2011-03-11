
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
  15:	c7 44 24 04 25 07 00 	movl   $0x725,0x4(%esp)
  1c:	00 
  1d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  24:	e8 27 04 00 00       	call   450 <printf>

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
  3e:	c7 44 24 04 38 07 00 	movl   $0x738,0x4(%esp)
  45:	00 
  46:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  4d:	e8 fe 03 00 00       	call   450 <printf>

  char path[] = "stressfs0";
  52:	a1 3c 07 00 00       	mov    0x73c,%eax
  path[8] += i;
  int fd = open(path, O_CREATE | O_RDWR);
  57:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
  5e:	00 
    }
  }

  printf(1, "%d\n", i);

  char path[] = "stressfs0";
  5f:	89 45 ea             	mov    %eax,-0x16(%ebp)
  62:	a1 40 07 00 00       	mov    0x740,%eax
  67:	89 45 ee             	mov    %eax,-0x12(%ebp)
  6a:	0f b7 05 44 07 00 00 	movzwl 0x744,%eax
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
  90:	c7 44 24 04 38 07 00 	movl   $0x738,0x4(%esp)
  97:	00 

  printf(1, "%d\n", i);

  char path[] = "stressfs0";
  path[8] += i;
  int fd = open(path, O_CREATE | O_RDWR);
  98:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 100; i++)
    printf(fd, "%d\n", i);
  9a:	89 04 24             	mov    %eax,(%esp)
  9d:	e8 ae 03 00 00       	call   450 <printf>
  a2:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  printf(1, "%d\n", i);

  char path[] = "stressfs0";
  path[8] += i;
  int fd = open(path, O_CREATE | O_RDWR);
  for(i = 0; i < 100; i++)
  a6:	83 c3 01             	add    $0x1,%ebx
    printf(fd, "%d\n", i);
  a9:	c7 44 24 04 38 07 00 	movl   $0x738,0x4(%esp)
  b0:	00 
  b1:	89 34 24             	mov    %esi,(%esp)
  b4:	e8 97 03 00 00       	call   450 <printf>
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

00000378 <nice>:
SYSCALL(nice)
 378:	b8 16 00 00 00       	mov    $0x16,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <getpriority>:
SYSCALL(getpriority)
 380:	b8 17 00 00 00       	mov    $0x17,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <setpriority>:
SYSCALL(setpriority)
 388:	b8 18 00 00 00       	mov    $0x18,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <getaffinity>:
SYSCALL(getaffinity)
 390:	b8 19 00 00 00       	mov    $0x19,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <setaffinity>:
SYSCALL(setaffinity)
 398:	b8 1a 00 00 00       	mov    $0x1a,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	83 ec 18             	sub    $0x18,%esp
 3a6:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 3a9:	8d 55 fc             	lea    -0x4(%ebp),%edx
 3ac:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3b3:	00 
 3b4:	89 54 24 04          	mov    %edx,0x4(%esp)
 3b8:	89 04 24             	mov    %eax,(%esp)
 3bb:	e8 38 ff ff ff       	call   2f8 <write>
}
 3c0:	c9                   	leave  
 3c1:	c3                   	ret    
 3c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 3c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000003d0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	57                   	push   %edi
 3d4:	56                   	push   %esi
 3d5:	89 ce                	mov    %ecx,%esi
 3d7:	53                   	push   %ebx
 3d8:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3db:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3de:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3e1:	85 c9                	test   %ecx,%ecx
 3e3:	74 04                	je     3e9 <printint+0x19>
 3e5:	85 d2                	test   %edx,%edx
 3e7:	78 54                	js     43d <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3e9:	89 d0                	mov    %edx,%eax
 3eb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 3f2:	31 db                	xor    %ebx,%ebx
 3f4:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 3f7:	31 d2                	xor    %edx,%edx
 3f9:	f7 f6                	div    %esi
 3fb:	89 c1                	mov    %eax,%ecx
 3fd:	0f b6 82 4d 07 00 00 	movzbl 0x74d(%edx),%eax
 404:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 407:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 40a:	85 c9                	test   %ecx,%ecx
 40c:	89 c8                	mov    %ecx,%eax
 40e:	75 e7                	jne    3f7 <printint+0x27>
  if(neg)
 410:	8b 45 e0             	mov    -0x20(%ebp),%eax
 413:	85 c0                	test   %eax,%eax
 415:	74 08                	je     41f <printint+0x4f>
    buf[i++] = '-';
 417:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 41c:	83 c3 01             	add    $0x1,%ebx
 41f:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 422:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 426:	83 eb 01             	sub    $0x1,%ebx
 429:	8b 45 dc             	mov    -0x24(%ebp),%eax
 42c:	e8 6f ff ff ff       	call   3a0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 431:	39 fb                	cmp    %edi,%ebx
 433:	75 ed                	jne    422 <printint+0x52>
    putc(fd, buf[i]);
}
 435:	83 c4 1c             	add    $0x1c,%esp
 438:	5b                   	pop    %ebx
 439:	5e                   	pop    %esi
 43a:	5f                   	pop    %edi
 43b:	5d                   	pop    %ebp
 43c:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 43d:	89 d0                	mov    %edx,%eax
 43f:	f7 d8                	neg    %eax
 441:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 448:	eb a8                	jmp    3f2 <printint+0x22>
 44a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000450 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	57                   	push   %edi
 454:	56                   	push   %esi
 455:	53                   	push   %ebx
 456:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 459:	8b 55 0c             	mov    0xc(%ebp),%edx
 45c:	0f b6 02             	movzbl (%edx),%eax
 45f:	84 c0                	test   %al,%al
 461:	0f 84 87 00 00 00    	je     4ee <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 467:	8d 4d 10             	lea    0x10(%ebp),%ecx
 46a:	31 ff                	xor    %edi,%edi
 46c:	31 f6                	xor    %esi,%esi
 46e:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 471:	eb 18                	jmp    48b <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 473:	83 fb 25             	cmp    $0x25,%ebx
 476:	0f 85 7a 00 00 00    	jne    4f6 <printf+0xa6>
 47c:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 480:	83 c7 01             	add    $0x1,%edi
 483:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 487:	84 c0                	test   %al,%al
 489:	74 63                	je     4ee <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 48b:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 48d:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 490:	74 e1                	je     473 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 492:	83 fe 25             	cmp    $0x25,%esi
 495:	75 e9                	jne    480 <printf+0x30>
      if(c == 'd'){
 497:	83 fb 64             	cmp    $0x64,%ebx
 49a:	0f 84 f0 00 00 00    	je     590 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4a0:	83 fb 78             	cmp    $0x78,%ebx
 4a3:	74 64                	je     509 <printf+0xb9>
 4a5:	83 fb 70             	cmp    $0x70,%ebx
 4a8:	74 5f                	je     509 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4aa:	83 fb 73             	cmp    $0x73,%ebx
 4ad:	8d 76 00             	lea    0x0(%esi),%esi
 4b0:	74 7e                	je     530 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4b2:	83 fb 63             	cmp    $0x63,%ebx
 4b5:	0f 84 b9 00 00 00    	je     574 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4bb:	83 fb 25             	cmp    $0x25,%ebx
 4be:	66 90                	xchg   %ax,%ax
 4c0:	0f 84 f2 00 00 00    	je     5b8 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 4c6:	8b 45 08             	mov    0x8(%ebp),%eax
 4c9:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4ce:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4d1:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 4d3:	e8 c8 fe ff ff       	call   3a0 <putc>
        putc(fd, c);
 4d8:	8b 45 08             	mov    0x8(%ebp),%eax
 4db:	0f be d3             	movsbl %bl,%edx
 4de:	e8 bd fe ff ff       	call   3a0 <putc>
 4e3:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4e6:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 4ea:	84 c0                	test   %al,%al
 4ec:	75 9d                	jne    48b <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4ee:	83 c4 0c             	add    $0xc,%esp
 4f1:	5b                   	pop    %ebx
 4f2:	5e                   	pop    %esi
 4f3:	5f                   	pop    %edi
 4f4:	5d                   	pop    %ebp
 4f5:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 4f6:	8b 45 08             	mov    0x8(%ebp),%eax
 4f9:	0f be d3             	movsbl %bl,%edx
 4fc:	e8 9f fe ff ff       	call   3a0 <putc>
 501:	8b 55 0c             	mov    0xc(%ebp),%edx
 504:	e9 77 ff ff ff       	jmp    480 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 509:	8b 45 f0             	mov    -0x10(%ebp),%eax
 50c:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 511:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 513:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 51a:	8b 10                	mov    (%eax),%edx
 51c:	8b 45 08             	mov    0x8(%ebp),%eax
 51f:	e8 ac fe ff ff       	call   3d0 <printint>
 524:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 527:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 52b:	e9 50 ff ff ff       	jmp    480 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 530:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 533:	8b 01                	mov    (%ecx),%eax
        ap++;
 535:	83 c1 04             	add    $0x4,%ecx
 538:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 53b:	b9 46 07 00 00       	mov    $0x746,%ecx
 540:	85 c0                	test   %eax,%eax
 542:	75 2c                	jne    570 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 544:	0f b6 01             	movzbl (%ecx),%eax
 547:	84 c0                	test   %al,%al
 549:	74 1e                	je     569 <printf+0x119>
 54b:	89 cb                	mov    %ecx,%ebx
 54d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 550:	0f be d0             	movsbl %al,%edx
 553:	8b 45 08             	mov    0x8(%ebp),%eax
 556:	e8 45 fe ff ff       	call   3a0 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 55b:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 55f:	83 c3 01             	add    $0x1,%ebx
 562:	84 c0                	test   %al,%al
 564:	75 ea                	jne    550 <printf+0x100>
 566:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 569:	31 f6                	xor    %esi,%esi
 56b:	e9 10 ff ff ff       	jmp    480 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 570:	89 c1                	mov    %eax,%ecx
 572:	eb d0                	jmp    544 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 574:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 577:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 579:	0f be 10             	movsbl (%eax),%edx
 57c:	8b 45 08             	mov    0x8(%ebp),%eax
 57f:	e8 1c fe ff ff       	call   3a0 <putc>
 584:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 587:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 58b:	e9 f0 fe ff ff       	jmp    480 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 590:	8b 45 f0             	mov    -0x10(%ebp),%eax
 593:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 598:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 59b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5a2:	8b 10                	mov    (%eax),%edx
 5a4:	8b 45 08             	mov    0x8(%ebp),%eax
 5a7:	e8 24 fe ff ff       	call   3d0 <printint>
 5ac:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 5af:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 5b3:	e9 c8 fe ff ff       	jmp    480 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 5b8:	8b 45 08             	mov    0x8(%ebp),%eax
 5bb:	ba 25 00 00 00       	mov    $0x25,%edx
 5c0:	31 f6                	xor    %esi,%esi
 5c2:	e8 d9 fd ff ff       	call   3a0 <putc>
 5c7:	8b 55 0c             	mov    0xc(%ebp),%edx
 5ca:	e9 b1 fe ff ff       	jmp    480 <printf+0x30>
 5cf:	90                   	nop    

000005d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5d1:	8b 0d 68 07 00 00    	mov    0x768,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 5d7:	89 e5                	mov    %esp,%ebp
 5d9:	56                   	push   %esi
 5da:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 5db:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5de:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e1:	39 d9                	cmp    %ebx,%ecx
 5e3:	73 18                	jae    5fd <free+0x2d>
 5e5:	8b 11                	mov    (%ecx),%edx
 5e7:	39 d3                	cmp    %edx,%ebx
 5e9:	72 17                	jb     602 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5eb:	39 d1                	cmp    %edx,%ecx
 5ed:	72 08                	jb     5f7 <free+0x27>
 5ef:	39 d9                	cmp    %ebx,%ecx
 5f1:	72 0f                	jb     602 <free+0x32>
 5f3:	39 d3                	cmp    %edx,%ebx
 5f5:	72 0b                	jb     602 <free+0x32>
 5f7:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f9:	39 d9                	cmp    %ebx,%ecx
 5fb:	72 e8                	jb     5e5 <free+0x15>
 5fd:	8b 11                	mov    (%ecx),%edx
 5ff:	90                   	nop    
 600:	eb e9                	jmp    5eb <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 602:	8b 73 04             	mov    0x4(%ebx),%esi
 605:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 608:	39 d0                	cmp    %edx,%eax
 60a:	74 18                	je     624 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 60c:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 60e:	8b 51 04             	mov    0x4(%ecx),%edx
 611:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 614:	39 d8                	cmp    %ebx,%eax
 616:	74 20                	je     638 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 618:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 61a:	5b                   	pop    %ebx
 61b:	5e                   	pop    %esi
 61c:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 61d:	89 0d 68 07 00 00    	mov    %ecx,0x768
}
 623:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 624:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 627:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 629:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 62c:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 62f:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 631:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 634:	39 d8                	cmp    %ebx,%eax
 636:	75 e0                	jne    618 <free+0x48>
    p->s.size += bp->s.size;
 638:	03 53 04             	add    0x4(%ebx),%edx
 63b:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 63e:	8b 13                	mov    (%ebx),%edx
 640:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 642:	5b                   	pop    %ebx
 643:	5e                   	pop    %esi
 644:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 645:	89 0d 68 07 00 00    	mov    %ecx,0x768
}
 64b:	c3                   	ret    
 64c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000650 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 650:	55                   	push   %ebp
 651:	89 e5                	mov    %esp,%ebp
 653:	57                   	push   %edi
 654:	56                   	push   %esi
 655:	53                   	push   %ebx
 656:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 659:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 65c:	8b 15 68 07 00 00    	mov    0x768,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 662:	83 c0 07             	add    $0x7,%eax
 665:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 668:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 66a:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 66d:	0f 84 8a 00 00 00    	je     6fd <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 673:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 675:	8b 41 04             	mov    0x4(%ecx),%eax
 678:	39 c3                	cmp    %eax,%ebx
 67a:	76 1a                	jbe    696 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 67c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 683:	3b 0d 68 07 00 00    	cmp    0x768,%ecx
 689:	89 ca                	mov    %ecx,%edx
 68b:	74 29                	je     6b6 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 68d:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 68f:	8b 41 04             	mov    0x4(%ecx),%eax
 692:	39 c3                	cmp    %eax,%ebx
 694:	77 ed                	ja     683 <malloc+0x33>
      if(p->s.size == nunits)
 696:	39 c3                	cmp    %eax,%ebx
 698:	74 5d                	je     6f7 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 69a:	29 d8                	sub    %ebx,%eax
 69c:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 69f:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 6a2:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 6a5:	89 15 68 07 00 00    	mov    %edx,0x768
      return (void*) (p + 1);
 6ab:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 6ae:	83 c4 0c             	add    $0xc,%esp
 6b1:	5b                   	pop    %ebx
 6b2:	5e                   	pop    %esi
 6b3:	5f                   	pop    %edi
 6b4:	5d                   	pop    %ebp
 6b5:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 6b6:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 6bc:	89 de                	mov    %ebx,%esi
 6be:	89 f8                	mov    %edi,%eax
 6c0:	76 29                	jbe    6eb <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 6c2:	89 04 24             	mov    %eax,(%esp)
 6c5:	e8 96 fc ff ff       	call   360 <sbrk>
  if(p == (char*) -1)
 6ca:	83 f8 ff             	cmp    $0xffffffff,%eax
 6cd:	74 18                	je     6e7 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 6cf:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 6d2:	83 c0 08             	add    $0x8,%eax
 6d5:	89 04 24             	mov    %eax,(%esp)
 6d8:	e8 f3 fe ff ff       	call   5d0 <free>
  return freep;
 6dd:	8b 15 68 07 00 00    	mov    0x768,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 6e3:	85 d2                	test   %edx,%edx
 6e5:	75 a6                	jne    68d <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6e7:	31 c0                	xor    %eax,%eax
 6e9:	eb c3                	jmp    6ae <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 6eb:	be 00 10 00 00       	mov    $0x1000,%esi
 6f0:	b8 00 80 00 00       	mov    $0x8000,%eax
 6f5:	eb cb                	jmp    6c2 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 6f7:	8b 01                	mov    (%ecx),%eax
 6f9:	89 02                	mov    %eax,(%edx)
 6fb:	eb a8                	jmp    6a5 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 6fd:	ba 60 07 00 00       	mov    $0x760,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 702:	c7 05 68 07 00 00 60 	movl   $0x760,0x768
 709:	07 00 00 
 70c:	c7 05 60 07 00 00 60 	movl   $0x760,0x760
 713:	07 00 00 
    base.s.size = 0;
 716:	c7 05 64 07 00 00 00 	movl   $0x0,0x764
 71d:	00 00 00 
 720:	e9 4e ff ff ff       	jmp    673 <malloc+0x23>
