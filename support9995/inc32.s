
		.export neg32
		.export inc32

		.code

neg32:
		inv	r0
		inv	r1
		; fall through
inc32:
		inc	r1
		jne	@inc32_1
		inc	r0
inc32_1:	rt
