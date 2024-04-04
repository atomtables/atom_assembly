scan:
	pusha 						; move all regs to stack

	cmp 	di, 0x0 			; check if di is null
	je 		scanTerminate 		; if so, terminate

	cmp 	si, 0x0 			; check if si is null
	je 		scanTerminate 		; if so, terminate


	scanStart:
	mov 	cx, di 				; set cx to our target length
	mov 	di, 0x0 			; reset di to use as addressing offset
	mov 	bx, si 				; move our string address to base-address register


	scanLoop:
	mov 	ah, 0x0 			; set to scan character
	int 	0x16 				; wait for user input

	cmp 	al, 0x8 			; check if input is a backspace
	je 		scanBackspace 		; handle a backspace

	mov 	dl, al 				; move character input to 8-bit data
	call 	printc 				; print character
	mov 	dl, 0 				; reset data 8-bit register

	mov 	[bx+di], al 		; add the character to the string
	inc 	di 					; increment the "for loop" counter

	cmp 	cx, di 				; check if incrementer is the same as string length
	je 		scanEnd 			; if so, end

	cmp 	al, 0xd 			; check if input is a newline
	je 		scanEnd 			; terminate the loop in that case

	jmp 	scanContinue 		; skip handling a backspace


	scanBackspace: 				; if jumped to this location
	cmp 	di-1, 0x0
	jle 	scanContinue
	mov 	dl, al 				; move character input to 8-bit data
	call 	printc 				; print character
	mov 	dl, 0 				; reset data 8-bit register
	mov 	[bx+di], byte 0x0 	; replace backspaced byte with a null byte
	dec 	di 					; decrement the counter in order to prepare for rewrite.


	scanContinue: 				; area after handling a backspace
	jmp 	scanLoop 			; reiterate through loop


	scanEnd:
	mov 	[bx+di], byte 0x0 	; null terminate the string for good measure


	scanTerminate: 				; area where termination should jump to
	popa 						; move all stack to regs
	ret 						; return to main function
