;Program to generate a 0.5 Hz wave of 75% duty cycle using Timer 0 in Mode 1.
; codeRSH	DS: 03.31.2011	DE: 04.03.2011


ORG 00H

MOV TMOD, #01H		; TMOD register used to set Timer Mode

REPT:
MOV R0, #42			; Repeat loop 42 times to generate ON period of 1.5 secs
SETB P1.1			; Set ON
MOV TL0, #00H
MOV TH0, #00H

BACK1: CLR TF0
SETB TR0			; Start the timer
AGN1: JNB TF0, AGN1	; Timer Flag gets set when the timer rolls over
CLR TR0
DJNZ R0, BACK1


MOV R0, #14			; To keep OFF for 0.5 sec loop 14 times
CLR P1.1			; Set OFF
MOV TL0, #00H
MOV TH0, #00H

BACK2: CLR TF0		; Clear the timer flag
SETB TR0
AGN2: JNB TF0, AGN2
CLR TR0
DJNZ R0, BACK2

SJMP REPT			; Repeat the pulse again to create the wave

END
