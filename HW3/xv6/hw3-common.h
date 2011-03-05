#define ONE_SEC     (100)
#define STACK_SIZE  (4096)
#define MAGIC_VALUE (0x0987CDEF)

int stdout = 1;
int stderr = 2;

// Return true if <a> and <b> differ in at most 5%. 
inline int time_equal(int a, int b) {
  if (a < 0 || b < 0)
    return 0;
  if (a > b) {
    int t = a;
    a = b;
    b = t;
  }
  return 10 * (b - a) <= b;
}

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
  exit();
}

#define NEW_STACK(stack) \
  { (stack) = malloc(STACK_SIZE); \
    if ((stack) == 0) \
      handle_error("malloc() error"); }

#define NEW_THREAD(thread_fn, arg, stack, tid) \
  { (tid) = tfork((thread_fn), (arg), (stack) + STACK_SIZE); \
    if ((tid) < 0) \
      handle_error("tfork() error"); }

#define NEW_STACK_THREAD(thread_fn, arg, stack, tid) \
  { NEW_STACK(stack); \
    NEW_THREAD((thread_fn), (arg), (stack), (tid)); }

#define WAIT_THREAD(tid, fail) \
  { if (fail) { \
      if (twait(tid) >= 0) \
        handle_error("twait() error X"); \
    } else { \
      if (twait(tid) < 0) \
        handle_error("twait() error"); } }

#define EXIT_THREAD \
  { texit(); \
    handle_error("texit() error"); } \

#define PROC_CHECK(n) \
  { if (pschk() != (n)) \
      handle_error("proc status error"); }
