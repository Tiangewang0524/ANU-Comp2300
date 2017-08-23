0x0100 :	load #959 R7
	load #0xffffffff R5

draw :	add R7 #0x7C40 R6
	store R5 R6
	sub R7 ONE R7
	jumpn R7 done
	jump draw

done :	halt

varp : block 1