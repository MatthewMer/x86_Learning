.model flat,c

.const
r4_180Deg	dword	43340000h

; arcsin(x) == arctan(x/(sqrt(1-x**2)))
; phi == atan(y/x)

.code
RectToPolarASM	proc
	push ebp
	mov ebp, esp

	mov eax,[ebp+8]		; src
	mov edx,[ebp+16]	; dest
	mov ecx,[ebp+12]	; size

	test ecx,ecx
	jz Done

@@:	fld real4 ptr[eax+4]	; load y
	fld real4 ptr[eax]		; load x
	fpatan
	fld real4 ptr[r4_180Deg]
	fldpi
	fdivp
	fmulp	
	fstp real4 ptr[edx+4]

	fld real4 ptr[eax+4]
	fmul st(0),st(0)
	fld real4 ptr[eax]
	fmul st(0),st(0)
	faddp
	fsqrt
	fstp real4 ptr[edx]

	add eax,8
	add edx,8
	dec ecx
	jnz @B

Done:
	pop ebp
	ret
RectToPolarASM	endp
end