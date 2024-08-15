.386
.model flat,c

.code
CountChar	proc
	push ebp
	mov ebp,esp
	push ebx
	push esi
	push edi

	xor ebx,ebx
	mov esi,[ebp+8]
	mov cl,[ebp+12]

@@:	lodsb			; load string (bytes) in eax from [esi] and ++esi
	or al,al
	jz @F
	cmp al,cl
	jnz @B
	inc ebx
	jmp @B

@@:	mov eax,ebx

	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
CountChar	endp
end