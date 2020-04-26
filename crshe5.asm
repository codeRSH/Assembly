; Program to read the I/P from 2x2 keypad and display on LED. Also if more than 1 key is pressed than all LEDs blink indicating error condition.
; codeRSH	DS: 03.30.2011		DE: 04.03.2011

ORG 00H

MOV P1, #00H	; Make P1 O/P port
MOV P2, #0FFH	; Make P2 I/P port

REPT: 
MOV R0, P2		; Save I/P in R0

MOV A, R0		; Lower 4 bits indicate I/P.
XRL A, #0F7H	; XOR with 11110111 (4th key pressed)
JZ CRRCT		; Zero indicates that A contains I/P for 4th key pressed
MOV A, R0
XRL A, #0FBH
JZ CRRCT		; 0 indicates that A contain I/P for 3rd key press. Go to label CRRCT to display
MOV A, R0
XRL A, #0FDH	; All inputs and outputs are active low. Hence comparing with "11111101" rather than "00000010"
JZ CRRCT
MOV A, R0
XRL A, #0FEH
JZ CRRCT
MOV A, R0
XRL A, #0FFH	; If no key pressed.
JZ CRRCT

ACALL INCRCT	; If more than 1 key pressed, go to procedure INCRCT
SJMP REPT

CRRCT: MOV P1, R0
SJMP REPT


ORG 50H
INCRCT:
MOV A, #0FFH

MOV R5, #02		; Triple loop inside loop used here.
AGAIN: CPL A
MOV P1, A
MOV R3, #01
THERE: MOV R4, #01
HERE: DJNZ R4, HERE
DJNZ R3, THERE
DJNZ R5, AGAIN
RET

END