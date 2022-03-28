
		.export _memcpy

		.code
;
;	This is complicated on a word based machine.
;
;	On entry  *sp = dest, @2(sp) = source @4(sp) = length
;
_memcpy:
		; r0 = dest, r1 = source, r2 = count, r3 scratch
		mov	*r13,r0
		mov	@2(r13),r1
		mov	@4(r13),r2
		xor	@2(r13),r3
		; check alignment between pointers
		mov	r0,r3
		srl	r3,1
		joc	@not_aligned
		; same alignment
		; check if they are odd or even aligned
		srl	r0,1
		joc	@byte_first
		mov	*r13,r0
		;
		;	Even alignment
		;
memcpy_aligned:
		;
		;	Check sizing
		;
		mov	r2,r3
		srl	r3,1
		joc	@memcpy_wb

;
;	Case 1: 	word aligned word sized
;
memcpy_w1:	
		mov	*r1+,*r0+
		dect	r2
		jne	@memcpy_w1
		mov	*r13,r1
		rt
;
;	Case 2:		word aligned odd sized
;
memcpy_wb:
		mov	*r1+,*r0+
		dec	r2
		jne	@memcpy_w1
		movb	*r1,*r0
		mov	*r13,r1
		rt
;
;	Case 3:		both halves misaligned
;
byte_first:
		mov	*r13,r0
		movb	*r1+,*r0+
		dec	r2
		;
		;	Do one byte then turns into case 1 or 2
		;
		jmp	@memcpy_aligned
;
;	Unaligned copy. We could optimise this case with swpb tricks
;	but for now don't bother. It should be rare with luck
;
not_aligned:
		movb	*r1+,*r0+
		dec	r2
		jne	@not_aligned
		mov	*r13, r1
		rt
