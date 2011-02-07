// Defines the types needed for syscall recording

// Exported to users

enum recordtype { SYSCALL_NO, ARG_INTEGER, ARG_POINTER, ARG_STRING, RET_VALUE };

#define MAX_STR_LEN (20)

struct record {
  enum recordtype type;
  union recordvalue {
    int intval;
    void *ptrval;
    char strval[MAX_STR_LEN];
  } value;
};

