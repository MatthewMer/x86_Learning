.model flat,c

.code
CalcSquaresASM	proc
	push ebp
	mov ebp,esp
	push ebx
	push esi
	push edi

	; load args
	mov esi,[ebp+8]			; source
	mov edi,[ebp+12]		; dest
	mov ecx,[ebp+16]		; length

	xor eax,eax
	cmp ecx,0				; check array length
	jle EmptyArray
	shl ecx,2				; adjust for counter (4 bytes per int)
	xor ebx,ebx

@@:	mov edx,[esi+ebx]		; load source array element
	imul edx,edx			; square
	mov [edi+ebx],edx		; store to des array
	add eax,edx				; add to accumulator (return value)
	add ebx,4				; update counter
	cmp ebx,ecx				; compare counter
	jl @B

EmptyArray:
	pop edi
	pop esi
	pop ebx
	pop ebp

	ret
CalcSquaresASM	endp
end