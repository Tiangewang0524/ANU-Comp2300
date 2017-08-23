; stack frame:
; return address #0
; varm #-1
; varn #-2
; result #-3

func:
	load SP #-1 R0
	load SP #-2 R1
	mult R1 #2 R2
	sub R0 R2 R3
	jumpn R3 funcelseif
	push R7
	push R2
	push R0

func2:
	call func
	pop R0
	pop R2
	pop R7
	store R7 #-1 SP
	jump func

funcelseif:
	sub R0 R1 R3
	jumpn R3 funcelse
	store R3 #-3 SP
	return

funcelse:
	store R0 #-3 SP
	return

0x0100 : 
	load varm R0
	load varn R1
 	push R2
 	push R1
	push R0
 	call func
 	pop R0
 	pop R1
	pop R2
	add #48 R2 R2
 	store R2 0xfff0
 	halt

varm : block #100
varn : block #5