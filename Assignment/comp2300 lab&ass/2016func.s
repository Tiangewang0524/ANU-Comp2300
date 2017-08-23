; stack frame:
; return address #0
; varm #-1
; varn #-2
; result #-3

funcelse:
	load SP #-1 R0
	load SP #-2 R1
	sub R1 R0 R3
	jumpz R3 func
	jumpn R3 funcelseif
	push R7
	push R3
	push R0
	call funcelse
	pop R0
	pop R3
	pop R7
	store R7 #-3 SP
	return

funcelseif:
	sub #0 R3 R3
	push R7
	push R1
	push R3
	call funcelse
	pop R3
	pop R1
	pop R7
	store R7 #-3 SP
	return

func:
	store R0 #-3 SP
	return

0x0100 : 
	load varm R0
	load varn R1
 	push R2
 	push R1
	push R0
 	call funcelse
 	pop R0
 	pop R1
	pop R2
	add #48 R2 R2
 	store R2 0xfff0
 	halt

varm : block #30
varn : block #84