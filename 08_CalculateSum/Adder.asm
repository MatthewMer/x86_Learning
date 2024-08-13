.386
.model flat,c
.code

AdderASM proc
	; init stack frame
	push ebp
	mov ebp,esp
	
	; procedure
	mov eax,[ebp+8]
	mov ecx,[ebp+12]
	mov edx,[ebp+16]

	add eax,ecx
	add eax,edx

	; deinit stack frame
	pop ebp
	ret

AdderASM endp
end