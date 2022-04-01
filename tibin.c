/*
 *	Turn a binary image into an EA5 pile
 *
 *	Ugly ugly loader format.
 */

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <ctype.h>

static uint8_t buf[8192];
static unsigned int start;
static unsigned int addr;

static void emit_block(char *name, int len, int last)
{
    int ofd;
    len += 6;
    buf[0] = last ? 0x00 : 0xFF;
    buf[1] = last ? 0x00 : 0xFF;
    buf[2] = (len >> 8) & 0xFF;
    buf[3] = (len & 0xFF);
    buf[4] = (addr >> 8) & 0xFF;
    buf[5] = (addr & 0xFF);
    printf("%s %X %X\n", name, addr, len);
    ofd = open(name, O_WRONLY|O_CREAT|O_TRUNC, 0666);
    if (ofd == -1) {
        perror(name);
        exit(1);
    }
    if (write(ofd, buf, len) != len || close(ofd)) {
        fprintf(stderr, "%s: write error.\n", name);
        exit(1);
    }
}

int main(int argc, char *argv[])
{
    int ifd;
    char *pname;
    char *pptr;
    int l;
    off_t left;

    start = 0xA000;
    addr = 0xA000;

    if (argc != 2) {
        fprintf(stderr, "%s: [file]\n", argv[0]);
        exit(1);
    }

    pname = malloc(strlen(argv[1]) + 1);
    if (pname == NULL) {
        fprintf(stderr, "%s: out of memory.\n", argv[0]);
        exit(1);
    }
    strcpy(pname, argv[1]);

    pptr = strrchr(pname, '/');
    if (pptr)
        pptr++;
    else
        pptr = pname;
    while(*pptr) {
        *pptr = toupper(*pptr);
        pptr++;
    }
    *pptr = '0';
    
    ifd = open(argv[1], O_RDONLY);
    if (ifd < 0) {
        perror(argv[1]);
        exit(1);
    }

    left = lseek(ifd, 0, SEEK_END);
    if (left < 0) {
        perror(argv[1]);
        exit(1);
    }
    
    left -= start;

    if (lseek(ifd, (off_t)start, SEEK_SET) < 0) {
        perror(argv[1]);
        exit(1);
    }

    while((l = read(ifd, buf + 6, 8186)) > 0) {
        left -= l;
        emit_block(pname, l, left == 0);
        addr += l;
        (*pptr)++;
    }
    if (l == -1) {
        perror(argv[1]);
        exit(1);
    }
    close(ifd);
    exit(0);
}
