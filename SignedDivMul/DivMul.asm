.386
.model flat,c

.code
;return :		0 Error (Div by 0)
;				1 Success
; Computation :	*prod = a*b
;				*quo = a/b
;				*rem = a%b
				
IntegerMulDiv proc
	; init stack frame
	push ebp
	mov ebp, esp
	push ebx

	xor eax,eax

	mov ecx,[ebp+8]		;a
	mov edx,[ebp+12]	;b

	or edx,edx			;check for divisor == 0
	jz InvalidDivisor

	imul edx,ecx
	mov ebx,[ebp+16]	;prod
	mov [ebx],edx

	mov eax,ecx			;eax = a
	cdq					;edx:eax contains dividend -> cdq sign extends eax (for idiv)
	idiv DWORD PTR[ebp+12]

	mov ebx,[ebp+20]
	mov [ebx],eax
	mov ebx,[ebp+24]
	mov [ebx],edx

	mov eax,1

InvalidDivisor:
	pop ebx
	pop ebp

	ret
IntegerMulDiv endp
end