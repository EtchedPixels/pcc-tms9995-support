
		.export rss32
		.export	rss32i

		.code

;
;	TODO: add fast paths for >= 16 bit case (needs sign handling though)
;
;	Manual says sra seta carry to the last bit shifted out but
;	that seems to fail on the emulator at least.
;
rss32_0:
		dec	r2
		sra	r0,1
		joc	@rss32_1
		srl	r1,1
		jmp	@rss32_2
rss32_1:	srl	r1,1
		ai	r1,0x8000
rss32_2:	ci	r2,0
		jne	@rss32_0
rss32_3:
		rt

		; Optimizations
		; 1. If the value is positive then do an unsigned shift
rss32i:
		mov	*r11+,r2
rss32:		ci	r0,0x8000
		jhe	@rss32_4
		b	@rsu32
rss32_4:
		; 2. If the value is > 16bit shift then do a mov and a 16bit
		; shift instead
		ci	r2,16
		jlt	@rss32_2
		mov	r0,r1
		mov	r2,r0
		ai	r2,-16
		jeq	@rss32_3
		sra	r1,r0
		li	r0,0xFFFF	; sign extend as know negative
		rt
