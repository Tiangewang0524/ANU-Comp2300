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
	   load length R1
	   jumpz R1 left_0
	   sub R1 #1 R2
	   jumpz R2 left_1
	   sub R1 #2 R2
	   jumpz R2 left_2
	   sub R1 #3 R2
	   jumpz R2 left_3
	   jump bit0

left_0:	  
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
	   store R1 bit1
	   load length R1
	   add R1 #6 R1
	   store R1 length
	   jump bit0
left_1:	  
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
	   div R0 #2 R0
	   mod R0 #2 R1
	   store R1 bit2
	   load length R1
	   add R1 #6 R1
	   store R1 length
	   jump bit0

left_2:	  
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
	   load length R1
	   add R1 #6 R1
	   store R1 length
	   jump bit0

left_3:	  
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
	 load length R1
	 add R1 #6 R1
	 store R1 length

bit0:
	load bit1 R0
	jumpz R0 bit1code0
	jumpnz R0 bit1code1
	
bit1code0:
	load bit2 R0
	jumpz R0 bit00setting
	jumpnz R0 bit01setting


bit00setting:
	load #8 R1
	load bit3 R0
	store R0 bit1
	   load bit4 R0
	   store R0 bit2
	   load bit5 R0
	   store R0 bit3
          load bit6 R0
	   store R0 bit4
	   load bit7 R0
	   store R0 bit5
	   load bit8 R0
	   store R0 bit6
	   load bit9 R0
	   store R0 bit7

bit00:
	   add R3 ONE R3
	   sub R6 R3 R5
	   jumpz R5 Yplus00
	   sub R1 #1 R1
	   jumpnz R1 bit00

bit00after:
	   load length R0
	   sub R0 #2 R0
	   store R0 length
	   sub R0 #4 R0
	   jumpn R0 asciichange
	   jump bit0


bit01setting:
	load #8 R5
	load length R0
	   sub R0 #2 R0
	   store R0 length
 	   load bit3 R0
	   store R0 bit1
	   load bit4 R0
	   store R0 bit2
	   load bit5 R0
	   store R0 bit3
          load bit6 R0
	   store R0 bit4
	   load bit7 R0
	   store R0 bit5
	   load bit8 R0
	   store R0 bit6
	   load bit9 R0
	   store R0 bit7

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

bit01after:
	load length R0
	sub R0 #4 R0
	jumpn R0 asciichange
	jump bit0


bit1code1:
	load bit2 R0
	jumpz R0 bit10
	sub R0 #1 R1
	jumpz R1 bit11

bit10:
	load bit3 R0
	jumpz R0 bit100setting
	sub R0 #1 R1
	jumpz R1 bit101setting

bit100setting:
	load bit4 R0
	   store R0 bit1
	   load bit5 R0
	   store R0 bit2
	   load bit6 R0
	   store R0 bit3
          load bit7 R0
	   store R0 bit4
	   load bit8 R0
	   store R0 bit5
	   load bit9 R0
	   store R0 bit6

bit100:
	add R3 ONE R3
	sub R6 R3 R5
	jumpz R5 Yplus100
	
bit100after:
	load length R0
	   sub R0 #3 R0
	   store R0 length
	   sub R0 #4 R0   
	jumpn R0 asciichange
	jump bit0

bit101setting:
	 load length R0
	   sub R0 #3 R0
	   store R0 length
	   load bit4 R0
	   store R0 bit1
	   load bit5 R0
	   store R0 bit2
	   load bit6 R0
	   store R0 bit3
          load bit7 R0
	   store R0 bit4
	   load bit8 R0
	   store R0 bit5
	   load bit9 R0
	   store R0 bit6

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

bit101after:	
	load length R0
	sub R0 #4 R0
	jumpn R0 asciichange
	jump bit0

bit11:
	load bit3 R0
	jumpz R0 bit110        ;;if bit3 is 0, go bit110
	sub R0 #1 R1
	jumpz R0 bit111       ;;if bit3 is 1, go bit111

bit110:
	load bit4 R0
	jumpz R0 bit1100setting
	sub R0 #1 R1
	jumpz R1 bit1101setting

bit1100setting:
	load #2 R1
	 load bit5 R0
	   store R0 bit1
	   load bit6 R0
	   store R0 bit2
	   load bit7 R0
	   store R0 bit3
          load bit8 R0
	   store R0 bit4
	   load bit9 R0
	   store R0 bit5

bit1100:
	add R3 ONE R3
	sub R6 R3 R5
	jumpz R5 Yplus1100   
	sub R1 #1 R1
	jumpnz R1 bit1100

bit1100after:
	load length R0
	   sub R0 #4 R0
	   store R0 length
	   sub R0 #4 R0
	jumpn R0 asciichange
	jump bit0

bit1101setting:
	load #2 R5
	 load length R0
	   sub R0 #4 R0
	   store R0 length
 	   load bit5 R0
	   store R0 bit1
	   load bit6 R0
	   store R0 bit2
	   load bit7 R0
	   store R0 bit3
          load bit8 R0
	   store R0 bit4
	   load bit9 R0
	   store R0 bit5

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

bit1101after:
	 load bit5 R0
	   store R0 bit1
	   load bit6 R0
	   store R0 bit2
	   load bit7 R0
	   store R0 bit3
          load bit8 R0
	   store R0 bit4
	   load bit9 R0
	   store R0 bit5
	load length R0
	sub R0 #4 R0
	jumpn R0 asciichange
	jump bit0

bit111:
	load bit4 R0
	jumpz R1 bit1110setting
	sub R0 #1 R1
	jumpz R1 bit1111setting

bit1110setting:
	load #4 R1
	load bit5 R0
	   store R0 bit1
	   load bit6 R0
	   store R0 bit2
	   load bit7 R0
	   store R0 bit3
          load bit8 R0
	   store R0 bit4
	   load bit9 R0
	   store R0 bit5

bit1110:
	add R3 ONE R3
	sub R6 R3 R5
	jumpz R5 Yplus1110   
	sub R1 #1 R1
	jumpnz R1 bit1110

bit1110after:
	load length R0
	   sub R0 #4 R0
	   store R0 length
	   sub R0 #4 R0
	jumpn R0 asciichange
	jump bit0

bit1111setting:       ;;initialize the loop of bit1111	
	load #4 R5
	load length R0
	   sub R0 #4 R0
	   store R0 length
 	   load bit5 R0
	   store R0 bit1
	   load bit6 R0
	   store R0 bit2
	   load bit7 R0
	   store R0 bit3
          load bit8 R0
	   store R0 bit4
	   load bit9 R0
	   store R0 bit5

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

bit1111after:
	load length R0
	   sub R0 #4 R0
	   store R0 length
	   sub R0 #4 R0
	jumpn R0 asciichange
	jump bit0

Yplus00:
	add R4 ONE R4
	sub R7 R4 R5
	jumpz R5 end
	load #0 R3
	sub R1 #1 R1
	jumpnz R1 bit00
	jump bit00after

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
	jump bit01after

Yplus100:
	add R4 ONE R4
	sub R7 R4 R5
	jumpz R5 end
	load #0 R3
	jump bit100after

Yplus101:
	add R4 ONE R4
	sub R7 R4 R5
	jumpz R5 end
	load #0 R3
	jump bit101after

Yplus1100:
	add R4 ONE R4
	sub R7 R4 R5
	jumpz R5 end
	load #0 R3
	sub R1 #1 R1
	jumpnz R1 bit1100
	jump bit1100after

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
	jump bit1101after

Yplus1110:
	add R4 ONE R4
	sub R7 R4 R5
	jumpz R5 end
	load length R5
	sub R5 #4 R5
	store R5 length
	load #0 R3
	sub R1 #1 R1
	jumpnz R1 bit1110
	jump bit1110after

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
	jump bit1111after

end:
	halt

bit1: block#0
bit2: block#0
bit3: block#0
bit4: block#0
bit5: block#0
bit6: block#0
bit7: block#0
bit8: block#0
bit9: block#0
length: block#0
