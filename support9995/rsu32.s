
		.export rsu32
		.export rsu32i

		.code

;
;	Unsigned 32bit right shift, with fast path for >= 16 bits
;
rsu32_0:
		dec	r2
		srl	r0,1
		joc	@rsu32_1
		srl	r1,1
		jmp	@rsu32
rsu32_1:	srl	r1,1
		ai	r1,0x8000
rsu32_2:	ci	r2,0
		jne	@rsu32_0
rsu32_3:
		rt
rsu32i:
		mov	*r11+,r2
rsu32:
		ci	r2,16
		jlt	@rsu32_2
		mov	r0,r1
		clr	r0
		ai	r2,-16
		jeq	@rsu32_3
		; We know half of the shift so we can do a 16bit
		; shift from hereon in
		; TODO - look at 6803 equivalent tweaks
		mov	r2,r0
		srl	r1,r0
		clr	r0
		rt
