.model flat,c

.code
SignedMinA	proc
	push ebp
	mov ebp,esp

	mov eax,[ebp+8]		; a
	mov ecx,[ebp+12]	; b

	cmp eax,ecx
	jle @F				; jump to nearest @@
	mov eax,ecx

@@:	mov ecx,[ebp+16]	; c
	cmp eax,ecx
	jle @F
	mov eax,ecx

@@:	pop ebp
	ret
SignedMinA	endp

SignedMaxA	proc
	push ebp
	mov ebp,esp

	mov eax,[ebp+8]		; a
	mov ecx,[ebp+12]	; b

	cmp eax,ecx
	jge @F				; jump to nearest @@
	mov eax,ecx

@@:	mov ecx,[ebp+16]	; c
	cmp eax,ecx
	jge @F
	mov eax,ecx

@@:	pop ebp
	ret
SignedMaxA	endp

SignedMinB	proc
	push ebp
	mov ebp,esp

	mov eax,[ebp+8]		; a
	mov ecx,[ebp+12]	; b

	cmp eax,ecx
	cmovg eax,ecx		; for signed ints (cmova for unsigned ints)

	mov ecx,[ebp+16]	; c
	cmp eax,ecx
	cmovg eax,ecx

	pop ebp
	ret
SignedMinB	endp

SignedMaxB	proc
	push ebp
	mov ebp,esp

	mov eax,[ebp+8]		; a
	mov ecx,[ebp+12]	; b

	cmp eax,ecx
	cmovl eax,ecx		; for signed ints (cmovb for unsigned ints)

	mov ecx,[ebp+16]	; c
	cmp eax,ecx
	cmovl eax,ecx

	pop ebp
	ret
SignedMaxB	endp
end