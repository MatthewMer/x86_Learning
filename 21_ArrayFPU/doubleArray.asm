.model flat,c

.code
CalcMeanStdevASM	proc
	push ebp
	mov ebp,esp
	push ebx
	push esi

	mov ecx,[ebp+12]	; count
	cmp ecx,1
	jle Error
	
	mov ebx,[ebp+8]		; src
	xor esi,esi

	fldz
@@:	fadd real8 ptr[ebx+esi*8]

	inc esi
	cmp esi,ecx
	jl @B

	fild dword ptr[ebp+12]
	fdivp

	mov esi,[ebp+16]
	fst real8 ptr[esi]

	xor esi,esi

	fldz
@@:	fld real8 ptr[ebx+esi*8]
	fsub st(0),st(2)
	fmul st(0),st(0)
	faddp

	inc esi
	cmp esi,ecx
	jl @B

	fild dword ptr[ebp+12]
	fld1
	fsubp
	fdivp
	fsqrt

	mov esi,[ebp+20]
	fstp real8 ptr[esi]

	fstp st(0)

	mov eax,1
	jmp Done

Error:
	xor eax,eax

Done:
	pop esi
	pop ebx
	pop ebp
	ret
CalcMeanStdevASM	endp
end