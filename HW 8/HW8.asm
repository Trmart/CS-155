;Taylor Martin 
; HW # 8 
; CS-151
; 4/15/20
; This program loops through values assigned to an array 
; in order to find the min and max values located within the array
; then once found, it will display the min and max values to the screen 

.ORIG x3000

LEA R2, num ;r2 will be our data address register for our array 
LDR R0, R2, #0 
LDR R1, R2, #0 
AND R5, R5, #0 ; R5 will be used as our loop counter 
ADD R5, R5, #10 ; we need to loop through the array 10 times 
		; to access elements 0-9 
AND R3, R3, #0 ; clear R3 for storage 

LEA R4, num ; load the size of the array into r4
AND R4, R4, #0 
NOT R4, R4
ADD, R4, R4, #1 




LOOP ST R2, R5 
ADD R2, R2, #1
LDR R6, R2, #0 
LDR R6, R7, #0 
NOT R7, R7  
.
.
.
.
ADD R5 R5, #1 ; increment our loop counter in R5 


BRn LOOP

HALT 


num .FILL 10
array .FILL 1
.FILL 3
.FILL 7
.FILL 2
.FILL 5
.FILL 4
.FILL 8
.FILL 7
.FILL 0
.FILL 2

maxstr STRINGZ "MAX = "
minstr STRINGZ "MIN = "

max .FILL xFE06 ; address of DDR 
min .FILL xFE06 ; address of DDR 

.END 
