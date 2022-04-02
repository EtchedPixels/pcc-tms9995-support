;
;	Simple dumb video console for 32 character wide mode
;
		.export _putchar

		.code

_putchar:
	cb	r4,@__litb_10
	jeq	@putnl
	cb	r4,@__litb_13
	jeq	@putcr
	mov	@spos,r0
	ci	r0,0x300
	jeq	@scroll_first
plotit:
	mov	r4,r1
	inc	@spos
	blwp	@0x6024
	rt

scroll_first:
	mov	r11,r3
	bl	@scroll
	mov	@spos,r0
	jmp	@plotit
putcr:
	mov	@spos,r0
	andi	r0,0xFFE0		; lose x bits
putdone:
	mov	r0,@spos
	rt
putnl:
	mov	@spos,r0
	ai	r0,0x0020
	ci	r0, 0x300
	jl	@putdone
	ai	r0,-0x20
	mov	r0,@spos

scroll:	li	r1,buf
	li	r2,0x20			; hardcoded width
	mov	r2,r0			; start from line 1
scrollnext:
	blwp	@0x6030			; fetch 32 bytes
	ai	r0,-0x20
	blwp	@0x6028			; paste the back 32 bytes up
	ai	r0,0x40			; next line
	ci	r0,0x300		; end ?
	jlt	@scrollnext
	ai	r0,-0x20
	li	r1,0x2000		; space
wipenext:
	blwp	@0x6024
	inc	r0
	ci	r0,0x300
	jne	@wipenext
	rt

	.bss
buf:	.ds	32
