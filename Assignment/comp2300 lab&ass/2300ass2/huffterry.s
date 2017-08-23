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

set:
	load #-1 R4
	load #0 R5

loadmode:
	load 0xfff0 R0


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
	   jumpz R1 left0
	   sub R1 #1 R2
	   jumpz R2 left1
	   sub R1 #2 R2
	   jumpz R2 left2
	   sub R1 #3 R2
	   jumpz R2 left3
	   jump bit0
left0:	   mod R0 #2 R1
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
left1:	   mod R0 #2 R1
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
left2:	   mod R0 #2 R1
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
left3:	   mod R0 #2 R1
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
	   jumpz R0 bit00
	   sub R0 #1 R1
	   jumpz R1 bit01

bit00:
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
	   add R4 #8 R4
	   sub R6 R4 R3
	   sub R3 #1 R3
          jumpn R3 Yplus00
	   load length R0
	   sub R0 #2 R0
	   store R0 length
	   sub R0 #4 R0
	   jumpn R0 asciichange
	   jump bit0 
bit01:
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
	   load #8 R0
	   store R0 count
	   jump drawpixel1

bit1code1:
	   load bit2 R0
	   jumpz R0 bit10
	   sub R0 #1 R1
	   jumpz R1 bit11

bit10:
	   load bit3 R0
	   jumpz R0 bit100
	   sub R0 #1 R1
	   jumpz R1 bit101

bit11:
	   load bit3 R0
	   jumpz R0 bit110
	   sub R0 #1 R1
	   jumpz R1 bit111

bit100:
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
	   add R4 ONE R4
	   sub R4 R6 R3
	   jumpz R3 Yplus100
	   load length R0
	   sub R0 #3 R0
	   store R0 length
	   sub R0 #4 R0
	   jumpn R0 asciichange
	   jump bit0
bit101:
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
	   add R4 ONE R4
	   sub R4 R6 R3
	   jumpz R3 Yplus101
	   jump setpixel
bit110:
	   load bit4 R0
	   jumpz R0 bit1100
	   sub R0 #1 R1
	   jumpz R1 bit1101
bit111:
	   load bit4 R0
	   jumpz R0 bit1110
	   sub R0 #1 R1
	   jumpz R1 bit1111
bit1100:
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
	   add R4 #2 R4
	   sub R6 R4 R3
	   sub R3 #1 R3
	   jumpn R3 Yplus1100
	   load length R0
	   sub R0 #4 R0
	   store R0 length
	   sub R0 #4 R0
	   jumpn R0 asciichange
	   jump bit0
bit1101:
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
	   load #2 R0
	   store R0 count
	   jump drawpixel1
bit1110:
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
	   add R4 #4 R4
	   sub R6 R4 R3
	   sub R3 #1 R3
	   jumpn R3 Yplus1110
	   load length R0
	   sub R0 #4 R0
	   store R0 length
	   sub R0 #4 R0
	   jumpn R0 asciichange
	   jump bit0
bit1111:
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
	   load #4 R0
	   store R0 count
	   jump drawpixel1

Yplus00:
	   mod R4 R6 R4
	   add R5 ONE R5
	sub R7 R5 R0
	jumpz R0 end
	   load length R0
	   sub R0 #2 R0
	   store R0 length
	   sub R0 #4 R0
	   jumpn R0 asciichange
	   jump bit0

Yplus100:
	   load #0 R4
	   add R5 ONE R5
	sub R7 R5 R0
	jumpz R0 end
	   load length R0
	   sub R0 #3 R0
	   store R0 length
	   sub R0 #4 R0
	   jumpn R0 asciichange
	   jump bit0
Yplus101:
	   load #0 R4
	   add R5 ONE R5
	sub R7 R5 R0
	jumpz R0 end
	   jump setpixel

Yplus1100 :
          mod R4 R6 R4
	   add R5 ONE R5
	sub R7 R5 R0
	jumpz R0 end
	   load length R0
	   sub R0 #4 R0
	   store R0 length
	   sub R0 #4 R0
	   jumpn R0 asciichange
	   jump bit0

Yplus1110 :
          mod R4 R6 R4 
	   add R5 ONE R5
	sub R7 R5 R0
	jumpz R0 end
	   load length R0
	   sub R0 #4 R0
	   store R0 length
	   sub R0 #4 R0
	   jumpn R0 asciichange
	   jump bit0

Yplusdraw1 :
	   load #0 R4
	   add R5 ONE R5
	sub R7 R5 R0
	jumpz R0 end
	add R4 #0 R1
	     add R5 #0 R2
	     load #0x7C40 R0
	     mult #6 R2 R3
	     add R0 R3 R0
	     div R1 #32 R3
	     add R0 R3 R0
	     mod R1 #32 R3
	     rotate R3 ONE R2
	     load R0 R3
	     or R2 R3 R3
	     store R3 R0

	   load count R0
	   sub R0 ONE R0
	   store R0 count
	   jumpnz R0 drawpixel1
	   load length R0
	   sub R0 #4 R0
	   jumpn R0 asciichange
	   jump bit0

setpixel: 
           add R4 #0 R1
	     add R5 #0 R2
	     load #0x7C40 R0
	     mult #6 R2 R3
	     add R0 R3 R0
	     div R1 #32 R3
	     add R0 R3 R0
	     mod R1 #32 R3
	     rotate R3 ONE R2
	     load R0 R3
	     or R2 R3 R3
	     store R3 R0

	     load length R0
	     sub R0 #4 R0
	     jumpn R0 asciichange
	     jump bit0

drawpixel1:
	     add R4 ONE R4
	     sub R4 R6 R3
	     jumpz R3 Yplusdraw1
		add R4 #0 R1
	     add R5 #0 R2
	     load #0x7C40 R0
	     mult #6 R2 R3
	     add R0 R3 R0
	     div R1 #32 R3
	     add R0 R3 R0
	     mod R1 #32 R3
	     rotate R3 ONE R2
	     load R0 R3
	     or R2 R3 R3
	     store R3 R0

	     load count R0
	     sub R0 ONE R0
	     store R0 count
	     jumpnz R0 drawpixel1
	     load length R0
	     sub R0 #4 R0
	     jumpn R0 asciichange
	     jump bit0
end:
	     halt


bit1 : block #0
bit2 : block #0
bit3 : block #0
bit4 : block #0
bit5 : block #0
bit6 : block #0
bit7 : block #0
bit8 : block #0
bit9 : block #0
length : block #0
count : block #0

