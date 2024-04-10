; ********************************
; What I need to remember:
; 	Only the following registers can be dereferenced in real mode:
; 		[BX+SI], [BX+DI], [BP+SI], [BP+DI], [SI], [DI], [BP], [BX]
; ********************************
org		0x7c00			; set origin of memory
mov		[bootDisk], dl	; keep our boot disk number safe

; ********************************
call	loadSectors	; load sectors (hardcoded values)
; ********************************
jmp 	ready
; ********************************
; include load sectors after jump to code section.
%include	"realmode/loadSectors.asm"		; include the load sectors file
; ********************************
; ********************************
times		510-($-$$) db 0x0	; fill the rest of the bootloader with null bytes
db			0x55, 0xaa			; define the "magic word" to show this as a bootloader
%include	"realmode/scan.asm"				; include the scan file
%include 	"realmode/strops.asm"
%include	"realmode/print.asm"			; include the print file
%include 	"commands.asm"
%include 	"data.asm"
%include 	"bss.asm"