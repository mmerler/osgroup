
_hw2-test-fork:     file format elf32-i386

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
  39:	c7 44 24 04 78 08 00 	movl   $0x878,0x4(%esp)
  40:	00 
  41:	89 44 24 08          	mov    %eax,0x8(%esp)
  45:	a1 70 09 00 00       	mov    0x970,%eax
  4a:	89 04 24             	mov    %eax,(%esp)
  4d:	e8 4e 05 00 00       	call   5a0 <printf>
  exit();
  52:	e8 f1 03 00 00       	call   448 <exit>
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
  7b:	e8 f0 01 00 00       	call   270 <strcmp>
  80:	85 c0                	test   %eax,%eax
  82:	74 22                	je     a6 <check_arg_string+0x46>
  // corresponding system call.
  return 0;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
  84:	a1 70 09 00 00       	mov    0x970,%eax
  89:	c7 44 24 08 7c 08 00 	movl   $0x87c,0x8(%esp)
  90:	00 
  91:	c7 44 24 04 78 08 00 	movl   $0x878,0x4(%esp)
  98:	00 
  99:	89 04 24             	mov    %eax,(%esp)
  9c:	e8 ff 04 00 00       	call   5a0 <printf>
  exit();
  a1:	e8 a2 03 00 00       	call   448 <exit>
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
  ca:	c7 44 24 04 93 08 00 	movl   $0x893,0x4(%esp)
  d1:	00 
  d2:	89 44 24 08          	mov    %eax,0x8(%esp)
  d6:	a1 70 09 00 00       	mov    0x970,%eax
  db:	89 04 24             	mov    %eax,(%esp)
  de:	e8 bd 04 00 00       	call   5a0 <printf>
  // corresponding system call.
  return 0;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
  e3:	a1 70 09 00 00       	mov    0x970,%eax
  e8:	c7 44 24 08 ab 08 00 	movl   $0x8ab,0x8(%esp)
  ef:	00 
  f0:	c7 44 24 04 78 08 00 	movl   $0x878,0x4(%esp)
  f7:	00 
  f8:	89 04 24             	mov    %eax,(%esp)
  fb:	e8 a0 04 00 00       	call   5a0 <printf>
  exit();
 100:	e8 43 03 00 00       	call   448 <exit>
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
 126:	a1 70 09 00 00       	mov    0x970,%eax
 12b:	c7 44 24 08 c3 08 00 	movl   $0x8c3,0x8(%esp)
 132:	00 
 133:	c7 44 24 04 78 08 00 	movl   $0x878,0x4(%esp)
 13a:	00 
 13b:	89 04 24             	mov    %eax,(%esp)
 13e:	e8 5d 04 00 00       	call   5a0 <printf>
  exit();
 143:	e8 00 03 00 00       	call   448 <exit>
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
 166:	a1 70 09 00 00       	mov    0x970,%eax
 16b:	c7 44 24 08 db 08 00 	movl   $0x8db,0x8(%esp)
 172:	00 
 173:	c7 44 24 04 78 08 00 	movl   $0x878,0x4(%esp)
 17a:	00 
 17b:	89 04 24             	mov    %eax,(%esp)
 17e:	e8 1d 04 00 00       	call   5a0 <printf>
  exit();
 183:	e8 c0 02 00 00       	call   448 <exit>
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
 1a7:	a1 70 09 00 00       	mov    0x970,%eax
 1ac:	c7 44 24 08 f1 08 00 	movl   $0x8f1,0x8(%esp)
 1b3:	00 
 1b4:	c7 44 24 04 78 08 00 	movl   $0x878,0x4(%esp)
 1bb:	00 
 1bc:	89 04 24             	mov    %eax,(%esp)
 1bf:	e8 dc 03 00 00       	call   5a0 <printf>
  exit();
 1c4:	e8 7f 02 00 00       	call   448 <exit>
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
 1f0:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 1f3:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  
  ret = startrecording();
  if (ret == -1)
    handle_error("error startrecording");

  child_pid = fork();
 1f6:	e8 45 02 00 00       	call   440 <fork>
 1fb:	89 c3                	mov    %eax,%ebx
  
  pid = getpid();
 1fd:	e8 c6 02 00 00       	call   4c8 <getpid>

  num_records = fetchrecords(0, 0);
  if (num_records == -1)
    handle_error("error fetching # of records\n");

  if (child_pid == 0 && num_records != 2)
 202:	85 db                	test   %ebx,%ebx
 204:	74 22                	je     228 <main+0x48>
  // corresponding system call.
  return 0;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 206:	c7 44 24 08 2c 09 00 	movl   $0x92c,0x8(%esp)
 20d:	00 
 20e:	a1 70 09 00 00       	mov    0x970,%eax
 213:	c7 44 24 04 78 08 00 	movl   $0x878,0x4(%esp)
 21a:	00 
 21b:	89 04 24             	mov    %eax,(%esp)
 21e:	e8 7d 03 00 00       	call   5a0 <printf>
  exit();
 223:	e8 20 02 00 00       	call   448 <exit>
  // corresponding system call.
  return 0;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 228:	c7 44 24 08 08 09 00 	movl   $0x908,0x8(%esp)
 22f:	00 
 230:	eb dc                	jmp    20e <main+0x2e>
 232:	90                   	nop    
 233:	90                   	nop    
 234:	90                   	nop    
 235:	90                   	nop    
 236:	90                   	nop    
 237:	90                   	nop    
 238:	90                   	nop    
 239:	90                   	nop    
 23a:	90                   	nop    
 23b:	90                   	nop    
 23c:	90                   	nop    
 23d:	90                   	nop    
 23e:	90                   	nop    
 23f:	90                   	nop    

00000240 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	53                   	push   %ebx
 244:	8b 5d 08             	mov    0x8(%ebp),%ebx
 247:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 24a:	89 da                	mov    %ebx,%edx
 24c:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 250:	0f b6 01             	movzbl (%ecx),%eax
 253:	83 c1 01             	add    $0x1,%ecx
 256:	88 02                	mov    %al,(%edx)
 258:	83 c2 01             	add    $0x1,%edx
 25b:	84 c0                	test   %al,%al
 25d:	75 f1                	jne    250 <strcpy+0x10>
    ;
  return os;
}
 25f:	89 d8                	mov    %ebx,%eax
 261:	5b                   	pop    %ebx
 262:	5d                   	pop    %ebp
 263:	c3                   	ret    
 264:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 26a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000270 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	8b 4d 08             	mov    0x8(%ebp),%ecx
 276:	53                   	push   %ebx
 277:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 27a:	0f b6 01             	movzbl (%ecx),%eax
 27d:	84 c0                	test   %al,%al
 27f:	74 24                	je     2a5 <strcmp+0x35>
 281:	0f b6 13             	movzbl (%ebx),%edx
 284:	38 d0                	cmp    %dl,%al
 286:	74 12                	je     29a <strcmp+0x2a>
 288:	eb 1e                	jmp    2a8 <strcmp+0x38>
 28a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 290:	0f b6 13             	movzbl (%ebx),%edx
 293:	83 c1 01             	add    $0x1,%ecx
 296:	38 d0                	cmp    %dl,%al
 298:	75 0e                	jne    2a8 <strcmp+0x38>
 29a:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 29e:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2a1:	84 c0                	test   %al,%al
 2a3:	75 eb                	jne    290 <strcmp+0x20>
 2a5:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 2a8:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2a9:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 2ac:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2ad:	0f b6 d2             	movzbl %dl,%edx
 2b0:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 2b2:	c3                   	ret    
 2b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000002c0 <strlen>:

uint
strlen(char *s)
{
 2c0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 2c1:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 2c3:	89 e5                	mov    %esp,%ebp
 2c5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 2c8:	80 39 00             	cmpb   $0x0,(%ecx)
 2cb:	74 0e                	je     2db <strlen+0x1b>
 2cd:	31 d2                	xor    %edx,%edx
 2cf:	90                   	nop    
 2d0:	83 c2 01             	add    $0x1,%edx
 2d3:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
 2d7:	89 d0                	mov    %edx,%eax
 2d9:	75 f5                	jne    2d0 <strlen+0x10>
    ;
  return n;
}
 2db:	5d                   	pop    %ebp
 2dc:	c3                   	ret    
 2dd:	8d 76 00             	lea    0x0(%esi),%esi

000002e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	8b 55 08             	mov    0x8(%ebp),%edx
 2e6:	57                   	push   %edi
 2e7:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ea:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 2ed:	89 d7                	mov    %edx,%edi
 2ef:	fc                   	cld    
 2f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 2f2:	5f                   	pop    %edi
 2f3:	89 d0                	mov    %edx,%eax
 2f5:	5d                   	pop    %ebp
 2f6:	c3                   	ret    
 2f7:	89 f6                	mov    %esi,%esi
 2f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000300 <strchr>:

char*
strchr(const char *s, char c)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	8b 45 08             	mov    0x8(%ebp),%eax
 306:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 30a:	0f b6 10             	movzbl (%eax),%edx
 30d:	84 d2                	test   %dl,%dl
 30f:	75 0c                	jne    31d <strchr+0x1d>
 311:	eb 11                	jmp    324 <strchr+0x24>
 313:	83 c0 01             	add    $0x1,%eax
 316:	0f b6 10             	movzbl (%eax),%edx
 319:	84 d2                	test   %dl,%dl
 31b:	74 07                	je     324 <strchr+0x24>
    if(*s == c)
 31d:	38 ca                	cmp    %cl,%dl
 31f:	90                   	nop    
 320:	75 f1                	jne    313 <strchr+0x13>
      return (char*) s;
  return 0;
}
 322:	5d                   	pop    %ebp
 323:	c3                   	ret    
 324:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 325:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 327:	c3                   	ret    
 328:	90                   	nop    
 329:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000330 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	8b 4d 08             	mov    0x8(%ebp),%ecx
 336:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 337:	31 db                	xor    %ebx,%ebx
 339:	0f b6 11             	movzbl (%ecx),%edx
 33c:	8d 42 d0             	lea    -0x30(%edx),%eax
 33f:	3c 09                	cmp    $0x9,%al
 341:	77 18                	ja     35b <atoi+0x2b>
    n = n*10 + *s++ - '0';
 343:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 346:	0f be d2             	movsbl %dl,%edx
 349:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 34d:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 351:	83 c1 01             	add    $0x1,%ecx
 354:	8d 42 d0             	lea    -0x30(%edx),%eax
 357:	3c 09                	cmp    $0x9,%al
 359:	76 e8                	jbe    343 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 35b:	89 d8                	mov    %ebx,%eax
 35d:	5b                   	pop    %ebx
 35e:	5d                   	pop    %ebp
 35f:	c3                   	ret    

00000360 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	8b 4d 10             	mov    0x10(%ebp),%ecx
 366:	56                   	push   %esi
 367:	8b 75 08             	mov    0x8(%ebp),%esi
 36a:	53                   	push   %ebx
 36b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 36e:	85 c9                	test   %ecx,%ecx
 370:	7e 10                	jle    382 <memmove+0x22>
 372:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 374:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 378:	88 04 32             	mov    %al,(%edx,%esi,1)
 37b:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 37e:	39 ca                	cmp    %ecx,%edx
 380:	75 f2                	jne    374 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 382:	89 f0                	mov    %esi,%eax
 384:	5b                   	pop    %ebx
 385:	5e                   	pop    %esi
 386:	5d                   	pop    %ebp
 387:	c3                   	ret    
 388:	90                   	nop    
 389:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000390 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 396:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 399:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 39c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 39f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3a4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 3ab:	00 
 3ac:	89 04 24             	mov    %eax,(%esp)
 3af:	e8 d4 00 00 00       	call   488 <open>
  if(fd < 0)
 3b4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3b6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 3b8:	78 19                	js     3d3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 3ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 3bd:	89 1c 24             	mov    %ebx,(%esp)
 3c0:	89 44 24 04          	mov    %eax,0x4(%esp)
 3c4:	e8 d7 00 00 00       	call   4a0 <fstat>
  close(fd);
 3c9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 3cc:	89 c6                	mov    %eax,%esi
  close(fd);
 3ce:	e8 9d 00 00 00       	call   470 <close>
  return r;
}
 3d3:	89 f0                	mov    %esi,%eax
 3d5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 3d8:	8b 75 fc             	mov    -0x4(%ebp),%esi
 3db:	89 ec                	mov    %ebp,%esp
 3dd:	5d                   	pop    %ebp
 3de:	c3                   	ret    
 3df:	90                   	nop    

000003e0 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	56                   	push   %esi
 3e5:	31 f6                	xor    %esi,%esi
 3e7:	53                   	push   %ebx
 3e8:	83 ec 1c             	sub    $0x1c,%esp
 3eb:	8b 7d 08             	mov    0x8(%ebp),%edi
 3ee:	eb 06                	jmp    3f6 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3f0:	3c 0d                	cmp    $0xd,%al
 3f2:	74 39                	je     42d <gets+0x4d>
 3f4:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3f6:	8d 5e 01             	lea    0x1(%esi),%ebx
 3f9:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3fc:	7d 31                	jge    42f <gets+0x4f>
    cc = read(0, &c, 1);
 3fe:	8d 45 f3             	lea    -0xd(%ebp),%eax
 401:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 408:	00 
 409:	89 44 24 04          	mov    %eax,0x4(%esp)
 40d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 414:	e8 47 00 00 00       	call   460 <read>
    if(cc < 1)
 419:	85 c0                	test   %eax,%eax
 41b:	7e 12                	jle    42f <gets+0x4f>
      break;
    buf[i++] = c;
 41d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 421:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 425:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 429:	3c 0a                	cmp    $0xa,%al
 42b:	75 c3                	jne    3f0 <gets+0x10>
 42d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 42f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 433:	89 f8                	mov    %edi,%eax
 435:	83 c4 1c             	add    $0x1c,%esp
 438:	5b                   	pop    %ebx
 439:	5e                   	pop    %esi
 43a:	5f                   	pop    %edi
 43b:	5d                   	pop    %ebp
 43c:	c3                   	ret    
 43d:	90                   	nop    
 43e:	90                   	nop    
 43f:	90                   	nop    

00000440 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 440:	b8 01 00 00 00       	mov    $0x1,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <exit>:
SYSCALL(exit)
 448:	b8 02 00 00 00       	mov    $0x2,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <wait>:
SYSCALL(wait)
 450:	b8 03 00 00 00       	mov    $0x3,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    

00000458 <pipe>:
SYSCALL(pipe)
 458:	b8 04 00 00 00       	mov    $0x4,%eax
 45d:	cd 40                	int    $0x40
 45f:	c3                   	ret    

00000460 <read>:
SYSCALL(read)
 460:	b8 06 00 00 00       	mov    $0x6,%eax
 465:	cd 40                	int    $0x40
 467:	c3                   	ret    

00000468 <write>:
SYSCALL(write)
 468:	b8 05 00 00 00       	mov    $0x5,%eax
 46d:	cd 40                	int    $0x40
 46f:	c3                   	ret    

00000470 <close>:
SYSCALL(close)
 470:	b8 07 00 00 00       	mov    $0x7,%eax
 475:	cd 40                	int    $0x40
 477:	c3                   	ret    

00000478 <kill>:
SYSCALL(kill)
 478:	b8 08 00 00 00       	mov    $0x8,%eax
 47d:	cd 40                	int    $0x40
 47f:	c3                   	ret    

00000480 <exec>:
SYSCALL(exec)
 480:	b8 09 00 00 00       	mov    $0x9,%eax
 485:	cd 40                	int    $0x40
 487:	c3                   	ret    

00000488 <open>:
SYSCALL(open)
 488:	b8 0a 00 00 00       	mov    $0xa,%eax
 48d:	cd 40                	int    $0x40
 48f:	c3                   	ret    

00000490 <mknod>:
SYSCALL(mknod)
 490:	b8 0b 00 00 00       	mov    $0xb,%eax
 495:	cd 40                	int    $0x40
 497:	c3                   	ret    

00000498 <unlink>:
SYSCALL(unlink)
 498:	b8 0c 00 00 00       	mov    $0xc,%eax
 49d:	cd 40                	int    $0x40
 49f:	c3                   	ret    

000004a0 <fstat>:
SYSCALL(fstat)
 4a0:	b8 0d 00 00 00       	mov    $0xd,%eax
 4a5:	cd 40                	int    $0x40
 4a7:	c3                   	ret    

000004a8 <link>:
SYSCALL(link)
 4a8:	b8 0e 00 00 00       	mov    $0xe,%eax
 4ad:	cd 40                	int    $0x40
 4af:	c3                   	ret    

000004b0 <mkdir>:
SYSCALL(mkdir)
 4b0:	b8 0f 00 00 00       	mov    $0xf,%eax
 4b5:	cd 40                	int    $0x40
 4b7:	c3                   	ret    

000004b8 <chdir>:
SYSCALL(chdir)
 4b8:	b8 10 00 00 00       	mov    $0x10,%eax
 4bd:	cd 40                	int    $0x40
 4bf:	c3                   	ret    

000004c0 <dup>:
SYSCALL(dup)
 4c0:	b8 11 00 00 00       	mov    $0x11,%eax
 4c5:	cd 40                	int    $0x40
 4c7:	c3                   	ret    

000004c8 <getpid>:
SYSCALL(getpid)
 4c8:	b8 12 00 00 00       	mov    $0x12,%eax
 4cd:	cd 40                	int    $0x40
 4cf:	c3                   	ret    

000004d0 <sbrk>:
SYSCALL(sbrk)
 4d0:	b8 13 00 00 00       	mov    $0x13,%eax
 4d5:	cd 40                	int    $0x40
 4d7:	c3                   	ret    

000004d8 <sleep>:
SYSCALL(sleep)
 4d8:	b8 14 00 00 00       	mov    $0x14,%eax
 4dd:	cd 40                	int    $0x40
 4df:	c3                   	ret    

000004e0 <uptime>:
SYSCALL(uptime)
 4e0:	b8 15 00 00 00       	mov    $0x15,%eax
 4e5:	cd 40                	int    $0x40
 4e7:	c3                   	ret    
 4e8:	90                   	nop    
 4e9:	90                   	nop    
 4ea:	90                   	nop    
 4eb:	90                   	nop    
 4ec:	90                   	nop    
 4ed:	90                   	nop    
 4ee:	90                   	nop    
 4ef:	90                   	nop    

000004f0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	83 ec 18             	sub    $0x18,%esp
 4f6:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 4f9:	8d 55 fc             	lea    -0x4(%ebp),%edx
 4fc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 503:	00 
 504:	89 54 24 04          	mov    %edx,0x4(%esp)
 508:	89 04 24             	mov    %eax,(%esp)
 50b:	e8 58 ff ff ff       	call   468 <write>
}
 510:	c9                   	leave  
 511:	c3                   	ret    
 512:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 519:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000520 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	57                   	push   %edi
 524:	56                   	push   %esi
 525:	89 ce                	mov    %ecx,%esi
 527:	53                   	push   %ebx
 528:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 52b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 52e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 531:	85 c9                	test   %ecx,%ecx
 533:	74 04                	je     539 <printint+0x19>
 535:	85 d2                	test   %edx,%edx
 537:	78 54                	js     58d <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 539:	89 d0                	mov    %edx,%eax
 53b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 542:	31 db                	xor    %ebx,%ebx
 544:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 547:	31 d2                	xor    %edx,%edx
 549:	f7 f6                	div    %esi
 54b:	89 c1                	mov    %eax,%ecx
 54d:	0f b6 82 5b 09 00 00 	movzbl 0x95b(%edx),%eax
 554:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 557:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 55a:	85 c9                	test   %ecx,%ecx
 55c:	89 c8                	mov    %ecx,%eax
 55e:	75 e7                	jne    547 <printint+0x27>
  if(neg)
 560:	8b 45 e0             	mov    -0x20(%ebp),%eax
 563:	85 c0                	test   %eax,%eax
 565:	74 08                	je     56f <printint+0x4f>
    buf[i++] = '-';
 567:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 56c:	83 c3 01             	add    $0x1,%ebx
 56f:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 572:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 576:	83 eb 01             	sub    $0x1,%ebx
 579:	8b 45 dc             	mov    -0x24(%ebp),%eax
 57c:	e8 6f ff ff ff       	call   4f0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 581:	39 fb                	cmp    %edi,%ebx
 583:	75 ed                	jne    572 <printint+0x52>
    putc(fd, buf[i]);
}
 585:	83 c4 1c             	add    $0x1c,%esp
 588:	5b                   	pop    %ebx
 589:	5e                   	pop    %esi
 58a:	5f                   	pop    %edi
 58b:	5d                   	pop    %ebp
 58c:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 58d:	89 d0                	mov    %edx,%eax
 58f:	f7 d8                	neg    %eax
 591:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 598:	eb a8                	jmp    542 <printint+0x22>
 59a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000005a0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	57                   	push   %edi
 5a4:	56                   	push   %esi
 5a5:	53                   	push   %ebx
 5a6:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5a9:	8b 55 0c             	mov    0xc(%ebp),%edx
 5ac:	0f b6 02             	movzbl (%edx),%eax
 5af:	84 c0                	test   %al,%al
 5b1:	0f 84 87 00 00 00    	je     63e <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 5b7:	8d 4d 10             	lea    0x10(%ebp),%ecx
 5ba:	31 ff                	xor    %edi,%edi
 5bc:	31 f6                	xor    %esi,%esi
 5be:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 5c1:	eb 18                	jmp    5db <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5c3:	83 fb 25             	cmp    $0x25,%ebx
 5c6:	0f 85 7a 00 00 00    	jne    646 <printf+0xa6>
 5cc:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5d0:	83 c7 01             	add    $0x1,%edi
 5d3:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 5d7:	84 c0                	test   %al,%al
 5d9:	74 63                	je     63e <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 5db:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 5dd:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 5e0:	74 e1                	je     5c3 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5e2:	83 fe 25             	cmp    $0x25,%esi
 5e5:	75 e9                	jne    5d0 <printf+0x30>
      if(c == 'd'){
 5e7:	83 fb 64             	cmp    $0x64,%ebx
 5ea:	0f 84 f0 00 00 00    	je     6e0 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5f0:	83 fb 78             	cmp    $0x78,%ebx
 5f3:	74 64                	je     659 <printf+0xb9>
 5f5:	83 fb 70             	cmp    $0x70,%ebx
 5f8:	74 5f                	je     659 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5fa:	83 fb 73             	cmp    $0x73,%ebx
 5fd:	8d 76 00             	lea    0x0(%esi),%esi
 600:	74 7e                	je     680 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 602:	83 fb 63             	cmp    $0x63,%ebx
 605:	0f 84 b9 00 00 00    	je     6c4 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 60b:	83 fb 25             	cmp    $0x25,%ebx
 60e:	66 90                	xchg   %ax,%ax
 610:	0f 84 f2 00 00 00    	je     708 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 616:	8b 45 08             	mov    0x8(%ebp),%eax
 619:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 61e:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 621:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 623:	e8 c8 fe ff ff       	call   4f0 <putc>
        putc(fd, c);
 628:	8b 45 08             	mov    0x8(%ebp),%eax
 62b:	0f be d3             	movsbl %bl,%edx
 62e:	e8 bd fe ff ff       	call   4f0 <putc>
 633:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 636:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 63a:	84 c0                	test   %al,%al
 63c:	75 9d                	jne    5db <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 63e:	83 c4 0c             	add    $0xc,%esp
 641:	5b                   	pop    %ebx
 642:	5e                   	pop    %esi
 643:	5f                   	pop    %edi
 644:	5d                   	pop    %ebp
 645:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 646:	8b 45 08             	mov    0x8(%ebp),%eax
 649:	0f be d3             	movsbl %bl,%edx
 64c:	e8 9f fe ff ff       	call   4f0 <putc>
 651:	8b 55 0c             	mov    0xc(%ebp),%edx
 654:	e9 77 ff ff ff       	jmp    5d0 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 659:	8b 45 f0             	mov    -0x10(%ebp),%eax
 65c:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 661:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 663:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 66a:	8b 10                	mov    (%eax),%edx
 66c:	8b 45 08             	mov    0x8(%ebp),%eax
 66f:	e8 ac fe ff ff       	call   520 <printint>
 674:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 677:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 67b:	e9 50 ff ff ff       	jmp    5d0 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 680:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 683:	8b 01                	mov    (%ecx),%eax
        ap++;
 685:	83 c1 04             	add    $0x4,%ecx
 688:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 68b:	b9 54 09 00 00       	mov    $0x954,%ecx
 690:	85 c0                	test   %eax,%eax
 692:	75 2c                	jne    6c0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 694:	0f b6 01             	movzbl (%ecx),%eax
 697:	84 c0                	test   %al,%al
 699:	74 1e                	je     6b9 <printf+0x119>
 69b:	89 cb                	mov    %ecx,%ebx
 69d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 6a0:	0f be d0             	movsbl %al,%edx
 6a3:	8b 45 08             	mov    0x8(%ebp),%eax
 6a6:	e8 45 fe ff ff       	call   4f0 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6ab:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 6af:	83 c3 01             	add    $0x1,%ebx
 6b2:	84 c0                	test   %al,%al
 6b4:	75 ea                	jne    6a0 <printf+0x100>
 6b6:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 6b9:	31 f6                	xor    %esi,%esi
 6bb:	e9 10 ff ff ff       	jmp    5d0 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 6c0:	89 c1                	mov    %eax,%ecx
 6c2:	eb d0                	jmp    694 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 6c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 6c7:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 6c9:	0f be 10             	movsbl (%eax),%edx
 6cc:	8b 45 08             	mov    0x8(%ebp),%eax
 6cf:	e8 1c fe ff ff       	call   4f0 <putc>
 6d4:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 6d7:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 6db:	e9 f0 fe ff ff       	jmp    5d0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 6e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6e3:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 6e8:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 6eb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 6f2:	8b 10                	mov    (%eax),%edx
 6f4:	8b 45 08             	mov    0x8(%ebp),%eax
 6f7:	e8 24 fe ff ff       	call   520 <printint>
 6fc:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 6ff:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 703:	e9 c8 fe ff ff       	jmp    5d0 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 708:	8b 45 08             	mov    0x8(%ebp),%eax
 70b:	ba 25 00 00 00       	mov    $0x25,%edx
 710:	31 f6                	xor    %esi,%esi
 712:	e8 d9 fd ff ff       	call   4f0 <putc>
 717:	8b 55 0c             	mov    0xc(%ebp),%edx
 71a:	e9 b1 fe ff ff       	jmp    5d0 <printf+0x30>
 71f:	90                   	nop    

00000720 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 720:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 721:	8b 0d 7c 09 00 00    	mov    0x97c,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 727:	89 e5                	mov    %esp,%ebp
 729:	56                   	push   %esi
 72a:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 72b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 72e:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 731:	39 d9                	cmp    %ebx,%ecx
 733:	73 18                	jae    74d <free+0x2d>
 735:	8b 11                	mov    (%ecx),%edx
 737:	39 d3                	cmp    %edx,%ebx
 739:	72 17                	jb     752 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 73b:	39 d1                	cmp    %edx,%ecx
 73d:	72 08                	jb     747 <free+0x27>
 73f:	39 d9                	cmp    %ebx,%ecx
 741:	72 0f                	jb     752 <free+0x32>
 743:	39 d3                	cmp    %edx,%ebx
 745:	72 0b                	jb     752 <free+0x32>
 747:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 749:	39 d9                	cmp    %ebx,%ecx
 74b:	72 e8                	jb     735 <free+0x15>
 74d:	8b 11                	mov    (%ecx),%edx
 74f:	90                   	nop    
 750:	eb e9                	jmp    73b <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 752:	8b 73 04             	mov    0x4(%ebx),%esi
 755:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 758:	39 d0                	cmp    %edx,%eax
 75a:	74 18                	je     774 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 75c:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 75e:	8b 51 04             	mov    0x4(%ecx),%edx
 761:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 764:	39 d8                	cmp    %ebx,%eax
 766:	74 20                	je     788 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 768:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 76a:	5b                   	pop    %ebx
 76b:	5e                   	pop    %esi
 76c:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 76d:	89 0d 7c 09 00 00    	mov    %ecx,0x97c
}
 773:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 774:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 777:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 779:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 77c:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 77f:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 781:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 784:	39 d8                	cmp    %ebx,%eax
 786:	75 e0                	jne    768 <free+0x48>
    p->s.size += bp->s.size;
 788:	03 53 04             	add    0x4(%ebx),%edx
 78b:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 78e:	8b 13                	mov    (%ebx),%edx
 790:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 792:	5b                   	pop    %ebx
 793:	5e                   	pop    %esi
 794:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 795:	89 0d 7c 09 00 00    	mov    %ecx,0x97c
}
 79b:	c3                   	ret    
 79c:	8d 74 26 00          	lea    0x0(%esi),%esi

000007a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7a0:	55                   	push   %ebp
 7a1:	89 e5                	mov    %esp,%ebp
 7a3:	57                   	push   %edi
 7a4:	56                   	push   %esi
 7a5:	53                   	push   %ebx
 7a6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7ac:	8b 15 7c 09 00 00    	mov    0x97c,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7b2:	83 c0 07             	add    $0x7,%eax
 7b5:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 7b8:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7ba:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 7bd:	0f 84 8a 00 00 00    	je     84d <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c3:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 7c5:	8b 41 04             	mov    0x4(%ecx),%eax
 7c8:	39 c3                	cmp    %eax,%ebx
 7ca:	76 1a                	jbe    7e6 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 7cc:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 7d3:	3b 0d 7c 09 00 00    	cmp    0x97c,%ecx
 7d9:	89 ca                	mov    %ecx,%edx
 7db:	74 29                	je     806 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7dd:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 7df:	8b 41 04             	mov    0x4(%ecx),%eax
 7e2:	39 c3                	cmp    %eax,%ebx
 7e4:	77 ed                	ja     7d3 <malloc+0x33>
      if(p->s.size == nunits)
 7e6:	39 c3                	cmp    %eax,%ebx
 7e8:	74 5d                	je     847 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 7ea:	29 d8                	sub    %ebx,%eax
 7ec:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 7ef:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 7f2:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 7f5:	89 15 7c 09 00 00    	mov    %edx,0x97c
      return (void*) (p + 1);
 7fb:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7fe:	83 c4 0c             	add    $0xc,%esp
 801:	5b                   	pop    %ebx
 802:	5e                   	pop    %esi
 803:	5f                   	pop    %edi
 804:	5d                   	pop    %ebp
 805:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 806:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 80c:	89 de                	mov    %ebx,%esi
 80e:	89 f8                	mov    %edi,%eax
 810:	76 29                	jbe    83b <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 812:	89 04 24             	mov    %eax,(%esp)
 815:	e8 b6 fc ff ff       	call   4d0 <sbrk>
  if(p == (char*) -1)
 81a:	83 f8 ff             	cmp    $0xffffffff,%eax
 81d:	74 18                	je     837 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 81f:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 822:	83 c0 08             	add    $0x8,%eax
 825:	89 04 24             	mov    %eax,(%esp)
 828:	e8 f3 fe ff ff       	call   720 <free>
  return freep;
 82d:	8b 15 7c 09 00 00    	mov    0x97c,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 833:	85 d2                	test   %edx,%edx
 835:	75 a6                	jne    7dd <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 837:	31 c0                	xor    %eax,%eax
 839:	eb c3                	jmp    7fe <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 83b:	be 00 10 00 00       	mov    $0x1000,%esi
 840:	b8 00 80 00 00       	mov    $0x8000,%eax
 845:	eb cb                	jmp    812 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 847:	8b 01                	mov    (%ecx),%eax
 849:	89 02                	mov    %eax,(%edx)
 84b:	eb a8                	jmp    7f5 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 84d:	ba 74 09 00 00       	mov    $0x974,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 852:	c7 05 7c 09 00 00 74 	movl   $0x974,0x97c
 859:	09 00 00 
 85c:	c7 05 74 09 00 00 74 	movl   $0x974,0x974
 863:	09 00 00 
    base.s.size = 0;
 866:	c7 05 78 09 00 00 00 	movl   $0x0,0x978
 86d:	00 00 00 
 870:	e9 4e ff ff ff       	jmp    7c3 <malloc+0x23>
