
_hw3-test-multiple:     file format elf32-i386

Disassembly of section .text:

00000000 <time_equal>:

int stdout = 1;
int stderr = 2;

// Return true if <a> and <b> differ in at most 5%. 
inline int time_equal(int a, int b) {
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	8b 55 08             	mov    0x8(%ebp),%edx
   6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  if (a < 0 || b < 0)
   9:	85 d2                	test   %edx,%edx
   b:	78 23                	js     30 <time_equal+0x30>
   d:	85 c9                	test   %ecx,%ecx
   f:	78 1f                	js     30 <time_equal+0x30>
    return 0;
  if (a > b) {
  11:	39 ca                	cmp    %ecx,%edx
  13:	7e 06                	jle    1b <time_equal+0x1b>
  15:	89 c8                	mov    %ecx,%eax
  17:	89 d1                	mov    %edx,%ecx
  19:	89 c2                	mov    %eax,%edx
    int t = a;
    a = b;
    b = t;
  }
  return 10 * (b - a) <= b;
  1b:	89 c8                	mov    %ecx,%eax
  1d:	29 d0                	sub    %edx,%eax
  1f:	8d 04 80             	lea    (%eax,%eax,4),%eax
  22:	01 c0                	add    %eax,%eax
  24:	39 c8                	cmp    %ecx,%eax
}
  26:	5d                   	pop    %ebp
  if (a > b) {
    int t = a;
    a = b;
    b = t;
  }
  return 10 * (b - a) <= b;
  27:	0f 9e c0             	setle  %al
  2a:	0f b6 c0             	movzbl %al,%eax
}
  2d:	c3                   	ret    
  2e:	66 90                	xchg   %ax,%ax
  30:	5d                   	pop    %ebp
int stdout = 1;
int stderr = 2;

// Return true if <a> and <b> differ in at most 5%. 
inline int time_equal(int a, int b) {
  if (a < 0 || b < 0)
  31:	31 c0                	xor    %eax,%eax
    int t = a;
    a = b;
    b = t;
  }
  return 10 * (b - a) <= b;
}
  33:	c3                   	ret    
  34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000040 <entry>:
#define N_THREADS 48

int check[N_THREADS];

void entry(void *arg)
{
  40:	55                   	push   %ebp
  41:	89 e5                	mov    %esp,%ebp
  43:	8b 55 08             	mov    0x8(%ebp),%edx
  check[(int)arg] = MAGIC_VALUE + (int)arg;

  texit();
}
  46:	5d                   	pop    %ebp

int check[N_THREADS];

void entry(void *arg)
{
  check[(int)arg] = MAGIC_VALUE + (int)arg;
  47:	8d 82 ef cd 87 09    	lea    0x987cdef(%edx),%eax
  4d:	89 04 95 00 09 00 00 	mov    %eax,0x900(,%edx,4)

  texit();
  54:	e9 47 04 00 00       	jmp    4a0 <texit>
  59:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000060 <handle_error>:

inline void handle_error(const char *msg) {
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	83 ec 18             	sub    $0x18,%esp
  printf(stderr, "%s\n", msg);
  66:	8b 45 08             	mov    0x8(%ebp),%eax
  69:	c7 44 24 04 35 08 00 	movl   $0x835,0x4(%esp)
  70:	00 
  71:	89 44 24 08          	mov    %eax,0x8(%esp)
  75:	a1 d0 08 00 00       	mov    0x8d0,%eax
  7a:	89 04 24             	mov    %eax,(%esp)
  7d:	e8 de 04 00 00       	call   560 <printf>
  exit();
  82:	e8 61 03 00 00       	call   3e8 <exit>
  87:	89 f6                	mov    %esi,%esi
  89:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000090 <main>:
}

int main(int argc, char *argv[])
{
  90:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  94:	83 e4 f0             	and    $0xfffffff0,%esp
  97:	ff 71 fc             	pushl  -0x4(%ecx)
  9a:	55                   	push   %ebp
  9b:	89 e5                	mov    %esp,%ebp
  9d:	57                   	push   %edi
  9e:	56                   	push   %esi
  9f:	31 f6                	xor    %esi,%esi
  a1:	53                   	push   %ebx
  a2:	51                   	push   %ecx
  a3:	81 ec 98 01 00 00    	sub    $0x198,%esp
  a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  char *stack[N_THREADS];
  int tid[N_THREADS];
  int i;

  for (i = 0; i < N_THREADS; i++)
    NEW_STACK_THREAD(entry, (char *)i, stack[i], tid[i]);
  b0:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  b7:	e8 a4 06 00 00       	call   760 <malloc>
  bc:	85 c0                	test   %eax,%eax
  be:	89 c3                	mov    %eax,%ebx
  c0:	0f 84 c6 00 00 00    	je     18c <main+0xfc>
  c6:	8d 80 00 10 00 00    	lea    0x1000(%eax),%eax
  cc:	89 44 24 08          	mov    %eax,0x8(%esp)
  d0:	89 74 24 04          	mov    %esi,0x4(%esp)
  d4:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
  db:	e8 b8 03 00 00       	call   498 <tfork>
  e0:	85 c0                	test   %eax,%eax
  e2:	0f 88 ae 00 00 00    	js     196 <main+0x106>
  e8:	8d 95 30 ff ff ff    	lea    -0xd0(%ebp),%edx
  ee:	8d bd 70 fe ff ff    	lea    -0x190(%ebp),%edi
  f4:	89 95 6c fe ff ff    	mov    %edx,-0x194(%ebp)
  fa:	89 1c b2             	mov    %ebx,(%edx,%esi,4)
  fd:	89 04 b7             	mov    %eax,(%edi,%esi,4)
{
  char *stack[N_THREADS];
  int tid[N_THREADS];
  int i;

  for (i = 0; i < N_THREADS; i++)
 100:	83 c6 01             	add    $0x1,%esi
 103:	83 fe 30             	cmp    $0x30,%esi
 106:	75 a8                	jne    b0 <main+0x20>
 108:	bb 01 00 00 00       	mov    $0x1,%ebx
 10d:	8d 76 00             	lea    0x0(%esi),%esi
    NEW_STACK_THREAD(entry, (char *)i, stack[i], tid[i]);

  for (i = 0; i < N_THREADS; i++) {
    if (twait(tid[i]) < 0)
 110:	8b 44 9f fc          	mov    -0x4(%edi,%ebx,4),%eax
 114:	89 04 24             	mov    %eax,(%esp)
 117:	e8 8c 03 00 00       	call   4a8 <twait>
 11c:	85 c0                	test   %eax,%eax
 11e:	0f 88 7c 00 00 00    	js     1a0 <main+0x110>
      handle_error("twait() error");
    free(stack[i]);
 124:	8b 95 6c fe ff ff    	mov    -0x194(%ebp),%edx
 12a:	8b 44 9a fc          	mov    -0x4(%edx,%ebx,4),%eax
 12e:	83 c3 01             	add    $0x1,%ebx
 131:	89 04 24             	mov    %eax,(%esp)
 134:	e8 a7 05 00 00       	call   6e0 <free>
  int i;

  for (i = 0; i < N_THREADS; i++)
    NEW_STACK_THREAD(entry, (char *)i, stack[i], tid[i]);

  for (i = 0; i < N_THREADS; i++) {
 139:	83 fb 31             	cmp    $0x31,%ebx
 13c:	75 d2                	jne    110 <main+0x80>
 13e:	b8 ef cd 87 09       	mov    $0x987cdef,%eax
      handle_error("twait() error");
    free(stack[i]);
  }

  for (i = 0; i < N_THREADS; i++) {
    if (check[i] != MAGIC_VALUE + i)
 143:	39 04 85 44 d1 e0 d9 	cmp    %eax,-0x261f2ebc(,%eax,4)
 14a:	75 5e                	jne    1aa <main+0x11a>
 14c:	83 c0 01             	add    $0x1,%eax
    if (twait(tid[i]) < 0)
      handle_error("twait() error");
    free(stack[i]);
  }

  for (i = 0; i < N_THREADS; i++) {
 14f:	3d 1f ce 87 09       	cmp    $0x987ce1f,%eax
 154:	75 ed                	jne    143 <main+0xb3>
    if (check[i] != MAGIC_VALUE + i)
      handle_error("check value error");
  }

  // Either returns >= 0 or really exits will count to be wrong
  if (texit() >= 0)
 156:	e8 45 03 00 00       	call   4a0 <texit>
 15b:	85 c0                	test   %eax,%eax
 15d:	79 6f                	jns    1ce <main+0x13e>
 15f:	90                   	nop    
    handle_error("texit() error");

  if (pschk() != 3)
 160:	e8 23 03 00 00       	call   488 <pschk>
 165:	83 f8 03             	cmp    $0x3,%eax
 168:	74 4a                	je     1b4 <main+0x124>
  }
  return 10 * (b - a) <= b;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 16a:	c7 44 24 08 84 08 00 	movl   $0x884,0x8(%esp)
 171:	00 
  exit();
 172:	a1 d0 08 00 00       	mov    0x8d0,%eax
 177:	c7 44 24 04 35 08 00 	movl   $0x835,0x4(%esp)
 17e:	00 
 17f:	89 04 24             	mov    %eax,(%esp)
 182:	e8 d9 03 00 00       	call   560 <printf>
 187:	e8 5c 02 00 00       	call   3e8 <exit>
  }
  return 10 * (b - a) <= b;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 18c:	c7 44 24 08 39 08 00 	movl   $0x839,0x8(%esp)
 193:	00 
 194:	eb dc                	jmp    172 <main+0xe2>
 196:	c7 44 24 08 48 08 00 	movl   $0x848,0x8(%esp)
 19d:	00 
 19e:	eb d2                	jmp    172 <main+0xe2>
    handle_error("proc status error");

  printf(stdout, "hw3-test-multiple succeeded!\n");
 1a0:	c7 44 24 08 56 08 00 	movl   $0x856,0x8(%esp)
 1a7:	00 
 1a8:	eb c8                	jmp    172 <main+0xe2>
 1aa:	c7 44 24 08 64 08 00 	movl   $0x864,0x8(%esp)
 1b1:	00 
 1b2:	eb be                	jmp    172 <main+0xe2>
 1b4:	a1 cc 08 00 00       	mov    0x8cc,%eax
 1b9:	c7 44 24 04 96 08 00 	movl   $0x896,0x4(%esp)
 1c0:	00 
 1c1:	89 04 24             	mov    %eax,(%esp)
 1c4:	e8 97 03 00 00       	call   560 <printf>

  exit();
 1c9:	e8 1a 02 00 00       	call   3e8 <exit>
 1ce:	c7 44 24 08 76 08 00 	movl   $0x876,0x8(%esp)
 1d5:	00 
 1d6:	eb 9a                	jmp    172 <main+0xe2>
 1d8:	90                   	nop    
 1d9:	90                   	nop    
 1da:	90                   	nop    
 1db:	90                   	nop    
 1dc:	90                   	nop    
 1dd:	90                   	nop    
 1de:	90                   	nop    
 1df:	90                   	nop    

000001e0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	53                   	push   %ebx
 1e4:	8b 5d 08             	mov    0x8(%ebp),%ebx
 1e7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1ea:	89 da                	mov    %ebx,%edx
 1ec:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1f0:	0f b6 01             	movzbl (%ecx),%eax
 1f3:	83 c1 01             	add    $0x1,%ecx
 1f6:	88 02                	mov    %al,(%edx)
 1f8:	83 c2 01             	add    $0x1,%edx
 1fb:	84 c0                	test   %al,%al
 1fd:	75 f1                	jne    1f0 <strcpy+0x10>
    ;
  return os;
}
 1ff:	89 d8                	mov    %ebx,%eax
 201:	5b                   	pop    %ebx
 202:	5d                   	pop    %ebp
 203:	c3                   	ret    
 204:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 20a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000210 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	8b 4d 08             	mov    0x8(%ebp),%ecx
 216:	53                   	push   %ebx
 217:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 21a:	0f b6 01             	movzbl (%ecx),%eax
 21d:	84 c0                	test   %al,%al
 21f:	74 24                	je     245 <strcmp+0x35>
 221:	0f b6 13             	movzbl (%ebx),%edx
 224:	38 d0                	cmp    %dl,%al
 226:	74 12                	je     23a <strcmp+0x2a>
 228:	eb 1e                	jmp    248 <strcmp+0x38>
 22a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 230:	0f b6 13             	movzbl (%ebx),%edx
 233:	83 c1 01             	add    $0x1,%ecx
 236:	38 d0                	cmp    %dl,%al
 238:	75 0e                	jne    248 <strcmp+0x38>
 23a:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 23e:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 241:	84 c0                	test   %al,%al
 243:	75 eb                	jne    230 <strcmp+0x20>
 245:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 248:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 249:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 24c:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 24d:	0f b6 d2             	movzbl %dl,%edx
 250:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 252:	c3                   	ret    
 253:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000260 <strlen>:

uint
strlen(char *s)
{
 260:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 261:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 263:	89 e5                	mov    %esp,%ebp
 265:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 268:	80 39 00             	cmpb   $0x0,(%ecx)
 26b:	74 0e                	je     27b <strlen+0x1b>
 26d:	31 d2                	xor    %edx,%edx
 26f:	90                   	nop    
 270:	83 c2 01             	add    $0x1,%edx
 273:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
 277:	89 d0                	mov    %edx,%eax
 279:	75 f5                	jne    270 <strlen+0x10>
    ;
  return n;
}
 27b:	5d                   	pop    %ebp
 27c:	c3                   	ret    
 27d:	8d 76 00             	lea    0x0(%esi),%esi

00000280 <memset>:

void*
memset(void *dst, int c, uint n)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	8b 55 08             	mov    0x8(%ebp),%edx
 286:	57                   	push   %edi
 287:	8b 45 0c             	mov    0xc(%ebp),%eax
 28a:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 28d:	89 d7                	mov    %edx,%edi
 28f:	fc                   	cld    
 290:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 292:	5f                   	pop    %edi
 293:	89 d0                	mov    %edx,%eax
 295:	5d                   	pop    %ebp
 296:	c3                   	ret    
 297:	89 f6                	mov    %esi,%esi
 299:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000002a0 <strchr>:

char*
strchr(const char *s, char c)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	8b 45 08             	mov    0x8(%ebp),%eax
 2a6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 2aa:	0f b6 10             	movzbl (%eax),%edx
 2ad:	84 d2                	test   %dl,%dl
 2af:	75 0c                	jne    2bd <strchr+0x1d>
 2b1:	eb 11                	jmp    2c4 <strchr+0x24>
 2b3:	83 c0 01             	add    $0x1,%eax
 2b6:	0f b6 10             	movzbl (%eax),%edx
 2b9:	84 d2                	test   %dl,%dl
 2bb:	74 07                	je     2c4 <strchr+0x24>
    if(*s == c)
 2bd:	38 ca                	cmp    %cl,%dl
 2bf:	90                   	nop    
 2c0:	75 f1                	jne    2b3 <strchr+0x13>
      return (char*) s;
  return 0;
}
 2c2:	5d                   	pop    %ebp
 2c3:	c3                   	ret    
 2c4:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2c5:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 2c7:	c3                   	ret    
 2c8:	90                   	nop    
 2c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000002d0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2d6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2d7:	31 db                	xor    %ebx,%ebx
 2d9:	0f b6 11             	movzbl (%ecx),%edx
 2dc:	8d 42 d0             	lea    -0x30(%edx),%eax
 2df:	3c 09                	cmp    $0x9,%al
 2e1:	77 18                	ja     2fb <atoi+0x2b>
    n = n*10 + *s++ - '0';
 2e3:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 2e6:	0f be d2             	movsbl %dl,%edx
 2e9:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2ed:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 2f1:	83 c1 01             	add    $0x1,%ecx
 2f4:	8d 42 d0             	lea    -0x30(%edx),%eax
 2f7:	3c 09                	cmp    $0x9,%al
 2f9:	76 e8                	jbe    2e3 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 2fb:	89 d8                	mov    %ebx,%eax
 2fd:	5b                   	pop    %ebx
 2fe:	5d                   	pop    %ebp
 2ff:	c3                   	ret    

00000300 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	8b 4d 10             	mov    0x10(%ebp),%ecx
 306:	56                   	push   %esi
 307:	8b 75 08             	mov    0x8(%ebp),%esi
 30a:	53                   	push   %ebx
 30b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 30e:	85 c9                	test   %ecx,%ecx
 310:	7e 10                	jle    322 <memmove+0x22>
 312:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 314:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 318:	88 04 32             	mov    %al,(%edx,%esi,1)
 31b:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 31e:	39 ca                	cmp    %ecx,%edx
 320:	75 f2                	jne    314 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 322:	89 f0                	mov    %esi,%eax
 324:	5b                   	pop    %ebx
 325:	5e                   	pop    %esi
 326:	5d                   	pop    %ebp
 327:	c3                   	ret    
 328:	90                   	nop    
 329:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000330 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 336:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 339:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 33c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 33f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 344:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 34b:	00 
 34c:	89 04 24             	mov    %eax,(%esp)
 34f:	e8 d4 00 00 00       	call   428 <open>
  if(fd < 0)
 354:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 356:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 358:	78 19                	js     373 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 35a:	8b 45 0c             	mov    0xc(%ebp),%eax
 35d:	89 1c 24             	mov    %ebx,(%esp)
 360:	89 44 24 04          	mov    %eax,0x4(%esp)
 364:	e8 d7 00 00 00       	call   440 <fstat>
  close(fd);
 369:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 36c:	89 c6                	mov    %eax,%esi
  close(fd);
 36e:	e8 9d 00 00 00       	call   410 <close>
  return r;
}
 373:	89 f0                	mov    %esi,%eax
 375:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 378:	8b 75 fc             	mov    -0x4(%ebp),%esi
 37b:	89 ec                	mov    %ebp,%esp
 37d:	5d                   	pop    %ebp
 37e:	c3                   	ret    
 37f:	90                   	nop    

00000380 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	56                   	push   %esi
 385:	31 f6                	xor    %esi,%esi
 387:	53                   	push   %ebx
 388:	83 ec 1c             	sub    $0x1c,%esp
 38b:	8b 7d 08             	mov    0x8(%ebp),%edi
 38e:	eb 06                	jmp    396 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 390:	3c 0d                	cmp    $0xd,%al
 392:	74 39                	je     3cd <gets+0x4d>
 394:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 396:	8d 5e 01             	lea    0x1(%esi),%ebx
 399:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 39c:	7d 31                	jge    3cf <gets+0x4f>
    cc = read(0, &c, 1);
 39e:	8d 45 f3             	lea    -0xd(%ebp),%eax
 3a1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3a8:	00 
 3a9:	89 44 24 04          	mov    %eax,0x4(%esp)
 3ad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 3b4:	e8 47 00 00 00       	call   400 <read>
    if(cc < 1)
 3b9:	85 c0                	test   %eax,%eax
 3bb:	7e 12                	jle    3cf <gets+0x4f>
      break;
    buf[i++] = c;
 3bd:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 3c1:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 3c5:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 3c9:	3c 0a                	cmp    $0xa,%al
 3cb:	75 c3                	jne    390 <gets+0x10>
 3cd:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 3cf:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 3d3:	89 f8                	mov    %edi,%eax
 3d5:	83 c4 1c             	add    $0x1c,%esp
 3d8:	5b                   	pop    %ebx
 3d9:	5e                   	pop    %esi
 3da:	5f                   	pop    %edi
 3db:	5d                   	pop    %ebp
 3dc:	c3                   	ret    
 3dd:	90                   	nop    
 3de:	90                   	nop    
 3df:	90                   	nop    

000003e0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3e0:	b8 01 00 00 00       	mov    $0x1,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <exit>:
SYSCALL(exit)
 3e8:	b8 02 00 00 00       	mov    $0x2,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <wait>:
SYSCALL(wait)
 3f0:	b8 03 00 00 00       	mov    $0x3,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <pipe>:
SYSCALL(pipe)
 3f8:	b8 04 00 00 00       	mov    $0x4,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <read>:
SYSCALL(read)
 400:	b8 06 00 00 00       	mov    $0x6,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <write>:
SYSCALL(write)
 408:	b8 05 00 00 00       	mov    $0x5,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <close>:
SYSCALL(close)
 410:	b8 07 00 00 00       	mov    $0x7,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <kill>:
SYSCALL(kill)
 418:	b8 08 00 00 00       	mov    $0x8,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <exec>:
SYSCALL(exec)
 420:	b8 09 00 00 00       	mov    $0x9,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <open>:
SYSCALL(open)
 428:	b8 0a 00 00 00       	mov    $0xa,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <mknod>:
SYSCALL(mknod)
 430:	b8 0b 00 00 00       	mov    $0xb,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    

00000438 <unlink>:
SYSCALL(unlink)
 438:	b8 0c 00 00 00       	mov    $0xc,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <fstat>:
SYSCALL(fstat)
 440:	b8 0d 00 00 00       	mov    $0xd,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <link>:
SYSCALL(link)
 448:	b8 0e 00 00 00       	mov    $0xe,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <mkdir>:
SYSCALL(mkdir)
 450:	b8 0f 00 00 00       	mov    $0xf,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    

00000458 <chdir>:
SYSCALL(chdir)
 458:	b8 10 00 00 00       	mov    $0x10,%eax
 45d:	cd 40                	int    $0x40
 45f:	c3                   	ret    

00000460 <dup>:
SYSCALL(dup)
 460:	b8 11 00 00 00       	mov    $0x11,%eax
 465:	cd 40                	int    $0x40
 467:	c3                   	ret    

00000468 <getpid>:
SYSCALL(getpid)
 468:	b8 12 00 00 00       	mov    $0x12,%eax
 46d:	cd 40                	int    $0x40
 46f:	c3                   	ret    

00000470 <sbrk>:
SYSCALL(sbrk)
 470:	b8 13 00 00 00       	mov    $0x13,%eax
 475:	cd 40                	int    $0x40
 477:	c3                   	ret    

00000478 <sleep>:
SYSCALL(sleep)
 478:	b8 14 00 00 00       	mov    $0x14,%eax
 47d:	cd 40                	int    $0x40
 47f:	c3                   	ret    

00000480 <uptime>:
SYSCALL(uptime)
 480:	b8 15 00 00 00       	mov    $0x15,%eax
 485:	cd 40                	int    $0x40
 487:	c3                   	ret    

00000488 <pschk>:
SYSCALL(pschk)
 488:	b8 17 00 00 00       	mov    $0x17,%eax
 48d:	cd 40                	int    $0x40
 48f:	c3                   	ret    

00000490 <rwlock>:
SYSCALL(rwlock)
 490:	b8 16 00 00 00       	mov    $0x16,%eax
 495:	cd 40                	int    $0x40
 497:	c3                   	ret    

00000498 <tfork>:
SYSCALL(tfork)
 498:	b8 18 00 00 00       	mov    $0x18,%eax
 49d:	cd 40                	int    $0x40
 49f:	c3                   	ret    

000004a0 <texit>:
SYSCALL(texit)
 4a0:	b8 19 00 00 00       	mov    $0x19,%eax
 4a5:	cd 40                	int    $0x40
 4a7:	c3                   	ret    

000004a8 <twait>:
SYSCALL(twait)
 4a8:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4ad:	cd 40                	int    $0x40
 4af:	c3                   	ret    

000004b0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	83 ec 18             	sub    $0x18,%esp
 4b6:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 4b9:	8d 55 fc             	lea    -0x4(%ebp),%edx
 4bc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4c3:	00 
 4c4:	89 54 24 04          	mov    %edx,0x4(%esp)
 4c8:	89 04 24             	mov    %eax,(%esp)
 4cb:	e8 38 ff ff ff       	call   408 <write>
}
 4d0:	c9                   	leave  
 4d1:	c3                   	ret    
 4d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 4d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000004e0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	56                   	push   %esi
 4e5:	89 ce                	mov    %ecx,%esi
 4e7:	53                   	push   %ebx
 4e8:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4eb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4ee:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4f1:	85 c9                	test   %ecx,%ecx
 4f3:	74 04                	je     4f9 <printint+0x19>
 4f5:	85 d2                	test   %edx,%edx
 4f7:	78 54                	js     54d <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4f9:	89 d0                	mov    %edx,%eax
 4fb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 502:	31 db                	xor    %ebx,%ebx
 504:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 507:	31 d2                	xor    %edx,%edx
 509:	f7 f6                	div    %esi
 50b:	89 c1                	mov    %eax,%ecx
 50d:	0f b6 82 bb 08 00 00 	movzbl 0x8bb(%edx),%eax
 514:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 517:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 51a:	85 c9                	test   %ecx,%ecx
 51c:	89 c8                	mov    %ecx,%eax
 51e:	75 e7                	jne    507 <printint+0x27>
  if(neg)
 520:	8b 45 e0             	mov    -0x20(%ebp),%eax
 523:	85 c0                	test   %eax,%eax
 525:	74 08                	je     52f <printint+0x4f>
    buf[i++] = '-';
 527:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 52c:	83 c3 01             	add    $0x1,%ebx
 52f:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 532:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 536:	83 eb 01             	sub    $0x1,%ebx
 539:	8b 45 dc             	mov    -0x24(%ebp),%eax
 53c:	e8 6f ff ff ff       	call   4b0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 541:	39 fb                	cmp    %edi,%ebx
 543:	75 ed                	jne    532 <printint+0x52>
    putc(fd, buf[i]);
}
 545:	83 c4 1c             	add    $0x1c,%esp
 548:	5b                   	pop    %ebx
 549:	5e                   	pop    %esi
 54a:	5f                   	pop    %edi
 54b:	5d                   	pop    %ebp
 54c:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 54d:	89 d0                	mov    %edx,%eax
 54f:	f7 d8                	neg    %eax
 551:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 558:	eb a8                	jmp    502 <printint+0x22>
 55a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000560 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	57                   	push   %edi
 564:	56                   	push   %esi
 565:	53                   	push   %ebx
 566:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 569:	8b 55 0c             	mov    0xc(%ebp),%edx
 56c:	0f b6 02             	movzbl (%edx),%eax
 56f:	84 c0                	test   %al,%al
 571:	0f 84 87 00 00 00    	je     5fe <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 577:	8d 4d 10             	lea    0x10(%ebp),%ecx
 57a:	31 ff                	xor    %edi,%edi
 57c:	31 f6                	xor    %esi,%esi
 57e:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 581:	eb 18                	jmp    59b <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 583:	83 fb 25             	cmp    $0x25,%ebx
 586:	0f 85 7a 00 00 00    	jne    606 <printf+0xa6>
 58c:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 590:	83 c7 01             	add    $0x1,%edi
 593:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 597:	84 c0                	test   %al,%al
 599:	74 63                	je     5fe <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 59b:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 59d:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 5a0:	74 e1                	je     583 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5a2:	83 fe 25             	cmp    $0x25,%esi
 5a5:	75 e9                	jne    590 <printf+0x30>
      if(c == 'd'){
 5a7:	83 fb 64             	cmp    $0x64,%ebx
 5aa:	0f 84 f0 00 00 00    	je     6a0 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5b0:	83 fb 78             	cmp    $0x78,%ebx
 5b3:	74 64                	je     619 <printf+0xb9>
 5b5:	83 fb 70             	cmp    $0x70,%ebx
 5b8:	74 5f                	je     619 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5ba:	83 fb 73             	cmp    $0x73,%ebx
 5bd:	8d 76 00             	lea    0x0(%esi),%esi
 5c0:	74 7e                	je     640 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5c2:	83 fb 63             	cmp    $0x63,%ebx
 5c5:	0f 84 b9 00 00 00    	je     684 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5cb:	83 fb 25             	cmp    $0x25,%ebx
 5ce:	66 90                	xchg   %ax,%ax
 5d0:	0f 84 f2 00 00 00    	je     6c8 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5d6:	8b 45 08             	mov    0x8(%ebp),%eax
 5d9:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5de:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 5e1:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5e3:	e8 c8 fe ff ff       	call   4b0 <putc>
        putc(fd, c);
 5e8:	8b 45 08             	mov    0x8(%ebp),%eax
 5eb:	0f be d3             	movsbl %bl,%edx
 5ee:	e8 bd fe ff ff       	call   4b0 <putc>
 5f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5f6:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 5fa:	84 c0                	test   %al,%al
 5fc:	75 9d                	jne    59b <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5fe:	83 c4 0c             	add    $0xc,%esp
 601:	5b                   	pop    %ebx
 602:	5e                   	pop    %esi
 603:	5f                   	pop    %edi
 604:	5d                   	pop    %ebp
 605:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 606:	8b 45 08             	mov    0x8(%ebp),%eax
 609:	0f be d3             	movsbl %bl,%edx
 60c:	e8 9f fe ff ff       	call   4b0 <putc>
 611:	8b 55 0c             	mov    0xc(%ebp),%edx
 614:	e9 77 ff ff ff       	jmp    590 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 619:	8b 45 f0             	mov    -0x10(%ebp),%eax
 61c:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 621:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 623:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 62a:	8b 10                	mov    (%eax),%edx
 62c:	8b 45 08             	mov    0x8(%ebp),%eax
 62f:	e8 ac fe ff ff       	call   4e0 <printint>
 634:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 637:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 63b:	e9 50 ff ff ff       	jmp    590 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 640:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 643:	8b 01                	mov    (%ecx),%eax
        ap++;
 645:	83 c1 04             	add    $0x4,%ecx
 648:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 64b:	b9 b4 08 00 00       	mov    $0x8b4,%ecx
 650:	85 c0                	test   %eax,%eax
 652:	75 2c                	jne    680 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 654:	0f b6 01             	movzbl (%ecx),%eax
 657:	84 c0                	test   %al,%al
 659:	74 1e                	je     679 <printf+0x119>
 65b:	89 cb                	mov    %ecx,%ebx
 65d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 660:	0f be d0             	movsbl %al,%edx
 663:	8b 45 08             	mov    0x8(%ebp),%eax
 666:	e8 45 fe ff ff       	call   4b0 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 66b:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 66f:	83 c3 01             	add    $0x1,%ebx
 672:	84 c0                	test   %al,%al
 674:	75 ea                	jne    660 <printf+0x100>
 676:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 679:	31 f6                	xor    %esi,%esi
 67b:	e9 10 ff ff ff       	jmp    590 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 680:	89 c1                	mov    %eax,%ecx
 682:	eb d0                	jmp    654 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 684:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 687:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 689:	0f be 10             	movsbl (%eax),%edx
 68c:	8b 45 08             	mov    0x8(%ebp),%eax
 68f:	e8 1c fe ff ff       	call   4b0 <putc>
 694:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 697:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 69b:	e9 f0 fe ff ff       	jmp    590 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 6a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 6a8:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 6ab:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 6b2:	8b 10                	mov    (%eax),%edx
 6b4:	8b 45 08             	mov    0x8(%ebp),%eax
 6b7:	e8 24 fe ff ff       	call   4e0 <printint>
 6bc:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 6bf:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 6c3:	e9 c8 fe ff ff       	jmp    590 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 6c8:	8b 45 08             	mov    0x8(%ebp),%eax
 6cb:	ba 25 00 00 00       	mov    $0x25,%edx
 6d0:	31 f6                	xor    %esi,%esi
 6d2:	e8 d9 fd ff ff       	call   4b0 <putc>
 6d7:	8b 55 0c             	mov    0xc(%ebp),%edx
 6da:	e9 b1 fe ff ff       	jmp    590 <printf+0x30>
 6df:	90                   	nop    

000006e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e1:	8b 0d e8 08 00 00    	mov    0x8e8,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 6e7:	89 e5                	mov    %esp,%ebp
 6e9:	56                   	push   %esi
 6ea:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 6eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6ee:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f1:	39 d9                	cmp    %ebx,%ecx
 6f3:	73 18                	jae    70d <free+0x2d>
 6f5:	8b 11                	mov    (%ecx),%edx
 6f7:	39 d3                	cmp    %edx,%ebx
 6f9:	72 17                	jb     712 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6fb:	39 d1                	cmp    %edx,%ecx
 6fd:	72 08                	jb     707 <free+0x27>
 6ff:	39 d9                	cmp    %ebx,%ecx
 701:	72 0f                	jb     712 <free+0x32>
 703:	39 d3                	cmp    %edx,%ebx
 705:	72 0b                	jb     712 <free+0x32>
 707:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 709:	39 d9                	cmp    %ebx,%ecx
 70b:	72 e8                	jb     6f5 <free+0x15>
 70d:	8b 11                	mov    (%ecx),%edx
 70f:	90                   	nop    
 710:	eb e9                	jmp    6fb <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 712:	8b 73 04             	mov    0x4(%ebx),%esi
 715:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 718:	39 d0                	cmp    %edx,%eax
 71a:	74 18                	je     734 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 71c:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 71e:	8b 51 04             	mov    0x4(%ecx),%edx
 721:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 724:	39 d8                	cmp    %ebx,%eax
 726:	74 20                	je     748 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 728:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 72a:	5b                   	pop    %ebx
 72b:	5e                   	pop    %esi
 72c:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 72d:	89 0d e8 08 00 00    	mov    %ecx,0x8e8
}
 733:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 734:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 737:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 739:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 73c:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 73f:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 741:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 744:	39 d8                	cmp    %ebx,%eax
 746:	75 e0                	jne    728 <free+0x48>
    p->s.size += bp->s.size;
 748:	03 53 04             	add    0x4(%ebx),%edx
 74b:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 74e:	8b 13                	mov    (%ebx),%edx
 750:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 752:	5b                   	pop    %ebx
 753:	5e                   	pop    %esi
 754:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 755:	89 0d e8 08 00 00    	mov    %ecx,0x8e8
}
 75b:	c3                   	ret    
 75c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000760 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	57                   	push   %edi
 764:	56                   	push   %esi
 765:	53                   	push   %ebx
 766:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 769:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 76c:	8b 15 e8 08 00 00    	mov    0x8e8,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 772:	83 c0 07             	add    $0x7,%eax
 775:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 778:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 77a:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 77d:	0f 84 8a 00 00 00    	je     80d <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 783:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 785:	8b 41 04             	mov    0x4(%ecx),%eax
 788:	39 c3                	cmp    %eax,%ebx
 78a:	76 1a                	jbe    7a6 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 78c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 793:	3b 0d e8 08 00 00    	cmp    0x8e8,%ecx
 799:	89 ca                	mov    %ecx,%edx
 79b:	74 29                	je     7c6 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 79d:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 79f:	8b 41 04             	mov    0x4(%ecx),%eax
 7a2:	39 c3                	cmp    %eax,%ebx
 7a4:	77 ed                	ja     793 <malloc+0x33>
      if(p->s.size == nunits)
 7a6:	39 c3                	cmp    %eax,%ebx
 7a8:	74 5d                	je     807 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 7aa:	29 d8                	sub    %ebx,%eax
 7ac:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 7af:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 7b2:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 7b5:	89 15 e8 08 00 00    	mov    %edx,0x8e8
      return (void*) (p + 1);
 7bb:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7be:	83 c4 0c             	add    $0xc,%esp
 7c1:	5b                   	pop    %ebx
 7c2:	5e                   	pop    %esi
 7c3:	5f                   	pop    %edi
 7c4:	5d                   	pop    %ebp
 7c5:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 7c6:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 7cc:	89 de                	mov    %ebx,%esi
 7ce:	89 f8                	mov    %edi,%eax
 7d0:	76 29                	jbe    7fb <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 7d2:	89 04 24             	mov    %eax,(%esp)
 7d5:	e8 96 fc ff ff       	call   470 <sbrk>
  if(p == (char*) -1)
 7da:	83 f8 ff             	cmp    $0xffffffff,%eax
 7dd:	74 18                	je     7f7 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 7df:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 7e2:	83 c0 08             	add    $0x8,%eax
 7e5:	89 04 24             	mov    %eax,(%esp)
 7e8:	e8 f3 fe ff ff       	call   6e0 <free>
  return freep;
 7ed:	8b 15 e8 08 00 00    	mov    0x8e8,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 7f3:	85 d2                	test   %edx,%edx
 7f5:	75 a6                	jne    79d <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7f7:	31 c0                	xor    %eax,%eax
 7f9:	eb c3                	jmp    7be <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 7fb:	be 00 10 00 00       	mov    $0x1000,%esi
 800:	b8 00 80 00 00       	mov    $0x8000,%eax
 805:	eb cb                	jmp    7d2 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 807:	8b 01                	mov    (%ecx),%eax
 809:	89 02                	mov    %eax,(%edx)
 80b:	eb a8                	jmp    7b5 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 80d:	ba e0 08 00 00       	mov    $0x8e0,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 812:	c7 05 e8 08 00 00 e0 	movl   $0x8e0,0x8e8
 819:	08 00 00 
 81c:	c7 05 e0 08 00 00 e0 	movl   $0x8e0,0x8e0
 823:	08 00 00 
    base.s.size = 0;
 826:	c7 05 e4 08 00 00 00 	movl   $0x0,0x8e4
 82d:	00 00 00 
 830:	e9 4e ff ff ff       	jmp    783 <malloc+0x23>
