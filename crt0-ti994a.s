
	.code

start:
	lwpi	0x8300
	clr	@0x8320
	li	r13,0x4000		; use low memory zone for stack
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

fake_args:
	.word	argv0
	.word	0
argv0:
	.ascii 'app'
	.byte	0
	.even
