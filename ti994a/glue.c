/*
 *	Some very basic test glue
 */

#include <unistd.h>
#include <errno.h>

int open(const char *name, int mode, ...)
{
    errno = EIO;
    return -1;
}

int close(int fd)
{
    errno = EIO;
    return -1;
}

int remove(const char *name)
{
    errno = EIO;
    return -1;
}

int rename(const char *n1, const char *n2)
{
    errno = EIO;
    return -1;
}

off_t lseek(int fd, long offset, int mode)
{
    errno = EIO;
    return -1L;
}

int read(int fd, void *bufp, int len)
{
    char *buf = bufp;
    if (fd) {
        errno = EIO;
        return -1;
    }
    *buf = getch();
    return 1;
}

int write(int fd, const void *bufp, int len)
{
    char *buf = bufp;
    if (fd !=1 && fd != 2) {
        errno = EIO;
        return -1;
    }
    while(len--)
        _putchar(*buf++);
}

static char *mptr = (char *)0x2000;		/* Base of low memory */

int brk(void *p)
{
    char dummy;
    char *x = &dummy;
    if (p + 256 >= x) {		/* Close to stack ?? */
        errno = ENOMEM;
        return -1;
    }
    mptr = p;
    return 0;
}

void *sbrk(intptr_t n)
{
    char *p = mptr;
    if (brk(mptr + n) == -1)
        return (void *)-1;
    return p;
}