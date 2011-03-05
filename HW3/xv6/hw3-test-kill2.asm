
_hw3-test-kill2:     file format elf32-i386

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

00000040 <handle_error>:

inline void handle_error(const char *msg) {
  40:	55                   	push   %ebp
  41:	89 e5                	mov    %esp,%ebp
  43:	83 ec 18             	sub    $0x18,%esp
  printf(stderr, "%s\n", msg);
  46:	8b 45 08             	mov    0x8(%ebp),%eax
  49:	c7 44 24 04 15 08 00 	movl   $0x815,0x4(%esp)
  50:	00 
  51:	89 44 24 08          	mov    %eax,0x8(%esp)
  55:	a1 a0 08 00 00       	mov    0x8a0,%eax
  5a:	89 04 24             	mov    %eax,(%esp)
  5d:	e8 de 04 00 00       	call   540 <printf>
  exit();
  62:	e8 61 03 00 00       	call   3c8 <exit>
  67:	89 f6                	mov    %esi,%esi
  69:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000070 <thread_function>:
#define N_THREADS 8

int thread_check[N_THREADS];

void thread_function(void *arg)
{
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	83 ec 08             	sub    $0x8,%esp
  thread_check[(int)arg] = MAGIC_VALUE;
  76:	8b 45 08             	mov    0x8(%ebp),%eax
  79:	c7 04 85 e0 08 00 00 	movl   $0x987cdef,0x8e0(,%eax,4)
  80:	ef cd 87 09 

  for (;;)
    sleep(0xFFFF);
  84:	c7 04 24 ff ff 00 00 	movl   $0xffff,(%esp)
  8b:	e8 c8 03 00 00       	call   458 <sleep>
  90:	eb f2                	jmp    84 <thread_function+0x14>
  92:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  99:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000000a0 <thread_kill_test>:

  texit();
}

void thread_kill_test()
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	57                   	push   %edi
  a4:	56                   	push   %esi
  a5:	53                   	push   %ebx
  a6:	31 db                	xor    %ebx,%ebx
  a8:	83 ec 2c             	sub    $0x2c,%esp
  char *stack[N_THREADS];
  int tid[N_THREADS];
  int i;

  for (i = 0; i < N_THREADS; i ++)
    NEW_STACK_THREAD(thread_function, (void *)i, stack[i], tid[i]);
  ab:	8d 7d d4             	lea    -0x2c(%ebp),%edi
  ae:	66 90                	xchg   %ax,%ax
  b0:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  b7:	e8 84 06 00 00       	call   740 <malloc>
  bc:	85 c0                	test   %eax,%eax
  be:	74 7d                	je     13d <thread_kill_test+0x9d>
  c0:	05 00 10 00 00       	add    $0x1000,%eax
  c5:	89 44 24 08          	mov    %eax,0x8(%esp)
  c9:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  cd:	c7 04 24 70 00 00 00 	movl   $0x70,(%esp)
  d4:	e8 9f 03 00 00       	call   478 <tfork>
  d9:	85 c0                	test   %eax,%eax
  db:	0f 88 7e 00 00 00    	js     15f <thread_kill_test+0xbf>
  e1:	89 04 9f             	mov    %eax,(%edi,%ebx,4)
{
  char *stack[N_THREADS];
  int tid[N_THREADS];
  int i;

  for (i = 0; i < N_THREADS; i ++)
  e4:	83 c3 01             	add    $0x1,%ebx
    NEW_STACK_THREAD(thread_function, (void *)i, stack[i], tid[i]);
  e7:	89 fe                	mov    %edi,%esi
{
  char *stack[N_THREADS];
  int tid[N_THREADS];
  int i;

  for (i = 0; i < N_THREADS; i ++)
  e9:	83 fb 08             	cmp    $0x8,%ebx
  ec:	75 c2                	jne    b0 <thread_kill_test+0x10>
  ee:	b3 01                	mov    $0x1,%bl
    NEW_STACK_THREAD(thread_function, (void *)i, stack[i], tid[i]);

  for (i = 0; i < N_THREADS; i ++) {
    if (kill(tid[i]) >= 0)
  f0:	8b 44 9e fc          	mov    -0x4(%esi,%ebx,4),%eax
  f4:	89 04 24             	mov    %eax,(%esp)
  f7:	e8 fc 02 00 00       	call   3f8 <kill>
  fc:	85 c0                	test   %eax,%eax
  fe:	79 69                	jns    169 <thread_kill_test+0xc9>
 100:	83 c3 01             	add    $0x1,%ebx
  int i;

  for (i = 0; i < N_THREADS; i ++)
    NEW_STACK_THREAD(thread_function, (void *)i, stack[i], tid[i]);

  for (i = 0; i < N_THREADS; i ++) {
 103:	83 fb 09             	cmp    $0x9,%ebx
 106:	75 e8                	jne    f0 <thread_kill_test+0x50>
    if (kill(tid[i]) >= 0)
      handle_error("kill() error");
  }

  sleep(ONE_SEC);
 108:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 10f:	e8 44 03 00 00       	call   458 <sleep>
 114:	31 c0                	xor    %eax,%eax

  for (i = 0; i < N_THREADS; i ++) {
    if (thread_check[i] != MAGIC_VALUE)
 116:	81 3c 85 e0 08 00 00 	cmpl   $0x987cdef,0x8e0(,%eax,4)
 11d:	ef cd 87 09 
 121:	75 50                	jne    173 <thread_kill_test+0xd3>
      handle_error("kill() error");
  }

  sleep(ONE_SEC);

  for (i = 0; i < N_THREADS; i ++) {
 123:	83 c0 01             	add    $0x1,%eax
 126:	83 f8 08             	cmp    $0x8,%eax
 129:	75 eb                	jne    116 <thread_kill_test+0x76>
    if (thread_check[i] != MAGIC_VALUE)
      handle_error("check value error");
  }

  PROC_CHECK(N_THREADS + 3);
 12b:	e8 38 03 00 00       	call   468 <pschk>
 130:	83 f8 0b             	cmp    $0xb,%eax
 133:	75 48                	jne    17d <thread_kill_test+0xdd>
}
 135:	83 c4 2c             	add    $0x2c,%esp
 138:	5b                   	pop    %ebx
 139:	5e                   	pop    %esi
 13a:	5f                   	pop    %edi
 13b:	5d                   	pop    %ebp
 13c:	c3                   	ret    
  }
  return 10 * (b - a) <= b;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 13d:	c7 44 24 08 19 08 00 	movl   $0x819,0x8(%esp)
 144:	00 
  exit();
 145:	a1 a0 08 00 00       	mov    0x8a0,%eax
 14a:	c7 44 24 04 15 08 00 	movl   $0x815,0x4(%esp)
 151:	00 
 152:	89 04 24             	mov    %eax,(%esp)
 155:	e8 e6 03 00 00       	call   540 <printf>
 15a:	e8 69 02 00 00       	call   3c8 <exit>
  }
  return 10 * (b - a) <= b;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 15f:	c7 44 24 08 28 08 00 	movl   $0x828,0x8(%esp)
 166:	00 
 167:	eb dc                	jmp    145 <thread_kill_test+0xa5>
 169:	c7 44 24 08 36 08 00 	movl   $0x836,0x8(%esp)
 170:	00 
 171:	eb d2                	jmp    145 <thread_kill_test+0xa5>

int main(int argc, char *argv[])
{
 173:	c7 44 24 08 43 08 00 	movl   $0x843,0x8(%esp)
 17a:	00 
 17b:	eb c8                	jmp    145 <thread_kill_test+0xa5>
 17d:	c7 44 24 08 55 08 00 	movl   $0x855,0x8(%esp)
 184:	00 
 185:	eb be                	jmp    145 <thread_kill_test+0xa5>
 187:	89 f6                	mov    %esi,%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000190 <main>:
 190:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 194:	83 e4 f0             	and    $0xfffffff0,%esp
 197:	ff 71 fc             	pushl  -0x4(%ecx)
 19a:	55                   	push   %ebp
 19b:	89 e5                	mov    %esp,%ebp
 19d:	51                   	push   %ecx
 19e:	83 ec 14             	sub    $0x14,%esp
  thread_kill_test();
 1a1:	e8 fa fe ff ff       	call   a0 <thread_kill_test>

  printf(stdout, "hw3-test-kill2 succeeded!\n");
 1a6:	a1 9c 08 00 00       	mov    0x89c,%eax
 1ab:	c7 44 24 04 67 08 00 	movl   $0x867,0x4(%esp)
 1b2:	00 
 1b3:	89 04 24             	mov    %eax,(%esp)
 1b6:	e8 85 03 00 00       	call   540 <printf>
  exit();
 1bb:	e8 08 02 00 00       	call   3c8 <exit>

000001c0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	53                   	push   %ebx
 1c4:	8b 5d 08             	mov    0x8(%ebp),%ebx
 1c7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1ca:	89 da                	mov    %ebx,%edx
 1cc:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1d0:	0f b6 01             	movzbl (%ecx),%eax
 1d3:	83 c1 01             	add    $0x1,%ecx
 1d6:	88 02                	mov    %al,(%edx)
 1d8:	83 c2 01             	add    $0x1,%edx
 1db:	84 c0                	test   %al,%al
 1dd:	75 f1                	jne    1d0 <strcpy+0x10>
    ;
  return os;
}
 1df:	89 d8                	mov    %ebx,%eax
 1e1:	5b                   	pop    %ebx
 1e2:	5d                   	pop    %ebp
 1e3:	c3                   	ret    
 1e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1f6:	53                   	push   %ebx
 1f7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 1fa:	0f b6 01             	movzbl (%ecx),%eax
 1fd:	84 c0                	test   %al,%al
 1ff:	74 24                	je     225 <strcmp+0x35>
 201:	0f b6 13             	movzbl (%ebx),%edx
 204:	38 d0                	cmp    %dl,%al
 206:	74 12                	je     21a <strcmp+0x2a>
 208:	eb 1e                	jmp    228 <strcmp+0x38>
 20a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 210:	0f b6 13             	movzbl (%ebx),%edx
 213:	83 c1 01             	add    $0x1,%ecx
 216:	38 d0                	cmp    %dl,%al
 218:	75 0e                	jne    228 <strcmp+0x38>
 21a:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 21e:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 221:	84 c0                	test   %al,%al
 223:	75 eb                	jne    210 <strcmp+0x20>
 225:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 228:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 229:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 22c:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 22d:	0f b6 d2             	movzbl %dl,%edx
 230:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 232:	c3                   	ret    
 233:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000240 <strlen>:

uint
strlen(char *s)
{
 240:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 241:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 243:	89 e5                	mov    %esp,%ebp
 245:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 248:	80 39 00             	cmpb   $0x0,(%ecx)
 24b:	74 0e                	je     25b <strlen+0x1b>
 24d:	31 d2                	xor    %edx,%edx
 24f:	90                   	nop    
 250:	83 c2 01             	add    $0x1,%edx
 253:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
 257:	89 d0                	mov    %edx,%eax
 259:	75 f5                	jne    250 <strlen+0x10>
    ;
  return n;
}
 25b:	5d                   	pop    %ebp
 25c:	c3                   	ret    
 25d:	8d 76 00             	lea    0x0(%esi),%esi

00000260 <memset>:

void*
memset(void *dst, int c, uint n)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	8b 55 08             	mov    0x8(%ebp),%edx
 266:	57                   	push   %edi
 267:	8b 45 0c             	mov    0xc(%ebp),%eax
 26a:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 26d:	89 d7                	mov    %edx,%edi
 26f:	fc                   	cld    
 270:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 272:	5f                   	pop    %edi
 273:	89 d0                	mov    %edx,%eax
 275:	5d                   	pop    %ebp
 276:	c3                   	ret    
 277:	89 f6                	mov    %esi,%esi
 279:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000280 <strchr>:

char*
strchr(const char *s, char c)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	8b 45 08             	mov    0x8(%ebp),%eax
 286:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 28a:	0f b6 10             	movzbl (%eax),%edx
 28d:	84 d2                	test   %dl,%dl
 28f:	75 0c                	jne    29d <strchr+0x1d>
 291:	eb 11                	jmp    2a4 <strchr+0x24>
 293:	83 c0 01             	add    $0x1,%eax
 296:	0f b6 10             	movzbl (%eax),%edx
 299:	84 d2                	test   %dl,%dl
 29b:	74 07                	je     2a4 <strchr+0x24>
    if(*s == c)
 29d:	38 ca                	cmp    %cl,%dl
 29f:	90                   	nop    
 2a0:	75 f1                	jne    293 <strchr+0x13>
      return (char*) s;
  return 0;
}
 2a2:	5d                   	pop    %ebp
 2a3:	c3                   	ret    
 2a4:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2a5:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 2a7:	c3                   	ret    
 2a8:	90                   	nop    
 2a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000002b0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2b6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2b7:	31 db                	xor    %ebx,%ebx
 2b9:	0f b6 11             	movzbl (%ecx),%edx
 2bc:	8d 42 d0             	lea    -0x30(%edx),%eax
 2bf:	3c 09                	cmp    $0x9,%al
 2c1:	77 18                	ja     2db <atoi+0x2b>
    n = n*10 + *s++ - '0';
 2c3:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 2c6:	0f be d2             	movsbl %dl,%edx
 2c9:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2cd:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 2d1:	83 c1 01             	add    $0x1,%ecx
 2d4:	8d 42 d0             	lea    -0x30(%edx),%eax
 2d7:	3c 09                	cmp    $0x9,%al
 2d9:	76 e8                	jbe    2c3 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 2db:	89 d8                	mov    %ebx,%eax
 2dd:	5b                   	pop    %ebx
 2de:	5d                   	pop    %ebp
 2df:	c3                   	ret    

000002e0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	8b 4d 10             	mov    0x10(%ebp),%ecx
 2e6:	56                   	push   %esi
 2e7:	8b 75 08             	mov    0x8(%ebp),%esi
 2ea:	53                   	push   %ebx
 2eb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ee:	85 c9                	test   %ecx,%ecx
 2f0:	7e 10                	jle    302 <memmove+0x22>
 2f2:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 2f4:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 2f8:	88 04 32             	mov    %al,(%edx,%esi,1)
 2fb:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2fe:	39 ca                	cmp    %ecx,%edx
 300:	75 f2                	jne    2f4 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 302:	89 f0                	mov    %esi,%eax
 304:	5b                   	pop    %ebx
 305:	5e                   	pop    %esi
 306:	5d                   	pop    %ebp
 307:	c3                   	ret    
 308:	90                   	nop    
 309:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000310 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 316:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 319:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 31c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 31f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 324:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 32b:	00 
 32c:	89 04 24             	mov    %eax,(%esp)
 32f:	e8 d4 00 00 00       	call   408 <open>
  if(fd < 0)
 334:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 336:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 338:	78 19                	js     353 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 33a:	8b 45 0c             	mov    0xc(%ebp),%eax
 33d:	89 1c 24             	mov    %ebx,(%esp)
 340:	89 44 24 04          	mov    %eax,0x4(%esp)
 344:	e8 d7 00 00 00       	call   420 <fstat>
  close(fd);
 349:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 34c:	89 c6                	mov    %eax,%esi
  close(fd);
 34e:	e8 9d 00 00 00       	call   3f0 <close>
  return r;
}
 353:	89 f0                	mov    %esi,%eax
 355:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 358:	8b 75 fc             	mov    -0x4(%ebp),%esi
 35b:	89 ec                	mov    %ebp,%esp
 35d:	5d                   	pop    %ebp
 35e:	c3                   	ret    
 35f:	90                   	nop    

00000360 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	56                   	push   %esi
 365:	31 f6                	xor    %esi,%esi
 367:	53                   	push   %ebx
 368:	83 ec 1c             	sub    $0x1c,%esp
 36b:	8b 7d 08             	mov    0x8(%ebp),%edi
 36e:	eb 06                	jmp    376 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 370:	3c 0d                	cmp    $0xd,%al
 372:	74 39                	je     3ad <gets+0x4d>
 374:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 376:	8d 5e 01             	lea    0x1(%esi),%ebx
 379:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 37c:	7d 31                	jge    3af <gets+0x4f>
    cc = read(0, &c, 1);
 37e:	8d 45 f3             	lea    -0xd(%ebp),%eax
 381:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 388:	00 
 389:	89 44 24 04          	mov    %eax,0x4(%esp)
 38d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 394:	e8 47 00 00 00       	call   3e0 <read>
    if(cc < 1)
 399:	85 c0                	test   %eax,%eax
 39b:	7e 12                	jle    3af <gets+0x4f>
      break;
    buf[i++] = c;
 39d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 3a1:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 3a5:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 3a9:	3c 0a                	cmp    $0xa,%al
 3ab:	75 c3                	jne    370 <gets+0x10>
 3ad:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 3af:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 3b3:	89 f8                	mov    %edi,%eax
 3b5:	83 c4 1c             	add    $0x1c,%esp
 3b8:	5b                   	pop    %ebx
 3b9:	5e                   	pop    %esi
 3ba:	5f                   	pop    %edi
 3bb:	5d                   	pop    %ebp
 3bc:	c3                   	ret    
 3bd:	90                   	nop    
 3be:	90                   	nop    
 3bf:	90                   	nop    

000003c0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3c0:	b8 01 00 00 00       	mov    $0x1,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <exit>:
SYSCALL(exit)
 3c8:	b8 02 00 00 00       	mov    $0x2,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <wait>:
SYSCALL(wait)
 3d0:	b8 03 00 00 00       	mov    $0x3,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <pipe>:
SYSCALL(pipe)
 3d8:	b8 04 00 00 00       	mov    $0x4,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <read>:
SYSCALL(read)
 3e0:	b8 06 00 00 00       	mov    $0x6,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <write>:
SYSCALL(write)
 3e8:	b8 05 00 00 00       	mov    $0x5,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <close>:
SYSCALL(close)
 3f0:	b8 07 00 00 00       	mov    $0x7,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <kill>:
SYSCALL(kill)
 3f8:	b8 08 00 00 00       	mov    $0x8,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <exec>:
SYSCALL(exec)
 400:	b8 09 00 00 00       	mov    $0x9,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <open>:
SYSCALL(open)
 408:	b8 0a 00 00 00       	mov    $0xa,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <mknod>:
SYSCALL(mknod)
 410:	b8 0b 00 00 00       	mov    $0xb,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <unlink>:
SYSCALL(unlink)
 418:	b8 0c 00 00 00       	mov    $0xc,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <fstat>:
SYSCALL(fstat)
 420:	b8 0d 00 00 00       	mov    $0xd,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <link>:
SYSCALL(link)
 428:	b8 0e 00 00 00       	mov    $0xe,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <mkdir>:
SYSCALL(mkdir)
 430:	b8 0f 00 00 00       	mov    $0xf,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    

00000438 <chdir>:
SYSCALL(chdir)
 438:	b8 10 00 00 00       	mov    $0x10,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <dup>:
SYSCALL(dup)
 440:	b8 11 00 00 00       	mov    $0x11,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <getpid>:
SYSCALL(getpid)
 448:	b8 12 00 00 00       	mov    $0x12,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <sbrk>:
SYSCALL(sbrk)
 450:	b8 13 00 00 00       	mov    $0x13,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    

00000458 <sleep>:
SYSCALL(sleep)
 458:	b8 14 00 00 00       	mov    $0x14,%eax
 45d:	cd 40                	int    $0x40
 45f:	c3                   	ret    

00000460 <uptime>:
SYSCALL(uptime)
 460:	b8 15 00 00 00       	mov    $0x15,%eax
 465:	cd 40                	int    $0x40
 467:	c3                   	ret    

00000468 <pschk>:
SYSCALL(pschk)
 468:	b8 17 00 00 00       	mov    $0x17,%eax
 46d:	cd 40                	int    $0x40
 46f:	c3                   	ret    

00000470 <rwlock>:
SYSCALL(rwlock)
 470:	b8 16 00 00 00       	mov    $0x16,%eax
 475:	cd 40                	int    $0x40
 477:	c3                   	ret    

00000478 <tfork>:
SYSCALL(tfork)
 478:	b8 18 00 00 00       	mov    $0x18,%eax
 47d:	cd 40                	int    $0x40
 47f:	c3                   	ret    

00000480 <texit>:
SYSCALL(texit)
 480:	b8 19 00 00 00       	mov    $0x19,%eax
 485:	cd 40                	int    $0x40
 487:	c3                   	ret    

00000488 <twait>:
SYSCALL(twait)
 488:	b8 1a 00 00 00       	mov    $0x1a,%eax
 48d:	cd 40                	int    $0x40
 48f:	c3                   	ret    

00000490 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	83 ec 18             	sub    $0x18,%esp
 496:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 499:	8d 55 fc             	lea    -0x4(%ebp),%edx
 49c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4a3:	00 
 4a4:	89 54 24 04          	mov    %edx,0x4(%esp)
 4a8:	89 04 24             	mov    %eax,(%esp)
 4ab:	e8 38 ff ff ff       	call   3e8 <write>
}
 4b0:	c9                   	leave  
 4b1:	c3                   	ret    
 4b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 4b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000004c0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	56                   	push   %esi
 4c5:	89 ce                	mov    %ecx,%esi
 4c7:	53                   	push   %ebx
 4c8:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4cb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4ce:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4d1:	85 c9                	test   %ecx,%ecx
 4d3:	74 04                	je     4d9 <printint+0x19>
 4d5:	85 d2                	test   %edx,%edx
 4d7:	78 54                	js     52d <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4d9:	89 d0                	mov    %edx,%eax
 4db:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 4e2:	31 db                	xor    %ebx,%ebx
 4e4:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 4e7:	31 d2                	xor    %edx,%edx
 4e9:	f7 f6                	div    %esi
 4eb:	89 c1                	mov    %eax,%ecx
 4ed:	0f b6 82 89 08 00 00 	movzbl 0x889(%edx),%eax
 4f4:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 4f7:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 4fa:	85 c9                	test   %ecx,%ecx
 4fc:	89 c8                	mov    %ecx,%eax
 4fe:	75 e7                	jne    4e7 <printint+0x27>
  if(neg)
 500:	8b 45 e0             	mov    -0x20(%ebp),%eax
 503:	85 c0                	test   %eax,%eax
 505:	74 08                	je     50f <printint+0x4f>
    buf[i++] = '-';
 507:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 50c:	83 c3 01             	add    $0x1,%ebx
 50f:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 512:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 516:	83 eb 01             	sub    $0x1,%ebx
 519:	8b 45 dc             	mov    -0x24(%ebp),%eax
 51c:	e8 6f ff ff ff       	call   490 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 521:	39 fb                	cmp    %edi,%ebx
 523:	75 ed                	jne    512 <printint+0x52>
    putc(fd, buf[i]);
}
 525:	83 c4 1c             	add    $0x1c,%esp
 528:	5b                   	pop    %ebx
 529:	5e                   	pop    %esi
 52a:	5f                   	pop    %edi
 52b:	5d                   	pop    %ebp
 52c:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 52d:	89 d0                	mov    %edx,%eax
 52f:	f7 d8                	neg    %eax
 531:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 538:	eb a8                	jmp    4e2 <printint+0x22>
 53a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000540 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	57                   	push   %edi
 544:	56                   	push   %esi
 545:	53                   	push   %ebx
 546:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 549:	8b 55 0c             	mov    0xc(%ebp),%edx
 54c:	0f b6 02             	movzbl (%edx),%eax
 54f:	84 c0                	test   %al,%al
 551:	0f 84 87 00 00 00    	je     5de <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 557:	8d 4d 10             	lea    0x10(%ebp),%ecx
 55a:	31 ff                	xor    %edi,%edi
 55c:	31 f6                	xor    %esi,%esi
 55e:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 561:	eb 18                	jmp    57b <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 563:	83 fb 25             	cmp    $0x25,%ebx
 566:	0f 85 7a 00 00 00    	jne    5e6 <printf+0xa6>
 56c:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 570:	83 c7 01             	add    $0x1,%edi
 573:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 577:	84 c0                	test   %al,%al
 579:	74 63                	je     5de <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 57b:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 57d:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 580:	74 e1                	je     563 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 582:	83 fe 25             	cmp    $0x25,%esi
 585:	75 e9                	jne    570 <printf+0x30>
      if(c == 'd'){
 587:	83 fb 64             	cmp    $0x64,%ebx
 58a:	0f 84 f0 00 00 00    	je     680 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 590:	83 fb 78             	cmp    $0x78,%ebx
 593:	74 64                	je     5f9 <printf+0xb9>
 595:	83 fb 70             	cmp    $0x70,%ebx
 598:	74 5f                	je     5f9 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 59a:	83 fb 73             	cmp    $0x73,%ebx
 59d:	8d 76 00             	lea    0x0(%esi),%esi
 5a0:	74 7e                	je     620 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5a2:	83 fb 63             	cmp    $0x63,%ebx
 5a5:	0f 84 b9 00 00 00    	je     664 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5ab:	83 fb 25             	cmp    $0x25,%ebx
 5ae:	66 90                	xchg   %ax,%ax
 5b0:	0f 84 f2 00 00 00    	je     6a8 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5b6:	8b 45 08             	mov    0x8(%ebp),%eax
 5b9:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5be:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 5c1:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5c3:	e8 c8 fe ff ff       	call   490 <putc>
        putc(fd, c);
 5c8:	8b 45 08             	mov    0x8(%ebp),%eax
 5cb:	0f be d3             	movsbl %bl,%edx
 5ce:	e8 bd fe ff ff       	call   490 <putc>
 5d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5d6:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 5da:	84 c0                	test   %al,%al
 5dc:	75 9d                	jne    57b <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5de:	83 c4 0c             	add    $0xc,%esp
 5e1:	5b                   	pop    %ebx
 5e2:	5e                   	pop    %esi
 5e3:	5f                   	pop    %edi
 5e4:	5d                   	pop    %ebp
 5e5:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 5e6:	8b 45 08             	mov    0x8(%ebp),%eax
 5e9:	0f be d3             	movsbl %bl,%edx
 5ec:	e8 9f fe ff ff       	call   490 <putc>
 5f1:	8b 55 0c             	mov    0xc(%ebp),%edx
 5f4:	e9 77 ff ff ff       	jmp    570 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5fc:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 601:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 603:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 60a:	8b 10                	mov    (%eax),%edx
 60c:	8b 45 08             	mov    0x8(%ebp),%eax
 60f:	e8 ac fe ff ff       	call   4c0 <printint>
 614:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 617:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 61b:	e9 50 ff ff ff       	jmp    570 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 620:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 623:	8b 01                	mov    (%ecx),%eax
        ap++;
 625:	83 c1 04             	add    $0x4,%ecx
 628:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 62b:	b9 82 08 00 00       	mov    $0x882,%ecx
 630:	85 c0                	test   %eax,%eax
 632:	75 2c                	jne    660 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 634:	0f b6 01             	movzbl (%ecx),%eax
 637:	84 c0                	test   %al,%al
 639:	74 1e                	je     659 <printf+0x119>
 63b:	89 cb                	mov    %ecx,%ebx
 63d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 640:	0f be d0             	movsbl %al,%edx
 643:	8b 45 08             	mov    0x8(%ebp),%eax
 646:	e8 45 fe ff ff       	call   490 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 64b:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 64f:	83 c3 01             	add    $0x1,%ebx
 652:	84 c0                	test   %al,%al
 654:	75 ea                	jne    640 <printf+0x100>
 656:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 659:	31 f6                	xor    %esi,%esi
 65b:	e9 10 ff ff ff       	jmp    570 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 660:	89 c1                	mov    %eax,%ecx
 662:	eb d0                	jmp    634 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 664:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 667:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 669:	0f be 10             	movsbl (%eax),%edx
 66c:	8b 45 08             	mov    0x8(%ebp),%eax
 66f:	e8 1c fe ff ff       	call   490 <putc>
 674:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 677:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 67b:	e9 f0 fe ff ff       	jmp    570 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 680:	8b 45 f0             	mov    -0x10(%ebp),%eax
 683:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 688:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 68b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 692:	8b 10                	mov    (%eax),%edx
 694:	8b 45 08             	mov    0x8(%ebp),%eax
 697:	e8 24 fe ff ff       	call   4c0 <printint>
 69c:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 69f:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 6a3:	e9 c8 fe ff ff       	jmp    570 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 6a8:	8b 45 08             	mov    0x8(%ebp),%eax
 6ab:	ba 25 00 00 00       	mov    $0x25,%edx
 6b0:	31 f6                	xor    %esi,%esi
 6b2:	e8 d9 fd ff ff       	call   490 <putc>
 6b7:	8b 55 0c             	mov    0xc(%ebp),%edx
 6ba:	e9 b1 fe ff ff       	jmp    570 <printf+0x30>
 6bf:	90                   	nop    

000006c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c1:	8b 0d c8 08 00 00    	mov    0x8c8,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c7:	89 e5                	mov    %esp,%ebp
 6c9:	56                   	push   %esi
 6ca:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 6cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6ce:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d1:	39 d9                	cmp    %ebx,%ecx
 6d3:	73 18                	jae    6ed <free+0x2d>
 6d5:	8b 11                	mov    (%ecx),%edx
 6d7:	39 d3                	cmp    %edx,%ebx
 6d9:	72 17                	jb     6f2 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6db:	39 d1                	cmp    %edx,%ecx
 6dd:	72 08                	jb     6e7 <free+0x27>
 6df:	39 d9                	cmp    %ebx,%ecx
 6e1:	72 0f                	jb     6f2 <free+0x32>
 6e3:	39 d3                	cmp    %edx,%ebx
 6e5:	72 0b                	jb     6f2 <free+0x32>
 6e7:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e9:	39 d9                	cmp    %ebx,%ecx
 6eb:	72 e8                	jb     6d5 <free+0x15>
 6ed:	8b 11                	mov    (%ecx),%edx
 6ef:	90                   	nop    
 6f0:	eb e9                	jmp    6db <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6f2:	8b 73 04             	mov    0x4(%ebx),%esi
 6f5:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 6f8:	39 d0                	cmp    %edx,%eax
 6fa:	74 18                	je     714 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6fc:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 6fe:	8b 51 04             	mov    0x4(%ecx),%edx
 701:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 704:	39 d8                	cmp    %ebx,%eax
 706:	74 20                	je     728 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 708:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 70a:	5b                   	pop    %ebx
 70b:	5e                   	pop    %esi
 70c:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 70d:	89 0d c8 08 00 00    	mov    %ecx,0x8c8
}
 713:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 714:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 717:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 719:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 71c:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 71f:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 721:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 724:	39 d8                	cmp    %ebx,%eax
 726:	75 e0                	jne    708 <free+0x48>
    p->s.size += bp->s.size;
 728:	03 53 04             	add    0x4(%ebx),%edx
 72b:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 72e:	8b 13                	mov    (%ebx),%edx
 730:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 732:	5b                   	pop    %ebx
 733:	5e                   	pop    %esi
 734:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 735:	89 0d c8 08 00 00    	mov    %ecx,0x8c8
}
 73b:	c3                   	ret    
 73c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000740 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	57                   	push   %edi
 744:	56                   	push   %esi
 745:	53                   	push   %ebx
 746:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 749:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 74c:	8b 15 c8 08 00 00    	mov    0x8c8,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 752:	83 c0 07             	add    $0x7,%eax
 755:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 758:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 75a:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 75d:	0f 84 8a 00 00 00    	je     7ed <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 763:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 765:	8b 41 04             	mov    0x4(%ecx),%eax
 768:	39 c3                	cmp    %eax,%ebx
 76a:	76 1a                	jbe    786 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 76c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 773:	3b 0d c8 08 00 00    	cmp    0x8c8,%ecx
 779:	89 ca                	mov    %ecx,%edx
 77b:	74 29                	je     7a6 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 77d:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 77f:	8b 41 04             	mov    0x4(%ecx),%eax
 782:	39 c3                	cmp    %eax,%ebx
 784:	77 ed                	ja     773 <malloc+0x33>
      if(p->s.size == nunits)
 786:	39 c3                	cmp    %eax,%ebx
 788:	74 5d                	je     7e7 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 78a:	29 d8                	sub    %ebx,%eax
 78c:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 78f:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 792:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 795:	89 15 c8 08 00 00    	mov    %edx,0x8c8
      return (void*) (p + 1);
 79b:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 79e:	83 c4 0c             	add    $0xc,%esp
 7a1:	5b                   	pop    %ebx
 7a2:	5e                   	pop    %esi
 7a3:	5f                   	pop    %edi
 7a4:	5d                   	pop    %ebp
 7a5:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 7a6:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 7ac:	89 de                	mov    %ebx,%esi
 7ae:	89 f8                	mov    %edi,%eax
 7b0:	76 29                	jbe    7db <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 7b2:	89 04 24             	mov    %eax,(%esp)
 7b5:	e8 96 fc ff ff       	call   450 <sbrk>
  if(p == (char*) -1)
 7ba:	83 f8 ff             	cmp    $0xffffffff,%eax
 7bd:	74 18                	je     7d7 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 7bf:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 7c2:	83 c0 08             	add    $0x8,%eax
 7c5:	89 04 24             	mov    %eax,(%esp)
 7c8:	e8 f3 fe ff ff       	call   6c0 <free>
  return freep;
 7cd:	8b 15 c8 08 00 00    	mov    0x8c8,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 7d3:	85 d2                	test   %edx,%edx
 7d5:	75 a6                	jne    77d <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7d7:	31 c0                	xor    %eax,%eax
 7d9:	eb c3                	jmp    79e <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 7db:	be 00 10 00 00       	mov    $0x1000,%esi
 7e0:	b8 00 80 00 00       	mov    $0x8000,%eax
 7e5:	eb cb                	jmp    7b2 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 7e7:	8b 01                	mov    (%ecx),%eax
 7e9:	89 02                	mov    %eax,(%edx)
 7eb:	eb a8                	jmp    795 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 7ed:	ba c0 08 00 00       	mov    $0x8c0,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 7f2:	c7 05 c8 08 00 00 c0 	movl   $0x8c0,0x8c8
 7f9:	08 00 00 
 7fc:	c7 05 c0 08 00 00 c0 	movl   $0x8c0,0x8c0
 803:	08 00 00 
    base.s.size = 0;
 806:	c7 05 c4 08 00 00 00 	movl   $0x0,0x8c4
 80d:	00 00 00 
 810:	e9 4e ff ff ff       	jmp    763 <malloc+0x23>
