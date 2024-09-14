.model flat,c

.const
r8_SfFtoC	real8	0.55555556	; 5/9
r8_SfCtoF	real8	1.8			; 9/5
i4_32		dword	32

.code

FtoC	proc
	push ebp
	mov ebp,esp

	fld [r8_SfFtoC]				; load 5/9									; ST(2)
	fld real8 ptr[ebp+8]		; load arg	(f)								; ST(1)
	fild [i4_32]				; load signed int and convert to real8		; ST(0)

	fsubp						; ST(0) = f - 32			(-> ST(0) = ST(i) - ST(0); pop ST(0))
	fmulp						; ST(0) = 5/9 * ST(0)		(-> ST(0) = ST(i) * ST(0); pop ST(0))

	pop ebp
	ret
FtoC	endp

CtoF	proc
	push ebp
	mov ebp,esp

	fild [i4_32]				; load signed int and convert to real8		; ST(2)
	fld real8 ptr[ebp+8]		; load arg	(c)								; ST(1)
	fld [r8_SfCtoF]				; load 9/5									; ST(0)

	fmulp						; ST(0) = 9/5 * c			(-> ST(0)' = ST(i) * ST(0); pop ST(0))
	faddp						; ST(0) = f + 32			(-> ST(0)' = ST(i) + ST(0); pop ST(0))

	pop ebp
	ret
CtoF	endp

end