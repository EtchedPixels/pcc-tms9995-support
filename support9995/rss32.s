
		.export rss32
		.export	rss32i

		.code

;
;	TODO: add fast paths for >= 16 bit case (needs sign handling though)
;
rss32_0:
		sra	r1,1
		joc	@rss32_1
		sra	r0,1
		jmp	@rss32
rss32_1:	sra	r0,1
		ai	r0,0x8000
rss32:		dec	r2
		jnc	@rss32_0
		rt
rss32i:		mov	*r11+,r2
		jmp	@rss32
