.386
.model flat

PBYTE TYPEDEF PTR BYTE
PWORD TYPEDEF PTR WORD
PDWORD TYPEDEF PTR DWORD

.data
arrayB BYTE 10h,20h,30h
arrayW WORD 1,2,3
arrayD DWORD 4,5,6

ptB PBYTE arrayB
ptW PWORD arrayW
ptD PDWORD arrayD

.code
main proc
	
	mov esi,ptB
	mov al,[esi]
	mov esi,ptW
	mov ax,[esi]
	mov esi,ptD
	mov eax,[esi]

	ret

main endp
end main