
_init:     file format elf32-i386

Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
   f:	83 ec 10             	sub    $0x10,%esp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
  12:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  19:	00 
  1a:	c7 04 24 45 07 00 00 	movl   $0x745,(%esp)
  21:	e8 32 03 00 00       	call   358 <open>
  26:	85 c0                	test   %eax,%eax
  28:	0f 88 a4 00 00 00    	js     d2 <main+0xd2>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  2e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  35:	e8 56 03 00 00       	call   390 <dup>
  dup(0);  // stderr
  3a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  41:	e8 4a 03 00 00       	call   390 <dup>

  for(;;){
    printf(1, "init: starting sh\n");
  46:	c7 44 24 04 4d 07 00 	movl   $0x74d,0x4(%esp)
  4d:	00 
  4e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  55:	e8 16 04 00 00       	call   470 <printf>
    pid = fork();
  5a:	e8 b1 02 00 00       	call   310 <fork>
    if(pid < 0){
  5f:	83 f8 00             	cmp    $0x0,%eax
  dup(0);  // stdout
  dup(0);  // stderr

  for(;;){
    printf(1, "init: starting sh\n");
    pid = fork();
  62:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  64:	7c 26                	jl     8c <main+0x8c>
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
  66:	74 3d                	je     a5 <main+0xa5>
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  68:	e8 b3 02 00 00       	call   320 <wait>
  6d:	85 c0                	test   %eax,%eax
  6f:	90                   	nop    
  70:	78 d4                	js     46 <main+0x46>
  72:	39 c3                	cmp    %eax,%ebx
  74:	74 d0                	je     46 <main+0x46>
      printf(1, "zombie!\n");
  76:	c7 44 24 04 8c 07 00 	movl   $0x78c,0x4(%esp)
  7d:	00 
  7e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  85:	e8 e6 03 00 00       	call   470 <printf>
  8a:	eb dc                	jmp    68 <main+0x68>

  for(;;){
    printf(1, "init: starting sh\n");
    pid = fork();
    if(pid < 0){
      printf(1, "init: fork failed\n");
  8c:	c7 44 24 04 60 07 00 	movl   $0x760,0x4(%esp)
  93:	00 
  94:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  9b:	e8 d0 03 00 00       	call   470 <printf>
      exit();
  a0:	e8 73 02 00 00       	call   318 <exit>
    }
    if(pid == 0){
      exec("sh", argv);
  a5:	c7 44 24 04 b0 07 00 	movl   $0x7b0,0x4(%esp)
  ac:	00 
  ad:	c7 04 24 73 07 00 00 	movl   $0x773,(%esp)
  b4:	e8 97 02 00 00       	call   350 <exec>
      printf(1, "init: exec sh failed\n");
  b9:	c7 44 24 04 76 07 00 	movl   $0x776,0x4(%esp)
  c0:	00 
  c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c8:	e8 a3 03 00 00       	call   470 <printf>
      exit();
  cd:	e8 46 02 00 00       	call   318 <exit>
main(void)
{
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
    mknod("console", 1, 1);
  d2:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  d9:	00 
  da:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  e1:	00 
  e2:	c7 04 24 45 07 00 00 	movl   $0x745,(%esp)
  e9:	e8 72 02 00 00       	call   360 <mknod>
    open("console", O_RDWR);
  ee:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  f5:	00 
  f6:	c7 04 24 45 07 00 00 	movl   $0x745,(%esp)
  fd:	e8 56 02 00 00       	call   358 <open>
 102:	e9 27 ff ff ff       	jmp    2e <main+0x2e>
 107:	90                   	nop    
 108:	90                   	nop    
 109:	90                   	nop    
 10a:	90                   	nop    
 10b:	90                   	nop    
 10c:	90                   	nop    
 10d:	90                   	nop    
 10e:	90                   	nop    
 10f:	90                   	nop    

00000110 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	53                   	push   %ebx
 114:	8b 5d 08             	mov    0x8(%ebp),%ebx
 117:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 11a:	89 da                	mov    %ebx,%edx
 11c:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 120:	0f b6 01             	movzbl (%ecx),%eax
 123:	83 c1 01             	add    $0x1,%ecx
 126:	88 02                	mov    %al,(%edx)
 128:	83 c2 01             	add    $0x1,%edx
 12b:	84 c0                	test   %al,%al
 12d:	75 f1                	jne    120 <strcpy+0x10>
    ;
  return os;
}
 12f:	89 d8                	mov    %ebx,%eax
 131:	5b                   	pop    %ebx
 132:	5d                   	pop    %ebp
 133:	c3                   	ret    
 134:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 13a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000140 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	8b 4d 08             	mov    0x8(%ebp),%ecx
 146:	53                   	push   %ebx
 147:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 14a:	0f b6 01             	movzbl (%ecx),%eax
 14d:	84 c0                	test   %al,%al
 14f:	74 24                	je     175 <strcmp+0x35>
 151:	0f b6 13             	movzbl (%ebx),%edx
 154:	38 d0                	cmp    %dl,%al
 156:	74 12                	je     16a <strcmp+0x2a>
 158:	eb 1e                	jmp    178 <strcmp+0x38>
 15a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 160:	0f b6 13             	movzbl (%ebx),%edx
 163:	83 c1 01             	add    $0x1,%ecx
 166:	38 d0                	cmp    %dl,%al
 168:	75 0e                	jne    178 <strcmp+0x38>
 16a:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 16e:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 171:	84 c0                	test   %al,%al
 173:	75 eb                	jne    160 <strcmp+0x20>
 175:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 178:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 179:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 17c:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 17d:	0f b6 d2             	movzbl %dl,%edx
 180:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 182:	c3                   	ret    
 183:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000190 <strlen>:

uint
strlen(char *s)
{
 190:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 191:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 193:	89 e5                	mov    %esp,%ebp
 195:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 198:	80 39 00             	cmpb   $0x0,(%ecx)
 19b:	74 0e                	je     1ab <strlen+0x1b>
 19d:	31 d2                	xor    %edx,%edx
 19f:	90                   	nop    
 1a0:	83 c2 01             	add    $0x1,%edx
 1a3:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
 1a7:	89 d0                	mov    %edx,%eax
 1a9:	75 f5                	jne    1a0 <strlen+0x10>
    ;
  return n;
}
 1ab:	5d                   	pop    %ebp
 1ac:	c3                   	ret    
 1ad:	8d 76 00             	lea    0x0(%esi),%esi

000001b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 55 08             	mov    0x8(%ebp),%edx
 1b6:	57                   	push   %edi
 1b7:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ba:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1bd:	89 d7                	mov    %edx,%edi
 1bf:	fc                   	cld    
 1c0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1c2:	5f                   	pop    %edi
 1c3:	89 d0                	mov    %edx,%eax
 1c5:	5d                   	pop    %ebp
 1c6:	c3                   	ret    
 1c7:	89 f6                	mov    %esi,%esi
 1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000001d0 <strchr>:

char*
strchr(const char *s, char c)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	8b 45 08             	mov    0x8(%ebp),%eax
 1d6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1da:	0f b6 10             	movzbl (%eax),%edx
 1dd:	84 d2                	test   %dl,%dl
 1df:	75 0c                	jne    1ed <strchr+0x1d>
 1e1:	eb 11                	jmp    1f4 <strchr+0x24>
 1e3:	83 c0 01             	add    $0x1,%eax
 1e6:	0f b6 10             	movzbl (%eax),%edx
 1e9:	84 d2                	test   %dl,%dl
 1eb:	74 07                	je     1f4 <strchr+0x24>
    if(*s == c)
 1ed:	38 ca                	cmp    %cl,%dl
 1ef:	90                   	nop    
 1f0:	75 f1                	jne    1e3 <strchr+0x13>
      return (char*) s;
  return 0;
}
 1f2:	5d                   	pop    %ebp
 1f3:	c3                   	ret    
 1f4:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1f5:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 1f7:	c3                   	ret    
 1f8:	90                   	nop    
 1f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000200 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	8b 4d 08             	mov    0x8(%ebp),%ecx
 206:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 207:	31 db                	xor    %ebx,%ebx
 209:	0f b6 11             	movzbl (%ecx),%edx
 20c:	8d 42 d0             	lea    -0x30(%edx),%eax
 20f:	3c 09                	cmp    $0x9,%al
 211:	77 18                	ja     22b <atoi+0x2b>
    n = n*10 + *s++ - '0';
 213:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 216:	0f be d2             	movsbl %dl,%edx
 219:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 21d:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 221:	83 c1 01             	add    $0x1,%ecx
 224:	8d 42 d0             	lea    -0x30(%edx),%eax
 227:	3c 09                	cmp    $0x9,%al
 229:	76 e8                	jbe    213 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 22b:	89 d8                	mov    %ebx,%eax
 22d:	5b                   	pop    %ebx
 22e:	5d                   	pop    %ebp
 22f:	c3                   	ret    

00000230 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	8b 4d 10             	mov    0x10(%ebp),%ecx
 236:	56                   	push   %esi
 237:	8b 75 08             	mov    0x8(%ebp),%esi
 23a:	53                   	push   %ebx
 23b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 23e:	85 c9                	test   %ecx,%ecx
 240:	7e 10                	jle    252 <memmove+0x22>
 242:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 244:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 248:	88 04 32             	mov    %al,(%edx,%esi,1)
 24b:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 24e:	39 ca                	cmp    %ecx,%edx
 250:	75 f2                	jne    244 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 252:	89 f0                	mov    %esi,%eax
 254:	5b                   	pop    %ebx
 255:	5e                   	pop    %esi
 256:	5d                   	pop    %ebp
 257:	c3                   	ret    
 258:	90                   	nop    
 259:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000260 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 266:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 269:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 26c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 26f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 274:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 27b:	00 
 27c:	89 04 24             	mov    %eax,(%esp)
 27f:	e8 d4 00 00 00       	call   358 <open>
  if(fd < 0)
 284:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 286:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 288:	78 19                	js     2a3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 28a:	8b 45 0c             	mov    0xc(%ebp),%eax
 28d:	89 1c 24             	mov    %ebx,(%esp)
 290:	89 44 24 04          	mov    %eax,0x4(%esp)
 294:	e8 d7 00 00 00       	call   370 <fstat>
  close(fd);
 299:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 29c:	89 c6                	mov    %eax,%esi
  close(fd);
 29e:	e8 9d 00 00 00       	call   340 <close>
  return r;
}
 2a3:	89 f0                	mov    %esi,%eax
 2a5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 2a8:	8b 75 fc             	mov    -0x4(%ebp),%esi
 2ab:	89 ec                	mov    %ebp,%esp
 2ad:	5d                   	pop    %ebp
 2ae:	c3                   	ret    
 2af:	90                   	nop    

000002b0 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	57                   	push   %edi
 2b4:	56                   	push   %esi
 2b5:	31 f6                	xor    %esi,%esi
 2b7:	53                   	push   %ebx
 2b8:	83 ec 1c             	sub    $0x1c,%esp
 2bb:	8b 7d 08             	mov    0x8(%ebp),%edi
 2be:	eb 06                	jmp    2c6 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2c0:	3c 0d                	cmp    $0xd,%al
 2c2:	74 39                	je     2fd <gets+0x4d>
 2c4:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2c6:	8d 5e 01             	lea    0x1(%esi),%ebx
 2c9:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2cc:	7d 31                	jge    2ff <gets+0x4f>
    cc = read(0, &c, 1);
 2ce:	8d 45 f3             	lea    -0xd(%ebp),%eax
 2d1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2d8:	00 
 2d9:	89 44 24 04          	mov    %eax,0x4(%esp)
 2dd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2e4:	e8 47 00 00 00       	call   330 <read>
    if(cc < 1)
 2e9:	85 c0                	test   %eax,%eax
 2eb:	7e 12                	jle    2ff <gets+0x4f>
      break;
    buf[i++] = c;
 2ed:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 2f1:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 2f5:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 2f9:	3c 0a                	cmp    $0xa,%al
 2fb:	75 c3                	jne    2c0 <gets+0x10>
 2fd:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 2ff:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 303:	89 f8                	mov    %edi,%eax
 305:	83 c4 1c             	add    $0x1c,%esp
 308:	5b                   	pop    %ebx
 309:	5e                   	pop    %esi
 30a:	5f                   	pop    %edi
 30b:	5d                   	pop    %ebp
 30c:	c3                   	ret    
 30d:	90                   	nop    
 30e:	90                   	nop    
 30f:	90                   	nop    

00000310 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 310:	b8 01 00 00 00       	mov    $0x1,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <exit>:
SYSCALL(exit)
 318:	b8 02 00 00 00       	mov    $0x2,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <wait>:
SYSCALL(wait)
 320:	b8 03 00 00 00       	mov    $0x3,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <pipe>:
SYSCALL(pipe)
 328:	b8 04 00 00 00       	mov    $0x4,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <read>:
SYSCALL(read)
 330:	b8 06 00 00 00       	mov    $0x6,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <write>:
SYSCALL(write)
 338:	b8 05 00 00 00       	mov    $0x5,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <close>:
SYSCALL(close)
 340:	b8 07 00 00 00       	mov    $0x7,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <kill>:
SYSCALL(kill)
 348:	b8 08 00 00 00       	mov    $0x8,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <exec>:
SYSCALL(exec)
 350:	b8 09 00 00 00       	mov    $0x9,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <open>:
SYSCALL(open)
 358:	b8 0a 00 00 00       	mov    $0xa,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <mknod>:
SYSCALL(mknod)
 360:	b8 0b 00 00 00       	mov    $0xb,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <unlink>:
SYSCALL(unlink)
 368:	b8 0c 00 00 00       	mov    $0xc,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <fstat>:
SYSCALL(fstat)
 370:	b8 0d 00 00 00       	mov    $0xd,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <link>:
SYSCALL(link)
 378:	b8 0e 00 00 00       	mov    $0xe,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <mkdir>:
SYSCALL(mkdir)
 380:	b8 0f 00 00 00       	mov    $0xf,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <chdir>:
SYSCALL(chdir)
 388:	b8 10 00 00 00       	mov    $0x10,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <dup>:
SYSCALL(dup)
 390:	b8 11 00 00 00       	mov    $0x11,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <getpid>:
SYSCALL(getpid)
 398:	b8 12 00 00 00       	mov    $0x12,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <sbrk>:
SYSCALL(sbrk)
 3a0:	b8 13 00 00 00       	mov    $0x13,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <sleep>:
SYSCALL(sleep)
 3a8:	b8 14 00 00 00       	mov    $0x14,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <uptime>:
SYSCALL(uptime)
 3b0:	b8 15 00 00 00       	mov    $0x15,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    
 3b8:	90                   	nop    
 3b9:	90                   	nop    
 3ba:	90                   	nop    
 3bb:	90                   	nop    
 3bc:	90                   	nop    
 3bd:	90                   	nop    
 3be:	90                   	nop    
 3bf:	90                   	nop    

000003c0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	83 ec 18             	sub    $0x18,%esp
 3c6:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 3c9:	8d 55 fc             	lea    -0x4(%ebp),%edx
 3cc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3d3:	00 
 3d4:	89 54 24 04          	mov    %edx,0x4(%esp)
 3d8:	89 04 24             	mov    %eax,(%esp)
 3db:	e8 58 ff ff ff       	call   338 <write>
}
 3e0:	c9                   	leave  
 3e1:	c3                   	ret    
 3e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 3e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000003f0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	56                   	push   %esi
 3f5:	89 ce                	mov    %ecx,%esi
 3f7:	53                   	push   %ebx
 3f8:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3fb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3fe:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 401:	85 c9                	test   %ecx,%ecx
 403:	74 04                	je     409 <printint+0x19>
 405:	85 d2                	test   %edx,%edx
 407:	78 54                	js     45d <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 409:	89 d0                	mov    %edx,%eax
 40b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 412:	31 db                	xor    %ebx,%ebx
 414:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 417:	31 d2                	xor    %edx,%edx
 419:	f7 f6                	div    %esi
 41b:	89 c1                	mov    %eax,%ecx
 41d:	0f b6 82 9c 07 00 00 	movzbl 0x79c(%edx),%eax
 424:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 427:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 42a:	85 c9                	test   %ecx,%ecx
 42c:	89 c8                	mov    %ecx,%eax
 42e:	75 e7                	jne    417 <printint+0x27>
  if(neg)
 430:	8b 45 e0             	mov    -0x20(%ebp),%eax
 433:	85 c0                	test   %eax,%eax
 435:	74 08                	je     43f <printint+0x4f>
    buf[i++] = '-';
 437:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 43c:	83 c3 01             	add    $0x1,%ebx
 43f:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 442:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 446:	83 eb 01             	sub    $0x1,%ebx
 449:	8b 45 dc             	mov    -0x24(%ebp),%eax
 44c:	e8 6f ff ff ff       	call   3c0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 451:	39 fb                	cmp    %edi,%ebx
 453:	75 ed                	jne    442 <printint+0x52>
    putc(fd, buf[i]);
}
 455:	83 c4 1c             	add    $0x1c,%esp
 458:	5b                   	pop    %ebx
 459:	5e                   	pop    %esi
 45a:	5f                   	pop    %edi
 45b:	5d                   	pop    %ebp
 45c:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 45d:	89 d0                	mov    %edx,%eax
 45f:	f7 d8                	neg    %eax
 461:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 468:	eb a8                	jmp    412 <printint+0x22>
 46a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000470 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	57                   	push   %edi
 474:	56                   	push   %esi
 475:	53                   	push   %ebx
 476:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 479:	8b 55 0c             	mov    0xc(%ebp),%edx
 47c:	0f b6 02             	movzbl (%edx),%eax
 47f:	84 c0                	test   %al,%al
 481:	0f 84 87 00 00 00    	je     50e <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 487:	8d 4d 10             	lea    0x10(%ebp),%ecx
 48a:	31 ff                	xor    %edi,%edi
 48c:	31 f6                	xor    %esi,%esi
 48e:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 491:	eb 18                	jmp    4ab <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 493:	83 fb 25             	cmp    $0x25,%ebx
 496:	0f 85 7a 00 00 00    	jne    516 <printf+0xa6>
 49c:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4a0:	83 c7 01             	add    $0x1,%edi
 4a3:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 4a7:	84 c0                	test   %al,%al
 4a9:	74 63                	je     50e <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 4ab:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 4ad:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 4b0:	74 e1                	je     493 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4b2:	83 fe 25             	cmp    $0x25,%esi
 4b5:	75 e9                	jne    4a0 <printf+0x30>
      if(c == 'd'){
 4b7:	83 fb 64             	cmp    $0x64,%ebx
 4ba:	0f 84 f0 00 00 00    	je     5b0 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4c0:	83 fb 78             	cmp    $0x78,%ebx
 4c3:	74 64                	je     529 <printf+0xb9>
 4c5:	83 fb 70             	cmp    $0x70,%ebx
 4c8:	74 5f                	je     529 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4ca:	83 fb 73             	cmp    $0x73,%ebx
 4cd:	8d 76 00             	lea    0x0(%esi),%esi
 4d0:	74 7e                	je     550 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4d2:	83 fb 63             	cmp    $0x63,%ebx
 4d5:	0f 84 b9 00 00 00    	je     594 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4db:	83 fb 25             	cmp    $0x25,%ebx
 4de:	66 90                	xchg   %ax,%ax
 4e0:	0f 84 f2 00 00 00    	je     5d8 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 4e6:	8b 45 08             	mov    0x8(%ebp),%eax
 4e9:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4ee:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4f1:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 4f3:	e8 c8 fe ff ff       	call   3c0 <putc>
        putc(fd, c);
 4f8:	8b 45 08             	mov    0x8(%ebp),%eax
 4fb:	0f be d3             	movsbl %bl,%edx
 4fe:	e8 bd fe ff ff       	call   3c0 <putc>
 503:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 506:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 50a:	84 c0                	test   %al,%al
 50c:	75 9d                	jne    4ab <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 50e:	83 c4 0c             	add    $0xc,%esp
 511:	5b                   	pop    %ebx
 512:	5e                   	pop    %esi
 513:	5f                   	pop    %edi
 514:	5d                   	pop    %ebp
 515:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 516:	8b 45 08             	mov    0x8(%ebp),%eax
 519:	0f be d3             	movsbl %bl,%edx
 51c:	e8 9f fe ff ff       	call   3c0 <putc>
 521:	8b 55 0c             	mov    0xc(%ebp),%edx
 524:	e9 77 ff ff ff       	jmp    4a0 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 529:	8b 45 f0             	mov    -0x10(%ebp),%eax
 52c:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 531:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 533:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 53a:	8b 10                	mov    (%eax),%edx
 53c:	8b 45 08             	mov    0x8(%ebp),%eax
 53f:	e8 ac fe ff ff       	call   3f0 <printint>
 544:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 547:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 54b:	e9 50 ff ff ff       	jmp    4a0 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 550:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 553:	8b 01                	mov    (%ecx),%eax
        ap++;
 555:	83 c1 04             	add    $0x4,%ecx
 558:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 55b:	b9 95 07 00 00       	mov    $0x795,%ecx
 560:	85 c0                	test   %eax,%eax
 562:	75 2c                	jne    590 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 564:	0f b6 01             	movzbl (%ecx),%eax
 567:	84 c0                	test   %al,%al
 569:	74 1e                	je     589 <printf+0x119>
 56b:	89 cb                	mov    %ecx,%ebx
 56d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 570:	0f be d0             	movsbl %al,%edx
 573:	8b 45 08             	mov    0x8(%ebp),%eax
 576:	e8 45 fe ff ff       	call   3c0 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 57b:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 57f:	83 c3 01             	add    $0x1,%ebx
 582:	84 c0                	test   %al,%al
 584:	75 ea                	jne    570 <printf+0x100>
 586:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 589:	31 f6                	xor    %esi,%esi
 58b:	e9 10 ff ff ff       	jmp    4a0 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 590:	89 c1                	mov    %eax,%ecx
 592:	eb d0                	jmp    564 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 594:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 597:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 599:	0f be 10             	movsbl (%eax),%edx
 59c:	8b 45 08             	mov    0x8(%ebp),%eax
 59f:	e8 1c fe ff ff       	call   3c0 <putc>
 5a4:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 5a7:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 5ab:	e9 f0 fe ff ff       	jmp    4a0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 5b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5b3:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 5b8:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 5bb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5c2:	8b 10                	mov    (%eax),%edx
 5c4:	8b 45 08             	mov    0x8(%ebp),%eax
 5c7:	e8 24 fe ff ff       	call   3f0 <printint>
 5cc:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 5cf:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 5d3:	e9 c8 fe ff ff       	jmp    4a0 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 5d8:	8b 45 08             	mov    0x8(%ebp),%eax
 5db:	ba 25 00 00 00       	mov    $0x25,%edx
 5e0:	31 f6                	xor    %esi,%esi
 5e2:	e8 d9 fd ff ff       	call   3c0 <putc>
 5e7:	8b 55 0c             	mov    0xc(%ebp),%edx
 5ea:	e9 b1 fe ff ff       	jmp    4a0 <printf+0x30>
 5ef:	90                   	nop    

000005f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f1:	8b 0d c0 07 00 00    	mov    0x7c0,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 5f7:	89 e5                	mov    %esp,%ebp
 5f9:	56                   	push   %esi
 5fa:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 5fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5fe:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 601:	39 d9                	cmp    %ebx,%ecx
 603:	73 18                	jae    61d <free+0x2d>
 605:	8b 11                	mov    (%ecx),%edx
 607:	39 d3                	cmp    %edx,%ebx
 609:	72 17                	jb     622 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 60b:	39 d1                	cmp    %edx,%ecx
 60d:	72 08                	jb     617 <free+0x27>
 60f:	39 d9                	cmp    %ebx,%ecx
 611:	72 0f                	jb     622 <free+0x32>
 613:	39 d3                	cmp    %edx,%ebx
 615:	72 0b                	jb     622 <free+0x32>
 617:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 619:	39 d9                	cmp    %ebx,%ecx
 61b:	72 e8                	jb     605 <free+0x15>
 61d:	8b 11                	mov    (%ecx),%edx
 61f:	90                   	nop    
 620:	eb e9                	jmp    60b <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 622:	8b 73 04             	mov    0x4(%ebx),%esi
 625:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 628:	39 d0                	cmp    %edx,%eax
 62a:	74 18                	je     644 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 62c:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 62e:	8b 51 04             	mov    0x4(%ecx),%edx
 631:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 634:	39 d8                	cmp    %ebx,%eax
 636:	74 20                	je     658 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 638:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 63a:	5b                   	pop    %ebx
 63b:	5e                   	pop    %esi
 63c:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 63d:	89 0d c0 07 00 00    	mov    %ecx,0x7c0
}
 643:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 644:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 647:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 649:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 64c:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 64f:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 651:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 654:	39 d8                	cmp    %ebx,%eax
 656:	75 e0                	jne    638 <free+0x48>
    p->s.size += bp->s.size;
 658:	03 53 04             	add    0x4(%ebx),%edx
 65b:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 65e:	8b 13                	mov    (%ebx),%edx
 660:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 662:	5b                   	pop    %ebx
 663:	5e                   	pop    %esi
 664:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 665:	89 0d c0 07 00 00    	mov    %ecx,0x7c0
}
 66b:	c3                   	ret    
 66c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000670 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	57                   	push   %edi
 674:	56                   	push   %esi
 675:	53                   	push   %ebx
 676:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 679:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 67c:	8b 15 c0 07 00 00    	mov    0x7c0,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 682:	83 c0 07             	add    $0x7,%eax
 685:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 688:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 68a:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 68d:	0f 84 8a 00 00 00    	je     71d <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 693:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 695:	8b 41 04             	mov    0x4(%ecx),%eax
 698:	39 c3                	cmp    %eax,%ebx
 69a:	76 1a                	jbe    6b6 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 69c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 6a3:	3b 0d c0 07 00 00    	cmp    0x7c0,%ecx
 6a9:	89 ca                	mov    %ecx,%edx
 6ab:	74 29                	je     6d6 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6ad:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 6af:	8b 41 04             	mov    0x4(%ecx),%eax
 6b2:	39 c3                	cmp    %eax,%ebx
 6b4:	77 ed                	ja     6a3 <malloc+0x33>
      if(p->s.size == nunits)
 6b6:	39 c3                	cmp    %eax,%ebx
 6b8:	74 5d                	je     717 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 6ba:	29 d8                	sub    %ebx,%eax
 6bc:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 6bf:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 6c2:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 6c5:	89 15 c0 07 00 00    	mov    %edx,0x7c0
      return (void*) (p + 1);
 6cb:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 6ce:	83 c4 0c             	add    $0xc,%esp
 6d1:	5b                   	pop    %ebx
 6d2:	5e                   	pop    %esi
 6d3:	5f                   	pop    %edi
 6d4:	5d                   	pop    %ebp
 6d5:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 6d6:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 6dc:	89 de                	mov    %ebx,%esi
 6de:	89 f8                	mov    %edi,%eax
 6e0:	76 29                	jbe    70b <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 6e2:	89 04 24             	mov    %eax,(%esp)
 6e5:	e8 b6 fc ff ff       	call   3a0 <sbrk>
  if(p == (char*) -1)
 6ea:	83 f8 ff             	cmp    $0xffffffff,%eax
 6ed:	74 18                	je     707 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 6ef:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 6f2:	83 c0 08             	add    $0x8,%eax
 6f5:	89 04 24             	mov    %eax,(%esp)
 6f8:	e8 f3 fe ff ff       	call   5f0 <free>
  return freep;
 6fd:	8b 15 c0 07 00 00    	mov    0x7c0,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 703:	85 d2                	test   %edx,%edx
 705:	75 a6                	jne    6ad <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 707:	31 c0                	xor    %eax,%eax
 709:	eb c3                	jmp    6ce <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 70b:	be 00 10 00 00       	mov    $0x1000,%esi
 710:	b8 00 80 00 00       	mov    $0x8000,%eax
 715:	eb cb                	jmp    6e2 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 717:	8b 01                	mov    (%ecx),%eax
 719:	89 02                	mov    %eax,(%edx)
 71b:	eb a8                	jmp    6c5 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 71d:	ba b8 07 00 00       	mov    $0x7b8,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 722:	c7 05 c0 07 00 00 b8 	movl   $0x7b8,0x7c0
 729:	07 00 00 
 72c:	c7 05 b8 07 00 00 b8 	movl   $0x7b8,0x7b8
 733:	07 00 00 
    base.s.size = 0;
 736:	c7 05 bc 07 00 00 00 	movl   $0x0,0x7bc
 73d:	00 00 00 
 740:	e9 4e ff ff ff       	jmp    693 <malloc+0x23>
