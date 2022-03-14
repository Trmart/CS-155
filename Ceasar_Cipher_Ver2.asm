;*****************************************************************************
;
;  Final Project:   Caesar Cipher Encryption Program 
;
;  Author: Taylor Martin 

;  Date: 05/06/2020
;
;  Revision: 2.0
;
;  Description:
;     This program prompts a user to enter a message to encrpyt and then prints the encrypted message to the screen 
;
;
;  Register Usage:
;     R0 Used for program message register
;     R1 General Purpose Reg
;     R2 General Purpose Reg
;     R3 General Purpose Reg
;     R4 General Purpose Reg
;     R5 General Purpose Reg
;     R6 General Purpose Reg
;     R7 unused, used by RET for functions 
;
;
;	Caesar Cipher Psuedo Code:
;string caesarCipher(string msg, int shift)
;{   
;    for (int i=0; i < msg.size(); i++)
;    {
;        if (msg[i] >= 'A' && msg[i] <= 'Z')
;        {
;            msg[i]= ((msg[i] - 'A') + shift) % 26 + 'A';
;        }
;    }
;  return msg;   
;}

;****************************************************************************/	

	.ORIG	x3000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;		 MAIN 
; Outputs Start message to screen and 
; calls 
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MAIN	LEA R0, Start 
	PUTS
	LEA R0, new ; Inserts a new line and loads the address into R0 
	PUTS	; Prints the /n to the screen 

	LEA R0, User_Choice	; Load User_Choice String into R0 to prepare to output 
	PUTS			; Output User_choice String to the screen

	IN
	LEA R0, new		;Load /n into R0 for printing 
	LEA R1, Convert_Const
	LDR R1, R1, #0 
	ADD R2, R0, R1 

	PUTS			;Print /n to the screen 


	LEA R0, Message_Input 	;Loads Message_Input string into R0 to get ready for printing to screen 
	PUTS			; Prints string Message_Input that was loaded into R0



	LEA	R4, Message_Arr ; Loads Address of first index in Message_Arr into R4
	AND 	R1, R1, #0	; Clear R1 and set value to 0. 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;				User_Input()
;
;
;
;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
USER_INPUT
	IN
	ADD R5, R0, #-10 ; subtract 10, to account for the enter key being searched for
	STR R0, R4, #0   ; Store character read into the Message_Arr
	ADD R4, R4, #1	 ; Index++, increment our index of the Message_Arr
	ADD R1, R1, #1	 ; ProgramCounter++, increment the PC
	BR	USER_INPUT ; LOOP through USER_INPUT again 


	;JSR	Encrypt	 ; Call and branch to the Encrypt() function 
	
	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;				Encrypt()
;This Function will use Message_Arr and Loop over each character inserted into 
;the Message_Arr to change the character and encrypt the message enter by the user
;
;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Encrypt
	LEA R4, Message_Arr ;Load the address of index 0 of the Message_Arr into R4
	ADD R5, R1, #0 	    ; Load Message_Arr Size into R5 and use it as the PC
	;LEA R5, i	    ; Load address of i into R5
	;LDR R5, R5, #0     ; Load 20 from i into R5
	
LOOP 
	LDR R0, R4, #0 
	JSR Swap 
	ADD R0, R6, R2 
	STR R0, R4, #0 ;store encrypted code into Message_Arr
	ADD R4, R4, #1 ; index++, increment the index of Message_ARR
	ADD R5, R5, #-1; PC--, Decrement the PC 
	BRp LOOP
	BR  Print 


Swap 
	NOT R3, R0 
	AND R3, R3, #1
	AND R0, R0, #-2
	ADD R6, R0, R3
	RET

Print 
	LEA R4, Message_Arr
PrintLoop
	LDR R0, R4, #0 
	OUT
	ADD R4, R4, #1 ; 
	ADD R1, R1, #-1
	BRp PrintLoop
	HALT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    Variables, Strings, and Constants Data Initialization
;
;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Convert_Const:  .FILL	#-48  ; Constant for converting numbers from ASCII to decimal.
Message_Arr .BLKW 20
i	 .FILL	#20   ; Constant used as loop counter.

New	.STRINGZ "/n"
Start	.STRINGZ "This Program Takes A Message Entered By A User And Then Encrypts And Prints The Message"
User_Choice	.STRINGZ "Please Enter A Number You Would Like To Use(1-9) "
Message_Input 	.STRINGZ "Please Enter A Message You Would Like To Encrypt (Max 20 Lowercase Characters)"
.END


	

	