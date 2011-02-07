
_hw2-test-string:     file format elf32-i386

Disassembly of section .text:

00000000 <startrecording>:
int stdout = 1;
int stderr = 2;

inline int startrecording() {
   0:	55                   	push   %ebp
  // homework 2: REMOVE this empty function once you've implemented the
  // corresponding system call.
  return 0;
}
   1:	31 c0                	xor    %eax,%eax
int stdout = 1;
int stderr = 2;

inline int startrecording() {
   3:	89 e5                	mov    %esp,%ebp
  // homework 2: REMOVE this empty function once you've implemented the
  // corresponding system call.
  return 0;
}
   5:	5d                   	pop    %ebp
   6:	c3                   	ret    
   7:	89 f6                	mov    %esi,%esi
   9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000010 <stoprecording>:

inline int stoprecording() {
  10:	55                   	push   %ebp
  // homework 2: REMOVE this empty function once you've implemented the
  // corresponding system call.
  return 0;
}
  11:	31 c0                	xor    %eax,%eax
  // homework 2: REMOVE this empty function once you've implemented the
  // corresponding system call.
  return 0;
}

inline int stoprecording() {
  13:	89 e5                	mov    %esp,%ebp
  // homework 2: REMOVE this empty function once you've implemented the
  // corresponding system call.
  return 0;
}
  15:	5d                   	pop    %ebp
  16:	c3                   	ret    
  17:	89 f6                	mov    %esi,%esi
  19:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000020 <fetchrecords>:

inline int fetchrecords(struct record *records, int num_records) {
  20:	55                   	push   %ebp
  // homework 2: REMOVE this empty function once you've implemented the
  // corresponding system call.
  return 0;
}
  21:	31 c0                	xor    %eax,%eax
  // homework 2: REMOVE this empty function once you've implemented the
  // corresponding system call.
  return 0;
}

inline int fetchrecords(struct record *records, int num_records) {
  23:	89 e5                	mov    %esp,%ebp
  // homework 2: REMOVE this empty function once you've implemented the
  // corresponding system call.
  return 0;
}
  25:	5d                   	pop    %ebp
  26:	c3                   	ret    
  27:	89 f6                	mov    %esi,%esi
  29:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000030 <handle_error>:

inline void handle_error(const char *msg) {
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	83 ec 18             	sub    $0x18,%esp
  printf(stderr, "%s\n", msg);
  36:	8b 45 08             	mov    0x8(%ebp),%eax
  39:	c7 44 24 04 85 08 00 	movl   $0x885,0x4(%esp)
  40:	00 
  41:	89 44 24 08          	mov    %eax,0x8(%esp)
  45:	a1 6c 09 00 00       	mov    0x96c,%eax
  4a:	89 04 24             	mov    %eax,(%esp)
  4d:	e8 5e 05 00 00       	call   5b0 <printf>
  exit();
  52:	e8 01 04 00 00       	call   458 <exit>
  57:	89 f6                	mov    %esi,%esi
  59:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000060 <check_arg_string>:
    printf(stderr, "actual %p, expected %p\n", r->value.ptrval, p);
    handle_error("error check_arg_pointer");
  }
}

inline void check_arg_string(const struct record *r, char *s) {
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	83 ec 18             	sub    $0x18,%esp
  66:	8b 45 08             	mov    0x8(%ebp),%eax
  if (r->type != ARG_STRING || strcmp(r->value.strval, s) != 0)
  69:	83 38 03             	cmpl   $0x3,(%eax)
  6c:	75 16                	jne    84 <check_arg_string+0x24>
  6e:	8b 55 0c             	mov    0xc(%ebp),%edx
  71:	83 c0 04             	add    $0x4,%eax
  74:	89 04 24             	mov    %eax,(%esp)
  77:	89 54 24 04          	mov    %edx,0x4(%esp)
  7b:	e8 00 02 00 00       	call   280 <strcmp>
  80:	85 c0                	test   %eax,%eax
  82:	74 22                	je     a6 <check_arg_string+0x46>
  // corresponding system call.
  return 0;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
  84:	a1 6c 09 00 00       	mov    0x96c,%eax
  89:	c7 44 24 08 89 08 00 	movl   $0x889,0x8(%esp)
  90:	00 
  91:	c7 44 24 04 85 08 00 	movl   $0x885,0x4(%esp)
  98:	00 
  99:	89 04 24             	mov    %eax,(%esp)
  9c:	e8 0f 05 00 00       	call   5b0 <printf>
  exit();
  a1:	e8 b2 03 00 00       	call   458 <exit>
}

inline void check_arg_string(const struct record *r, char *s) {
  if (r->type != ARG_STRING || strcmp(r->value.strval, s) != 0)
    handle_error("error check_arg_string");
}
  a6:	c9                   	leave  
  a7:	c3                   	ret    
  a8:	90                   	nop    
  a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000000b0 <check_arg_pointer>:
inline void check_arg_integer(const struct record *r, int v) {
  if (r->type != ARG_INTEGER || r->value.intval != v)
    handle_error("error check_arg_integer");
}

inline void check_arg_pointer(const struct record *r, void *p) {
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	83 ec 18             	sub    $0x18,%esp
  b6:	8b 45 08             	mov    0x8(%ebp),%eax
  // Pointer values differs form machine to machine. 
  // Do not count on it. 
  if (r->type != ARG_POINTER/* || r->value.ptrval != p */) {
  b9:	83 38 02             	cmpl   $0x2,(%eax)
  bc:	75 02                	jne    c0 <check_arg_pointer+0x10>
    printf(stderr, "actual %p, expected %p\n", r->value.ptrval, p);
    handle_error("error check_arg_pointer");
  }
}
  be:	c9                   	leave  
  bf:	c3                   	ret    

inline void check_arg_pointer(const struct record *r, void *p) {
  // Pointer values differs form machine to machine. 
  // Do not count on it. 
  if (r->type != ARG_POINTER/* || r->value.ptrval != p */) {
    printf(stderr, "actual %p, expected %p\n", r->value.ptrval, p);
  c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  c3:	89 54 24 0c          	mov    %edx,0xc(%esp)
  c7:	8b 40 04             	mov    0x4(%eax),%eax
  ca:	c7 44 24 04 a0 08 00 	movl   $0x8a0,0x4(%esp)
  d1:	00 
  d2:	89 44 24 08          	mov    %eax,0x8(%esp)
  d6:	a1 6c 09 00 00       	mov    0x96c,%eax
  db:	89 04 24             	mov    %eax,(%esp)
  de:	e8 cd 04 00 00       	call   5b0 <printf>
  // corresponding system call.
  return 0;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
  e3:	a1 6c 09 00 00       	mov    0x96c,%eax
  e8:	c7 44 24 08 b8 08 00 	movl   $0x8b8,0x8(%esp)
  ef:	00 
  f0:	c7 44 24 04 85 08 00 	movl   $0x885,0x4(%esp)
  f7:	00 
  f8:	89 04 24             	mov    %eax,(%esp)
  fb:	e8 b0 04 00 00       	call   5b0 <printf>
  exit();
 100:	e8 53 03 00 00       	call   458 <exit>
 105:	8d 74 26 00          	lea    0x0(%esi),%esi
 109:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000110 <check_arg_integer>:
inline void check_ret_value(const struct record *r, int v) {
  if (r->type != RET_VALUE || r->value.intval != v)
    handle_error("error check_ret_value");
}

inline void check_arg_integer(const struct record *r, int v) {
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	83 ec 18             	sub    $0x18,%esp
 116:	8b 45 08             	mov    0x8(%ebp),%eax
  if (r->type != ARG_INTEGER || r->value.intval != v)
 119:	83 38 01             	cmpl   $0x1,(%eax)
 11c:	75 08                	jne    126 <check_arg_integer+0x16>
 11e:	8b 55 0c             	mov    0xc(%ebp),%edx
 121:	39 50 04             	cmp    %edx,0x4(%eax)
 124:	74 22                	je     148 <check_arg_integer+0x38>
  // corresponding system call.
  return 0;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 126:	a1 6c 09 00 00       	mov    0x96c,%eax
 12b:	c7 44 24 08 d0 08 00 	movl   $0x8d0,0x8(%esp)
 132:	00 
 133:	c7 44 24 04 85 08 00 	movl   $0x885,0x4(%esp)
 13a:	00 
 13b:	89 04 24             	mov    %eax,(%esp)
 13e:	e8 6d 04 00 00       	call   5b0 <printf>
  exit();
 143:	e8 10 03 00 00       	call   458 <exit>
}

inline void check_arg_integer(const struct record *r, int v) {
  if (r->type != ARG_INTEGER || r->value.intval != v)
    handle_error("error check_arg_integer");
}
 148:	c9                   	leave  
 149:	c3                   	ret    
 14a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000150 <check_ret_value>:
inline void check_syscall_no(const struct record *r, int n) {
  if (r->type != SYSCALL_NO || r->value.intval != n)
    handle_error("error check_syscall_no");
}

inline void check_ret_value(const struct record *r, int v) {
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	83 ec 18             	sub    $0x18,%esp
 156:	8b 45 08             	mov    0x8(%ebp),%eax
  if (r->type != RET_VALUE || r->value.intval != v)
 159:	83 38 04             	cmpl   $0x4,(%eax)
 15c:	75 08                	jne    166 <check_ret_value+0x16>
 15e:	8b 55 0c             	mov    0xc(%ebp),%edx
 161:	39 50 04             	cmp    %edx,0x4(%eax)
 164:	74 22                	je     188 <check_ret_value+0x38>
  // corresponding system call.
  return 0;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 166:	a1 6c 09 00 00       	mov    0x96c,%eax
 16b:	c7 44 24 08 e8 08 00 	movl   $0x8e8,0x8(%esp)
 172:	00 
 173:	c7 44 24 04 85 08 00 	movl   $0x885,0x4(%esp)
 17a:	00 
 17b:	89 04 24             	mov    %eax,(%esp)
 17e:	e8 2d 04 00 00       	call   5b0 <printf>
  exit();
 183:	e8 d0 02 00 00       	call   458 <exit>
}

inline void check_ret_value(const struct record *r, int v) {
  if (r->type != RET_VALUE || r->value.intval != v)
    handle_error("error check_ret_value");
}
 188:	c9                   	leave  
 189:	c3                   	ret    
 18a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000190 <check_syscall_no>:
inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
  exit();
}

inline void check_syscall_no(const struct record *r, int n) {
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	83 ec 18             	sub    $0x18,%esp
 196:	8b 45 08             	mov    0x8(%ebp),%eax
  if (r->type != SYSCALL_NO || r->value.intval != n)
 199:	8b 10                	mov    (%eax),%edx
 19b:	85 d2                	test   %edx,%edx
 19d:	75 08                	jne    1a7 <check_syscall_no+0x17>
 19f:	8b 55 0c             	mov    0xc(%ebp),%edx
 1a2:	39 50 04             	cmp    %edx,0x4(%eax)
 1a5:	74 29                	je     1d0 <check_syscall_no+0x40>
  // corresponding system call.
  return 0;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 1a7:	a1 6c 09 00 00       	mov    0x96c,%eax
 1ac:	c7 44 24 08 fe 08 00 	movl   $0x8fe,0x8(%esp)
 1b3:	00 
 1b4:	c7 44 24 04 85 08 00 	movl   $0x885,0x4(%esp)
 1bb:	00 
 1bc:	89 04 24             	mov    %eax,(%esp)
 1bf:	e8 ec 03 00 00       	call   5b0 <printf>
  exit();
 1c4:	e8 8f 02 00 00       	call   458 <exit>
 1c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
}

inline void check_syscall_no(const struct record *r, int n) {
  if (r->type != SYSCALL_NO || r->value.intval != n)
    handle_error("error check_syscall_no");
}
 1d0:	c9                   	leave  
 1d1:	c3                   	ret    
 1d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000001e0 <main>:
#include "record.h"
#include "fcntl.h"
#include "syscall.h"
#include "hw2-common.h"

int main(int argc, char *argv[]) {
 1e0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 1e4:	83 e4 f0             	and    $0xfffffff0,%esp
 1e7:	ff 71 fc             	pushl  -0x4(%ecx)
 1ea:	55                   	push   %ebp
 1eb:	89 e5                	mov    %esp,%ebp
 1ed:	83 ec 18             	sub    $0x18,%esp
  
  ret = startrecording();
  if (ret == -1)
    handle_error("error startrecording");

  fd = open("README", O_RDONLY);
 1f0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1f7:	00 
#include "record.h"
#include "fcntl.h"
#include "syscall.h"
#include "hw2-common.h"

int main(int argc, char *argv[]) {
 1f8:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 1fb:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  
  ret = startrecording();
  if (ret == -1)
    handle_error("error startrecording");

  fd = open("README", O_RDONLY);
 1fe:	c7 04 24 15 09 00 00 	movl   $0x915,(%esp)
 205:	e8 8e 02 00 00       	call   498 <open>
  open("abcdefghijklmnopqrstuvwxyz", O_WRONLY);
 20a:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
 211:	00 
 212:	c7 04 24 1c 09 00 00 	movl   $0x91c,(%esp)
  
  ret = startrecording();
  if (ret == -1)
    handle_error("error startrecording");

  fd = open("README", O_RDONLY);
 219:	89 c3                	mov    %eax,%ebx
  open("abcdefghijklmnopqrstuvwxyz", O_WRONLY);
 21b:	e8 78 02 00 00       	call   498 <open>
  close(fd);
 220:	89 1c 24             	mov    %ebx,(%esp)
 223:	e8 58 02 00 00       	call   480 <close>
  // corresponding system call.
  return 0;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 228:	a1 6c 09 00 00       	mov    0x96c,%eax
 22d:	c7 44 24 08 37 09 00 	movl   $0x937,0x8(%esp)
 234:	00 
 235:	c7 44 24 04 85 08 00 	movl   $0x885,0x4(%esp)
 23c:	00 
 23d:	89 04 24             	mov    %eax,(%esp)
 240:	e8 6b 03 00 00       	call   5b0 <printf>
  exit();
 245:	e8 0e 02 00 00       	call   458 <exit>
 24a:	90                   	nop    
 24b:	90                   	nop    
 24c:	90                   	nop    
 24d:	90                   	nop    
 24e:	90                   	nop    
 24f:	90                   	nop    

00000250 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	53                   	push   %ebx
 254:	8b 5d 08             	mov    0x8(%ebp),%ebx
 257:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 25a:	89 da                	mov    %ebx,%edx
 25c:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 260:	0f b6 01             	movzbl (%ecx),%eax
 263:	83 c1 01             	add    $0x1,%ecx
 266:	88 02                	mov    %al,(%edx)
 268:	83 c2 01             	add    $0x1,%edx
 26b:	84 c0                	test   %al,%al
 26d:	75 f1                	jne    260 <strcpy+0x10>
    ;
  return os;
}
 26f:	89 d8                	mov    %ebx,%eax
 271:	5b                   	pop    %ebx
 272:	5d                   	pop    %ebp
 273:	c3                   	ret    
 274:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 27a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000280 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	8b 4d 08             	mov    0x8(%ebp),%ecx
 286:	53                   	push   %ebx
 287:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 28a:	0f b6 01             	movzbl (%ecx),%eax
 28d:	84 c0                	test   %al,%al
 28f:	74 24                	je     2b5 <strcmp+0x35>
 291:	0f b6 13             	movzbl (%ebx),%edx
 294:	38 d0                	cmp    %dl,%al
 296:	74 12                	je     2aa <strcmp+0x2a>
 298:	eb 1e                	jmp    2b8 <strcmp+0x38>
 29a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2a0:	0f b6 13             	movzbl (%ebx),%edx
 2a3:	83 c1 01             	add    $0x1,%ecx
 2a6:	38 d0                	cmp    %dl,%al
 2a8:	75 0e                	jne    2b8 <strcmp+0x38>
 2aa:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 2ae:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2b1:	84 c0                	test   %al,%al
 2b3:	75 eb                	jne    2a0 <strcmp+0x20>
 2b5:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 2b8:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2b9:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 2bc:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2bd:	0f b6 d2             	movzbl %dl,%edx
 2c0:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 2c2:	c3                   	ret    
 2c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000002d0 <strlen>:

uint
strlen(char *s)
{
 2d0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 2d1:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 2d3:	89 e5                	mov    %esp,%ebp
 2d5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 2d8:	80 39 00             	cmpb   $0x0,(%ecx)
 2db:	74 0e                	je     2eb <strlen+0x1b>
 2dd:	31 d2                	xor    %edx,%edx
 2df:	90                   	nop    
 2e0:	83 c2 01             	add    $0x1,%edx
 2e3:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
 2e7:	89 d0                	mov    %edx,%eax
 2e9:	75 f5                	jne    2e0 <strlen+0x10>
    ;
  return n;
}
 2eb:	5d                   	pop    %ebp
 2ec:	c3                   	ret    
 2ed:	8d 76 00             	lea    0x0(%esi),%esi

000002f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	8b 55 08             	mov    0x8(%ebp),%edx
 2f6:	57                   	push   %edi
 2f7:	8b 45 0c             	mov    0xc(%ebp),%eax
 2fa:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 2fd:	89 d7                	mov    %edx,%edi
 2ff:	fc                   	cld    
 300:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 302:	5f                   	pop    %edi
 303:	89 d0                	mov    %edx,%eax
 305:	5d                   	pop    %ebp
 306:	c3                   	ret    
 307:	89 f6                	mov    %esi,%esi
 309:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000310 <strchr>:

char*
strchr(const char *s, char c)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	8b 45 08             	mov    0x8(%ebp),%eax
 316:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 31a:	0f b6 10             	movzbl (%eax),%edx
 31d:	84 d2                	test   %dl,%dl
 31f:	75 0c                	jne    32d <strchr+0x1d>
 321:	eb 11                	jmp    334 <strchr+0x24>
 323:	83 c0 01             	add    $0x1,%eax
 326:	0f b6 10             	movzbl (%eax),%edx
 329:	84 d2                	test   %dl,%dl
 32b:	74 07                	je     334 <strchr+0x24>
    if(*s == c)
 32d:	38 ca                	cmp    %cl,%dl
 32f:	90                   	nop    
 330:	75 f1                	jne    323 <strchr+0x13>
      return (char*) s;
  return 0;
}
 332:	5d                   	pop    %ebp
 333:	c3                   	ret    
 334:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 335:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 337:	c3                   	ret    
 338:	90                   	nop    
 339:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000340 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	8b 4d 08             	mov    0x8(%ebp),%ecx
 346:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 347:	31 db                	xor    %ebx,%ebx
 349:	0f b6 11             	movzbl (%ecx),%edx
 34c:	8d 42 d0             	lea    -0x30(%edx),%eax
 34f:	3c 09                	cmp    $0x9,%al
 351:	77 18                	ja     36b <atoi+0x2b>
    n = n*10 + *s++ - '0';
 353:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 356:	0f be d2             	movsbl %dl,%edx
 359:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 35d:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 361:	83 c1 01             	add    $0x1,%ecx
 364:	8d 42 d0             	lea    -0x30(%edx),%eax
 367:	3c 09                	cmp    $0x9,%al
 369:	76 e8                	jbe    353 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 36b:	89 d8                	mov    %ebx,%eax
 36d:	5b                   	pop    %ebx
 36e:	5d                   	pop    %ebp
 36f:	c3                   	ret    

00000370 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	8b 4d 10             	mov    0x10(%ebp),%ecx
 376:	56                   	push   %esi
 377:	8b 75 08             	mov    0x8(%ebp),%esi
 37a:	53                   	push   %ebx
 37b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 37e:	85 c9                	test   %ecx,%ecx
 380:	7e 10                	jle    392 <memmove+0x22>
 382:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 384:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 388:	88 04 32             	mov    %al,(%edx,%esi,1)
 38b:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 38e:	39 ca                	cmp    %ecx,%edx
 390:	75 f2                	jne    384 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 392:	89 f0                	mov    %esi,%eax
 394:	5b                   	pop    %ebx
 395:	5e                   	pop    %esi
 396:	5d                   	pop    %ebp
 397:	c3                   	ret    
 398:	90                   	nop    
 399:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000003a0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3a6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 3a9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 3ac:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 3af:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3b4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 3bb:	00 
 3bc:	89 04 24             	mov    %eax,(%esp)
 3bf:	e8 d4 00 00 00       	call   498 <open>
  if(fd < 0)
 3c4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3c6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 3c8:	78 19                	js     3e3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 3ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 3cd:	89 1c 24             	mov    %ebx,(%esp)
 3d0:	89 44 24 04          	mov    %eax,0x4(%esp)
 3d4:	e8 d7 00 00 00       	call   4b0 <fstat>
  close(fd);
 3d9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 3dc:	89 c6                	mov    %eax,%esi
  close(fd);
 3de:	e8 9d 00 00 00       	call   480 <close>
  return r;
}
 3e3:	89 f0                	mov    %esi,%eax
 3e5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 3e8:	8b 75 fc             	mov    -0x4(%ebp),%esi
 3eb:	89 ec                	mov    %ebp,%esp
 3ed:	5d                   	pop    %ebp
 3ee:	c3                   	ret    
 3ef:	90                   	nop    

000003f0 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	56                   	push   %esi
 3f5:	31 f6                	xor    %esi,%esi
 3f7:	53                   	push   %ebx
 3f8:	83 ec 1c             	sub    $0x1c,%esp
 3fb:	8b 7d 08             	mov    0x8(%ebp),%edi
 3fe:	eb 06                	jmp    406 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 400:	3c 0d                	cmp    $0xd,%al
 402:	74 39                	je     43d <gets+0x4d>
 404:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 406:	8d 5e 01             	lea    0x1(%esi),%ebx
 409:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 40c:	7d 31                	jge    43f <gets+0x4f>
    cc = read(0, &c, 1);
 40e:	8d 45 f3             	lea    -0xd(%ebp),%eax
 411:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 418:	00 
 419:	89 44 24 04          	mov    %eax,0x4(%esp)
 41d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 424:	e8 47 00 00 00       	call   470 <read>
    if(cc < 1)
 429:	85 c0                	test   %eax,%eax
 42b:	7e 12                	jle    43f <gets+0x4f>
      break;
    buf[i++] = c;
 42d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 431:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 435:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 439:	3c 0a                	cmp    $0xa,%al
 43b:	75 c3                	jne    400 <gets+0x10>
 43d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 43f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 443:	89 f8                	mov    %edi,%eax
 445:	83 c4 1c             	add    $0x1c,%esp
 448:	5b                   	pop    %ebx
 449:	5e                   	pop    %esi
 44a:	5f                   	pop    %edi
 44b:	5d                   	pop    %ebp
 44c:	c3                   	ret    
 44d:	90                   	nop    
 44e:	90                   	nop    
 44f:	90                   	nop    

00000450 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 450:	b8 01 00 00 00       	mov    $0x1,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    

00000458 <exit>:
SYSCALL(exit)
 458:	b8 02 00 00 00       	mov    $0x2,%eax
 45d:	cd 40                	int    $0x40
 45f:	c3                   	ret    

00000460 <wait>:
SYSCALL(wait)
 460:	b8 03 00 00 00       	mov    $0x3,%eax
 465:	cd 40                	int    $0x40
 467:	c3                   	ret    

00000468 <pipe>:
SYSCALL(pipe)
 468:	b8 04 00 00 00       	mov    $0x4,%eax
 46d:	cd 40                	int    $0x40
 46f:	c3                   	ret    

00000470 <read>:
SYSCALL(read)
 470:	b8 06 00 00 00       	mov    $0x6,%eax
 475:	cd 40                	int    $0x40
 477:	c3                   	ret    

00000478 <write>:
SYSCALL(write)
 478:	b8 05 00 00 00       	mov    $0x5,%eax
 47d:	cd 40                	int    $0x40
 47f:	c3                   	ret    

00000480 <close>:
SYSCALL(close)
 480:	b8 07 00 00 00       	mov    $0x7,%eax
 485:	cd 40                	int    $0x40
 487:	c3                   	ret    

00000488 <kill>:
SYSCALL(kill)
 488:	b8 08 00 00 00       	mov    $0x8,%eax
 48d:	cd 40                	int    $0x40
 48f:	c3                   	ret    

00000490 <exec>:
SYSCALL(exec)
 490:	b8 09 00 00 00       	mov    $0x9,%eax
 495:	cd 40                	int    $0x40
 497:	c3                   	ret    

00000498 <open>:
SYSCALL(open)
 498:	b8 0a 00 00 00       	mov    $0xa,%eax
 49d:	cd 40                	int    $0x40
 49f:	c3                   	ret    

000004a0 <mknod>:
SYSCALL(mknod)
 4a0:	b8 0b 00 00 00       	mov    $0xb,%eax
 4a5:	cd 40                	int    $0x40
 4a7:	c3                   	ret    

000004a8 <unlink>:
SYSCALL(unlink)
 4a8:	b8 0c 00 00 00       	mov    $0xc,%eax
 4ad:	cd 40                	int    $0x40
 4af:	c3                   	ret    

000004b0 <fstat>:
SYSCALL(fstat)
 4b0:	b8 0d 00 00 00       	mov    $0xd,%eax
 4b5:	cd 40                	int    $0x40
 4b7:	c3                   	ret    

000004b8 <link>:
SYSCALL(link)
 4b8:	b8 0e 00 00 00       	mov    $0xe,%eax
 4bd:	cd 40                	int    $0x40
 4bf:	c3                   	ret    

000004c0 <mkdir>:
SYSCALL(mkdir)
 4c0:	b8 0f 00 00 00       	mov    $0xf,%eax
 4c5:	cd 40                	int    $0x40
 4c7:	c3                   	ret    

000004c8 <chdir>:
SYSCALL(chdir)
 4c8:	b8 10 00 00 00       	mov    $0x10,%eax
 4cd:	cd 40                	int    $0x40
 4cf:	c3                   	ret    

000004d0 <dup>:
SYSCALL(dup)
 4d0:	b8 11 00 00 00       	mov    $0x11,%eax
 4d5:	cd 40                	int    $0x40
 4d7:	c3                   	ret    

000004d8 <getpid>:
SYSCALL(getpid)
 4d8:	b8 12 00 00 00       	mov    $0x12,%eax
 4dd:	cd 40                	int    $0x40
 4df:	c3                   	ret    

000004e0 <sbrk>:
SYSCALL(sbrk)
 4e0:	b8 13 00 00 00       	mov    $0x13,%eax
 4e5:	cd 40                	int    $0x40
 4e7:	c3                   	ret    

000004e8 <sleep>:
SYSCALL(sleep)
 4e8:	b8 14 00 00 00       	mov    $0x14,%eax
 4ed:	cd 40                	int    $0x40
 4ef:	c3                   	ret    

000004f0 <uptime>:
SYSCALL(uptime)
 4f0:	b8 15 00 00 00       	mov    $0x15,%eax
 4f5:	cd 40                	int    $0x40
 4f7:	c3                   	ret    
 4f8:	90                   	nop    
 4f9:	90                   	nop    
 4fa:	90                   	nop    
 4fb:	90                   	nop    
 4fc:	90                   	nop    
 4fd:	90                   	nop    
 4fe:	90                   	nop    
 4ff:	90                   	nop    

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
 51b:	e8 58 ff ff ff       	call   478 <write>
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
 55d:	0f b6 82 55 09 00 00 	movzbl 0x955(%edx),%eax
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
 69b:	b9 4e 09 00 00       	mov    $0x94e,%ecx
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
 731:	8b 0d 78 09 00 00    	mov    0x978,%ecx
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
 77d:	89 0d 78 09 00 00    	mov    %ecx,0x978
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
 7a5:	89 0d 78 09 00 00    	mov    %ecx,0x978
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
 7bc:	8b 15 78 09 00 00    	mov    0x978,%edx
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
 7e3:	3b 0d 78 09 00 00    	cmp    0x978,%ecx
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
 805:	89 15 78 09 00 00    	mov    %edx,0x978
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
 825:	e8 b6 fc ff ff       	call   4e0 <sbrk>
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
 83d:	8b 15 78 09 00 00    	mov    0x978,%edx
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
 85d:	ba 70 09 00 00       	mov    $0x970,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 862:	c7 05 78 09 00 00 70 	movl   $0x970,0x978
 869:	09 00 00 
 86c:	c7 05 70 09 00 00 70 	movl   $0x970,0x970
 873:	09 00 00 
    base.s.size = 0;
 876:	c7 05 74 09 00 00 00 	movl   $0x0,0x974
 87d:	00 00 00 
 880:	e9 4e ff ff ff       	jmp    7d3 <malloc+0x23>
