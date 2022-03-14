;*****************************************************************************
;
;  Homework 8:   Array Min and Max Counter 
;
;  Author: Taylor Martin 

;  Date: 04/22/2020
;
;  Revision: 2.0
;
;  Description:
;     This routine calculates the Min and Max values of an array and outputs them to the screen 
;
;
;
;  Register Usage:
;     R0 Loads character to display with the use of the DDR
;     R1 Str pointer to load the str into r0 
;     R2 checks if the DSR is ready 
;     R3 Array SIZE 
;     R4 Ptr to current value being checked in Array
;     R5 Min Value 
;     R6 Max Value 
;     R7 Temp Register 
;
;     All registers are preserved by this function
;
;   Pseudocode Algorithm:
;
;  #include <iostream> 
;using namespace std; 

;int main()
;{
    
;    int array[] = {1,3,7,2,5,4,8,7,0,2}; 
    
;    int min = array[0]; 
;    int max = array[0]; 

;    for (int i = 0; i < 9 ; i++)
;    {
;        if(array[i] > max)
;        {
;            max = array[i]; 
;        }
;        else if(array[i] < min)
;        {
;            min = array[i]; 
;        }
;   }
;
;    cout << "Max = " << max << " Min = " << min; 
;    
;
;    return 0; 
;}
;
;
;****************************************************************************/
.ORIG x3000
;Initialization int main()
		LD 	R3, SIZE	; Loads R3 with SIZE of Arr
		LEA	R4, ARR		; Loads R4 with a PTR to the first element of ARR		
		LD	R5, ARR		; Loads R5 with value in ARR[0]
		LD	R6, ARR		; Loads R6 with value in ARR[0]
		AND 	R7, R7, #0 	; Clear R7 and set to 0 
;;Loop()

LOOP		LDR R7, R4, #0 		; Set R7 to R4
		NOT R7, R7 		; Invert R7
		ADD R7, R7, #1
		ADD R7, R5, R7		; Add R7(Temp) to R5(Min) 
		BRnz	IF		; If R7(Temp) is negative or Zero, branch
		LDR	R5, R4, #0 	; Else R7(temp) is positive, set Min to R4(PTR) 

;;Test() 
; Test for MIN and MAX

IF		LDR R7, R4, #0 		; Set R7(temp) to R4(PTR) 
		NOT	R7, R7		; Invert R7
		ADD 	R7, R7, #1
		ADD	R7, R6, R7	; ADD R7(Temp)	to R6(MAX) 	
		BRzp	ELSE		; Branch to Else, when R7(temp) is Zero or Positive 	
		LDR 	R6, R4, #0	; If Temp is negative, set R4(PTR) to R6(MAX) 

ELSE		ADD R4, R4, #1		; Set R4(PTR) to point to next element in ARR
		ADD R3, R3, #-1		; Decrement R3(SIZE), which is also the counter to the ELSE loop 
		BRp LOOP		; If R3 is positive, check the next value

;;;Display()
;;;Print String MIN()
DISPLAYSTRMIN	LEA	R1, MIN		; Load address of first character in MIN string into R1
MINLOOP		LDR 	R0, R1, #0 	; Load next character in 
		BRz	MINVAL		; Load next character untill null character is reached 
DISPLAY1	LDI	R2, DSR		; 
		BRzp	DISPLAY1	; Loop until console is ready for output 
		STI	R0, DDR		; Write next character in String 
		ADD	R1,R1, #1	; Set R1 to next character in String 
		BR	MINLOOP

;Write MIN Value to screen 
MINVAL		LD	R7, ASCII 	; Set R7(Temp) to ASCII converter 
		ADD	R0,R7,R5	; Set R0 to MIN value in R5(MIN)
DISPLAY2	LDI	R2, DSR
		BRzp DISPLAY2		; Loop untill console is ready for output 
		STI 	R0, DDR		; Write character to screen 

;Print String MAX()
DISPLAYSTRMAX	LEA	R1, MAX		; Load address of first character of MAX string into R1
MAXLOOP		LDR 	R0, R1, #0 	;
		BRz	MAXVAL
DISPLAY3	LDI	R2, DSR
		BRzp	DISPLAY3	; Loop until console is ready for output 
		STI	R0, DDR		; write character to DDR
		ADD	R1, R1, #1	; Set R1 to next character in MAX string 
		BR	MAXLOOP 	

;Write MAX value to screen
MAXVAL		LD	R7, ASCII 	; Set R7(Temp) to ASCII converter 
		ADD	R0,R7,R6	; Set R0 to MAX value in R6(MAX)
DISPLAY4	LDI	R2, DSR
		BRzp DISPLAY4		; Loop untill console is ready for output 
		STI 	R0, DDR		; Write character to screen 


		HALT

;;;;;;;;Variables and Strings 
MAX	.STRINGZ 	"MAX = " 
MIN	.STRINGZ	" MIN = "
DSR	.FILL		xFE04
DDR	.FILL		xFE06
ASCII	.FILL		x0030		


SIZE	.FILL	#10	
ARR	.FILL	#1
	.FILL	#3
	.FILL	#7
	.FILL	#2
	.FILL	#5
	.FILL	#4
	.FILL	#8
	.FILL	#7
	.FILL	#0
	.FILL	#2  

	.END 
                



