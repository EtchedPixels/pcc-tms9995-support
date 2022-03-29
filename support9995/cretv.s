		.export cretv
		.export cretv6
		.export cretv7
		.export cretv8
		.export cretv9

		.code

; Helper for some of usual register cases
;
; Vararg version
;
cretv9:
		mov	*r13+,r9
cretv8:
		mov	*r13+,r8
cretv7:
		mov	*r13+,r7
cretv6:
		mov	*r13+,r6
cretv:
		inct	r12
		mov	r12,r13
		mov	*r13+,r12
		mov	*r13+,r11
		inct	r13
		inct	r13
		rt
