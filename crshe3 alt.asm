;Program to find the number of 1's in 00H, 55H, 0AAH & 0FFH stored at 30H-33H resp. and send the address of RAM location having max number of ones to P1
;codeRSH	DS:03.19.2011	DE:03.19.2011


ORG 00H			;All programs start at M/M locatin 00H

;------------------Main Program-----------------
MOV R0, #30H		;Only R0 and R1 can be used as pointers to RAM location

MOV R1, #3		;Start saving no. of 1's from Register 3
MOV R7, #4		;We need to loop 4 times

LOOP: ACALL PROC
MOV @R1, B		;R1 points to the location where the number of 1's will be stored
INC R0			;R0 now points to next M/M location
INC R1			;R1 now points to next register
DJNZ R7, LOOP

MOV R1, #3		;R1 pointing to R3 now.
MOV A, @R1		;A will hold the largest number, let it be that in R3 for now
MOV R0, #30H		;R3 will hold the corresponding M/M location
MOV R2, #30H
MOV R7, #3		;MOV R7, 3 is wrong

MORE: INC R1
INC R2
MOV B, @R1		;B holds the value from next M/M location to be compared with the current largest number
CJNE A, B, NE		;NE is required only because the syntax of compare instruction is like that
NE: JNC DONT		;If A greater, then jump
MOV A, B		;If A was less, then value in B becomes the largest number
MOV R0, 2		;And R0 will now point to its corresponding M/M location; Note MOV R0, R2 is invalid
DONT: DJNZ R7, MORE

MOV P1, #00		;Make P1 an output port by sending all 0's
MOV P1, R0		;Send the required M/M location to P1

;--------------------------------------------------------
ORG 50H			;Keep Procedures sufficiently far away so that they don't interfere with the other code
PROC:
CLR CY
MOV A, @R0

MOV B, #00		;B will count the number of 1's
MOV R2, #08		;We got 8 bits to check in each M/M location

AGAIN: RLC A		;Rotate left through Carry bit
JNC OVER			
INC B			;If carry bit has a 1 increment R1
OVER: DJNZ R2, AGAIN	;Loop 8 times

RET			;Return back

;----------------------------------------------------------
ORG 30H			;Jump to M/M location 30H
DB 00H, 55H, 0AAH, 0FFH	;Define the bytes at 30H-33H. Interestingly '#' is not required before the numbers here.

END

