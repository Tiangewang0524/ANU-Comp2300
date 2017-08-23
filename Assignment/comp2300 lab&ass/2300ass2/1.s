0x100:
	call loadchar
	call loadchar
	call loadchar
	;get x edge
	call loadint
	mult #100 R0 R2
	call loadint
	mult #10 R0 R1
	call loadint
	add R0 R1 R0
	add R0 R2 R0
	add R0 #0 R4
	;get y edge
	call loadint
	mult #100 R0 R2
	call loadint
	mult #10 R0 R1
	call loadint
	add R0 R1 R0
	add R0 R2 R0
	add R0 #0 R5

	load #0 R6
	load #0 R7
;	load #192 R4
	sub R4 #1 R4
;	load #142 R5
	sub R5 #1 R5

	;identify B X H
	call loadchar
	sub R0 #'B' R1
	jumpz R1 isB

isB:	call startb
	halt
	
startb:

	;read int
	load 0xfff0 R0
	sub R0 #'0' R0
	jumpz R0 iszero


	;draw pixel
	load #0x7C40 R0
	mult #6 R7 R1
	add R1 R0 R0
	div R6 #32 R1
	add R1 R0 R0
	mod R6 #32 R2
	rotate R2 ONE R2
	load R0 R1
	or R1 R2 R1
	store R1 R0

iszero:	;x++,y++
	sub R6 R4 R1
	jumpz R1 backtozerob
	add #1 R6 R6
	jump startb
	
backtozerob:
	sub R7 R5 R1
	jumpz R1 end
	load #0 R6
	add #1 R7 R7
	jump startb
;read int from 0xfff1
loadint:
	load 0xfff1 R0
	jumpz R0 loadint
	load 0xfff0 R0
	sub R0 #'0' R0
	return

;read int from 0xfff1
loadchar:
	load 0xfff1 R0
	jumpz R0 loadchar
	load 0xfff0 R0
	return

end:
	halt