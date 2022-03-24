;
;	A simple test crt0
;
	.code

start:
	bl	@_main
fail:	jmp	@fail
