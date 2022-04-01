# TMS9995 Support Code For PCC

This contains the supporting files for the tms9995 compiler suite. As well
as these you need the pcc 9995 backend, the assembler and linker.

## Compiler

Pull the git repository and build it. At the moment it will fail on the
driver but ignore that, all you want is tms9995-ccom and tms9995-cpp. 
Stick them in /opt/cc9995/lib.

## Assembler And Linker

For historical reasons these live in the CC6303 repository.

````
make -f Makefile.tms9995 clean
make -f Makefile.tms9995 install
````

## The Runtime

````
make
make install
````

## Usage

The cc9995 command takes the same basic options as most Unix style C
compilers

````
-c:	compile but do not link
-D:	add a define
-E:	preprocess only
-i:	generate split I/D on relevant platforms (no effect on this one)
-I:	add an include path
-l:	add a library
-L:	add a library search path
-m:	specify machine subtype. Only 9900 and 9995 are currently accepted
-M:	generate a map file if linking
-s:	standalone
-S:	generate assembler but do not assemble
-t:	specify target system. Only fuzix ones or ti994a are currently accepted
-X:	keep temporary files. Does not delete any intermediate .%, .s or
	similar files. Useful for debugging.
````

For Fuzix see thge Applications/rules.tms9995 file in the Fuzix distribution
for the build rules, although the OS side is all still very much under
debug.

For ti99/4a something like

````
cc -tti994a foo.c -o foo
````

should produce a binary image 'foo' linked at 0xA000 and FOO0 (FOO1, ...) an
EA5 image.

If you are usimg this toolchain with code intended for the gcc compiler note
that the compiler ABI is entirely different. R13 is a downward growing stack
(usually placed at 0x4000), R12 is used as a frame pointer, and the first
two arguments are passed in R4 and R5 (or the first long argument). R0-R5
are scratch, R1 is the return value or R0/R1 for 32bit. R8-R15 should be
preserved except for R11 which is used for BL as normal.

The assembler syntax is also slightly more conventional. The use of 'r' to
indicate a register is mandatory, and hexadecimal is indicated by 0x or $.
The '<' and '>' symbols select the upper and lower byte of a value as with
the rest of the assemblers in the toolkit used.

Floating point generates TI990/12 single precision instructions and expects
them to be emulated if floating point is required. At this point floating
point has not really been tested so is best avoided.
