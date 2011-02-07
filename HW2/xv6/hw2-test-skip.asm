
_hw2-test-skip:     file format elf32-i386

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
  39:	c7 44 24 04 45 08 00 	movl   $0x845,0x4(%esp)
  40:	00 
  41:	89 44 24 08          	mov    %eax,0x8(%esp)
  45:	a1 0c 09 00 00       	mov    0x90c,%eax
  4a:	89 04 24             	mov    %eax,(%esp)
  4d:	e8 1e 05 00 00       	call   570 <printf>
  exit();
  52:	e8 c1 03 00 00       	call   418 <exit>
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
  76:	a1 0c 09 00 00       	mov    0x90c,%eax
  7b:	c7 44 24 08 49 08 00 	movl   $0x849,0x8(%esp)
  82:	00 
  83:	c7 44 24 04 45 08 00 	movl   $0x845,0x4(%esp)
  8a:	00 
  8b:	89 04 24             	mov    %eax,(%esp)
  8e:	e8 dd 04 00 00       	call   570 <printf>
  exit();
  93:	e8 80 03 00 00       	call   418 <exit>
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
  b7:	a1 0c 09 00 00       	mov    0x90c,%eax
  bc:	c7 44 24 08 5f 08 00 	movl   $0x85f,0x8(%esp)
  c3:	00 
  c4:	c7 44 24 04 45 08 00 	movl   $0x845,0x4(%esp)
  cb:	00 
  cc:	89 04 24             	mov    %eax,(%esp)
  cf:	e8 9c 04 00 00       	call   570 <printf>
  exit();
  d4:	e8 3f 03 00 00       	call   418 <exit>
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
    handle_error("error fetching # of records\n");

  if (num_records != 0)
    handle_error("# of records is wrong\n");

  printf(stdout, "hw2-test-skip succeeded\n");
 101:	a1 08 09 00 00       	mov    0x908,%eax
 106:	c7 44 24 04 76 08 00 	movl   $0x876,0x4(%esp)
 10d:	00 
 10e:	89 04 24             	mov    %eax,(%esp)
 111:	e8 5a 04 00 00       	call   570 <printf>

  exit();
 116:	e8 fd 02 00 00       	call   418 <exit>
 11b:	90                   	nop    
 11c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000120 <check_arg_string>:
    printf(stderr, "actual %p, expected %p\n", r->value.ptrval, p);
    handle_error("error check_arg_pointer");
  }
}

inline void check_arg_string(const struct record *r, char *s) {
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	83 ec 18             	sub    $0x18,%esp
 126:	8b 45 08             	mov    0x8(%ebp),%eax
  if (r->type != ARG_STRING || strcmp(r->value.strval, s) != 0)
 129:	83 38 03             	cmpl   $0x3,(%eax)
 12c:	75 16                	jne    144 <check_arg_string+0x24>
 12e:	8b 55 0c             	mov    0xc(%ebp),%edx
 131:	83 c0 04             	add    $0x4,%eax
 134:	89 04 24             	mov    %eax,(%esp)
 137:	89 54 24 04          	mov    %edx,0x4(%esp)
 13b:	e8 00 01 00 00       	call   240 <strcmp>
 140:	85 c0                	test   %eax,%eax
 142:	74 22                	je     166 <check_arg_string+0x46>
  // corresponding system call.
  return 0;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 144:	a1 0c 09 00 00       	mov    0x90c,%eax
 149:	c7 44 24 08 8f 08 00 	movl   $0x88f,0x8(%esp)
 150:	00 
 151:	c7 44 24 04 45 08 00 	movl   $0x845,0x4(%esp)
 158:	00 
 159:	89 04 24             	mov    %eax,(%esp)
 15c:	e8 0f 04 00 00       	call   570 <printf>
  exit();
 161:	e8 b2 02 00 00       	call   418 <exit>
}

inline void check_arg_string(const struct record *r, char *s) {
  if (r->type != ARG_STRING || strcmp(r->value.strval, s) != 0)
    handle_error("error check_arg_string");
}
 166:	c9                   	leave  
 167:	c3                   	ret    
 168:	90                   	nop    
 169:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000170 <check_arg_pointer>:
inline void check_arg_integer(const struct record *r, int v) {
  if (r->type != ARG_INTEGER || r->value.intval != v)
    handle_error("error check_arg_integer");
}

inline void check_arg_pointer(const struct record *r, void *p) {
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	83 ec 18             	sub    $0x18,%esp
 176:	8b 45 08             	mov    0x8(%ebp),%eax
  // Pointer values differs form machine to machine. 
  // Do not count on it. 
  if (r->type != ARG_POINTER/* || r->value.ptrval != p */) {
 179:	83 38 02             	cmpl   $0x2,(%eax)
 17c:	75 02                	jne    180 <check_arg_pointer+0x10>
    printf(stderr, "actual %p, expected %p\n", r->value.ptrval, p);
    handle_error("error check_arg_pointer");
  }
}
 17e:	c9                   	leave  
 17f:	c3                   	ret    

inline void check_arg_pointer(const struct record *r, void *p) {
  // Pointer values differs form machine to machine. 
  // Do not count on it. 
  if (r->type != ARG_POINTER/* || r->value.ptrval != p */) {
    printf(stderr, "actual %p, expected %p\n", r->value.ptrval, p);
 180:	8b 55 0c             	mov    0xc(%ebp),%edx
 183:	89 54 24 0c          	mov    %edx,0xc(%esp)
 187:	8b 40 04             	mov    0x4(%eax),%eax
 18a:	c7 44 24 04 a6 08 00 	movl   $0x8a6,0x4(%esp)
 191:	00 
 192:	89 44 24 08          	mov    %eax,0x8(%esp)
 196:	a1 0c 09 00 00       	mov    0x90c,%eax
 19b:	89 04 24             	mov    %eax,(%esp)
 19e:	e8 cd 03 00 00       	call   570 <printf>
  // corresponding system call.
  return 0;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 1a3:	a1 0c 09 00 00       	mov    0x90c,%eax
 1a8:	c7 44 24 08 be 08 00 	movl   $0x8be,0x8(%esp)
 1af:	00 
 1b0:	c7 44 24 04 45 08 00 	movl   $0x845,0x4(%esp)
 1b7:	00 
 1b8:	89 04 24             	mov    %eax,(%esp)
 1bb:	e8 b0 03 00 00       	call   570 <printf>
  exit();
 1c0:	e8 53 02 00 00       	call   418 <exit>
 1c5:	8d 74 26 00          	lea    0x0(%esi),%esi
 1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000001d0 <check_arg_integer>:
inline void check_ret_value(const struct record *r, int v) {
  if (r->type != RET_VALUE || r->value.intval != v)
    handle_error("error check_ret_value");
}

inline void check_arg_integer(const struct record *r, int v) {
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	83 ec 18             	sub    $0x18,%esp
 1d6:	8b 45 08             	mov    0x8(%ebp),%eax
  if (r->type != ARG_INTEGER || r->value.intval != v)
 1d9:	83 38 01             	cmpl   $0x1,(%eax)
 1dc:	75 08                	jne    1e6 <check_arg_integer+0x16>
 1de:	8b 55 0c             	mov    0xc(%ebp),%edx
 1e1:	39 50 04             	cmp    %edx,0x4(%eax)
 1e4:	74 22                	je     208 <check_arg_integer+0x38>
  // corresponding system call.
  return 0;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 1e6:	a1 0c 09 00 00       	mov    0x90c,%eax
 1eb:	c7 44 24 08 d6 08 00 	movl   $0x8d6,0x8(%esp)
 1f2:	00 
 1f3:	c7 44 24 04 45 08 00 	movl   $0x845,0x4(%esp)
 1fa:	00 
 1fb:	89 04 24             	mov    %eax,(%esp)
 1fe:	e8 6d 03 00 00       	call   570 <printf>
  exit();
 203:	e8 10 02 00 00       	call   418 <exit>
}

inline void check_arg_integer(const struct record *r, int v) {
  if (r->type != ARG_INTEGER || r->value.intval != v)
    handle_error("error check_arg_integer");
}
 208:	c9                   	leave  
 209:	c3                   	ret    
 20a:	90                   	nop    
 20b:	90                   	nop    
 20c:	90                   	nop    
 20d:	90                   	nop    
 20e:	90                   	nop    
 20f:	90                   	nop    

00000210 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	53                   	push   %ebx
 214:	8b 5d 08             	mov    0x8(%ebp),%ebx
 217:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 21a:	89 da                	mov    %ebx,%edx
 21c:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 220:	0f b6 01             	movzbl (%ecx),%eax
 223:	83 c1 01             	add    $0x1,%ecx
 226:	88 02                	mov    %al,(%edx)
 228:	83 c2 01             	add    $0x1,%edx
 22b:	84 c0                	test   %al,%al
 22d:	75 f1                	jne    220 <strcpy+0x10>
    ;
  return os;
}
 22f:	89 d8                	mov    %ebx,%eax
 231:	5b                   	pop    %ebx
 232:	5d                   	pop    %ebp
 233:	c3                   	ret    
 234:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 23a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000240 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	8b 4d 08             	mov    0x8(%ebp),%ecx
 246:	53                   	push   %ebx
 247:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 24a:	0f b6 01             	movzbl (%ecx),%eax
 24d:	84 c0                	test   %al,%al
 24f:	74 24                	je     275 <strcmp+0x35>
 251:	0f b6 13             	movzbl (%ebx),%edx
 254:	38 d0                	cmp    %dl,%al
 256:	74 12                	je     26a <strcmp+0x2a>
 258:	eb 1e                	jmp    278 <strcmp+0x38>
 25a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 260:	0f b6 13             	movzbl (%ebx),%edx
 263:	83 c1 01             	add    $0x1,%ecx
 266:	38 d0                	cmp    %dl,%al
 268:	75 0e                	jne    278 <strcmp+0x38>
 26a:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 26e:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 271:	84 c0                	test   %al,%al
 273:	75 eb                	jne    260 <strcmp+0x20>
 275:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 278:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 279:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 27c:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 27d:	0f b6 d2             	movzbl %dl,%edx
 280:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 282:	c3                   	ret    
 283:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000290 <strlen>:

uint
strlen(char *s)
{
 290:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 291:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 293:	89 e5                	mov    %esp,%ebp
 295:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 298:	80 39 00             	cmpb   $0x0,(%ecx)
 29b:	74 0e                	je     2ab <strlen+0x1b>
 29d:	31 d2                	xor    %edx,%edx
 29f:	90                   	nop    
 2a0:	83 c2 01             	add    $0x1,%edx
 2a3:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
 2a7:	89 d0                	mov    %edx,%eax
 2a9:	75 f5                	jne    2a0 <strlen+0x10>
    ;
  return n;
}
 2ab:	5d                   	pop    %ebp
 2ac:	c3                   	ret    
 2ad:	8d 76 00             	lea    0x0(%esi),%esi

000002b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	8b 55 08             	mov    0x8(%ebp),%edx
 2b6:	57                   	push   %edi
 2b7:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ba:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 2bd:	89 d7                	mov    %edx,%edi
 2bf:	fc                   	cld    
 2c0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 2c2:	5f                   	pop    %edi
 2c3:	89 d0                	mov    %edx,%eax
 2c5:	5d                   	pop    %ebp
 2c6:	c3                   	ret    
 2c7:	89 f6                	mov    %esi,%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000002d0 <strchr>:

char*
strchr(const char *s, char c)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	8b 45 08             	mov    0x8(%ebp),%eax
 2d6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 2da:	0f b6 10             	movzbl (%eax),%edx
 2dd:	84 d2                	test   %dl,%dl
 2df:	75 0c                	jne    2ed <strchr+0x1d>
 2e1:	eb 11                	jmp    2f4 <strchr+0x24>
 2e3:	83 c0 01             	add    $0x1,%eax
 2e6:	0f b6 10             	movzbl (%eax),%edx
 2e9:	84 d2                	test   %dl,%dl
 2eb:	74 07                	je     2f4 <strchr+0x24>
    if(*s == c)
 2ed:	38 ca                	cmp    %cl,%dl
 2ef:	90                   	nop    
 2f0:	75 f1                	jne    2e3 <strchr+0x13>
      return (char*) s;
  return 0;
}
 2f2:	5d                   	pop    %ebp
 2f3:	c3                   	ret    
 2f4:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2f5:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 2f7:	c3                   	ret    
 2f8:	90                   	nop    
 2f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000300 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	8b 4d 08             	mov    0x8(%ebp),%ecx
 306:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 307:	31 db                	xor    %ebx,%ebx
 309:	0f b6 11             	movzbl (%ecx),%edx
 30c:	8d 42 d0             	lea    -0x30(%edx),%eax
 30f:	3c 09                	cmp    $0x9,%al
 311:	77 18                	ja     32b <atoi+0x2b>
    n = n*10 + *s++ - '0';
 313:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 316:	0f be d2             	movsbl %dl,%edx
 319:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 31d:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 321:	83 c1 01             	add    $0x1,%ecx
 324:	8d 42 d0             	lea    -0x30(%edx),%eax
 327:	3c 09                	cmp    $0x9,%al
 329:	76 e8                	jbe    313 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 32b:	89 d8                	mov    %ebx,%eax
 32d:	5b                   	pop    %ebx
 32e:	5d                   	pop    %ebp
 32f:	c3                   	ret    

00000330 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	8b 4d 10             	mov    0x10(%ebp),%ecx
 336:	56                   	push   %esi
 337:	8b 75 08             	mov    0x8(%ebp),%esi
 33a:	53                   	push   %ebx
 33b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 33e:	85 c9                	test   %ecx,%ecx
 340:	7e 10                	jle    352 <memmove+0x22>
 342:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 344:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 348:	88 04 32             	mov    %al,(%edx,%esi,1)
 34b:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 34e:	39 ca                	cmp    %ecx,%edx
 350:	75 f2                	jne    344 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 352:	89 f0                	mov    %esi,%eax
 354:	5b                   	pop    %ebx
 355:	5e                   	pop    %esi
 356:	5d                   	pop    %ebp
 357:	c3                   	ret    
 358:	90                   	nop    
 359:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000360 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 366:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 369:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 36c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 36f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 374:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 37b:	00 
 37c:	89 04 24             	mov    %eax,(%esp)
 37f:	e8 d4 00 00 00       	call   458 <open>
  if(fd < 0)
 384:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 386:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 388:	78 19                	js     3a3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 38a:	8b 45 0c             	mov    0xc(%ebp),%eax
 38d:	89 1c 24             	mov    %ebx,(%esp)
 390:	89 44 24 04          	mov    %eax,0x4(%esp)
 394:	e8 d7 00 00 00       	call   470 <fstat>
  close(fd);
 399:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 39c:	89 c6                	mov    %eax,%esi
  close(fd);
 39e:	e8 9d 00 00 00       	call   440 <close>
  return r;
}
 3a3:	89 f0                	mov    %esi,%eax
 3a5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 3a8:	8b 75 fc             	mov    -0x4(%ebp),%esi
 3ab:	89 ec                	mov    %ebp,%esp
 3ad:	5d                   	pop    %ebp
 3ae:	c3                   	ret    
 3af:	90                   	nop    

000003b0 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	57                   	push   %edi
 3b4:	56                   	push   %esi
 3b5:	31 f6                	xor    %esi,%esi
 3b7:	53                   	push   %ebx
 3b8:	83 ec 1c             	sub    $0x1c,%esp
 3bb:	8b 7d 08             	mov    0x8(%ebp),%edi
 3be:	eb 06                	jmp    3c6 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3c0:	3c 0d                	cmp    $0xd,%al
 3c2:	74 39                	je     3fd <gets+0x4d>
 3c4:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3c6:	8d 5e 01             	lea    0x1(%esi),%ebx
 3c9:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3cc:	7d 31                	jge    3ff <gets+0x4f>
    cc = read(0, &c, 1);
 3ce:	8d 45 f3             	lea    -0xd(%ebp),%eax
 3d1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3d8:	00 
 3d9:	89 44 24 04          	mov    %eax,0x4(%esp)
 3dd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 3e4:	e8 47 00 00 00       	call   430 <read>
    if(cc < 1)
 3e9:	85 c0                	test   %eax,%eax
 3eb:	7e 12                	jle    3ff <gets+0x4f>
      break;
    buf[i++] = c;
 3ed:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 3f1:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 3f5:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 3f9:	3c 0a                	cmp    $0xa,%al
 3fb:	75 c3                	jne    3c0 <gets+0x10>
 3fd:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 3ff:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 403:	89 f8                	mov    %edi,%eax
 405:	83 c4 1c             	add    $0x1c,%esp
 408:	5b                   	pop    %ebx
 409:	5e                   	pop    %esi
 40a:	5f                   	pop    %edi
 40b:	5d                   	pop    %ebp
 40c:	c3                   	ret    
 40d:	90                   	nop    
 40e:	90                   	nop    
 40f:	90                   	nop    

00000410 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 410:	b8 01 00 00 00       	mov    $0x1,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <exit>:
SYSCALL(exit)
 418:	b8 02 00 00 00       	mov    $0x2,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <wait>:
SYSCALL(wait)
 420:	b8 03 00 00 00       	mov    $0x3,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <pipe>:
SYSCALL(pipe)
 428:	b8 04 00 00 00       	mov    $0x4,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <read>:
SYSCALL(read)
 430:	b8 06 00 00 00       	mov    $0x6,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    

00000438 <write>:
SYSCALL(write)
 438:	b8 05 00 00 00       	mov    $0x5,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <close>:
SYSCALL(close)
 440:	b8 07 00 00 00       	mov    $0x7,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <kill>:
SYSCALL(kill)
 448:	b8 08 00 00 00       	mov    $0x8,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <exec>:
SYSCALL(exec)
 450:	b8 09 00 00 00       	mov    $0x9,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    

00000458 <open>:
SYSCALL(open)
 458:	b8 0a 00 00 00       	mov    $0xa,%eax
 45d:	cd 40                	int    $0x40
 45f:	c3                   	ret    

00000460 <mknod>:
SYSCALL(mknod)
 460:	b8 0b 00 00 00       	mov    $0xb,%eax
 465:	cd 40                	int    $0x40
 467:	c3                   	ret    

00000468 <unlink>:
SYSCALL(unlink)
 468:	b8 0c 00 00 00       	mov    $0xc,%eax
 46d:	cd 40                	int    $0x40
 46f:	c3                   	ret    

00000470 <fstat>:
SYSCALL(fstat)
 470:	b8 0d 00 00 00       	mov    $0xd,%eax
 475:	cd 40                	int    $0x40
 477:	c3                   	ret    

00000478 <link>:
SYSCALL(link)
 478:	b8 0e 00 00 00       	mov    $0xe,%eax
 47d:	cd 40                	int    $0x40
 47f:	c3                   	ret    

00000480 <mkdir>:
SYSCALL(mkdir)
 480:	b8 0f 00 00 00       	mov    $0xf,%eax
 485:	cd 40                	int    $0x40
 487:	c3                   	ret    

00000488 <chdir>:
SYSCALL(chdir)
 488:	b8 10 00 00 00       	mov    $0x10,%eax
 48d:	cd 40                	int    $0x40
 48f:	c3                   	ret    

00000490 <dup>:
SYSCALL(dup)
 490:	b8 11 00 00 00       	mov    $0x11,%eax
 495:	cd 40                	int    $0x40
 497:	c3                   	ret    

00000498 <getpid>:
SYSCALL(getpid)
 498:	b8 12 00 00 00       	mov    $0x12,%eax
 49d:	cd 40                	int    $0x40
 49f:	c3                   	ret    

000004a0 <sbrk>:
SYSCALL(sbrk)
 4a0:	b8 13 00 00 00       	mov    $0x13,%eax
 4a5:	cd 40                	int    $0x40
 4a7:	c3                   	ret    

000004a8 <sleep>:
SYSCALL(sleep)
 4a8:	b8 14 00 00 00       	mov    $0x14,%eax
 4ad:	cd 40                	int    $0x40
 4af:	c3                   	ret    

000004b0 <uptime>:
SYSCALL(uptime)
 4b0:	b8 15 00 00 00       	mov    $0x15,%eax
 4b5:	cd 40                	int    $0x40
 4b7:	c3                   	ret    
 4b8:	90                   	nop    
 4b9:	90                   	nop    
 4ba:	90                   	nop    
 4bb:	90                   	nop    
 4bc:	90                   	nop    
 4bd:	90                   	nop    
 4be:	90                   	nop    
 4bf:	90                   	nop    

000004c0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	83 ec 18             	sub    $0x18,%esp
 4c6:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 4c9:	8d 55 fc             	lea    -0x4(%ebp),%edx
 4cc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4d3:	00 
 4d4:	89 54 24 04          	mov    %edx,0x4(%esp)
 4d8:	89 04 24             	mov    %eax,(%esp)
 4db:	e8 58 ff ff ff       	call   438 <write>
}
 4e0:	c9                   	leave  
 4e1:	c3                   	ret    
 4e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 4e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000004f0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	57                   	push   %edi
 4f4:	56                   	push   %esi
 4f5:	89 ce                	mov    %ecx,%esi
 4f7:	53                   	push   %ebx
 4f8:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4fb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4fe:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 501:	85 c9                	test   %ecx,%ecx
 503:	74 04                	je     509 <printint+0x19>
 505:	85 d2                	test   %edx,%edx
 507:	78 54                	js     55d <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 509:	89 d0                	mov    %edx,%eax
 50b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 512:	31 db                	xor    %ebx,%ebx
 514:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 517:	31 d2                	xor    %edx,%edx
 519:	f7 f6                	div    %esi
 51b:	89 c1                	mov    %eax,%ecx
 51d:	0f b6 82 f5 08 00 00 	movzbl 0x8f5(%edx),%eax
 524:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 527:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 52a:	85 c9                	test   %ecx,%ecx
 52c:	89 c8                	mov    %ecx,%eax
 52e:	75 e7                	jne    517 <printint+0x27>
  if(neg)
 530:	8b 45 e0             	mov    -0x20(%ebp),%eax
 533:	85 c0                	test   %eax,%eax
 535:	74 08                	je     53f <printint+0x4f>
    buf[i++] = '-';
 537:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 53c:	83 c3 01             	add    $0x1,%ebx
 53f:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 542:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 546:	83 eb 01             	sub    $0x1,%ebx
 549:	8b 45 dc             	mov    -0x24(%ebp),%eax
 54c:	e8 6f ff ff ff       	call   4c0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 551:	39 fb                	cmp    %edi,%ebx
 553:	75 ed                	jne    542 <printint+0x52>
    putc(fd, buf[i]);
}
 555:	83 c4 1c             	add    $0x1c,%esp
 558:	5b                   	pop    %ebx
 559:	5e                   	pop    %esi
 55a:	5f                   	pop    %edi
 55b:	5d                   	pop    %ebp
 55c:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 55d:	89 d0                	mov    %edx,%eax
 55f:	f7 d8                	neg    %eax
 561:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 568:	eb a8                	jmp    512 <printint+0x22>
 56a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000570 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 570:	55                   	push   %ebp
 571:	89 e5                	mov    %esp,%ebp
 573:	57                   	push   %edi
 574:	56                   	push   %esi
 575:	53                   	push   %ebx
 576:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 579:	8b 55 0c             	mov    0xc(%ebp),%edx
 57c:	0f b6 02             	movzbl (%edx),%eax
 57f:	84 c0                	test   %al,%al
 581:	0f 84 87 00 00 00    	je     60e <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 587:	8d 4d 10             	lea    0x10(%ebp),%ecx
 58a:	31 ff                	xor    %edi,%edi
 58c:	31 f6                	xor    %esi,%esi
 58e:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 591:	eb 18                	jmp    5ab <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 593:	83 fb 25             	cmp    $0x25,%ebx
 596:	0f 85 7a 00 00 00    	jne    616 <printf+0xa6>
 59c:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5a0:	83 c7 01             	add    $0x1,%edi
 5a3:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 5a7:	84 c0                	test   %al,%al
 5a9:	74 63                	je     60e <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 5ab:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 5ad:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 5b0:	74 e1                	je     593 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5b2:	83 fe 25             	cmp    $0x25,%esi
 5b5:	75 e9                	jne    5a0 <printf+0x30>
      if(c == 'd'){
 5b7:	83 fb 64             	cmp    $0x64,%ebx
 5ba:	0f 84 f0 00 00 00    	je     6b0 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5c0:	83 fb 78             	cmp    $0x78,%ebx
 5c3:	74 64                	je     629 <printf+0xb9>
 5c5:	83 fb 70             	cmp    $0x70,%ebx
 5c8:	74 5f                	je     629 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5ca:	83 fb 73             	cmp    $0x73,%ebx
 5cd:	8d 76 00             	lea    0x0(%esi),%esi
 5d0:	74 7e                	je     650 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5d2:	83 fb 63             	cmp    $0x63,%ebx
 5d5:	0f 84 b9 00 00 00    	je     694 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5db:	83 fb 25             	cmp    $0x25,%ebx
 5de:	66 90                	xchg   %ax,%ax
 5e0:	0f 84 f2 00 00 00    	je     6d8 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5e6:	8b 45 08             	mov    0x8(%ebp),%eax
 5e9:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5ee:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 5f1:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5f3:	e8 c8 fe ff ff       	call   4c0 <putc>
        putc(fd, c);
 5f8:	8b 45 08             	mov    0x8(%ebp),%eax
 5fb:	0f be d3             	movsbl %bl,%edx
 5fe:	e8 bd fe ff ff       	call   4c0 <putc>
 603:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 606:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 60a:	84 c0                	test   %al,%al
 60c:	75 9d                	jne    5ab <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 60e:	83 c4 0c             	add    $0xc,%esp
 611:	5b                   	pop    %ebx
 612:	5e                   	pop    %esi
 613:	5f                   	pop    %edi
 614:	5d                   	pop    %ebp
 615:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 616:	8b 45 08             	mov    0x8(%ebp),%eax
 619:	0f be d3             	movsbl %bl,%edx
 61c:	e8 9f fe ff ff       	call   4c0 <putc>
 621:	8b 55 0c             	mov    0xc(%ebp),%edx
 624:	e9 77 ff ff ff       	jmp    5a0 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 629:	8b 45 f0             	mov    -0x10(%ebp),%eax
 62c:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 631:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 633:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 63a:	8b 10                	mov    (%eax),%edx
 63c:	8b 45 08             	mov    0x8(%ebp),%eax
 63f:	e8 ac fe ff ff       	call   4f0 <printint>
 644:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 647:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 64b:	e9 50 ff ff ff       	jmp    5a0 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 650:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 653:	8b 01                	mov    (%ecx),%eax
        ap++;
 655:	83 c1 04             	add    $0x4,%ecx
 658:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 65b:	b9 ee 08 00 00       	mov    $0x8ee,%ecx
 660:	85 c0                	test   %eax,%eax
 662:	75 2c                	jne    690 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 664:	0f b6 01             	movzbl (%ecx),%eax
 667:	84 c0                	test   %al,%al
 669:	74 1e                	je     689 <printf+0x119>
 66b:	89 cb                	mov    %ecx,%ebx
 66d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 670:	0f be d0             	movsbl %al,%edx
 673:	8b 45 08             	mov    0x8(%ebp),%eax
 676:	e8 45 fe ff ff       	call   4c0 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 67b:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 67f:	83 c3 01             	add    $0x1,%ebx
 682:	84 c0                	test   %al,%al
 684:	75 ea                	jne    670 <printf+0x100>
 686:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 689:	31 f6                	xor    %esi,%esi
 68b:	e9 10 ff ff ff       	jmp    5a0 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 690:	89 c1                	mov    %eax,%ecx
 692:	eb d0                	jmp    664 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 694:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 697:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 699:	0f be 10             	movsbl (%eax),%edx
 69c:	8b 45 08             	mov    0x8(%ebp),%eax
 69f:	e8 1c fe ff ff       	call   4c0 <putc>
 6a4:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 6a7:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 6ab:	e9 f0 fe ff ff       	jmp    5a0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 6b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6b3:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 6b8:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 6bb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 6c2:	8b 10                	mov    (%eax),%edx
 6c4:	8b 45 08             	mov    0x8(%ebp),%eax
 6c7:	e8 24 fe ff ff       	call   4f0 <printint>
 6cc:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 6cf:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 6d3:	e9 c8 fe ff ff       	jmp    5a0 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 6d8:	8b 45 08             	mov    0x8(%ebp),%eax
 6db:	ba 25 00 00 00       	mov    $0x25,%edx
 6e0:	31 f6                	xor    %esi,%esi
 6e2:	e8 d9 fd ff ff       	call   4c0 <putc>
 6e7:	8b 55 0c             	mov    0xc(%ebp),%edx
 6ea:	e9 b1 fe ff ff       	jmp    5a0 <printf+0x30>
 6ef:	90                   	nop    

000006f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f1:	8b 0d 18 09 00 00    	mov    0x918,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 6f7:	89 e5                	mov    %esp,%ebp
 6f9:	56                   	push   %esi
 6fa:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 6fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6fe:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 701:	39 d9                	cmp    %ebx,%ecx
 703:	73 18                	jae    71d <free+0x2d>
 705:	8b 11                	mov    (%ecx),%edx
 707:	39 d3                	cmp    %edx,%ebx
 709:	72 17                	jb     722 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 70b:	39 d1                	cmp    %edx,%ecx
 70d:	72 08                	jb     717 <free+0x27>
 70f:	39 d9                	cmp    %ebx,%ecx
 711:	72 0f                	jb     722 <free+0x32>
 713:	39 d3                	cmp    %edx,%ebx
 715:	72 0b                	jb     722 <free+0x32>
 717:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 719:	39 d9                	cmp    %ebx,%ecx
 71b:	72 e8                	jb     705 <free+0x15>
 71d:	8b 11                	mov    (%ecx),%edx
 71f:	90                   	nop    
 720:	eb e9                	jmp    70b <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 722:	8b 73 04             	mov    0x4(%ebx),%esi
 725:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 728:	39 d0                	cmp    %edx,%eax
 72a:	74 18                	je     744 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 72c:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 72e:	8b 51 04             	mov    0x4(%ecx),%edx
 731:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 734:	39 d8                	cmp    %ebx,%eax
 736:	74 20                	je     758 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 738:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 73a:	5b                   	pop    %ebx
 73b:	5e                   	pop    %esi
 73c:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 73d:	89 0d 18 09 00 00    	mov    %ecx,0x918
}
 743:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 744:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 747:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 749:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 74c:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 74f:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 751:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 754:	39 d8                	cmp    %ebx,%eax
 756:	75 e0                	jne    738 <free+0x48>
    p->s.size += bp->s.size;
 758:	03 53 04             	add    0x4(%ebx),%edx
 75b:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 75e:	8b 13                	mov    (%ebx),%edx
 760:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 762:	5b                   	pop    %ebx
 763:	5e                   	pop    %esi
 764:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 765:	89 0d 18 09 00 00    	mov    %ecx,0x918
}
 76b:	c3                   	ret    
 76c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000770 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 770:	55                   	push   %ebp
 771:	89 e5                	mov    %esp,%ebp
 773:	57                   	push   %edi
 774:	56                   	push   %esi
 775:	53                   	push   %ebx
 776:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 779:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 77c:	8b 15 18 09 00 00    	mov    0x918,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 782:	83 c0 07             	add    $0x7,%eax
 785:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 788:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 78a:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 78d:	0f 84 8a 00 00 00    	je     81d <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 793:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 795:	8b 41 04             	mov    0x4(%ecx),%eax
 798:	39 c3                	cmp    %eax,%ebx
 79a:	76 1a                	jbe    7b6 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 79c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 7a3:	3b 0d 18 09 00 00    	cmp    0x918,%ecx
 7a9:	89 ca                	mov    %ecx,%edx
 7ab:	74 29                	je     7d6 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ad:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 7af:	8b 41 04             	mov    0x4(%ecx),%eax
 7b2:	39 c3                	cmp    %eax,%ebx
 7b4:	77 ed                	ja     7a3 <malloc+0x33>
      if(p->s.size == nunits)
 7b6:	39 c3                	cmp    %eax,%ebx
 7b8:	74 5d                	je     817 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 7ba:	29 d8                	sub    %ebx,%eax
 7bc:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 7bf:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 7c2:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 7c5:	89 15 18 09 00 00    	mov    %edx,0x918
      return (void*) (p + 1);
 7cb:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7ce:	83 c4 0c             	add    $0xc,%esp
 7d1:	5b                   	pop    %ebx
 7d2:	5e                   	pop    %esi
 7d3:	5f                   	pop    %edi
 7d4:	5d                   	pop    %ebp
 7d5:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 7d6:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 7dc:	89 de                	mov    %ebx,%esi
 7de:	89 f8                	mov    %edi,%eax
 7e0:	76 29                	jbe    80b <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 7e2:	89 04 24             	mov    %eax,(%esp)
 7e5:	e8 b6 fc ff ff       	call   4a0 <sbrk>
  if(p == (char*) -1)
 7ea:	83 f8 ff             	cmp    $0xffffffff,%eax
 7ed:	74 18                	je     807 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 7ef:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 7f2:	83 c0 08             	add    $0x8,%eax
 7f5:	89 04 24             	mov    %eax,(%esp)
 7f8:	e8 f3 fe ff ff       	call   6f0 <free>
  return freep;
 7fd:	8b 15 18 09 00 00    	mov    0x918,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 803:	85 d2                	test   %edx,%edx
 805:	75 a6                	jne    7ad <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 807:	31 c0                	xor    %eax,%eax
 809:	eb c3                	jmp    7ce <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 80b:	be 00 10 00 00       	mov    $0x1000,%esi
 810:	b8 00 80 00 00       	mov    $0x8000,%eax
 815:	eb cb                	jmp    7e2 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 817:	8b 01                	mov    (%ecx),%eax
 819:	89 02                	mov    %eax,(%edx)
 81b:	eb a8                	jmp    7c5 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 81d:	ba 10 09 00 00       	mov    $0x910,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 822:	c7 05 18 09 00 00 10 	movl   $0x910,0x918
 829:	09 00 00 
 82c:	c7 05 10 09 00 00 10 	movl   $0x910,0x910
 833:	09 00 00 
    base.s.size = 0;
 836:	c7 05 14 09 00 00 00 	movl   $0x0,0x914
 83d:	00 00 00 
 840:	e9 4e ff ff ff       	jmp    793 <malloc+0x23>
