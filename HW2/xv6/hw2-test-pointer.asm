
_hw2-test-pointer:     file format elf32-i386

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
  39:	c7 44 24 04 65 08 00 	movl   $0x865,0x4(%esp)
  40:	00 
  41:	89 44 24 08          	mov    %eax,0x8(%esp)
  45:	a1 30 09 00 00       	mov    0x930,%eax
  4a:	89 04 24             	mov    %eax,(%esp)
  4d:	e8 3e 05 00 00       	call   590 <printf>
  exit();
  52:	e8 e1 03 00 00       	call   438 <exit>
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
  7b:	e8 e0 01 00 00       	call   260 <strcmp>
  80:	85 c0                	test   %eax,%eax
  82:	74 22                	je     a6 <check_arg_string+0x46>
  // corresponding system call.
  return 0;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
  84:	a1 30 09 00 00       	mov    0x930,%eax
  89:	c7 44 24 08 69 08 00 	movl   $0x869,0x8(%esp)
  90:	00 
  91:	c7 44 24 04 65 08 00 	movl   $0x865,0x4(%esp)
  98:	00 
  99:	89 04 24             	mov    %eax,(%esp)
  9c:	e8 ef 04 00 00       	call   590 <printf>
  exit();
  a1:	e8 92 03 00 00       	call   438 <exit>
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
  ca:	c7 44 24 04 80 08 00 	movl   $0x880,0x4(%esp)
  d1:	00 
  d2:	89 44 24 08          	mov    %eax,0x8(%esp)
  d6:	a1 30 09 00 00       	mov    0x930,%eax
  db:	89 04 24             	mov    %eax,(%esp)
  de:	e8 ad 04 00 00       	call   590 <printf>
  // corresponding system call.
  return 0;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
  e3:	a1 30 09 00 00       	mov    0x930,%eax
  e8:	c7 44 24 08 98 08 00 	movl   $0x898,0x8(%esp)
  ef:	00 
  f0:	c7 44 24 04 65 08 00 	movl   $0x865,0x4(%esp)
  f7:	00 
  f8:	89 04 24             	mov    %eax,(%esp)
  fb:	e8 90 04 00 00       	call   590 <printf>
  exit();
 100:	e8 33 03 00 00       	call   438 <exit>
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
 126:	a1 30 09 00 00       	mov    0x930,%eax
 12b:	c7 44 24 08 b0 08 00 	movl   $0x8b0,0x8(%esp)
 132:	00 
 133:	c7 44 24 04 65 08 00 	movl   $0x865,0x4(%esp)
 13a:	00 
 13b:	89 04 24             	mov    %eax,(%esp)
 13e:	e8 4d 04 00 00       	call   590 <printf>
  exit();
 143:	e8 f0 02 00 00       	call   438 <exit>
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
 166:	a1 30 09 00 00       	mov    0x930,%eax
 16b:	c7 44 24 08 c8 08 00 	movl   $0x8c8,0x8(%esp)
 172:	00 
 173:	c7 44 24 04 65 08 00 	movl   $0x865,0x4(%esp)
 17a:	00 
 17b:	89 04 24             	mov    %eax,(%esp)
 17e:	e8 0d 04 00 00       	call   590 <printf>
  exit();
 183:	e8 b0 02 00 00       	call   438 <exit>
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
 1a7:	a1 30 09 00 00       	mov    0x930,%eax
 1ac:	c7 44 24 08 de 08 00 	movl   $0x8de,0x8(%esp)
 1b3:	00 
 1b4:	c7 44 24 04 65 08 00 	movl   $0x865,0x4(%esp)
 1bb:	00 
 1bc:	89 04 24             	mov    %eax,(%esp)
 1bf:	e8 cc 03 00 00       	call   590 <printf>
  exit();
 1c4:	e8 6f 02 00 00       	call   438 <exit>
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
 1ed:	51                   	push   %ecx
 1ee:	83 ec 14             	sub    $0x14,%esp
  
  ret = startrecording();
  if (ret == -1)
    handle_error("error startrecording");

  printf(stderr, "test\n");
 1f1:	a1 30 09 00 00       	mov    0x930,%eax
 1f6:	c7 44 24 04 f5 08 00 	movl   $0x8f5,0x4(%esp)
 1fd:	00 
 1fe:	89 04 24             	mov    %eax,(%esp)
 201:	e8 8a 03 00 00       	call   590 <printf>
  // corresponding system call.
  return 0;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 206:	a1 30 09 00 00       	mov    0x930,%eax
 20b:	c7 44 24 08 fb 08 00 	movl   $0x8fb,0x8(%esp)
 212:	00 
 213:	c7 44 24 04 65 08 00 	movl   $0x865,0x4(%esp)
 21a:	00 
 21b:	89 04 24             	mov    %eax,(%esp)
 21e:	e8 6d 03 00 00       	call   590 <printf>
  exit();
 223:	e8 10 02 00 00       	call   438 <exit>
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
 4d8:	90                   	nop    
 4d9:	90                   	nop    
 4da:	90                   	nop    
 4db:	90                   	nop    
 4dc:	90                   	nop    
 4dd:	90                   	nop    
 4de:	90                   	nop    
 4df:	90                   	nop    

000004e0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	83 ec 18             	sub    $0x18,%esp
 4e6:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 4e9:	8d 55 fc             	lea    -0x4(%ebp),%edx
 4ec:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4f3:	00 
 4f4:	89 54 24 04          	mov    %edx,0x4(%esp)
 4f8:	89 04 24             	mov    %eax,(%esp)
 4fb:	e8 58 ff ff ff       	call   458 <write>
}
 500:	c9                   	leave  
 501:	c3                   	ret    
 502:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 509:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000510 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	57                   	push   %edi
 514:	56                   	push   %esi
 515:	89 ce                	mov    %ecx,%esi
 517:	53                   	push   %ebx
 518:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 51b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 51e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 521:	85 c9                	test   %ecx,%ecx
 523:	74 04                	je     529 <printint+0x19>
 525:	85 d2                	test   %edx,%edx
 527:	78 54                	js     57d <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 529:	89 d0                	mov    %edx,%eax
 52b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 532:	31 db                	xor    %ebx,%ebx
 534:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 537:	31 d2                	xor    %edx,%edx
 539:	f7 f6                	div    %esi
 53b:	89 c1                	mov    %eax,%ecx
 53d:	0f b6 82 19 09 00 00 	movzbl 0x919(%edx),%eax
 544:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 547:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 54a:	85 c9                	test   %ecx,%ecx
 54c:	89 c8                	mov    %ecx,%eax
 54e:	75 e7                	jne    537 <printint+0x27>
  if(neg)
 550:	8b 45 e0             	mov    -0x20(%ebp),%eax
 553:	85 c0                	test   %eax,%eax
 555:	74 08                	je     55f <printint+0x4f>
    buf[i++] = '-';
 557:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 55c:	83 c3 01             	add    $0x1,%ebx
 55f:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 562:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 566:	83 eb 01             	sub    $0x1,%ebx
 569:	8b 45 dc             	mov    -0x24(%ebp),%eax
 56c:	e8 6f ff ff ff       	call   4e0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 571:	39 fb                	cmp    %edi,%ebx
 573:	75 ed                	jne    562 <printint+0x52>
    putc(fd, buf[i]);
}
 575:	83 c4 1c             	add    $0x1c,%esp
 578:	5b                   	pop    %ebx
 579:	5e                   	pop    %esi
 57a:	5f                   	pop    %edi
 57b:	5d                   	pop    %ebp
 57c:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 57d:	89 d0                	mov    %edx,%eax
 57f:	f7 d8                	neg    %eax
 581:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 588:	eb a8                	jmp    532 <printint+0x22>
 58a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000590 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	57                   	push   %edi
 594:	56                   	push   %esi
 595:	53                   	push   %ebx
 596:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 599:	8b 55 0c             	mov    0xc(%ebp),%edx
 59c:	0f b6 02             	movzbl (%edx),%eax
 59f:	84 c0                	test   %al,%al
 5a1:	0f 84 87 00 00 00    	je     62e <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 5a7:	8d 4d 10             	lea    0x10(%ebp),%ecx
 5aa:	31 ff                	xor    %edi,%edi
 5ac:	31 f6                	xor    %esi,%esi
 5ae:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 5b1:	eb 18                	jmp    5cb <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5b3:	83 fb 25             	cmp    $0x25,%ebx
 5b6:	0f 85 7a 00 00 00    	jne    636 <printf+0xa6>
 5bc:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5c0:	83 c7 01             	add    $0x1,%edi
 5c3:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 5c7:	84 c0                	test   %al,%al
 5c9:	74 63                	je     62e <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 5cb:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 5cd:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 5d0:	74 e1                	je     5b3 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5d2:	83 fe 25             	cmp    $0x25,%esi
 5d5:	75 e9                	jne    5c0 <printf+0x30>
      if(c == 'd'){
 5d7:	83 fb 64             	cmp    $0x64,%ebx
 5da:	0f 84 f0 00 00 00    	je     6d0 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5e0:	83 fb 78             	cmp    $0x78,%ebx
 5e3:	74 64                	je     649 <printf+0xb9>
 5e5:	83 fb 70             	cmp    $0x70,%ebx
 5e8:	74 5f                	je     649 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5ea:	83 fb 73             	cmp    $0x73,%ebx
 5ed:	8d 76 00             	lea    0x0(%esi),%esi
 5f0:	74 7e                	je     670 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5f2:	83 fb 63             	cmp    $0x63,%ebx
 5f5:	0f 84 b9 00 00 00    	je     6b4 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5fb:	83 fb 25             	cmp    $0x25,%ebx
 5fe:	66 90                	xchg   %ax,%ax
 600:	0f 84 f2 00 00 00    	je     6f8 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 606:	8b 45 08             	mov    0x8(%ebp),%eax
 609:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 60e:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 611:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 613:	e8 c8 fe ff ff       	call   4e0 <putc>
        putc(fd, c);
 618:	8b 45 08             	mov    0x8(%ebp),%eax
 61b:	0f be d3             	movsbl %bl,%edx
 61e:	e8 bd fe ff ff       	call   4e0 <putc>
 623:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 626:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 62a:	84 c0                	test   %al,%al
 62c:	75 9d                	jne    5cb <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 62e:	83 c4 0c             	add    $0xc,%esp
 631:	5b                   	pop    %ebx
 632:	5e                   	pop    %esi
 633:	5f                   	pop    %edi
 634:	5d                   	pop    %ebp
 635:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 636:	8b 45 08             	mov    0x8(%ebp),%eax
 639:	0f be d3             	movsbl %bl,%edx
 63c:	e8 9f fe ff ff       	call   4e0 <putc>
 641:	8b 55 0c             	mov    0xc(%ebp),%edx
 644:	e9 77 ff ff ff       	jmp    5c0 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 649:	8b 45 f0             	mov    -0x10(%ebp),%eax
 64c:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 651:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 653:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 65a:	8b 10                	mov    (%eax),%edx
 65c:	8b 45 08             	mov    0x8(%ebp),%eax
 65f:	e8 ac fe ff ff       	call   510 <printint>
 664:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 667:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 66b:	e9 50 ff ff ff       	jmp    5c0 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 670:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 673:	8b 01                	mov    (%ecx),%eax
        ap++;
 675:	83 c1 04             	add    $0x4,%ecx
 678:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 67b:	b9 12 09 00 00       	mov    $0x912,%ecx
 680:	85 c0                	test   %eax,%eax
 682:	75 2c                	jne    6b0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 684:	0f b6 01             	movzbl (%ecx),%eax
 687:	84 c0                	test   %al,%al
 689:	74 1e                	je     6a9 <printf+0x119>
 68b:	89 cb                	mov    %ecx,%ebx
 68d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 690:	0f be d0             	movsbl %al,%edx
 693:	8b 45 08             	mov    0x8(%ebp),%eax
 696:	e8 45 fe ff ff       	call   4e0 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 69b:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 69f:	83 c3 01             	add    $0x1,%ebx
 6a2:	84 c0                	test   %al,%al
 6a4:	75 ea                	jne    690 <printf+0x100>
 6a6:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 6a9:	31 f6                	xor    %esi,%esi
 6ab:	e9 10 ff ff ff       	jmp    5c0 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 6b0:	89 c1                	mov    %eax,%ecx
 6b2:	eb d0                	jmp    684 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 6b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 6b7:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 6b9:	0f be 10             	movsbl (%eax),%edx
 6bc:	8b 45 08             	mov    0x8(%ebp),%eax
 6bf:	e8 1c fe ff ff       	call   4e0 <putc>
 6c4:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 6c7:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 6cb:	e9 f0 fe ff ff       	jmp    5c0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 6d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 6d8:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 6db:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 6e2:	8b 10                	mov    (%eax),%edx
 6e4:	8b 45 08             	mov    0x8(%ebp),%eax
 6e7:	e8 24 fe ff ff       	call   510 <printint>
 6ec:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 6ef:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 6f3:	e9 c8 fe ff ff       	jmp    5c0 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 6f8:	8b 45 08             	mov    0x8(%ebp),%eax
 6fb:	ba 25 00 00 00       	mov    $0x25,%edx
 700:	31 f6                	xor    %esi,%esi
 702:	e8 d9 fd ff ff       	call   4e0 <putc>
 707:	8b 55 0c             	mov    0xc(%ebp),%edx
 70a:	e9 b1 fe ff ff       	jmp    5c0 <printf+0x30>
 70f:	90                   	nop    

00000710 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 710:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 711:	8b 0d 3c 09 00 00    	mov    0x93c,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 717:	89 e5                	mov    %esp,%ebp
 719:	56                   	push   %esi
 71a:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 71b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 71e:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 721:	39 d9                	cmp    %ebx,%ecx
 723:	73 18                	jae    73d <free+0x2d>
 725:	8b 11                	mov    (%ecx),%edx
 727:	39 d3                	cmp    %edx,%ebx
 729:	72 17                	jb     742 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 72b:	39 d1                	cmp    %edx,%ecx
 72d:	72 08                	jb     737 <free+0x27>
 72f:	39 d9                	cmp    %ebx,%ecx
 731:	72 0f                	jb     742 <free+0x32>
 733:	39 d3                	cmp    %edx,%ebx
 735:	72 0b                	jb     742 <free+0x32>
 737:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 739:	39 d9                	cmp    %ebx,%ecx
 73b:	72 e8                	jb     725 <free+0x15>
 73d:	8b 11                	mov    (%ecx),%edx
 73f:	90                   	nop    
 740:	eb e9                	jmp    72b <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 742:	8b 73 04             	mov    0x4(%ebx),%esi
 745:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 748:	39 d0                	cmp    %edx,%eax
 74a:	74 18                	je     764 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 74c:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 74e:	8b 51 04             	mov    0x4(%ecx),%edx
 751:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 754:	39 d8                	cmp    %ebx,%eax
 756:	74 20                	je     778 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 758:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 75a:	5b                   	pop    %ebx
 75b:	5e                   	pop    %esi
 75c:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 75d:	89 0d 3c 09 00 00    	mov    %ecx,0x93c
}
 763:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 764:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 767:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 769:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 76c:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 76f:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 771:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 774:	39 d8                	cmp    %ebx,%eax
 776:	75 e0                	jne    758 <free+0x48>
    p->s.size += bp->s.size;
 778:	03 53 04             	add    0x4(%ebx),%edx
 77b:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 77e:	8b 13                	mov    (%ebx),%edx
 780:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 782:	5b                   	pop    %ebx
 783:	5e                   	pop    %esi
 784:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 785:	89 0d 3c 09 00 00    	mov    %ecx,0x93c
}
 78b:	c3                   	ret    
 78c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000790 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 790:	55                   	push   %ebp
 791:	89 e5                	mov    %esp,%ebp
 793:	57                   	push   %edi
 794:	56                   	push   %esi
 795:	53                   	push   %ebx
 796:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 799:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 79c:	8b 15 3c 09 00 00    	mov    0x93c,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a2:	83 c0 07             	add    $0x7,%eax
 7a5:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 7a8:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7aa:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 7ad:	0f 84 8a 00 00 00    	je     83d <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7b3:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 7b5:	8b 41 04             	mov    0x4(%ecx),%eax
 7b8:	39 c3                	cmp    %eax,%ebx
 7ba:	76 1a                	jbe    7d6 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 7bc:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 7c3:	3b 0d 3c 09 00 00    	cmp    0x93c,%ecx
 7c9:	89 ca                	mov    %ecx,%edx
 7cb:	74 29                	je     7f6 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7cd:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 7cf:	8b 41 04             	mov    0x4(%ecx),%eax
 7d2:	39 c3                	cmp    %eax,%ebx
 7d4:	77 ed                	ja     7c3 <malloc+0x33>
      if(p->s.size == nunits)
 7d6:	39 c3                	cmp    %eax,%ebx
 7d8:	74 5d                	je     837 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 7da:	29 d8                	sub    %ebx,%eax
 7dc:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 7df:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 7e2:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 7e5:	89 15 3c 09 00 00    	mov    %edx,0x93c
      return (void*) (p + 1);
 7eb:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7ee:	83 c4 0c             	add    $0xc,%esp
 7f1:	5b                   	pop    %ebx
 7f2:	5e                   	pop    %esi
 7f3:	5f                   	pop    %edi
 7f4:	5d                   	pop    %ebp
 7f5:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 7f6:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 7fc:	89 de                	mov    %ebx,%esi
 7fe:	89 f8                	mov    %edi,%eax
 800:	76 29                	jbe    82b <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 802:	89 04 24             	mov    %eax,(%esp)
 805:	e8 b6 fc ff ff       	call   4c0 <sbrk>
  if(p == (char*) -1)
 80a:	83 f8 ff             	cmp    $0xffffffff,%eax
 80d:	74 18                	je     827 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 80f:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 812:	83 c0 08             	add    $0x8,%eax
 815:	89 04 24             	mov    %eax,(%esp)
 818:	e8 f3 fe ff ff       	call   710 <free>
  return freep;
 81d:	8b 15 3c 09 00 00    	mov    0x93c,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 823:	85 d2                	test   %edx,%edx
 825:	75 a6                	jne    7cd <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 827:	31 c0                	xor    %eax,%eax
 829:	eb c3                	jmp    7ee <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 82b:	be 00 10 00 00       	mov    $0x1000,%esi
 830:	b8 00 80 00 00       	mov    $0x8000,%eax
 835:	eb cb                	jmp    802 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 837:	8b 01                	mov    (%ecx),%eax
 839:	89 02                	mov    %eax,(%edx)
 83b:	eb a8                	jmp    7e5 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 83d:	ba 34 09 00 00       	mov    $0x934,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 842:	c7 05 3c 09 00 00 34 	movl   $0x934,0x93c
 849:	09 00 00 
 84c:	c7 05 34 09 00 00 34 	movl   $0x934,0x934
 853:	09 00 00 
    base.s.size = 0;
 856:	c7 05 38 09 00 00 00 	movl   $0x0,0x938
 85d:	00 00 00 
 860:	e9 4e ff ff ff       	jmp    7b3 <malloc+0x23>
