
		.export sub32i

		.code

sub32i:
		c	*r11,@0
		jeq	@sub32i_1
		s	*r11,r1
		jnc	@sub32i_1
		dec	r0
sub32i_1:	inct	r11
		s	*r11+,r0
		rt
