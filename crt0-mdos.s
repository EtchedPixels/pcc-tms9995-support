;
;	The first words get replaced by the fixer upper
;

		.code

	.word __code_size
	.word __data_size
	.word __bss_size

start:
	li	r13, stack
	li	r0,__bss_size
	jeq	@nowipe
	li	r1,__bss
	clr	r2
wipe:
	mov	r2,*r1+
	dect	r0
	jne	@wipe

nowipe:
	li	r4,1
	li	r5, fake_args
	bl	@_main

	blwp	@0

;
;	TODO proper arg processing
;
fake_args:
	.word	argv0
	.word	0
argv0:
	.ascii 'app'
	.byte	0
	.even

	.bss

	.even
	.ds	8192		; for now - configurable might be good ??
stack:
