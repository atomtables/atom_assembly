loadSectors:
	pusha

	loadSectorsStart:
	mov		ah, 2				; hex 13, argument 2
	mov		al, [lsSec]			; amount of sectors we want to read from  

	mov		dl, [bootDisk]		; read from our boot disk
	mov		ch, 0				; read from cylinder 0
	mov		dh, 0				; read from head 0
	mov		cl, 2				; read from sector 2

	mov		bx, 0x7e00			; load sectors at address 7e00h
	int		0x13				; interrupt to load disk

	loadSectorsEnd:
	cmp		al, [lsSec]			; check if amount of sectors needed was loaded
	jne		loadSectorsError	; if not, reset computer and try again
	jc		loadSectorsError	; if the carry flag is high, reset computer and try again

	popa
	ret

	loadSectorsError:
	mov		si, lsStr			; set argument to the error message
	call	println				; print error message
	mov		ah, 0x86			; set argument for int 15h
	mov		cx, 0xf				; set amount of time to wait to F(9xxms)
	int		0x15				; wait 1 second
	jmp		0xFFFF:0			; reset (restart) system

	lsStr: 	db 	"There was an error loading sectors. Please wait while the system resets.", 0x0
	lsSec: 	db 	2