.386
.model flat,c

extern GlChar:BYTE
extern GlShort:WORD
extern GlInt:DWORD
extern GlLong:QWORD

.code
IntegerAddition proc

	push ebp
	mov ebp, esp
	;push ebx
	;push esi
	;push edi

; routine
	mov al,[ebp+8]
	add [GlChar],al

	mov ax,[ebp+12]
	add [GlShort],ax

	mov eax,[ebp+16]
	add [GlInt],eax

	mov eax,[ebp+20]				; addition done in 2 steps: lower and upper 32 bits
	mov edx,[ebp+24]
	add DWORD PTR[GlLong],eax
	adc DWORD PTR[GlLong+4],edx		; includes carry flag set by previous add instruction

	;pop edi
	;pop esi
	;pop ebx
	pop ebp
	ret

IntegerAddition endp
end