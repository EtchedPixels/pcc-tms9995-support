
			.export	_strlen
			.code

; On entry r4 is the pointer
_strlen:
		clr	r1
strlenlp:	movb	*r4+,r2
		jeq	@strlen_end
		inc	r1
		jmp 	@strlenlp
strlen_end:	rt
