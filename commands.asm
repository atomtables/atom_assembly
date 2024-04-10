ready:
jmp		readUserInput

readUserInput:
mov 	si, scanStr				; move target string address to di
call	print					; print scanStr

mov		si, 100					; length of target string
mov		di, prompt				; target string address
call	scanln					; scan prompt

cmp 	byte [prompt], 0x0		; if prompt is empty
je 		readUserInput			; run again

jmp 	parseCommand			; start parsing command



parseCommand:
; I don't know how to check for a command within a list, 
; I'm not even going to go on about implementing data structures other than
; a string, though I might in the future. For now, time to write a buncha code by hand.
;cmp 	byte [prompt], 'e' 		; commands that start with E
;je 		cmdE
;mov 	dx, [0x7e5f]
mov 	bp, commands
mov 	cx, 0x0

parseCommandLoop:
mov 	bx, cx
imul 	bx, 12
add 	bx, 1

mov 	dx, [commands+bx+10]
mov 	si, commands
mov 	di, prompt
add 	si, bx

call 	strcmp
jz 		success

inc		cx
cmp 	bp, cx
je 		eNF

jmp 	parseCommandLoop

success:
call 	dx
jmp 	ready

echo:
pusha
mov		si, prompt+5
call	println
popa
ret

exit:
mov		si, exitStr
call	println
ret						; suspend execution

eNF:
mov 	si, eNFStr
call 	println
jmp		ready