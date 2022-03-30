
		.export _memcpy

		.code
;
;	This is complicated on a word based machine.
;
;	On entry  r4 = dest, r5 = source @(sp) = length
;
_memcpy:
		; r4 = dest, r5 = source, r2 = count, r0, r3 scratch
		mov	*r13,r2
		mov	r4,r0
		mov	r4,r1		; return code is always dest
		xor	r5,r0
		; check alignment between pointers
		mov	r0,r3
		srl	r3,1
		joc	@not_aligned
		; same alignment
		; check if they are odd or even aligned
		mov	r4,r0
		srl	r0,1
		joc	@byte_first
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
		mov	*r5+,*r4+
		dect	r2
		jne	@memcpy_w1
		rt
;
;	Case 2:		word aligned odd sized
;
memcpy_wb:
		mov	*r5+,*r4+
		dect	r2
		jne	@memcpy_wb
		movb	*r5,*r4
		rt
;
;	Case 3:		both halves misaligned
;
byte_first:
		movb	*r5+,*r4+
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
		movb	*r5+,*r4+
		dec	r2
		jne	@not_aligned
		rt
