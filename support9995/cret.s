
		.export cret

		.code

cret:
		mov	r12,r13
		mov	*r13+,r12
		mov	*r13+,r11
		rt
