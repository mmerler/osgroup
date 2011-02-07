
_hw2-test-invalid:     file format elf32-i386

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
  39:	c7 44 24 04 58 08 00 	movl   $0x858,0x4(%esp)
  40:	00 
  41:	89 44 24 08          	mov    %eax,0x8(%esp)
  45:	a1 2c 09 00 00       	mov    0x92c,%eax
  4a:	89 04 24             	mov    %eax,(%esp)
  4d:	e8 2e 05 00 00       	call   580 <printf>
  exit();
  52:	e8 d1 03 00 00       	call   428 <exit>
  57:	89 f6                	mov    %esi,%esi
  59:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000060 <check_ret_value>:
inline void check_syscall_no(const struct record *r, int n) {
  if (r->type != SYSCALL_NO || r->value.intval != n)
    handle_error("error check_syscall_no");
}

inline void check_ret_value(const struct record *r, int v) {
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	83 ec 18             	sub    $0x18,%esp
  66:	8b 45 08             	mov    0x8(%ebp),%eax
  if (r->type != RET_VALUE || r->value.intval != v)
  69:	83 38 04             	cmpl   $0x4,(%eax)
  6c:	75 08                	jne    76 <check_ret_value+0x16>
  6e:	8b 55 0c             	mov    0xc(%ebp),%edx
  71:	39 50 04             	cmp    %edx,0x4(%eax)
  74:	74 22                	je     98 <check_ret_value+0x38>
  // corresponding system call.
  return 0;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
  76:	a1 2c 09 00 00       	mov    0x92c,%eax
  7b:	c7 44 24 08 5c 08 00 	movl   $0x85c,0x8(%esp)
  82:	00 
  83:	c7 44 24 04 58 08 00 	movl   $0x858,0x4(%esp)
  8a:	00 
  8b:	89 04 24             	mov    %eax,(%esp)
  8e:	e8 ed 04 00 00       	call   580 <printf>
  exit();
  93:	e8 90 03 00 00       	call   428 <exit>
}

inline void check_ret_value(const struct record *r, int v) {
  if (r->type != RET_VALUE || r->value.intval != v)
    handle_error("error check_ret_value");
}
  98:	c9                   	leave  
  99:	c3                   	ret    
  9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000000a0 <check_syscall_no>:
inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
  exit();
}

inline void check_syscall_no(const struct record *r, int n) {
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	83 ec 18             	sub    $0x18,%esp
  a6:	8b 45 08             	mov    0x8(%ebp),%eax
  if (r->type != SYSCALL_NO || r->value.intval != n)
  a9:	8b 10                	mov    (%eax),%edx
  ab:	85 d2                	test   %edx,%edx
  ad:	75 08                	jne    b7 <check_syscall_no+0x17>
  af:	8b 55 0c             	mov    0xc(%ebp),%edx
  b2:	39 50 04             	cmp    %edx,0x4(%eax)
  b5:	74 29                	je     e0 <check_syscall_no+0x40>
  // corresponding system call.
  return 0;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
  b7:	a1 2c 09 00 00       	mov    0x92c,%eax
  bc:	c7 44 24 08 72 08 00 	movl   $0x872,0x8(%esp)
  c3:	00 
  c4:	c7 44 24 04 58 08 00 	movl   $0x858,0x4(%esp)
  cb:	00 
  cc:	89 04 24             	mov    %eax,(%esp)
  cf:	e8 ac 04 00 00       	call   580 <printf>
  exit();
  d4:	e8 4f 03 00 00       	call   428 <exit>
  d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
}

inline void check_syscall_no(const struct record *r, int n) {
  if (r->type != SYSCALL_NO || r->value.intval != n)
    handle_error("error check_syscall_no");
}
  e0:	c9                   	leave  
  e1:	c3                   	ret    
  e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000000f0 <main>:
#include "record.h"
#include "fcntl.h"
#include "syscall.h"
#include "hw2-common.h"

int main(int argc, char *argv[]) {
  f0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  f4:	83 e4 f0             	and    $0xfffffff0,%esp
  f7:	ff 71 fc             	pushl  -0x4(%ecx)
  fa:	55                   	push   %ebp
  fb:	89 e5                	mov    %esp,%ebp
  fd:	51                   	push   %ecx
  fe:	83 ec 14             	sub    $0x14,%esp
  // corresponding system call.
  return 0;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 101:	a1 2c 09 00 00       	mov    0x92c,%eax
 106:	c7 44 24 08 e8 08 00 	movl   $0x8e8,0x8(%esp)
 10d:	00 
 10e:	c7 44 24 04 58 08 00 	movl   $0x858,0x4(%esp)
 115:	00 
 116:	89 04 24             	mov    %eax,(%esp)
 119:	e8 62 04 00 00       	call   580 <printf>
  exit();
 11e:	e8 05 03 00 00       	call   428 <exit>
 123:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 129:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000130 <check_arg_string>:
    printf(stderr, "actual %p, expected %p\n", r->value.ptrval, p);
    handle_error("error check_arg_pointer");
  }
}

inline void check_arg_string(const struct record *r, char *s) {
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	83 ec 18             	sub    $0x18,%esp
 136:	8b 45 08             	mov    0x8(%ebp),%eax
  if (r->type != ARG_STRING || strcmp(r->value.strval, s) != 0)
 139:	83 38 03             	cmpl   $0x3,(%eax)
 13c:	75 16                	jne    154 <check_arg_string+0x24>
 13e:	8b 55 0c             	mov    0xc(%ebp),%edx
 141:	83 c0 04             	add    $0x4,%eax
 144:	89 04 24             	mov    %eax,(%esp)
 147:	89 54 24 04          	mov    %edx,0x4(%esp)
 14b:	e8 00 01 00 00       	call   250 <strcmp>
 150:	85 c0                	test   %eax,%eax
 152:	74 22                	je     176 <check_arg_string+0x46>
  // corresponding system call.
  return 0;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 154:	a1 2c 09 00 00       	mov    0x92c,%eax
 159:	c7 44 24 08 89 08 00 	movl   $0x889,0x8(%esp)
 160:	00 
 161:	c7 44 24 04 58 08 00 	movl   $0x858,0x4(%esp)
 168:	00 
 169:	89 04 24             	mov    %eax,(%esp)
 16c:	e8 0f 04 00 00       	call   580 <printf>
  exit();
 171:	e8 b2 02 00 00       	call   428 <exit>
}

inline void check_arg_string(const struct record *r, char *s) {
  if (r->type != ARG_STRING || strcmp(r->value.strval, s) != 0)
    handle_error("error check_arg_string");
}
 176:	c9                   	leave  
 177:	c3                   	ret    
 178:	90                   	nop    
 179:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000180 <check_arg_pointer>:
inline void check_arg_integer(const struct record *r, int v) {
  if (r->type != ARG_INTEGER || r->value.intval != v)
    handle_error("error check_arg_integer");
}

inline void check_arg_pointer(const struct record *r, void *p) {
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	83 ec 18             	sub    $0x18,%esp
 186:	8b 45 08             	mov    0x8(%ebp),%eax
  // Pointer values differs form machine to machine. 
  // Do not count on it. 
  if (r->type != ARG_POINTER/* || r->value.ptrval != p */) {
 189:	83 38 02             	cmpl   $0x2,(%eax)
 18c:	75 02                	jne    190 <check_arg_pointer+0x10>
    printf(stderr, "actual %p, expected %p\n", r->value.ptrval, p);
    handle_error("error check_arg_pointer");
  }
}
 18e:	c9                   	leave  
 18f:	c3                   	ret    

inline void check_arg_pointer(const struct record *r, void *p) {
  // Pointer values differs form machine to machine. 
  // Do not count on it. 
  if (r->type != ARG_POINTER/* || r->value.ptrval != p */) {
    printf(stderr, "actual %p, expected %p\n", r->value.ptrval, p);
 190:	8b 55 0c             	mov    0xc(%ebp),%edx
 193:	89 54 24 0c          	mov    %edx,0xc(%esp)
 197:	8b 40 04             	mov    0x4(%eax),%eax
 19a:	c7 44 24 04 a0 08 00 	movl   $0x8a0,0x4(%esp)
 1a1:	00 
 1a2:	89 44 24 08          	mov    %eax,0x8(%esp)
 1a6:	a1 2c 09 00 00       	mov    0x92c,%eax
 1ab:	89 04 24             	mov    %eax,(%esp)
 1ae:	e8 cd 03 00 00       	call   580 <printf>
  // corresponding system call.
  return 0;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 1b3:	a1 2c 09 00 00       	mov    0x92c,%eax
 1b8:	c7 44 24 08 b8 08 00 	movl   $0x8b8,0x8(%esp)
 1bf:	00 
 1c0:	c7 44 24 04 58 08 00 	movl   $0x858,0x4(%esp)
 1c7:	00 
 1c8:	89 04 24             	mov    %eax,(%esp)
 1cb:	e8 b0 03 00 00       	call   580 <printf>
  exit();
 1d0:	e8 53 02 00 00       	call   428 <exit>
 1d5:	8d 74 26 00          	lea    0x0(%esi),%esi
 1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000001e0 <check_arg_integer>:
inline void check_ret_value(const struct record *r, int v) {
  if (r->type != RET_VALUE || r->value.intval != v)
    handle_error("error check_ret_value");
}

inline void check_arg_integer(const struct record *r, int v) {
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	83 ec 18             	sub    $0x18,%esp
 1e6:	8b 45 08             	mov    0x8(%ebp),%eax
  if (r->type != ARG_INTEGER || r->value.intval != v)
 1e9:	83 38 01             	cmpl   $0x1,(%eax)
 1ec:	75 08                	jne    1f6 <check_arg_integer+0x16>
 1ee:	8b 55 0c             	mov    0xc(%ebp),%edx
 1f1:	39 50 04             	cmp    %edx,0x4(%eax)
 1f4:	74 22                	je     218 <check_arg_integer+0x38>
  // corresponding system call.
  return 0;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 1f6:	a1 2c 09 00 00       	mov    0x92c,%eax
 1fb:	c7 44 24 08 d0 08 00 	movl   $0x8d0,0x8(%esp)
 202:	00 
 203:	c7 44 24 04 58 08 00 	movl   $0x858,0x4(%esp)
 20a:	00 
 20b:	89 04 24             	mov    %eax,(%esp)
 20e:	e8 6d 03 00 00       	call   580 <printf>
  exit();
 213:	e8 10 02 00 00       	call   428 <exit>
}

inline void check_arg_integer(const struct record *r, int v) {
  if (r->type != ARG_INTEGER || r->value.intval != v)
    handle_error("error check_arg_integer");
}
 218:	c9                   	leave  
 219:	c3                   	ret    
 21a:	90                   	nop    
 21b:	90                   	nop    
 21c:	90                   	nop    
 21d:	90                   	nop    
 21e:	90                   	nop    
 21f:	90                   	nop    

00000220 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	53                   	push   %ebx
 224:	8b 5d 08             	mov    0x8(%ebp),%ebx
 227:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 22a:	89 da                	mov    %ebx,%edx
 22c:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 230:	0f b6 01             	movzbl (%ecx),%eax
 233:	83 c1 01             	add    $0x1,%ecx
 236:	88 02                	mov    %al,(%edx)
 238:	83 c2 01             	add    $0x1,%edx
 23b:	84 c0                	test   %al,%al
 23d:	75 f1                	jne    230 <strcpy+0x10>
    ;
  return os;
}
 23f:	89 d8                	mov    %ebx,%eax
 241:	5b                   	pop    %ebx
 242:	5d                   	pop    %ebp
 243:	c3                   	ret    
 244:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 24a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000250 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	8b 4d 08             	mov    0x8(%ebp),%ecx
 256:	53                   	push   %ebx
 257:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 25a:	0f b6 01             	movzbl (%ecx),%eax
 25d:	84 c0                	test   %al,%al
 25f:	74 24                	je     285 <strcmp+0x35>
 261:	0f b6 13             	movzbl (%ebx),%edx
 264:	38 d0                	cmp    %dl,%al
 266:	74 12                	je     27a <strcmp+0x2a>
 268:	eb 1e                	jmp    288 <strcmp+0x38>
 26a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 270:	0f b6 13             	movzbl (%ebx),%edx
 273:	83 c1 01             	add    $0x1,%ecx
 276:	38 d0                	cmp    %dl,%al
 278:	75 0e                	jne    288 <strcmp+0x38>
 27a:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 27e:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 281:	84 c0                	test   %al,%al
 283:	75 eb                	jne    270 <strcmp+0x20>
 285:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 288:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 289:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 28c:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 28d:	0f b6 d2             	movzbl %dl,%edx
 290:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 292:	c3                   	ret    
 293:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 299:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000002a0 <strlen>:

uint
strlen(char *s)
{
 2a0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 2a1:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 2a3:	89 e5                	mov    %esp,%ebp
 2a5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 2a8:	80 39 00             	cmpb   $0x0,(%ecx)
 2ab:	74 0e                	je     2bb <strlen+0x1b>
 2ad:	31 d2                	xor    %edx,%edx
 2af:	90                   	nop    
 2b0:	83 c2 01             	add    $0x1,%edx
 2b3:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
 2b7:	89 d0                	mov    %edx,%eax
 2b9:	75 f5                	jne    2b0 <strlen+0x10>
    ;
  return n;
}
 2bb:	5d                   	pop    %ebp
 2bc:	c3                   	ret    
 2bd:	8d 76 00             	lea    0x0(%esi),%esi

000002c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	8b 55 08             	mov    0x8(%ebp),%edx
 2c6:	57                   	push   %edi
 2c7:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ca:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 2cd:	89 d7                	mov    %edx,%edi
 2cf:	fc                   	cld    
 2d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 2d2:	5f                   	pop    %edi
 2d3:	89 d0                	mov    %edx,%eax
 2d5:	5d                   	pop    %ebp
 2d6:	c3                   	ret    
 2d7:	89 f6                	mov    %esi,%esi
 2d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000002e0 <strchr>:

char*
strchr(const char *s, char c)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	8b 45 08             	mov    0x8(%ebp),%eax
 2e6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 2ea:	0f b6 10             	movzbl (%eax),%edx
 2ed:	84 d2                	test   %dl,%dl
 2ef:	75 0c                	jne    2fd <strchr+0x1d>
 2f1:	eb 11                	jmp    304 <strchr+0x24>
 2f3:	83 c0 01             	add    $0x1,%eax
 2f6:	0f b6 10             	movzbl (%eax),%edx
 2f9:	84 d2                	test   %dl,%dl
 2fb:	74 07                	je     304 <strchr+0x24>
    if(*s == c)
 2fd:	38 ca                	cmp    %cl,%dl
 2ff:	90                   	nop    
 300:	75 f1                	jne    2f3 <strchr+0x13>
      return (char*) s;
  return 0;
}
 302:	5d                   	pop    %ebp
 303:	c3                   	ret    
 304:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 305:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 307:	c3                   	ret    
 308:	90                   	nop    
 309:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000310 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	8b 4d 08             	mov    0x8(%ebp),%ecx
 316:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 317:	31 db                	xor    %ebx,%ebx
 319:	0f b6 11             	movzbl (%ecx),%edx
 31c:	8d 42 d0             	lea    -0x30(%edx),%eax
 31f:	3c 09                	cmp    $0x9,%al
 321:	77 18                	ja     33b <atoi+0x2b>
    n = n*10 + *s++ - '0';
 323:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 326:	0f be d2             	movsbl %dl,%edx
 329:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 32d:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 331:	83 c1 01             	add    $0x1,%ecx
 334:	8d 42 d0             	lea    -0x30(%edx),%eax
 337:	3c 09                	cmp    $0x9,%al
 339:	76 e8                	jbe    323 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 33b:	89 d8                	mov    %ebx,%eax
 33d:	5b                   	pop    %ebx
 33e:	5d                   	pop    %ebp
 33f:	c3                   	ret    

00000340 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	8b 4d 10             	mov    0x10(%ebp),%ecx
 346:	56                   	push   %esi
 347:	8b 75 08             	mov    0x8(%ebp),%esi
 34a:	53                   	push   %ebx
 34b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 34e:	85 c9                	test   %ecx,%ecx
 350:	7e 10                	jle    362 <memmove+0x22>
 352:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 354:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 358:	88 04 32             	mov    %al,(%edx,%esi,1)
 35b:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 35e:	39 ca                	cmp    %ecx,%edx
 360:	75 f2                	jne    354 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 362:	89 f0                	mov    %esi,%eax
 364:	5b                   	pop    %ebx
 365:	5e                   	pop    %esi
 366:	5d                   	pop    %ebp
 367:	c3                   	ret    
 368:	90                   	nop    
 369:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000370 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 376:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 379:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 37c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 37f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 384:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 38b:	00 
 38c:	89 04 24             	mov    %eax,(%esp)
 38f:	e8 d4 00 00 00       	call   468 <open>
  if(fd < 0)
 394:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 396:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 398:	78 19                	js     3b3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 39a:	8b 45 0c             	mov    0xc(%ebp),%eax
 39d:	89 1c 24             	mov    %ebx,(%esp)
 3a0:	89 44 24 04          	mov    %eax,0x4(%esp)
 3a4:	e8 d7 00 00 00       	call   480 <fstat>
  close(fd);
 3a9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 3ac:	89 c6                	mov    %eax,%esi
  close(fd);
 3ae:	e8 9d 00 00 00       	call   450 <close>
  return r;
}
 3b3:	89 f0                	mov    %esi,%eax
 3b5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 3b8:	8b 75 fc             	mov    -0x4(%ebp),%esi
 3bb:	89 ec                	mov    %ebp,%esp
 3bd:	5d                   	pop    %ebp
 3be:	c3                   	ret    
 3bf:	90                   	nop    

000003c0 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	57                   	push   %edi
 3c4:	56                   	push   %esi
 3c5:	31 f6                	xor    %esi,%esi
 3c7:	53                   	push   %ebx
 3c8:	83 ec 1c             	sub    $0x1c,%esp
 3cb:	8b 7d 08             	mov    0x8(%ebp),%edi
 3ce:	eb 06                	jmp    3d6 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3d0:	3c 0d                	cmp    $0xd,%al
 3d2:	74 39                	je     40d <gets+0x4d>
 3d4:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3d6:	8d 5e 01             	lea    0x1(%esi),%ebx
 3d9:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3dc:	7d 31                	jge    40f <gets+0x4f>
    cc = read(0, &c, 1);
 3de:	8d 45 f3             	lea    -0xd(%ebp),%eax
 3e1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3e8:	00 
 3e9:	89 44 24 04          	mov    %eax,0x4(%esp)
 3ed:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 3f4:	e8 47 00 00 00       	call   440 <read>
    if(cc < 1)
 3f9:	85 c0                	test   %eax,%eax
 3fb:	7e 12                	jle    40f <gets+0x4f>
      break;
    buf[i++] = c;
 3fd:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 401:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 405:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 409:	3c 0a                	cmp    $0xa,%al
 40b:	75 c3                	jne    3d0 <gets+0x10>
 40d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 40f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 413:	89 f8                	mov    %edi,%eax
 415:	83 c4 1c             	add    $0x1c,%esp
 418:	5b                   	pop    %ebx
 419:	5e                   	pop    %esi
 41a:	5f                   	pop    %edi
 41b:	5d                   	pop    %ebp
 41c:	c3                   	ret    
 41d:	90                   	nop    
 41e:	90                   	nop    
 41f:	90                   	nop    

00000420 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 420:	b8 01 00 00 00       	mov    $0x1,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <exit>:
SYSCALL(exit)
 428:	b8 02 00 00 00       	mov    $0x2,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <wait>:
SYSCALL(wait)
 430:	b8 03 00 00 00       	mov    $0x3,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    

00000438 <pipe>:
SYSCALL(pipe)
 438:	b8 04 00 00 00       	mov    $0x4,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <read>:
SYSCALL(read)
 440:	b8 06 00 00 00       	mov    $0x6,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <write>:
SYSCALL(write)
 448:	b8 05 00 00 00       	mov    $0x5,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <close>:
SYSCALL(close)
 450:	b8 07 00 00 00       	mov    $0x7,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    

00000458 <kill>:
SYSCALL(kill)
 458:	b8 08 00 00 00       	mov    $0x8,%eax
 45d:	cd 40                	int    $0x40
 45f:	c3                   	ret    

00000460 <exec>:
SYSCALL(exec)
 460:	b8 09 00 00 00       	mov    $0x9,%eax
 465:	cd 40                	int    $0x40
 467:	c3                   	ret    

00000468 <open>:
SYSCALL(open)
 468:	b8 0a 00 00 00       	mov    $0xa,%eax
 46d:	cd 40                	int    $0x40
 46f:	c3                   	ret    

00000470 <mknod>:
SYSCALL(mknod)
 470:	b8 0b 00 00 00       	mov    $0xb,%eax
 475:	cd 40                	int    $0x40
 477:	c3                   	ret    

00000478 <unlink>:
SYSCALL(unlink)
 478:	b8 0c 00 00 00       	mov    $0xc,%eax
 47d:	cd 40                	int    $0x40
 47f:	c3                   	ret    

00000480 <fstat>:
SYSCALL(fstat)
 480:	b8 0d 00 00 00       	mov    $0xd,%eax
 485:	cd 40                	int    $0x40
 487:	c3                   	ret    

00000488 <link>:
SYSCALL(link)
 488:	b8 0e 00 00 00       	mov    $0xe,%eax
 48d:	cd 40                	int    $0x40
 48f:	c3                   	ret    

00000490 <mkdir>:
SYSCALL(mkdir)
 490:	b8 0f 00 00 00       	mov    $0xf,%eax
 495:	cd 40                	int    $0x40
 497:	c3                   	ret    

00000498 <chdir>:
SYSCALL(chdir)
 498:	b8 10 00 00 00       	mov    $0x10,%eax
 49d:	cd 40                	int    $0x40
 49f:	c3                   	ret    

000004a0 <dup>:
SYSCALL(dup)
 4a0:	b8 11 00 00 00       	mov    $0x11,%eax
 4a5:	cd 40                	int    $0x40
 4a7:	c3                   	ret    

000004a8 <getpid>:
SYSCALL(getpid)
 4a8:	b8 12 00 00 00       	mov    $0x12,%eax
 4ad:	cd 40                	int    $0x40
 4af:	c3                   	ret    

000004b0 <sbrk>:
SYSCALL(sbrk)
 4b0:	b8 13 00 00 00       	mov    $0x13,%eax
 4b5:	cd 40                	int    $0x40
 4b7:	c3                   	ret    

000004b8 <sleep>:
SYSCALL(sleep)
 4b8:	b8 14 00 00 00       	mov    $0x14,%eax
 4bd:	cd 40                	int    $0x40
 4bf:	c3                   	ret    

000004c0 <uptime>:
SYSCALL(uptime)
 4c0:	b8 15 00 00 00       	mov    $0x15,%eax
 4c5:	cd 40                	int    $0x40
 4c7:	c3                   	ret    
 4c8:	90                   	nop    
 4c9:	90                   	nop    
 4ca:	90                   	nop    
 4cb:	90                   	nop    
 4cc:	90                   	nop    
 4cd:	90                   	nop    
 4ce:	90                   	nop    
 4cf:	90                   	nop    

000004d0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	83 ec 18             	sub    $0x18,%esp
 4d6:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 4d9:	8d 55 fc             	lea    -0x4(%ebp),%edx
 4dc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4e3:	00 
 4e4:	89 54 24 04          	mov    %edx,0x4(%esp)
 4e8:	89 04 24             	mov    %eax,(%esp)
 4eb:	e8 58 ff ff ff       	call   448 <write>
}
 4f0:	c9                   	leave  
 4f1:	c3                   	ret    
 4f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 4f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000500 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	57                   	push   %edi
 504:	56                   	push   %esi
 505:	89 ce                	mov    %ecx,%esi
 507:	53                   	push   %ebx
 508:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 50b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 50e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 511:	85 c9                	test   %ecx,%ecx
 513:	74 04                	je     519 <printint+0x19>
 515:	85 d2                	test   %edx,%edx
 517:	78 54                	js     56d <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 519:	89 d0                	mov    %edx,%eax
 51b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 522:	31 db                	xor    %ebx,%ebx
 524:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 527:	31 d2                	xor    %edx,%edx
 529:	f7 f6                	div    %esi
 52b:	89 c1                	mov    %eax,%ecx
 52d:	0f b6 82 17 09 00 00 	movzbl 0x917(%edx),%eax
 534:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 537:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 53a:	85 c9                	test   %ecx,%ecx
 53c:	89 c8                	mov    %ecx,%eax
 53e:	75 e7                	jne    527 <printint+0x27>
  if(neg)
 540:	8b 45 e0             	mov    -0x20(%ebp),%eax
 543:	85 c0                	test   %eax,%eax
 545:	74 08                	je     54f <printint+0x4f>
    buf[i++] = '-';
 547:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 54c:	83 c3 01             	add    $0x1,%ebx
 54f:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 552:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 556:	83 eb 01             	sub    $0x1,%ebx
 559:	8b 45 dc             	mov    -0x24(%ebp),%eax
 55c:	e8 6f ff ff ff       	call   4d0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 561:	39 fb                	cmp    %edi,%ebx
 563:	75 ed                	jne    552 <printint+0x52>
    putc(fd, buf[i]);
}
 565:	83 c4 1c             	add    $0x1c,%esp
 568:	5b                   	pop    %ebx
 569:	5e                   	pop    %esi
 56a:	5f                   	pop    %edi
 56b:	5d                   	pop    %ebp
 56c:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 56d:	89 d0                	mov    %edx,%eax
 56f:	f7 d8                	neg    %eax
 571:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 578:	eb a8                	jmp    522 <printint+0x22>
 57a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000580 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	57                   	push   %edi
 584:	56                   	push   %esi
 585:	53                   	push   %ebx
 586:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 589:	8b 55 0c             	mov    0xc(%ebp),%edx
 58c:	0f b6 02             	movzbl (%edx),%eax
 58f:	84 c0                	test   %al,%al
 591:	0f 84 87 00 00 00    	je     61e <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 597:	8d 4d 10             	lea    0x10(%ebp),%ecx
 59a:	31 ff                	xor    %edi,%edi
 59c:	31 f6                	xor    %esi,%esi
 59e:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 5a1:	eb 18                	jmp    5bb <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5a3:	83 fb 25             	cmp    $0x25,%ebx
 5a6:	0f 85 7a 00 00 00    	jne    626 <printf+0xa6>
 5ac:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5b0:	83 c7 01             	add    $0x1,%edi
 5b3:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 5b7:	84 c0                	test   %al,%al
 5b9:	74 63                	je     61e <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 5bb:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 5bd:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 5c0:	74 e1                	je     5a3 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5c2:	83 fe 25             	cmp    $0x25,%esi
 5c5:	75 e9                	jne    5b0 <printf+0x30>
      if(c == 'd'){
 5c7:	83 fb 64             	cmp    $0x64,%ebx
 5ca:	0f 84 f0 00 00 00    	je     6c0 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5d0:	83 fb 78             	cmp    $0x78,%ebx
 5d3:	74 64                	je     639 <printf+0xb9>
 5d5:	83 fb 70             	cmp    $0x70,%ebx
 5d8:	74 5f                	je     639 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5da:	83 fb 73             	cmp    $0x73,%ebx
 5dd:	8d 76 00             	lea    0x0(%esi),%esi
 5e0:	74 7e                	je     660 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5e2:	83 fb 63             	cmp    $0x63,%ebx
 5e5:	0f 84 b9 00 00 00    	je     6a4 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5eb:	83 fb 25             	cmp    $0x25,%ebx
 5ee:	66 90                	xchg   %ax,%ax
 5f0:	0f 84 f2 00 00 00    	je     6e8 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5f6:	8b 45 08             	mov    0x8(%ebp),%eax
 5f9:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5fe:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 601:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 603:	e8 c8 fe ff ff       	call   4d0 <putc>
        putc(fd, c);
 608:	8b 45 08             	mov    0x8(%ebp),%eax
 60b:	0f be d3             	movsbl %bl,%edx
 60e:	e8 bd fe ff ff       	call   4d0 <putc>
 613:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 616:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 61a:	84 c0                	test   %al,%al
 61c:	75 9d                	jne    5bb <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 61e:	83 c4 0c             	add    $0xc,%esp
 621:	5b                   	pop    %ebx
 622:	5e                   	pop    %esi
 623:	5f                   	pop    %edi
 624:	5d                   	pop    %ebp
 625:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 626:	8b 45 08             	mov    0x8(%ebp),%eax
 629:	0f be d3             	movsbl %bl,%edx
 62c:	e8 9f fe ff ff       	call   4d0 <putc>
 631:	8b 55 0c             	mov    0xc(%ebp),%edx
 634:	e9 77 ff ff ff       	jmp    5b0 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 639:	8b 45 f0             	mov    -0x10(%ebp),%eax
 63c:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 641:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 643:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 64a:	8b 10                	mov    (%eax),%edx
 64c:	8b 45 08             	mov    0x8(%ebp),%eax
 64f:	e8 ac fe ff ff       	call   500 <printint>
 654:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 657:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 65b:	e9 50 ff ff ff       	jmp    5b0 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 660:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 663:	8b 01                	mov    (%ecx),%eax
        ap++;
 665:	83 c1 04             	add    $0x4,%ecx
 668:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 66b:	b9 10 09 00 00       	mov    $0x910,%ecx
 670:	85 c0                	test   %eax,%eax
 672:	75 2c                	jne    6a0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 674:	0f b6 01             	movzbl (%ecx),%eax
 677:	84 c0                	test   %al,%al
 679:	74 1e                	je     699 <printf+0x119>
 67b:	89 cb                	mov    %ecx,%ebx
 67d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 680:	0f be d0             	movsbl %al,%edx
 683:	8b 45 08             	mov    0x8(%ebp),%eax
 686:	e8 45 fe ff ff       	call   4d0 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 68b:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 68f:	83 c3 01             	add    $0x1,%ebx
 692:	84 c0                	test   %al,%al
 694:	75 ea                	jne    680 <printf+0x100>
 696:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 699:	31 f6                	xor    %esi,%esi
 69b:	e9 10 ff ff ff       	jmp    5b0 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 6a0:	89 c1                	mov    %eax,%ecx
 6a2:	eb d0                	jmp    674 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 6a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 6a7:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 6a9:	0f be 10             	movsbl (%eax),%edx
 6ac:	8b 45 08             	mov    0x8(%ebp),%eax
 6af:	e8 1c fe ff ff       	call   4d0 <putc>
 6b4:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 6b7:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 6bb:	e9 f0 fe ff ff       	jmp    5b0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 6c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6c3:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 6c8:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 6cb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 6d2:	8b 10                	mov    (%eax),%edx
 6d4:	8b 45 08             	mov    0x8(%ebp),%eax
 6d7:	e8 24 fe ff ff       	call   500 <printint>
 6dc:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 6df:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 6e3:	e9 c8 fe ff ff       	jmp    5b0 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 6e8:	8b 45 08             	mov    0x8(%ebp),%eax
 6eb:	ba 25 00 00 00       	mov    $0x25,%edx
 6f0:	31 f6                	xor    %esi,%esi
 6f2:	e8 d9 fd ff ff       	call   4d0 <putc>
 6f7:	8b 55 0c             	mov    0xc(%ebp),%edx
 6fa:	e9 b1 fe ff ff       	jmp    5b0 <printf+0x30>
 6ff:	90                   	nop    

00000700 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 700:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 701:	8b 0d 38 09 00 00    	mov    0x938,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 707:	89 e5                	mov    %esp,%ebp
 709:	56                   	push   %esi
 70a:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 70b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 70e:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 711:	39 d9                	cmp    %ebx,%ecx
 713:	73 18                	jae    72d <free+0x2d>
 715:	8b 11                	mov    (%ecx),%edx
 717:	39 d3                	cmp    %edx,%ebx
 719:	72 17                	jb     732 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 71b:	39 d1                	cmp    %edx,%ecx
 71d:	72 08                	jb     727 <free+0x27>
 71f:	39 d9                	cmp    %ebx,%ecx
 721:	72 0f                	jb     732 <free+0x32>
 723:	39 d3                	cmp    %edx,%ebx
 725:	72 0b                	jb     732 <free+0x32>
 727:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 729:	39 d9                	cmp    %ebx,%ecx
 72b:	72 e8                	jb     715 <free+0x15>
 72d:	8b 11                	mov    (%ecx),%edx
 72f:	90                   	nop    
 730:	eb e9                	jmp    71b <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 732:	8b 73 04             	mov    0x4(%ebx),%esi
 735:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 738:	39 d0                	cmp    %edx,%eax
 73a:	74 18                	je     754 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 73c:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 73e:	8b 51 04             	mov    0x4(%ecx),%edx
 741:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 744:	39 d8                	cmp    %ebx,%eax
 746:	74 20                	je     768 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 748:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 74a:	5b                   	pop    %ebx
 74b:	5e                   	pop    %esi
 74c:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 74d:	89 0d 38 09 00 00    	mov    %ecx,0x938
}
 753:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 754:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 757:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 759:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 75c:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 75f:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 761:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 764:	39 d8                	cmp    %ebx,%eax
 766:	75 e0                	jne    748 <free+0x48>
    p->s.size += bp->s.size;
 768:	03 53 04             	add    0x4(%ebx),%edx
 76b:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 76e:	8b 13                	mov    (%ebx),%edx
 770:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 772:	5b                   	pop    %ebx
 773:	5e                   	pop    %esi
 774:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 775:	89 0d 38 09 00 00    	mov    %ecx,0x938
}
 77b:	c3                   	ret    
 77c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000780 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 780:	55                   	push   %ebp
 781:	89 e5                	mov    %esp,%ebp
 783:	57                   	push   %edi
 784:	56                   	push   %esi
 785:	53                   	push   %ebx
 786:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 789:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 78c:	8b 15 38 09 00 00    	mov    0x938,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 792:	83 c0 07             	add    $0x7,%eax
 795:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 798:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 79a:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 79d:	0f 84 8a 00 00 00    	je     82d <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a3:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 7a5:	8b 41 04             	mov    0x4(%ecx),%eax
 7a8:	39 c3                	cmp    %eax,%ebx
 7aa:	76 1a                	jbe    7c6 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 7ac:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 7b3:	3b 0d 38 09 00 00    	cmp    0x938,%ecx
 7b9:	89 ca                	mov    %ecx,%edx
 7bb:	74 29                	je     7e6 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7bd:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 7bf:	8b 41 04             	mov    0x4(%ecx),%eax
 7c2:	39 c3                	cmp    %eax,%ebx
 7c4:	77 ed                	ja     7b3 <malloc+0x33>
      if(p->s.size == nunits)
 7c6:	39 c3                	cmp    %eax,%ebx
 7c8:	74 5d                	je     827 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 7ca:	29 d8                	sub    %ebx,%eax
 7cc:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 7cf:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 7d2:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 7d5:	89 15 38 09 00 00    	mov    %edx,0x938
      return (void*) (p + 1);
 7db:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7de:	83 c4 0c             	add    $0xc,%esp
 7e1:	5b                   	pop    %ebx
 7e2:	5e                   	pop    %esi
 7e3:	5f                   	pop    %edi
 7e4:	5d                   	pop    %ebp
 7e5:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 7e6:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 7ec:	89 de                	mov    %ebx,%esi
 7ee:	89 f8                	mov    %edi,%eax
 7f0:	76 29                	jbe    81b <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 7f2:	89 04 24             	mov    %eax,(%esp)
 7f5:	e8 b6 fc ff ff       	call   4b0 <sbrk>
  if(p == (char*) -1)
 7fa:	83 f8 ff             	cmp    $0xffffffff,%eax
 7fd:	74 18                	je     817 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 7ff:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 802:	83 c0 08             	add    $0x8,%eax
 805:	89 04 24             	mov    %eax,(%esp)
 808:	e8 f3 fe ff ff       	call   700 <free>
  return freep;
 80d:	8b 15 38 09 00 00    	mov    0x938,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 813:	85 d2                	test   %edx,%edx
 815:	75 a6                	jne    7bd <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 817:	31 c0                	xor    %eax,%eax
 819:	eb c3                	jmp    7de <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 81b:	be 00 10 00 00       	mov    $0x1000,%esi
 820:	b8 00 80 00 00       	mov    $0x8000,%eax
 825:	eb cb                	jmp    7f2 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 827:	8b 01                	mov    (%ecx),%eax
 829:	89 02                	mov    %eax,(%edx)
 82b:	eb a8                	jmp    7d5 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 82d:	ba 30 09 00 00       	mov    $0x930,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 832:	c7 05 38 09 00 00 30 	movl   $0x930,0x938
 839:	09 00 00 
 83c:	c7 05 30 09 00 00 30 	movl   $0x930,0x930
 843:	09 00 00 
    base.s.size = 0;
 846:	c7 05 34 09 00 00 00 	movl   $0x0,0x934
 84d:	00 00 00 
 850:	e9 4e ff ff ff       	jmp    7a3 <malloc+0x23>
