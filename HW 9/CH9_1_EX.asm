	.ORIG x3000 
	LD	R2, TERM ; Load -7
	LD 	R3, ASCII ; Load ASCII Difference between upper and lowercase letters 
LOOP	TRAP	x23	; Request Key board Input 
	ADD	R1, R2, R0 ; Test for terminating NULL character 
	BRz	EXIT
	ADD	R0, R0, R3 ;	Change to lowercase 
	TRAP	x21	; Output to monitor 
	BRnzp	LOOP	; Loop Again 
TERM	.FILL	#-7	; Load Term with -7 
ASCII	.FILL	x0020 	; ASCII difference between upper and lower case letters 
EXIT 	TRAP	x25	; HALT
	.END 
