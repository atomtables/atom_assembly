strcmp:
	pusha
	cmp si, 0x0 ; si is our source
	cmp di, 0x0 ; di is our comparison

	mov bp, 0x0

	strcmpLoop:
	mov byte al, [si+bp]
	mov byte ah, [di+bp]
	inc bp

	cmp ah, 0x0
	je scEnd1
	cmp ah, 0x20
	je scEnd1

	cmp ah, al
	je strcmpLoop
	jl scUnequal
	jg scUnequal

	scEnd1:
	cmp al, 0x0
	jne scUnequal
	popa
	stc
	ret
 
	scUnequal:
	popa
	ret

;strcmp:
    mov ecx,0
    strcmp_loop:
        mov byte dl,[eax+ecx]
        mov byte dh,[ebx+ecx]
        inc ecx
        cmp dl,0
        je strcmp_end_0
        cmp byte dl,dh
        je strcmp_loop
        jl strcmp_end_1
        jg strcmp_end_2
    strcmp_end_0:
        cmp dh,0
        jne strcmp_end_1
        xor ecx,ecx
        ret
    strcmp_end_1:
        mov ecx,1
        ret
    strcmp_end_2:
        mov ecx,-1
        ret