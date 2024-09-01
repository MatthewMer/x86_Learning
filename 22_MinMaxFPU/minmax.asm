.model flat,c							; floatingpoint
										; | 31 (sign;1bit) | 30 - 23 (exponent;8bit) | 22 - 0 (mantissa/fraction;23bit) |  (exponent = 0xFF is reserved for NaN)
.const									; -> (-1)^b31      * 2^(b30b29...b23) - 127  * (1.b22b21...b0)					-> (-1)^sign * 2^(E-127) * 1+sum(i=1,23){b(23-i) * 2^(-i)}
r4_minFloat		dword	0ff7fffffh		; Min: 1             1111 1110                 1111 1111 1111 1111 1111 111	    -> -1 * 2^(0xF7 - 127) * (1 + (1/2 + 1/4 + ... + 2^(-23))) = ~ -3.4E+38
r4_maxFloat		dword	7f7fffffh		; Max: 0             1111 1110                 1111 1111 1111 1111 1111 111	    ->  1 * 2^(0xF7 - 127) * (1 + (1/2 + 1/4 + ... + 2^(-23))) = ~  3.4E+38

.code
MinMaxASM	proc
	push ebp
	mov ebp,esp

	xor eax,eax
	xor ecx,ecx
	mov eax,[ebp+8]		; esi = data*
	mov edx,[ebp+12]	; edx = size
	test edx,edx
	jle Done

	fld [r4_minFloat]			; st(2)
	fld [r4_maxFloat]			; st(1)

@@:	fld real4 ptr[eax+ecx*4]
	fld st(0)
	
	fcomi st(0),st(2)			; st(0) < st(i) -> CF = 1
	fcmovnb st(0),st(2)			; CF == 1 ? st(0) = st(i)
	fstp st(2)					; store new min

	fcomi st(0),st(2)			; st(0) < st(i) -> CF = 1
	fcmovb st(0),st(2)			; CF == 0 ? st(0) = st(i)
	fstp st(2)					; store new max

	inc ecx
	cmp ecx,edx
	jl @B

	mov ecx,[ebp+16]
	fstp real4 ptr[ecx]
	mov ecx,[ebp+20]
	fstp real4 ptr[ecx]

Done:
	pop ebp

	ret
MinMaxASM	endp
end