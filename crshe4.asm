;Program to glow LED's in different patterns
;codeRSH	DS:03.19.2011	DE:03.19.2011


ORG 00H			;All programs start at M/M locatin 00H

MOV P1, #00		;Assume LED's connected to Port 1. Make P1 an output port by sending all 0's
;------------------Main Program-----------------

MOV B, #08H		;Run the whole pattern 8 times

CLR P3.3		;These 3 statements are required
CLR P3.4		;to make the LED bank glow
SETB P0.7		;may not be necessary in other IDEs

MORE: MOV A, #00
MOV P1, A		;All LEDs off
ACALL DELAY		;Call the delay routine
CPL A
MOV P1, A		;All ON
ACALL DELAY
MOV P1, #55H		;Alternating Off
ACALL DELAY
MOV P1, #0AAH		;Alternating On

MOV A, #80H
MOV R0, #8		;Loop 8 times for 8 bits

AGAIN:RL A		;Next bit gets set
MOV P1, A
ACALL DELAY
DJNZ R0, AGAIN

MOV R0, #8

HERE: RR A		;Previous bit gets set
MOV P1, A
ACALL DELAY
DJNZ R0, HERE

DJNZ B, MORE		;Run the whole pattern again

ENDP: NOP		;End of Main program

;--------------------------------------
DELAY:			;Counters in this delay routine will vary according to the amount of delay required.
	MOV R2, #1
J1: 	MOV R3, #1
J2: 	DJNZ R3, J2
	DJNZ R2, J1
	RET


END

