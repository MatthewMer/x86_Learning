.386
.model flat,c

.code

; demonstration of local variable usage

; __cdecl: 
;			- caller pushes arguments in reverse order onto the stack
;			- callee just returns at end of procedure
;			-> caller is expected to pop the arguments from the stack
Caller_cdecl		proc
	push ebp
	mov ebp,esp
	push ebx
	push esi
	push edi

	push dword ptr[ebp+24]
	push dword ptr[ebp+20]
	push dword ptr[ebp+16]
	push dword ptr[ebp+12]
	call dword ptr[ebp+8]
	add esp,16

	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
Caller_cdecl		endp

CalculateSum_cdecl	proc
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
CalculateSum_cdecl endp

; __stdcall: 
;			- caller pushes arguments in reverse order onto the stack
;			- callee returns at end of procedure and pops arguments from stack
;			-> callee is expected to pop the arguments from the stack
Caller_stdcall		proc
	push ebp
	mov ebp,esp
	push ebx
	push esi
	push edi

	push dword ptr[ebp+24]
	push dword ptr[ebp+20]
	push dword ptr[ebp+16]
	push dword ptr[ebp+12]
	call dword ptr[ebp+8]

	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
Caller_stdcall		endp

CalculateSum_stdcall@16 proc
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

	; a*a*a + b*b*b + c*c*c
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

	ret 16
CalculateSum_stdcall@16 endp

; __fastcall: 
;			- caller passes first 2 arguments in registers ECX,EDX (left to right) (if fit -> 32 bit)
;			- pushes remaining arguments in reverse order onto the stack
;			-> callee manages arguments on stack
Caller_fastcall		proc
	push ebp
	mov ebp,esp
	push ebx
	push esi
	push edi

	mov ecx, dword ptr[ebp+12]		; a
	mov edx, dword ptr[ebp+16]		; b
	push dword ptr[ebp+24]
	push dword ptr[ebp+20]
	call dword ptr[ebp+8]

	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
Caller_fastcall		endp

OPTION LANGUAGE: syscall			;  directive avoids automatic prefixing of function names with '_' -> required for C compiler symbols
@CalculateSum_fastcall@16 proc
	push ebp			; push old base pointer
	mov ebp,esp			; set current stack pointer as new base pointer
	sub esp,12			; "allocate" 12 bytes
	push ebx			; store remaining non volatile registers
	push edi

	; load remaining arguments
	mov eax,[ebp+8]		; c
	
	; a + b + c
	mov [ebp-12],ecx
	add [ebp-12],edx
	add [ebp-12],eax

	; a*a + b*b + c*c
	mov ebx,ecx
	mov edi,edx

	imul ecx,ecx
	imul edx,edx
	imul eax,eax

	mov [ebp-8],ecx
	add [ebp-8],edx
	add [ebp-8],eax

	; a*a*a + b*b*b + c*c*c
	imul ecx,ebx
	imul edx,edi
	imul eax,[ebp+8]

	mov [ebp-4],ecx
	add [ebp-4],edx
	add [ebp-4],eax

	; save results
	mov edi,[ebp+12]

	mov eax,[ebp-12]
	mov [edi],eax
	mov eax,[ebp-8]
	mov [edi+4],eax
	mov eax,[ebp-4]
	mov [edi+8],eax

	pop edi
	pop ebx
	mov esp,ebp
	pop ebp

	ret 8
@CalculateSum_fastcall@16 endp
OPTION LANGUAGE: C

end