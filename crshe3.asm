;Program to find the number of 1's in 00H, 55H, 0AAH & 0FFH stored at 30H-33H resp. and send the address of RAM location having max number of ones to P1
;codeRSH	DS:03.19.2011	DE:03.19.2011


ORG 00H			;All programs start at M/M locatin 00H

;----------Main Program------------
MOV R0, #30H		;Only R0 and R1 can be used as pointers to RAM location
ACALL PROC		;Call procedure PROC
MOV A, R1
MOV R3, A		;MOV R3, R1 is invalid; R3 holds number of 1's @ 30H

INC R0			;Point to next RAM location
ACALL PROC		;Call PROC again
MOV A, R1
MOV R4, A		;R4 holds number of 1's @ 31H

INC R0
ACALL PROC
MOV 5, 1		;But this way is valid; R5 holds number of 1's @ 32H

INC R0
ACALL PROC
MOV A, R1
MOV R6, A		;R6 holds number of 1's @ 33H

MOV A, R3		;A will hold the largest number, let it be that in R3 for now
MOV R0, #30H		;R3 will hold the corresponding M/M location

CJNE A, 4, NE0	;NE0 is required only because the syntax of compare instruction is like that
NE0: JNC DONT0		;If A greater than R4 then jump to next compare instruction
MOV A, R4		;If A was less than R4, then R4 becomes the largest number
MOV R0, #31H		;And R0 will now point to its corresponding M/M location

DONT0:	CJNE A, 5, NE1	;Compare A and R5 and jump if they are not equal
NE1:	JNC DONT1
MOV A, R5
MOV R0, #32H

DONT1:	CJNE A, 6, NE2	;CJNE A, R6, NE2 not working somehow, why?
NE2: JNC DONT2
MOV A, R6
MOV R0, #33H

DONT2:
MOV P1, #00		;Make P1 an output port by sending all 0's
MOV P1, R0		;Send the required M/M location to P1

;--------------------------------------------------------
ORG 50H			;Keep Procedures sufficiently far away so that they don't interfere with the other code
PROC:
CLR CY
MOV A, @R0

MOV R1, #0		;R1 will count the number of 1's
MOV R2, #08		;We got 8 bits to check in each M/M location

AGAIN: RLC A		;Rotate left through Carry bit
JNC OVER			
INC R1			;If carry bit has a 1 increment R1
OVER: DJNZ R2, AGAIN	;Loop 8 times

RET			;Return back

;----------------------------------------------------------
ORG 30H			;Jump to M/M location 30H
DB 00H, 55H, 0AAH, 0FFH	;Define the bytes at 30H-33H. Interestingly '#' is not required before the numbers here.

END
