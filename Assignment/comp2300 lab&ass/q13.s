;  for (i = 0; i <= 100; i++) {
;    setpixel((rand())%192,(rand())%160);
;  }

0x0100 :   jump loopbool
loop:      push R0   ; work out x pixel
           call rand
           pop R0
           load #192 R1
           mod R0 R1 R0
           push R0 

           push R0   ; work out y pixel
           call rand
           pop R0
           load #160 R1
           mod R0 R1 R0
           push R0 
           call setpixel ; draw the pixel 
           pop R0
           pop R0
           load loopcount R1
           add R1 ONE R1
           store R1 loopcount 

loopbool : load #100 R0
           load loopcount R1
           sub R0 R1 R1
           jumpnz R1 loop
           halt

loopcount : block 1
mask : block #0x7fffffff ; we need this mask so the random number is positive

; rand - generate psudo random numbers.
; this uses Linear Congruential Generator see http://en.wikipedia.org/wiki/Linear_congruential_generator
; stack frame :
;   return address #0
;   return random value #-1
rand : load aval R0
       load rval R1
       mult R0 R1 R1
       load cval R0
       add R1 R0 R1
       store R1 rval
       rotate #12 R1 R1
       load mask R0
       and R0 R1 R1
       store R1 #-1 SP
       return
rval : block #0  ; this stores the current random 
aval : block #1664525
cval : block #1013904223


; setpixel - set a pixel to white
; stack frame :
;  return address #0
;  y #-1
;  x #-2
; "pixel (x,y) will be bit x%32 of the word at 
; address 0x7C40 + 6*y + x/32" from spec

setpixel :	load SP #-1 R0
	load SP #-2 R1
	load #32 R4
	mod R0 R4 R4
	rotate R4 ONE R4
	load #0x7C40 R2
	load #6 R3
	mult R1 R3 R1
	load #32 R3
	div R0 R3 R0
	add R0 R2 R2
	add R1 R2 R2
	load R2 R3
	or R3 R4 R4
	store R4 R2
	return
	