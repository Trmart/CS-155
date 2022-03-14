;*****************************************************************************
;
;  Homework 10:   LC-3 Trap Handler 
;
;  Author: Taylor Martin 

;  Date: 05/04/2020
;
;  Revision: 2.0
;
;  Description:
;     This program writes its own Trap Handler at Trap x40, and fills the trap with an character echo routine. 
;
;
;
;  Register Usage:
;     R0 Used for program pointer 
;     R1 General Purpose Reg
;     R2 General Purpose Reg
;     R3 General Purpose Reg
;     R4 General Purpose Reg
;     R5 General Purpose Reg
;     R6 General Purpose Reg
;     R7 unused, used by RET for functions 
;
;
;****************************************************************************/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		MAIN
   Initializes program and calls two
  subroutines COUT and Store 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	.ORIG x3000 


MAIN	ST	R7, SaveR7
	JSR	Store
	LD	R2, NewLine	
	JSR	COUT 	
	LEA	R1, UserPrompt
Trap	x40 	.FILL 	UserInput

 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOOP	calls the Trapx40 and COUT
functions to recieve input from the 
user and echo the char back to the screen 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	


LOOP	LDR	R2, R1, #0 ; loads next prompt char 
	BRz	Trap x40  
	JSR	COUT
	ADD	R1, R1, #1 
	BRnzp 	LOOP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	TrapX40(UserInput) 
 a function that calls on the CIN
function to read the character input by the user
and COUT to output it to the screen. Finally calls
Delete to clear the reg data
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


UserInput	JSR	CIN
	ADD	R2, R0, #0 ; move char to R2 and prepare for writing 
	JSR	COUT       ; echo to monitor 
	
	LD	R2,NewLine
	JSR	COUT
	JSR	Delete
	LD	R7, SaveR7
	RET		  ;JMP R7 terminates the subroutine, Returning to main


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SaveR7	.FILL	x0000
NewLine	.FILL	x000A
UserPrompt	.STRINGZ "Input a character>"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		COUT
Function that outputs characters to
the screen
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

COUT		LDI	R3, DSR
		BRzp	COUT
		STI	R2, DDR
		RET
DSR	.FILL	xFE04
DDR	.FILL	xFE06

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		CIN
A funtion that reads user input char
and stores it for output. 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CIN		LDI	R3, KBSR
		BRzp	CIN
		LDI	R0, KBDR
		RET
KBSR	.FILL	xFE00
KBDR	.FILL	xFE02

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		Store 
Utilizes the stack for data storage
	to save register data 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Store   ST	R1, SaveR1
	ST	R2, SaveR2
	ST	R3, SaveR3
	ST	R4, SaveR4
	ST	R5, SaveR5
	ST	R6, SaveR6
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		Delete 
Utilizes the stack to delete the data
stored in the register 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Delete  	LD	R1, SaveR1
		LD	R2, SaveR2
		LD	R3, SaveR3
		LD	R4, SaveR4
		LD	R5, SaveR5
		LD	R6, SaveR6
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Initializes the SaveR veriables to 
0 in order to use in the Store and Delete
functions 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SaveR1		.FILL	x0000
SaveR2		.FILL	x0000
SaveR3		.FILL	x0000
SaveR4		.FILL	x0000
SaveR5		.FILL	x0000
SaveR6		.FILL	x0000
		.END ;end of program 
		
	
				
	
