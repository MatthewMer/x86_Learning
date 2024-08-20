; Volume sphere: 4/3 * pi * r^3

.model flat,c

.const
r8_4p0	real8	4.0
r8_3p0	real8	3.0

.code
SphereVolumeASM	proc
	push ebp
	mov ebp, esp
	
	fld real4 ptr[ebp+8]
	fldz 
	fcomip st(0), st(1)
	fstp st(0)

	jp Done		; unordered operand
	ja Done		; r <= 0

	fld real4 ptr[ebp+8]
	fld st(0)
	fmul st(0), st(0)			
	fmulp		; st(0) = r^3
	fldpi
	fmulp		; st(0) = r^3 * pi
	fld r8_4p0
	fmulp
	fld r8_3p0
	fdivp

Done:
	pop ebp
	ret
SphereVolumeASM	endp
end