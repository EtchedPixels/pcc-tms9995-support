		.export _getjs
		.code

_getjs:
	li	r0,0200
	movb	r0,@0x8374
	blwp	@0x6020
	mov	@0x8375,r1
	rt

