; Program for the H2FC in 8051 Assembly
; codeRSH

ORG 00H

SJMP MAIN

;------------MAIN PROGRAM-----------
MAIN:
MOV P3, #00H	; Make P3 output port
MOV P1, #00H	; Make P1 output port
MOV P2, #0FFH	; Make P2 Input port
MOV P0, #0FFH	; Make P0 Input port

REPT:
MOV A, P1		; Take the water level signal
MOV P2, A		; Move signal to water level indicator

MOV A, P3		; Take signal from rate controller
JB ACC.0, HIG	; Find which key is set
JB ACC.1, MID	; Highest priority is given to Hig then Mid and then Lo
JB ACC.2, LO	; Jump according to the bit set

HIG:
MOV R0, #255	; Make On period large
MOV R1, #0FH	; Make Off period small
ACALL PWM		; Call PWM procedure
SJMP REPT		; Repeat again

MID:
MOV R0, #125
MOV R1, #1FH
ACALL PWM
SJMP REPT

LO:
MOV R0, #25		; Make Off period small
MOV R1, #0FFH	; Make On period large
ACALL PWM
SJMP REPT


;----------- PWM Procedure -----------

PWM:
MOV TMOD, #01		; Set Mode of Timer 0 to 1

HERE:
MOV TH0, #00H		; Load Timer 0 to initial value of #0000h
MOV TL0, #00H

CLR TF0				; Clear Timer Flag
SETB TR0			; Start the Timer
AGAIN: JNB TF0, AGAIN
CLR TR0				; Stop the Timer
SETB P0.0		; Keep PWM signal ON
DJNZ R0, HERE


THERE:
MOV TH0, #00H
MOV TL0, #00H

CLR TF0
SETB TR0
AGAIN1: JNB TF0, AGAIN1		; Check for the Flag
CLR TR0
CLR P0.0		; Keep PWM signal Off
DJNZ R1, THERE	; Loop Again

RET				; Return from Procedure

END					; End of Program