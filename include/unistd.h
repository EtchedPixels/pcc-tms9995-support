#ifndef __UNISTD_H
#define __UNISTD_H
#ifndef __TYPES_H
#include <types.h>
#endif

#ifndef SEEK_SET
#define SEEK_SET 0
#define SEEK_CUR 1
#define SEEK_END 2
#endif

#define STDIN_FILENO	0
#define STDOUT_FILENO	1
#define STDERR_FILENO	2

extern void swab(const void * __from, void * __to, ssize_t __count);

#ifndef __STDLIB_H
extern void exit(int __status);
#endif

#endif /* __UNISTD_H */
