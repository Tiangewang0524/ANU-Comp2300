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

asciichange:
	load 0xfff0 R0
	sub R0 #'a' R1
	jumpn R1 upperchange
	sub R0 #71 R0
	jump base64change

upperchange:
	sub R0 #'A' R1
	jumpn R1 numberchange2
	sub R0 #65 R0
	jump base64change

numberchange2:
	sub R0 #'0' R1
	jumpn R1 slashchange
	add R0 #4 R0
	jump base64change

slashchange:
	sub R0 #'/' R1
	jumpn R1 pluschange
	add R0 #16 R0
	jump base64change

pluschange:
	add R0 #19 R0

base64change:
	mod R0 #2 R1
	store R1 bit6
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit5
	div R0 #2 R0
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
	store R1 bit

asciichange2:
	load 0xfff0 R0
	sub R0 #'a' R1
	jumpn R1 upperchange2
	sub R0 #71 R0
	jump base64change2

upperchange2:
	sub R0 #'A' R1
	jumpn R1 numberchange3
	sub R0 #65 R0
	jump base64change2

numberchange3:
	sub R0 #'0' R1
	jumpn R1 slashchange3
	add R0 #4 R0
	jump base64change2

slashchange2:
	sub R0 #'/' R1
	jumpn R1 pluschange2
	add R0 #16 R0
	jump base64change2

pluschange2:
	add R0 #19 R0

base64change2:
	mod R0 #2 R1
	store R1 bit12
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit11
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit10
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit9
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit8
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit7

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
	jump readbit3

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
	jump readbit3

bit1:
	load bit2 R0
	jumpnz R0 bit11     ;;If R0 is one, go bit11
	load bit3 R0
	jumpnz R0 bit101    ;;If R0 is one, go bit101
	
bit100:
	add R3 ONE R3
	sub R6 R3 R5
	jumpz R5 Yplus100   
	jump readbit4         ;;read bit4

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
	jump readbit4        ;;read bit4

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
	jump readbit5                     ;;;;read bit5
	
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
	jump readbit5                  ;;read bit5
	

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
	jump readbit5

readbit3:
	load bit3 R0
	jumpnz R0 readbit3bit1
	load bit4 R0
	jumpnz R0 readbit3bit11111111
	
readbit3bit00000000:
	load #8 R0

readbit3bit00:
	add R3 ONE R3
	sub R6 R3 R5
	jumpz R5 readbit3Yplus00   
	sub R0 #1 R0
	jumpnz R0 readbit3bit00
	jump readbit5

readbit3bit11111111:
	load #8 R5

readbit3bit01:
	add R3 ONE R3
	sub R6 R3 R0
	jumpz R0 readbit3Yplus01    
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
	jumpnz R5 readbit3bit01
	jump readbit5

readbit3bit1:
	load bit4 R0
	jumpnz R0 readbit3bit11     ;;If R0 is one, go bit11
	load bit5 R0
	jumpnz R0 readbit3bit101    ;;If R0 is one, go bit101
	
readbit3bit100:
	add R3 ONE R3
	sub R6 R3 R5
	jumpz R5 Yplus100   
	jump readbit6         ;;read bit6

readbit3bit101:
	add R3 ONE R3
	sub R6 R3 R5
	jumpz R5 readbit3Yplus101
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
	jump readbit6        ;;read bit6

readbit3bit11:
	load bit5 R0
	jumpnz R0 bit111        ;;if bit5 is 0, go bit111
	load bit6 R0
	jumpnz R0 bitloop11       ;;if bit6 is 0, go bit1101
	load #2 R0

readbit3bit1100:
	add R3 ONE R3
	sub R6 R3 R5
	jumpz R5 readbit3Yplus1100   
	sub R0 #1 R0
	jumpnz R0 readbit3bit1100
	jump exchangebit7             ;;read bit7

readbit3bitloop11:
	load #2 R5

readbit3bit1101:
	add R3 ONE R3
	sub R6 R3 R0
	jumpz R0 readbit3Yplus1101    
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
	jumpnz R5 readbit3bit1101
	jump exchangebit7                     ;;;;read bit7
	
readbit3bit111:
	load bit4 R0
	jumpnz R0 readbit3Fbit1111

readbit3bit0000:
	load #4 R0

readbit3bit1110:
	add R3 ONE R3
	sub R6 R3 R5
	jumpz R5 Yplus1110   
	sub R0 #1 R0
	jumpnz R0 bit1110
	jump exchangebit7                  ;;read bit7
	

readbit3Fbit1111:       ;;initialize the loop of bit1111	
	load #4 R5

readbit3bit1111:
	add R3 ONE R3
	sub R6 R3 R0
	jumpz R0 readbit3Yplus1111    
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
	jumpnz R5 readbit3bit1111
	jump exchangebit7


exchangebit7:                            ;;bit7 is new bit1
	store bit12 bit6
	store bit11 bit5
	store bit10 bit4
	store bit9 bit3
	store bit8 bit2
	store bit7 bit
	jump asciichange2

exchangebit8:                              ;;bit8 is new bit1
	store bit12 bit5
	store bit11 bit4
	store bit10 bit3
	store bit9 bit2
	store bit8 bit

asciichange3:
	load 0xfff0 R0
	sub R0 #'a' R1
	jumpn R1 upperchange3
	sub R0 #71 R0
	jump base64change3

upperchange3:
	sub R0 #'A' R1
	jumpn R1 numberchange4
	sub R0 #65 R0
	jump base64change3

numberchange4:
	sub R0 #'0' R1
	jumpn R1 slashchange3
	add R0 #4 R0
	jump base64change3

slashchange3:
	sub R0 #'/' R1
	jumpn R1 pluschange3
	add R0 #16 R0
	jump base64change3

pluschange3:
	add R0 #19 R0

base64change3:
	store #0 bit12
	mod R0 #2 R1
	store R1 bit11
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit10
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit9
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit8
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit7
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit6
	jump bit0

exchangebit9:                              ;;bit9 is new bit1
	load bit11 R0
	jumpz R0 bit9asciichange
	store bit12 bit4
	store bit11 bit3
	store bit10 bit2
	store bit9 bit
	
asciichange4:
	load 0xfff0 R0
	sub R0 #'a' R1
	jumpn R1 upperchange4
	sub R0 #71 R0
	jump base64change4

upperchange4:
	sub R0 #'A' R1
	jumpn R1 numberchange5
	sub R0 #65 R0
	jump base64change4

numberchange5:
	sub R0 #'0' R1
	jumpn R1 slashchange4
	add R0 #4 R0
	jump base64change4

slashchange4:
	sub R0 #'/' R1
	jumpn R1 pluschange4
	add R0 #16 R0
	jump base64change4

pluschange4:
	add R0 #19 R0

base64change4:
	store #0 bit12
	store #0 bit11
	mod R0 #2 R1
	store R1 bit10
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit9
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit8
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit7
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit6
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit5
	jump bit0

exchangebit10:                              ;;bit10 is new bit1
	load bit10 R0
	jumpz R0 asciichange
	store bit12 bit3
	store bit11 bit2
	store bit10 bit
	
asciichange5:
	load 0xfff0 R0
	sub R0 #'a' R1
	jumpn R1 upperchange5
	sub R0 #71 R0
	jump base64change5

upperchange5:
	sub R0 #'A' R1
	jumpn R1 numberchange6
	sub R0 #65 R0
	jump base64change5

numberchange6:
	sub R0 #'0' R1
	jumpn R1 slashchange5
	add R0 #4 R0
	jump base64change5

slashchange5:
	sub R0 #'/' R1
	jumpn R1 pluschange5
	add R0 #16 R0
	jump base64change5

pluschange5:
	add R0 #19 R0

base64change5:
	store #0 bit12
	store #0 bit11
	store #0 bit10
	mod R0 #2 R1
	store R1 bit9
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit8
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit7
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit6
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit5
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit4
	jump bit0


Yplus00:
	add R4 ONE R4
	sub R7 R4 R5
	jumpz R5 end
	load #0 R3
	sub R0 #1 R0
	jumpnz R0 bit00
	jump readbit3

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
	jump readbit3

Yplus100:
	add R4 ONE R4
	sub R7 R4 R5
	jumpz R5 end
	load #0 R3
	jump readbit4

Yplus101:
	add R4 ONE R4
	sub R7 R4 R5
	jumpz R5 end
	load #0 R3
	jump readbit4

Yplus1100:
	add R4 ONE R4
	sub R7 R4 R5
	jumpz R5 end
	load #0 R3
	sub R0 #1 R0
	jumpnz R0 bit1100
	jump readbit5

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
	jump readbit5

Yplus1110:
	add R4 ONE R4
	sub R7 R4 R5
	jumpz R5 end
	load #0 R3
	sub R0 #1 R0
	jumpnz R0 bit1110
	jump readbit5

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
	jump readbit5

readbit3Yplus00:
	add R4 ONE R4
	sub R7 R4 R5
	jumpz R5 end
	load #0 R3
	sub R0 #1 R0
	jumpnz R0 readbit3bit00
	jump readbit5

readbit3Yplus01:
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
	jumpnz R5 readbit3bit01
	jump readbit5

readbit3Yplus100:
	add R4 ONE R4
	sub R7 R4 R5
	jumpz R5 end
	load #0 R3
	jump readbit6

readbit3Yplus101:
	add R4 ONE R4
	sub R7 R4 R5
	jumpz R5 end
	load #0 R3
	jump readbit6

readbit3Yplus1100:
	add R4 ONE R4
	sub R7 R4 R5
	jumpz R5 end
	load #0 R3
	sub R0 #1 R0
	jumpnz R0 readbit3bit1100
	jump exchangebit7

readbit3Yplus1101:
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
	jumpnz R5 readbit3bit1101
	jump exchangebit7

readbit3Yplus1110:
	add R4 ONE R4
	sub R7 R4 R5
	jumpz R5 end
	load #0 R3
	sub R0 #1 R0
	jumpnz R0 readbit3bit1110
	jump exchangebit7

readbit3Yplus1111:
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
	jumpnz R5 readbit3bit1111
	jump exchangebit7

bit9asciichange:
	store bit10 bit2
	store bit9 bit
	load 0xfff0 R0
	sub R0 #'a' R1
	jumpn R1 bit9upperchange
	sub R0 #71 R0
	jump bit9base64change

bit9upperchange:
	sub R0 #'A' R1
	jumpn R1 bit9numberchange
	sub R0 #65 R0
	jump bit9base64change

bit9numberchange:
	sub R0 #'0' R1
	jumpn R1 bit9slashchange
	add R0 #4 R0
	jump bit9base64change

bit9slashchange:
	sub R0 #'/' R1
	jumpn R1 bit9pluschange
	add R0 #16 R0
	jump bit9base64change

bit9pluschange:
	add R0 #19 R0

bit9base64change:
	mod R0 #2 R1
	store R1 bit8
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit7
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit6
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit5
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit4
	div R0 #2 R0
	mod R0 #2 R1
	store R1 bit3

bit9asciichange2:
	load 0xfff0 R0
	sub R0 #'a' R1
	jumpn R1 bit9upperchange2
	sub R0 #71 R0
	jump bit9base64change2

bit9upperchange2:
	sub R0 #'A' R1
	jumpn R1 bit9numberchange2
	sub R0 #65 R0
	jump bit9base64change2

bit9numberchange2:
	sub R0 #'0' R1
	jumpn R1 bit9slashchange2
	add R0 #4 R0
	jump bit9base64change2

bit9slashchange2:
	sub R0 #'/' R1
	jumpn R1 bit9pluschange2
	add R0 #16 R0
	jump bit9base64change2

bit9pluschange2:
	add R0 #19 R0

bit9base64change2:
	store R0 number1
	div R0 #32 R0
	mod R0 #2 R1
	store R1 bit9
	load number1 R0
	jump bit01

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
