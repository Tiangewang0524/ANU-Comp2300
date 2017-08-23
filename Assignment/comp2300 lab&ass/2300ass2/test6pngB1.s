0x0100:
;;R3:x R4:y
loadR:
	load 0xfff1 R0
	jumpz R0 loadR
	load 0xfff0 R0

loadP:
	load 0xfff1 R0
	jumpz R0 loadP
	load 0xfff0 R0

loadI:
	load 0xfff1 R0
	jumpz R0 loadI
	load 0xfff0 R0

loadwidth1:
	load 0xfff1 R0
	jumpz R0 loadwidth1
	load 0xfff0 R0
	sub R0 #'0' R0
	mult R0 #100 R0

loadwidth2:
	load 0xfff1 R1
	jumpz R1 loadwidth2
	load 0xfff0 R1
	sub R1 #'0' R1
	mult R1 #10 R1

loadwidth3:
	load 0xfff1 R2
	jumpz R2 loadwidth3
	load 0xfff0 R2
	sub R2 #'0' R2
	add R0 R1 R0
	add R0 R2 R6          ;;width is R6

loadheight1:
	load 0xfff1 R0
	jumpz R0 loadheight1
	load 0xfff0 R0
	sub R0 #'0' R0
	mult R0 #100 R0

loadheight2:
	load 0xfff1 R1
	jumpz R1 loadheight2
	load 0xfff0 R1
	sub R1 #'0' R1
	mult R1 #10 R1

loadheight3:
	load 0xfff1 R2
	jumpz R2 loadheight3
	load 0xfff0 R2
	sub R2 #'0' R2
	add R0 R1 R0
	add R0 R2 R7          ;;height is R7

save:
	sub R6 #1 R0
	sub R7 #1 R1
	add R0 R1 R0
	store R0 Sum

loadmode:
	load 0xfff1 R0
	jumpz R0 loadmode
	load 0xfff0 R0

identifyY:
	load ZERO R4

arithmometer:
	load #-1 R3

identifyX:
	add R3 R4 R1
	load Sum R0
	sub R1 R0 R1
	jumpz R1 end
	load 0xfff1 R0
	jumpz R0 identifyX
	load 0xfff0 R0
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

end:
	halt

Sum: block#1