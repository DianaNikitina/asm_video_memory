.model tiny
.code
org 100h
VIDEOSEG equ 0b800h

Start:  call Main
        call Exit

;==================================
Main    proc

        call Print_str
        ;call Do_frame
        
        ret
        endp

;==================================
Print_str   proc

            mov ax, VIDEOSEG
            mov es, ax

            mov bx, 7C6h

            mov cl, ds: [80h]
		    sub cl, 1
		    xor ch, ch

            mov si, 82h
            mov ah, 0DBh

Put_str:    mov al, ds: [si]
            inc si

            mov es: [bx], ax
            add bx, 2
            LOOP Put_str

            ret
            endp

;==================================
Exit    proc

        mov ax, 4c00h
        int 21
    
        ret
        endp

end     Start