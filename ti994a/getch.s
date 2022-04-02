		.export _getch
		.code

_getch:
	clr	@0x8374
	blwp	@0x6020
	mov	@0x837C,r1
	coc	@lit2000_w, r1
	jne	@getch_1
	mov	@0x8375,r1
	rt
getch_1:
	li	r1,0xffff
	rt
