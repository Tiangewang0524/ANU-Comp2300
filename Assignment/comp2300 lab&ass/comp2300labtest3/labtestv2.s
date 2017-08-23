;stack frame:
;return address #0
;n #-1
;result #-2

square:
	load SP #-1 R0
	mult R0 R0 R0
	store R0 #-2 SP
	return
0x0100:
	push R0 ; add a spot for result
	load varn R0
	push R0
	call square

	pop R0
	pop R0	; pop twice only

varn:
	block #65535

;int square(int n) {
;return n*n;
;}