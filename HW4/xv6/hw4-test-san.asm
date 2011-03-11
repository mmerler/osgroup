
_hw4-test-san:     file format elf32-i386

Disassembly of section .text:

00000000 <lengthy>:
  printf(stderr, "%s\n", msg);
  exit();
}

void lengthy(int *value, int N, int k)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 ec 10             	sub    $0x10,%esp
	static int level = -1;
	int i;
	level = level + 1;
   9:	8b 15 20 08 00 00    	mov    0x820,%edx
  printf(stderr, "%s\n", msg);
  exit();
}

void lengthy(int *value, int N, int k)
{
   f:	8b 7d 08             	mov    0x8(%ebp),%edi
  12:	8b 75 0c             	mov    0xc(%ebp),%esi
	static int level = -1;
	int i;
	level = level + 1;
	value[k] = level;
  15:	8b 45 10             	mov    0x10(%ebp),%eax

void lengthy(int *value, int N, int k)
{
	static int level = -1;
	int i;
	level = level + 1;
  18:	83 c2 01             	add    $0x1,%edx
  1b:	89 15 20 08 00 00    	mov    %edx,0x820
	value[k] = level;

	for (i = 0; i < N; i++)
  21:	85 f6                	test   %esi,%esi
void lengthy(int *value, int N, int k)
{
	static int level = -1;
	int i;
	level = level + 1;
	value[k] = level;
  23:	8d 04 87             	lea    (%edi,%eax,4),%eax
  26:	89 45 f0             	mov    %eax,-0x10(%ebp)
  29:	89 10                	mov    %edx,(%eax)

	for (i = 0; i < N; i++)
  2b:	7e 29                	jle    56 <lengthy+0x56>
  2d:	31 db                	xor    %ebx,%ebx
  2f:	eb 07                	jmp    38 <lengthy+0x38>
  31:	83 c3 01             	add    $0x1,%ebx
  34:	39 f3                	cmp    %esi,%ebx
  36:	74 1e                	je     56 <lengthy+0x56>
		if (value[i] == 0)
  38:	8b 04 9f             	mov    (%edi,%ebx,4),%eax
  3b:	85 c0                	test   %eax,%eax
  3d:	75 f2                	jne    31 <lengthy+0x31>
			lengthy(value, N, i);
  3f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
	static int level = -1;
	int i;
	level = level + 1;
	value[k] = level;

	for (i = 0; i < N; i++)
  43:	83 c3 01             	add    $0x1,%ebx
		if (value[i] == 0)
			lengthy(value, N, i);
  46:	89 74 24 04          	mov    %esi,0x4(%esp)
  4a:	89 3c 24             	mov    %edi,(%esp)
  4d:	e8 ae ff ff ff       	call   0 <lengthy>
	static int level = -1;
	int i;
	level = level + 1;
	value[k] = level;

	for (i = 0; i < N; i++)
  52:	39 f3                	cmp    %esi,%ebx
  54:	75 e2                	jne    38 <lengthy+0x38>
		if (value[i] == 0)
			lengthy(value, N, i);

	level = level-1; 
	value[k] = 0;
  56:	8b 45 f0             	mov    -0x10(%ebp),%eax

	for (i = 0; i < N; i++)
		if (value[i] == 0)
			lengthy(value, N, i);

	level = level-1; 
  59:	83 2d 20 08 00 00 01 	subl   $0x1,0x820
	value[k] = 0;
  60:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return;
}
  66:	83 c4 10             	add    $0x10,%esp
  69:	5b                   	pop    %ebx
  6a:	5e                   	pop    %esi
  6b:	5f                   	pop    %edi
  6c:	5d                   	pop    %ebp
  6d:	c3                   	ret    
  6e:	66 90                	xchg   %ax,%ax

00000070 <handle_error>:
int stdout = 1;
int stderr = 2;
inline void handle_error(const char *msg) {
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	83 ec 18             	sub    $0x18,%esp
  printf(stderr, "%s\n", msg);
  76:	8b 45 08             	mov    0x8(%ebp),%eax
  79:	c7 44 24 04 b5 07 00 	movl   $0x7b5,0x4(%esp)
  80:	00 
  81:	89 44 24 08          	mov    %eax,0x8(%esp)
  85:	a1 1c 08 00 00       	mov    0x81c,%eax
  8a:	89 04 24             	mov    %eax,(%esp)
  8d:	e8 4e 04 00 00       	call   4e0 <printf>
  exit();
  92:	e8 d1 02 00 00       	call   368 <exit>
  97:	89 f6                	mov    %esi,%esi
  99:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000000a0 <main>:

#define N 8
#define MAX_PRIO 5

int main(int argc, const char *argv[])
{
  a0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  a4:	83 e4 f0             	and    $0xfffffff0,%esp
  a7:	ff 71 fc             	pushl  -0x4(%ecx)
	int i;
	int pid;
	int value[N];
	for (i = 0; i < N; i++) {
		value[i] = 0;
  aa:	b8 02 00 00 00       	mov    $0x2,%eax

#define N 8
#define MAX_PRIO 5

int main(int argc, const char *argv[])
{
  af:	55                   	push   %ebp
  b0:	89 e5                	mov    %esp,%ebp
  b2:	56                   	push   %esi
  b3:	53                   	push   %ebx
  b4:	51                   	push   %ecx
  b5:	83 ec 2c             	sub    $0x2c,%esp
  b8:	8d 75 d4             	lea    -0x2c(%ebp),%esi
	int i;
	int pid;
	int value[N];
	for (i = 0; i < N; i++) {
		value[i] = 0;
  bb:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  c2:	c7 44 86 fc 00 00 00 	movl   $0x0,-0x4(%esi,%eax,4)
  c9:	00 
  ca:	83 c0 01             	add    $0x1,%eax
int main(int argc, const char *argv[])
{
	int i;
	int pid;
	int value[N];
	for (i = 0; i < N; i++) {
  cd:	83 f8 09             	cmp    $0x9,%eax
  d0:	75 f0                	jne    c2 <main+0x22>
		value[i] = 0;
	}

	if ((pid=fork())) { /* parent */
  d2:	e8 89 02 00 00       	call   360 <fork>
  d7:	85 c0                	test   %eax,%eax
  d9:	89 c3                	mov    %eax,%ebx
  db:	74 3f                	je     11c <main+0x7c>
		if (setpriority(pid, 1) < 0)
  dd:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  e4:	00 
  e5:	89 04 24             	mov    %eax,(%esp)
  e8:	e8 2b 03 00 00       	call   418 <setpriority>
  ed:	85 c0                	test   %eax,%eax
  ef:	78 62                	js     153 <main+0xb3>
			handle_error("set priority failed\n");
		if (wait() != pid) {
  f1:	e8 7a 02 00 00       	call   370 <wait>
  f6:	39 c3                	cmp    %eax,%ebx
  f8:	74 3f                	je     139 <main+0x99>
int stdout = 1;
int stderr = 2;
inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
  fa:	c7 44 24 08 ce 07 00 	movl   $0x7ce,0x8(%esp)
 101:	00 
 102:	a1 1c 08 00 00       	mov    0x81c,%eax
 107:	c7 44 24 04 b5 07 00 	movl   $0x7b5,0x4(%esp)
 10e:	00 
 10f:	89 04 24             	mov    %eax,(%esp)
 112:	e8 c9 03 00 00       	call   4e0 <printf>
  exit();
 117:	e8 4c 02 00 00       	call   368 <exit>
			handle_error("child pid inconsistent\n");
		}
	} else { /* child */
		lengthy(value, N, 0);
 11c:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
 123:	00 
 124:	c7 44 24 04 08 00 00 	movl   $0x8,0x4(%esp)
 12b:	00 
 12c:	89 34 24             	mov    %esi,(%esp)
 12f:	e8 cc fe ff ff       	call   0 <lengthy>
		exit();
 134:	e8 2f 02 00 00       	call   368 <exit>
	}

	printf(stdout, "hw4-test-san succeeded\n");
 139:	a1 18 08 00 00       	mov    0x818,%eax
 13e:	c7 44 24 04 e6 07 00 	movl   $0x7e6,0x4(%esp)
 145:	00 
 146:	89 04 24             	mov    %eax,(%esp)
 149:	e8 92 03 00 00       	call   4e0 <printf>

	exit();
 14e:	e8 15 02 00 00       	call   368 <exit>
int stdout = 1;
int stderr = 2;
inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
 153:	c7 44 24 08 b9 07 00 	movl   $0x7b9,0x8(%esp)
 15a:	00 
 15b:	eb a5                	jmp    102 <main+0x62>
 15d:	90                   	nop    
 15e:	90                   	nop    
 15f:	90                   	nop    

00000160 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	53                   	push   %ebx
 164:	8b 5d 08             	mov    0x8(%ebp),%ebx
 167:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 16a:	89 da                	mov    %ebx,%edx
 16c:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 170:	0f b6 01             	movzbl (%ecx),%eax
 173:	83 c1 01             	add    $0x1,%ecx
 176:	88 02                	mov    %al,(%edx)
 178:	83 c2 01             	add    $0x1,%edx
 17b:	84 c0                	test   %al,%al
 17d:	75 f1                	jne    170 <strcpy+0x10>
    ;
  return os;
}
 17f:	89 d8                	mov    %ebx,%eax
 181:	5b                   	pop    %ebx
 182:	5d                   	pop    %ebp
 183:	c3                   	ret    
 184:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 18a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000190 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	8b 4d 08             	mov    0x8(%ebp),%ecx
 196:	53                   	push   %ebx
 197:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 19a:	0f b6 01             	movzbl (%ecx),%eax
 19d:	84 c0                	test   %al,%al
 19f:	74 24                	je     1c5 <strcmp+0x35>
 1a1:	0f b6 13             	movzbl (%ebx),%edx
 1a4:	38 d0                	cmp    %dl,%al
 1a6:	74 12                	je     1ba <strcmp+0x2a>
 1a8:	eb 1e                	jmp    1c8 <strcmp+0x38>
 1aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1b0:	0f b6 13             	movzbl (%ebx),%edx
 1b3:	83 c1 01             	add    $0x1,%ecx
 1b6:	38 d0                	cmp    %dl,%al
 1b8:	75 0e                	jne    1c8 <strcmp+0x38>
 1ba:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 1be:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1c1:	84 c0                	test   %al,%al
 1c3:	75 eb                	jne    1b0 <strcmp+0x20>
 1c5:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 1c8:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1c9:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 1cc:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1cd:	0f b6 d2             	movzbl %dl,%edx
 1d0:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 1d2:	c3                   	ret    
 1d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000001e0 <strlen>:

uint
strlen(char *s)
{
 1e0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 1e1:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 1e3:	89 e5                	mov    %esp,%ebp
 1e5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1e8:	80 39 00             	cmpb   $0x0,(%ecx)
 1eb:	74 0e                	je     1fb <strlen+0x1b>
 1ed:	31 d2                	xor    %edx,%edx
 1ef:	90                   	nop    
 1f0:	83 c2 01             	add    $0x1,%edx
 1f3:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
 1f7:	89 d0                	mov    %edx,%eax
 1f9:	75 f5                	jne    1f0 <strlen+0x10>
    ;
  return n;
}
 1fb:	5d                   	pop    %ebp
 1fc:	c3                   	ret    
 1fd:	8d 76 00             	lea    0x0(%esi),%esi

00000200 <memset>:

void*
memset(void *dst, int c, uint n)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	8b 55 08             	mov    0x8(%ebp),%edx
 206:	57                   	push   %edi
 207:	8b 45 0c             	mov    0xc(%ebp),%eax
 20a:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 20d:	89 d7                	mov    %edx,%edi
 20f:	fc                   	cld    
 210:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 212:	5f                   	pop    %edi
 213:	89 d0                	mov    %edx,%eax
 215:	5d                   	pop    %ebp
 216:	c3                   	ret    
 217:	89 f6                	mov    %esi,%esi
 219:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000220 <strchr>:

char*
strchr(const char *s, char c)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	8b 45 08             	mov    0x8(%ebp),%eax
 226:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 22a:	0f b6 10             	movzbl (%eax),%edx
 22d:	84 d2                	test   %dl,%dl
 22f:	75 0c                	jne    23d <strchr+0x1d>
 231:	eb 11                	jmp    244 <strchr+0x24>
 233:	83 c0 01             	add    $0x1,%eax
 236:	0f b6 10             	movzbl (%eax),%edx
 239:	84 d2                	test   %dl,%dl
 23b:	74 07                	je     244 <strchr+0x24>
    if(*s == c)
 23d:	38 ca                	cmp    %cl,%dl
 23f:	90                   	nop    
 240:	75 f1                	jne    233 <strchr+0x13>
      return (char*) s;
  return 0;
}
 242:	5d                   	pop    %ebp
 243:	c3                   	ret    
 244:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 245:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 247:	c3                   	ret    
 248:	90                   	nop    
 249:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000250 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	8b 4d 08             	mov    0x8(%ebp),%ecx
 256:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 257:	31 db                	xor    %ebx,%ebx
 259:	0f b6 11             	movzbl (%ecx),%edx
 25c:	8d 42 d0             	lea    -0x30(%edx),%eax
 25f:	3c 09                	cmp    $0x9,%al
 261:	77 18                	ja     27b <atoi+0x2b>
    n = n*10 + *s++ - '0';
 263:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 266:	0f be d2             	movsbl %dl,%edx
 269:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 26d:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 271:	83 c1 01             	add    $0x1,%ecx
 274:	8d 42 d0             	lea    -0x30(%edx),%eax
 277:	3c 09                	cmp    $0x9,%al
 279:	76 e8                	jbe    263 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 27b:	89 d8                	mov    %ebx,%eax
 27d:	5b                   	pop    %ebx
 27e:	5d                   	pop    %ebp
 27f:	c3                   	ret    

00000280 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	8b 4d 10             	mov    0x10(%ebp),%ecx
 286:	56                   	push   %esi
 287:	8b 75 08             	mov    0x8(%ebp),%esi
 28a:	53                   	push   %ebx
 28b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 28e:	85 c9                	test   %ecx,%ecx
 290:	7e 10                	jle    2a2 <memmove+0x22>
 292:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 294:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 298:	88 04 32             	mov    %al,(%edx,%esi,1)
 29b:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 29e:	39 ca                	cmp    %ecx,%edx
 2a0:	75 f2                	jne    294 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 2a2:	89 f0                	mov    %esi,%eax
 2a4:	5b                   	pop    %ebx
 2a5:	5e                   	pop    %esi
 2a6:	5d                   	pop    %ebp
 2a7:	c3                   	ret    
 2a8:	90                   	nop    
 2a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000002b0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 2b9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 2bc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 2bf:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2c4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2cb:	00 
 2cc:	89 04 24             	mov    %eax,(%esp)
 2cf:	e8 d4 00 00 00       	call   3a8 <open>
  if(fd < 0)
 2d4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2d6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 2d8:	78 19                	js     2f3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 2da:	8b 45 0c             	mov    0xc(%ebp),%eax
 2dd:	89 1c 24             	mov    %ebx,(%esp)
 2e0:	89 44 24 04          	mov    %eax,0x4(%esp)
 2e4:	e8 d7 00 00 00       	call   3c0 <fstat>
  close(fd);
 2e9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 2ec:	89 c6                	mov    %eax,%esi
  close(fd);
 2ee:	e8 9d 00 00 00       	call   390 <close>
  return r;
}
 2f3:	89 f0                	mov    %esi,%eax
 2f5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 2f8:	8b 75 fc             	mov    -0x4(%ebp),%esi
 2fb:	89 ec                	mov    %ebp,%esp
 2fd:	5d                   	pop    %ebp
 2fe:	c3                   	ret    
 2ff:	90                   	nop    

00000300 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	57                   	push   %edi
 304:	56                   	push   %esi
 305:	31 f6                	xor    %esi,%esi
 307:	53                   	push   %ebx
 308:	83 ec 1c             	sub    $0x1c,%esp
 30b:	8b 7d 08             	mov    0x8(%ebp),%edi
 30e:	eb 06                	jmp    316 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 310:	3c 0d                	cmp    $0xd,%al
 312:	74 39                	je     34d <gets+0x4d>
 314:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 316:	8d 5e 01             	lea    0x1(%esi),%ebx
 319:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 31c:	7d 31                	jge    34f <gets+0x4f>
    cc = read(0, &c, 1);
 31e:	8d 45 f3             	lea    -0xd(%ebp),%eax
 321:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 328:	00 
 329:	89 44 24 04          	mov    %eax,0x4(%esp)
 32d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 334:	e8 47 00 00 00       	call   380 <read>
    if(cc < 1)
 339:	85 c0                	test   %eax,%eax
 33b:	7e 12                	jle    34f <gets+0x4f>
      break;
    buf[i++] = c;
 33d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 341:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 345:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 349:	3c 0a                	cmp    $0xa,%al
 34b:	75 c3                	jne    310 <gets+0x10>
 34d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 34f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 353:	89 f8                	mov    %edi,%eax
 355:	83 c4 1c             	add    $0x1c,%esp
 358:	5b                   	pop    %ebx
 359:	5e                   	pop    %esi
 35a:	5f                   	pop    %edi
 35b:	5d                   	pop    %ebp
 35c:	c3                   	ret    
 35d:	90                   	nop    
 35e:	90                   	nop    
 35f:	90                   	nop    

00000360 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 360:	b8 01 00 00 00       	mov    $0x1,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <exit>:
SYSCALL(exit)
 368:	b8 02 00 00 00       	mov    $0x2,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <wait>:
SYSCALL(wait)
 370:	b8 03 00 00 00       	mov    $0x3,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <pipe>:
SYSCALL(pipe)
 378:	b8 04 00 00 00       	mov    $0x4,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <read>:
SYSCALL(read)
 380:	b8 06 00 00 00       	mov    $0x6,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <write>:
SYSCALL(write)
 388:	b8 05 00 00 00       	mov    $0x5,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <close>:
SYSCALL(close)
 390:	b8 07 00 00 00       	mov    $0x7,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <kill>:
SYSCALL(kill)
 398:	b8 08 00 00 00       	mov    $0x8,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <exec>:
SYSCALL(exec)
 3a0:	b8 09 00 00 00       	mov    $0x9,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <open>:
SYSCALL(open)
 3a8:	b8 0a 00 00 00       	mov    $0xa,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <mknod>:
SYSCALL(mknod)
 3b0:	b8 0b 00 00 00       	mov    $0xb,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <unlink>:
SYSCALL(unlink)
 3b8:	b8 0c 00 00 00       	mov    $0xc,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <fstat>:
SYSCALL(fstat)
 3c0:	b8 0d 00 00 00       	mov    $0xd,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <link>:
SYSCALL(link)
 3c8:	b8 0e 00 00 00       	mov    $0xe,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <mkdir>:
SYSCALL(mkdir)
 3d0:	b8 0f 00 00 00       	mov    $0xf,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <chdir>:
SYSCALL(chdir)
 3d8:	b8 10 00 00 00       	mov    $0x10,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <dup>:
SYSCALL(dup)
 3e0:	b8 11 00 00 00       	mov    $0x11,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <getpid>:
SYSCALL(getpid)
 3e8:	b8 12 00 00 00       	mov    $0x12,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <sbrk>:
SYSCALL(sbrk)
 3f0:	b8 13 00 00 00       	mov    $0x13,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <sleep>:
SYSCALL(sleep)
 3f8:	b8 14 00 00 00       	mov    $0x14,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <uptime>:
SYSCALL(uptime)
 400:	b8 15 00 00 00       	mov    $0x15,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <nice>:
SYSCALL(nice)
 408:	b8 16 00 00 00       	mov    $0x16,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <getpriority>:
SYSCALL(getpriority)
 410:	b8 17 00 00 00       	mov    $0x17,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <setpriority>:
SYSCALL(setpriority)
 418:	b8 18 00 00 00       	mov    $0x18,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <getaffinity>:
SYSCALL(getaffinity)
 420:	b8 19 00 00 00       	mov    $0x19,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <setaffinity>:
SYSCALL(setaffinity)
 428:	b8 1a 00 00 00       	mov    $0x1a,%eax
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
 44b:	e8 38 ff ff ff       	call   388 <write>
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
 48d:	0f b6 82 05 08 00 00 	movzbl 0x805(%edx),%eax
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
 5cb:	b9 fe 07 00 00       	mov    $0x7fe,%ecx
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
 661:	8b 0d 2c 08 00 00    	mov    0x82c,%ecx
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
 6ad:	89 0d 2c 08 00 00    	mov    %ecx,0x82c
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
 6d5:	89 0d 2c 08 00 00    	mov    %ecx,0x82c
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
 6ec:	8b 15 2c 08 00 00    	mov    0x82c,%edx
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
 713:	3b 0d 2c 08 00 00    	cmp    0x82c,%ecx
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
 735:	89 15 2c 08 00 00    	mov    %edx,0x82c
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
 755:	e8 96 fc ff ff       	call   3f0 <sbrk>
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
 76d:	8b 15 2c 08 00 00    	mov    0x82c,%edx
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
 78d:	ba 24 08 00 00       	mov    $0x824,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 792:	c7 05 2c 08 00 00 24 	movl   $0x824,0x82c
 799:	08 00 00 
 79c:	c7 05 24 08 00 00 24 	movl   $0x824,0x824
 7a3:	08 00 00 
    base.s.size = 0;
 7a6:	c7 05 28 08 00 00 00 	movl   $0x0,0x828
 7ad:	00 00 00 
 7b0:	e9 4e ff ff ff       	jmp    703 <malloc+0x23>
