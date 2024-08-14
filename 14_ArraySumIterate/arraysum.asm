.model flat,c

.code
CalcArraySumASM		proc
	push ebp;
	mov ebp,esp

	mov edx,[ebp+8]		; ptr
	mov ecx,[ebp+12]	; size
	xor eax,eax

	cmp ecx,0
	jle InvalidSize

@@:	add eax,[edx]		; next element
	add edx,4			; increment address
	dec ecx				; adjust counter
	jnz @B				; backwards next @@ label

InvalidSize:
	pop ebp

	ret
CalcArraySumASM		endp
end