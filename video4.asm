.model tiny
.code
org 100h
VIDEOSEG equ 0b800h

Start:  call Main
        call Exit

;==================================
Main    proc

        call Print_str
        call Do_frame
        
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

            mov [SavedBX], bx

            ret
            endp

;==================================
Do_frame    proc

            mov al, 03h
	        mov ah, 8Bh

            mov bx, 680h
            call Put_cl_horizontall
            call Put_heart_horizontall

            mov bx, 900h
            call Put_cl_horizontall
            call Put_heart_horizontall

            mov bx, 720h
            call Put_cl_verticall
            call Put_heart_verticall

            mov bx, [SavedBX]
            add bx, 4
            sub bx, 160
            call Put_cl_verticall
            call Put_heart_verticall

            ret
            endp

;==================================
Put_heart_horizontall   proc

Put_heart:              mov es:[bx], ax
                        add bx, 2
                        LOOP Put_heart

                        ret
                        endp

;==================================
Put_heart_verticall     proc

Put_heart2:             mov es:[bx], ax
                        add bx, 160
                        LOOP Put_heart2

                        ret
                        endp

;==================================
Put_cl_horizontall      proc

                        mov cl, ds: [80h]
                        add cl, 5
                        xor ch, ch

                        ret
                        endp

;==================================
Put_cl_verticall        proc

                        add cl, 3
                        xor ch, ch

                        ret
                        endp

;==================================
Exit                    proc

                        mov ax, 4c00h
                        int 21
                    
                        ret
                        endp

SavedBX dw 0

end     Start