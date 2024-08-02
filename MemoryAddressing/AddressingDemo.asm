.386
.model flat,c

.const

FibVals DWORD 0,1,1,2,3,5,8,13,21
		DWORD 34,55,89,144,233,377,610

NumFibVals DWORD($-FibVals)/sizeof DWORD
public NumFibVals

.code
AddressingDemo proc
	push ebp
	mov ebp,esp
	push ebx
	push esi
	push edi

	xor eax,eax
	mov ecx,[ebp+8]
	cmp ecx,0
	jl InvalidIndex
	cmp ecx,[NumFibVals]
	jge InvalidIndex

; result 1 - base register
	mov ebx,OFFSET FibVals	; base offset
	mov esi,[ebp+8]			; passed index i
	shl esi,2				; i*4 -> offset in bytes
	add ebx,esi				; address at index
	mov eax,[ebx]			; get value
	mov edi,[ebp+12]		; address v1
	mov [edi],eax			; store result

; result 2 - base register + displacement
	mov esi,[ebp+8]			; passed index i
	shl esi,2				; i*4
	mov eax,[esi+FibVals]	; value at offset FibVals + i*4
	mov edi,[ebp+12]		; address v2
	add edi,4
	mov [edi],eax			; store result

; result 3 - base register + index register
	mov ebx,OFFSET FibVals	; base offset
	mov esi,[ebp+8]			; passed index i
	shl esi,2				; i*4
	mov eax,[ebx+esi]		; base offset + index reg
	mov edi,[ebp+12]		; address v3
	add edi,8
	mov [edi],eax			; store result

; result 4 - base register + index register * scale factor
	mov ebx,OFFSET FibVals	; base offset
	mov esi,[ebp+8]			; passed index i
	mov eax,[ebx+esi*4]		; base offset + index reg * scale factor
	mov edi,[ebp+12]		; address v4
	add edi,12
	mov [edi],eax			; store result

	mov eax,1

InvalidIndex:
	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
AddressingDemo endp
end