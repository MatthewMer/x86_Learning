.model flat,c

.code

OPTION LANGUAGE: syscall		; name mangling (no C symbols) -> Cpp compiler

; mangled name for Cpp compiler
SseAdd equ <?SseAdd@SseVal@@QAEAAV1@ABV1@W4AddOp@1@@Z>
SseAdd		proc
	push ebp
	mov ebp,esp

	mov eax,[ebp+12]			; load op enum
	cmp eax,AddOpTableCount		; compare with table count
	jae Finished				; jump if invalid
	
	mov edx,[ebp+8]				; load address b

	jmp [AddOpTable+eax*4]		; jump to opcode

SseAddss:
	movss xmm0,real4 ptr[ecx]
	movss xmm1,real4 ptr[edx]			; load b
	addss xmm0,xmm1
	movss real4 ptr[ecx],xmm0
	jmp Finished

SseAddsd:
	movsd xmm0,real8 ptr[ecx]
	movsd xmm1,real8 ptr[edx]			; load b
	addsd xmm0,xmm1
	movsd real8 ptr[ecx],xmm0
	jmp Finished

SseAddps:
	movups xmm0,[ecx]
	movups xmm1,[edx]					; load b
	addps xmm0,xmm1
	movups [ecx],xmm0
	jmp Finished

SseAddpd:
	movupd xmm0,[ecx]
	movupd xmm1,[edx]			; load b
	addpd xmm0,xmm1
	movupd [ecx],xmm0
	jmp Finished

Finished:
	mov eax,ecx

	pop ebp
	ret 8

	align 4
AddOpTable:
	dword SseAddss, SseAddsd
	dword SseAddps, SseAddpd

AddOpTableCount equ ($-AddOpTable) / size dword
SseAdd		endp

end