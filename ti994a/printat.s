		.export _printat
		.code

_printat:
	mov	r4,r0	; position
	mov	r5,r1	; string
	clr	r2
printat_1:
	inc	r2
	movb	*r5+,r3
	jne	@printat_1
	dec	r2
	blwp	@0x6028
	rt
