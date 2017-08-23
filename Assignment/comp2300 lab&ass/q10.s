0x0100 :	load varx R0
	push R0
	call square
	pop R0
	halt


square :	load SP #-1 R0
	mult R0 R0 R0
	store R0 #-1 SP
	return

varx : block #65535