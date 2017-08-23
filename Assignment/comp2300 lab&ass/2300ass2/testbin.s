; Tiange WANG
; u5715141


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
	sub R0 #'B' R1
	jumpz R1 binary
	sub R0 #'X' R1
	jumpz R1 hex
	
binary:
	load ZERO R4
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

hex:
	load ZERO R4
	load #-1 R3

hexchange:
	add R3 R4 R1
	load Sum R0
	sub R1 R0 R1
	jumpz R1 end
	load 0xfff1 R0
	jumpz R0 hexchange
	load 0xfff0 R0
	sub R0 #'A' R1
	jumpn R1 numberchange
	sub R0 #'A' R0
	add R0 #10 R0
	jump binarychange

numberchange:
	sub R0 #'0' R0

binarychange:
	mod R0 #2 R1
	store R1 bit4
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit3
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit2
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit1

bitvalue1:
	add R3 ONE R3
	load bit1 R1
	sub R6 R3 R5
	jumpz R5 Yplus1
	jumpz R1 bitvalue2
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

bitvalue2:
	add R3 ONE R3
	load bit2 R1
	sub R6 R3 R5
	jumpz R5 Yplus2
	jumpz R1 bitvalue3
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
bitvalue3:
	add R3 ONE R3
	load bit3 R1
	sub R6 R3 R5
	jumpz R5 Yplus3
	jumpz R1 bitvalue4
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

bitvalue4:
	add R3 ONE R3
	load bit4 R1
	sub R6 R3 R5
	jumpz R5 Yplus4
	jumpz R1 hexchange
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

	jump hexchange

Yplus1:
	add R4 ONE R4
	sub R7 R4 R5
	jumpz R5 end
	load #0 R3
	load bit1 R5
	jumpz R5 bitvalue2
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
	jump bitvalue2

Yplus2:
	add R4 ONE R4
	sub R7 R4 R5
	jumpz R5 end
	load #0 R3
	load bit2 R5
	jumpz R5 bitvalue3
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
	jump bitvalue3

Yplus3:
	add R4 ONE R4
	sub R7 R4 R5
	jumpz R5 end
	load #0 R3
	load bit3 R5
	jumpz R5 bitvalue4
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
	jump bitvalue4

Yplus4:
	add R4 ONE R4
	sub R7 R4 R5
	jumpz R5 end
	load #0 R3
	load bit4 R5
	jumpz R5 hexchange
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
	jump hexchange


end:
	halt

bit1: block#1
bit2: block#1
bit3: block#1
bit4: block#1
Sum: block#0