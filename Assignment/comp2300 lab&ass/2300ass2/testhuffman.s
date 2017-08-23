; Tiange WANG
; u5715141


0x0100:
;;R3:x R4:y
loadRPI:
	load 0xfff0 R0
	load 0xfff0 R0
	load 0xfff0 R0

loadwidth:
	load 0xfff0 R0
	sub R0 #'0' R0
	mult R0 #100 R0
	load 0xfff0 R1
	sub R1 #'0' R1
	mult R1 #10 R1
	load 0xfff0 R2
	sub R2 #'0' R2
	add R0 R1 R0
	add R0 R2 R6          ;;width is R6

loadheight:
	load 0xfff0 R0
	sub R0 #'0' R0
	mult R0 #100 R0
	load 0xfff0 R1
	sub R1 #'0' R1
	mult R1 #10 R1
	load 0xfff0 R2
	sub R2 #'0' R2
	add R0 R1 R0
	add R0 R2 R7          ;;height is R7

loadmode:
	load 0xfff0 R0

identifyY:
	load ZERO R4

arithmometer:
	load #-1 R3

hexchange:
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

bit0:
	load bit R0
	jumpnz R0 bit1
	load bit2 R0
	jumpnz R0 bit11111111
	
bit00000000:
	load #8 R0

bit00:
	add R3 ONE R3
	sub R6 R3 R5
	jumpz R5 Yplus00   
	sub R0 #1 R0
	jumpnz R0 bit00
	;;jump readbit3

bit11111111:
	load #8 R5

bit01:
	add R3 ONE R3
	sub R6 R3 R0
	jumpz R0 Yplus01    
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
	sub R5 #1 R5
	jumpnz R5 bit01
	;;jump readbit3

bit1:
	load bit2 R0
	jumpnz R0 bit11     ;;If R0 is one, go bit11
	load bit3 R0
	jumpnz R0 bit101    ;;If R0 is one, go bit101
	
bit100:
	add R3 ONE R3
	sub R6 R3 R5
	jumpz R5 Yplus100   
	;;jump readbit4          ;;read bit4

bit101:
	add R3 ONE R3
	sub R6 R3 R5
	jumpz R5 Yplus101
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
	;;jump readbit4          ;;read bit4

bit11:
	load bit3 R0
	jumpnz R0 bit111        ;;if bit3 is 0, go bit111
	load bit4 R0
	jumpnz R0 bitloop11       ;;if bit4 is 0, go bit1101
	load #2 R0

bit1100:
	add R3 ONE R3
	sub R6 R3 R5
	jumpz R5 Yplus1100   
	sub R0 #1 R0
	jumpnz R0 bit1100
	jump readbit5             ;;read bit5

bitloop11:
	load #2 R5

bit1101:
	add R3 ONE R3
	sub R6 R3 R0
	jumpz R0 Yplus1101    
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
	sub R5 #1 R5
	jumpnz R5 bit1101
	;;jump 读bit5	
	
bit111:
	load bit4 R0
	jumpnz R0 Fbit1111

bit0000:
	load #4 R0

bit1110:
	add R3 ONE R3
	sub R6 R3 R5
	jumpz R5 Yplus1110   
	sub R0 #1 R0
	jumpnz R0 bit1110
	;;jump 读bit5
	

Fbit1111:       ;;initialize the loop of bit1111	
	load #4 R5

bit1111:
	add R3 ONE R3
	sub R6 R3 R0
	jumpz R0 Yplus1111    
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
	sub R5 #1 R5
	jumpnz R5 bit1111
	jump 读bit5



Yplus00:
	add R4 ONE R4
	sub R7 R4 R5
	jumpz R5 end
	load #0 R3
	sub R0 #1 R0
	jumpnz R0 bit00
	jump end

Yplus01:
	add R4 ONE R4
	sub R7 R4 R0
	jumpz R0 end
	load #0 R3
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
	sub R5 #1 R5
	jumpnz R5 bit01
	jump end

Yplus100:
	add R4 ONE R4
	sub R7 R4 R5
	jumpz R5 end
	load #0 R3
	jump end

Yplus101:
	add R4 ONE R4
	sub R7 R4 R5
	jumpz R5 end
	load #0 R3
	jump end

Yplus1100:
	add R4 ONE R4
	sub R7 R4 R5
	jumpz R5 end
	load #0 R3
	sub R0 #1 R0
	jumpnz R0 bit1100
	jump end

Yplus1101:
	add R4 ONE R4
	sub R7 R4 R0
	jumpz R0 end
	load #0 R3
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
	sub R5 #1 R5
	jumpnz R5 bit1101
	jump end

Yplus1110:
	add R4 ONE R4
	sub R7 R4 R5
	jumpz R5 end
	load #0 R3
	sub R0 #1 R0
	jumpnz R0 bit1110
	jump end

Yplus1111:
	add R4 ONE R4
	sub R7 R4 R0
	jumpz R0 end
	load #0 R3
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
	sub R5 #1 R5
	jumpnz R5 bit1111

end:
	halt


bit:block#1
bit2: block#1
bit3: block#1
bit4: block#1
bit5: block#1
bit6: block#1
bit7: block#1
bit8: block#1
bit9: block#1
bitA: block#1
bitB: block#1
bitC: block#1
number1: block#1