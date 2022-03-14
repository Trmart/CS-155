;*****************************************************************************
;
;  Homework 9:   String Echo and Converter 
;
;  Author: Taylor Martin 

;  Date: 04/22/2020
;
;  Revision: 1.0 (4/27/20) 
;
;  Description:
;   This program will prompt a user to enter in the size of a string, and then echo the SIZE back to the screen
;   The user then will enter a string, the program will echo out the string entered by user on the scren
;   leaving numbers untouched and converting lowercase letters to uppercase
;
;
;
;  Register Usage:
;     R0 Loads character to display with the use of the DDR
;     R1 Str pointer to load the str into r0 
;     R2 checks if the DSR is ready 
;     R3 String SIZE 
;     R4 Ptr to current value being checked in String
;     R5 KBSR
;     R6 KBDR
;     R7 Unused ; TRAP and return address register 
;
;     All registers are preserved by this function
;
;   Pseudocode Algorithm:
;
;
;#include <iostream> 
;#include <string> 
;#include <cstring> 
;using namespace std; 
;
;string function(char str[])
;{
;     for(int i = 0; i < strlen(str); i++)
;    { 
;        if(islower(str[i]))
;        {
;            str[i] = toupper(str[i]); 
;            cout << str[i]; 
;        }
;        else 
;        cout << str[i];  
;    }
;}
;
;int main()
;{   
;    const int SIZE = 9 ; 
;    int strSize; 
;     
;    cout << "Please Enter The Length Of A String You Wish To Input (Max String Length can be 9) : "; 
;    cin >> strSize; 
;    cout << "\nEntered Size: " << strSize << "\n";
;    
;    char str[SIZE]; 
;    
;    cout << "Please Enter the String You Wish To Input: "; 
;    cin >> str; 
;
;    function(str); 
;
;    return 0; 
;}
;
;****************************************************************************/
.ORIG x3000
;Initialization int main()

DISPLAYPROMPT 1	LEA	R1, PROMPT1	; Load address of first character in Prompt1 string into R1
LOOP1		LDR 	R0, R1, #0 	; Load next character in 
		BRz	LOOP1		; Load next character untill null character is reached 
DISPLAY1	LDI	R2, DSR		; 
		BRzp	DISPLAY1	; Loop until console is ready for output 
		STI	R0, DDR		; Write next character in String 
		ADD	R1,R1, #1	; Set R1 to next character in String 
		BR	LOOP1



INPUTLEN	LDI	R5, KBSR	; Test for character input 
		BRzp 	INPUTLEN	; Loop until user input is detected 
		LDI 	R6, KBDR	; Assign input data in KBDR to R6 
		LDR 	R3,R6, #0       ; Assign R3(Str SIZE) to R6(KBDR) 


DISPLAYPROMPT2	LEA	R1, PROMPT2	; Load address of first character in Prompt2 string into R1
LOOP2		LDR	R0, R1, #0 	; Load next character in 
		BRz 	LOOP2		; Load untill null 
DISPLAY2	LDI	R2, DSR		; 
		BRzp	DISPLAY2	; Loop until console is ready for output 
		STI	R0, DDR		; Write next character in String 
		ADD	R1,R1, #1	; Set R1 to next character in String 
		BR	LOOP2	


DISPLAYLEN	LEA	R1, R6	
		LDR	R0, R1	
DISPLAY3	LDI	R2, DSR 
		BRzp 	DISPLAY3
		STI	R0, DDR


DISPLAYPROMPT3	LEA	R1, PROMPT3	; Load address of first character in Prompt3 string into R1
LOOP3		LDR	R0, R1, #0 	; Load next character in 
		BRz 	LOOP3		; Load untill null 
DISPLAY4	LDI	R2, DSR		; 
		BRzp	DISPLAY4	; Loop until console is ready for output 
		STI	R0, DDR		; Write next character in String 
		ADD	R1,R1, #1	; Set R1 to next character in String 
		BR	LOOP3	

INPUTSTR	LDI	R5, KBSR	; Test for character input 
		BRzp 	INPUTSTR	; Loop until user input is detected 
		LDI 	R6, KBDR	; Assign input data in KBDR to R6 
		LDR 	R4,R6, #0       ; Assign R4(Str) to R6(KBDR) 
		
		LD	R2, TERM	; load R2 with -7
		LD	R3, ASCII	; load R3 with ASCII difference between lower and uppercase letters
		ADD	R1, R2, R0      
		BRz	Trap	x25
		ADD	R0, R0, R3
		TRAP	x21
		BRnzp	LOOP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WriteChar Subroutine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WriteChar	LDI	R3, DSR
		BRzp	WriteChar
		STI	R2, DDR
		RET
DSR	.FILL	xFE04
DDR	.FILL	xFE06
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ReadChar subroutine 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ReadChar	LDI	R3, KBSR
		BRzp	ReadChar
		LDI	R0, KBDR
		RET
KBSR	.FILL	xFE00
KBDR	.FILL	xFE02
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Save Reg Subroutine 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SaveReg	ST	R1, SaveR1
	ST	R2, SaveR2
	ST	R3, SaveR3
	ST	R4, SaveR4
	ST	R5, SaveR5
	ST	R6, SaveR6
	RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RestoreReg Subroutine 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RestoreReg	LD	R1, SaveR1
		LD	R2, SaveR2
		LD	R3, SaveR3
		LD	R4, SaveR4
		LD	R5, SaveR5
		LD	R6, SaveR6
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
initiallizing save reg values 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SaveR1		.FILL	x0000
SaveR2		.FILL	x0000
SaveR3		.FILL	x0000
SaveR4		.FILL	x0000
SaveR5		.FILL	x0000
SaveR6		.FILL	x0000
		RET

;;;;;;;;Variables and Strings 
PROMPT1	.STRINGZ 	"Enter String Length(Max is 9): " 
PROMPT2	.STRINGZ	"Entered Size: "
PROMPT3 .STRINGZ	"Input A Character: "
Newline	.FILL		x000A ; ASCII code for \n 
TERM	.FILL		#-32 ASCII code difference between lowercase and uppercase letters


SIZE	.FILL	KBDR 	


	.END