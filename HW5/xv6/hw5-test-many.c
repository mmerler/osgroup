// Added by Jingyue

#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "stat.h"
#include "fs.h"
#include "hw5-common.h"

#define MAX_LEN (1024)
#define N_LOOPS (5)
#define N_PROCS (1 << N_LOOPS)

static char digit2char(int d) {
  if (d < 0 || d > 9)
    panic("digit2char");
  return (char)('0' + d);
}

// Returns -1 on error; otherwise, returns the length of the string. 
static int itoa(int v, char *buf, int max_size) {
  if (v <= 0)
    return -1;
  int i = 0;
  while (v > 0) {
    if (i + 1 >= max_size)
      return -1;
    buf[i] = digit2char(v % 10);
    i++;
    v /= 10;
  }
  buf[i] = '\0';
  int j = 0, k = i - 1;
  while (j < k) {
    char tmp = buf[j]; buf[j] = buf[k]; buf[k] = tmp;
    ++j; --k;
  }
  return i;
}

int main() {

  int i;
  int root = 1;
  for (i = 0; i < N_LOOPS; i++) {
    int child_pid = fork();
    if (child_pid < 0)
      panic("fork");
    if (child_pid == 0)
      root = 0;
  }

  // Each process creates a file with the name <pid> under
  // the current directory. 
  char file_name[MAX_LEN];
  if (itoa(getpid(), file_name, MAX_LEN) < 0)
    panic("itoa");
  int fd = open(file_name, O_CREATE);
  if (fd == -1)
    panic("open");
  close(fd);

  sleep(root ? 4 * 100 : 1 * 100);
  // Wait for all children to exit. 
  while (wait() >= 0);
  // Only the root process decides whether the testcase is passed. 
  if (!root)
    exit();

  int dir = open(".", O_RDONLY);
  if (dir < 0)
    panic("open dir");
  struct stat st;
  if (fstat(dir, &st) < 0)
    panic("fstat");
  if (st.type != T_DIR)
    panic("Not a directory");

  // The root process counts all files whose name contains only digits.
  // Those are the notification files.  
  struct dirent de;
  int n_succ = 0;
  while (read(dir, &de, sizeof(de)) == sizeof(de)) {
    int all_digits = 1;
    for (i = 0; i < strlen(de.name); ++i) {
      if (de.name[i] < '0' || de.name[i] > '9') {
        all_digits = 0;
        break;
      }
    }
    if (all_digits)
      ++n_succ;
  }
  
  // If every process has created a notification file, it's great.
  if (n_succ != N_PROCS)
    panic("Some child processes didn't exit successfully");

  printf(stdout, "hw5-test-many succeeded\n");
  exit();
}

