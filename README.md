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

make
make install

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
-m:	specify machine subtype. Only 9995 is currently accepted
-M:	generate a map file if linking
-s:	standalone
-S:	generate assembler but do not assemble
-t:	specify target system. Only fuzix ones are currently accepted
-X:	keep temporary files. Does not delete any intermediate .%, .s or
	similar files. Useful for debugging.
````

