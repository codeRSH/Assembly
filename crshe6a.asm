;Program to generate a 2 Hz wave of 50% duty cycle using Timer 1 in Mode 1
; codeRSH	DS: 03.31.2011	DE: 04.03.2011


ORG 00H

MOV TMOD, #10H		; TMOD register used to set Timer Mode

REPT:
MOV R0, #7			; Repeat loop 7 times to generate ON period of .25 secs
SETB P1.0			; Set ON
MOV TH1, #00H
MOV TL1, #00H

BACK1: CLR TF1
SETB TR1			; Start the timer
AGN1: JNB TF1, AGN1	; Timer Flag gets set when the timer rolls over
CLR TR1
DJNZ R0, BACK1


MOV R0, #7			; To keep OFF for 0.25 sec loop 7 times
CLR P1.0			; Set OFF
MOV TH1, #00H
MOV TL1, #00H

BACK2: CLR TF1		; Clear the timer flag
SETB TR1
AGN2: JNB TF1, AGN2
CLR TR1
DJNZ R0, BACK2

SJMP REPT			; Repeat the pulse again to create the wave

END
