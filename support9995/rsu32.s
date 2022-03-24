
		.export rsu32
		.export rsu32i

		.code

;
;	Unsigned 32bit right shift, with fast path for >= 16 bits
;
rsu32_0:
		srl	r1,1
		joc	@rsu32_1
		srl	r0,1
		jmp	@rsu32
rsu32_1:	srl	r0,1
		ai	r0,0x8000
rsu32_2:	dec	r2
		jnc	@rsu32_0
		rt
rsu32i:
		mov	*r11+,r2
rsu32:
		ci	r2,16
		jlt	@rsu32_2
		mov	r0,r1
		clr	r0
		ai	r2,-16
		jmp	@rsu32_2
