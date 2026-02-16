.model tiny
.code
org 100h
start:	mov ah, 09h
	mov dx, offset HelloStr
	int 21h

HelloStr db 'Hello','$'

	mov ax, 4c00h
	int 21h
end start