.386
.model flat,c

.code

; demonstration of local variable usage

CalculateSum proc
	push ebp			; push old base pointer
	mov ebp,esp			; set current stack pointer as new base pointer
	sub esp,12			; "allocate" 12 bytes
	push ebx			; store remaining non volatile registers

	; load arguments
	mov eax,[ebp+8]
	mov ebx,[ebp+12]
	mov ecx,[ebp+16]
	mov edx,[ebp+20]
	
	; a + b + c
	mov [ebp-12],eax
	add [ebp-12],ebx
	add [ebp-12],ecx

	; a*a + b*b + c*c
	imul eax,eax
	imul ebx,ebx
	imul ecx,ecx
	mov [ebp-8],eax
	add [ebp-8],ebx
	add [ebp-8],ecx

	; a*a + b*b + c*c
	imul eax,[ebp+8]
	imul ebx,[ebp+12]
	imul ecx,[ebp+16]
	mov [ebp-4],eax
	add [ebp-4],ebx
	add [ebp-4],ecx

	; save results
	mov eax,[ebp-12]
	mov [edx],eax
	mov eax,[ebp-8]
	mov [edx+4],eax
	mov eax,[ebp-4]
	mov [edx+8],eax

	pop ebx
	mov esp,ebp
	pop ebp

	ret

CalculateSum endp
end