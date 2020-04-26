; Program to do arithmetic operations on given numbers
; codeRSH	DS: 03.20.2011	DE: 03.20.2011


ORG 0000
MOV R0, #30H	;Save data from this location in RAM

LCALL MOVDATA	;call MOVDATA procedure
ADD A, B		;Adds values in A and B and puts it in A
MOV @R0,A		;Mov value of A in RAM location pointed by RO
INC R0			;Go to next M/M location

LCALL MOVDATA
CLR CY			;clear the carry flag
SUBB A, B		;A = A - B - CY
MOV @R0, A		
INC R0

LCALL MOVDATA
MUL AB			;A*B Put Higher byte in B and lower in A
MOV @R0, A		
INC R0
MOV @R0, B
INC R0

LCALL MOVDATA
DIV AB			;A/B Quotient goes in A, Remainder in B
MOV @R0, A
INC R0
MOV @R0, B

MOVDATA:		;MOVDATA procedure
	MOV A, #32H	;1st Number
	MOV B, #12H	;2nd Number
	RET			;Return Back to next instruction at the point of call.		

END				;End of Program
