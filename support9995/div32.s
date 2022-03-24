;
;	Core 32bit unsigned division
;

		.export	div32
		.export div32i
		.export	mod32
		.export mod32i

		.code

div32i:
	mov	*r11+,r2
	mov	*r11+,r3
div32:
	dect	r13
	mov	r4,*r13
	dect	r13
	mov	r5,*r13
	dect	r13
	mov	r6,*r13
	dect	r13
	mov	r7,*r13
	li	r6, 32
	clr	r0
	clr	r1
div32op_1:
	; Shift the dividend left
	mov	r2,r7		; save the bit
	sla	r2, 1
	sla	r3, 1
	jnc	div32op_2
	inc	r2
div32op_2:
	inc	r3
	; Shift the working register left
	sla	r0, 1
	sla	r1, 1
	jnc	div32op_3
	inc	r0
div32op_3;
	; capture the old high bit of the dividend into the working register
	andi	r7,1
	a	r7,r1
	; 32bit compare
	c	r0, r4
	jlo	div32op_5
	jhi	div32op_4
	c	r1,r5
	jlo	div32op_5
div32op_4:
	; >=
	inc	r1		; set the low bit of the working reg
	sub	r1, r5		; safe as r1 can't be 0 at this point
	jnc	div32op_5
	sub	r0,r4
div32op_5:
	dec	r6
	jne	@div32op_1
	mov	*r13+,r7
	mov	*r13+,r6
	mov	*r13+,r5
	mov	*r13+,r4
	;	R01 and R23 are the results
	rt

mod32i:
	mov	*r11+,r2
	mov	*r11+,r3
mod32:
	dect	r13
	mov	r11,*r13
	bl	div32
	mov	*r13+,r11
	mov	r2,r0
	mov	r3,r1	
	rt

; The result shall be negative if the signs differ
div32s:
	dect	r13
	mov	r11,*r13
	dect	r13
	mov	r4, *r13
	dect	r13
	mov	r5, *r13
	clr	r5		; sign tracker
	ci	r0, 0
	jge	@div32s_1
	bl	@neg32
	inc	r5		; track sign
div32s_1:
	ci	r2, 0
	jge	@div32s_3
	; Negate r2/r3
	inv	r2
	inv	r3
	inc	r3
	jne	@div32s_2
	inc	r0
div32s_2:
	inc	r5		; track sign
div32s_3:
	bl	@div32
	srl	r5,1
	jnc	div32s_3
	; negate r0/r1
	mov	*r13+,r5
	mov	*r13+,r4
	mov	*r13+,r11
	rt

; Actually remainder for C. The sign shall be the sign of the dividend
mod32s:
	dect	r13
	mov	r11,*r13
	dect	r13
	mov	r4, *r13
	dect	r13
	mov	r5, *r13
	clr	r5		; sign tracker
	ci	r0, 0
	jge	@div32s_1
	bl	@neg32
	; todo - negate r0/r1
	inc	r5		; track sign
mod32s_1:
	bl	@div32
	srl	r5,1
	jnc	mod32s_2
	bl	@neg32
mod32s_2:
	mov	*r13+,r5
	mov	*r13+,r4
	mov	*r13+,r11
	rt

