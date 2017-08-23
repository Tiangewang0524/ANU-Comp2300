;strlen stack frame
; resvar: #0
; return: address #-1
; strvar: #-2
; resultvar: #-3

strlen:
	load #1 R0
	push R0
	jump strlenwb

strlenwc:
	load SP #0 R0
	add ONE R0 R0
	store R0 #0 SP

strlenwb:
	load SP #-2 R0
	load SP #-1 R7
	load SP #0 R1
	add R0 R1 R2
	load R2 R3
	jumpnz R3 strlenwc
	load SP #0 R0
	store R0 #-3 SP
	pop R0
	return

0x0100:
	push R0
	load #str R1
	push R1
	call strlen
	pop R1
	pop R0
	halt
str: block #"Hello"