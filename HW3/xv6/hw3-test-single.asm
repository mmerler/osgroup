
_hw3-test-single:     file format elf32-i386

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
#include "hw3-common.h"

int check;

void entry(void *arg)
{
  40:	55                   	push   %ebp
  41:	89 e5                	mov    %esp,%ebp
  check = MAGIC_VALUE;

  texit();
}
  43:	5d                   	pop    %ebp

int check;

void entry(void *arg)
{
  check = MAGIC_VALUE;
  44:	c7 05 30 09 00 00 ef 	movl   $0x987cdef,0x930
  4b:	cd 87 09 

  texit();
  4e:	e9 9d 04 00 00       	jmp    4f0 <texit>
  53:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  59:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000060 <handle_error>:

inline void handle_error(const char *msg) {
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	83 ec 18             	sub    $0x18,%esp
  printf(stderr, "%s\n", msg);
  66:	8b 45 08             	mov    0x8(%ebp),%eax
  69:	c7 44 24 04 85 08 00 	movl   $0x885,0x4(%esp)
  70:	00 
  71:	89 44 24 08          	mov    %eax,0x8(%esp)
  75:	a1 20 09 00 00       	mov    0x920,%eax
  7a:	89 04 24             	mov    %eax,(%esp)
  7d:	e8 2e 05 00 00       	call   5b0 <printf>
  exit();
  82:	e8 b1 03 00 00       	call   438 <exit>
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
  9d:	56                   	push   %esi
  9e:	53                   	push   %ebx
  9f:	51                   	push   %ecx
  a0:	83 ec 0c             	sub    $0xc,%esp
  char *stack;
  int tid;

  NEW_STACK_THREAD(entry, 0, stack, tid);
  a3:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  aa:	e8 01 07 00 00       	call   7b0 <malloc>
  af:	85 c0                	test   %eax,%eax
  b1:	89 c3                	mov    %eax,%ebx
  b3:	0f 84 27 01 00 00    	je     1e0 <main+0x150>
  b9:	8d 80 00 10 00 00    	lea    0x1000(%eax),%eax
  bf:	89 44 24 08          	mov    %eax,0x8(%esp)
  c3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  ca:	00 
  cb:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
  d2:	e8 11 04 00 00       	call   4e8 <tfork>
  d7:	85 c0                	test   %eax,%eax
  d9:	0f 88 ed 00 00 00    	js     1cc <main+0x13c>
  WAIT_THREAD(tid, 0);
  df:	89 04 24             	mov    %eax,(%esp)
  e2:	e8 11 04 00 00       	call   4f8 <twait>
  e7:	85 c0                	test   %eax,%eax
  e9:	0f 88 e7 00 00 00    	js     1d6 <main+0x146>
  free(stack);
  ef:	89 1c 24             	mov    %ebx,(%esp)
  f2:	e8 39 06 00 00       	call   730 <free>

  NEW_STACK_THREAD(entry, 0, stack, tid);
  f7:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  fe:	e8 ad 06 00 00       	call   7b0 <malloc>
 103:	85 c0                	test   %eax,%eax
 105:	89 c3                	mov    %eax,%ebx
 107:	0f 84 d3 00 00 00    	je     1e0 <main+0x150>
 10d:	8d 80 00 10 00 00    	lea    0x1000(%eax),%eax
 113:	89 44 24 08          	mov    %eax,0x8(%esp)
 117:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 11e:	00 
 11f:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
 126:	e8 bd 03 00 00       	call   4e8 <tfork>
 12b:	85 c0                	test   %eax,%eax
 12d:	89 c6                	mov    %eax,%esi
 12f:	0f 88 97 00 00 00    	js     1cc <main+0x13c>
  if (wait() >= 0)
 135:	e8 06 03 00 00       	call   440 <wait>
 13a:	85 c0                	test   %eax,%eax
 13c:	0f 89 a8 00 00 00    	jns    1ea <main+0x15a>
    handle_error("wait() error");
  WAIT_THREAD(tid, 0);
 142:	89 34 24             	mov    %esi,(%esp)
 145:	e8 ae 03 00 00       	call   4f8 <twait>
 14a:	85 c0                	test   %eax,%eax
 14c:	0f 88 84 00 00 00    	js     1d6 <main+0x146>
  free(stack);
 152:	89 1c 24             	mov    %ebx,(%esp)
 155:	e8 d6 05 00 00       	call   730 <free>

  if (twait(MAGIC_VALUE) >= 0)
 15a:	c7 04 24 ef cd 87 09 	movl   $0x987cdef,(%esp)
 161:	e8 92 03 00 00       	call   4f8 <twait>
 166:	85 c0                	test   %eax,%eax
 168:	79 6c                	jns    1d6 <main+0x146>
    handle_error("twait() error");

  if (tfork(entry, 0, 0) >= 0)
 16a:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
 171:	00 
 172:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 179:	00 
 17a:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
 181:	e8 62 03 00 00       	call   4e8 <tfork>
 186:	85 c0                	test   %eax,%eax
 188:	79 42                	jns    1cc <main+0x13c>
    handle_error("tfork() error");

  if (check != MAGIC_VALUE)
 18a:	81 3d 30 09 00 00 ef 	cmpl   $0x987cdef,0x930
 191:	cd 87 09 
 194:	75 5e                	jne    1f4 <main+0x164>
    handle_error("check value error");

  if (texit() >= 0)
 196:	e8 55 03 00 00       	call   4f0 <texit>
 19b:	85 c0                	test   %eax,%eax
 19d:	79 79                	jns    218 <main+0x188>
 19f:	90                   	nop    
    handle_error("texit() error");

  PROC_CHECK(3);
 1a0:	e8 33 03 00 00       	call   4d8 <pschk>
 1a5:	83 f8 03             	cmp    $0x3,%eax
 1a8:	74 54                	je     1fe <main+0x16e>
  }
  return 10 * (b - a) <= b;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 1aa:	c7 44 24 08 d4 08 00 	movl   $0x8d4,0x8(%esp)
 1b1:	00 
  exit();
 1b2:	a1 20 09 00 00       	mov    0x920,%eax
 1b7:	c7 44 24 04 85 08 00 	movl   $0x885,0x4(%esp)
 1be:	00 
 1bf:	89 04 24             	mov    %eax,(%esp)
 1c2:	e8 e9 03 00 00       	call   5b0 <printf>
 1c7:	e8 6c 02 00 00       	call   438 <exit>
  }
  return 10 * (b - a) <= b;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 1cc:	c7 44 24 08 98 08 00 	movl   $0x898,0x8(%esp)
 1d3:	00 
 1d4:	eb dc                	jmp    1b2 <main+0x122>

  printf(stdout, "hw3-test-single succeeded!\n");
 1d6:	c7 44 24 08 a6 08 00 	movl   $0x8a6,0x8(%esp)
 1dd:	00 
 1de:	eb d2                	jmp    1b2 <main+0x122>
 1e0:	c7 44 24 08 89 08 00 	movl   $0x889,0x8(%esp)
 1e7:	00 
 1e8:	eb c8                	jmp    1b2 <main+0x122>
 1ea:	c7 44 24 08 a7 08 00 	movl   $0x8a7,0x8(%esp)
 1f1:	00 
 1f2:	eb be                	jmp    1b2 <main+0x122>
 1f4:	c7 44 24 08 b4 08 00 	movl   $0x8b4,0x8(%esp)
 1fb:	00 
 1fc:	eb b4                	jmp    1b2 <main+0x122>
 1fe:	a1 1c 09 00 00       	mov    0x91c,%eax
 203:	c7 44 24 04 e6 08 00 	movl   $0x8e6,0x4(%esp)
 20a:	00 
 20b:	89 04 24             	mov    %eax,(%esp)
 20e:	e8 9d 03 00 00       	call   5b0 <printf>

  exit();
 213:	e8 20 02 00 00       	call   438 <exit>
 218:	c7 44 24 08 c6 08 00 	movl   $0x8c6,0x8(%esp)
 21f:	00 
 220:	eb 90                	jmp    1b2 <main+0x122>
 222:	90                   	nop    
 223:	90                   	nop    
 224:	90                   	nop    
 225:	90                   	nop    
 226:	90                   	nop    
 227:	90                   	nop    
 228:	90                   	nop    
 229:	90                   	nop    
 22a:	90                   	nop    
 22b:	90                   	nop    
 22c:	90                   	nop    
 22d:	90                   	nop    
 22e:	90                   	nop    
 22f:	90                   	nop    

00000230 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	53                   	push   %ebx
 234:	8b 5d 08             	mov    0x8(%ebp),%ebx
 237:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 23a:	89 da                	mov    %ebx,%edx
 23c:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 240:	0f b6 01             	movzbl (%ecx),%eax
 243:	83 c1 01             	add    $0x1,%ecx
 246:	88 02                	mov    %al,(%edx)
 248:	83 c2 01             	add    $0x1,%edx
 24b:	84 c0                	test   %al,%al
 24d:	75 f1                	jne    240 <strcpy+0x10>
    ;
  return os;
}
 24f:	89 d8                	mov    %ebx,%eax
 251:	5b                   	pop    %ebx
 252:	5d                   	pop    %ebp
 253:	c3                   	ret    
 254:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 25a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000260 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	8b 4d 08             	mov    0x8(%ebp),%ecx
 266:	53                   	push   %ebx
 267:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 26a:	0f b6 01             	movzbl (%ecx),%eax
 26d:	84 c0                	test   %al,%al
 26f:	74 24                	je     295 <strcmp+0x35>
 271:	0f b6 13             	movzbl (%ebx),%edx
 274:	38 d0                	cmp    %dl,%al
 276:	74 12                	je     28a <strcmp+0x2a>
 278:	eb 1e                	jmp    298 <strcmp+0x38>
 27a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 280:	0f b6 13             	movzbl (%ebx),%edx
 283:	83 c1 01             	add    $0x1,%ecx
 286:	38 d0                	cmp    %dl,%al
 288:	75 0e                	jne    298 <strcmp+0x38>
 28a:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 28e:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 291:	84 c0                	test   %al,%al
 293:	75 eb                	jne    280 <strcmp+0x20>
 295:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 298:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 299:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 29c:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 29d:	0f b6 d2             	movzbl %dl,%edx
 2a0:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 2a2:	c3                   	ret    
 2a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000002b0 <strlen>:

uint
strlen(char *s)
{
 2b0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 2b1:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 2b3:	89 e5                	mov    %esp,%ebp
 2b5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 2b8:	80 39 00             	cmpb   $0x0,(%ecx)
 2bb:	74 0e                	je     2cb <strlen+0x1b>
 2bd:	31 d2                	xor    %edx,%edx
 2bf:	90                   	nop    
 2c0:	83 c2 01             	add    $0x1,%edx
 2c3:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
 2c7:	89 d0                	mov    %edx,%eax
 2c9:	75 f5                	jne    2c0 <strlen+0x10>
    ;
  return n;
}
 2cb:	5d                   	pop    %ebp
 2cc:	c3                   	ret    
 2cd:	8d 76 00             	lea    0x0(%esi),%esi

000002d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	8b 55 08             	mov    0x8(%ebp),%edx
 2d6:	57                   	push   %edi
 2d7:	8b 45 0c             	mov    0xc(%ebp),%eax
 2da:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 2dd:	89 d7                	mov    %edx,%edi
 2df:	fc                   	cld    
 2e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 2e2:	5f                   	pop    %edi
 2e3:	89 d0                	mov    %edx,%eax
 2e5:	5d                   	pop    %ebp
 2e6:	c3                   	ret    
 2e7:	89 f6                	mov    %esi,%esi
 2e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000002f0 <strchr>:

char*
strchr(const char *s, char c)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	8b 45 08             	mov    0x8(%ebp),%eax
 2f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 2fa:	0f b6 10             	movzbl (%eax),%edx
 2fd:	84 d2                	test   %dl,%dl
 2ff:	75 0c                	jne    30d <strchr+0x1d>
 301:	eb 11                	jmp    314 <strchr+0x24>
 303:	83 c0 01             	add    $0x1,%eax
 306:	0f b6 10             	movzbl (%eax),%edx
 309:	84 d2                	test   %dl,%dl
 30b:	74 07                	je     314 <strchr+0x24>
    if(*s == c)
 30d:	38 ca                	cmp    %cl,%dl
 30f:	90                   	nop    
 310:	75 f1                	jne    303 <strchr+0x13>
      return (char*) s;
  return 0;
}
 312:	5d                   	pop    %ebp
 313:	c3                   	ret    
 314:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 315:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 317:	c3                   	ret    
 318:	90                   	nop    
 319:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000320 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	8b 4d 08             	mov    0x8(%ebp),%ecx
 326:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 327:	31 db                	xor    %ebx,%ebx
 329:	0f b6 11             	movzbl (%ecx),%edx
 32c:	8d 42 d0             	lea    -0x30(%edx),%eax
 32f:	3c 09                	cmp    $0x9,%al
 331:	77 18                	ja     34b <atoi+0x2b>
    n = n*10 + *s++ - '0';
 333:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 336:	0f be d2             	movsbl %dl,%edx
 339:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 33d:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 341:	83 c1 01             	add    $0x1,%ecx
 344:	8d 42 d0             	lea    -0x30(%edx),%eax
 347:	3c 09                	cmp    $0x9,%al
 349:	76 e8                	jbe    333 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 34b:	89 d8                	mov    %ebx,%eax
 34d:	5b                   	pop    %ebx
 34e:	5d                   	pop    %ebp
 34f:	c3                   	ret    

00000350 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	8b 4d 10             	mov    0x10(%ebp),%ecx
 356:	56                   	push   %esi
 357:	8b 75 08             	mov    0x8(%ebp),%esi
 35a:	53                   	push   %ebx
 35b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 35e:	85 c9                	test   %ecx,%ecx
 360:	7e 10                	jle    372 <memmove+0x22>
 362:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 364:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 368:	88 04 32             	mov    %al,(%edx,%esi,1)
 36b:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 36e:	39 ca                	cmp    %ecx,%edx
 370:	75 f2                	jne    364 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 372:	89 f0                	mov    %esi,%eax
 374:	5b                   	pop    %ebx
 375:	5e                   	pop    %esi
 376:	5d                   	pop    %ebp
 377:	c3                   	ret    
 378:	90                   	nop    
 379:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000380 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 386:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 389:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 38c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 38f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 394:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 39b:	00 
 39c:	89 04 24             	mov    %eax,(%esp)
 39f:	e8 d4 00 00 00       	call   478 <open>
  if(fd < 0)
 3a4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3a6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 3a8:	78 19                	js     3c3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 3aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ad:	89 1c 24             	mov    %ebx,(%esp)
 3b0:	89 44 24 04          	mov    %eax,0x4(%esp)
 3b4:	e8 d7 00 00 00       	call   490 <fstat>
  close(fd);
 3b9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 3bc:	89 c6                	mov    %eax,%esi
  close(fd);
 3be:	e8 9d 00 00 00       	call   460 <close>
  return r;
}
 3c3:	89 f0                	mov    %esi,%eax
 3c5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 3c8:	8b 75 fc             	mov    -0x4(%ebp),%esi
 3cb:	89 ec                	mov    %ebp,%esp
 3cd:	5d                   	pop    %ebp
 3ce:	c3                   	ret    
 3cf:	90                   	nop    

000003d0 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	57                   	push   %edi
 3d4:	56                   	push   %esi
 3d5:	31 f6                	xor    %esi,%esi
 3d7:	53                   	push   %ebx
 3d8:	83 ec 1c             	sub    $0x1c,%esp
 3db:	8b 7d 08             	mov    0x8(%ebp),%edi
 3de:	eb 06                	jmp    3e6 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3e0:	3c 0d                	cmp    $0xd,%al
 3e2:	74 39                	je     41d <gets+0x4d>
 3e4:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3e6:	8d 5e 01             	lea    0x1(%esi),%ebx
 3e9:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3ec:	7d 31                	jge    41f <gets+0x4f>
    cc = read(0, &c, 1);
 3ee:	8d 45 f3             	lea    -0xd(%ebp),%eax
 3f1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3f8:	00 
 3f9:	89 44 24 04          	mov    %eax,0x4(%esp)
 3fd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 404:	e8 47 00 00 00       	call   450 <read>
    if(cc < 1)
 409:	85 c0                	test   %eax,%eax
 40b:	7e 12                	jle    41f <gets+0x4f>
      break;
    buf[i++] = c;
 40d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 411:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 415:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 419:	3c 0a                	cmp    $0xa,%al
 41b:	75 c3                	jne    3e0 <gets+0x10>
 41d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 41f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 423:	89 f8                	mov    %edi,%eax
 425:	83 c4 1c             	add    $0x1c,%esp
 428:	5b                   	pop    %ebx
 429:	5e                   	pop    %esi
 42a:	5f                   	pop    %edi
 42b:	5d                   	pop    %ebp
 42c:	c3                   	ret    
 42d:	90                   	nop    
 42e:	90                   	nop    
 42f:	90                   	nop    

00000430 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 430:	b8 01 00 00 00       	mov    $0x1,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    

00000438 <exit>:
SYSCALL(exit)
 438:	b8 02 00 00 00       	mov    $0x2,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <wait>:
SYSCALL(wait)
 440:	b8 03 00 00 00       	mov    $0x3,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <pipe>:
SYSCALL(pipe)
 448:	b8 04 00 00 00       	mov    $0x4,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <read>:
SYSCALL(read)
 450:	b8 06 00 00 00       	mov    $0x6,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    

00000458 <write>:
SYSCALL(write)
 458:	b8 05 00 00 00       	mov    $0x5,%eax
 45d:	cd 40                	int    $0x40
 45f:	c3                   	ret    

00000460 <close>:
SYSCALL(close)
 460:	b8 07 00 00 00       	mov    $0x7,%eax
 465:	cd 40                	int    $0x40
 467:	c3                   	ret    

00000468 <kill>:
SYSCALL(kill)
 468:	b8 08 00 00 00       	mov    $0x8,%eax
 46d:	cd 40                	int    $0x40
 46f:	c3                   	ret    

00000470 <exec>:
SYSCALL(exec)
 470:	b8 09 00 00 00       	mov    $0x9,%eax
 475:	cd 40                	int    $0x40
 477:	c3                   	ret    

00000478 <open>:
SYSCALL(open)
 478:	b8 0a 00 00 00       	mov    $0xa,%eax
 47d:	cd 40                	int    $0x40
 47f:	c3                   	ret    

00000480 <mknod>:
SYSCALL(mknod)
 480:	b8 0b 00 00 00       	mov    $0xb,%eax
 485:	cd 40                	int    $0x40
 487:	c3                   	ret    

00000488 <unlink>:
SYSCALL(unlink)
 488:	b8 0c 00 00 00       	mov    $0xc,%eax
 48d:	cd 40                	int    $0x40
 48f:	c3                   	ret    

00000490 <fstat>:
SYSCALL(fstat)
 490:	b8 0d 00 00 00       	mov    $0xd,%eax
 495:	cd 40                	int    $0x40
 497:	c3                   	ret    

00000498 <link>:
SYSCALL(link)
 498:	b8 0e 00 00 00       	mov    $0xe,%eax
 49d:	cd 40                	int    $0x40
 49f:	c3                   	ret    

000004a0 <mkdir>:
SYSCALL(mkdir)
 4a0:	b8 0f 00 00 00       	mov    $0xf,%eax
 4a5:	cd 40                	int    $0x40
 4a7:	c3                   	ret    

000004a8 <chdir>:
SYSCALL(chdir)
 4a8:	b8 10 00 00 00       	mov    $0x10,%eax
 4ad:	cd 40                	int    $0x40
 4af:	c3                   	ret    

000004b0 <dup>:
SYSCALL(dup)
 4b0:	b8 11 00 00 00       	mov    $0x11,%eax
 4b5:	cd 40                	int    $0x40
 4b7:	c3                   	ret    

000004b8 <getpid>:
SYSCALL(getpid)
 4b8:	b8 12 00 00 00       	mov    $0x12,%eax
 4bd:	cd 40                	int    $0x40
 4bf:	c3                   	ret    

000004c0 <sbrk>:
SYSCALL(sbrk)
 4c0:	b8 13 00 00 00       	mov    $0x13,%eax
 4c5:	cd 40                	int    $0x40
 4c7:	c3                   	ret    

000004c8 <sleep>:
SYSCALL(sleep)
 4c8:	b8 14 00 00 00       	mov    $0x14,%eax
 4cd:	cd 40                	int    $0x40
 4cf:	c3                   	ret    

000004d0 <uptime>:
SYSCALL(uptime)
 4d0:	b8 15 00 00 00       	mov    $0x15,%eax
 4d5:	cd 40                	int    $0x40
 4d7:	c3                   	ret    

000004d8 <pschk>:
SYSCALL(pschk)
 4d8:	b8 17 00 00 00       	mov    $0x17,%eax
 4dd:	cd 40                	int    $0x40
 4df:	c3                   	ret    

000004e0 <rwlock>:
SYSCALL(rwlock)
 4e0:	b8 16 00 00 00       	mov    $0x16,%eax
 4e5:	cd 40                	int    $0x40
 4e7:	c3                   	ret    

000004e8 <tfork>:
SYSCALL(tfork)
 4e8:	b8 18 00 00 00       	mov    $0x18,%eax
 4ed:	cd 40                	int    $0x40
 4ef:	c3                   	ret    

000004f0 <texit>:
SYSCALL(texit)
 4f0:	b8 19 00 00 00       	mov    $0x19,%eax
 4f5:	cd 40                	int    $0x40
 4f7:	c3                   	ret    

000004f8 <twait>:
SYSCALL(twait)
 4f8:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4fd:	cd 40                	int    $0x40
 4ff:	c3                   	ret    

00000500 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	83 ec 18             	sub    $0x18,%esp
 506:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 509:	8d 55 fc             	lea    -0x4(%ebp),%edx
 50c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 513:	00 
 514:	89 54 24 04          	mov    %edx,0x4(%esp)
 518:	89 04 24             	mov    %eax,(%esp)
 51b:	e8 38 ff ff ff       	call   458 <write>
}
 520:	c9                   	leave  
 521:	c3                   	ret    
 522:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 529:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000530 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	57                   	push   %edi
 534:	56                   	push   %esi
 535:	89 ce                	mov    %ecx,%esi
 537:	53                   	push   %ebx
 538:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 53b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 53e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 541:	85 c9                	test   %ecx,%ecx
 543:	74 04                	je     549 <printint+0x19>
 545:	85 d2                	test   %edx,%edx
 547:	78 54                	js     59d <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 549:	89 d0                	mov    %edx,%eax
 54b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 552:	31 db                	xor    %ebx,%ebx
 554:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 557:	31 d2                	xor    %edx,%edx
 559:	f7 f6                	div    %esi
 55b:	89 c1                	mov    %eax,%ecx
 55d:	0f b6 82 09 09 00 00 	movzbl 0x909(%edx),%eax
 564:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 567:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 56a:	85 c9                	test   %ecx,%ecx
 56c:	89 c8                	mov    %ecx,%eax
 56e:	75 e7                	jne    557 <printint+0x27>
  if(neg)
 570:	8b 45 e0             	mov    -0x20(%ebp),%eax
 573:	85 c0                	test   %eax,%eax
 575:	74 08                	je     57f <printint+0x4f>
    buf[i++] = '-';
 577:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 57c:	83 c3 01             	add    $0x1,%ebx
 57f:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 582:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 586:	83 eb 01             	sub    $0x1,%ebx
 589:	8b 45 dc             	mov    -0x24(%ebp),%eax
 58c:	e8 6f ff ff ff       	call   500 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 591:	39 fb                	cmp    %edi,%ebx
 593:	75 ed                	jne    582 <printint+0x52>
    putc(fd, buf[i]);
}
 595:	83 c4 1c             	add    $0x1c,%esp
 598:	5b                   	pop    %ebx
 599:	5e                   	pop    %esi
 59a:	5f                   	pop    %edi
 59b:	5d                   	pop    %ebp
 59c:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 59d:	89 d0                	mov    %edx,%eax
 59f:	f7 d8                	neg    %eax
 5a1:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 5a8:	eb a8                	jmp    552 <printint+0x22>
 5aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000005b0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	57                   	push   %edi
 5b4:	56                   	push   %esi
 5b5:	53                   	push   %ebx
 5b6:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5b9:	8b 55 0c             	mov    0xc(%ebp),%edx
 5bc:	0f b6 02             	movzbl (%edx),%eax
 5bf:	84 c0                	test   %al,%al
 5c1:	0f 84 87 00 00 00    	je     64e <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 5c7:	8d 4d 10             	lea    0x10(%ebp),%ecx
 5ca:	31 ff                	xor    %edi,%edi
 5cc:	31 f6                	xor    %esi,%esi
 5ce:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 5d1:	eb 18                	jmp    5eb <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5d3:	83 fb 25             	cmp    $0x25,%ebx
 5d6:	0f 85 7a 00 00 00    	jne    656 <printf+0xa6>
 5dc:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5e0:	83 c7 01             	add    $0x1,%edi
 5e3:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 5e7:	84 c0                	test   %al,%al
 5e9:	74 63                	je     64e <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 5eb:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 5ed:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 5f0:	74 e1                	je     5d3 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5f2:	83 fe 25             	cmp    $0x25,%esi
 5f5:	75 e9                	jne    5e0 <printf+0x30>
      if(c == 'd'){
 5f7:	83 fb 64             	cmp    $0x64,%ebx
 5fa:	0f 84 f0 00 00 00    	je     6f0 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 600:	83 fb 78             	cmp    $0x78,%ebx
 603:	74 64                	je     669 <printf+0xb9>
 605:	83 fb 70             	cmp    $0x70,%ebx
 608:	74 5f                	je     669 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 60a:	83 fb 73             	cmp    $0x73,%ebx
 60d:	8d 76 00             	lea    0x0(%esi),%esi
 610:	74 7e                	je     690 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 612:	83 fb 63             	cmp    $0x63,%ebx
 615:	0f 84 b9 00 00 00    	je     6d4 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 61b:	83 fb 25             	cmp    $0x25,%ebx
 61e:	66 90                	xchg   %ax,%ax
 620:	0f 84 f2 00 00 00    	je     718 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 626:	8b 45 08             	mov    0x8(%ebp),%eax
 629:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 62e:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 631:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 633:	e8 c8 fe ff ff       	call   500 <putc>
        putc(fd, c);
 638:	8b 45 08             	mov    0x8(%ebp),%eax
 63b:	0f be d3             	movsbl %bl,%edx
 63e:	e8 bd fe ff ff       	call   500 <putc>
 643:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 646:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 64a:	84 c0                	test   %al,%al
 64c:	75 9d                	jne    5eb <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 64e:	83 c4 0c             	add    $0xc,%esp
 651:	5b                   	pop    %ebx
 652:	5e                   	pop    %esi
 653:	5f                   	pop    %edi
 654:	5d                   	pop    %ebp
 655:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 656:	8b 45 08             	mov    0x8(%ebp),%eax
 659:	0f be d3             	movsbl %bl,%edx
 65c:	e8 9f fe ff ff       	call   500 <putc>
 661:	8b 55 0c             	mov    0xc(%ebp),%edx
 664:	e9 77 ff ff ff       	jmp    5e0 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 669:	8b 45 f0             	mov    -0x10(%ebp),%eax
 66c:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 671:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 673:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 67a:	8b 10                	mov    (%eax),%edx
 67c:	8b 45 08             	mov    0x8(%ebp),%eax
 67f:	e8 ac fe ff ff       	call   530 <printint>
 684:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 687:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 68b:	e9 50 ff ff ff       	jmp    5e0 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 690:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 693:	8b 01                	mov    (%ecx),%eax
        ap++;
 695:	83 c1 04             	add    $0x4,%ecx
 698:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 69b:	b9 02 09 00 00       	mov    $0x902,%ecx
 6a0:	85 c0                	test   %eax,%eax
 6a2:	75 2c                	jne    6d0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 6a4:	0f b6 01             	movzbl (%ecx),%eax
 6a7:	84 c0                	test   %al,%al
 6a9:	74 1e                	je     6c9 <printf+0x119>
 6ab:	89 cb                	mov    %ecx,%ebx
 6ad:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 6b0:	0f be d0             	movsbl %al,%edx
 6b3:	8b 45 08             	mov    0x8(%ebp),%eax
 6b6:	e8 45 fe ff ff       	call   500 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6bb:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 6bf:	83 c3 01             	add    $0x1,%ebx
 6c2:	84 c0                	test   %al,%al
 6c4:	75 ea                	jne    6b0 <printf+0x100>
 6c6:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 6c9:	31 f6                	xor    %esi,%esi
 6cb:	e9 10 ff ff ff       	jmp    5e0 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 6d0:	89 c1                	mov    %eax,%ecx
 6d2:	eb d0                	jmp    6a4 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 6d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 6d7:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 6d9:	0f be 10             	movsbl (%eax),%edx
 6dc:	8b 45 08             	mov    0x8(%ebp),%eax
 6df:	e8 1c fe ff ff       	call   500 <putc>
 6e4:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 6e7:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 6eb:	e9 f0 fe ff ff       	jmp    5e0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 6f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6f3:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 6f8:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 6fb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 702:	8b 10                	mov    (%eax),%edx
 704:	8b 45 08             	mov    0x8(%ebp),%eax
 707:	e8 24 fe ff ff       	call   530 <printint>
 70c:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 70f:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 713:	e9 c8 fe ff ff       	jmp    5e0 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 718:	8b 45 08             	mov    0x8(%ebp),%eax
 71b:	ba 25 00 00 00       	mov    $0x25,%edx
 720:	31 f6                	xor    %esi,%esi
 722:	e8 d9 fd ff ff       	call   500 <putc>
 727:	8b 55 0c             	mov    0xc(%ebp),%edx
 72a:	e9 b1 fe ff ff       	jmp    5e0 <printf+0x30>
 72f:	90                   	nop    

00000730 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 730:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 731:	8b 0d 2c 09 00 00    	mov    0x92c,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 737:	89 e5                	mov    %esp,%ebp
 739:	56                   	push   %esi
 73a:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 73b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 73e:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 741:	39 d9                	cmp    %ebx,%ecx
 743:	73 18                	jae    75d <free+0x2d>
 745:	8b 11                	mov    (%ecx),%edx
 747:	39 d3                	cmp    %edx,%ebx
 749:	72 17                	jb     762 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 74b:	39 d1                	cmp    %edx,%ecx
 74d:	72 08                	jb     757 <free+0x27>
 74f:	39 d9                	cmp    %ebx,%ecx
 751:	72 0f                	jb     762 <free+0x32>
 753:	39 d3                	cmp    %edx,%ebx
 755:	72 0b                	jb     762 <free+0x32>
 757:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 759:	39 d9                	cmp    %ebx,%ecx
 75b:	72 e8                	jb     745 <free+0x15>
 75d:	8b 11                	mov    (%ecx),%edx
 75f:	90                   	nop    
 760:	eb e9                	jmp    74b <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 762:	8b 73 04             	mov    0x4(%ebx),%esi
 765:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 768:	39 d0                	cmp    %edx,%eax
 76a:	74 18                	je     784 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 76c:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 76e:	8b 51 04             	mov    0x4(%ecx),%edx
 771:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 774:	39 d8                	cmp    %ebx,%eax
 776:	74 20                	je     798 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 778:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 77a:	5b                   	pop    %ebx
 77b:	5e                   	pop    %esi
 77c:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 77d:	89 0d 2c 09 00 00    	mov    %ecx,0x92c
}
 783:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 784:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 787:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 789:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 78c:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 78f:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 791:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 794:	39 d8                	cmp    %ebx,%eax
 796:	75 e0                	jne    778 <free+0x48>
    p->s.size += bp->s.size;
 798:	03 53 04             	add    0x4(%ebx),%edx
 79b:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 79e:	8b 13                	mov    (%ebx),%edx
 7a0:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 7a2:	5b                   	pop    %ebx
 7a3:	5e                   	pop    %esi
 7a4:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 7a5:	89 0d 2c 09 00 00    	mov    %ecx,0x92c
}
 7ab:	c3                   	ret    
 7ac:	8d 74 26 00          	lea    0x0(%esi),%esi

000007b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7b0:	55                   	push   %ebp
 7b1:	89 e5                	mov    %esp,%ebp
 7b3:	57                   	push   %edi
 7b4:	56                   	push   %esi
 7b5:	53                   	push   %ebx
 7b6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7bc:	8b 15 2c 09 00 00    	mov    0x92c,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7c2:	83 c0 07             	add    $0x7,%eax
 7c5:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 7c8:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7ca:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 7cd:	0f 84 8a 00 00 00    	je     85d <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d3:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 7d5:	8b 41 04             	mov    0x4(%ecx),%eax
 7d8:	39 c3                	cmp    %eax,%ebx
 7da:	76 1a                	jbe    7f6 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 7dc:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 7e3:	3b 0d 2c 09 00 00    	cmp    0x92c,%ecx
 7e9:	89 ca                	mov    %ecx,%edx
 7eb:	74 29                	je     816 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ed:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 7ef:	8b 41 04             	mov    0x4(%ecx),%eax
 7f2:	39 c3                	cmp    %eax,%ebx
 7f4:	77 ed                	ja     7e3 <malloc+0x33>
      if(p->s.size == nunits)
 7f6:	39 c3                	cmp    %eax,%ebx
 7f8:	74 5d                	je     857 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 7fa:	29 d8                	sub    %ebx,%eax
 7fc:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 7ff:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 802:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 805:	89 15 2c 09 00 00    	mov    %edx,0x92c
      return (void*) (p + 1);
 80b:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 80e:	83 c4 0c             	add    $0xc,%esp
 811:	5b                   	pop    %ebx
 812:	5e                   	pop    %esi
 813:	5f                   	pop    %edi
 814:	5d                   	pop    %ebp
 815:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 816:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 81c:	89 de                	mov    %ebx,%esi
 81e:	89 f8                	mov    %edi,%eax
 820:	76 29                	jbe    84b <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 822:	89 04 24             	mov    %eax,(%esp)
 825:	e8 96 fc ff ff       	call   4c0 <sbrk>
  if(p == (char*) -1)
 82a:	83 f8 ff             	cmp    $0xffffffff,%eax
 82d:	74 18                	je     847 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 82f:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 832:	83 c0 08             	add    $0x8,%eax
 835:	89 04 24             	mov    %eax,(%esp)
 838:	e8 f3 fe ff ff       	call   730 <free>
  return freep;
 83d:	8b 15 2c 09 00 00    	mov    0x92c,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 843:	85 d2                	test   %edx,%edx
 845:	75 a6                	jne    7ed <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 847:	31 c0                	xor    %eax,%eax
 849:	eb c3                	jmp    80e <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 84b:	be 00 10 00 00       	mov    $0x1000,%esi
 850:	b8 00 80 00 00       	mov    $0x8000,%eax
 855:	eb cb                	jmp    822 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 857:	8b 01                	mov    (%ecx),%eax
 859:	89 02                	mov    %eax,(%edx)
 85b:	eb a8                	jmp    805 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 85d:	ba 24 09 00 00       	mov    $0x924,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 862:	c7 05 2c 09 00 00 24 	movl   $0x924,0x92c
 869:	09 00 00 
 86c:	c7 05 24 09 00 00 24 	movl   $0x924,0x924
 873:	09 00 00 
    base.s.size = 0;
 876:	c7 05 28 09 00 00 00 	movl   $0x0,0x928
 87d:	00 00 00 
 880:	e9 4e ff ff ff       	jmp    7d3 <malloc+0x23>
