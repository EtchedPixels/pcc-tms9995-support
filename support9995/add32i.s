
		.export add32i

		.code

add32i:
		a	*r11+,r1
		jnc	@add32_1
		inc	r0
add32_1:	a	*r11+,r0
		rt


