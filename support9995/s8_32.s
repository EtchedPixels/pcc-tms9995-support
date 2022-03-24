
		.export s8_32
		.export s16_32
		.code

s8_32:
		swpb	r1
		sra	r1,8
s16_32:
		clr	r0
		ci	r1,0
		jlt	@s16_32_1
		dec	r0
s16_32_1:	rt
