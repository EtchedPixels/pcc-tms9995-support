
		.export ls32
		.export	ls32i

		.code

;
;	Fast paths for 16bit shift.
;
ls32_0:
		dec	r2
		sla	r1,1
		joc	@ls32_1
		sla	r0,1
		jmp	@ls32
ls32_1:		sla	r0,1
		inc	r0
ls32_2:		ci	r2,0
		jne	@ls32_0
ls32_3:
		rt
ls32i:
		mov	*r11+,r2
ls32:
		ci	r2,16
		jlt	@ls32_2
		mov	r1,r0
		clr	r1
		ai	r2,-16
		jeq	@ls32_3
		mov	r0,r1
		mov	r2,r0
		sla	r1,r0
		mov	r1,r0
		rt
