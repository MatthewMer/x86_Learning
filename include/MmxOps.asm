.model flat,c

.code

OPTION LANGUAGE: syscall		; name mangling (no C symbols) -> Cpp compiler

; mangled name for Cpp compiler
MmxAdd equ <?MmxAdd@Mmx@MMX@@QAEAAU12@ABU12@W4MmxAddOp@2@@Z>
MmxAdd		proc
	push ebp
	mov ebp,esp

	mov eax,[ebp+12]			; load op enum
	cmp eax,AddOpTableCount		; compare with table count
	jae BadAddOp				; jump if invalid
	
	movq mm0,[ecx]
	mov edx,[ebp+8]
	movq mm1,[edx]				; load b

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
; return 64 bit data using registers eax and edx
	;movd eax,mm0				; low dword to eax
	;pshufw mm2,mm0,01001110b	; mov words in mm0 to mm2 in a specified order (1, 0, 3, 2)
								; -> effectively swapping low and high dword
	;movd edx,mm2				; high dword to edx
	movq [ecx],mm0
	mov eax,ecx
	emms						; clear mmx state

	pop ebp
	ret 8

	align 4
AddOpTable:
	dword MmxPaddb, MmxPaddsb, MmxPaddusb
	dword MmxPaddw, MmxPaddsw, MmxPaddusw
	dword MmxPaddd, MmxPaddq

AddOpTableCount equ ($-AddOpTable) / size dword
MmxAdd		endp

MmxSub equ <?MmxSub@Mmx@MMX@@QAEAAU12@ABU12@W4MmxSubOp@2@@Z>
MmxSub		proc
	push ebp
	mov ebp,esp

	mov eax,[ebp+12]			; load op enum
	cmp eax,SubOpTableCount		; compare with table count
	jae BadSubOp				; jump if invalid
	
	movq mm0,[ecx]
	mov edx,[ebp+8]
	movq mm1,[edx]				; load b

	jmp [SubOpTable+eax*4]		; jump to opcode (-> symbol at index)

MmxPsubb:
	psubb mm0,mm1
	jmp StoreResult

MmxPsubsb:
	psubsb mm0,mm1
	jmp StoreResult

MmxPsubusb:
	psubusb mm0,mm1
	jmp StoreResult

MmxPsubw:
	psubw mm0,mm1
	jmp StoreResult

MmxPsubsw:
	psubsw mm0,mm1
	jmp StoreResult

MmxPsubusw:
	psubusw mm0,mm1
	jmp StoreResult

MmxPsubd:
	psubd mm0,mm1
	jmp StoreResult

MmxPsubq:
	psubq mm0,mm1
	jmp StoreResult

BadSubOp:
	pxor mm0,mm0

StoreResult:
; return 64 bit data using registers eax and edx
	;movd eax,mm0				; low dword to eax
	;pshufw mm2,mm0,01001110b	; mov words in mm0 to mm2 in a specified order (1, 0, 3, 2)
								; -> effectively swapping low and high dword
	;movd edx,mm2				; high dword to edx
	movq [ecx],mm0
	mov eax,ecx
	emms						; clear mmx state

	pop ebp
	ret 8

	align 4
SubOpTable:
	dword MmxPsubb, MmxPsubsb, MmxPsubusb
	dword MmxPsubw, MmxPsubsw, MmxPsubusw
	dword MmxPsubd, MmxPsubq

SubOpTableCount equ ($-SubOpTable) / size dword
MmxSub		endp

MmxShift equ <?MmxShift@Mmx@MMX@@QAEAAU12@ABIW4MmxShiftOp@2@@Z>
MmxShift	proc
	push ebp
	mov ebp,esp

	mov eax,[ebp+12]			; load op enum
	cmp eax,ShiftOpTableCount	; compare with table count
	jae BadShiftOp				; jump if invalid
	
	movq mm0,[ecx]
	mov edx,[ebp+8]
	movd mm1,dword ptr[edx]		; load count

	jmp [ShiftOpTable+eax*4]	; jump to opcode (-> symbol at index)

MmxPsllw:
	psllw mm0,mm1
	jmp StoreResult

MmxPslld:
	pslld mm0,mm1
	jmp StoreResult

MmxPsllq:
	psllq mm0,mm1
	jmp StoreResult

MmxPsrlw:
	psrlw mm0,mm1
	jmp StoreResult

MmxPsrld:
	psrld mm0,mm1
	jmp StoreResult

MmxPsrlq:
	psrlq mm0,mm1
	jmp StoreResult

MmxPsraw:
	psraw mm0,mm1
	jmp StoreResult

MmxPsrad:
	psrad mm0,mm1
	jmp StoreResult

;MmxPsraq:
	;psraq mm0,mm1
	jmp StoreResult


BadShiftOp:
	pxor mm0,mm0

StoreResult:
; return 64 bit data using registers eax and edx
	;movd eax,mm0				; low dword to eax
	;pshufw mm2,mm0,01001110b	; mov words in mm0 to mm2 in a specified order (1, 0, 3, 2)
								; -> effectively swapping low and high dword
	;movd edx,mm2				; high dword to edx
	movq [ecx],mm0
	mov eax,ecx
	emms						; clear mmx state

	pop ebp
	ret 8

		align 4
ShiftOpTable:
	dword MmxPsllw, MmxPslld, MmxPsllq
	dword MmxPsrlw, MmxPsrld, MmxPsrlq
	dword MmxPsraw, MmxPsrad;, MmxPsraq

ShiftOpTableCount equ ($-ShiftOpTable) / size dword
MmxShift	endp

OPTION LANGUAGE: C
end