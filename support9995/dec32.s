
		.export dec32

		.code

dec32:
		dec	r1
		jne	@dec32_1
		dec	r0
dec32_1:	rt



