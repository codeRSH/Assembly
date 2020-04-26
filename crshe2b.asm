;Program to clear the contents of RAM locations 30H-7FH & then read the data from Port P1 and P2 and store it at even and odd M/M locations resp.
;codeRSH	DS:03.19.2011	DE:03.19.2011

ORG 00H

ACALL PROCEDURE	;since target 'PROCEDURE' is within 2KB range of this instruction ACALL can be used

AGAIN: 	MOV @R1, #00H	;Clear M/M location pointed by R1
INC R1
DJNZ R2, AGAIN				;Loop till all bytes are cleared

MOV P1, #0FFH				;Send all 1's to P1 and P2
MOV P2, #0FFH				;to make them input ports.

ACALL PROCEDURE

THERE:	MOV A, R1
JB ACC.0, ODD				;Check A.0 (since it is bit addressable), if it is set means M/M location is odd
MOV @R1, P1					;If A.0 is not set it means M/M location is even, so save input from P1
JMP OVER
ODD:		MOV @R1, P2
OVER:	INC R1
DJNZ R2, THERE


ORG 30H
PROCEDURE:
	MOV R1, #30H		;We are using R1 as pointer to M/M location 30H-7FH
	MOV A, #7FH
	MOV B, R1

	CLR CY				;Simple A-B requires Carry flag to be cleared.

	SUBB A, B			;Accumulator contains the number of M/M location to traverse
	MOV R2, A			;Using R2 to cycle from 30H-7FH

	RET

END
