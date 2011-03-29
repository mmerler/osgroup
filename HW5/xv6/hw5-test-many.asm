
_hw5-test-many:     file format elf32-i386

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
   9:	c7 44 24 04 08 09 00 	movl   $0x908,0x4(%esp)
  10:	00 
  11:	89 44 24 08          	mov    %eax,0x8(%esp)
  15:	a1 b4 09 00 00       	mov    0x9b4,%eax
  1a:	89 04 24             	mov    %eax,(%esp)
  1d:	e8 0e 06 00 00       	call   630 <printf>
  exit();
  22:	e8 b1 04 00 00       	call   4d8 <exit>
  27:	89 f6                	mov    %esi,%esi
  29:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000030 <main>:
    ++j; --k;
  }
  return i;
}

int main() {
  30:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  34:	83 e4 f0             	and    $0xfffffff0,%esp
  37:	ff 71 fc             	pushl  -0x4(%ecx)
  3a:	55                   	push   %ebp
  3b:	89 e5                	mov    %esp,%ebp
  3d:	57                   	push   %edi
  3e:	56                   	push   %esi
  3f:	53                   	push   %ebx
  40:	31 db                	xor    %ebx,%ebx
  42:	51                   	push   %ecx
  43:	81 ec 58 04 00 00    	sub    $0x458,%esp
  49:	c7 85 b0 fb ff ff 01 	movl   $0x1,-0x450(%ebp)
  50:	00 00 00 

  int i;
  int root = 1;
  for (i = 0; i < N_LOOPS; i++) {
    int child_pid = fork();
  53:	e8 78 04 00 00       	call   4d0 <fork>
    if (child_pid < 0)
  58:	83 f8 00             	cmp    $0x0,%eax
  5b:	0f 8c 16 02 00 00    	jl     277 <main+0x247>
      panic("fork");
    if (child_pid == 0)
  61:	83 f8 01             	cmp    $0x1,%eax
  64:	19 c0                	sbb    %eax,%eax

int main() {

  int i;
  int root = 1;
  for (i = 0; i < N_LOOPS; i++) {
  66:	83 c3 01             	add    $0x1,%ebx
    int child_pid = fork();
    if (child_pid < 0)
      panic("fork");
    if (child_pid == 0)
  69:	f7 d0                	not    %eax
  6b:	21 85 b0 fb ff ff    	and    %eax,-0x450(%ebp)

int main() {

  int i;
  int root = 1;
  for (i = 0; i < N_LOOPS; i++) {
  71:	83 fb 05             	cmp    $0x5,%ebx
  74:	75 dd                	jne    53 <main+0x23>
  }

  // Each process creates a file with the name <pid> under
  // the current directory. 
  char file_name[MAX_LEN];
  if (itoa(getpid(), file_name, MAX_LEN) < 0)
  76:	e8 dd 04 00 00       	call   558 <getpid>
  return (char)('0' + d);
}

// Returns -1 on error; otherwise, returns the length of the string. 
static int itoa(int v, char *buf, int max_size) {
  if (v <= 0)
  7b:	85 c0                	test   %eax,%eax
  }

  // Each process creates a file with the name <pid> under
  // the current directory. 
  char file_name[MAX_LEN];
  if (itoa(getpid(), file_name, MAX_LEN) < 0)
  7d:	89 c1                	mov    %eax,%ecx
  return (char)('0' + d);
}

// Returns -1 on error; otherwise, returns the length of the string. 
static int itoa(int v, char *buf, int max_size) {
  if (v <= 0)
  7f:	0f 8e b3 01 00 00    	jle    238 <main+0x208>
  85:	30 db                	xor    %bl,%bl
    return -1;
  int i = 0;
  while (v > 0) {
    if (i + 1 >= max_size)
      return -1;
    buf[i] = digit2char(v % 10);
  87:	8d b5 cc fb ff ff    	lea    -0x434(%ebp),%esi
  return (char)('0' + d);
}

// Returns -1 on error; otherwise, returns the length of the string. 
static int itoa(int v, char *buf, int max_size) {
  if (v <= 0)
  8d:	c7 85 bc fb ff ff 01 	movl   $0x1,-0x444(%ebp)
  94:	00 00 00 
  97:	eb 27                	jmp    c0 <main+0x90>
  99:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
    return -1;
  int i = 0;
  while (v > 0) {
    if (i + 1 >= max_size)
  a0:	8b 85 bc fb ff ff    	mov    -0x444(%ebp),%eax
  a6:	83 c0 01             	add    $0x1,%eax
  a9:	3d 00 04 00 00       	cmp    $0x400,%eax
  ae:	0f 84 84 01 00 00    	je     238 <main+0x208>
  b4:	8b 9d bc fb ff ff    	mov    -0x444(%ebp),%ebx
  ba:	89 85 bc fb ff ff    	mov    %eax,-0x444(%ebp)
      return -1;
    buf[i] = digit2char(v % 10);
  c0:	b8 67 66 66 66       	mov    $0x66666667,%eax
  c5:	f7 e9                	imul   %ecx
  c7:	89 c8                	mov    %ecx,%eax
  c9:	c1 f8 1f             	sar    $0x1f,%eax
  cc:	c1 fa 02             	sar    $0x2,%edx
  cf:	29 c2                	sub    %eax,%edx
  d1:	8d 04 92             	lea    (%edx,%edx,4),%eax
  d4:	01 c0                	add    %eax,%eax
  d6:	29 c1                	sub    %eax,%ecx
#define MAX_LEN (1024)
#define N_LOOPS (5)
#define N_PROCS (1 << N_LOOPS)

static char digit2char(int d) {
  if (d < 0 || d > 9)
  d8:	83 f9 09             	cmp    $0x9,%ecx
    return -1;
  int i = 0;
  while (v > 0) {
    if (i + 1 >= max_size)
      return -1;
    buf[i] = digit2char(v % 10);
  db:	89 c8                	mov    %ecx,%eax
#define MAX_LEN (1024)
#define N_LOOPS (5)
#define N_PROCS (1 << N_LOOPS)

static char digit2char(int d) {
  if (d < 0 || d > 9)
  dd:	0f 87 8a 01 00 00    	ja     26d <main+0x23d>
    return -1;
  int i = 0;
  while (v > 0) {
    if (i + 1 >= max_size)
      return -1;
    buf[i] = digit2char(v % 10);
  e3:	83 c0 30             	add    $0x30,%eax
// Returns -1 on error; otherwise, returns the length of the string. 
static int itoa(int v, char *buf, int max_size) {
  if (v <= 0)
    return -1;
  int i = 0;
  while (v > 0) {
  e6:	85 d2                	test   %edx,%edx
    if (i + 1 >= max_size)
      return -1;
    buf[i] = digit2char(v % 10);
  e8:	89 f7                	mov    %esi,%edi
    i++;
    v /= 10;
  ea:	89 d1                	mov    %edx,%ecx
    return -1;
  int i = 0;
  while (v > 0) {
    if (i + 1 >= max_size)
      return -1;
    buf[i] = digit2char(v % 10);
  ec:	88 84 1d cc fb ff ff 	mov    %al,-0x434(%ebp,%ebx,1)
// Returns -1 on error; otherwise, returns the length of the string. 
static int itoa(int v, char *buf, int max_size) {
  if (v <= 0)
    return -1;
  int i = 0;
  while (v > 0) {
  f3:	7f ab                	jg     a0 <main+0x70>
      return -1;
    buf[i] = digit2char(v % 10);
    i++;
    v /= 10;
  }
  buf[i] = '\0';
  f5:	8b 85 bc fb ff ff    	mov    -0x444(%ebp),%eax
  int j = 0, k = i - 1;
  fb:	89 c6                	mov    %eax,%esi
  fd:	83 ee 01             	sub    $0x1,%esi
  while (j < k) {
 100:	85 f6                	test   %esi,%esi
      return -1;
    buf[i] = digit2char(v % 10);
    i++;
    v /= 10;
  }
  buf[i] = '\0';
 102:	c6 84 05 cc fb ff ff 	movb   $0x0,-0x434(%ebp,%eax,1)
 109:	00 
  int j = 0, k = i - 1;
  while (j < k) {
 10a:	7e 27                	jle    133 <main+0x103>
 10c:	8d 0c 07             	lea    (%edi,%eax,1),%ecx
 10f:	bb 01 00 00 00       	mov    $0x1,%ebx
    char tmp = buf[j]; buf[j] = buf[k]; buf[k] = tmp;
 114:	0f b6 44 3b ff       	movzbl -0x1(%ebx,%edi,1),%eax
    ++j; --k;
 119:	83 ee 01             	sub    $0x1,%esi
    v /= 10;
  }
  buf[i] = '\0';
  int j = 0, k = i - 1;
  while (j < k) {
    char tmp = buf[j]; buf[j] = buf[k]; buf[k] = tmp;
 11c:	0f b6 51 ff          	movzbl -0x1(%ecx),%edx
 120:	88 54 3b ff          	mov    %dl,-0x1(%ebx,%edi,1)
 124:	88 41 ff             	mov    %al,-0x1(%ecx)
 127:	89 d8                	mov    %ebx,%eax
    ++j; --k;
 129:	83 e9 01             	sub    $0x1,%ecx
 12c:	83 c3 01             	add    $0x1,%ebx
    i++;
    v /= 10;
  }
  buf[i] = '\0';
  int j = 0, k = i - 1;
  while (j < k) {
 12f:	39 c6                	cmp    %eax,%esi
 131:	7f e1                	jg     114 <main+0xe4>
  }

  // Each process creates a file with the name <pid> under
  // the current directory. 
  char file_name[MAX_LEN];
  if (itoa(getpid(), file_name, MAX_LEN) < 0)
 133:	8b 95 bc fb ff ff    	mov    -0x444(%ebp),%edx
 139:	85 d2                	test   %edx,%edx
 13b:	0f 88 f7 00 00 00    	js     238 <main+0x208>
    panic("itoa");
  int fd = open(file_name, O_CREATE);
 141:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
 148:	00 
 149:	89 3c 24             	mov    %edi,(%esp)
 14c:	e8 c7 03 00 00       	call   518 <open>
  if (fd == -1)
 151:	83 f8 ff             	cmp    $0xffffffff,%eax
 154:	0f 84 41 01 00 00    	je     29b <main+0x26b>
    panic("open");
  close(fd);
 15a:	89 04 24             	mov    %eax,(%esp)
 15d:	e8 9e 03 00 00       	call   500 <close>

  sleep(root ? 4 * 100 : 1 * 100);
 162:	83 bd b0 fb ff ff 01 	cmpl   $0x1,-0x450(%ebp)
 169:	19 c0                	sbb    %eax,%eax
 16b:	25 d4 fe ff ff       	and    $0xfffffed4,%eax
 170:	05 90 01 00 00       	add    $0x190,%eax
 175:	89 04 24             	mov    %eax,(%esp)
 178:	e8 eb 03 00 00       	call   568 <sleep>
 17d:	8d 76 00             	lea    0x0(%esi),%esi
  // Wait for all children to exit. 
  while (wait() >= 0);
 180:	e8 5b 03 00 00       	call   4e0 <wait>
 185:	85 c0                	test   %eax,%eax
 187:	79 f7                	jns    180 <main+0x150>
  // Only the root process decides whether the testcase is passed. 
  if (!root)
 189:	8b 85 b0 fb ff ff    	mov    -0x450(%ebp),%eax
 18f:	85 c0                	test   %eax,%eax
 191:	0f 84 ff 00 00 00    	je     296 <main+0x266>
    exit();

  int dir = open(".", O_RDONLY);
 197:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 19e:	00 
 19f:	c7 04 24 2e 09 00 00 	movl   $0x92e,(%esp)
 1a6:	e8 6d 03 00 00       	call   518 <open>
  if (dir < 0)
 1ab:	85 c0                	test   %eax,%eax
  while (wait() >= 0);
  // Only the root process decides whether the testcase is passed. 
  if (!root)
    exit();

  int dir = open(".", O_RDONLY);
 1ad:	89 85 b4 fb ff ff    	mov    %eax,-0x44c(%ebp)
  if (dir < 0)
 1b3:	0f 88 00 01 00 00    	js     2b9 <main+0x289>
    panic("open dir");
  struct stat st;
  if (fstat(dir, &st) < 0)
 1b9:	8d 45 cc             	lea    -0x34(%ebp),%eax
 1bc:	89 44 24 04          	mov    %eax,0x4(%esp)
 1c0:	8b 85 b4 fb ff ff    	mov    -0x44c(%ebp),%eax
 1c6:	89 04 24             	mov    %eax,(%esp)
 1c9:	e8 62 03 00 00       	call   530 <fstat>
 1ce:	85 c0                	test   %eax,%eax
 1d0:	0f 88 cf 00 00 00    	js     2a5 <main+0x275>
    panic("fstat");
  if (st.type != T_DIR)
 1d6:	66 83 7d cc 01       	cmpw   $0x1,-0x34(%ebp)
 1db:	0f 85 ce 00 00 00    	jne    2af <main+0x27f>
 1e1:	c7 85 b8 fb ff ff 00 	movl   $0x0,-0x448(%ebp)
 1e8:	00 00 00 
 1eb:	8d 75 e0             	lea    -0x20(%ebp),%esi
 1ee:	8d 7d e2             	lea    -0x1e(%ebp),%edi

  // The root process counts all files whose name contains only digits.
  // Those are the notification files.  
  struct dirent de;
  int n_succ = 0;
  while (read(dir, &de, sizeof(de)) == sizeof(de)) {
 1f1:	8b 85 b4 fb ff ff    	mov    -0x44c(%ebp),%eax
 1f7:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 1fe:	00 
 1ff:	89 74 24 04          	mov    %esi,0x4(%esp)
 203:	89 04 24             	mov    %eax,(%esp)
 206:	e8 e5 02 00 00       	call   4f0 <read>
 20b:	83 f8 10             	cmp    $0x10,%eax
 20e:	75 4a                	jne    25a <main+0x22a>
 210:	31 db                	xor    %ebx,%ebx
 212:	eb 0f                	jmp    223 <main+0x1f3>
    int all_digits = 1;
    for (i = 0; i < strlen(de.name); ++i) {
      if (de.name[i] < '0' || de.name[i] > '9') {
 214:	0f b6 44 33 02       	movzbl 0x2(%ebx,%esi,1),%eax
 219:	83 e8 30             	sub    $0x30,%eax
 21c:	3c 09                	cmp    $0x9,%al
 21e:	77 d1                	ja     1f1 <main+0x1c1>
  // Those are the notification files.  
  struct dirent de;
  int n_succ = 0;
  while (read(dir, &de, sizeof(de)) == sizeof(de)) {
    int all_digits = 1;
    for (i = 0; i < strlen(de.name); ++i) {
 220:	83 c3 01             	add    $0x1,%ebx
 223:	89 3c 24             	mov    %edi,(%esp)
 226:	e8 25 01 00 00       	call   350 <strlen>
 22b:	39 d8                	cmp    %ebx,%eax
 22d:	77 e5                	ja     214 <main+0x1e4>
        all_digits = 0;
        break;
      }
    }
    if (all_digits)
      ++n_succ;
 22f:	83 85 b8 fb ff ff 01 	addl   $0x1,-0x448(%ebp)
 236:	eb b9                	jmp    1f1 <main+0x1c1>
int stdin = 0;
int stdout = 1;
int stderr = 2;

inline __attribute__((noreturn)) void panic(const char *msg) {
  printf(stderr, "[panic] %s\n", msg);
 238:	c7 44 24 08 24 09 00 	movl   $0x924,0x8(%esp)
 23f:	00 
  exit();
 240:	a1 b4 09 00 00       	mov    0x9b4,%eax
 245:	c7 44 24 04 08 09 00 	movl   $0x908,0x4(%esp)
 24c:	00 
 24d:	89 04 24             	mov    %eax,(%esp)
 250:	e8 db 03 00 00       	call   630 <printf>
 255:	e8 7e 02 00 00       	call   4d8 <exit>
  }
  
  // If every process has created a notification file, it's great.
  if (n_succ != N_PROCS)
 25a:	83 bd b8 fb ff ff 20 	cmpl   $0x20,-0x448(%ebp)
 261:	74 1e                	je     281 <main+0x251>
int stdin = 0;
int stdout = 1;
int stderr = 2;

inline __attribute__((noreturn)) void panic(const char *msg) {
  printf(stderr, "[panic] %s\n", msg);
 263:	c7 44 24 08 68 09 00 	movl   $0x968,0x8(%esp)
 26a:	00 
 26b:	eb d3                	jmp    240 <main+0x210>
 26d:	c7 44 24 08 19 09 00 	movl   $0x919,0x8(%esp)
 274:	00 
 275:	eb c9                	jmp    240 <main+0x210>
    panic("Some child processes didn't exit successfully");

  printf(stdout, "hw5-test-many succeeded\n");
 277:	c7 44 24 08 14 09 00 	movl   $0x914,0x8(%esp)
 27e:	00 
 27f:	eb bf                	jmp    240 <main+0x210>
 281:	a1 b0 09 00 00       	mov    0x9b0,%eax
 286:	c7 44 24 04 4f 09 00 	movl   $0x94f,0x4(%esp)
 28d:	00 
 28e:	89 04 24             	mov    %eax,(%esp)
 291:	e8 9a 03 00 00       	call   630 <printf>
  exit();
 296:	e8 3d 02 00 00       	call   4d8 <exit>
 29b:	c7 44 24 08 29 09 00 	movl   $0x929,0x8(%esp)
 2a2:	00 
 2a3:	eb 9b                	jmp    240 <main+0x210>
 2a5:	c7 44 24 08 39 09 00 	movl   $0x939,0x8(%esp)
 2ac:	00 
 2ad:	eb 91                	jmp    240 <main+0x210>
 2af:	c7 44 24 08 3f 09 00 	movl   $0x93f,0x8(%esp)
 2b6:	00 
 2b7:	eb 87                	jmp    240 <main+0x210>
 2b9:	c7 44 24 08 30 09 00 	movl   $0x930,0x8(%esp)
 2c0:	00 
 2c1:	e9 7a ff ff ff       	jmp    240 <main+0x210>
 2c6:	90                   	nop    
 2c7:	90                   	nop    
 2c8:	90                   	nop    
 2c9:	90                   	nop    
 2ca:	90                   	nop    
 2cb:	90                   	nop    
 2cc:	90                   	nop    
 2cd:	90                   	nop    
 2ce:	90                   	nop    
 2cf:	90                   	nop    

000002d0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	53                   	push   %ebx
 2d4:	8b 5d 08             	mov    0x8(%ebp),%ebx
 2d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 2da:	89 da                	mov    %ebx,%edx
 2dc:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2e0:	0f b6 01             	movzbl (%ecx),%eax
 2e3:	83 c1 01             	add    $0x1,%ecx
 2e6:	88 02                	mov    %al,(%edx)
 2e8:	83 c2 01             	add    $0x1,%edx
 2eb:	84 c0                	test   %al,%al
 2ed:	75 f1                	jne    2e0 <strcpy+0x10>
    ;
  return os;
}
 2ef:	89 d8                	mov    %ebx,%eax
 2f1:	5b                   	pop    %ebx
 2f2:	5d                   	pop    %ebp
 2f3:	c3                   	ret    
 2f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000300 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	8b 4d 08             	mov    0x8(%ebp),%ecx
 306:	53                   	push   %ebx
 307:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 30a:	0f b6 01             	movzbl (%ecx),%eax
 30d:	84 c0                	test   %al,%al
 30f:	74 24                	je     335 <strcmp+0x35>
 311:	0f b6 13             	movzbl (%ebx),%edx
 314:	38 d0                	cmp    %dl,%al
 316:	74 12                	je     32a <strcmp+0x2a>
 318:	eb 1e                	jmp    338 <strcmp+0x38>
 31a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 320:	0f b6 13             	movzbl (%ebx),%edx
 323:	83 c1 01             	add    $0x1,%ecx
 326:	38 d0                	cmp    %dl,%al
 328:	75 0e                	jne    338 <strcmp+0x38>
 32a:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 32e:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 331:	84 c0                	test   %al,%al
 333:	75 eb                	jne    320 <strcmp+0x20>
 335:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 338:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 339:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 33c:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 33d:	0f b6 d2             	movzbl %dl,%edx
 340:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 342:	c3                   	ret    
 343:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 349:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000350 <strlen>:

uint
strlen(char *s)
{
 350:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 351:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 353:	89 e5                	mov    %esp,%ebp
 355:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 358:	80 39 00             	cmpb   $0x0,(%ecx)
 35b:	74 0e                	je     36b <strlen+0x1b>
 35d:	31 d2                	xor    %edx,%edx
 35f:	90                   	nop    
 360:	83 c2 01             	add    $0x1,%edx
 363:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
 367:	89 d0                	mov    %edx,%eax
 369:	75 f5                	jne    360 <strlen+0x10>
    ;
  return n;
}
 36b:	5d                   	pop    %ebp
 36c:	c3                   	ret    
 36d:	8d 76 00             	lea    0x0(%esi),%esi

00000370 <memset>:

void*
memset(void *dst, int c, uint n)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	8b 55 08             	mov    0x8(%ebp),%edx
 376:	57                   	push   %edi
 377:	8b 45 0c             	mov    0xc(%ebp),%eax
 37a:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 37d:	89 d7                	mov    %edx,%edi
 37f:	fc                   	cld    
 380:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 382:	5f                   	pop    %edi
 383:	89 d0                	mov    %edx,%eax
 385:	5d                   	pop    %ebp
 386:	c3                   	ret    
 387:	89 f6                	mov    %esi,%esi
 389:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000390 <strchr>:

char*
strchr(const char *s, char c)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	8b 45 08             	mov    0x8(%ebp),%eax
 396:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 39a:	0f b6 10             	movzbl (%eax),%edx
 39d:	84 d2                	test   %dl,%dl
 39f:	75 0c                	jne    3ad <strchr+0x1d>
 3a1:	eb 11                	jmp    3b4 <strchr+0x24>
 3a3:	83 c0 01             	add    $0x1,%eax
 3a6:	0f b6 10             	movzbl (%eax),%edx
 3a9:	84 d2                	test   %dl,%dl
 3ab:	74 07                	je     3b4 <strchr+0x24>
    if(*s == c)
 3ad:	38 ca                	cmp    %cl,%dl
 3af:	90                   	nop    
 3b0:	75 f1                	jne    3a3 <strchr+0x13>
      return (char*) s;
  return 0;
}
 3b2:	5d                   	pop    %ebp
 3b3:	c3                   	ret    
 3b4:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 3b5:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 3b7:	c3                   	ret    
 3b8:	90                   	nop    
 3b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000003c0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3c6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3c7:	31 db                	xor    %ebx,%ebx
 3c9:	0f b6 11             	movzbl (%ecx),%edx
 3cc:	8d 42 d0             	lea    -0x30(%edx),%eax
 3cf:	3c 09                	cmp    $0x9,%al
 3d1:	77 18                	ja     3eb <atoi+0x2b>
    n = n*10 + *s++ - '0';
 3d3:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 3d6:	0f be d2             	movsbl %dl,%edx
 3d9:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3dd:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 3e1:	83 c1 01             	add    $0x1,%ecx
 3e4:	8d 42 d0             	lea    -0x30(%edx),%eax
 3e7:	3c 09                	cmp    $0x9,%al
 3e9:	76 e8                	jbe    3d3 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 3eb:	89 d8                	mov    %ebx,%eax
 3ed:	5b                   	pop    %ebx
 3ee:	5d                   	pop    %ebp
 3ef:	c3                   	ret    

000003f0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3f6:	56                   	push   %esi
 3f7:	8b 75 08             	mov    0x8(%ebp),%esi
 3fa:	53                   	push   %ebx
 3fb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3fe:	85 c9                	test   %ecx,%ecx
 400:	7e 10                	jle    412 <memmove+0x22>
 402:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 404:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 408:	88 04 32             	mov    %al,(%edx,%esi,1)
 40b:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 40e:	39 ca                	cmp    %ecx,%edx
 410:	75 f2                	jne    404 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 412:	89 f0                	mov    %esi,%eax
 414:	5b                   	pop    %ebx
 415:	5e                   	pop    %esi
 416:	5d                   	pop    %ebp
 417:	c3                   	ret    
 418:	90                   	nop    
 419:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000420 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 426:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 429:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 42c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 42f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 434:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 43b:	00 
 43c:	89 04 24             	mov    %eax,(%esp)
 43f:	e8 d4 00 00 00       	call   518 <open>
  if(fd < 0)
 444:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 446:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 448:	78 19                	js     463 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 44a:	8b 45 0c             	mov    0xc(%ebp),%eax
 44d:	89 1c 24             	mov    %ebx,(%esp)
 450:	89 44 24 04          	mov    %eax,0x4(%esp)
 454:	e8 d7 00 00 00       	call   530 <fstat>
  close(fd);
 459:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 45c:	89 c6                	mov    %eax,%esi
  close(fd);
 45e:	e8 9d 00 00 00       	call   500 <close>
  return r;
}
 463:	89 f0                	mov    %esi,%eax
 465:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 468:	8b 75 fc             	mov    -0x4(%ebp),%esi
 46b:	89 ec                	mov    %ebp,%esp
 46d:	5d                   	pop    %ebp
 46e:	c3                   	ret    
 46f:	90                   	nop    

00000470 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	57                   	push   %edi
 474:	56                   	push   %esi
 475:	31 f6                	xor    %esi,%esi
 477:	53                   	push   %ebx
 478:	83 ec 1c             	sub    $0x1c,%esp
 47b:	8b 7d 08             	mov    0x8(%ebp),%edi
 47e:	eb 06                	jmp    486 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 480:	3c 0d                	cmp    $0xd,%al
 482:	74 39                	je     4bd <gets+0x4d>
 484:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 486:	8d 5e 01             	lea    0x1(%esi),%ebx
 489:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 48c:	7d 31                	jge    4bf <gets+0x4f>
    cc = read(0, &c, 1);
 48e:	8d 45 f3             	lea    -0xd(%ebp),%eax
 491:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 498:	00 
 499:	89 44 24 04          	mov    %eax,0x4(%esp)
 49d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4a4:	e8 47 00 00 00       	call   4f0 <read>
    if(cc < 1)
 4a9:	85 c0                	test   %eax,%eax
 4ab:	7e 12                	jle    4bf <gets+0x4f>
      break;
    buf[i++] = c;
 4ad:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 4b1:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 4b5:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 4b9:	3c 0a                	cmp    $0xa,%al
 4bb:	75 c3                	jne    480 <gets+0x10>
 4bd:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 4bf:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 4c3:	89 f8                	mov    %edi,%eax
 4c5:	83 c4 1c             	add    $0x1c,%esp
 4c8:	5b                   	pop    %ebx
 4c9:	5e                   	pop    %esi
 4ca:	5f                   	pop    %edi
 4cb:	5d                   	pop    %ebp
 4cc:	c3                   	ret    
 4cd:	90                   	nop    
 4ce:	90                   	nop    
 4cf:	90                   	nop    

000004d0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4d0:	b8 01 00 00 00       	mov    $0x1,%eax
 4d5:	cd 40                	int    $0x40
 4d7:	c3                   	ret    

000004d8 <exit>:
SYSCALL(exit)
 4d8:	b8 02 00 00 00       	mov    $0x2,%eax
 4dd:	cd 40                	int    $0x40
 4df:	c3                   	ret    

000004e0 <wait>:
SYSCALL(wait)
 4e0:	b8 03 00 00 00       	mov    $0x3,%eax
 4e5:	cd 40                	int    $0x40
 4e7:	c3                   	ret    

000004e8 <pipe>:
SYSCALL(pipe)
 4e8:	b8 04 00 00 00       	mov    $0x4,%eax
 4ed:	cd 40                	int    $0x40
 4ef:	c3                   	ret    

000004f0 <read>:
SYSCALL(read)
 4f0:	b8 06 00 00 00       	mov    $0x6,%eax
 4f5:	cd 40                	int    $0x40
 4f7:	c3                   	ret    

000004f8 <write>:
SYSCALL(write)
 4f8:	b8 05 00 00 00       	mov    $0x5,%eax
 4fd:	cd 40                	int    $0x40
 4ff:	c3                   	ret    

00000500 <close>:
SYSCALL(close)
 500:	b8 07 00 00 00       	mov    $0x7,%eax
 505:	cd 40                	int    $0x40
 507:	c3                   	ret    

00000508 <kill>:
SYSCALL(kill)
 508:	b8 08 00 00 00       	mov    $0x8,%eax
 50d:	cd 40                	int    $0x40
 50f:	c3                   	ret    

00000510 <exec>:
SYSCALL(exec)
 510:	b8 09 00 00 00       	mov    $0x9,%eax
 515:	cd 40                	int    $0x40
 517:	c3                   	ret    

00000518 <open>:
SYSCALL(open)
 518:	b8 0a 00 00 00       	mov    $0xa,%eax
 51d:	cd 40                	int    $0x40
 51f:	c3                   	ret    

00000520 <mknod>:
SYSCALL(mknod)
 520:	b8 0b 00 00 00       	mov    $0xb,%eax
 525:	cd 40                	int    $0x40
 527:	c3                   	ret    

00000528 <unlink>:
SYSCALL(unlink)
 528:	b8 0c 00 00 00       	mov    $0xc,%eax
 52d:	cd 40                	int    $0x40
 52f:	c3                   	ret    

00000530 <fstat>:
SYSCALL(fstat)
 530:	b8 0d 00 00 00       	mov    $0xd,%eax
 535:	cd 40                	int    $0x40
 537:	c3                   	ret    

00000538 <link>:
SYSCALL(link)
 538:	b8 0e 00 00 00       	mov    $0xe,%eax
 53d:	cd 40                	int    $0x40
 53f:	c3                   	ret    

00000540 <mkdir>:
SYSCALL(mkdir)
 540:	b8 0f 00 00 00       	mov    $0xf,%eax
 545:	cd 40                	int    $0x40
 547:	c3                   	ret    

00000548 <chdir>:
SYSCALL(chdir)
 548:	b8 10 00 00 00       	mov    $0x10,%eax
 54d:	cd 40                	int    $0x40
 54f:	c3                   	ret    

00000550 <dup>:
SYSCALL(dup)
 550:	b8 11 00 00 00       	mov    $0x11,%eax
 555:	cd 40                	int    $0x40
 557:	c3                   	ret    

00000558 <getpid>:
SYSCALL(getpid)
 558:	b8 12 00 00 00       	mov    $0x12,%eax
 55d:	cd 40                	int    $0x40
 55f:	c3                   	ret    

00000560 <sbrk>:
SYSCALL(sbrk)
 560:	b8 13 00 00 00       	mov    $0x13,%eax
 565:	cd 40                	int    $0x40
 567:	c3                   	ret    

00000568 <sleep>:
SYSCALL(sleep)
 568:	b8 14 00 00 00       	mov    $0x14,%eax
 56d:	cd 40                	int    $0x40
 56f:	c3                   	ret    

00000570 <uptime>:
SYSCALL(uptime)
 570:	b8 15 00 00 00       	mov    $0x15,%eax
 575:	cd 40                	int    $0x40
 577:	c3                   	ret    

00000578 <freepages>:
// Added by Jingyue
SYSCALL(freepages)
 578:	b8 16 00 00 00       	mov    $0x16,%eax
 57d:	cd 40                	int    $0x40
 57f:	c3                   	ret    

00000580 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	83 ec 18             	sub    $0x18,%esp
 586:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 589:	8d 55 fc             	lea    -0x4(%ebp),%edx
 58c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 593:	00 
 594:	89 54 24 04          	mov    %edx,0x4(%esp)
 598:	89 04 24             	mov    %eax,(%esp)
 59b:	e8 58 ff ff ff       	call   4f8 <write>
}
 5a0:	c9                   	leave  
 5a1:	c3                   	ret    
 5a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 5a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000005b0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	57                   	push   %edi
 5b4:	56                   	push   %esi
 5b5:	89 ce                	mov    %ecx,%esi
 5b7:	53                   	push   %ebx
 5b8:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5bb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 5be:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5c1:	85 c9                	test   %ecx,%ecx
 5c3:	74 04                	je     5c9 <printint+0x19>
 5c5:	85 d2                	test   %edx,%edx
 5c7:	78 54                	js     61d <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5c9:	89 d0                	mov    %edx,%eax
 5cb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 5d2:	31 db                	xor    %ebx,%ebx
 5d4:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 5d7:	31 d2                	xor    %edx,%edx
 5d9:	f7 f6                	div    %esi
 5db:	89 c1                	mov    %eax,%ecx
 5dd:	0f b6 82 9f 09 00 00 	movzbl 0x99f(%edx),%eax
 5e4:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 5e7:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 5ea:	85 c9                	test   %ecx,%ecx
 5ec:	89 c8                	mov    %ecx,%eax
 5ee:	75 e7                	jne    5d7 <printint+0x27>
  if(neg)
 5f0:	8b 45 e0             	mov    -0x20(%ebp),%eax
 5f3:	85 c0                	test   %eax,%eax
 5f5:	74 08                	je     5ff <printint+0x4f>
    buf[i++] = '-';
 5f7:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 5fc:	83 c3 01             	add    $0x1,%ebx
 5ff:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 602:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 606:	83 eb 01             	sub    $0x1,%ebx
 609:	8b 45 dc             	mov    -0x24(%ebp),%eax
 60c:	e8 6f ff ff ff       	call   580 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 611:	39 fb                	cmp    %edi,%ebx
 613:	75 ed                	jne    602 <printint+0x52>
    putc(fd, buf[i]);
}
 615:	83 c4 1c             	add    $0x1c,%esp
 618:	5b                   	pop    %ebx
 619:	5e                   	pop    %esi
 61a:	5f                   	pop    %edi
 61b:	5d                   	pop    %ebp
 61c:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 61d:	89 d0                	mov    %edx,%eax
 61f:	f7 d8                	neg    %eax
 621:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 628:	eb a8                	jmp    5d2 <printint+0x22>
 62a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000630 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	57                   	push   %edi
 634:	56                   	push   %esi
 635:	53                   	push   %ebx
 636:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 639:	8b 55 0c             	mov    0xc(%ebp),%edx
 63c:	0f b6 02             	movzbl (%edx),%eax
 63f:	84 c0                	test   %al,%al
 641:	0f 84 87 00 00 00    	je     6ce <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 647:	8d 4d 10             	lea    0x10(%ebp),%ecx
 64a:	31 ff                	xor    %edi,%edi
 64c:	31 f6                	xor    %esi,%esi
 64e:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 651:	eb 18                	jmp    66b <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 653:	83 fb 25             	cmp    $0x25,%ebx
 656:	0f 85 7a 00 00 00    	jne    6d6 <printf+0xa6>
 65c:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 660:	83 c7 01             	add    $0x1,%edi
 663:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 667:	84 c0                	test   %al,%al
 669:	74 63                	je     6ce <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 66b:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 66d:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 670:	74 e1                	je     653 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 672:	83 fe 25             	cmp    $0x25,%esi
 675:	75 e9                	jne    660 <printf+0x30>
      if(c == 'd'){
 677:	83 fb 64             	cmp    $0x64,%ebx
 67a:	0f 84 f0 00 00 00    	je     770 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 680:	83 fb 78             	cmp    $0x78,%ebx
 683:	74 64                	je     6e9 <printf+0xb9>
 685:	83 fb 70             	cmp    $0x70,%ebx
 688:	74 5f                	je     6e9 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 68a:	83 fb 73             	cmp    $0x73,%ebx
 68d:	8d 76 00             	lea    0x0(%esi),%esi
 690:	74 7e                	je     710 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 692:	83 fb 63             	cmp    $0x63,%ebx
 695:	0f 84 b9 00 00 00    	je     754 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 69b:	83 fb 25             	cmp    $0x25,%ebx
 69e:	66 90                	xchg   %ax,%ax
 6a0:	0f 84 f2 00 00 00    	je     798 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6a6:	8b 45 08             	mov    0x8(%ebp),%eax
 6a9:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6ae:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 6b1:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6b3:	e8 c8 fe ff ff       	call   580 <putc>
        putc(fd, c);
 6b8:	8b 45 08             	mov    0x8(%ebp),%eax
 6bb:	0f be d3             	movsbl %bl,%edx
 6be:	e8 bd fe ff ff       	call   580 <putc>
 6c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6c6:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 6ca:	84 c0                	test   %al,%al
 6cc:	75 9d                	jne    66b <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6ce:	83 c4 0c             	add    $0xc,%esp
 6d1:	5b                   	pop    %ebx
 6d2:	5e                   	pop    %esi
 6d3:	5f                   	pop    %edi
 6d4:	5d                   	pop    %ebp
 6d5:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 6d6:	8b 45 08             	mov    0x8(%ebp),%eax
 6d9:	0f be d3             	movsbl %bl,%edx
 6dc:	e8 9f fe ff ff       	call   580 <putc>
 6e1:	8b 55 0c             	mov    0xc(%ebp),%edx
 6e4:	e9 77 ff ff ff       	jmp    660 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 6e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6ec:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 6f1:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 6f3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 6fa:	8b 10                	mov    (%eax),%edx
 6fc:	8b 45 08             	mov    0x8(%ebp),%eax
 6ff:	e8 ac fe ff ff       	call   5b0 <printint>
 704:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 707:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 70b:	e9 50 ff ff ff       	jmp    660 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 710:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 713:	8b 01                	mov    (%ecx),%eax
        ap++;
 715:	83 c1 04             	add    $0x4,%ecx
 718:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 71b:	b9 98 09 00 00       	mov    $0x998,%ecx
 720:	85 c0                	test   %eax,%eax
 722:	75 2c                	jne    750 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 724:	0f b6 01             	movzbl (%ecx),%eax
 727:	84 c0                	test   %al,%al
 729:	74 1e                	je     749 <printf+0x119>
 72b:	89 cb                	mov    %ecx,%ebx
 72d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 730:	0f be d0             	movsbl %al,%edx
 733:	8b 45 08             	mov    0x8(%ebp),%eax
 736:	e8 45 fe ff ff       	call   580 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 73b:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 73f:	83 c3 01             	add    $0x1,%ebx
 742:	84 c0                	test   %al,%al
 744:	75 ea                	jne    730 <printf+0x100>
 746:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 749:	31 f6                	xor    %esi,%esi
 74b:	e9 10 ff ff ff       	jmp    660 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 750:	89 c1                	mov    %eax,%ecx
 752:	eb d0                	jmp    724 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 754:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 757:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 759:	0f be 10             	movsbl (%eax),%edx
 75c:	8b 45 08             	mov    0x8(%ebp),%eax
 75f:	e8 1c fe ff ff       	call   580 <putc>
 764:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 767:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 76b:	e9 f0 fe ff ff       	jmp    660 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 770:	8b 45 f0             	mov    -0x10(%ebp),%eax
 773:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 778:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 77b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 782:	8b 10                	mov    (%eax),%edx
 784:	8b 45 08             	mov    0x8(%ebp),%eax
 787:	e8 24 fe ff ff       	call   5b0 <printint>
 78c:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 78f:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 793:	e9 c8 fe ff ff       	jmp    660 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 798:	8b 45 08             	mov    0x8(%ebp),%eax
 79b:	ba 25 00 00 00       	mov    $0x25,%edx
 7a0:	31 f6                	xor    %esi,%esi
 7a2:	e8 d9 fd ff ff       	call   580 <putc>
 7a7:	8b 55 0c             	mov    0xc(%ebp),%edx
 7aa:	e9 b1 fe ff ff       	jmp    660 <printf+0x30>
 7af:	90                   	nop    

000007b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b1:	8b 0d c4 09 00 00    	mov    0x9c4,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 7b7:	89 e5                	mov    %esp,%ebp
 7b9:	56                   	push   %esi
 7ba:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 7bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 7be:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c1:	39 d9                	cmp    %ebx,%ecx
 7c3:	73 18                	jae    7dd <free+0x2d>
 7c5:	8b 11                	mov    (%ecx),%edx
 7c7:	39 d3                	cmp    %edx,%ebx
 7c9:	72 17                	jb     7e2 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7cb:	39 d1                	cmp    %edx,%ecx
 7cd:	72 08                	jb     7d7 <free+0x27>
 7cf:	39 d9                	cmp    %ebx,%ecx
 7d1:	72 0f                	jb     7e2 <free+0x32>
 7d3:	39 d3                	cmp    %edx,%ebx
 7d5:	72 0b                	jb     7e2 <free+0x32>
 7d7:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d9:	39 d9                	cmp    %ebx,%ecx
 7db:	72 e8                	jb     7c5 <free+0x15>
 7dd:	8b 11                	mov    (%ecx),%edx
 7df:	90                   	nop    
 7e0:	eb e9                	jmp    7cb <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7e2:	8b 73 04             	mov    0x4(%ebx),%esi
 7e5:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 7e8:	39 d0                	cmp    %edx,%eax
 7ea:	74 18                	je     804 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7ec:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 7ee:	8b 51 04             	mov    0x4(%ecx),%edx
 7f1:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 7f4:	39 d8                	cmp    %ebx,%eax
 7f6:	74 20                	je     818 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7f8:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 7fa:	5b                   	pop    %ebx
 7fb:	5e                   	pop    %esi
 7fc:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 7fd:	89 0d c4 09 00 00    	mov    %ecx,0x9c4
}
 803:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 804:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 807:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 809:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 80c:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 80f:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 811:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 814:	39 d8                	cmp    %ebx,%eax
 816:	75 e0                	jne    7f8 <free+0x48>
    p->s.size += bp->s.size;
 818:	03 53 04             	add    0x4(%ebx),%edx
 81b:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 81e:	8b 13                	mov    (%ebx),%edx
 820:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 822:	5b                   	pop    %ebx
 823:	5e                   	pop    %esi
 824:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 825:	89 0d c4 09 00 00    	mov    %ecx,0x9c4
}
 82b:	c3                   	ret    
 82c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000830 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 830:	55                   	push   %ebp
 831:	89 e5                	mov    %esp,%ebp
 833:	57                   	push   %edi
 834:	56                   	push   %esi
 835:	53                   	push   %ebx
 836:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 839:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 83c:	8b 15 c4 09 00 00    	mov    0x9c4,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 842:	83 c0 07             	add    $0x7,%eax
 845:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 848:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 84a:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 84d:	0f 84 8a 00 00 00    	je     8dd <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 853:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 855:	8b 41 04             	mov    0x4(%ecx),%eax
 858:	39 c3                	cmp    %eax,%ebx
 85a:	76 1a                	jbe    876 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 85c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 863:	3b 0d c4 09 00 00    	cmp    0x9c4,%ecx
 869:	89 ca                	mov    %ecx,%edx
 86b:	74 29                	je     896 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 86d:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 86f:	8b 41 04             	mov    0x4(%ecx),%eax
 872:	39 c3                	cmp    %eax,%ebx
 874:	77 ed                	ja     863 <malloc+0x33>
      if(p->s.size == nunits)
 876:	39 c3                	cmp    %eax,%ebx
 878:	74 5d                	je     8d7 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 87a:	29 d8                	sub    %ebx,%eax
 87c:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 87f:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 882:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 885:	89 15 c4 09 00 00    	mov    %edx,0x9c4
      return (void*) (p + 1);
 88b:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 88e:	83 c4 0c             	add    $0xc,%esp
 891:	5b                   	pop    %ebx
 892:	5e                   	pop    %esi
 893:	5f                   	pop    %edi
 894:	5d                   	pop    %ebp
 895:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 896:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 89c:	89 de                	mov    %ebx,%esi
 89e:	89 f8                	mov    %edi,%eax
 8a0:	76 29                	jbe    8cb <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 8a2:	89 04 24             	mov    %eax,(%esp)
 8a5:	e8 b6 fc ff ff       	call   560 <sbrk>
  if(p == (char*) -1)
 8aa:	83 f8 ff             	cmp    $0xffffffff,%eax
 8ad:	74 18                	je     8c7 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 8af:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 8b2:	83 c0 08             	add    $0x8,%eax
 8b5:	89 04 24             	mov    %eax,(%esp)
 8b8:	e8 f3 fe ff ff       	call   7b0 <free>
  return freep;
 8bd:	8b 15 c4 09 00 00    	mov    0x9c4,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 8c3:	85 d2                	test   %edx,%edx
 8c5:	75 a6                	jne    86d <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 8c7:	31 c0                	xor    %eax,%eax
 8c9:	eb c3                	jmp    88e <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 8cb:	be 00 10 00 00       	mov    $0x1000,%esi
 8d0:	b8 00 80 00 00       	mov    $0x8000,%eax
 8d5:	eb cb                	jmp    8a2 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 8d7:	8b 01                	mov    (%ecx),%eax
 8d9:	89 02                	mov    %eax,(%edx)
 8db:	eb a8                	jmp    885 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 8dd:	ba bc 09 00 00       	mov    $0x9bc,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 8e2:	c7 05 c4 09 00 00 bc 	movl   $0x9bc,0x9c4
 8e9:	09 00 00 
 8ec:	c7 05 bc 09 00 00 bc 	movl   $0x9bc,0x9bc
 8f3:	09 00 00 
    base.s.size = 0;
 8f6:	c7 05 c0 09 00 00 00 	movl   $0x0,0x9c0
 8fd:	00 00 00 
 900:	e9 4e ff ff ff       	jmp    853 <malloc+0x23>
