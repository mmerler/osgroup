int stdout = 1;
int stderr = 2;

/* inline int startrecording() { */
/*   // homework 2: REMOVE this empty function once you've implemented the */
/*   // corresponding system call. */
/*   return 0; */
/* } */

/* inline int stoprecording() { */
/*   // homework 2: REMOVE this empty function once you've implemented the */
/*   // corresponding system call. */
/*   return 0; */
/* } */

/* inline int fetchrecords(struct record *records, int num_records) { */
/*   // homework 2: REMOVE this empty function once you've implemented the */
/*   // corresponding system call. */
/*   return 0; */
/* } */

inline void handle_error(const char *msg) {
  printf(stderr, "%s\n", msg);
  exit();
}

inline void check_syscall_no(const struct record *r, int n) {
  if (r->type != SYSCALL_NO || r->value.intval != n)
    handle_error("error check_syscall_no");
}

inline void check_ret_value(const struct record *r, int v) {
  if (r->type != RET_VALUE || r->value.intval != v)
    handle_error("error check_ret_value");
}

inline void check_arg_integer(const struct record *r, int v) {
  if (r->type != ARG_INTEGER || r->value.intval != v)
    handle_error("error check_arg_integer");
}

inline void check_arg_pointer(const struct record *r, void *p) {
  // Pointer values differs form machine to machine. 
  // Do not count on it. 
  if (r->type != ARG_POINTER/* || r->value.ptrval != p */) {
    printf(stderr, "actual %p, expected %p\n", r->value.ptrval, p);
    handle_error("error check_arg_pointer");
  }
}

inline void check_arg_string(const struct record *r, char *s) {
  if (r->type != ARG_STRING || strcmp(r->value.strval, s) != 0)
    handle_error("error check_arg_string");
}

