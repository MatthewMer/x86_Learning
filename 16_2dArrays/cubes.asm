.model flat,c

.code
CalcArrayCubeASM	proc
	push ebp
	mov ebp,esp
	push ebx
	push esi
	push edi

	xor eax,eax

	cmp dword ptr[ebp+16],0
	jle Epilog

	cmp dword ptr[ebp+20],0
	jle Epilog

	mov edx,[ebp+8]		; src. array
	mov ecx,[ebp+12]	; dest. array

	xor esi,esi			; i = 0
	xor edi,edi

L1:	shl edi,2
	add ecx,edi
	add edx,edi
	xor edi,edi			; j = 0

L2:	mov ebx,[edx+edi*4]
	push ecx
	mov ecx,2
C1:	imul ebx,[edx+edi*4]
	dec ecx
	cmp ecx,0
	jg C1
	pop ecx
	add eax,ebx
	mov [ecx+edi*4],ebx

	inc edi				; ++j
	cmp edi,[ebp+20]
	jl L2

	inc esi				; ++i
	cmp esi,[ebp+16]
	jl L1

Epilog:
	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
CalcArrayCubeASM endp
end