0x0100:
	load #192 R6
	load #160 R7

initialization:
	load #-1 R3
	load #0 R4

setX:
	add R3 ONE R3 
	sub R6 R3 R5
	jumpz R5 setY

drawpixel:
	load #0x7C40 R0
	mult #6 R4 R1
	add R0 R1 R0
	div R3 #32 R1
	add R0 R1 R0

	mod R3 #32 R1
	rotate R1 ONE R2

	load R0 R1
	or R2 R1 R1
	store R1 R0
	jump setX

setY:
	add R4 ONE R4
	sub R7 R4 R5
	jumpz R5 end
	load #-1 R3
	jump setX

end:
	halt