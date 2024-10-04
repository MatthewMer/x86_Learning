.model flat,c

.data


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

; mangled name for Cpp compiler
SseSub equ <?SseSub@SseVal@@QAEAAV1@ABV1@W4SubOp@1@@Z>
SseSub		proc
	push ebp
	mov ebp,esp

	mov eax,[ebp+12]			; load op enum
	cmp eax,SubOpTableCount		; compare with table count
	jae Finished				; jump if invalid
	
	mov edx,[ebp+8]				; load address b

	jmp [SubOpTable+eax*4]		; jump to opcode

SseSubss:
	movss xmm0,real4 ptr[ecx]
	movss xmm1,real4 ptr[edx]			; load b
	subss xmm0,xmm1
	movss real4 ptr[ecx],xmm0
	jmp Finished

SseSubsd:
	movsd xmm0,real8 ptr[ecx]
	movsd xmm1,real8 ptr[edx]			; load b
	subsd xmm0,xmm1
	movsd real8 ptr[ecx],xmm0
	jmp Finished

SseSubps:
	movups xmm0,[ecx]
	movups xmm1,[edx]					; load b
	subps xmm0,xmm1
	movups [ecx],xmm0
	jmp Finished

SseSubpd:
	movupd xmm0,[ecx]
	movupd xmm1,[edx]			; load b
	subpd xmm0,xmm1
	movupd [ecx],xmm0
	jmp Finished

Finished:
	mov eax,ecx

	pop ebp
	ret 8

	align 4
SubOpTable:
	dword SseSubss, SseSubsd
	dword SseSubps, SseSubpd

SubOpTableCount equ ($-SubOpTable) / size dword
SseSub		endp

; mangled name for Cpp compiler
SseMul equ <?SseMul@SseVal@@QAEAAV1@ABV1@W4MulOp@1@@Z>
SseMul		proc
	push ebp
	mov ebp,esp

	mov eax,[ebp+12]			; load op enum
	cmp eax,MulOpTableCount		; compare with table count
	jae Finished				; jump if invalid
	
	mov edx,[ebp+8]				; load address b

	jmp [MulOpTable+eax*4]		; jump to opcode

SseMulss:
	movss xmm0,real4 ptr[ecx]
	movss xmm1,real4 ptr[edx]			; load b
	mulss xmm0,xmm1
	movss real4 ptr[ecx],xmm0
	jmp Finished

SseMulsd:
	movsd xmm0,real8 ptr[ecx]
	movsd xmm1,real8 ptr[edx]			; load b
	mulsd xmm0,xmm1
	movsd real8 ptr[ecx],xmm0
	jmp Finished

SseMulps:
	movups xmm0,[ecx]
	movups xmm1,[edx]					; load b
	mulps xmm0,xmm1
	movups [ecx],xmm0
	jmp Finished

SseMulpd:
	movupd xmm0,[ecx]
	movupd xmm1,[edx]			; load b
	mulpd xmm0,xmm1
	movupd [ecx],xmm0
	jmp Finished

Finished:
	mov eax,ecx

	pop ebp
	ret 8

	align 4
MulOpTable:
	dword SseMulss, SseMulsd
	dword SseMulps, SseMulpd

MulOpTableCount equ ($-MulOpTable) / size dword
SseMul		endp

; mangled name for Cpp compiler
SseDiv equ <?SseDiv@SseVal@@QAEAAV1@ABV1@W4DivOp@1@@Z>
SseDiv		proc
	push ebp
	mov ebp,esp

	mov eax,[ebp+12]			; load op enum
	cmp eax,DivOpTableCount		; compare with table count
	jae Finished				; jump if invalid
	
	mov edx,[ebp+8]				; load address b

	jmp [DivOpTable+eax*4]		; jump to opcode

SseDivss:
	movss xmm0,real4 ptr[ecx]
	movss xmm1,real4 ptr[edx]			; load b
	divss xmm0,xmm1
	movss real4 ptr[ecx],xmm0
	jmp Finished

SseDivsd:
	movsd xmm0,real8 ptr[ecx]
	movsd xmm1,real8 ptr[edx]			; load b
	divsd xmm0,xmm1
	movsd real8 ptr[ecx],xmm0
	jmp Finished

SseDivps:
	movups xmm0,[ecx]
	movups xmm1,[edx]					; load b
	divps xmm0,xmm1
	movups [ecx],xmm0
	jmp Finished

SseDivpd:
	movupd xmm0,[ecx]
	movupd xmm1,[edx]			; load b
	divpd xmm0,xmm1
	movupd [ecx],xmm0
	jmp Finished

Finished:
	mov eax,ecx

	pop ebp
	ret 8

	align 4
DivOpTable:
	dword SseDivss, SseDivsd
	dword SseDivps, SseDivpd

DivOpTableCount equ ($-DivOpTable) / size dword
SseDiv		endp

; mangled name for Cpp compiler
SseMin equ <?SseMin@SseVal@@QAEAAV1@ABV1@W4MinOp@1@@Z>
SseMin		proc
	push ebp
	mov ebp,esp

	mov eax,[ebp+12]			; load op enum
	cmp eax,MinOpTableCount		; compare with table count
	jae Finished				; jump if invalid
	
	mov edx,[ebp+8]				; load address b

	jmp [MinOpTable+eax*4]		; jump to opcode

SseMinss:
	movss xmm0,real4 ptr[ecx]
	movss xmm1,real4 ptr[edx]			; load b
	minss xmm0,xmm1
	movss real4 ptr[ecx],xmm0
	jmp Finished

SseMinsd:
	movsd xmm0,real8 ptr[ecx]
	movsd xmm1,real8 ptr[edx]			; load b
	minsd xmm0,xmm1
	movsd real8 ptr[ecx],xmm0
	jmp Finished

SseMinps:
	movups xmm0,[ecx]
	movups xmm1,[edx]					; load b
	minps xmm0,xmm1
	movups [ecx],xmm0
	jmp Finished

SseMinpd:
	movupd xmm0,[ecx]
	movupd xmm1,[edx]			; load b
	minpd xmm0,xmm1
	movupd [ecx],xmm0
	jmp Finished

Finished:
	mov eax,ecx

	pop ebp
	ret 8

	align 4
MinOpTable:
	dword SseMinss, SseMinsd
	dword SseMinps, SseMinpd

MinOpTableCount equ ($-MinOpTable) / size dword
SseMin		endp

; mangled name for Cpp compiler
SseMax equ <?SseMax@SseVal@@QAEAAV1@ABV1@W4MaxOp@1@@Z>
SseMax		proc
	push ebp
	mov ebp,esp

	mov eax,[ebp+12]			; load op enum
	cmp eax,MaxOpTableCount		; compare with table count
	jae Finished				; jump if invalid
	
	mov edx,[ebp+8]				; load address b

	jmp [MaxOpTable+eax*4]		; jump to opcode

SseMaxss:
	movss xmm0,real4 ptr[ecx]
	movss xmm1,real4 ptr[edx]			; load b
	maxss xmm0,xmm1
	movss real4 ptr[ecx],xmm0
	jmp Finished

SseMaxsd:
	movsd xmm0,real8 ptr[ecx]
	movsd xmm1,real8 ptr[edx]			; load b
	maxsd xmm0,xmm1
	movsd real8 ptr[ecx],xmm0
	jmp Finished

SseMaxps:
	movups xmm0,[ecx]
	movups xmm1,[edx]					; load b
	maxps xmm0,xmm1
	movups [ecx],xmm0
	jmp Finished

SseMaxpd:
	movupd xmm0,[ecx]
	movupd xmm1,[edx]			; load b
	maxpd xmm0,xmm1
	movupd [ecx],xmm0
	jmp Finished

Finished:
	mov eax,ecx

	pop ebp
	ret 8

	align 4
MaxOpTable:
	dword SseMaxss, SseMaxsd
	dword SseMaxps, SseMaxpd

MaxOpTableCount equ ($-MaxOpTable) / size dword
SseMax		endp

; mangled name for Cpp compiler
SseSqrt equ <?SseSqrt@SseVal@@QAEAAV1@W4SqrtOp@1@@Z>
SseSqrt		proc
	push ebp
	mov ebp,esp

	mov eax,[ebp+8]			; load op enum
	cmp eax,SqrtOpTableCount		; compare with table count
	jae Finished				; jump if invalid

	jmp [SqrtOpTable+eax*4]		; jump to opcode

SseSqrtss:
	movss xmm0,real4 ptr[ecx]
	sqrtss xmm1,xmm0
	movss real4 ptr[ecx],xmm1
	jmp Finished

SseSqrtsd:
	movsd xmm0,real8 ptr[ecx]
	sqrtsd xmm1,xmm0
	movsd real8 ptr[ecx],xmm1
	jmp Finished

SseSqrtps:
	movups xmm0,[ecx]
	sqrtps xmm1,xmm0
	movups [ecx],xmm1
	jmp Finished

SseSqrtpd:
	movupd xmm0,[ecx]
	sqrtpd xmm1,xmm0
	movupd [ecx],xmm1
	jmp Finished

Finished:
	mov eax,ecx

	pop ebp
	ret 4

	align 4
SqrtOpTable:
	dword SseSqrtss, SseSqrtsd
	dword SseSqrtps, SseSqrtpd

SqrtOpTableCount equ ($-SqrtOpTable) / size dword
SseSqrt		endp

; mangled name for Cpp compiler
SseAnd equ <?SseAnd@SseVal@@QAEAAV1@W4AndOp@1@@Z>
SseAnd		proc
	push ebp
	mov ebp,esp

	mov eax,[ebp+8]			; load op enum
	cmp eax,AndOpTableCount		; compare with table count
	jae Finished				; jump if invalid

	jmp [AndOpTable+eax*4]		; jump to opcode

SseAndps:
	movups xmm0,[ecx]
	andps xmm1,xmm0
	movups [ecx],xmm1
	jmp Finished

SseAndpd:
	movupd xmm0,[ecx]
	andpd xmm1,xmm0
	movupd [ecx],xmm1
	jmp Finished

SseAndnps:
	movups xmm0,[ecx]
	andnps xmm1,xmm0
	movups [ecx],xmm1
	jmp Finished

SseAndnpd:
	movupd xmm0,[ecx]
	andnpd xmm1,xmm0
	movupd [ecx],xmm1
	jmp Finished

Finished:
	mov eax,ecx

	pop ebp
	ret 4

	align 4
AndOpTable:
	dword SseAndps, SseAndpd
	dword SseAndnps, SseAndnpd

AndOpTableCount equ ($-AndOpTable) / size dword
SseAnd		endp

OPTION LANGUAGE: C
end