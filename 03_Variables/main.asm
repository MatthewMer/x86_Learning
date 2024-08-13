.386
.model flat

.data
num1	DWORD	11111111h
num2	DWORD	10101010h
ans		DWORD	0h

.code
start	proc
	mov eax, num1
	add eax, num2
	mov ans, eax

	ret
start	endp
end		start