
_forktest:     file format elf32-i386

Disassembly of section .text:

00000000 <printf>:

#define N  1000

void
printf(int fd, char *s, ...)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 14             	sub    $0x14,%esp
   7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  write(fd, s, strlen(s));
   a:	89 1c 24             	mov    %ebx,(%esp)
   d:	e8 8e 01 00 00       	call   1a0 <strlen>
  12:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  16:	89 44 24 08          	mov    %eax,0x8(%esp)
  1a:	8b 45 08             	mov    0x8(%ebp),%eax
  1d:	89 04 24             	mov    %eax,(%esp)
  20:	e8 23 03 00 00       	call   348 <write>
}
  25:	83 c4 14             	add    $0x14,%esp
  28:	5b                   	pop    %ebx
  29:	5d                   	pop    %ebp
  2a:	c3                   	ret    
  2b:	90                   	nop    
  2c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000030 <forktest>:

void
forktest(void)
{
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	53                   	push   %ebx
  int n, pid;

  printf(1, "fork test\n");
  34:	31 db                	xor    %ebx,%ebx
  write(fd, s, strlen(s));
}

void
forktest(void)
{
  36:	83 ec 14             	sub    $0x14,%esp
  int n, pid;

  printf(1, "fork test\n");
  39:	c7 44 24 04 f0 03 00 	movl   $0x3f0,0x4(%esp)
  40:	00 
  41:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  48:	e8 b3 ff ff ff       	call   0 <printf>
  4d:	eb 13                	jmp    62 <forktest+0x32>
  4f:	90                   	nop    

  for(n=0; n<N; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
  50:	74 68                	je     ba <forktest+0x8a>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<N; n++){
  52:	83 c3 01             	add    $0x1,%ebx
  55:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
  5b:	90                   	nop    
  5c:	8d 74 26 00          	lea    0x0(%esi),%esi
  60:	74 5d                	je     bf <forktest+0x8f>
    pid = fork();
  62:	e8 b9 02 00 00       	call   320 <fork>
    if(pid < 0)
  67:	83 f8 00             	cmp    $0x0,%eax
  6a:	7d e4                	jge    50 <forktest+0x20>
  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit();
  }
  
  for(; n > 0; n--){
  6c:	85 db                	test   %ebx,%ebx
  6e:	66 90                	xchg   %ax,%ax
  70:	7e 10                	jle    82 <forktest+0x52>
    if(wait() < 0){
  72:	e8 b9 02 00 00       	call   330 <wait>
  77:	85 c0                	test   %eax,%eax
  79:	78 2b                	js     a6 <forktest+0x76>
  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit();
  }
  
  for(; n > 0; n--){
  7b:	83 eb 01             	sub    $0x1,%ebx
  7e:	66 90                	xchg   %ax,%ax
  80:	75 f0                	jne    72 <forktest+0x42>
      printf(1, "wait stopped early\n");
      exit();
    }
  }
  
  if(wait() != -1){
  82:	e8 a9 02 00 00       	call   330 <wait>
  87:	83 c0 01             	add    $0x1,%eax
  8a:	75 54                	jne    e0 <forktest+0xb0>
    printf(1, "wait got too many\n");
    exit();
  }
  
  printf(1, "fork test OK\n");
  8c:	c7 44 24 04 22 04 00 	movl   $0x422,0x4(%esp)
  93:	00 
  94:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  9b:	e8 60 ff ff ff       	call   0 <printf>
}
  a0:	83 c4 14             	add    $0x14,%esp
  a3:	5b                   	pop    %ebx
  a4:	5d                   	pop    %ebp
  a5:	c3                   	ret    
    exit();
  }
  
  for(; n > 0; n--){
    if(wait() < 0){
      printf(1, "wait stopped early\n");
  a6:	c7 44 24 04 fb 03 00 	movl   $0x3fb,0x4(%esp)
  ad:	00 
  ae:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  b5:	e8 46 ff ff ff       	call   0 <printf>
      exit();
  ba:	e8 69 02 00 00       	call   328 <exit>
    if(pid == 0)
      exit();
  }
  
  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
  bf:	c7 44 24 08 e8 03 00 	movl   $0x3e8,0x8(%esp)
  c6:	00 
  c7:	c7 44 24 04 30 04 00 	movl   $0x430,0x4(%esp)
  ce:	00 
  cf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  d6:	e8 25 ff ff ff       	call   0 <printf>
  }
  
  for(; n > 0; n--){
    if(wait() < 0){
      printf(1, "wait stopped early\n");
      exit();
  db:	e8 48 02 00 00       	call   328 <exit>
    }
  }
  
  if(wait() != -1){
    printf(1, "wait got too many\n");
  e0:	c7 44 24 04 0f 04 00 	movl   $0x40f,0x4(%esp)
  e7:	00 
  e8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  ef:	e8 0c ff ff ff       	call   0 <printf>
    exit();
  f4:	e8 2f 02 00 00       	call   328 <exit>
  f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000100 <main>:
  printf(1, "fork test OK\n");
}

int
main(void)
{
 100:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 104:	83 e4 f0             	and    $0xfffffff0,%esp
 107:	ff 71 fc             	pushl  -0x4(%ecx)
 10a:	55                   	push   %ebp
 10b:	89 e5                	mov    %esp,%ebp
 10d:	51                   	push   %ecx
 10e:	83 ec 04             	sub    $0x4,%esp
  forktest();
 111:	e8 1a ff ff ff       	call   30 <forktest>
  exit();
 116:	e8 0d 02 00 00       	call   328 <exit>
 11b:	90                   	nop    
 11c:	90                   	nop    
 11d:	90                   	nop    
 11e:	90                   	nop    
 11f:	90                   	nop    

00000120 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	53                   	push   %ebx
 124:	8b 5d 08             	mov    0x8(%ebp),%ebx
 127:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 12a:	89 da                	mov    %ebx,%edx
 12c:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 130:	0f b6 01             	movzbl (%ecx),%eax
 133:	83 c1 01             	add    $0x1,%ecx
 136:	88 02                	mov    %al,(%edx)
 138:	83 c2 01             	add    $0x1,%edx
 13b:	84 c0                	test   %al,%al
 13d:	75 f1                	jne    130 <strcpy+0x10>
    ;
  return os;
}
 13f:	89 d8                	mov    %ebx,%eax
 141:	5b                   	pop    %ebx
 142:	5d                   	pop    %ebp
 143:	c3                   	ret    
 144:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 14a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000150 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	8b 4d 08             	mov    0x8(%ebp),%ecx
 156:	53                   	push   %ebx
 157:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 15a:	0f b6 01             	movzbl (%ecx),%eax
 15d:	84 c0                	test   %al,%al
 15f:	74 24                	je     185 <strcmp+0x35>
 161:	0f b6 13             	movzbl (%ebx),%edx
 164:	38 d0                	cmp    %dl,%al
 166:	74 12                	je     17a <strcmp+0x2a>
 168:	eb 1e                	jmp    188 <strcmp+0x38>
 16a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 170:	0f b6 13             	movzbl (%ebx),%edx
 173:	83 c1 01             	add    $0x1,%ecx
 176:	38 d0                	cmp    %dl,%al
 178:	75 0e                	jne    188 <strcmp+0x38>
 17a:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 17e:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 181:	84 c0                	test   %al,%al
 183:	75 eb                	jne    170 <strcmp+0x20>
 185:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 188:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 189:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 18c:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 18d:	0f b6 d2             	movzbl %dl,%edx
 190:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 192:	c3                   	ret    
 193:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 199:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000001a0 <strlen>:

uint
strlen(char *s)
{
 1a0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 1a1:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 1a3:	89 e5                	mov    %esp,%ebp
 1a5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1a8:	80 39 00             	cmpb   $0x0,(%ecx)
 1ab:	74 0e                	je     1bb <strlen+0x1b>
 1ad:	31 d2                	xor    %edx,%edx
 1af:	90                   	nop    
 1b0:	83 c2 01             	add    $0x1,%edx
 1b3:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
 1b7:	89 d0                	mov    %edx,%eax
 1b9:	75 f5                	jne    1b0 <strlen+0x10>
    ;
  return n;
}
 1bb:	5d                   	pop    %ebp
 1bc:	c3                   	ret    
 1bd:	8d 76 00             	lea    0x0(%esi),%esi

000001c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 55 08             	mov    0x8(%ebp),%edx
 1c6:	57                   	push   %edi
 1c7:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ca:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1cd:	89 d7                	mov    %edx,%edi
 1cf:	fc                   	cld    
 1d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1d2:	5f                   	pop    %edi
 1d3:	89 d0                	mov    %edx,%eax
 1d5:	5d                   	pop    %ebp
 1d6:	c3                   	ret    
 1d7:	89 f6                	mov    %esi,%esi
 1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000001e0 <strchr>:

char*
strchr(const char *s, char c)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1ea:	0f b6 10             	movzbl (%eax),%edx
 1ed:	84 d2                	test   %dl,%dl
 1ef:	75 0c                	jne    1fd <strchr+0x1d>
 1f1:	eb 11                	jmp    204 <strchr+0x24>
 1f3:	83 c0 01             	add    $0x1,%eax
 1f6:	0f b6 10             	movzbl (%eax),%edx
 1f9:	84 d2                	test   %dl,%dl
 1fb:	74 07                	je     204 <strchr+0x24>
    if(*s == c)
 1fd:	38 ca                	cmp    %cl,%dl
 1ff:	90                   	nop    
 200:	75 f1                	jne    1f3 <strchr+0x13>
      return (char*) s;
  return 0;
}
 202:	5d                   	pop    %ebp
 203:	c3                   	ret    
 204:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 205:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 207:	c3                   	ret    
 208:	90                   	nop    
 209:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000210 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	8b 4d 08             	mov    0x8(%ebp),%ecx
 216:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 217:	31 db                	xor    %ebx,%ebx
 219:	0f b6 11             	movzbl (%ecx),%edx
 21c:	8d 42 d0             	lea    -0x30(%edx),%eax
 21f:	3c 09                	cmp    $0x9,%al
 221:	77 18                	ja     23b <atoi+0x2b>
    n = n*10 + *s++ - '0';
 223:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 226:	0f be d2             	movsbl %dl,%edx
 229:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 22d:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 231:	83 c1 01             	add    $0x1,%ecx
 234:	8d 42 d0             	lea    -0x30(%edx),%eax
 237:	3c 09                	cmp    $0x9,%al
 239:	76 e8                	jbe    223 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 23b:	89 d8                	mov    %ebx,%eax
 23d:	5b                   	pop    %ebx
 23e:	5d                   	pop    %ebp
 23f:	c3                   	ret    

00000240 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	8b 4d 10             	mov    0x10(%ebp),%ecx
 246:	56                   	push   %esi
 247:	8b 75 08             	mov    0x8(%ebp),%esi
 24a:	53                   	push   %ebx
 24b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 24e:	85 c9                	test   %ecx,%ecx
 250:	7e 10                	jle    262 <memmove+0x22>
 252:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 254:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 258:	88 04 32             	mov    %al,(%edx,%esi,1)
 25b:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 25e:	39 ca                	cmp    %ecx,%edx
 260:	75 f2                	jne    254 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 262:	89 f0                	mov    %esi,%eax
 264:	5b                   	pop    %ebx
 265:	5e                   	pop    %esi
 266:	5d                   	pop    %ebp
 267:	c3                   	ret    
 268:	90                   	nop    
 269:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000270 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 276:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 279:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 27c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 27f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 284:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 28b:	00 
 28c:	89 04 24             	mov    %eax,(%esp)
 28f:	e8 d4 00 00 00       	call   368 <open>
  if(fd < 0)
 294:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 296:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 298:	78 19                	js     2b3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 29a:	8b 45 0c             	mov    0xc(%ebp),%eax
 29d:	89 1c 24             	mov    %ebx,(%esp)
 2a0:	89 44 24 04          	mov    %eax,0x4(%esp)
 2a4:	e8 d7 00 00 00       	call   380 <fstat>
  close(fd);
 2a9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 2ac:	89 c6                	mov    %eax,%esi
  close(fd);
 2ae:	e8 9d 00 00 00       	call   350 <close>
  return r;
}
 2b3:	89 f0                	mov    %esi,%eax
 2b5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 2b8:	8b 75 fc             	mov    -0x4(%ebp),%esi
 2bb:	89 ec                	mov    %ebp,%esp
 2bd:	5d                   	pop    %ebp
 2be:	c3                   	ret    
 2bf:	90                   	nop    

000002c0 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	57                   	push   %edi
 2c4:	56                   	push   %esi
 2c5:	31 f6                	xor    %esi,%esi
 2c7:	53                   	push   %ebx
 2c8:	83 ec 1c             	sub    $0x1c,%esp
 2cb:	8b 7d 08             	mov    0x8(%ebp),%edi
 2ce:	eb 06                	jmp    2d6 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2d0:	3c 0d                	cmp    $0xd,%al
 2d2:	74 39                	je     30d <gets+0x4d>
 2d4:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2d6:	8d 5e 01             	lea    0x1(%esi),%ebx
 2d9:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2dc:	7d 31                	jge    30f <gets+0x4f>
    cc = read(0, &c, 1);
 2de:	8d 45 f3             	lea    -0xd(%ebp),%eax
 2e1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2e8:	00 
 2e9:	89 44 24 04          	mov    %eax,0x4(%esp)
 2ed:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2f4:	e8 47 00 00 00       	call   340 <read>
    if(cc < 1)
 2f9:	85 c0                	test   %eax,%eax
 2fb:	7e 12                	jle    30f <gets+0x4f>
      break;
    buf[i++] = c;
 2fd:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 301:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 305:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 309:	3c 0a                	cmp    $0xa,%al
 30b:	75 c3                	jne    2d0 <gets+0x10>
 30d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 30f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 313:	89 f8                	mov    %edi,%eax
 315:	83 c4 1c             	add    $0x1c,%esp
 318:	5b                   	pop    %ebx
 319:	5e                   	pop    %esi
 31a:	5f                   	pop    %edi
 31b:	5d                   	pop    %ebp
 31c:	c3                   	ret    
 31d:	90                   	nop    
 31e:	90                   	nop    
 31f:	90                   	nop    

00000320 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 320:	b8 01 00 00 00       	mov    $0x1,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <exit>:
SYSCALL(exit)
 328:	b8 02 00 00 00       	mov    $0x2,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <wait>:
SYSCALL(wait)
 330:	b8 03 00 00 00       	mov    $0x3,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <pipe>:
SYSCALL(pipe)
 338:	b8 04 00 00 00       	mov    $0x4,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <read>:
SYSCALL(read)
 340:	b8 06 00 00 00       	mov    $0x6,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <write>:
SYSCALL(write)
 348:	b8 05 00 00 00       	mov    $0x5,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <close>:
SYSCALL(close)
 350:	b8 07 00 00 00       	mov    $0x7,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <kill>:
SYSCALL(kill)
 358:	b8 08 00 00 00       	mov    $0x8,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <exec>:
SYSCALL(exec)
 360:	b8 09 00 00 00       	mov    $0x9,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <open>:
SYSCALL(open)
 368:	b8 0a 00 00 00       	mov    $0xa,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <mknod>:
SYSCALL(mknod)
 370:	b8 0b 00 00 00       	mov    $0xb,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <unlink>:
SYSCALL(unlink)
 378:	b8 0c 00 00 00       	mov    $0xc,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <fstat>:
SYSCALL(fstat)
 380:	b8 0d 00 00 00       	mov    $0xd,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <link>:
SYSCALL(link)
 388:	b8 0e 00 00 00       	mov    $0xe,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <mkdir>:
SYSCALL(mkdir)
 390:	b8 0f 00 00 00       	mov    $0xf,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <chdir>:
SYSCALL(chdir)
 398:	b8 10 00 00 00       	mov    $0x10,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <dup>:
SYSCALL(dup)
 3a0:	b8 11 00 00 00       	mov    $0x11,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <getpid>:
SYSCALL(getpid)
 3a8:	b8 12 00 00 00       	mov    $0x12,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <sbrk>:
SYSCALL(sbrk)
 3b0:	b8 13 00 00 00       	mov    $0x13,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <sleep>:
SYSCALL(sleep)
 3b8:	b8 14 00 00 00       	mov    $0x14,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <uptime>:
SYSCALL(uptime)
 3c0:	b8 15 00 00 00       	mov    $0x15,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <nice>:
SYSCALL(nice)
 3c8:	b8 16 00 00 00       	mov    $0x16,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <getpriority>:
SYSCALL(getpriority)
 3d0:	b8 17 00 00 00       	mov    $0x17,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <setpriority>:
SYSCALL(setpriority)
 3d8:	b8 18 00 00 00       	mov    $0x18,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <getaffinity>:
SYSCALL(getaffinity)
 3e0:	b8 19 00 00 00       	mov    $0x19,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <setaffinity>:
SYSCALL(setaffinity)
 3e8:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    
