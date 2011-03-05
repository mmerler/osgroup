
_wc:     file format elf32-i386

Disassembly of section .text:

00000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	31 ff                	xor    %edi,%edi
   6:	56                   	push   %esi
   7:	53                   	push   %ebx
   8:	83 ec 2c             	sub    $0x2c,%esp
   b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  12:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  19:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
  20:	8b 45 08             	mov    0x8(%ebp),%eax
  23:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  2a:	00 
  2b:	c7 44 24 04 80 08 00 	movl   $0x880,0x4(%esp)
  32:	00 
  33:	89 04 24             	mov    %eax,(%esp)
  36:	e8 85 03 00 00       	call   3c0 <read>
  3b:	83 f8 00             	cmp    $0x0,%eax
  3e:	89 c6                	mov    %eax,%esi
  40:	7e 59                	jle    9b <wc+0x9b>
  42:	31 db                	xor    %ebx,%ebx
  44:	eb 0e                	jmp    54 <wc+0x54>
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  46:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
  4d:	83 c3 01             	add    $0x1,%ebx
  50:	39 f3                	cmp    %esi,%ebx
  52:	74 3d                	je     91 <wc+0x91>
      c++;
      if(buf[i] == '\n')
  54:	0f be 83 80 08 00 00 	movsbl 0x880(%ebx),%eax
        l++;
  5b:	31 d2                	xor    %edx,%edx
      if(strchr(" \r\t\n\v", buf[i]))
  5d:	c7 04 24 f5 07 00 00 	movl   $0x7f5,(%esp)
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
        l++;
  64:	3c 0a                	cmp    $0xa,%al
  66:	0f 94 c2             	sete   %dl
  69:	01 d7                	add    %edx,%edi
      if(strchr(" \r\t\n\v", buf[i]))
  6b:	89 44 24 04          	mov    %eax,0x4(%esp)
  6f:	e8 ec 01 00 00       	call   260 <strchr>
  74:	85 c0                	test   %eax,%eax
  76:	75 ce                	jne    46 <wc+0x46>
        inword = 0;
      else if(!inword){
  78:	8b 45 f0             	mov    -0x10(%ebp),%eax
  7b:	85 c0                	test   %eax,%eax
  7d:	75 ce                	jne    4d <wc+0x4d>
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
  7f:	83 c3 01             	add    $0x1,%ebx
      if(buf[i] == '\n')
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
        inword = 0;
      else if(!inword){
        w++;
  82:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
  86:	39 f3                	cmp    %esi,%ebx
      if(buf[i] == '\n')
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
        inword = 0;
      else if(!inword){
        w++;
  88:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
  8f:	75 c3                	jne    54 <wc+0x54>
  91:	8b 45 ec             	mov    -0x14(%ebp),%eax
  94:	01 f0                	add    %esi,%eax
  96:	89 45 ec             	mov    %eax,-0x14(%ebp)
  99:	eb 85                	jmp    20 <wc+0x20>
        w++;
        inword = 1;
      }
    }
  }
  if(n < 0){
  9b:	75 35                	jne    d2 <wc+0xd2>
    printf(1, "wc: read error\n");
    exit();
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
  9d:	8b 45 0c             	mov    0xc(%ebp),%eax
  a0:	89 7c 24 08          	mov    %edi,0x8(%esp)
  a4:	c7 44 24 04 0b 08 00 	movl   $0x80b,0x4(%esp)
  ab:	00 
  ac:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  b3:	89 44 24 14          	mov    %eax,0x14(%esp)
  b7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  ba:	89 44 24 10          	mov    %eax,0x10(%esp)
  be:	8b 45 e8             	mov    -0x18(%ebp),%eax
  c1:	89 44 24 0c          	mov    %eax,0xc(%esp)
  c5:	e8 56 04 00 00       	call   520 <printf>
}
  ca:	83 c4 2c             	add    $0x2c,%esp
  cd:	5b                   	pop    %ebx
  ce:	5e                   	pop    %esi
  cf:	5f                   	pop    %edi
  d0:	5d                   	pop    %ebp
  d1:	c3                   	ret    
        inword = 1;
      }
    }
  }
  if(n < 0){
    printf(1, "wc: read error\n");
  d2:	c7 44 24 04 fb 07 00 	movl   $0x7fb,0x4(%esp)
  d9:	00 
  da:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  e1:	e8 3a 04 00 00       	call   520 <printf>
    exit();
  e6:	e8 bd 02 00 00       	call   3a8 <exit>
  eb:	90                   	nop    
  ec:	8d 74 26 00          	lea    0x0(%esi),%esi

000000f0 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
}

int
main(int argc, char *argv[])
{
  f0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  f4:	83 e4 f0             	and    $0xfffffff0,%esp
  f7:	ff 71 fc             	pushl  -0x4(%ecx)
  fa:	55                   	push   %ebp
  fb:	89 e5                	mov    %esp,%ebp
  fd:	57                   	push   %edi
  int fd, i;

  if(argc <= 1){
    wc(0, "");
    exit();
  fe:	bf 01 00 00 00       	mov    $0x1,%edi
  printf(1, "%d %d %d %s\n", l, w, c, name);
}

int
main(int argc, char *argv[])
{
 103:	56                   	push   %esi
 104:	53                   	push   %ebx
 105:	51                   	push   %ecx
 106:	83 ec 18             	sub    $0x18,%esp
 109:	8b 01                	mov    (%ecx),%eax
 10b:	89 45 ec             	mov    %eax,-0x14(%ebp)
 10e:	8b 41 04             	mov    0x4(%ecx),%eax
  int fd, i;

  if(argc <= 1){
 111:	83 7d ec 01          	cmpl   $0x1,-0x14(%ebp)
    wc(0, "");
    exit();
 115:	8d 70 04             	lea    0x4(%eax),%esi
int
main(int argc, char *argv[])
{
  int fd, i;

  if(argc <= 1){
 118:	7f 27                	jg     141 <main+0x51>
 11a:	eb 61                	jmp    17d <main+0x8d>
 11c:	8d 74 26 00          	lea    0x0(%esi),%esi
  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
 120:	8b 06                	mov    (%esi),%eax
  if(argc <= 1){
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
 122:	83 c7 01             	add    $0x1,%edi
 125:	83 c6 04             	add    $0x4,%esi
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
 128:	89 1c 24             	mov    %ebx,(%esp)
 12b:	89 44 24 04          	mov    %eax,0x4(%esp)
 12f:	e8 cc fe ff ff       	call   0 <wc>
    close(fd);
 134:	89 1c 24             	mov    %ebx,(%esp)
 137:	e8 94 02 00 00       	call   3d0 <close>
  if(argc <= 1){
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
 13c:	3b 7d ec             	cmp    -0x14(%ebp),%edi
 13f:	74 37                	je     178 <main+0x88>
    if((fd = open(argv[i], 0)) < 0){
 141:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 148:	00 
 149:	8b 06                	mov    (%esi),%eax
 14b:	89 04 24             	mov    %eax,(%esp)
 14e:	e8 95 02 00 00       	call   3e8 <open>
 153:	85 c0                	test   %eax,%eax
 155:	89 c3                	mov    %eax,%ebx
 157:	79 c7                	jns    120 <main+0x30>
      printf(1, "cat: cannot open %s\n", argv[i]);
 159:	8b 06                	mov    (%esi),%eax
 15b:	c7 44 24 04 18 08 00 	movl   $0x818,0x4(%esp)
 162:	00 
 163:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 16a:	89 44 24 08          	mov    %eax,0x8(%esp)
 16e:	e8 ad 03 00 00       	call   520 <printf>
      exit();
 173:	e8 30 02 00 00       	call   3a8 <exit>
    }
    wc(fd, argv[i]);
    close(fd);
  }
  exit();
 178:	e8 2b 02 00 00       	call   3a8 <exit>
main(int argc, char *argv[])
{
  int fd, i;

  if(argc <= 1){
    wc(0, "");
 17d:	c7 44 24 04 0a 08 00 	movl   $0x80a,0x4(%esp)
 184:	00 
 185:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 18c:	e8 6f fe ff ff       	call   0 <wc>
    exit();
 191:	e8 12 02 00 00       	call   3a8 <exit>
 196:	90                   	nop    
 197:	90                   	nop    
 198:	90                   	nop    
 199:	90                   	nop    
 19a:	90                   	nop    
 19b:	90                   	nop    
 19c:	90                   	nop    
 19d:	90                   	nop    
 19e:	90                   	nop    
 19f:	90                   	nop    

000001a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	53                   	push   %ebx
 1a4:	8b 5d 08             	mov    0x8(%ebp),%ebx
 1a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1aa:	89 da                	mov    %ebx,%edx
 1ac:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1b0:	0f b6 01             	movzbl (%ecx),%eax
 1b3:	83 c1 01             	add    $0x1,%ecx
 1b6:	88 02                	mov    %al,(%edx)
 1b8:	83 c2 01             	add    $0x1,%edx
 1bb:	84 c0                	test   %al,%al
 1bd:	75 f1                	jne    1b0 <strcpy+0x10>
    ;
  return os;
}
 1bf:	89 d8                	mov    %ebx,%eax
 1c1:	5b                   	pop    %ebx
 1c2:	5d                   	pop    %ebp
 1c3:	c3                   	ret    
 1c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1d6:	53                   	push   %ebx
 1d7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 1da:	0f b6 01             	movzbl (%ecx),%eax
 1dd:	84 c0                	test   %al,%al
 1df:	74 24                	je     205 <strcmp+0x35>
 1e1:	0f b6 13             	movzbl (%ebx),%edx
 1e4:	38 d0                	cmp    %dl,%al
 1e6:	74 12                	je     1fa <strcmp+0x2a>
 1e8:	eb 1e                	jmp    208 <strcmp+0x38>
 1ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1f0:	0f b6 13             	movzbl (%ebx),%edx
 1f3:	83 c1 01             	add    $0x1,%ecx
 1f6:	38 d0                	cmp    %dl,%al
 1f8:	75 0e                	jne    208 <strcmp+0x38>
 1fa:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 1fe:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 201:	84 c0                	test   %al,%al
 203:	75 eb                	jne    1f0 <strcmp+0x20>
 205:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 208:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 209:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 20c:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 20d:	0f b6 d2             	movzbl %dl,%edx
 210:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 212:	c3                   	ret    
 213:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 219:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000220 <strlen>:

uint
strlen(char *s)
{
 220:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 221:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 223:	89 e5                	mov    %esp,%ebp
 225:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 228:	80 39 00             	cmpb   $0x0,(%ecx)
 22b:	74 0e                	je     23b <strlen+0x1b>
 22d:	31 d2                	xor    %edx,%edx
 22f:	90                   	nop    
 230:	83 c2 01             	add    $0x1,%edx
 233:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
 237:	89 d0                	mov    %edx,%eax
 239:	75 f5                	jne    230 <strlen+0x10>
    ;
  return n;
}
 23b:	5d                   	pop    %ebp
 23c:	c3                   	ret    
 23d:	8d 76 00             	lea    0x0(%esi),%esi

00000240 <memset>:

void*
memset(void *dst, int c, uint n)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	8b 55 08             	mov    0x8(%ebp),%edx
 246:	57                   	push   %edi
 247:	8b 45 0c             	mov    0xc(%ebp),%eax
 24a:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 24d:	89 d7                	mov    %edx,%edi
 24f:	fc                   	cld    
 250:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 252:	5f                   	pop    %edi
 253:	89 d0                	mov    %edx,%eax
 255:	5d                   	pop    %ebp
 256:	c3                   	ret    
 257:	89 f6                	mov    %esi,%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000260 <strchr>:

char*
strchr(const char *s, char c)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	8b 45 08             	mov    0x8(%ebp),%eax
 266:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 26a:	0f b6 10             	movzbl (%eax),%edx
 26d:	84 d2                	test   %dl,%dl
 26f:	75 0c                	jne    27d <strchr+0x1d>
 271:	eb 11                	jmp    284 <strchr+0x24>
 273:	83 c0 01             	add    $0x1,%eax
 276:	0f b6 10             	movzbl (%eax),%edx
 279:	84 d2                	test   %dl,%dl
 27b:	74 07                	je     284 <strchr+0x24>
    if(*s == c)
 27d:	38 ca                	cmp    %cl,%dl
 27f:	90                   	nop    
 280:	75 f1                	jne    273 <strchr+0x13>
      return (char*) s;
  return 0;
}
 282:	5d                   	pop    %ebp
 283:	c3                   	ret    
 284:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 285:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 287:	c3                   	ret    
 288:	90                   	nop    
 289:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000290 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	8b 4d 08             	mov    0x8(%ebp),%ecx
 296:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 297:	31 db                	xor    %ebx,%ebx
 299:	0f b6 11             	movzbl (%ecx),%edx
 29c:	8d 42 d0             	lea    -0x30(%edx),%eax
 29f:	3c 09                	cmp    $0x9,%al
 2a1:	77 18                	ja     2bb <atoi+0x2b>
    n = n*10 + *s++ - '0';
 2a3:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 2a6:	0f be d2             	movsbl %dl,%edx
 2a9:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2ad:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 2b1:	83 c1 01             	add    $0x1,%ecx
 2b4:	8d 42 d0             	lea    -0x30(%edx),%eax
 2b7:	3c 09                	cmp    $0x9,%al
 2b9:	76 e8                	jbe    2a3 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 2bb:	89 d8                	mov    %ebx,%eax
 2bd:	5b                   	pop    %ebx
 2be:	5d                   	pop    %ebp
 2bf:	c3                   	ret    

000002c0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	8b 4d 10             	mov    0x10(%ebp),%ecx
 2c6:	56                   	push   %esi
 2c7:	8b 75 08             	mov    0x8(%ebp),%esi
 2ca:	53                   	push   %ebx
 2cb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ce:	85 c9                	test   %ecx,%ecx
 2d0:	7e 10                	jle    2e2 <memmove+0x22>
 2d2:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 2d4:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 2d8:	88 04 32             	mov    %al,(%edx,%esi,1)
 2db:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2de:	39 ca                	cmp    %ecx,%edx
 2e0:	75 f2                	jne    2d4 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 2e2:	89 f0                	mov    %esi,%eax
 2e4:	5b                   	pop    %ebx
 2e5:	5e                   	pop    %esi
 2e6:	5d                   	pop    %ebp
 2e7:	c3                   	ret    
 2e8:	90                   	nop    
 2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000002f0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2f6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 2f9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 2fc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 2ff:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 304:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 30b:	00 
 30c:	89 04 24             	mov    %eax,(%esp)
 30f:	e8 d4 00 00 00       	call   3e8 <open>
  if(fd < 0)
 314:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 316:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 318:	78 19                	js     333 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 31a:	8b 45 0c             	mov    0xc(%ebp),%eax
 31d:	89 1c 24             	mov    %ebx,(%esp)
 320:	89 44 24 04          	mov    %eax,0x4(%esp)
 324:	e8 d7 00 00 00       	call   400 <fstat>
  close(fd);
 329:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 32c:	89 c6                	mov    %eax,%esi
  close(fd);
 32e:	e8 9d 00 00 00       	call   3d0 <close>
  return r;
}
 333:	89 f0                	mov    %esi,%eax
 335:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 338:	8b 75 fc             	mov    -0x4(%ebp),%esi
 33b:	89 ec                	mov    %ebp,%esp
 33d:	5d                   	pop    %ebp
 33e:	c3                   	ret    
 33f:	90                   	nop    

00000340 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	56                   	push   %esi
 345:	31 f6                	xor    %esi,%esi
 347:	53                   	push   %ebx
 348:	83 ec 1c             	sub    $0x1c,%esp
 34b:	8b 7d 08             	mov    0x8(%ebp),%edi
 34e:	eb 06                	jmp    356 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 350:	3c 0d                	cmp    $0xd,%al
 352:	74 39                	je     38d <gets+0x4d>
 354:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 356:	8d 5e 01             	lea    0x1(%esi),%ebx
 359:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 35c:	7d 31                	jge    38f <gets+0x4f>
    cc = read(0, &c, 1);
 35e:	8d 45 f3             	lea    -0xd(%ebp),%eax
 361:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 368:	00 
 369:	89 44 24 04          	mov    %eax,0x4(%esp)
 36d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 374:	e8 47 00 00 00       	call   3c0 <read>
    if(cc < 1)
 379:	85 c0                	test   %eax,%eax
 37b:	7e 12                	jle    38f <gets+0x4f>
      break;
    buf[i++] = c;
 37d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 381:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 385:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 389:	3c 0a                	cmp    $0xa,%al
 38b:	75 c3                	jne    350 <gets+0x10>
 38d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 38f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 393:	89 f8                	mov    %edi,%eax
 395:	83 c4 1c             	add    $0x1c,%esp
 398:	5b                   	pop    %ebx
 399:	5e                   	pop    %esi
 39a:	5f                   	pop    %edi
 39b:	5d                   	pop    %ebp
 39c:	c3                   	ret    
 39d:	90                   	nop    
 39e:	90                   	nop    
 39f:	90                   	nop    

000003a0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3a0:	b8 01 00 00 00       	mov    $0x1,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <exit>:
SYSCALL(exit)
 3a8:	b8 02 00 00 00       	mov    $0x2,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <wait>:
SYSCALL(wait)
 3b0:	b8 03 00 00 00       	mov    $0x3,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <pipe>:
SYSCALL(pipe)
 3b8:	b8 04 00 00 00       	mov    $0x4,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <read>:
SYSCALL(read)
 3c0:	b8 06 00 00 00       	mov    $0x6,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <write>:
SYSCALL(write)
 3c8:	b8 05 00 00 00       	mov    $0x5,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <close>:
SYSCALL(close)
 3d0:	b8 07 00 00 00       	mov    $0x7,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <kill>:
SYSCALL(kill)
 3d8:	b8 08 00 00 00       	mov    $0x8,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <exec>:
SYSCALL(exec)
 3e0:	b8 09 00 00 00       	mov    $0x9,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <open>:
SYSCALL(open)
 3e8:	b8 0a 00 00 00       	mov    $0xa,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <mknod>:
SYSCALL(mknod)
 3f0:	b8 0b 00 00 00       	mov    $0xb,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <unlink>:
SYSCALL(unlink)
 3f8:	b8 0c 00 00 00       	mov    $0xc,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <fstat>:
SYSCALL(fstat)
 400:	b8 0d 00 00 00       	mov    $0xd,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <link>:
SYSCALL(link)
 408:	b8 0e 00 00 00       	mov    $0xe,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <mkdir>:
SYSCALL(mkdir)
 410:	b8 0f 00 00 00       	mov    $0xf,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <chdir>:
SYSCALL(chdir)
 418:	b8 10 00 00 00       	mov    $0x10,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <dup>:
SYSCALL(dup)
 420:	b8 11 00 00 00       	mov    $0x11,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <getpid>:
SYSCALL(getpid)
 428:	b8 12 00 00 00       	mov    $0x12,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <sbrk>:
SYSCALL(sbrk)
 430:	b8 13 00 00 00       	mov    $0x13,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    

00000438 <sleep>:
SYSCALL(sleep)
 438:	b8 14 00 00 00       	mov    $0x14,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <uptime>:
SYSCALL(uptime)
 440:	b8 15 00 00 00       	mov    $0x15,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <pschk>:
SYSCALL(pschk)
 448:	b8 17 00 00 00       	mov    $0x17,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <rwlock>:
SYSCALL(rwlock)
 450:	b8 16 00 00 00       	mov    $0x16,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    

00000458 <tfork>:
SYSCALL(tfork)
 458:	b8 18 00 00 00       	mov    $0x18,%eax
 45d:	cd 40                	int    $0x40
 45f:	c3                   	ret    

00000460 <texit>:
SYSCALL(texit)
 460:	b8 19 00 00 00       	mov    $0x19,%eax
 465:	cd 40                	int    $0x40
 467:	c3                   	ret    

00000468 <twait>:
SYSCALL(twait)
 468:	b8 1a 00 00 00       	mov    $0x1a,%eax
 46d:	cd 40                	int    $0x40
 46f:	c3                   	ret    

00000470 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	83 ec 18             	sub    $0x18,%esp
 476:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 479:	8d 55 fc             	lea    -0x4(%ebp),%edx
 47c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 483:	00 
 484:	89 54 24 04          	mov    %edx,0x4(%esp)
 488:	89 04 24             	mov    %eax,(%esp)
 48b:	e8 38 ff ff ff       	call   3c8 <write>
}
 490:	c9                   	leave  
 491:	c3                   	ret    
 492:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 499:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000004a0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	57                   	push   %edi
 4a4:	56                   	push   %esi
 4a5:	89 ce                	mov    %ecx,%esi
 4a7:	53                   	push   %ebx
 4a8:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4ab:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4ae:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4b1:	85 c9                	test   %ecx,%ecx
 4b3:	74 04                	je     4b9 <printint+0x19>
 4b5:	85 d2                	test   %edx,%edx
 4b7:	78 54                	js     50d <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4b9:	89 d0                	mov    %edx,%eax
 4bb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 4c2:	31 db                	xor    %ebx,%ebx
 4c4:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 4c7:	31 d2                	xor    %edx,%edx
 4c9:	f7 f6                	div    %esi
 4cb:	89 c1                	mov    %eax,%ecx
 4cd:	0f b6 82 34 08 00 00 	movzbl 0x834(%edx),%eax
 4d4:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 4d7:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 4da:	85 c9                	test   %ecx,%ecx
 4dc:	89 c8                	mov    %ecx,%eax
 4de:	75 e7                	jne    4c7 <printint+0x27>
  if(neg)
 4e0:	8b 45 e0             	mov    -0x20(%ebp),%eax
 4e3:	85 c0                	test   %eax,%eax
 4e5:	74 08                	je     4ef <printint+0x4f>
    buf[i++] = '-';
 4e7:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 4ec:	83 c3 01             	add    $0x1,%ebx
 4ef:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 4f2:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 4f6:	83 eb 01             	sub    $0x1,%ebx
 4f9:	8b 45 dc             	mov    -0x24(%ebp),%eax
 4fc:	e8 6f ff ff ff       	call   470 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 501:	39 fb                	cmp    %edi,%ebx
 503:	75 ed                	jne    4f2 <printint+0x52>
    putc(fd, buf[i]);
}
 505:	83 c4 1c             	add    $0x1c,%esp
 508:	5b                   	pop    %ebx
 509:	5e                   	pop    %esi
 50a:	5f                   	pop    %edi
 50b:	5d                   	pop    %ebp
 50c:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 50d:	89 d0                	mov    %edx,%eax
 50f:	f7 d8                	neg    %eax
 511:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 518:	eb a8                	jmp    4c2 <printint+0x22>
 51a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000520 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	57                   	push   %edi
 524:	56                   	push   %esi
 525:	53                   	push   %ebx
 526:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 529:	8b 55 0c             	mov    0xc(%ebp),%edx
 52c:	0f b6 02             	movzbl (%edx),%eax
 52f:	84 c0                	test   %al,%al
 531:	0f 84 87 00 00 00    	je     5be <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 537:	8d 4d 10             	lea    0x10(%ebp),%ecx
 53a:	31 ff                	xor    %edi,%edi
 53c:	31 f6                	xor    %esi,%esi
 53e:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 541:	eb 18                	jmp    55b <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 543:	83 fb 25             	cmp    $0x25,%ebx
 546:	0f 85 7a 00 00 00    	jne    5c6 <printf+0xa6>
 54c:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 550:	83 c7 01             	add    $0x1,%edi
 553:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 557:	84 c0                	test   %al,%al
 559:	74 63                	je     5be <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 55b:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 55d:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 560:	74 e1                	je     543 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 562:	83 fe 25             	cmp    $0x25,%esi
 565:	75 e9                	jne    550 <printf+0x30>
      if(c == 'd'){
 567:	83 fb 64             	cmp    $0x64,%ebx
 56a:	0f 84 f0 00 00 00    	je     660 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 570:	83 fb 78             	cmp    $0x78,%ebx
 573:	74 64                	je     5d9 <printf+0xb9>
 575:	83 fb 70             	cmp    $0x70,%ebx
 578:	74 5f                	je     5d9 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 57a:	83 fb 73             	cmp    $0x73,%ebx
 57d:	8d 76 00             	lea    0x0(%esi),%esi
 580:	74 7e                	je     600 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 582:	83 fb 63             	cmp    $0x63,%ebx
 585:	0f 84 b9 00 00 00    	je     644 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 58b:	83 fb 25             	cmp    $0x25,%ebx
 58e:	66 90                	xchg   %ax,%ax
 590:	0f 84 f2 00 00 00    	je     688 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 596:	8b 45 08             	mov    0x8(%ebp),%eax
 599:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 59e:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 5a1:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5a3:	e8 c8 fe ff ff       	call   470 <putc>
        putc(fd, c);
 5a8:	8b 45 08             	mov    0x8(%ebp),%eax
 5ab:	0f be d3             	movsbl %bl,%edx
 5ae:	e8 bd fe ff ff       	call   470 <putc>
 5b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5b6:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 5ba:	84 c0                	test   %al,%al
 5bc:	75 9d                	jne    55b <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5be:	83 c4 0c             	add    $0xc,%esp
 5c1:	5b                   	pop    %ebx
 5c2:	5e                   	pop    %esi
 5c3:	5f                   	pop    %edi
 5c4:	5d                   	pop    %ebp
 5c5:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 5c6:	8b 45 08             	mov    0x8(%ebp),%eax
 5c9:	0f be d3             	movsbl %bl,%edx
 5cc:	e8 9f fe ff ff       	call   470 <putc>
 5d1:	8b 55 0c             	mov    0xc(%ebp),%edx
 5d4:	e9 77 ff ff ff       	jmp    550 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5dc:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 5e1:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5e3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 5ea:	8b 10                	mov    (%eax),%edx
 5ec:	8b 45 08             	mov    0x8(%ebp),%eax
 5ef:	e8 ac fe ff ff       	call   4a0 <printint>
 5f4:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 5f7:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 5fb:	e9 50 ff ff ff       	jmp    550 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 600:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 603:	8b 01                	mov    (%ecx),%eax
        ap++;
 605:	83 c1 04             	add    $0x4,%ecx
 608:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 60b:	b9 2d 08 00 00       	mov    $0x82d,%ecx
 610:	85 c0                	test   %eax,%eax
 612:	75 2c                	jne    640 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 614:	0f b6 01             	movzbl (%ecx),%eax
 617:	84 c0                	test   %al,%al
 619:	74 1e                	je     639 <printf+0x119>
 61b:	89 cb                	mov    %ecx,%ebx
 61d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 620:	0f be d0             	movsbl %al,%edx
 623:	8b 45 08             	mov    0x8(%ebp),%eax
 626:	e8 45 fe ff ff       	call   470 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 62b:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 62f:	83 c3 01             	add    $0x1,%ebx
 632:	84 c0                	test   %al,%al
 634:	75 ea                	jne    620 <printf+0x100>
 636:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 639:	31 f6                	xor    %esi,%esi
 63b:	e9 10 ff ff ff       	jmp    550 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 640:	89 c1                	mov    %eax,%ecx
 642:	eb d0                	jmp    614 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 644:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 647:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 649:	0f be 10             	movsbl (%eax),%edx
 64c:	8b 45 08             	mov    0x8(%ebp),%eax
 64f:	e8 1c fe ff ff       	call   470 <putc>
 654:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 657:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 65b:	e9 f0 fe ff ff       	jmp    550 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 660:	8b 45 f0             	mov    -0x10(%ebp),%eax
 663:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 668:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 66b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 672:	8b 10                	mov    (%eax),%edx
 674:	8b 45 08             	mov    0x8(%ebp),%eax
 677:	e8 24 fe ff ff       	call   4a0 <printint>
 67c:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 67f:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 683:	e9 c8 fe ff ff       	jmp    550 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 688:	8b 45 08             	mov    0x8(%ebp),%eax
 68b:	ba 25 00 00 00       	mov    $0x25,%edx
 690:	31 f6                	xor    %esi,%esi
 692:	e8 d9 fd ff ff       	call   470 <putc>
 697:	8b 55 0c             	mov    0xc(%ebp),%edx
 69a:	e9 b1 fe ff ff       	jmp    550 <printf+0x30>
 69f:	90                   	nop    

000006a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a1:	8b 0d 68 08 00 00    	mov    0x868,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 6a7:	89 e5                	mov    %esp,%ebp
 6a9:	56                   	push   %esi
 6aa:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 6ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6ae:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b1:	39 d9                	cmp    %ebx,%ecx
 6b3:	73 18                	jae    6cd <free+0x2d>
 6b5:	8b 11                	mov    (%ecx),%edx
 6b7:	39 d3                	cmp    %edx,%ebx
 6b9:	72 17                	jb     6d2 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6bb:	39 d1                	cmp    %edx,%ecx
 6bd:	72 08                	jb     6c7 <free+0x27>
 6bf:	39 d9                	cmp    %ebx,%ecx
 6c1:	72 0f                	jb     6d2 <free+0x32>
 6c3:	39 d3                	cmp    %edx,%ebx
 6c5:	72 0b                	jb     6d2 <free+0x32>
 6c7:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c9:	39 d9                	cmp    %ebx,%ecx
 6cb:	72 e8                	jb     6b5 <free+0x15>
 6cd:	8b 11                	mov    (%ecx),%edx
 6cf:	90                   	nop    
 6d0:	eb e9                	jmp    6bb <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6d2:	8b 73 04             	mov    0x4(%ebx),%esi
 6d5:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 6d8:	39 d0                	cmp    %edx,%eax
 6da:	74 18                	je     6f4 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6dc:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 6de:	8b 51 04             	mov    0x4(%ecx),%edx
 6e1:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 6e4:	39 d8                	cmp    %ebx,%eax
 6e6:	74 20                	je     708 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6e8:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 6ea:	5b                   	pop    %ebx
 6eb:	5e                   	pop    %esi
 6ec:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 6ed:	89 0d 68 08 00 00    	mov    %ecx,0x868
}
 6f3:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6f4:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 6f7:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6f9:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6fc:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 6ff:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 701:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 704:	39 d8                	cmp    %ebx,%eax
 706:	75 e0                	jne    6e8 <free+0x48>
    p->s.size += bp->s.size;
 708:	03 53 04             	add    0x4(%ebx),%edx
 70b:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 70e:	8b 13                	mov    (%ebx),%edx
 710:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 712:	5b                   	pop    %ebx
 713:	5e                   	pop    %esi
 714:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 715:	89 0d 68 08 00 00    	mov    %ecx,0x868
}
 71b:	c3                   	ret    
 71c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000720 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	57                   	push   %edi
 724:	56                   	push   %esi
 725:	53                   	push   %ebx
 726:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 729:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 72c:	8b 15 68 08 00 00    	mov    0x868,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 732:	83 c0 07             	add    $0x7,%eax
 735:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 738:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 73a:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 73d:	0f 84 8a 00 00 00    	je     7cd <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 743:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 745:	8b 41 04             	mov    0x4(%ecx),%eax
 748:	39 c3                	cmp    %eax,%ebx
 74a:	76 1a                	jbe    766 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 74c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 753:	3b 0d 68 08 00 00    	cmp    0x868,%ecx
 759:	89 ca                	mov    %ecx,%edx
 75b:	74 29                	je     786 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 75d:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 75f:	8b 41 04             	mov    0x4(%ecx),%eax
 762:	39 c3                	cmp    %eax,%ebx
 764:	77 ed                	ja     753 <malloc+0x33>
      if(p->s.size == nunits)
 766:	39 c3                	cmp    %eax,%ebx
 768:	74 5d                	je     7c7 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 76a:	29 d8                	sub    %ebx,%eax
 76c:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 76f:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 772:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 775:	89 15 68 08 00 00    	mov    %edx,0x868
      return (void*) (p + 1);
 77b:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 77e:	83 c4 0c             	add    $0xc,%esp
 781:	5b                   	pop    %ebx
 782:	5e                   	pop    %esi
 783:	5f                   	pop    %edi
 784:	5d                   	pop    %ebp
 785:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 786:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 78c:	89 de                	mov    %ebx,%esi
 78e:	89 f8                	mov    %edi,%eax
 790:	76 29                	jbe    7bb <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 792:	89 04 24             	mov    %eax,(%esp)
 795:	e8 96 fc ff ff       	call   430 <sbrk>
  if(p == (char*) -1)
 79a:	83 f8 ff             	cmp    $0xffffffff,%eax
 79d:	74 18                	je     7b7 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 79f:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 7a2:	83 c0 08             	add    $0x8,%eax
 7a5:	89 04 24             	mov    %eax,(%esp)
 7a8:	e8 f3 fe ff ff       	call   6a0 <free>
  return freep;
 7ad:	8b 15 68 08 00 00    	mov    0x868,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 7b3:	85 d2                	test   %edx,%edx
 7b5:	75 a6                	jne    75d <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7b7:	31 c0                	xor    %eax,%eax
 7b9:	eb c3                	jmp    77e <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 7bb:	be 00 10 00 00       	mov    $0x1000,%esi
 7c0:	b8 00 80 00 00       	mov    $0x8000,%eax
 7c5:	eb cb                	jmp    792 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 7c7:	8b 01                	mov    (%ecx),%eax
 7c9:	89 02                	mov    %eax,(%edx)
 7cb:	eb a8                	jmp    775 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 7cd:	ba 60 08 00 00       	mov    $0x860,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 7d2:	c7 05 68 08 00 00 60 	movl   $0x860,0x868
 7d9:	08 00 00 
 7dc:	c7 05 60 08 00 00 60 	movl   $0x860,0x860
 7e3:	08 00 00 
    base.s.size = 0;
 7e6:	c7 05 64 08 00 00 00 	movl   $0x0,0x864
 7ed:	00 00 00 
 7f0:	e9 4e ff ff ff       	jmp    743 <malloc+0x23>
