0x100:
read_RPI:
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
	load #-1 R3
	load #0 R4
loadmode:
	load 0xfff0 R0

base64_judgement:
	   load 0xfff0 R0
	   sub R0 #'+' R1
	   jumpz R1 base64_plus
	   sub R0 #'/' R1
	   jumpz R1 base64_slash
	   sub R0 #':' R1
	   jumpn R1 base64_number
	   sub R0 #'[' R1
	   jumpn R1 base64_uppercase
	   sub R0 #'{' R1
	   jumpn R1 base64_lowercase
base64_slash:
	   load #63 R0
	   jump base64_to_binary
base64_plus:
	   load #62 R0
	   jump base64_to_binary
base64_number:
	   add R0 #4 R0
	   jump base64_to_binary
base64_uppercase:
	   sub R0 #65 R0
	   jump base64_to_binary
base64_lowercase:
	   sub R0 #71 R0
	   jump base64_to_binary
base64_to_binary :
	   load length R1
	   jumpz R1 left_0
	   sub R1 #1 R2
	   jumpz R2 left_1
	   sub R1 #2 R2
	   jumpz R2 left_2
	   sub R1 #3 R2
	   jumpz R2 left_3
	   jump binary_to_huffman
left_0:	   mod R0 #2 R1
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
	   jump binary_to_huffman
left_1:	   mod R0 #2 R1
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
	   jump binary_to_huffman
left_2:	   mod R0 #2 R1
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
	   jump binary_to_huffman
left_3:	   mod R0 #2 R1
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
binary_to_huffman:
	   load bit1 R0
	   sub R0 #0 R1
	   jumpz R1 huffman_code_0
	   sub R0 #1 R1
	   jumpz R1 huffman_code_1
huffman_code_0:
	   load bit2 R0
	   sub R0 #0 R1
	   jumpz R1 huffman_code_00
	   sub R0 #1 R1
	   jumpz R1 huffman_code_01
huffman_code_1:
	   load bit2 R0
	   sub R0 #0 R1
	   jumpz R1 huffman_code_10
	   sub R0 #1 R1
	   jumpz R1 huffman_code_11
huffman_code_00:
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
	   add R3 #8 R3
	   sub R6 R3 R2
	   sub R2 #1 R2
          jumpn R2 newline_00
	   load length R0
	   sub R0 #2 R0
	   store R0 length
	   sub R0 #4 R0
	   jumpn R0 base64_judgement
	   jump binary_to_huffman 
huffman_code_01:
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
	   store R0 left
	   jump set_pixel_several_1
huffman_code_10:
	   load bit3 R0
	   sub R0 #0 R1
	   jumpz R1 huffman_code_100
	   sub R0 #1 R1
	   jumpz R1 huffman_code_101
huffman_code_11:
	   load bit3 R0
	   sub R0 #0 R1
	   jumpz R1 huffman_code_110
	   sub R0 #1 R1
	   jumpz R1 huffman_code_111
huffman_code_100:
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
	   add R3 ONE R3
	   sub R3 R6 R2
	   jumpz R2 newline_100
	   load length R0
	   sub R0 #3 R0
	   store R0 length
	   sub R0 #4 R0
	   jumpn R0 base64_judgement
	   jump binary_to_huffman
huffman_code_101:
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
	   add R3 ONE R3
	   sub R3 R6 R2
	   jumpz R2 newline_101
	   jump set_pixel_101
huffman_code_110:
	   load bit4 R0
	   sub R0 #0 R1
	   jumpz R1 huffman_code_1100
	   sub R0 #1 R1
	   jumpz R1 huffman_code_1101
huffman_code_111:
	   load bit4 R0
	   sub R0 #0 R1
	   jumpz R1 huffman_code_1110
	   sub R0 #1 R1
	   jumpz R1 huffman_code_1111
huffman_code_1100:
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
	   add R3 #2 R3
	   sub R6 R3 R2
	   sub R2 #1 R2
	   jumpn R2 newline_1100
	   load length R0
	   sub R0 #4 R0
	   store R0 length
	   sub R0 #4 R0
	   jumpn R0 base64_judgement
	   jump binary_to_huffman
huffman_code_1101:
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
	   store R0 left
	   jump set_pixel_several_1
huffman_code_1110:
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
	   add R3 #4 R3
	   sub R6 R3 R2
	   sub R2 #1 R2
	   jumpn R2 newline_1110
	   load length R0
	   sub R0 #4 R0
	   store R0 length
	   sub R0 #4 R0
	   jumpn R0 base64_judgement
	   jump binary_to_huffman
huffman_code_1111:
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
	   store R0 left
	   jump set_pixel_several_1
newline_00:
	   mod R3 R6 R3
	   add R4 ONE R4
	   sub R7 R4 R0
	   jumpz R0 end
	   load length R0
	   sub R0 #2 R0
	   store R0 length
	   sub R0 #4 R0
	   jumpn R0 base64_judgement
	   jump binary_to_huffman
newline_100:
	   load #0 R3
	   add R4 ONE R4
	   sub R7 R4 R0
	   jumpz R0 end
	   load length R0
	   sub R0 #3 R0
	   store R0 length
	   sub R0 #4 R0
	   jumpn R0 base64_judgement
	   jump binary_to_huffman
newline_101:
	   load #0 R3
	   add R4 ONE R4
	sub R7 R4 R0
	jumpz R0 end
	   jump set_pixel_101
newline_1100 :
          mod R3 R6 R3
	   add R4 ONE R4
	sub R7 R4 R0
	jumpz R0 end
	   load length R0
	   sub R0 #4 R0
	   store R0 length
	   sub R0 #4 R0
	   jumpn R0 base64_judgement
	   jump binary_to_huffman
newline_1110 :
          mod R3 R6 R3 
	   add R4 ONE R4
	sub R7 R4 R0
	jumpz R0 end
	   load length R0
	   sub R0 #4 R0
	   store R0 length
	   sub R0 #4 R0
	   jumpn R0 base64_judgement
	   jump binary_to_huffman
newline_several_1 :
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

	   load left R0
	   sub R0 ONE R0
	   store R0 left
	   jumpnz R0 set_pixel_several_1
	   load length R0
	   sub R0 #4 R0
	   jumpn R0 base64_judgement
	   jump binary_to_huffman


load_int : load 0xfff1 R0
	   jumpz R0 load_int
	   load 0xfff0 R0
	   sub R0 #'0' R1
si:	   load 0xfff1 R0
	   jumpz R0 si
	   load 0xfff0 R0
	   sub R0 #'0' R2
si2:	   load 0xfff1 R0
	   jumpz R0 si2
	   load 0xfff0 R0
	   sub R0 #'0' R3
	   mult R1 #100 R1
	   mult R2 #10 R2
	   add R1 R2 R2
 	   add R3 R2 R2
	   store R2 #-1 SP
 	   return
set_pixel_101 : 
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
	     load length R0
	     sub R0 #4 R0
	     jumpn R0 base64_judgement
	     jump binary_to_huffman
set_pixel_several_1:
	     add R3 ONE R3
	     sub R3 R6 R3
	     jumpz R3 newline_several_1
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

	     load left R0
	     sub R0 ONE R0
	     store R0 left
	     jumpnz R0 set_pixel_several_1
	     load length R0
	     sub R0 #4 R0
	     jumpn R0 base64_judgement
	     jump binary_to_huffman
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
left : block #0