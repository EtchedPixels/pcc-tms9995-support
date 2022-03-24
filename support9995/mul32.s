;
;	32bit x 32bit mpytiply using 16x16 to 32bit mpytiply hardware
;
		.export	mul32
		.export mul32i

		.code
;
;		R0R1	x 	R2R3
;
mul32:
;
;		The maths is
;
;		R1 * R3 +
;		(R0 * R3) << 16 +
;		(R1 * R2) << 16 +
;		(R0 * R3) << 32		(not needed - all overflows)
;
		dect	r13
		mov	r2, *r13
		dect	r13
		mov	r3, *r13
mul32_1:
		dect	r13
		mov	r4, *r13
		inc	r13
		mov	r5, *r13

		mov	r3, r5		; save R3

		; R1 * R3	destroys R3
		mpy	r1,r3	; r3, r4 is now the result

		; R1 * R2	destroys R2, R1
		mpy	r2, r1	; r2 * r1 into r1:r2 
		a	r2, r3	; r3, r4 is now the result

		; R0 * R3	recover R3 into R1
		mov	r5, r1
		mpy	r1, r0	; r0, r1 is result
		a	r1, r3	; r1,r4 is the result


		mov	r3, r0
		mov	r4, r1

		mov	*r13+, r5
		mov	*r13+, r4
		mov	*r13+, r3
		mov	*r13+, r2
		rt

mul32i:
		dect	r13
		mov	r2,*r13
		dect	r13
		mov	r3,*r13
		mov	*r11+,r2
		mov	*r11+,r3
		jmp	@mul32_1
