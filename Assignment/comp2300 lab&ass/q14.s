0x0100 :	

comm_div :	load SP #-2 R6	;x
	load SP #-1 R7	;y
	jumpz R7 rtn_x

rtn_x :	store R6 