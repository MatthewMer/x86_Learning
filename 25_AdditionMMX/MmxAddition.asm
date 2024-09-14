.model flat,c
.code

MmxAdd		proc
	push ebp
	mov ebp,esp

	mov eax,[ebp+24]			; load op enum
	cmp eax,AddOpTableCount		; compare with table count
	jae BadAddOp				; jump if invalid
	
	movq mm0,[ebp+8]			; load a
	movq mm1,[ebp+16]			; load b

	jmp [AddOpTable+eax*4]		; jump to opcode (-> symbol at index)

MmxPaddb:
	paddb mm0,mm1
	jmp StoreResult

MmxPaddsb:
	paddsb mm0,mm1
	jmp StoreResult

MmxPaddusb:
	paddusb mm0,mm1
	jmp StoreResult

MmxPaddw:
	paddw mm0,mm1
	jmp StoreResult

MmxPaddsw:
	paddsw mm0,mm1
	jmp StoreResult

MmxPaddusw:
	paddusw mm0,mm1
	jmp StoreResult

MmxPaddd:
	paddd mm0,mm1
	jmp StoreResult

MmxPaddq:
	paddq mm0,mm1
	jmp StoreResult

BadAddOp:
	pxor mm0,mm0

StoreResult:
	movd eax,mm0				; low dword to eax
	pshufw mm2,mm0,01001110b	; mov words in mm0 to mm2 in a specified order (1, 0, 3, 2)
								; -> effectively swapping low and high dword
	movd edx,mm2				; high dword to edx
	emms						; clear mmx state

	pop ebp
	ret

	align 4
AddOpTable:
	dword MmxPaddb, MmxPaddsb, MmxPaddusb
	dword MmxPaddw, MmxPaddsw, MmxPaddusw
	dword MmxPaddd, MmxPaddq

AddOpTableCount equ ($-AddOpTable) / size dword

MmxAdd		endp
end