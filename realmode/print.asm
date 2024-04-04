print:						; subroutine to print a string.
	pusha					; move all regs to stack
	cmp		di, 0x0			; if args are empty, end execution
	je		printEnd
    

	printStart:
	mov		ah, 0x0e		; set to tty mode
	mov		bx, di			; move argument pointer to base address reg.
    

	printLoop:
	cmp		byte [bx], 0x0	; check if string is null terminated
	je		printEnd		; if it is, exit.

	mov		al, byte [bx]	; move value of base address to argument register
	int		0x10			; call interrupt

	inc		bx				; increment base address
	jmp		printLoop		; until string is null terminated


	printEnd:
	popa					; move all stack to regs
	mov		di, 0x0			; empty parameter
	ret						; return to main function

; ****************************************************************************

; The printc subroutine is not really meant for usual stuff, and is really 
; a dependency of the scan subroutine.
; parameter: dl (character to print)
printc:						; subroutine to print a single character
	pusha					; move all regs to stack

	mov		al, dl			; move argument (8-bit register dl) to al
	mov		ah, 0x0e		; set ah to teletype

	cmp		dl, 0xd			; check if dl is a carriage return
	je		printNewLine	; if so, print a new-line instead.

	cmp		dl, 0x8			; check if dl is a backspace
	je		printBackspace	; if so, do some extra stuff

	int		0x10			; perform interrupt 10h, printing al
	jmp		complete		; skip printNewLineReached


	printBackspace:
	mov		al, 0x8			; go back a character
	int		0x10			; print to tty
	mov		al, 0x0			; print a null in the back character
	int		0x10			; print to tty
	mov		al, 0x8			; go back after printing the null character
	int		0x10			; print to tty
	jmp		complete		; complete


	printNewLine:			; address in code
	call	printnl			; print a new line
	jmp		complete		; complete


	complete:				; address in code
	popa					; move all stack to regs
	ret						; return to main function

; ****************************************************************************

printnl:
	pusha						; move all regs to stack

	nlstr:	db 0xd, 0xa, 0x0	; Oxd=CR, 0xa=LF, 0x0=terminator

	mov		di, nlstr			; move newline definition to function argument
	call	print				; print newline

	popa						; move all stack to regs
	ret

; ****************************************************************************

println: 			; subroutine to print a string and a newline
	pusha 			; move all regs to stack

	call 	print 	; print value of di (function argument)
	call 	printnl ; print a newline aswell

	popa 			; move all stack to regs
	ret 			; return to main function
