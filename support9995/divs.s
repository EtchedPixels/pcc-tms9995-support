;
;	Signed divide using div for the TMS9900
;
			.export dodivs
			.export domods
			.code

dodivs:
		mov	r2,r0
		xor	r1,r0
		srl	r0,1
		joc	@negsign
		abs	r2
		abs	r1
		clr	r0
		div	r0,r2
		mov	r0,r1
		rt
negsign:
		abs	r2
		abs	r1
		clr	r0
		div	r0,r2
		mov	r0,r1
		neg	r1
		rt

domods:
		mov	r1,r0
		srl	r0,1
		joc	@negsignm
		abs	r2
		abs	r1
		clr	r0
		div	r0,r2
		rt
negsignm:
		abs	r2
		abs	r1
		clr	r0
		div	r0,r2
		neg	r1
		rt
