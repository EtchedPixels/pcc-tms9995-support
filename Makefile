all: makelitb cc9995 crt0.o crt0-ti994a.o crt0-mdos.o libc.a lib9995.a \
     libti994a.a tibin mdosbin

install: cc9995 crt0.o crt0-ti994a.o crt0-mdos.o libc.a lib9995.a \
	tibin mdosbin libti994a.a
	mkdir -p /opt/cc9995/lib
	mkdir -p /opt/cc9995/bin
	mkdir -p /opt/cc9995/include
	mkdir -p /opt/cc9995/include/sys
	mkdir -p /opt/cc9995/lib/target-ti994a
	mkdir -p /opt/cc9995/include/target-ti994a
	mkdir -p /opt/cc9995/lib/target-mdos
	mkdir -p /opt/cc9995/include/target-mdos
	cp crt0.o /opt/cc9995/lib
	cp crt0-ti994a.o /opt/cc9995/lib/target-ti994a
	cp libti994a.a /opt/cc9995/lib/target-ti994a
	cp libc.a /opt/cc9995/lib
	cp include/*.h /opt/cc9995/include
	cp include/sys/*.h /opt/cc9995/include/sys
	cp lib9995.a /opt/cc9995/lib
	cp cc9995 /opt/cc9995/bin
	cp tibin /opt/cc9995/lib/target-ti994a
	cp mdosbin /opt/cc9995/lib/target-mdos

cc9995: cc9995.c
	gcc -Wall -pedantic -O2 cc9995.c -o cc9995

tibin: tibin.c
	gcc -Wall -pedantic -O2 tibin.c -o tibin

mdosbin: mdosbin.c
	gcc -Wall -pedantic -O2 mdosbin.c -o mdosbin

makelitb: makelitb.c
	gcc -Wall -pedantic -O2 makelitb.c -o makelitb
	./makelitb

# Members for the C library
OBJ =	libc/memcpy.o \
	libc/memset.o \
	libc/strlen.o \
	libc/abort.o \
	libc/abs.o \
	libc/atoi.o \
	libc/atol.o \
	libc/bcmp.o \
	libc/bcopy.o \
	libc/bsearch.o \
	libc/bzero.o \
	libc/calloc.o \
	libc/crypt.o \
	libc/exit.o \
	libc/free.o \
	libc/getopt.o \
	libc/index.o \
	libc/isalnum.o \
	libc/isalpha.o \
	libc/isascii.o \
	libc/isblank.o \
	libc/iscntrl.o \
	libc/isdigit.o \
	libc/isgraph.o \
	libc/islower.o \
	libc/isprint.o \
	libc/ispunct.o \
	libc/isspace.o \
	libc/isupper.o \
	libc/isxdigit.o \
	libc/libintl.o \
	libc/lrand48.o \
	libc/lsearch.o \
	libc/ltoa.o \
	libc/ltostr.o \
	libc/malloc.o \
	libc/memccpy.o \
	libc/memcmp.o \
	libc/memmove.o \
	libc/qsort.o \
	libc/realloc.o \
	libc/rindex.o \
	libc/strcasecmp.o \
	libc/strcasestr.o \
	libc/strcat.o \
	libc/strchr.o \
	libc/strcmp.o \
	libc/strcoll.o \
	libc/strcpy.o \
	libc/strcspn.o \
	libc/strdup.o \
	libc/stricmp.o \
	libc/strlcpy.o \
	libc/strncasecmp.o \
	libc/strncat.o \
	libc/strncmp.o \
	libc/strncpy.o \
	libc/strnicmp.o \
	libc/strnlen.o \
	libc/strpbrk.o \
	libc/strrchr.o \
	libc/strsep.o \
	libc/strspn.o \
	libc/strstr.o \
	libc/strtok.o \
	libc/strtok_r.o \
	libc/strtol.o \
	libc/strxfrm.o \
	libc/swab.o \
	libc/tfind.o \
	libc/tolower.o \
	libc/toupper.o \
	libc/xitoa.o

STDIO =	stdio/fclose.o \
	stdio/fflush.o \
	stdio/fgetc.o \
	stdio/fgetpos.o \
	stdio/fgets.o \
	stdio/fopen.o \
	stdio/fprintf.o \
	stdio/fputc.o \
	stdio/fputs.o \
	stdio/fread.o \
	stdio/fscanf.o \
	stdio/fsetpos.o \
	stdio/ftell.o \
	stdio/fwrite.o \
	stdio/gets.o \
	stdio/getw.o \
	stdio/printf.o \
	stdio/putchar.o \
	stdio/putw.o \
	stdio/sprintf.o \
	stdio/sscanf.o \
	stdio/stdio0.o \
	stdio/vfprintf.o \
	stdio/vfscanf.o \
	stdio/vprintf.o \
	stdio/vscanf.o \
	stdio/vsscanf.o

# Members for the support library
SOBJ =  support9995/add32i.o \
	support9995/add32.o \
	support9995/center.o \
	support9995/cret.o \
	support9995/cretv.o \
	support9995/dec32.o \
	support9995/div32.o \
	support9995/divs.o \
	support9995/fpreg.o \
	support9995/inc32.o \
	support9995/ls32.o \
	support9995/mul32.o \
	support9995/rss32.o \
	support9995/rsu32.o \
	support9995/s8_32.o \
	support9995/sub32i.o \
	support9995/sub32.o \
	support9995/u32fp.o

# Members for the TI/994A library

TOBJ = 	ti994a/console.o \
	ti994a/getch.o \
	ti994a/getjs.o \
	ti994a/printat.o \
	ti994a/glue.o

include literals

libc.a:	cc9995 $(STDIO) $(OBJ)
	ar rc libc.a $(STDIO) $(OBJ) $(AOBJ)

lib9995.a: cc9995 $(SOBJ) $(LOBJ)
	ar rc lib9995.a $(SOBJ) $(LOBJ)

libti994a.a: cc9995 $(TOBJ)
	ar rc libti994a.a $(TOBJ)

%.o: %.s
	as9995 $^

%.o: %.c
	./cc9995 -Iinclude -c $^

clean:
	rm -f $(OBJ) *~ cc9995 crt0.o lib9995.a libc.a
	rm -f support9995/*.o libc/*.o ti994a/*.o


