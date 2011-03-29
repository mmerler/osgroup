
_hw5-test-comp:     file format elf32-i386

Disassembly of section .text:

00000000 <panic>:
int stdin = 0;
int stdout = 1;
int stderr = 2;

inline __attribute__((noreturn)) void panic(const char *msg) {
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  printf(stderr, "[panic] %s\n", msg);
   6:	8b 45 08             	mov    0x8(%ebp),%eax
   9:	c7 44 24 04 b5 07 00 	movl   $0x7b5,0x4(%esp)
  10:	00 
  11:	89 44 24 08          	mov    %eax,0x8(%esp)
  15:	a1 40 08 00 00       	mov    0x840,%eax
  1a:	89 04 24             	mov    %eax,(%esp)
  1d:	e8 be 04 00 00       	call   4e0 <printf>
  exit();
  22:	e8 61 03 00 00       	call   388 <exit>
  27:	89 f6                	mov    %esi,%esi
  29:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000030 <main>:

#define MAX_BUF_SIZE (1024)

char *usertests_argv[] = {"usertests", 0};

int main() {
  30:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  34:	83 e4 f0             	and    $0xfffffff0,%esp
  37:	ff 71 fc             	pushl  -0x4(%ecx)
  3a:	55                   	push   %ebp
  3b:	89 e5                	mov    %esp,%ebp
  3d:	81 ec 28 04 00 00    	sub    $0x428,%esp
  int p[2];
  int child;
  char buf[MAX_BUF_SIZE];
  int succeed = 0;

  if (pipe(p) < 0)
  43:	8d 45 ec             	lea    -0x14(%ebp),%eax

#define MAX_BUF_SIZE (1024)

char *usertests_argv[] = {"usertests", 0};

int main() {
  46:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  49:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  4c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int p[2];
  int child;
  char buf[MAX_BUF_SIZE];
  int succeed = 0;

  if (pipe(p) < 0)
  4f:	89 04 24             	mov    %eax,(%esp)
  52:	e8 41 03 00 00       	call   398 <pipe>
  57:	85 c0                	test   %eax,%eax
  59:	78 6e                	js     c9 <main+0x99>
    panic("pipe failed");

  child = fork();
  5b:	e8 20 03 00 00       	call   380 <fork>
  if (child == 0) {
  60:	85 c0                	test   %eax,%eax
  62:	75 6f                	jne    d3 <main+0xa3>
    close(stdout);
  64:	a1 3c 08 00 00       	mov    0x83c,%eax
  69:	89 04 24             	mov    %eax,(%esp)
  6c:	e8 3f 03 00 00       	call   3b0 <close>
    dup(p[1]);
  71:	8b 45 f0             	mov    -0x10(%ebp),%eax
  74:	89 04 24             	mov    %eax,(%esp)
  77:	e8 84 03 00 00       	call   400 <dup>
    close(p[0]);
  7c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  7f:	89 04 24             	mov    %eax,(%esp)
  82:	e8 29 03 00 00       	call   3b0 <close>
    close(p[1]);
  87:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8a:	89 04 24             	mov    %eax,(%esp)
  8d:	e8 1e 03 00 00       	call   3b0 <close>
    exec(usertests_argv[0], usertests_argv);
  92:	a1 44 08 00 00       	mov    0x844,%eax
  97:	c7 44 24 04 44 08 00 	movl   $0x844,0x4(%esp)
  9e:	00 
  9f:	89 04 24             	mov    %eax,(%esp)
  a2:	e8 19 03 00 00       	call   3c0 <exec>
int stdin = 0;
int stdout = 1;
int stderr = 2;

inline __attribute__((noreturn)) void panic(const char *msg) {
  printf(stderr, "[panic] %s\n", msg);
  a7:	c7 44 24 08 cd 07 00 	movl   $0x7cd,0x8(%esp)
  ae:	00 
  af:	a1 40 08 00 00       	mov    0x840,%eax
  b4:	c7 44 24 04 b5 07 00 	movl   $0x7b5,0x4(%esp)
  bb:	00 
  bc:	89 04 24             	mov    %eax,(%esp)
  bf:	e8 1c 04 00 00       	call   4e0 <printf>
  exit();
  c4:	e8 bf 02 00 00       	call   388 <exit>
int stdin = 0;
int stdout = 1;
int stderr = 2;

inline __attribute__((noreturn)) void panic(const char *msg) {
  printf(stderr, "[panic] %s\n", msg);
  c9:	c7 44 24 08 c1 07 00 	movl   $0x7c1,0x8(%esp)
  d0:	00 
  d1:	eb dc                	jmp    af <main+0x7f>
    panic("exec failed");
  }
  close(stdin);
  d3:	a1 4c 08 00 00       	mov    0x84c,%eax
  dup(p[0]);
  close(p[0]);
  close(p[1]);
  d8:	31 f6                	xor    %esi,%esi
  da:	8d 9d ec fb ff ff    	lea    -0x414(%ebp),%ebx
    close(p[0]);
    close(p[1]);
    exec(usertests_argv[0], usertests_argv);
    panic("exec failed");
  }
  close(stdin);
  e0:	89 04 24             	mov    %eax,(%esp)
  e3:	e8 c8 02 00 00       	call   3b0 <close>
  dup(p[0]);
  e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  eb:	89 04 24             	mov    %eax,(%esp)
  ee:	e8 0d 03 00 00       	call   400 <dup>
  close(p[0]);
  f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  f6:	89 04 24             	mov    %eax,(%esp)
  f9:	e8 b2 02 00 00       	call   3b0 <close>
  close(p[1]);
  fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
 101:	89 04 24             	mov    %eax,(%esp)
 104:	e8 a7 02 00 00       	call   3b0 <close>

  for (;;) {
    gets(buf, MAX_BUF_SIZE);
 109:	c7 44 24 04 00 04 00 	movl   $0x400,0x4(%esp)
 110:	00 
 111:	89 1c 24             	mov    %ebx,(%esp)
 114:	e8 07 02 00 00       	call   320 <gets>
    if (strlen(buf) <= 0)
 119:	89 1c 24             	mov    %ebx,(%esp)
 11c:	e8 df 00 00 00       	call   200 <strlen>
 121:	85 c0                	test   %eax,%eax
 123:	74 1b                	je     140 <main+0x110>
      break;
    if (strcmp(buf, "ALL TESTS PASSED\n") == 0)
 125:	c7 44 24 04 d9 07 00 	movl   $0x7d9,0x4(%esp)
 12c:	00 
 12d:	89 1c 24             	mov    %ebx,(%esp)
 130:	e8 7b 00 00 00       	call   1b0 <strcmp>
 135:	85 c0                	test   %eax,%eax
 137:	75 d0                	jne    109 <main+0xd9>
 139:	be 01 00 00 00       	mov    $0x1,%esi
 13e:	eb c9                	jmp    109 <main+0xd9>
      succeed = 1;
  }
  wait();
 140:	e8 4b 02 00 00       	call   390 <wait>

  if (succeed)
 145:	85 f6                	test   %esi,%esi
 147:	74 1a                	je     163 <main+0x133>
    printf(stdout, "hw5-test-comp succeeded\n");
 149:	a1 3c 08 00 00       	mov    0x83c,%eax
 14e:	c7 44 24 04 eb 07 00 	movl   $0x7eb,0x4(%esp)
 155:	00 
 156:	89 04 24             	mov    %eax,(%esp)
 159:	e8 82 03 00 00       	call   4e0 <printf>
 15e:	e9 61 ff ff ff       	jmp    c4 <main+0x94>
  else
    printf(stdout, "hw5-test-comp failed\n");
 163:	a1 3c 08 00 00       	mov    0x83c,%eax
 168:	c7 44 24 04 04 08 00 	movl   $0x804,0x4(%esp)
 16f:	00 
 170:	89 04 24             	mov    %eax,(%esp)
 173:	e8 68 03 00 00       	call   4e0 <printf>
 178:	e9 47 ff ff ff       	jmp    c4 <main+0x94>
 17d:	90                   	nop    
 17e:	90                   	nop    
 17f:	90                   	nop    

00000180 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	53                   	push   %ebx
 184:	8b 5d 08             	mov    0x8(%ebp),%ebx
 187:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 18a:	89 da                	mov    %ebx,%edx
 18c:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 190:	0f b6 01             	movzbl (%ecx),%eax
 193:	83 c1 01             	add    $0x1,%ecx
 196:	88 02                	mov    %al,(%edx)
 198:	83 c2 01             	add    $0x1,%edx
 19b:	84 c0                	test   %al,%al
 19d:	75 f1                	jne    190 <strcpy+0x10>
    ;
  return os;
}
 19f:	89 d8                	mov    %ebx,%eax
 1a1:	5b                   	pop    %ebx
 1a2:	5d                   	pop    %ebp
 1a3:	c3                   	ret    
 1a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1b6:	53                   	push   %ebx
 1b7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 1ba:	0f b6 01             	movzbl (%ecx),%eax
 1bd:	84 c0                	test   %al,%al
 1bf:	74 24                	je     1e5 <strcmp+0x35>
 1c1:	0f b6 13             	movzbl (%ebx),%edx
 1c4:	38 d0                	cmp    %dl,%al
 1c6:	74 12                	je     1da <strcmp+0x2a>
 1c8:	eb 1e                	jmp    1e8 <strcmp+0x38>
 1ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1d0:	0f b6 13             	movzbl (%ebx),%edx
 1d3:	83 c1 01             	add    $0x1,%ecx
 1d6:	38 d0                	cmp    %dl,%al
 1d8:	75 0e                	jne    1e8 <strcmp+0x38>
 1da:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 1de:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1e1:	84 c0                	test   %al,%al
 1e3:	75 eb                	jne    1d0 <strcmp+0x20>
 1e5:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 1e8:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1e9:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 1ec:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1ed:	0f b6 d2             	movzbl %dl,%edx
 1f0:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 1f2:	c3                   	ret    
 1f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000200 <strlen>:

uint
strlen(char *s)
{
 200:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 201:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 203:	89 e5                	mov    %esp,%ebp
 205:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 208:	80 39 00             	cmpb   $0x0,(%ecx)
 20b:	74 0e                	je     21b <strlen+0x1b>
 20d:	31 d2                	xor    %edx,%edx
 20f:	90                   	nop    
 210:	83 c2 01             	add    $0x1,%edx
 213:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
 217:	89 d0                	mov    %edx,%eax
 219:	75 f5                	jne    210 <strlen+0x10>
    ;
  return n;
}
 21b:	5d                   	pop    %ebp
 21c:	c3                   	ret    
 21d:	8d 76 00             	lea    0x0(%esi),%esi

00000220 <memset>:

void*
memset(void *dst, int c, uint n)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	8b 55 08             	mov    0x8(%ebp),%edx
 226:	57                   	push   %edi
 227:	8b 45 0c             	mov    0xc(%ebp),%eax
 22a:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 22d:	89 d7                	mov    %edx,%edi
 22f:	fc                   	cld    
 230:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 232:	5f                   	pop    %edi
 233:	89 d0                	mov    %edx,%eax
 235:	5d                   	pop    %ebp
 236:	c3                   	ret    
 237:	89 f6                	mov    %esi,%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000240 <strchr>:

char*
strchr(const char *s, char c)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	8b 45 08             	mov    0x8(%ebp),%eax
 246:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 24a:	0f b6 10             	movzbl (%eax),%edx
 24d:	84 d2                	test   %dl,%dl
 24f:	75 0c                	jne    25d <strchr+0x1d>
 251:	eb 11                	jmp    264 <strchr+0x24>
 253:	83 c0 01             	add    $0x1,%eax
 256:	0f b6 10             	movzbl (%eax),%edx
 259:	84 d2                	test   %dl,%dl
 25b:	74 07                	je     264 <strchr+0x24>
    if(*s == c)
 25d:	38 ca                	cmp    %cl,%dl
 25f:	90                   	nop    
 260:	75 f1                	jne    253 <strchr+0x13>
      return (char*) s;
  return 0;
}
 262:	5d                   	pop    %ebp
 263:	c3                   	ret    
 264:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 265:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 267:	c3                   	ret    
 268:	90                   	nop    
 269:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000270 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	8b 4d 08             	mov    0x8(%ebp),%ecx
 276:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 277:	31 db                	xor    %ebx,%ebx
 279:	0f b6 11             	movzbl (%ecx),%edx
 27c:	8d 42 d0             	lea    -0x30(%edx),%eax
 27f:	3c 09                	cmp    $0x9,%al
 281:	77 18                	ja     29b <atoi+0x2b>
    n = n*10 + *s++ - '0';
 283:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 286:	0f be d2             	movsbl %dl,%edx
 289:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 28d:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 291:	83 c1 01             	add    $0x1,%ecx
 294:	8d 42 d0             	lea    -0x30(%edx),%eax
 297:	3c 09                	cmp    $0x9,%al
 299:	76 e8                	jbe    283 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 29b:	89 d8                	mov    %ebx,%eax
 29d:	5b                   	pop    %ebx
 29e:	5d                   	pop    %ebp
 29f:	c3                   	ret    

000002a0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	8b 4d 10             	mov    0x10(%ebp),%ecx
 2a6:	56                   	push   %esi
 2a7:	8b 75 08             	mov    0x8(%ebp),%esi
 2aa:	53                   	push   %ebx
 2ab:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ae:	85 c9                	test   %ecx,%ecx
 2b0:	7e 10                	jle    2c2 <memmove+0x22>
 2b2:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 2b4:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 2b8:	88 04 32             	mov    %al,(%edx,%esi,1)
 2bb:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2be:	39 ca                	cmp    %ecx,%edx
 2c0:	75 f2                	jne    2b4 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 2c2:	89 f0                	mov    %esi,%eax
 2c4:	5b                   	pop    %ebx
 2c5:	5e                   	pop    %esi
 2c6:	5d                   	pop    %ebp
 2c7:	c3                   	ret    
 2c8:	90                   	nop    
 2c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000002d0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2d6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 2d9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 2dc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 2df:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2e4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2eb:	00 
 2ec:	89 04 24             	mov    %eax,(%esp)
 2ef:	e8 d4 00 00 00       	call   3c8 <open>
  if(fd < 0)
 2f4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2f6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 2f8:	78 19                	js     313 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 2fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 2fd:	89 1c 24             	mov    %ebx,(%esp)
 300:	89 44 24 04          	mov    %eax,0x4(%esp)
 304:	e8 d7 00 00 00       	call   3e0 <fstat>
  close(fd);
 309:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 30c:	89 c6                	mov    %eax,%esi
  close(fd);
 30e:	e8 9d 00 00 00       	call   3b0 <close>
  return r;
}
 313:	89 f0                	mov    %esi,%eax
 315:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 318:	8b 75 fc             	mov    -0x4(%ebp),%esi
 31b:	89 ec                	mov    %ebp,%esp
 31d:	5d                   	pop    %ebp
 31e:	c3                   	ret    
 31f:	90                   	nop    

00000320 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	57                   	push   %edi
 324:	56                   	push   %esi
 325:	31 f6                	xor    %esi,%esi
 327:	53                   	push   %ebx
 328:	83 ec 1c             	sub    $0x1c,%esp
 32b:	8b 7d 08             	mov    0x8(%ebp),%edi
 32e:	eb 06                	jmp    336 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 330:	3c 0d                	cmp    $0xd,%al
 332:	74 39                	je     36d <gets+0x4d>
 334:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 336:	8d 5e 01             	lea    0x1(%esi),%ebx
 339:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 33c:	7d 31                	jge    36f <gets+0x4f>
    cc = read(0, &c, 1);
 33e:	8d 45 f3             	lea    -0xd(%ebp),%eax
 341:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 348:	00 
 349:	89 44 24 04          	mov    %eax,0x4(%esp)
 34d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 354:	e8 47 00 00 00       	call   3a0 <read>
    if(cc < 1)
 359:	85 c0                	test   %eax,%eax
 35b:	7e 12                	jle    36f <gets+0x4f>
      break;
    buf[i++] = c;
 35d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 361:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 365:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 369:	3c 0a                	cmp    $0xa,%al
 36b:	75 c3                	jne    330 <gets+0x10>
 36d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 36f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 373:	89 f8                	mov    %edi,%eax
 375:	83 c4 1c             	add    $0x1c,%esp
 378:	5b                   	pop    %ebx
 379:	5e                   	pop    %esi
 37a:	5f                   	pop    %edi
 37b:	5d                   	pop    %ebp
 37c:	c3                   	ret    
 37d:	90                   	nop    
 37e:	90                   	nop    
 37f:	90                   	nop    

00000380 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 380:	b8 01 00 00 00       	mov    $0x1,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <exit>:
SYSCALL(exit)
 388:	b8 02 00 00 00       	mov    $0x2,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <wait>:
SYSCALL(wait)
 390:	b8 03 00 00 00       	mov    $0x3,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <pipe>:
SYSCALL(pipe)
 398:	b8 04 00 00 00       	mov    $0x4,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <read>:
SYSCALL(read)
 3a0:	b8 06 00 00 00       	mov    $0x6,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <write>:
SYSCALL(write)
 3a8:	b8 05 00 00 00       	mov    $0x5,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <close>:
SYSCALL(close)
 3b0:	b8 07 00 00 00       	mov    $0x7,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <kill>:
SYSCALL(kill)
 3b8:	b8 08 00 00 00       	mov    $0x8,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <exec>:
SYSCALL(exec)
 3c0:	b8 09 00 00 00       	mov    $0x9,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <open>:
SYSCALL(open)
 3c8:	b8 0a 00 00 00       	mov    $0xa,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <mknod>:
SYSCALL(mknod)
 3d0:	b8 0b 00 00 00       	mov    $0xb,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <unlink>:
SYSCALL(unlink)
 3d8:	b8 0c 00 00 00       	mov    $0xc,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <fstat>:
SYSCALL(fstat)
 3e0:	b8 0d 00 00 00       	mov    $0xd,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <link>:
SYSCALL(link)
 3e8:	b8 0e 00 00 00       	mov    $0xe,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <mkdir>:
SYSCALL(mkdir)
 3f0:	b8 0f 00 00 00       	mov    $0xf,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <chdir>:
SYSCALL(chdir)
 3f8:	b8 10 00 00 00       	mov    $0x10,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <dup>:
SYSCALL(dup)
 400:	b8 11 00 00 00       	mov    $0x11,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <getpid>:
SYSCALL(getpid)
 408:	b8 12 00 00 00       	mov    $0x12,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <sbrk>:
SYSCALL(sbrk)
 410:	b8 13 00 00 00       	mov    $0x13,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <sleep>:
SYSCALL(sleep)
 418:	b8 14 00 00 00       	mov    $0x14,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <uptime>:
SYSCALL(uptime)
 420:	b8 15 00 00 00       	mov    $0x15,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <freepages>:
// Added by Jingyue
SYSCALL(freepages)
 428:	b8 16 00 00 00       	mov    $0x16,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	83 ec 18             	sub    $0x18,%esp
 436:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 439:	8d 55 fc             	lea    -0x4(%ebp),%edx
 43c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 443:	00 
 444:	89 54 24 04          	mov    %edx,0x4(%esp)
 448:	89 04 24             	mov    %eax,(%esp)
 44b:	e8 58 ff ff ff       	call   3a8 <write>
}
 450:	c9                   	leave  
 451:	c3                   	ret    
 452:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 459:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000460 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	56                   	push   %esi
 465:	89 ce                	mov    %ecx,%esi
 467:	53                   	push   %ebx
 468:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 46b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 46e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 471:	85 c9                	test   %ecx,%ecx
 473:	74 04                	je     479 <printint+0x19>
 475:	85 d2                	test   %edx,%edx
 477:	78 54                	js     4cd <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 479:	89 d0                	mov    %edx,%eax
 47b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 482:	31 db                	xor    %ebx,%ebx
 484:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 487:	31 d2                	xor    %edx,%edx
 489:	f7 f6                	div    %esi
 48b:	89 c1                	mov    %eax,%ecx
 48d:	0f b6 82 2b 08 00 00 	movzbl 0x82b(%edx),%eax
 494:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 497:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 49a:	85 c9                	test   %ecx,%ecx
 49c:	89 c8                	mov    %ecx,%eax
 49e:	75 e7                	jne    487 <printint+0x27>
  if(neg)
 4a0:	8b 45 e0             	mov    -0x20(%ebp),%eax
 4a3:	85 c0                	test   %eax,%eax
 4a5:	74 08                	je     4af <printint+0x4f>
    buf[i++] = '-';
 4a7:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 4ac:	83 c3 01             	add    $0x1,%ebx
 4af:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 4b2:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 4b6:	83 eb 01             	sub    $0x1,%ebx
 4b9:	8b 45 dc             	mov    -0x24(%ebp),%eax
 4bc:	e8 6f ff ff ff       	call   430 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4c1:	39 fb                	cmp    %edi,%ebx
 4c3:	75 ed                	jne    4b2 <printint+0x52>
    putc(fd, buf[i]);
}
 4c5:	83 c4 1c             	add    $0x1c,%esp
 4c8:	5b                   	pop    %ebx
 4c9:	5e                   	pop    %esi
 4ca:	5f                   	pop    %edi
 4cb:	5d                   	pop    %ebp
 4cc:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 4cd:	89 d0                	mov    %edx,%eax
 4cf:	f7 d8                	neg    %eax
 4d1:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 4d8:	eb a8                	jmp    482 <printint+0x22>
 4da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000004e0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	56                   	push   %esi
 4e5:	53                   	push   %ebx
 4e6:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4e9:	8b 55 0c             	mov    0xc(%ebp),%edx
 4ec:	0f b6 02             	movzbl (%edx),%eax
 4ef:	84 c0                	test   %al,%al
 4f1:	0f 84 87 00 00 00    	je     57e <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 4f7:	8d 4d 10             	lea    0x10(%ebp),%ecx
 4fa:	31 ff                	xor    %edi,%edi
 4fc:	31 f6                	xor    %esi,%esi
 4fe:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 501:	eb 18                	jmp    51b <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 503:	83 fb 25             	cmp    $0x25,%ebx
 506:	0f 85 7a 00 00 00    	jne    586 <printf+0xa6>
 50c:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 510:	83 c7 01             	add    $0x1,%edi
 513:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 517:	84 c0                	test   %al,%al
 519:	74 63                	je     57e <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 51b:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 51d:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 520:	74 e1                	je     503 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 522:	83 fe 25             	cmp    $0x25,%esi
 525:	75 e9                	jne    510 <printf+0x30>
      if(c == 'd'){
 527:	83 fb 64             	cmp    $0x64,%ebx
 52a:	0f 84 f0 00 00 00    	je     620 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 530:	83 fb 78             	cmp    $0x78,%ebx
 533:	74 64                	je     599 <printf+0xb9>
 535:	83 fb 70             	cmp    $0x70,%ebx
 538:	74 5f                	je     599 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 53a:	83 fb 73             	cmp    $0x73,%ebx
 53d:	8d 76 00             	lea    0x0(%esi),%esi
 540:	74 7e                	je     5c0 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 542:	83 fb 63             	cmp    $0x63,%ebx
 545:	0f 84 b9 00 00 00    	je     604 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 54b:	83 fb 25             	cmp    $0x25,%ebx
 54e:	66 90                	xchg   %ax,%ax
 550:	0f 84 f2 00 00 00    	je     648 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 556:	8b 45 08             	mov    0x8(%ebp),%eax
 559:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 55e:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 561:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 563:	e8 c8 fe ff ff       	call   430 <putc>
        putc(fd, c);
 568:	8b 45 08             	mov    0x8(%ebp),%eax
 56b:	0f be d3             	movsbl %bl,%edx
 56e:	e8 bd fe ff ff       	call   430 <putc>
 573:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 576:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 57a:	84 c0                	test   %al,%al
 57c:	75 9d                	jne    51b <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 57e:	83 c4 0c             	add    $0xc,%esp
 581:	5b                   	pop    %ebx
 582:	5e                   	pop    %esi
 583:	5f                   	pop    %edi
 584:	5d                   	pop    %ebp
 585:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 586:	8b 45 08             	mov    0x8(%ebp),%eax
 589:	0f be d3             	movsbl %bl,%edx
 58c:	e8 9f fe ff ff       	call   430 <putc>
 591:	8b 55 0c             	mov    0xc(%ebp),%edx
 594:	e9 77 ff ff ff       	jmp    510 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 599:	8b 45 f0             	mov    -0x10(%ebp),%eax
 59c:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 5a1:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5a3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 5aa:	8b 10                	mov    (%eax),%edx
 5ac:	8b 45 08             	mov    0x8(%ebp),%eax
 5af:	e8 ac fe ff ff       	call   460 <printint>
 5b4:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 5b7:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 5bb:	e9 50 ff ff ff       	jmp    510 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 5c0:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 5c3:	8b 01                	mov    (%ecx),%eax
        ap++;
 5c5:	83 c1 04             	add    $0x4,%ecx
 5c8:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 5cb:	b9 24 08 00 00       	mov    $0x824,%ecx
 5d0:	85 c0                	test   %eax,%eax
 5d2:	75 2c                	jne    600 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 5d4:	0f b6 01             	movzbl (%ecx),%eax
 5d7:	84 c0                	test   %al,%al
 5d9:	74 1e                	je     5f9 <printf+0x119>
 5db:	89 cb                	mov    %ecx,%ebx
 5dd:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 5e0:	0f be d0             	movsbl %al,%edx
 5e3:	8b 45 08             	mov    0x8(%ebp),%eax
 5e6:	e8 45 fe ff ff       	call   430 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5eb:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 5ef:	83 c3 01             	add    $0x1,%ebx
 5f2:	84 c0                	test   %al,%al
 5f4:	75 ea                	jne    5e0 <printf+0x100>
 5f6:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 5f9:	31 f6                	xor    %esi,%esi
 5fb:	e9 10 ff ff ff       	jmp    510 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 600:	89 c1                	mov    %eax,%ecx
 602:	eb d0                	jmp    5d4 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 604:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 607:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 609:	0f be 10             	movsbl (%eax),%edx
 60c:	8b 45 08             	mov    0x8(%ebp),%eax
 60f:	e8 1c fe ff ff       	call   430 <putc>
 614:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 617:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 61b:	e9 f0 fe ff ff       	jmp    510 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 620:	8b 45 f0             	mov    -0x10(%ebp),%eax
 623:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 628:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 62b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 632:	8b 10                	mov    (%eax),%edx
 634:	8b 45 08             	mov    0x8(%ebp),%eax
 637:	e8 24 fe ff ff       	call   460 <printint>
 63c:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 63f:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 643:	e9 c8 fe ff ff       	jmp    510 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 648:	8b 45 08             	mov    0x8(%ebp),%eax
 64b:	ba 25 00 00 00       	mov    $0x25,%edx
 650:	31 f6                	xor    %esi,%esi
 652:	e8 d9 fd ff ff       	call   430 <putc>
 657:	8b 55 0c             	mov    0xc(%ebp),%edx
 65a:	e9 b1 fe ff ff       	jmp    510 <printf+0x30>
 65f:	90                   	nop    

00000660 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 660:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 661:	8b 0d 58 08 00 00    	mov    0x858,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 667:	89 e5                	mov    %esp,%ebp
 669:	56                   	push   %esi
 66a:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 66b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 66e:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 671:	39 d9                	cmp    %ebx,%ecx
 673:	73 18                	jae    68d <free+0x2d>
 675:	8b 11                	mov    (%ecx),%edx
 677:	39 d3                	cmp    %edx,%ebx
 679:	72 17                	jb     692 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 67b:	39 d1                	cmp    %edx,%ecx
 67d:	72 08                	jb     687 <free+0x27>
 67f:	39 d9                	cmp    %ebx,%ecx
 681:	72 0f                	jb     692 <free+0x32>
 683:	39 d3                	cmp    %edx,%ebx
 685:	72 0b                	jb     692 <free+0x32>
 687:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 689:	39 d9                	cmp    %ebx,%ecx
 68b:	72 e8                	jb     675 <free+0x15>
 68d:	8b 11                	mov    (%ecx),%edx
 68f:	90                   	nop    
 690:	eb e9                	jmp    67b <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 692:	8b 73 04             	mov    0x4(%ebx),%esi
 695:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 698:	39 d0                	cmp    %edx,%eax
 69a:	74 18                	je     6b4 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 69c:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 69e:	8b 51 04             	mov    0x4(%ecx),%edx
 6a1:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 6a4:	39 d8                	cmp    %ebx,%eax
 6a6:	74 20                	je     6c8 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6a8:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 6aa:	5b                   	pop    %ebx
 6ab:	5e                   	pop    %esi
 6ac:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 6ad:	89 0d 58 08 00 00    	mov    %ecx,0x858
}
 6b3:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6b4:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 6b7:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6b9:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6bc:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 6bf:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6c1:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 6c4:	39 d8                	cmp    %ebx,%eax
 6c6:	75 e0                	jne    6a8 <free+0x48>
    p->s.size += bp->s.size;
 6c8:	03 53 04             	add    0x4(%ebx),%edx
 6cb:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 6ce:	8b 13                	mov    (%ebx),%edx
 6d0:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 6d2:	5b                   	pop    %ebx
 6d3:	5e                   	pop    %esi
 6d4:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 6d5:	89 0d 58 08 00 00    	mov    %ecx,0x858
}
 6db:	c3                   	ret    
 6dc:	8d 74 26 00          	lea    0x0(%esi),%esi

000006e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	57                   	push   %edi
 6e4:	56                   	push   %esi
 6e5:	53                   	push   %ebx
 6e6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6ec:	8b 15 58 08 00 00    	mov    0x858,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6f2:	83 c0 07             	add    $0x7,%eax
 6f5:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 6f8:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6fa:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 6fd:	0f 84 8a 00 00 00    	je     78d <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 703:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 705:	8b 41 04             	mov    0x4(%ecx),%eax
 708:	39 c3                	cmp    %eax,%ebx
 70a:	76 1a                	jbe    726 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 70c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 713:	3b 0d 58 08 00 00    	cmp    0x858,%ecx
 719:	89 ca                	mov    %ecx,%edx
 71b:	74 29                	je     746 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 71d:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 71f:	8b 41 04             	mov    0x4(%ecx),%eax
 722:	39 c3                	cmp    %eax,%ebx
 724:	77 ed                	ja     713 <malloc+0x33>
      if(p->s.size == nunits)
 726:	39 c3                	cmp    %eax,%ebx
 728:	74 5d                	je     787 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 72a:	29 d8                	sub    %ebx,%eax
 72c:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 72f:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 732:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 735:	89 15 58 08 00 00    	mov    %edx,0x858
      return (void*) (p + 1);
 73b:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 73e:	83 c4 0c             	add    $0xc,%esp
 741:	5b                   	pop    %ebx
 742:	5e                   	pop    %esi
 743:	5f                   	pop    %edi
 744:	5d                   	pop    %ebp
 745:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 746:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 74c:	89 de                	mov    %ebx,%esi
 74e:	89 f8                	mov    %edi,%eax
 750:	76 29                	jbe    77b <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 752:	89 04 24             	mov    %eax,(%esp)
 755:	e8 b6 fc ff ff       	call   410 <sbrk>
  if(p == (char*) -1)
 75a:	83 f8 ff             	cmp    $0xffffffff,%eax
 75d:	74 18                	je     777 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 75f:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 762:	83 c0 08             	add    $0x8,%eax
 765:	89 04 24             	mov    %eax,(%esp)
 768:	e8 f3 fe ff ff       	call   660 <free>
  return freep;
 76d:	8b 15 58 08 00 00    	mov    0x858,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 773:	85 d2                	test   %edx,%edx
 775:	75 a6                	jne    71d <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 777:	31 c0                	xor    %eax,%eax
 779:	eb c3                	jmp    73e <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 77b:	be 00 10 00 00       	mov    $0x1000,%esi
 780:	b8 00 80 00 00       	mov    $0x8000,%eax
 785:	eb cb                	jmp    752 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 787:	8b 01                	mov    (%ecx),%eax
 789:	89 02                	mov    %eax,(%edx)
 78b:	eb a8                	jmp    735 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 78d:	ba 50 08 00 00       	mov    $0x850,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 792:	c7 05 58 08 00 00 50 	movl   $0x850,0x858
 799:	08 00 00 
 79c:	c7 05 50 08 00 00 50 	movl   $0x850,0x850
 7a3:	08 00 00 
    base.s.size = 0;
 7a6:	c7 05 54 08 00 00 00 	movl   $0x0,0x854
 7ad:	00 00 00 
 7b0:	e9 4e ff ff ff       	jmp    703 <malloc+0x23>
