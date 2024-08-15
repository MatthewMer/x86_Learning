.386
.model flat

.data
quote	db "Assembly is fun",0Ah
msg		db SIZEOF quote DUP(0)

.code
start	proc
	xor esi,esi
	mov ecx,SIZEOF quote

LP:	mov al,quote[esi]		; load char
	mov msg[esi],al			; store char in msg
	inc esi
	loop LP

	ret
start	endp
end		start