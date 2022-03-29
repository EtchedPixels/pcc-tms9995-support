;
;	Entry functions. We pay a very small cost for these but it saves
;	a lot of space


		.code
		.export center_r
		.export	center
		.export center0_r
		.export center0
		.export center2_r
		.export center2
;
;	Uses r6 or r7, arbitrary size
;
;	called with
;	mov	r11,r0
;	bl	@center_r
;	.word	-(size + 2)
;

center_r:
	dect	r13
	mov	*r11+,r1
	mov	r0,*r13
	dect	r13
	mov	r12,*r13
	mov	r13,r12
	a	r1,r13		; size + 2 (negative)
	dect	r12
	mov	r6,*r13
	dect	r13
	mov	r7,*r13
	rt

;
;	No r6 or r7, arbitrary size
;
;	called with
;	mov	r11,r0
;	bl	@center_r
;	.word	-size
;
center:
	dect	r13
	mov	*r11+,r1
	mov	r0,*r13
	dect	r13
	mov	r12,*r13
	mov	r13,r12
	a	r1,*r13		; size (negative)	
	dect	r12
	rt

;
;	Uses r6 or r7, zero size
;
;	called with
;	mov	r11,r0
;	bl	@center0_r
;

center0_r:
	dect	r13
	mov	r0,*r13
	dect	r13
	mov	r12,*r13
	mov	r13,r12
	dect	r12
	dect	r13
	mov	r6,*r13
	dect	r13
	mov	r7,*r13
	rt

;
;	No r6 or r7, zero size
;
;	called with
;	mov	r11,r0
;	bl	@center0
;
center0:
	dect	r13
	mov	r0,*r13
	dect	r13
	mov	r12,*r13
	mov	r13,r12
	dect	r12
	rt

;
;	Uses r6 or r7, zero size
;
;	called with
;	mov	r11,r0
;	bl	@center2_r
;

center2_r:
	dect	r13
	mov	r0,*r13
	dect	r13
	mov	r12,*r13
	dect	r13
	mov	r13,r12
	dect	r13
	mov	r6,*r13
	dect	r13
	mov	r7,*r13
	rt

;
;	No r6 or r7, zero size
;
;	called with
;	mov	r11,r0
;	bl	@center2
;
center2:
	dect	r13
	mov	r0,*r13
	dect	r13
	mov	r12,*r13
	dect	r13
	mov	r13,r12
	rt
