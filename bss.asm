; ********************************
;          BSS SECTION
; Stores uninitialised data that is meant to be written to
; ********************************
section BSS:
bootDisk:	resw	1						; define 2 bytes to store the boot disk number
prompt:		resb	101						; all strings must be defined one extra than length for null termination.