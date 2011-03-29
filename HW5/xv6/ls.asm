
_ls:     file format elf32-i386

Disassembly of section .text:

00000000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	56                   	push   %esi
   4:	53                   	push   %ebx
   5:	83 ec 10             	sub    $0x10,%esp
   8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;
  
  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   b:	89 1c 24             	mov    %ebx,(%esp)
   e:	e8 bd 03 00 00       	call   3d0 <strlen>
  13:	01 d8                	add    %ebx,%eax
  15:	39 c3                	cmp    %eax,%ebx
  17:	76 0e                	jbe    27 <fmtname+0x27>
  19:	eb 11                	jmp    2c <fmtname+0x2c>
  1b:	90                   	nop    
  1c:	8d 74 26 00          	lea    0x0(%esi),%esi
  20:	83 e8 01             	sub    $0x1,%eax
  23:	39 c3                	cmp    %eax,%ebx
  25:	77 05                	ja     2c <fmtname+0x2c>
  27:	80 38 2f             	cmpb   $0x2f,(%eax)
  2a:	75 f4                	jne    20 <fmtname+0x20>
    ;
  p++;
  2c:	8d 70 01             	lea    0x1(%eax),%esi
  
  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  2f:	89 34 24             	mov    %esi,(%esp)
  32:	e8 99 03 00 00       	call   3d0 <strlen>
  37:	83 f8 0d             	cmp    $0xd,%eax
  3a:	77 53                	ja     8f <fmtname+0x8f>
    return p;
  memmove(buf, p, strlen(p));
  3c:	89 34 24             	mov    %esi,(%esp)
  3f:	e8 8c 03 00 00       	call   3d0 <strlen>
  44:	89 74 24 04          	mov    %esi,0x4(%esp)
  48:	c7 04 24 e8 09 00 00 	movl   $0x9e8,(%esp)
  4f:	89 44 24 08          	mov    %eax,0x8(%esp)
  53:	e8 18 04 00 00       	call   470 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  58:	89 34 24             	mov    %esi,(%esp)
  5b:	e8 70 03 00 00       	call   3d0 <strlen>
  60:	89 34 24             	mov    %esi,(%esp)
  63:	be e8 09 00 00       	mov    $0x9e8,%esi
  68:	89 c3                	mov    %eax,%ebx
  6a:	e8 61 03 00 00       	call   3d0 <strlen>
  6f:	ba 0e 00 00 00       	mov    $0xe,%edx
  74:	29 da                	sub    %ebx,%edx
  76:	89 54 24 08          	mov    %edx,0x8(%esp)
  7a:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  81:	00 
  82:	05 e8 09 00 00       	add    $0x9e8,%eax
  87:	89 04 24             	mov    %eax,(%esp)
  8a:	e8 61 03 00 00       	call   3f0 <memset>
  return buf;
}
  8f:	83 c4 10             	add    $0x10,%esp
  92:	89 f0                	mov    %esi,%eax
  94:	5b                   	pop    %ebx
  95:	5e                   	pop    %esi
  96:	5d                   	pop    %ebp
  97:	c3                   	ret    
  98:	90                   	nop    
  99:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000000a0 <ls>:

void
ls(char *path)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	57                   	push   %edi
  a4:	56                   	push   %esi
  a5:	53                   	push   %ebx
  a6:	81 ec 5c 02 00 00    	sub    $0x25c,%esp
  ac:	8b 75 08             	mov    0x8(%ebp),%esi
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  
  if((fd = open(path, 0)) < 0){
  af:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  b6:	00 
  b7:	89 34 24             	mov    %esi,(%esp)
  ba:	e8 d9 04 00 00       	call   598 <open>
  bf:	85 c0                	test   %eax,%eax
  c1:	89 c7                	mov    %eax,%edi
  c3:	0f 88 9b 01 00 00    	js     264 <ls+0x1c4>
    printf(2, "ls: cannot open %s\n", path);
    return;
  }
  
  if(fstat(fd, &st) < 0){
  c9:	8d 45 d0             	lea    -0x30(%ebp),%eax
  cc:	89 44 24 04          	mov    %eax,0x4(%esp)
  d0:	89 3c 24             	mov    %edi,(%esp)
  d3:	e8 d8 04 00 00       	call   5b0 <fstat>
  d8:	85 c0                	test   %eax,%eax
  da:	0f 88 c0 01 00 00    	js     2a0 <ls+0x200>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }
  
  switch(st.type){
  e0:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
  e4:	66 83 f8 01          	cmp    $0x1,%ax
  e8:	74 66                	je     150 <ls+0xb0>
  ea:	66 83 f8 02          	cmp    $0x2,%ax
  ee:	66 90                	xchg   %ax,%ax
  f0:	74 13                	je     105 <ls+0x65>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
  f2:	89 3c 24             	mov    %edi,(%esp)
  f5:	e8 86 04 00 00       	call   580 <close>
}
  fa:	81 c4 5c 02 00 00    	add    $0x25c,%esp
 100:	5b                   	pop    %ebx
 101:	5e                   	pop    %esi
 102:	5f                   	pop    %edi
 103:	5d                   	pop    %ebp
 104:	c3                   	ret    
    return;
  }
  
  switch(st.type){
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 105:	8b 55 d8             	mov    -0x28(%ebp),%edx
 108:	8b 5d e0             	mov    -0x20(%ebp),%ebx
 10b:	89 95 b8 fd ff ff    	mov    %edx,-0x248(%ebp)
 111:	89 34 24             	mov    %esi,(%esp)
 114:	e8 e7 fe ff ff       	call   0 <fmtname>
 119:	89 5c 24 14          	mov    %ebx,0x14(%esp)
 11d:	8b 95 b8 fd ff ff    	mov    -0x248(%ebp),%edx
 123:	c7 44 24 0c 02 00 00 	movl   $0x2,0xc(%esp)
 12a:	00 
 12b:	c7 44 24 04 ad 09 00 	movl   $0x9ad,0x4(%esp)
 132:	00 
 133:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 13a:	89 54 24 10          	mov    %edx,0x10(%esp)
 13e:	89 44 24 08          	mov    %eax,0x8(%esp)
 142:	e8 69 05 00 00       	call   6b0 <printf>
 147:	eb a9                	jmp    f2 <ls+0x52>
 149:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
    break;
  
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 150:	89 34 24             	mov    %esi,(%esp)
 153:	e8 78 02 00 00       	call   3d0 <strlen>
 158:	83 c0 10             	add    $0x10,%eax
 15b:	3d 00 02 00 00       	cmp    $0x200,%eax
 160:	0f 87 21 01 00 00    	ja     287 <ls+0x1e7>
      printf(1, "ls: path too long\n");
      break;
    }
    strcpy(buf, path);
 166:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
 16c:	89 74 24 04          	mov    %esi,0x4(%esp)
 170:	89 04 24             	mov    %eax,(%esp)
 173:	e8 d8 01 00 00       	call   350 <strcpy>
    p = buf+strlen(buf);
 178:	8d 95 d0 fd ff ff    	lea    -0x230(%ebp),%edx
 17e:	89 14 24             	mov    %edx,(%esp)
 181:	e8 4a 02 00 00       	call   3d0 <strlen>
 186:	8d 95 d0 fd ff ff    	lea    -0x230(%ebp),%edx
 18c:	8d 04 02             	lea    (%edx,%eax,1),%eax
    *p++ = '/';
 18f:	c6 00 2f             	movb   $0x2f,(%eax)
 192:	83 c0 01             	add    $0x1,%eax
 195:	89 85 c0 fd ff ff    	mov    %eax,-0x240(%ebp)
 19b:	90                   	nop    
 19c:	8d 74 26 00          	lea    0x0(%esi),%esi
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1a0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 1a3:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 1aa:	00 
 1ab:	89 44 24 04          	mov    %eax,0x4(%esp)
 1af:	89 3c 24             	mov    %edi,(%esp)
 1b2:	e8 b9 03 00 00       	call   570 <read>
 1b7:	83 f8 10             	cmp    $0x10,%eax
 1ba:	0f 85 32 ff ff ff    	jne    f2 <ls+0x52>
      if(de.inum == 0)
 1c0:	66 83 7d e4 00       	cmpw   $0x0,-0x1c(%ebp)
 1c5:	74 d9                	je     1a0 <ls+0x100>
        continue;
      memmove(p, de.name, DIRSIZ);
 1c7:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 1ca:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
 1d1:	00 
 1d2:	89 44 24 04          	mov    %eax,0x4(%esp)
 1d6:	8b 95 c0 fd ff ff    	mov    -0x240(%ebp),%edx
 1dc:	89 14 24             	mov    %edx,(%esp)
 1df:	e8 8c 02 00 00       	call   470 <memmove>
      p[DIRSIZ] = 0;
 1e4:	8b 85 c0 fd ff ff    	mov    -0x240(%ebp),%eax
      if(stat(buf, &st) < 0){
 1ea:	8d 55 d0             	lea    -0x30(%ebp),%edx
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
      if(de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
 1ed:	c6 40 0e 00          	movb   $0x0,0xe(%eax)
      if(stat(buf, &st) < 0){
 1f1:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
 1f7:	89 54 24 04          	mov    %edx,0x4(%esp)
 1fb:	89 04 24             	mov    %eax,(%esp)
 1fe:	e8 9d 02 00 00       	call   4a0 <stat>
 203:	85 c0                	test   %eax,%eax
 205:	0f 88 ba 00 00 00    	js     2c5 <ls+0x225>
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 20b:	8b 45 d8             	mov    -0x28(%ebp),%eax
 20e:	0f bf 55 d0          	movswl -0x30(%ebp),%edx
 212:	8b 5d e0             	mov    -0x20(%ebp),%ebx
 215:	89 85 bc fd ff ff    	mov    %eax,-0x244(%ebp)
 21b:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
 221:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 227:	89 04 24             	mov    %eax,(%esp)
 22a:	e8 d1 fd ff ff       	call   0 <fmtname>
 22f:	89 5c 24 14          	mov    %ebx,0x14(%esp)
 233:	8b 95 bc fd ff ff    	mov    -0x244(%ebp),%edx
 239:	89 54 24 10          	mov    %edx,0x10(%esp)
 23d:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 243:	89 44 24 08          	mov    %eax,0x8(%esp)
 247:	c7 44 24 04 ad 09 00 	movl   $0x9ad,0x4(%esp)
 24e:	00 
 24f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 256:	89 54 24 0c          	mov    %edx,0xc(%esp)
 25a:	e8 51 04 00 00       	call   6b0 <printf>
 25f:	e9 3c ff ff ff       	jmp    1a0 <ls+0x100>
  int fd;
  struct dirent de;
  struct stat st;
  
  if((fd = open(path, 0)) < 0){
    printf(2, "ls: cannot open %s\n", path);
 264:	89 74 24 08          	mov    %esi,0x8(%esp)
 268:	c7 44 24 04 85 09 00 	movl   $0x985,0x4(%esp)
 26f:	00 
 270:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 277:	e8 34 04 00 00       	call   6b0 <printf>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
}
 27c:	81 c4 5c 02 00 00    	add    $0x25c,%esp
 282:	5b                   	pop    %ebx
 283:	5e                   	pop    %esi
 284:	5f                   	pop    %edi
 285:	5d                   	pop    %ebp
 286:	c3                   	ret    
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    break;
  
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
      printf(1, "ls: path too long\n");
 287:	c7 44 24 04 ba 09 00 	movl   $0x9ba,0x4(%esp)
 28e:	00 
 28f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 296:	e8 15 04 00 00       	call   6b0 <printf>
 29b:	e9 52 fe ff ff       	jmp    f2 <ls+0x52>
    printf(2, "ls: cannot open %s\n", path);
    return;
  }
  
  if(fstat(fd, &st) < 0){
    printf(2, "ls: cannot stat %s\n", path);
 2a0:	89 74 24 08          	mov    %esi,0x8(%esp)
 2a4:	c7 44 24 04 99 09 00 	movl   $0x999,0x4(%esp)
 2ab:	00 
 2ac:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 2b3:	e8 f8 03 00 00       	call   6b0 <printf>
    close(fd);
 2b8:	89 3c 24             	mov    %edi,(%esp)
 2bb:	e8 c0 02 00 00       	call   580 <close>
 2c0:	e9 35 fe ff ff       	jmp    fa <ls+0x5a>
      if(de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
      if(stat(buf, &st) < 0){
        printf(1, "ls: cannot stat %s\n", buf);
 2c5:	8d 95 d0 fd ff ff    	lea    -0x230(%ebp),%edx
 2cb:	89 54 24 08          	mov    %edx,0x8(%esp)
 2cf:	c7 44 24 04 99 09 00 	movl   $0x999,0x4(%esp)
 2d6:	00 
 2d7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2de:	e8 cd 03 00 00       	call   6b0 <printf>
 2e3:	e9 b8 fe ff ff       	jmp    1a0 <ls+0x100>
 2e8:	90                   	nop    
 2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000002f0 <main>:
  close(fd);
}

int
main(int argc, char *argv[])
{
 2f0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 2f4:	83 e4 f0             	and    $0xfffffff0,%esp
 2f7:	ff 71 fc             	pushl  -0x4(%ecx)
 2fa:	55                   	push   %ebp
 2fb:	89 e5                	mov    %esp,%ebp
 2fd:	83 ec 18             	sub    $0x18,%esp
 300:	89 5d f4             	mov    %ebx,-0xc(%ebp)
 303:	8b 19                	mov    (%ecx),%ebx
 305:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 308:	89 75 f8             	mov    %esi,-0x8(%ebp)
 30b:	89 7d fc             	mov    %edi,-0x4(%ebp)
 30e:	8b 71 04             	mov    0x4(%ecx),%esi
  int i;

  if(argc < 2){
 311:	83 fb 01             	cmp    $0x1,%ebx
 314:	7f 11                	jg     327 <main+0x37>
    ls(".");
 316:	c7 04 24 cd 09 00 00 	movl   $0x9cd,(%esp)
 31d:	e8 7e fd ff ff       	call   a0 <ls>
    exit();
 322:	e8 31 02 00 00       	call   558 <exit>
 327:	bf 01 00 00 00       	mov    $0x1,%edi
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 32c:	8b 04 be             	mov    (%esi,%edi,4),%eax

  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
 32f:	83 c7 01             	add    $0x1,%edi
    ls(argv[i]);
 332:	89 04 24             	mov    %eax,(%esp)
 335:	e8 66 fd ff ff       	call   a0 <ls>

  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
 33a:	39 df                	cmp    %ebx,%edi
 33c:	75 ee                	jne    32c <main+0x3c>
    ls(argv[i]);
  exit();
 33e:	e8 15 02 00 00       	call   558 <exit>
 343:	90                   	nop    
 344:	90                   	nop    
 345:	90                   	nop    
 346:	90                   	nop    
 347:	90                   	nop    
 348:	90                   	nop    
 349:	90                   	nop    
 34a:	90                   	nop    
 34b:	90                   	nop    
 34c:	90                   	nop    
 34d:	90                   	nop    
 34e:	90                   	nop    
 34f:	90                   	nop    

00000350 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	53                   	push   %ebx
 354:	8b 5d 08             	mov    0x8(%ebp),%ebx
 357:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 35a:	89 da                	mov    %ebx,%edx
 35c:	8d 74 26 00          	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 360:	0f b6 01             	movzbl (%ecx),%eax
 363:	83 c1 01             	add    $0x1,%ecx
 366:	88 02                	mov    %al,(%edx)
 368:	83 c2 01             	add    $0x1,%edx
 36b:	84 c0                	test   %al,%al
 36d:	75 f1                	jne    360 <strcpy+0x10>
    ;
  return os;
}
 36f:	89 d8                	mov    %ebx,%eax
 371:	5b                   	pop    %ebx
 372:	5d                   	pop    %ebp
 373:	c3                   	ret    
 374:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 37a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000380 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	8b 4d 08             	mov    0x8(%ebp),%ecx
 386:	53                   	push   %ebx
 387:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 38a:	0f b6 01             	movzbl (%ecx),%eax
 38d:	84 c0                	test   %al,%al
 38f:	74 24                	je     3b5 <strcmp+0x35>
 391:	0f b6 13             	movzbl (%ebx),%edx
 394:	38 d0                	cmp    %dl,%al
 396:	74 12                	je     3aa <strcmp+0x2a>
 398:	eb 1e                	jmp    3b8 <strcmp+0x38>
 39a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3a0:	0f b6 13             	movzbl (%ebx),%edx
 3a3:	83 c1 01             	add    $0x1,%ecx
 3a6:	38 d0                	cmp    %dl,%al
 3a8:	75 0e                	jne    3b8 <strcmp+0x38>
 3aa:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 3ae:	83 c3 01             	add    $0x1,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3b1:	84 c0                	test   %al,%al
 3b3:	75 eb                	jne    3a0 <strcmp+0x20>
 3b5:	0f b6 13             	movzbl (%ebx),%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 3b8:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3b9:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 3bc:	5d                   	pop    %ebp
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3bd:	0f b6 d2             	movzbl %dl,%edx
 3c0:	29 d0                	sub    %edx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 3c2:	c3                   	ret    
 3c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000003d0 <strlen>:

uint
strlen(char *s)
{
 3d0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 3d1:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 3d3:	89 e5                	mov    %esp,%ebp
 3d5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 3d8:	80 39 00             	cmpb   $0x0,(%ecx)
 3db:	74 0e                	je     3eb <strlen+0x1b>
 3dd:	31 d2                	xor    %edx,%edx
 3df:	90                   	nop    
 3e0:	83 c2 01             	add    $0x1,%edx
 3e3:	80 3c 0a 00          	cmpb   $0x0,(%edx,%ecx,1)
 3e7:	89 d0                	mov    %edx,%eax
 3e9:	75 f5                	jne    3e0 <strlen+0x10>
    ;
  return n;
}
 3eb:	5d                   	pop    %ebp
 3ec:	c3                   	ret    
 3ed:	8d 76 00             	lea    0x0(%esi),%esi

000003f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	8b 55 08             	mov    0x8(%ebp),%edx
 3f6:	57                   	push   %edi
 3f7:	8b 45 0c             	mov    0xc(%ebp),%eax
 3fa:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3fd:	89 d7                	mov    %edx,%edi
 3ff:	fc                   	cld    
 400:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 402:	5f                   	pop    %edi
 403:	89 d0                	mov    %edx,%eax
 405:	5d                   	pop    %ebp
 406:	c3                   	ret    
 407:	89 f6                	mov    %esi,%esi
 409:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000410 <strchr>:

char*
strchr(const char *s, char c)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	8b 45 08             	mov    0x8(%ebp),%eax
 416:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 41a:	0f b6 10             	movzbl (%eax),%edx
 41d:	84 d2                	test   %dl,%dl
 41f:	75 0c                	jne    42d <strchr+0x1d>
 421:	eb 11                	jmp    434 <strchr+0x24>
 423:	83 c0 01             	add    $0x1,%eax
 426:	0f b6 10             	movzbl (%eax),%edx
 429:	84 d2                	test   %dl,%dl
 42b:	74 07                	je     434 <strchr+0x24>
    if(*s == c)
 42d:	38 ca                	cmp    %cl,%dl
 42f:	90                   	nop    
 430:	75 f1                	jne    423 <strchr+0x13>
      return (char*) s;
  return 0;
}
 432:	5d                   	pop    %ebp
 433:	c3                   	ret    
 434:	5d                   	pop    %ebp
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 435:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 437:	c3                   	ret    
 438:	90                   	nop    
 439:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000440 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	8b 4d 08             	mov    0x8(%ebp),%ecx
 446:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 447:	31 db                	xor    %ebx,%ebx
 449:	0f b6 11             	movzbl (%ecx),%edx
 44c:	8d 42 d0             	lea    -0x30(%edx),%eax
 44f:	3c 09                	cmp    $0x9,%al
 451:	77 18                	ja     46b <atoi+0x2b>
    n = n*10 + *s++ - '0';
 453:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 456:	0f be d2             	movsbl %dl,%edx
 459:	8d 5c 42 d0          	lea    -0x30(%edx,%eax,2),%ebx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 45d:	0f b6 51 01          	movzbl 0x1(%ecx),%edx
 461:	83 c1 01             	add    $0x1,%ecx
 464:	8d 42 d0             	lea    -0x30(%edx),%eax
 467:	3c 09                	cmp    $0x9,%al
 469:	76 e8                	jbe    453 <atoi+0x13>
    n = n*10 + *s++ - '0';
  return n;
}
 46b:	89 d8                	mov    %ebx,%eax
 46d:	5b                   	pop    %ebx
 46e:	5d                   	pop    %ebp
 46f:	c3                   	ret    

00000470 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	8b 4d 10             	mov    0x10(%ebp),%ecx
 476:	56                   	push   %esi
 477:	8b 75 08             	mov    0x8(%ebp),%esi
 47a:	53                   	push   %ebx
 47b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 47e:	85 c9                	test   %ecx,%ecx
 480:	7e 10                	jle    492 <memmove+0x22>
 482:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 484:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
 488:	88 04 32             	mov    %al,(%edx,%esi,1)
 48b:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 48e:	39 ca                	cmp    %ecx,%edx
 490:	75 f2                	jne    484 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 492:	89 f0                	mov    %esi,%eax
 494:	5b                   	pop    %ebx
 495:	5e                   	pop    %esi
 496:	5d                   	pop    %ebp
 497:	c3                   	ret    
 498:	90                   	nop    
 499:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000004a0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4a6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 4a9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 4ac:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 4af:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4b4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 4bb:	00 
 4bc:	89 04 24             	mov    %eax,(%esp)
 4bf:	e8 d4 00 00 00       	call   598 <open>
  if(fd < 0)
 4c4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4c6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 4c8:	78 19                	js     4e3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 4ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 4cd:	89 1c 24             	mov    %ebx,(%esp)
 4d0:	89 44 24 04          	mov    %eax,0x4(%esp)
 4d4:	e8 d7 00 00 00       	call   5b0 <fstat>
  close(fd);
 4d9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 4dc:	89 c6                	mov    %eax,%esi
  close(fd);
 4de:	e8 9d 00 00 00       	call   580 <close>
  return r;
}
 4e3:	89 f0                	mov    %esi,%eax
 4e5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 4e8:	8b 75 fc             	mov    -0x4(%ebp),%esi
 4eb:	89 ec                	mov    %ebp,%esp
 4ed:	5d                   	pop    %ebp
 4ee:	c3                   	ret    
 4ef:	90                   	nop    

000004f0 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	57                   	push   %edi
 4f4:	56                   	push   %esi
 4f5:	31 f6                	xor    %esi,%esi
 4f7:	53                   	push   %ebx
 4f8:	83 ec 1c             	sub    $0x1c,%esp
 4fb:	8b 7d 08             	mov    0x8(%ebp),%edi
 4fe:	eb 06                	jmp    506 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 500:	3c 0d                	cmp    $0xd,%al
 502:	74 39                	je     53d <gets+0x4d>
 504:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 506:	8d 5e 01             	lea    0x1(%esi),%ebx
 509:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 50c:	7d 31                	jge    53f <gets+0x4f>
    cc = read(0, &c, 1);
 50e:	8d 45 f3             	lea    -0xd(%ebp),%eax
 511:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 518:	00 
 519:	89 44 24 04          	mov    %eax,0x4(%esp)
 51d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 524:	e8 47 00 00 00       	call   570 <read>
    if(cc < 1)
 529:	85 c0                	test   %eax,%eax
 52b:	7e 12                	jle    53f <gets+0x4f>
      break;
    buf[i++] = c;
 52d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 531:	88 44 3b ff          	mov    %al,-0x1(%ebx,%edi,1)
    if(c == '\n' || c == '\r')
 535:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 539:	3c 0a                	cmp    $0xa,%al
 53b:	75 c3                	jne    500 <gets+0x10>
 53d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 53f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 543:	89 f8                	mov    %edi,%eax
 545:	83 c4 1c             	add    $0x1c,%esp
 548:	5b                   	pop    %ebx
 549:	5e                   	pop    %esi
 54a:	5f                   	pop    %edi
 54b:	5d                   	pop    %ebp
 54c:	c3                   	ret    
 54d:	90                   	nop    
 54e:	90                   	nop    
 54f:	90                   	nop    

00000550 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 550:	b8 01 00 00 00       	mov    $0x1,%eax
 555:	cd 40                	int    $0x40
 557:	c3                   	ret    

00000558 <exit>:
SYSCALL(exit)
 558:	b8 02 00 00 00       	mov    $0x2,%eax
 55d:	cd 40                	int    $0x40
 55f:	c3                   	ret    

00000560 <wait>:
SYSCALL(wait)
 560:	b8 03 00 00 00       	mov    $0x3,%eax
 565:	cd 40                	int    $0x40
 567:	c3                   	ret    

00000568 <pipe>:
SYSCALL(pipe)
 568:	b8 04 00 00 00       	mov    $0x4,%eax
 56d:	cd 40                	int    $0x40
 56f:	c3                   	ret    

00000570 <read>:
SYSCALL(read)
 570:	b8 06 00 00 00       	mov    $0x6,%eax
 575:	cd 40                	int    $0x40
 577:	c3                   	ret    

00000578 <write>:
SYSCALL(write)
 578:	b8 05 00 00 00       	mov    $0x5,%eax
 57d:	cd 40                	int    $0x40
 57f:	c3                   	ret    

00000580 <close>:
SYSCALL(close)
 580:	b8 07 00 00 00       	mov    $0x7,%eax
 585:	cd 40                	int    $0x40
 587:	c3                   	ret    

00000588 <kill>:
SYSCALL(kill)
 588:	b8 08 00 00 00       	mov    $0x8,%eax
 58d:	cd 40                	int    $0x40
 58f:	c3                   	ret    

00000590 <exec>:
SYSCALL(exec)
 590:	b8 09 00 00 00       	mov    $0x9,%eax
 595:	cd 40                	int    $0x40
 597:	c3                   	ret    

00000598 <open>:
SYSCALL(open)
 598:	b8 0a 00 00 00       	mov    $0xa,%eax
 59d:	cd 40                	int    $0x40
 59f:	c3                   	ret    

000005a0 <mknod>:
SYSCALL(mknod)
 5a0:	b8 0b 00 00 00       	mov    $0xb,%eax
 5a5:	cd 40                	int    $0x40
 5a7:	c3                   	ret    

000005a8 <unlink>:
SYSCALL(unlink)
 5a8:	b8 0c 00 00 00       	mov    $0xc,%eax
 5ad:	cd 40                	int    $0x40
 5af:	c3                   	ret    

000005b0 <fstat>:
SYSCALL(fstat)
 5b0:	b8 0d 00 00 00       	mov    $0xd,%eax
 5b5:	cd 40                	int    $0x40
 5b7:	c3                   	ret    

000005b8 <link>:
SYSCALL(link)
 5b8:	b8 0e 00 00 00       	mov    $0xe,%eax
 5bd:	cd 40                	int    $0x40
 5bf:	c3                   	ret    

000005c0 <mkdir>:
SYSCALL(mkdir)
 5c0:	b8 0f 00 00 00       	mov    $0xf,%eax
 5c5:	cd 40                	int    $0x40
 5c7:	c3                   	ret    

000005c8 <chdir>:
SYSCALL(chdir)
 5c8:	b8 10 00 00 00       	mov    $0x10,%eax
 5cd:	cd 40                	int    $0x40
 5cf:	c3                   	ret    

000005d0 <dup>:
SYSCALL(dup)
 5d0:	b8 11 00 00 00       	mov    $0x11,%eax
 5d5:	cd 40                	int    $0x40
 5d7:	c3                   	ret    

000005d8 <getpid>:
SYSCALL(getpid)
 5d8:	b8 12 00 00 00       	mov    $0x12,%eax
 5dd:	cd 40                	int    $0x40
 5df:	c3                   	ret    

000005e0 <sbrk>:
SYSCALL(sbrk)
 5e0:	b8 13 00 00 00       	mov    $0x13,%eax
 5e5:	cd 40                	int    $0x40
 5e7:	c3                   	ret    

000005e8 <sleep>:
SYSCALL(sleep)
 5e8:	b8 14 00 00 00       	mov    $0x14,%eax
 5ed:	cd 40                	int    $0x40
 5ef:	c3                   	ret    

000005f0 <uptime>:
SYSCALL(uptime)
 5f0:	b8 15 00 00 00       	mov    $0x15,%eax
 5f5:	cd 40                	int    $0x40
 5f7:	c3                   	ret    

000005f8 <freepages>:
// Added by Jingyue
SYSCALL(freepages)
 5f8:	b8 16 00 00 00       	mov    $0x16,%eax
 5fd:	cd 40                	int    $0x40
 5ff:	c3                   	ret    

00000600 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 600:	55                   	push   %ebp
 601:	89 e5                	mov    %esp,%ebp
 603:	83 ec 18             	sub    $0x18,%esp
 606:	88 55 fc             	mov    %dl,-0x4(%ebp)
  write(fd, &c, 1);
 609:	8d 55 fc             	lea    -0x4(%ebp),%edx
 60c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 613:	00 
 614:	89 54 24 04          	mov    %edx,0x4(%esp)
 618:	89 04 24             	mov    %eax,(%esp)
 61b:	e8 58 ff ff ff       	call   578 <write>
}
 620:	c9                   	leave  
 621:	c3                   	ret    
 622:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
 629:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000630 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	57                   	push   %edi
 634:	56                   	push   %esi
 635:	89 ce                	mov    %ecx,%esi
 637:	53                   	push   %ebx
 638:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 63b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 63e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 641:	85 c9                	test   %ecx,%ecx
 643:	74 04                	je     649 <printint+0x19>
 645:	85 d2                	test   %edx,%edx
 647:	78 54                	js     69d <printint+0x6d>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 649:	89 d0                	mov    %edx,%eax
 64b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 652:	31 db                	xor    %ebx,%ebx
 654:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 657:	31 d2                	xor    %edx,%edx
 659:	f7 f6                	div    %esi
 65b:	89 c1                	mov    %eax,%ecx
 65d:	0f b6 82 d6 09 00 00 	movzbl 0x9d6(%edx),%eax
 664:	88 04 3b             	mov    %al,(%ebx,%edi,1)
 667:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 66a:	85 c9                	test   %ecx,%ecx
 66c:	89 c8                	mov    %ecx,%eax
 66e:	75 e7                	jne    657 <printint+0x27>
  if(neg)
 670:	8b 45 e0             	mov    -0x20(%ebp),%eax
 673:	85 c0                	test   %eax,%eax
 675:	74 08                	je     67f <printint+0x4f>
    buf[i++] = '-';
 677:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
 67c:	83 c3 01             	add    $0x1,%ebx
 67f:	8d 1c 1f             	lea    (%edi,%ebx,1),%ebx

  while(--i >= 0)
    putc(fd, buf[i]);
 682:	0f be 53 ff          	movsbl -0x1(%ebx),%edx
 686:	83 eb 01             	sub    $0x1,%ebx
 689:	8b 45 dc             	mov    -0x24(%ebp),%eax
 68c:	e8 6f ff ff ff       	call   600 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 691:	39 fb                	cmp    %edi,%ebx
 693:	75 ed                	jne    682 <printint+0x52>
    putc(fd, buf[i]);
}
 695:	83 c4 1c             	add    $0x1c,%esp
 698:	5b                   	pop    %ebx
 699:	5e                   	pop    %esi
 69a:	5f                   	pop    %edi
 69b:	5d                   	pop    %ebp
 69c:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 69d:	89 d0                	mov    %edx,%eax
 69f:	f7 d8                	neg    %eax
 6a1:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
 6a8:	eb a8                	jmp    652 <printint+0x22>
 6aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000006b0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6b0:	55                   	push   %ebp
 6b1:	89 e5                	mov    %esp,%ebp
 6b3:	57                   	push   %edi
 6b4:	56                   	push   %esi
 6b5:	53                   	push   %ebx
 6b6:	83 ec 0c             	sub    $0xc,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6b9:	8b 55 0c             	mov    0xc(%ebp),%edx
 6bc:	0f b6 02             	movzbl (%edx),%eax
 6bf:	84 c0                	test   %al,%al
 6c1:	0f 84 87 00 00 00    	je     74e <printf+0x9e>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 6c7:	8d 4d 10             	lea    0x10(%ebp),%ecx
 6ca:	31 ff                	xor    %edi,%edi
 6cc:	31 f6                	xor    %esi,%esi
 6ce:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 6d1:	eb 18                	jmp    6eb <printf+0x3b>
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 6d3:	83 fb 25             	cmp    $0x25,%ebx
 6d6:	0f 85 7a 00 00 00    	jne    756 <printf+0xa6>
 6dc:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6e0:	83 c7 01             	add    $0x1,%edi
 6e3:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 6e7:	84 c0                	test   %al,%al
 6e9:	74 63                	je     74e <printf+0x9e>
    c = fmt[i] & 0xff;
    if(state == 0){
 6eb:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 6ed:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 6f0:	74 e1                	je     6d3 <printf+0x23>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6f2:	83 fe 25             	cmp    $0x25,%esi
 6f5:	75 e9                	jne    6e0 <printf+0x30>
      if(c == 'd'){
 6f7:	83 fb 64             	cmp    $0x64,%ebx
 6fa:	0f 84 f0 00 00 00    	je     7f0 <printf+0x140>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 700:	83 fb 78             	cmp    $0x78,%ebx
 703:	74 64                	je     769 <printf+0xb9>
 705:	83 fb 70             	cmp    $0x70,%ebx
 708:	74 5f                	je     769 <printf+0xb9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 70a:	83 fb 73             	cmp    $0x73,%ebx
 70d:	8d 76 00             	lea    0x0(%esi),%esi
 710:	74 7e                	je     790 <printf+0xe0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 712:	83 fb 63             	cmp    $0x63,%ebx
 715:	0f 84 b9 00 00 00    	je     7d4 <printf+0x124>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 71b:	83 fb 25             	cmp    $0x25,%ebx
 71e:	66 90                	xchg   %ax,%ax
 720:	0f 84 f2 00 00 00    	je     818 <printf+0x168>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 726:	8b 45 08             	mov    0x8(%ebp),%eax
 729:	ba 25 00 00 00       	mov    $0x25,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 72e:	83 c7 01             	add    $0x1,%edi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 731:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 733:	e8 c8 fe ff ff       	call   600 <putc>
        putc(fd, c);
 738:	8b 45 08             	mov    0x8(%ebp),%eax
 73b:	0f be d3             	movsbl %bl,%edx
 73e:	e8 bd fe ff ff       	call   600 <putc>
 743:	8b 55 0c             	mov    0xc(%ebp),%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 746:	0f b6 04 3a          	movzbl (%edx,%edi,1),%eax
 74a:	84 c0                	test   %al,%al
 74c:	75 9d                	jne    6eb <printf+0x3b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 74e:	83 c4 0c             	add    $0xc,%esp
 751:	5b                   	pop    %ebx
 752:	5e                   	pop    %esi
 753:	5f                   	pop    %edi
 754:	5d                   	pop    %ebp
 755:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 756:	8b 45 08             	mov    0x8(%ebp),%eax
 759:	0f be d3             	movsbl %bl,%edx
 75c:	e8 9f fe ff ff       	call   600 <putc>
 761:	8b 55 0c             	mov    0xc(%ebp),%edx
 764:	e9 77 ff ff ff       	jmp    6e0 <printf+0x30>
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 769:	8b 45 f0             	mov    -0x10(%ebp),%eax
 76c:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 771:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 773:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 77a:	8b 10                	mov    (%eax),%edx
 77c:	8b 45 08             	mov    0x8(%ebp),%eax
 77f:	e8 ac fe ff ff       	call   630 <printint>
 784:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 787:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 78b:	e9 50 ff ff ff       	jmp    6e0 <printf+0x30>
      } else if(c == 's'){
        s = (char*)*ap;
 790:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 793:	8b 01                	mov    (%ecx),%eax
        ap++;
 795:	83 c1 04             	add    $0x4,%ecx
 798:	89 4d f0             	mov    %ecx,-0x10(%ebp)
        if(s == 0)
 79b:	b9 cf 09 00 00       	mov    $0x9cf,%ecx
 7a0:	85 c0                	test   %eax,%eax
 7a2:	75 2c                	jne    7d0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
 7a4:	0f b6 01             	movzbl (%ecx),%eax
 7a7:	84 c0                	test   %al,%al
 7a9:	74 1e                	je     7c9 <printf+0x119>
 7ab:	89 cb                	mov    %ecx,%ebx
 7ad:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 7b0:	0f be d0             	movsbl %al,%edx
 7b3:	8b 45 08             	mov    0x8(%ebp),%eax
 7b6:	e8 45 fe ff ff       	call   600 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7bb:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 7bf:	83 c3 01             	add    $0x1,%ebx
 7c2:	84 c0                	test   %al,%al
 7c4:	75 ea                	jne    7b0 <printf+0x100>
 7c6:	8b 55 0c             	mov    0xc(%ebp),%edx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 7c9:	31 f6                	xor    %esi,%esi
 7cb:	e9 10 ff ff ff       	jmp    6e0 <printf+0x30>
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 7d0:	89 c1                	mov    %eax,%ecx
 7d2:	eb d0                	jmp    7a4 <printf+0xf4>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 7d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
        ap++;
 7d7:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 7d9:	0f be 10             	movsbl (%eax),%edx
 7dc:	8b 45 08             	mov    0x8(%ebp),%eax
 7df:	e8 1c fe ff ff       	call   600 <putc>
 7e4:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 7e7:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 7eb:	e9 f0 fe ff ff       	jmp    6e0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 7f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f3:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 7f8:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 7fb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 802:	8b 10                	mov    (%eax),%edx
 804:	8b 45 08             	mov    0x8(%ebp),%eax
 807:	e8 24 fe ff ff       	call   630 <printint>
 80c:	8b 55 0c             	mov    0xc(%ebp),%edx
        ap++;
 80f:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 813:	e9 c8 fe ff ff       	jmp    6e0 <printf+0x30>
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 818:	8b 45 08             	mov    0x8(%ebp),%eax
 81b:	ba 25 00 00 00       	mov    $0x25,%edx
 820:	31 f6                	xor    %esi,%esi
 822:	e8 d9 fd ff ff       	call   600 <putc>
 827:	8b 55 0c             	mov    0xc(%ebp),%edx
 82a:	e9 b1 fe ff ff       	jmp    6e0 <printf+0x30>
 82f:	90                   	nop    

00000830 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 830:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 831:	8b 0d 00 0a 00 00    	mov    0xa00,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 837:	89 e5                	mov    %esp,%ebp
 839:	56                   	push   %esi
 83a:	53                   	push   %ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 83b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 83e:	83 eb 08             	sub    $0x8,%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 841:	39 d9                	cmp    %ebx,%ecx
 843:	73 18                	jae    85d <free+0x2d>
 845:	8b 11                	mov    (%ecx),%edx
 847:	39 d3                	cmp    %edx,%ebx
 849:	72 17                	jb     862 <free+0x32>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 84b:	39 d1                	cmp    %edx,%ecx
 84d:	72 08                	jb     857 <free+0x27>
 84f:	39 d9                	cmp    %ebx,%ecx
 851:	72 0f                	jb     862 <free+0x32>
 853:	39 d3                	cmp    %edx,%ebx
 855:	72 0b                	jb     862 <free+0x32>
 857:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 859:	39 d9                	cmp    %ebx,%ecx
 85b:	72 e8                	jb     845 <free+0x15>
 85d:	8b 11                	mov    (%ecx),%edx
 85f:	90                   	nop    
 860:	eb e9                	jmp    84b <free+0x1b>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 862:	8b 73 04             	mov    0x4(%ebx),%esi
 865:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 868:	39 d0                	cmp    %edx,%eax
 86a:	74 18                	je     884 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 86c:	89 13                	mov    %edx,(%ebx)
  if(p + p->s.size == bp){
 86e:	8b 51 04             	mov    0x4(%ecx),%edx
 871:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 874:	39 d8                	cmp    %ebx,%eax
 876:	74 20                	je     898 <free+0x68>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 878:	89 19                	mov    %ebx,(%ecx)
  freep = p;
}
 87a:	5b                   	pop    %ebx
 87b:	5e                   	pop    %esi
 87c:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 87d:	89 0d 00 0a 00 00    	mov    %ecx,0xa00
}
 883:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 884:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 887:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 889:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 88c:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 88f:	89 03                	mov    %eax,(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 891:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 894:	39 d8                	cmp    %ebx,%eax
 896:	75 e0                	jne    878 <free+0x48>
    p->s.size += bp->s.size;
 898:	03 53 04             	add    0x4(%ebx),%edx
 89b:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
 89e:	8b 13                	mov    (%ebx),%edx
 8a0:	89 11                	mov    %edx,(%ecx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 8a2:	5b                   	pop    %ebx
 8a3:	5e                   	pop    %esi
 8a4:	5d                   	pop    %ebp
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 8a5:	89 0d 00 0a 00 00    	mov    %ecx,0xa00
}
 8ab:	c3                   	ret    
 8ac:	8d 74 26 00          	lea    0x0(%esi),%esi

000008b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8b0:	55                   	push   %ebp
 8b1:	89 e5                	mov    %esp,%ebp
 8b3:	57                   	push   %edi
 8b4:	56                   	push   %esi
 8b5:	53                   	push   %ebx
 8b6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 8bc:	8b 15 00 0a 00 00    	mov    0xa00,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8c2:	83 c0 07             	add    $0x7,%eax
 8c5:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 8c8:	85 d2                	test   %edx,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8ca:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 8cd:	0f 84 8a 00 00 00    	je     95d <malloc+0xad>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d3:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 8d5:	8b 41 04             	mov    0x4(%ecx),%eax
 8d8:	39 c3                	cmp    %eax,%ebx
 8da:	76 1a                	jbe    8f6 <malloc+0x46>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 8dc:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
    }
    if(p == freep)
 8e3:	3b 0d 00 0a 00 00    	cmp    0xa00,%ecx
 8e9:	89 ca                	mov    %ecx,%edx
 8eb:	74 29                	je     916 <malloc+0x66>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ed:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 8ef:	8b 41 04             	mov    0x4(%ecx),%eax
 8f2:	39 c3                	cmp    %eax,%ebx
 8f4:	77 ed                	ja     8e3 <malloc+0x33>
      if(p->s.size == nunits)
 8f6:	39 c3                	cmp    %eax,%ebx
 8f8:	74 5d                	je     957 <malloc+0xa7>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 8fa:	29 d8                	sub    %ebx,%eax
 8fc:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
 8ff:	8d 0c c1             	lea    (%ecx,%eax,8),%ecx
        p->s.size = nunits;
 902:	89 59 04             	mov    %ebx,0x4(%ecx)
      }
      freep = prevp;
 905:	89 15 00 0a 00 00    	mov    %edx,0xa00
      return (void*) (p + 1);
 90b:	8d 41 08             	lea    0x8(%ecx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 90e:	83 c4 0c             	add    $0xc,%esp
 911:	5b                   	pop    %ebx
 912:	5e                   	pop    %esi
 913:	5f                   	pop    %edi
 914:	5d                   	pop    %ebp
 915:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 916:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 91c:	89 de                	mov    %ebx,%esi
 91e:	89 f8                	mov    %edi,%eax
 920:	76 29                	jbe    94b <malloc+0x9b>
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 922:	89 04 24             	mov    %eax,(%esp)
 925:	e8 b6 fc ff ff       	call   5e0 <sbrk>
  if(p == (char*) -1)
 92a:	83 f8 ff             	cmp    $0xffffffff,%eax
 92d:	74 18                	je     947 <malloc+0x97>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 92f:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 932:	83 c0 08             	add    $0x8,%eax
 935:	89 04 24             	mov    %eax,(%esp)
 938:	e8 f3 fe ff ff       	call   830 <free>
  return freep;
 93d:	8b 15 00 0a 00 00    	mov    0xa00,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 943:	85 d2                	test   %edx,%edx
 945:	75 a6                	jne    8ed <malloc+0x3d>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 947:	31 c0                	xor    %eax,%eax
 949:	eb c3                	jmp    90e <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 94b:	be 00 10 00 00       	mov    $0x1000,%esi
 950:	b8 00 80 00 00       	mov    $0x8000,%eax
 955:	eb cb                	jmp    922 <malloc+0x72>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 957:	8b 01                	mov    (%ecx),%eax
 959:	89 02                	mov    %eax,(%edx)
 95b:	eb a8                	jmp    905 <malloc+0x55>
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
 95d:	ba f8 09 00 00       	mov    $0x9f8,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 962:	c7 05 00 0a 00 00 f8 	movl   $0x9f8,0xa00
 969:	09 00 00 
 96c:	c7 05 f8 09 00 00 f8 	movl   $0x9f8,0x9f8
 973:	09 00 00 
    base.s.size = 0;
 976:	c7 05 fc 09 00 00 00 	movl   $0x0,0x9fc
 97d:	00 00 00 
 980:	e9 4e ff ff ff       	jmp    8d3 <malloc+0x23>
