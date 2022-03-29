all: makelitb cc9995 crt0.o libc.a lib9995.a

install: cc9995 crt0.o libc.a lib9995.a
	cp crt0.o /opt/cc9995/lib
	cp libc.a /opt/cc9995/lib
	cp lib9995.a /opt/cc9995/lib
	cp cc9995 /opt/cc9995/bin

cc9995: cc9995.c
	gcc -Wall -pedantic -O2 cc9995.c -o cc9995

makelitb: makelitb.c
	gcc -Wall -pedantic -O2 makelitb.c -o makelitb
	./makelitb

# Members for the C library
OBJ =	libc/memcpy.o \
	libc/memset.o \
	libc/strlen.o

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

include literals

libc.a:	cc9995 $(OBJ)
	ar rc libc.a $(OBJ) $(AOBJ)

lib9995.a: cc9995 $(SOBJ) $(LOBJ)
	ar rc lib9995.a $(SOBJ) $(LOBJ)

%.o: %.s
	as9995 $^

%.o: %.c
	cc9995 -c $^

clean:
	rm -f $(OBJ) *~ cc9995 crt0.o lib9995.a libc.a support9995/*.o libc/*.o


