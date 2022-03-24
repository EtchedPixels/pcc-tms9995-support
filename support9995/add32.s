
		.export add32

		.code

add32:
		a	r3,r1
		jnc	@add32_1
		inc	r0
add32_1:	a	r2,r0
		rt


