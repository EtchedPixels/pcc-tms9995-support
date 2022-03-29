
		.export cret
		.export cret6
		.export cret7
		.export cret8
		.export cret9

		.code

; Helper for some of usual register cases
cret9:
		mov	*r13+,r9
cret8:
		mov	*r13+,r8
cret7:
		mov	*r13+,r7
cret6:
		mov	*r13+,r6
cret:
		inct	r12
		mov	r12,r13
		mov	*r13+,r12
		mov	*r13+,r11
		rt
