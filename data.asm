; ********************************
;          DATA SECTION
; Usually stores data that is meant to be read
; Not really meant for read/write data.
; ********************************
section data:

scanStr:	db		"atom>> ", 0x0
successStr:	db		"successfully found command...", 0x0
exitStr: 	db 		"Exiting AtomASM...", 0x0
eNFStr:		db		"Command does not exist...", 0x0
; array is initialised with number of elements
; array contains 2 things: char[10] and 2 bytes that go to the pointer of the function.
commands:	db 		2										; two elements
			db 		"exit", 0x0, 0x0, 0x0, 0x0, 0x0, 0x0 	; char[10]
			dw 		exit									; void*()
			db 		"echo", 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
			dw		echo