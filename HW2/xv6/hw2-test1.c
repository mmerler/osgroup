#include "types.h"
#include "user.h"
#include "record.h"
#include "fcntl.h"
#include "syscall.h"

#define CORRECT_NUM_RECORDS (16)

int stdout = 1;
int stderr = 2;

static void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
  exit();
}

int main(int argc, char *argv[]) {
  int ret;
  struct record *records;
  int fd;
  int num_records;
  
  ret = startrecording();
  if (ret == -1)
    handle_error("error startrecording");

  printf(stderr, "\n");
  fd = open("README", O_RDONLY);

  open("abcdefghijklmnopqrstuvwxyz", O_RDONLY);

  close(fd);
  
  ret = stoprecording();
  if (ret == -1)
    handle_error("error stoprecording");

  ret = fetchrecords(0, &num_records);
  if (ret == -1)
    handle_error("error fetching # of records\n");

  if (num_records != CORRECT_NUM_RECORDS)
    handle_error("# of records is wrong\n");

  records = malloc(sizeof(struct record) * num_records);
  if (!records)
    handle_error("error malloc");

  ret = fetchrecords(records, &num_records);
  if (ret == -1)
    handle_error("error fetchrecords");

  if (records[0].type != SYSCALL_NO || records[0].value.intval != SYS_write)
    handle_error("error record 0");
  if (records[1].type != ARG_INTEGER || records[1].value.intval != 2)
    handle_error("error record 1");
  if (records[2].type != ARG_POINTER || records[2].value.ptrval != (void *)0x1f8b)
    handle_error("error record 2");
  if (records[3].type != ARG_INTEGER || records[3].value.intval != 1)
    handle_error("error record 3");
  if (records[4].type != RET_VALUE || records[4].value.intval != 1)
    handle_error("error record 4");
  if (records[5].type != SYSCALL_NO || records[5].value.intval != SYS_open)
    handle_error("error record 5");
  if (records[6].type != ARG_STRING ||
      strcmp(records[6].value.strval, "README") != 0)
    handle_error("error record 6");
  if (records[7].type != ARG_INTEGER || records[7].value.intval != 0)
    handle_error("error record 7");
  if (records[8].type != RET_VALUE || records[8].value.intval != 3)
    handle_error("error record 8");
  if (records[9].type != SYSCALL_NO || records[9].value.intval != SYS_open)
    handle_error("error record 9");
  if (records[10].type != ARG_STRING ||
      strcmp(records[10].value.strval, "abcdefghijklmnopqrs") != 0)
    handle_error("error record 10");
  if (records[11].type != ARG_INTEGER || records[11].value.intval != 0)
    handle_error("error record 11");
  if (records[12].type != RET_VALUE || records[12].value.intval != -1)
    handle_error("error record 12");
  if (records[13].type != SYSCALL_NO || records[13].value.intval != SYS_close)
    handle_error("error record 13");
  if (records[14].type != ARG_INTEGER || records[14].value.intval != 3)
    handle_error("error record 14");
  if (records[15].type != RET_VALUE || records[15].value.intval != 0)
    handle_error("error record 15");

  free(records);

  printf(stdout, "hw2-test1 succeed\n");

  exit();
}

