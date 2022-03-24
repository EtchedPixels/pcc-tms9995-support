
		.export sub32

		.code

sub32:
		ci	r3,0
		jeq	@sub32_1
		s	r3,r1
		jnc	@sub32_1
		dec	r0
sub32_1:	s	r2,r0
		rt



