;*****************************************************************************
;
;  Homework 11: Fibonacci Sequence LC-3 Program 
;
;  Author: Taylor Martin 

;  Date: 05/13/2020
;
;  Revision: 3.0
;
;  Description:
;     This LC-3 program repeatedly accepts a number from 0-9 (n) from the keyboard, 
;      then calculates and displays the nth Fibonacci number.
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
;Psuedo Code: 
;int Fibonacci(int n)
;{
;if ((n == 0) || (n == 1))
;   return 1; R6
;else
;   return Fibonacci(n-1) + Fibonacci(n-2); 
;}
;
;****************************************************************************/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		MAIN
   Initializes program and calls two
  subroutines COUT and Store 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    .ORIG x3000 
               LD R6, STACK_PTR     ; setup stack pointer to Top Of Stack
               JSR FIB_SEQ ; assumes R0 contains number of times to recurse
STOP_LOOP      BRnzp STOP_LOOP ; loop rather than HALT to preserve R0 value

STACK_PTR      .FILL 0x8000
FIB_SEQ        ADD R6, R6, #-1       ; push R1
               STR R1, R6, #0

               ADD R6, R6, #-1       ; push R7
               STR R7, R6, #0

               AND R1, R1, #0        ; clear R1
               ADD R1, R0, #-1       ; test for n = 0 case
               BRnzp FIB_SEQ_N
               ADD R1, R2, #-1       ; Test for n = 1 case 
               BRzp FIB_SEQ_N
               
;;if n-1 and n-2 are not zero, n>2, branch here
               ADD R0, R1, #0 
               JSR FIB_SEQ
               ADD R5, R0, #0   ; Save the n-1 term 
               BRnzp FIB_SEQ_END 

FIB_SEQ_END    AND R0, R0, #0        ; here if n = 1 case
               ADD R0, R6, #0        ; copy value in R6 (the SP) into R0
               BRnzp EXIT_PROGRAM

FIB_SEQ_N      ADD R0, R0, #-1       ; here if n>1. put n-1 into R0
               JSR FIB_SEQ           ; recursively call FIB_SEQ(n-1)

EXIT_PROGRAM   LDR R7, R6, #0        ; pop R7.  The JSR instruction above
               ADD R6, R6, #1        ; changed it, so we must restore it
                                     ;   before the RET below.

               LDR R1, R6, #0        ; pop R1. Pop all regs in reverse
               ADD R6, R6, #1        ; order that they were pushed

               RET
.END



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   I thought that I needed these subroutines down below
;to use for the FIB_SEQ program, in order to save, restore, and 
;delete the registers for use. But it seems that I don't need them for the 
;stack? Ill leave them in here in case I do need to use them. 
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
		