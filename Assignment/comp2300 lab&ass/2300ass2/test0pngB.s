0x0100:
;;R3:x R4:y
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
	add R0 #0 R6
	;get y edge
	call loadint
	mult #100 R0 R2
	call loadint
	mult #10 R0 R1
	call loadint
	add R0 R1 R0
	add R0 R2 R0
	add R0 #0 R7
	
	call loadchar
	sub R0 #'B' R1
	jumpz R1 isB

isB:	call identifyY
	halt

identifyY:
	load ZERO R4

arithmometer:
	load #-1 R3

identifyX:
	load 0xfff0 R0
	jumpz R0 identifyX
	;;load 0xfff0 R0
	sub R0 #'0' R0
	add R3 ONE R3 
	sub R6 R3 R5
	jumpz R5 Yplus
	jumpz R0 identifyX
	jump drawpixel

Yplus:
	add R4 ONE R4
	sub R7 R4 R5
	jumpz R5 end
	load #0 R3
	jumpnz R0 drawpixel
	jump identifyX

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

	jump identifyX

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
	jumpz R0 loadint
	load 0xfff0 R0
	return

end:
	halt

