.386
.model flat

.data
intArray DWORD 10000h,20000h,30000h,40000h

.code
start proc
	mov esi,OFFSET intArray
	mov ecx,LENGTHOF intArray
	mov eax,0

LP:
	add eax,[esi]
	add esi,TYPE intArray
	loop LP

	ret

start endp
end start