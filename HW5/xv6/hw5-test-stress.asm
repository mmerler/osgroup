
_hw5-test-stress:     file format elf32-i386

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
   9:	c7 44 24 04 35 07 00 	movl   $0x735,0x4(%esp)
  10:	00 
  11:	89 44 24 08          	mov    %eax,0x8(%esp)
  15:	a1 80 07 00 00       	mov    0x780,%eax
  1a:	89 04 24             	mov    %eax,(%esp)
  1d:	e8 3e 04 00 00       	call   460 <printf>
  exit();
  22:	e8 e1 02 00 00       	call   308 <exit>
  27:	89 f6                	mov    %esi,%esi
  29:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000030 <main>:
#define MAX_SIZE (64 * 1024)
#define N_PROCS (32)

int buf[MAX_SIZE];

int main() {
  30:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  34:	83 e4 f0             	and    $0xfffffff0,%esp
  37:	ff 71 fc             	pushl  -0x4(%ecx)

  int i;
	for (i = 0; i < MAX_SIZE; i++)
		buf[i] = 0;
  3a:	b8 01 00 00 00       	mov    $0x1,%eax
#define MAX_SIZE (64 * 1024)
#define N_PROCS (32)

int buf[MAX_SIZE];

int main() {
  3f:	55                   	push   %ebp
  40:	89 e5                	mov    %esp,%ebp
  42:	53                   	push   %ebx
  43:	51                   	push   %ecx
  44:	83 ec 10             	sub    $0x10,%esp

  int i;
	for (i = 0; i < MAX_SIZE; i++)
		buf[i] = 0;
  47:	c7 05 c0 07 00 00 00 	movl   $0x0,0x7c0
  4e:	00 00 00 
  51:	c7 04 85 c0 07 00 00 	movl   $0x0,0x7c0(,%eax,4)
  58:	00 00 00 00 
int buf[MAX_SIZE];

int main() {

  int i;
	for (i = 0; i < MAX_SIZE; i++)
  5c:	83 c0 01             	add    $0x1,%eax
  5f:	3d 00 00 01 00       	cmp    $0x10000,%eax
  64:	75 eb                	jne    51 <main+0x21>
  66:	31 db                	xor    %ebx,%ebx
  68:	eb 0a                	jmp    74 <main+0x44>
  int root = 1;
  for (i = 0; i + 1 < N_PROCS; i++) {
    int child_pid = fork();
    if (child_pid < 0)
      panic("fork");
    if (child_pid == 0) {
  6a:	74 70                	je     dc <main+0xac>
  int i;
	for (i = 0; i < MAX_SIZE; i++)
		buf[i] = 0;

  int root = 1;
  for (i = 0; i + 1 < N_PROCS; i++) {
  6c:	83 c3 01             	add    $0x1,%ebx
  6f:	83 fb 1f             	cmp    $0x1f,%ebx
  72:	74 2c                	je     a0 <main+0x70>
    int child_pid = fork();
  74:	e8 87 02 00 00       	call   300 <fork>
    if (child_pid < 0)
  79:	83 f8 00             	cmp    $0x0,%eax
  7c:	7d ec                	jge    6a <main+0x3a>
int stdin = 0;
int stdout = 1;
int stderr = 2;

inline __attribute__((noreturn)) void panic(const char *msg) {
  printf(stderr, "[panic] %s\n", msg);
  7e:	a1 80 07 00 00       	mov    0x780,%eax
  83:	c7 44 24 08 41 07 00 	movl   $0x741,0x8(%esp)
  8a:	00 
  8b:	c7 44 24 04 35 07 00 	movl   $0x735,0x4(%esp)
  92:	00 
  93:	89 04 24             	mov    %eax,(%esp)
  96:	e8 c5 03 00 00       	call   460 <printf>
  exit();
  9b:	e8 68 02 00 00       	call   308 <exit>
  int i;
	for (i = 0; i < MAX_SIZE; i++)
		buf[i] = 0;

  int root = 1;
  for (i = 0; i + 1 < N_PROCS; i++) {
  a0:	b3 01                	mov    $0x1,%bl
  a2:	31 d2                	xor    %edx,%edx
  }

	int j;
	for (j = 0; j < N_LOOPS; j++) {
		for (i = 0; i < MAX_SIZE; i++)
			++buf[i];
  a4:	83 05 c0 07 00 00 01 	addl   $0x1,0x7c0
  ab:	b8 01 00 00 00       	mov    $0x1,%eax
  b0:	83 04 85 c0 07 00 00 	addl   $0x1,0x7c0(,%eax,4)
  b7:	01 
		}
  }

	int j;
	for (j = 0; j < N_LOOPS; j++) {
		for (i = 0; i < MAX_SIZE; i++)
  b8:	83 c0 01             	add    $0x1,%eax
  bb:	3d 00 00 01 00       	cmp    $0x10000,%eax
  c0:	75 ee                	jne    b0 <main+0x80>
			break;
		}
  }

	int j;
	for (j = 0; j < N_LOOPS; j++) {
  c2:	83 c2 01             	add    $0x1,%edx
  c5:	83 fa 64             	cmp    $0x64,%edx
  c8:	75 da                	jne    a4 <main+0x74>
		for (i = 0; i < MAX_SIZE; i++)
			++buf[i];
	}

  // Wait for all children to exit. 
  while (wait() >= 0);
  ca:	e8 41 02 00 00       	call   310 <wait>
  cf:	85 c0                	test   %eax,%eax
  d1:	79 f7                	jns    ca <main+0x9a>

	if (!root)
  d3:	85 db                	test   %ebx,%ebx
  d5:	75 0b                	jne    e2 <main+0xb2>
		exit();
  
	printf(stdout, "hw5-test-stress succeeded\n");
  exit();
  d7:	e8 2c 02 00 00       	call   308 <exit>
  int root = 1;
  for (i = 0; i + 1 < N_PROCS; i++) {
    int child_pid = fork();
    if (child_pid < 0)
      panic("fork");
    if (child_pid == 0) {
  dc:	31 db                	xor    %ebx,%ebx
  de:	66 90                	xchg   %ax,%ax
  e0:	eb c0                	jmp    a2 <main+0x72>
  while (wait() >= 0);

	if (!root)
		exit();
  
	printf(stdout, "hw5-test-stress succeeded\n");
  e2:	a1 7c 07 00 00       	mov    0x77c,%eax
  e7:	c7 44 24 04 46 07 00 	movl   $0x746,0x4(%esp)
  ee:	00 
  ef:	89 04 24             	mov    %eax,(%esp)
  f2:	e8 69 03 00 00       	call   460 <printf>
  f7:	eb de                	jmp    d7 <main+0xa7>
  f9:	90                   	nop    
  fa:	90                   	nop    
  fb:	90                   	nop    
  fc:	90                   	nop    
  fd:	90                   	nop    
  fe:	90                   	nop    
  ff:	90                   	nop    

00000100 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	53                   	push   %ebx
 104:	8b 5d 08             	mov    0x8(%ebp),%ebx
 107:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 10a:	89 da                	mov    %ebx,%edx
 10c:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 110:	0f b6 01             	movzbl (%ecx),%eax
 113:	83 c1 01             	add    $0x1,%ecx
 116:	88 02                	mov    %al,(%edx)
 118:	83 c2 01             	add    $0x1,%edx
 11b:	84 c0                	test   %al,%al
 11d:	75 f1                	jne    110 <strcpy+0x10>
    ;
  return os;
}
 11f:	89 d8                	mov    %ebx,%eax
 121:	5b                   	pop    %ebx
 122:	5d                   	pop    %ebp
 123:	c3                   	ret    
 124:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 12a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000130 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	8b 4d 08             	mov    0x8(%ebp),%ecx
 136:	53                   	push   %ebx
 137:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 13a:	0f b6 01             	movzbl (%ecx),%eax
 13d:	84 c0                	test   %al,%al
 13f:	74 24                	je     165 <strcmp+0x35>
 141:	0f b6 13             	movzbl (%ebx),%edx
 144:	38 d0                	cmp    %dl,%al
 146:	74 12                	je     15a <strcmp+0x2a>
 148:	eb 1e                	jmp    168 <strcmp+0x38>
 14a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 150:	0f b6 13             	movzbl (%ebx),%edx
 153:	83 c1 01             	add    $0x1,%ecx
 156:	38 d0                	cmp    %dl,%al
 158:	75 0e                	jne    168 <strcmp+0x38>
 15a:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 15e:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 161:	84 c0                	test   %al,%al
 163:	75 eb                	jne    150 <strcmp+0x20>
 165:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 168:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 169:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 16c:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 16d:	0f b6 d2             	movzbl %dl,%edx
 170:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 172:	c3                   	ret    
 173:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 179:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000180 <strlen>:

uint
strlen(char *s)
{
 180:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 181:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 183:	89 e5                	mov    %esp,%ebp
 185:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 188:	80 39 00             	cmpb   $0x0,(%ecx)
 18b:	74 0e                	je     19b <strlen+0x1b>
 18d:	31 d2                	xor    %edx,%edx
 18f:	90                   	nop    
 190:	83 c2 01             	add    $0x1,%edx
 193:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
 197:	89 d0                	mov    %edx,%eax
 199:	75 f5                	jne    190 <strlen+0x10>
    ;
  return n;
}
 19b:	5d                   	pop    %ebp
 19c:	c3                   	ret    
 19d:	8d 76 00             	lea    0x0(%esi),%esi

000001a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	8b 55 08             	mov    0x8(%ebp),%edx
 1a6:	57                   	push   %edi
 1a7:	8b 45 0c             	mov    0xc(%ebp),%eax
 1aa:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1ad:	89 d7                	mov    %edx,%edi
 1af:	fc                   	cld    
 1b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1b2:	5f                   	pop    %edi
 1b3:	89 d0                	mov    %edx,%eax
 1b5:	5d                   	pop    %ebp
 1b6:	c3                   	ret    
 1b7:	89 f6                	mov    %esi,%esi
 1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000001c0 <strchr>:

char*
strchr(const char *s, char c)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 45 08             	mov    0x8(%ebp),%eax
 1c6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1ca:	0f b6 10             	movzbl (%eax),%edx
 1cd:	84 d2                	test   %dl,%dl
 1cf:	75 0c                	jne    1dd <strchr+0x1d>
 1d1:	eb 11                	jmp    1e4 <strchr+0x24>
 1d3:	83 c0 01             	add    $0x1,%eax
 1d6:	0f b6 10             	movzbl (%eax),%edx
 1d9:	84 d2                	test   %dl,%dl
 1db:	74 07                	je     1e4 <strchr+0x24>
    if(*s == c)
 1dd:	38 ca                	cmp    %cl,%dl
 1df:	90                   	nop    
 1e0:	75 f1                	jne    1d3 <strchr+0x13>
      return (char*) s;
  return 0;
}
 1e2:	5d                   	pop    %ebp
 1e3:	c3                   	ret    
 1e4:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1e5:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 1e7:	c3                   	ret    
 1e8:	90                   	nop    
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000001f0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1f6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1f7:	31 db                	xor    %ebx,%ebx
 1f9:	0f b6 11             	movzbl (%ecx),%edx
 1fc:	8d 42 d0             	lea    -0x30(%edx),%eax
 1ff:	3c 09                	cmp    $0x9,%al
 201:	77 18                	ja     21b <atoi+0x2b>
    n = n*10 + *s++ - '0';
 203:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 206:	0f be d2             	movsbl %dl,%edx
 209:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 20d:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 211:	83 c1 01             	add    $0x1,%ecx
 214:	8d 42 d0             	lea    -0x30(%edx),%eax
 217:	3c 09                	cmp    $0x9,%al
 219:	76 e8                	jbe    203 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 21b:	89 d8                	mov    %ebx,%eax
 21d:	5b                   	pop    %ebx
 21e:	5d                   	pop    %ebp
 21f:	c3                   	ret    

00000220 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	8b 4d 10             	mov    0x10(%ebp),%ecx
 226:	56                   	push   %esi
 227:	8b 75 08             	mov    0x8(%ebp),%esi
 22a:	53                   	push   %ebx
 22b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 22e:	85 c9                	test   %ecx,%ecx
 230:	7e 10                	jle    242 <memmove+0x22>
 232:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 234:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 238:	88 04 32             	mov    %al,(%edx,%esi,1)
 23b:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 23e:	39 ca                	cmp    %ecx,%edx
 240:	75 f2                	jne    234 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 242:	89 f0                	mov    %esi,%eax
 244:	5b                   	pop    %ebx
 245:	5e                   	pop    %esi
 246:	5d                   	pop    %ebp
 247:	c3                   	ret    
 248:	90                   	nop    
 249:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000250 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 256:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 259:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 25c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 25f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 264:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 26b:	00 
 26c:	89 04 24             	mov    %eax,(%esp)
 26f:	e8 d4 00 00 00       	call   348 <open>
  if(fd < 0)
 274:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 276:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 278:	78 19                	js     293 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 27a:	8b 45 0c             	mov    0xc(%ebp),%eax
 27d:	89 1c 24             	mov    %ebx,(%esp)
 280:	89 44 24 04          	mov    %eax,0x4(%esp)
 284:	e8 d7 00 00 00       	call   360 <fstat>
  close(fd);
 289:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 28c:	89 c6                	mov    %eax,%esi
  close(fd);
 28e:	e8 9d 00 00 00       	call   330 <close>
  return r;
}
 293:	89 f0                	mov    %esi,%eax
 295:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 298:	8b 75 fc             	mov    -0x4(%ebp),%esi
 29b:	89 ec                	mov    %ebp,%esp
 29d:	5d                   	pop    %ebp
 29e:	c3                   	ret    
 29f:	90                   	nop    

000002a0 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	57                   	push   %edi
 2a4:	56                   	push   %esi
 2a5:	31 f6                	xor    %esi,%esi
 2a7:	53                   	push   %ebx
 2a8:	83 ec 1c             	sub    $0x1c,%esp
 2ab:	8b 7d 08             	mov    0x8(%ebp),%edi
 2ae:	eb 06                	jmp    2b6 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2b0:	3c 0d                	cmp    $0xd,%al
 2b2:	74 39                	je     2ed <gets+0x4d>
 2b4:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2b6:	8d 5e 01             	lea    0x1(%esi),%ebx
 2b9:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2bc:	7d 31                	jge    2ef <gets+0x4f>
    cc = read(0, &c, 1);
 2be:	8d 45 f3             	lea    -0xd(%ebp),%eax
 2c1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2c8:	00 
 2c9:	89 44 24 04          	mov    %eax,0x4(%esp)
 2cd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2d4:	e8 47 00 00 00       	call   320 <read>
    if(cc < 1)
 2d9:	85 c0                	test   %eax,%eax
 2db:	7e 12                	jle    2ef <gets+0x4f>
      break;
    buf[i++] = c;
 2dd:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 2e1:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 2e5:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 2e9:	3c 0a                	cmp    $0xa,%al
 2eb:	75 c3                	jne    2b0 <gets+0x10>
 2ed:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 2ef:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 2f3:	89 f8                	mov    %edi,%eax
 2f5:	83 c4 1c             	add    $0x1c,%esp
 2f8:	5b                   	pop    %ebx
 2f9:	5e                   	pop    %esi
 2fa:	5f                   	pop    %edi
 2fb:	5d                   	pop    %ebp
 2fc:	c3                   	ret    
 2fd:	90                   	nop    
 2fe:	90                   	nop    
 2ff:	90                   	nop    

00000300 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 300:	b8 01 00 00 00       	mov    $0x1,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <exit>:
SYSCALL(exit)
 308:	b8 02 00 00 00       	mov    $0x2,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <wait>:
SYSCALL(wait)
 310:	b8 03 00 00 00       	mov    $0x3,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <pipe>:
SYSCALL(pipe)
 318:	b8 04 00 00 00       	mov    $0x4,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <read>:
SYSCALL(read)
 320:	b8 06 00 00 00       	mov    $0x6,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <write>:
SYSCALL(write)
 328:	b8 05 00 00 00       	mov    $0x5,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <close>:
SYSCALL(close)
 330:	b8 07 00 00 00       	mov    $0x7,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <kill>:
SYSCALL(kill)
 338:	b8 08 00 00 00       	mov    $0x8,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <exec>:
SYSCALL(exec)
 340:	b8 09 00 00 00       	mov    $0x9,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <open>:
SYSCALL(open)
 348:	b8 0a 00 00 00       	mov    $0xa,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <mknod>:
SYSCALL(mknod)
 350:	b8 0b 00 00 00       	mov    $0xb,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <unlink>:
SYSCALL(unlink)
 358:	b8 0c 00 00 00       	mov    $0xc,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <fstat>:
SYSCALL(fstat)
 360:	b8 0d 00 00 00       	mov    $0xd,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <link>:
SYSCALL(link)
 368:	b8 0e 00 00 00       	mov    $0xe,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <mkdir>:
SYSCALL(mkdir)
 370:	b8 0f 00 00 00       	mov    $0xf,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <chdir>:
SYSCALL(chdir)
 378:	b8 10 00 00 00       	mov    $0x10,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <dup>:
SYSCALL(dup)
 380:	b8 11 00 00 00       	mov    $0x11,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <getpid>:
SYSCALL(getpid)
 388:	b8 12 00 00 00       	mov    $0x12,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <sbrk>:
SYSCALL(sbrk)
 390:	b8 13 00 00 00       	mov    $0x13,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <sleep>:
SYSCALL(sleep)
 398:	b8 14 00 00 00       	mov    $0x14,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <uptime>:
SYSCALL(uptime)
 3a0:	b8 15 00 00 00       	mov    $0x15,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <freepages>:
// Added by Jingyue
SYSCALL(freepages)
 3a8:	b8 16 00 00 00       	mov    $0x16,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	83 ec 18             	sub    $0x18,%esp
 3b6:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 3b9:	8d 55 fc             	lea    -0x4(%ebp),%edx
 3bc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3c3:	00 
 3c4:	89 54 24 04          	mov    %edx,0x4(%esp)
 3c8:	89 04 24             	mov    %eax,(%esp)
 3cb:	e8 58 ff ff ff       	call   328 <write>
}
 3d0:	c9                   	leave  
 3d1:	c3                   	ret    
 3d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 3d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000003e0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	56                   	push   %esi
 3e5:	89 ce                	mov    %ecx,%esi
 3e7:	53                   	push   %ebx
 3e8:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3eb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3ee:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3f1:	85 c9                	test   %ecx,%ecx
 3f3:	74 04                	je     3f9 <printint+0x19>
 3f5:	85 d2                	test   %edx,%edx
 3f7:	78 54                	js     44d <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3f9:	89 d0                	mov    %edx,%eax
 3fb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 402:	31 db                	xor    %ebx,%ebx
 404:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 407:	31 d2                	xor    %edx,%edx
 409:	f7 f6                	div    %esi
 40b:	89 c1                	mov    %eax,%ecx
 40d:	0f b6 82 68 07 00 00 	movzbl 0x768(%edx),%eax
 414:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 417:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 41a:	85 c9                	test   %ecx,%ecx
 41c:	89 c8                	mov    %ecx,%eax
 41e:	75 e7                	jne    407 <printint+0x27>
  if(neg)
 420:	8b 45 e0             	mov    -0x20(%ebp),%eax
 423:	85 c0                	test   %eax,%eax
 425:	74 08                	je     42f <printint+0x4f>
    buf[i++] = '-';
 427:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 42c:	83 c3 01             	add    $0x1,%ebx
 42f:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 432:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 436:	83 eb 01             	sub    $0x1,%ebx
 439:	8b 45 dc             	mov    -0x24(%ebp),%eax
 43c:	e8 6f ff ff ff       	call   3b0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 441:	39 fb                	cmp    %edi,%ebx
 443:	75 ed                	jne    432 <printint+0x52>
    putc(fd, buf[i]);
}
 445:	83 c4 1c             	add    $0x1c,%esp
 448:	5b                   	pop    %ebx
 449:	5e                   	pop    %esi
 44a:	5f                   	pop    %edi
 44b:	5d                   	pop    %ebp
 44c:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 44d:	89 d0                	mov    %edx,%eax
 44f:	f7 d8                	neg    %eax
 451:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 458:	eb a8                	jmp    402 <printint+0x22>
 45a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000460 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	56                   	push   %esi
 465:	53                   	push   %ebx
 466:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 469:	8b 55 0c             	mov    0xc(%ebp),%edx
 46c:	0f b6 02             	movzbl (%edx),%eax
 46f:	84 c0                	test   %al,%al
 471:	0f 84 87 00 00 00    	je     4fe <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 477:	8d 4d 10             	lea    0x10(%ebp),%ecx
 47a:	31 ff                	xor    %edi,%edi
 47c:	31 f6                	xor    %esi,%esi
 47e:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 481:	eb 18                	jmp    49b <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 483:	83 fb 25             	cmp    $0x25,%ebx
 486:	0f 85 7a 00 00 00    	jne    506 <printf+0xa6>
 48c:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 490:	83 c7 01             	add    $0x1,%edi
 493:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 497:	84 c0                	test   %al,%al
 499:	74 63                	je     4fe <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 49b:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 49d:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 4a0:	74 e1                	je     483 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4a2:	83 fe 25             	cmp    $0x25,%esi
 4a5:	75 e9                	jne    490 <printf+0x30>
      if(c == 'd'){
 4a7:	83 fb 64             	cmp    $0x64,%ebx
 4aa:	0f 84 f0 00 00 00    	je     5a0 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4b0:	83 fb 78             	cmp    $0x78,%ebx
 4b3:	74 64                	je     519 <printf+0xb9>
 4b5:	83 fb 70             	cmp    $0x70,%ebx
 4b8:	74 5f                	je     519 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4ba:	83 fb 73             	cmp    $0x73,%ebx
 4bd:	8d 76 00             	lea    0x0(%esi),%esi
 4c0:	74 7e                	je     540 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4c2:	83 fb 63             	cmp    $0x63,%ebx
 4c5:	0f 84 b9 00 00 00    	je     584 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4cb:	83 fb 25             	cmp    $0x25,%ebx
 4ce:	66 90                	xchg   %ax,%ax
 4d0:	0f 84 f2 00 00 00    	je     5c8 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 4d6:	8b 45 08             	mov    0x8(%ebp),%eax
 4d9:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4de:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4e1:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 4e3:	e8 c8 fe ff ff       	call   3b0 <putc>
        putc(fd, c);
 4e8:	8b 45 08             	mov    0x8(%ebp),%eax
 4eb:	0f be d3             	movsbl %bl,%edx
 4ee:	e8 bd fe ff ff       	call   3b0 <putc>
 4f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4f6:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 4fa:	84 c0                	test   %al,%al
 4fc:	75 9d                	jne    49b <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4fe:	83 c4 0c             	add    $0xc,%esp
 501:	5b                   	pop    %ebx
 502:	5e                   	pop    %esi
 503:	5f                   	pop    %edi
 504:	5d                   	pop    %ebp
 505:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 506:	8b 45 08             	mov    0x8(%ebp),%eax
 509:	0f be d3             	movsbl %bl,%edx
 50c:	e8 9f fe ff ff       	call   3b0 <putc>
 511:	8b 55 0c             	mov    0xc(%ebp),%edx
 514:	e9 77 ff ff ff       	jmp    490 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 519:	8b 45 f0             	mov    -0x10(%ebp),%eax
 51c:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 521:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 523:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 52a:	8b 10                	mov    (%eax),%edx
 52c:	8b 45 08             	mov    0x8(%ebp),%eax
 52f:	e8 ac fe ff ff       	call   3e0 <printint>
 534:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 537:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 53b:	e9 50 ff ff ff       	jmp    490 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 540:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 543:	8b 01                	mov    (%ecx),%eax
        ap++;
 545:	83 c1 04             	add    $0x4,%ecx
 548:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 54b:	b9 61 07 00 00       	mov    $0x761,%ecx
 550:	85 c0                	test   %eax,%eax
 552:	75 2c                	jne    580 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 554:	0f b6 01             	movzbl (%ecx),%eax
 557:	84 c0                	test   %al,%al
 559:	74 1e                	je     579 <printf+0x119>
 55b:	89 cb                	mov    %ecx,%ebx
 55d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 560:	0f be d0             	movsbl %al,%edx
 563:	8b 45 08             	mov    0x8(%ebp),%eax
 566:	e8 45 fe ff ff       	call   3b0 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 56b:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 56f:	83 c3 01             	add    $0x1,%ebx
 572:	84 c0                	test   %al,%al
 574:	75 ea                	jne    560 <printf+0x100>
 576:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 579:	31 f6                	xor    %esi,%esi
 57b:	e9 10 ff ff ff       	jmp    490 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 580:	89 c1                	mov    %eax,%ecx
 582:	eb d0                	jmp    554 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 584:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 587:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 589:	0f be 10             	movsbl (%eax),%edx
 58c:	8b 45 08             	mov    0x8(%ebp),%eax
 58f:	e8 1c fe ff ff       	call   3b0 <putc>
 594:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 597:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 59b:	e9 f0 fe ff ff       	jmp    490 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 5a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 5a8:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 5ab:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5b2:	8b 10                	mov    (%eax),%edx
 5b4:	8b 45 08             	mov    0x8(%ebp),%eax
 5b7:	e8 24 fe ff ff       	call   3e0 <printint>
 5bc:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 5bf:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 5c3:	e9 c8 fe ff ff       	jmp    490 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 5c8:	8b 45 08             	mov    0x8(%ebp),%eax
 5cb:	ba 25 00 00 00       	mov    $0x25,%edx
 5d0:	31 f6                	xor    %esi,%esi
 5d2:	e8 d9 fd ff ff       	call   3b0 <putc>
 5d7:	8b 55 0c             	mov    0xc(%ebp),%edx
 5da:	e9 b1 fe ff ff       	jmp    490 <printf+0x30>
 5df:	90                   	nop    

000005e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e1:	8b 0d ac 07 00 00    	mov    0x7ac,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 5e7:	89 e5                	mov    %esp,%ebp
 5e9:	56                   	push   %esi
 5ea:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 5eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5ee:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f1:	39 d9                	cmp    %ebx,%ecx
 5f3:	73 18                	jae    60d <free+0x2d>
 5f5:	8b 11                	mov    (%ecx),%edx
 5f7:	39 d3                	cmp    %edx,%ebx
 5f9:	72 17                	jb     612 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5fb:	39 d1                	cmp    %edx,%ecx
 5fd:	72 08                	jb     607 <free+0x27>
 5ff:	39 d9                	cmp    %ebx,%ecx
 601:	72 0f                	jb     612 <free+0x32>
 603:	39 d3                	cmp    %edx,%ebx
 605:	72 0b                	jb     612 <free+0x32>
 607:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 609:	39 d9                	cmp    %ebx,%ecx
 60b:	72 e8                	jb     5f5 <free+0x15>
 60d:	8b 11                	mov    (%ecx),%edx
 60f:	90                   	nop    
 610:	eb e9                	jmp    5fb <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 612:	8b 73 04             	mov    0x4(%ebx),%esi
 615:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 618:	39 d0                	cmp    %edx,%eax
 61a:	74 18                	je     634 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 61c:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 61e:	8b 51 04             	mov    0x4(%ecx),%edx
 621:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 624:	39 d8                	cmp    %ebx,%eax
 626:	74 20                	je     648 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 628:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 62a:	5b                   	pop    %ebx
 62b:	5e                   	pop    %esi
 62c:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 62d:	89 0d ac 07 00 00    	mov    %ecx,0x7ac
}
 633:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 634:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 637:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 639:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 63c:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 63f:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 641:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 644:	39 d8                	cmp    %ebx,%eax
 646:	75 e0                	jne    628 <free+0x48>
    p->s.size += bp->s.size;
 648:	03 53 04             	add    0x4(%ebx),%edx
 64b:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 64e:	8b 13                	mov    (%ebx),%edx
 650:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 652:	5b                   	pop    %ebx
 653:	5e                   	pop    %esi
 654:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 655:	89 0d ac 07 00 00    	mov    %ecx,0x7ac
}
 65b:	c3                   	ret    
 65c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000660 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 660:	55                   	push   %ebp
 661:	89 e5                	mov    %esp,%ebp
 663:	57                   	push   %edi
 664:	56                   	push   %esi
 665:	53                   	push   %ebx
 666:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 669:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 66c:	8b 15 ac 07 00 00    	mov    0x7ac,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 672:	83 c0 07             	add    $0x7,%eax
 675:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 678:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 67a:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 67d:	0f 84 8a 00 00 00    	je     70d <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 683:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 685:	8b 41 04             	mov    0x4(%ecx),%eax
 688:	39 c3                	cmp    %eax,%ebx
 68a:	76 1a                	jbe    6a6 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 68c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 693:	3b 0d ac 07 00 00    	cmp    0x7ac,%ecx
 699:	89 ca                	mov    %ecx,%edx
 69b:	74 29                	je     6c6 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 69d:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 69f:	8b 41 04             	mov    0x4(%ecx),%eax
 6a2:	39 c3                	cmp    %eax,%ebx
 6a4:	77 ed                	ja     693 <malloc+0x33>
      if(p->s.size == nunits)
 6a6:	39 c3                	cmp    %eax,%ebx
 6a8:	74 5d                	je     707 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 6aa:	29 d8                	sub    %ebx,%eax
 6ac:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 6af:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 6b2:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 6b5:	89 15 ac 07 00 00    	mov    %edx,0x7ac
      return (void*) (p + 1);
 6bb:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 6be:	83 c4 0c             	add    $0xc,%esp
 6c1:	5b                   	pop    %ebx
 6c2:	5e                   	pop    %esi
 6c3:	5f                   	pop    %edi
 6c4:	5d                   	pop    %ebp
 6c5:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 6c6:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 6cc:	89 de                	mov    %ebx,%esi
 6ce:	89 f8                	mov    %edi,%eax
 6d0:	76 29                	jbe    6fb <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 6d2:	89 04 24             	mov    %eax,(%esp)
 6d5:	e8 b6 fc ff ff       	call   390 <sbrk>
  if(p == (char*) -1)
 6da:	83 f8 ff             	cmp    $0xffffffff,%eax
 6dd:	74 18                	je     6f7 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 6df:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 6e2:	83 c0 08             	add    $0x8,%eax
 6e5:	89 04 24             	mov    %eax,(%esp)
 6e8:	e8 f3 fe ff ff       	call   5e0 <free>
  return freep;
 6ed:	8b 15 ac 07 00 00    	mov    0x7ac,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 6f3:	85 d2                	test   %edx,%edx
 6f5:	75 a6                	jne    69d <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6f7:	31 c0                	xor    %eax,%eax
 6f9:	eb c3                	jmp    6be <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 6fb:	be 00 10 00 00       	mov    $0x1000,%esi
 700:	b8 00 80 00 00       	mov    $0x8000,%eax
 705:	eb cb                	jmp    6d2 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 707:	8b 01                	mov    (%ecx),%eax
 709:	89 02                	mov    %eax,(%edx)
 70b:	eb a8                	jmp    6b5 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 70d:	ba a4 07 00 00       	mov    $0x7a4,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 712:	c7 05 ac 07 00 00 a4 	movl   $0x7a4,0x7ac
 719:	07 00 00 
 71c:	c7 05 a4 07 00 00 a4 	movl   $0x7a4,0x7a4
 723:	07 00 00 
    base.s.size = 0;
 726:	c7 05 a8 07 00 00 00 	movl   $0x0,0x7a8
 72d:	00 00 00 
 730:	e9 4e ff ff ff       	jmp    683 <malloc+0x23>
