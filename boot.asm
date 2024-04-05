org		0x7c00			; set origin of memory
mov		[bootDisk], dl	; keep our boot disk number safe

; ********************************
call	loadSectors	; load sectors (hardcoded values)

mov		di, scanStr	; move target string address to di
call	print		; print scanStr

mov		di, 101		; length of target string
mov		si, prompt	; target string address
call	scan		; scan prompt

call	printnl		; create a new line
mov		di, success	; move target string address to di
call	println		; println success

mov		di, prompt	; move target string address to di
call	println		; println prompt

ret					; suspend execution

; ********************************
; include asm file after program halt to ensure code isn't ran prematurely.
%include	"realmode/print.asm"			; include the print file
%include	"realmode/loadSectors.asm"		; include the load sectors file
%include	"realmode/scan.asm"				; include the scan file

; ********************************
times		510-($-$$) db 0x0	; fill the rest of the bootloader with null bytes
db			0x55, 0xaa			; define the "magic word" to show this as a bootloader

; ********************************
;          DATA SECTION
; ********************************
section data:

scanStr:	db		"atom>> ", 0x0
success:	db		"success read...", 0x0
prompt:		resb	101						; all strings must be defined one extra than length for null termination.
bootDisk:	dw		0x0000					; define 2 bytes to store the boot disk number