0x0001:
	jump iodevhandler

0x0100:
	store ONE 0xFFF2
	load #'*' R0

step1:
	store R0 0xfff0
	jump step1

iodevhandler:
	push R0
	load 0xfff0 R0
	store R0 0xfff0
	pop R0
	reset IM
	return
