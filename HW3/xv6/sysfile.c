#include "types.h"
#include "defs.h"
#include "param.h"
#include "stat.h"
#include "mmu.h"
#include "spinlock.h"
#include "rwlock.h"
#include "proc.h"
#include "fs.h"
#include "file.h"
#include "fcntl.h"

static int
getfd(int n, int *pfd, struct file **pf)
{
  int fd;
  struct file *f;

  if(getuserint(n, &fd) < 0)
    return -1;
  if(fd < 0 || fd >= NOFILE)
    return -1;

  acquire(&proc->common->lock);
  f = proc->common->ofile[fd];
  if (f != 0)
    filedup(f);
  release(&proc->common->lock);
  if (f == 0)
    return -1;

  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}

static void
putfd(struct file *f)
{
  fileclose(f);
}

static int
fdalloc(struct file *f)
{
  int fd;

  acquire(&proc->common->lock);
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->common->ofile[fd] == 0){
      proc->common->ofile[fd] = f;
      release(&proc->common->lock);
      return fd;
    }
  }
  release(&proc->common->lock);
  return -1;
}

int
sys_dup(void)
{
  struct file *f;
  int fd;
  
  if(getfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    goto error;
  filedup(f);

  putfd(f);
  return fd;

error:
  putfd(f);
  return -1;
}

int
sys_read(void)
{
  struct file *f;
  int n, ret;
  char *p;

  if (getfd(0, 0, &f) < 0)
    return -1;

  if (getuserint(2, &n) < 0 || n > PGSIZE || (p = kalloc()) == 0)
    goto e_fd;

  if ((ret = fileread(f, p, n)) < 0 || putuserbuf(1, p, n) < 0)
    goto e_ka;

  kfree(p);
  putfd(f);
  return ret;

e_ka:
  kfree(p);
e_fd:
  putfd(f);
  return -1;
}

int
sys_write(void)
{
  struct file *f;
  int n, ret;
  char *p;

  if (getfd(0, 0, &f) < 0)
    return -1;

  if (getuserint(2, &n) < 0 || n > PGSIZE || (p = kalloc()) == 0)
    goto e_fd;

  if (getuserbuf(1, p, n) < 0 || (ret = filewrite(f, p, n)) < 0)
    goto e_ka;

  kfree(p);
  putfd(f);
  return ret;

e_ka:
  kfree(p);
e_fd:
  putfd(f);
  return -1;
}

int
sys_close(void)
{
  int fd;
  struct file *f;
  
  if(getfd(0, &fd, &f) < 0)
    return -1;

  proc->common->ofile[fd] = 0;
  fileclose(f);

  putfd(f);
  return 0;
}

int
sys_fstat(void)
{
  struct file *f;
  struct stat st;
  int ret;

  if (getfd(0, 0, &f) < 0)
    return -1;

  if ((ret = filestat(f, &st)) < 0 || putuserbuf(1, &st, sizeof(struct stat)) < 0)
    goto e_fd;

  putfd(f);
  return ret;

e_fd:
  putfd(f);
  return -1;
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
  char name[DIRSIZ], new[MAXPATH], old[MAXPATH];
  struct inode *dp, *ip;
  int str;

  if ((str = getuserstr(0, old, MAXPATH)) < 0 || str >= MAXPATH ||
      (str = getuserstr(1, new, MAXPATH)) < 0 || str >= MAXPATH ||
      (ip = namei(old)) == 0)
    return -1;

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
    return -1;
  }
  ip->nlink++;
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
  iput(ip);

  return 0;

bad:
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  return -1;
}

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
}

int
sys_unlink(void)
{
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], path[MAXPATH];
  uint off;
  int str;

  if ((str = getuserstr(0, path, MAXPATH)) < 0 || str >= MAXPATH ||
      (dp = nameiparent(path, name)) == 0)
    return -1;

  ilock(dp);

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0){
    iunlockput(dp);
    return -1;
  }

  if((ip = dirlookup(dp, name, &off)) == 0){
    iunlockput(dp);
    return -1;
  }
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
    iunlockput(dp);
    return -1;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);

  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  return 0;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
  ilock(dp);

  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");

  ilock(ip);
  ip->major = major;
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
    iupdate(dp);
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);
  return ip;
}

int
sys_open(void)
{
  char path[MAXPATH];
  int fd, omode, len;
  struct file *f;
  struct inode *ip;

  if ((len = getuserstr(0, path, MAXPATH)) < 0 || len >= MAXPATH ||
      getuserint(1, &omode) < 0)
    return -1;

  if(omode & O_CREATE){
    if((ip = create(path, T_FILE, 0, 0)) == 0)
      return -1;
  } else {
    if((ip = namei(path)) == 0)
      return -1;
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
      iunlockput(ip);
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}

int
sys_mkdir(void)
{
  char path[MAXPATH];
  struct inode *ip;
  int len;

  if((len = getuserstr(0, path, MAXPATH)) < 0 || len >= MAXPATH ||
     (ip = create(path, T_DIR, 0, 0)) == 0)
    return -1;

  iunlockput(ip);

  return 0;
}

int
sys_mknod(void)
{
  struct inode *ip;
  char path[MAXPATH];
  int len;
  int major, minor;
  
  if((len=getuserstr(0, path, MAXPATH)) < 0 || len >= MAXPATH ||
     getuserint(1, &major) < 0 || getuserint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0)
    return -1;

  iunlockput(ip);
  return 0;
}

int
sys_chdir(void)
{
  char path[MAXPATH];
  struct inode *ip;
  int len;

  if ((len = getuserstr(0, path, MAXPATH)) < 0 || len >= MAXPATH ||
      (ip = namei(path)) == 0)
    return -1;

  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);
  acquire(&proc->common->lock);
  iput(proc->common->cwd);
  proc->common->cwd = ip;
  release(&proc->common->lock);
  return 0;
}

int
sys_exec(void)
{
  char path[MAXPATH], *argv[20];
  int i, len;
  uint uargv, uarg;

  if ((len = getuserstr(0, path, MAXPATH)) < 0 || len >= MAXPATH ||
      getuserint(1, (int *)&uargv) < 0)
    return -1;

  memset(argv, 0, sizeof(argv));
  for (i=0;; i++) {
    if (i >= NELEM(argv))
      return -1;
    if (fetchint(proc, uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if (uarg == 0) {
      argv[i] = 0;
      break;
    }
    // Safe.. exec() prohibited in threaded processes
    if (fetchstr_legacy(proc, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}

int
sys_pipe(void)
{
  struct file *rf, *wf;
  int fd[2];

  if (pipealloc(&rf, &wf) < 0)
    return -1;
  if ((fd[0] = fdalloc(rf)) < 0)
    goto e_pa;
  if ((fd[1] = fdalloc(wf)) < 0)
    goto e_rf;
  if (putuserbuf(0, fd, sizeof(fd)) < 0)
    goto e_wf;

  return 0;

e_wf:
  proc->common->ofile[fd[1]] = 0;
e_rf:
  proc->common->ofile[fd[0]] = 0;
e_pa:
  fileclose(rf);
  fileclose(wf);
  return -1;
}
