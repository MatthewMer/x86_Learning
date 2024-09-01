.model flat,c

.code
leastSquares	proc
	push ebp
	mov ebp,esp

	xor eax,eax
	mov edx,[ebp+8]
	mov ecx,[ebp+12]
	test ecx,ecx
	jle Done

	fldz
	fldz
@@:	fild dword ptr[edx]
	faddp st(2),st(0)

	fld real4 ptr[edx+4]
	faddp

	add edx,8
	dec ecx
	jnz @B

	fild dword ptr[ebp+12]
	fdiv st(2),st(0)
	fdivp

	mov edx,[ebp+8]
	mov ecx,[ebp+12]

	fldz
	fldz
@@:	fild dword ptr[edx]
	fsub st(0),st(4)		; x - x_avg
	fld st(0)
	fmul st(1),st(0)		; (x - x_avg)**2
	fld real4 ptr[edx+4]
	fsub st(0),st(5)		; y - y_avg
	fmulp
	faddp st(3),st(0)
	faddp

	add edx,8
	dec ecx
	jnz @B

	fdivp

	mov edx,[ebp+16]
	fst real4 ptr[edx]

	fmulp st(2),st(0)
	fsubp st(1),st(0)

	mov edx,[ebp+20]
	fstp real4 ptr[edx]

	mov eax,1	
Done:
	pop ebp
	ret
	
leastSquares	endp
end