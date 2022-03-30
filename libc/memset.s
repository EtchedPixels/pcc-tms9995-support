
			.export _memset
			.code

;
;	memset has an int sized pattern that is byte written. With the
;	TMS99xx oddity about bytes that means we need to swpb it
;
;
;		On entry r4 = dest r5 = pattern @r13 = count
_memset:
		mov	*r13,r3
		mov	r4,r1		; return code
		jeq	@memsetdone
		swpb	r5
		; We could do word optimisations here TODO
memsetlp:	movb	r5,*r4+
		dec	r3
		jne	@memsetlp
memsetdone:	rt
