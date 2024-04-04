mov ah, 0x0e ; teletype mode
mov al, 65 ; current ascii character in decimal
mov bh, 0x00 ; uppercase flag

; print the alphabet
alphabet:
    int 0x10
    cmp bh, 0x00
    je uppercase
    jne lowercase
    
; make the letter lowercase: routine
lowercase:
    sub al, 31
    dec bh
    cmp al, 122
    jne alphabet

; make the letter uppercase: routine
uppercase:
    add al, 33
    inc bh
    cmp al, 122
    jne alphabet
    
; print out the last letter
int 0x10
; go into an infinite loop
jmp $

; make raw image bootable
times 510-($-$$) db 0
db 0x55, 0xaa