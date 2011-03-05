#include "types.h"
#include "defs.h"
#include "param.h"
#include "mmu.h"
#include "spinlock.h"
#include "rwlock.h"
#include "proc.h"
#include "x86.h"
#include "syscall.h"

// User code makes a system call with INT T_SYSCALL.
// System call number in %eax.
// Arguments on the stack, from the user call to the C
// library system call function. The saved user %esp points
// to a saved program counter, and then the first argument.

int
fetchint(struct proc *p, uint addr, int *ip)
{
  readlock(&p->common->pglock);

  if (addr >= p->common->sz || addr+4 > p->common->sz) {
    readunlock(&p->common->pglock);
    return -1;
  }

  *ip = *(int*)(addr);

  readunlock(&p->common->pglock);
  return 0;
}

int
fetchstr(struct proc *p, uint addr, char *dst, uint dsz)
{
  char *s;
  uint sz = 0;

  readlock(&p->common->pglock);

  if (addr >= p->common->sz)
    goto error;

  for (s = (char *)addr; s < (char *)p->common->sz; s++) {
    if (sz++ < dsz)
      *(dst++) = *s;
    if (*s == '\0') {
        readunlock(&p->common->pglock);
        return sz - 1;
    }
  }

error:
  readunlock(&p->common->pglock);
  return -1;
}

int
fetchbuf(struct proc *p, uint addr, void *dst, uint sz)
{
  readlock(&p->common->pglock);

  if(addr >= p->common->sz || (uint)addr+sz >= proc->common->sz)
    goto error;

  memmove(dst, (char *)addr, sz);

  readunlock(&p->common->pglock);
  return sz;

error:
  readunlock(&p->common->pglock);
  return -1;
}

int
writeint(struct proc *p, uint addr, int i)
{
  readlock(&p->common->pglock);

  if (addr >= p->common->sz || addr+4 > p->common->sz) {
    readunlock(&p->common->pglock);
    return -1;
  }

  *(int*)(addr) = i;

  readunlock(&p->common->pglock);
  return 0;
}

int
writebuf(struct proc *p, uint addr, void *src, uint sz)
{
  readlock(&p->common->pglock);

  if(addr >= p->common->sz || (uint)addr+sz >= proc->common->sz)
    goto error;

  memmove((char *)addr, src, sz);

  readunlock(&p->common->pglock);
  return sz;

error:
  readunlock(&p->common->pglock);
  return -1;
}

int
writestr(struct proc *p, uint addr, char *src, uint dsz)
{
  return writebuf(p, addr, src, strlen(src) + 1);
}

int
getuserint(int n, int *ip)
{
  return fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
}

int
getuserbuf(int n, void *dst, int size)
{
  int i;

  if (getuserint(n, &i) < 0)
    return -1;
  return fetchbuf(proc, (uint)i, dst, size);
}

int
getuserstr(int n, char *dst, int dsz)
{
  int i;

  if (getuserint(n, &i) < 0)
    return -1;
  return fetchstr(proc, (uint)i, dst, dsz);
}

int
putuserbuf(int n, void *src, int sz)
{
  int i;

  if (getuserint(n, &i) < 0)
    return -1;
  return writebuf(proc, (uint)i, src, sz);
}

// LEGACY XV6 CODE BELOW

int
argint(int n, int *ip)
{
  return fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
}

int
argptr(int n, char **pp, int size)
{
  int i;
  
  if(argint(n, &i) < 0)
    return -1;
  if((uint)i >= proc->common->sz || (uint)i+size >= proc->common->sz)
    return -1;
  *pp = (char *) i;
  return 0;
}

int
fetchstr_legacy(struct proc *p, uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= p->common->sz)
    return -1;
  *pp = (char *) addr;
  ep = (char *) p->common->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
      return s - *pp;
  return -1;
}

int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr_legacy(proc, addr, pp);
}

extern int sys_chdir(void);
extern int sys_close(void);
extern int sys_dup(void);
extern int sys_exec(void);
extern int sys_exit(void);
extern int sys_fork(void);
extern int sys_fstat(void);
extern int sys_getpid(void);
extern int sys_kill(void);
extern int sys_link(void);
extern int sys_mkdir(void);
extern int sys_mknod(void);
extern int sys_open(void);
extern int sys_pipe(void);
extern int sys_read(void);
extern int sys_sbrk(void);
extern int sys_sleep(void);
extern int sys_unlink(void);
extern int sys_wait(void);
extern int sys_write(void);
extern int sys_uptime(void);
extern int sys_rwlock(void);
extern int sys_pschk(void);
extern int sys_tfork(void);
extern int sys_texit(void);
extern int sys_twait(void);

static int (*syscalls[])(void) = {
[SYS_chdir]   sys_chdir,
[SYS_close]   sys_close,
[SYS_dup]     sys_dup,
[SYS_exec]    sys_exec,
[SYS_exit]    sys_exit,
[SYS_fork]    sys_fork,
[SYS_fstat]   sys_fstat,
[SYS_getpid]  sys_getpid,
[SYS_kill]    sys_kill,
[SYS_link]    sys_link,
[SYS_mkdir]   sys_mkdir,
[SYS_mknod]   sys_mknod,
[SYS_open]    sys_open,
[SYS_pipe]    sys_pipe,
[SYS_read]    sys_read,
[SYS_sbrk]    sys_sbrk,
[SYS_sleep]   sys_sleep,
[SYS_unlink]  sys_unlink,
[SYS_wait]    sys_wait,
[SYS_write]   sys_write,
[SYS_uptime]  sys_uptime,
[SYS_rwlock]  sys_rwlock,
[SYS_pschk]   sys_pschk,
[SYS_tfork]   sys_tfork,
[SYS_texit]   sys_texit,
[SYS_twait]   sys_twait,
};

void
syscall(void)
{
  int num;
  
  num = proc->tf->eax;
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
  }
}
