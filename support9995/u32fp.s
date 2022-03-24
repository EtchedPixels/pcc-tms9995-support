;
;	Unsigned 32bit to float. We only have signed 32bit to float hardware
;	so do the signed convert and then fix it up
;
		.export u32fp

		.code

u32fp:
		ci	r0,0
		jlt	@u32fp_1
		cer
		rt
u32fp_1:
		; Divide by 2 unsigned
		srl	r1,1
		srl	r0,1
		jnc	@u32fp_2
		ai	r1,0x8000
u32fp_2:
		; Make floating point
		cer
		; And double
		mr	@litfp_2
		rt

		; 0.5 in hardware floating point form
lifp_2:
		.word	0x4080
		.word	0x0000
