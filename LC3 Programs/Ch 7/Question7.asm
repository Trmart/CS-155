;Taylor Martin 
;CS-155 
;HW #7
;4/8/20

; This Program counts the number of 1's in the value 
; Stored in R0 and Stores the result in R1. 

.ORIG x3000
AND R5, R5, #0
ADD R5, R5, #1 ;R5 will act as a mask to
	       ;mask out the unneeded bit
AND R1, R1, #0 ;clear register 
AND R2, R2, #0 ;R2 be our counter register 
LD R3, NegativeSixteen
;Tried to load R0 with the hex equivalent of 
;R0 example from the book, with no luck. 
;Said 4976 cannot be represented as a signed number in
;9 Bits.   
;LD R0, x1370
MaskWhileLoop AND R4, R0, R5 ;mask off the bit
BRz NotOne 	;if bit is zero then don’t
		;increment the result
ADD R1, R1, #1  ;if bit is one increment
		;the result
NotOne ADD R5, R5, R5 ;shift the mask one bit left
ADD R2, R2, #1 ;increment counter 
ADD R1, R2, R3 
BRn MaskWhileLoop 

HALT

NegativeSixteen .FILL #-16
.END