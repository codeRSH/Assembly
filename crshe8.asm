; Program to send an ASCII value from PC to uC, convert to binary and then display it on LEDs connected to P0. Also generate a square wave of 1Hz on P2.0
; codeRSH	DS: 04.03.2011		DE: 04.04.2011

ORG 00H
LJMP MAIN

ORG 0BH		; ISR for Timer 0
DJNZ R0, OVER
MOV R0, #14
CPL P1.0
OVER: RETI

ORG 23H		; ISR for Serial should be stored at this location
LJMP SERIAL

ORG 30H		; Look up table
DB 0H, 1H, 2H, 3H, 4H, 5H, 6H, 7H, 8H, 9H

ORG 60H
MAIN:			; Main Program
MOV R0, #14		; Timer 0 loops 14 times to get a wave of 1Hz.
MOV DPTR, #00H
MOV IE, #10010010B	; Enable Serial and Timer 0 Interrupt
MOV TMOD, #21H
MOV TH1, #-6
MOV TL0, #00H
MOV TH0, #00H
MOV SCON, #50H

SETB TR1	; Start Timer 1
SETB TR0	; Start Timer 0

AGAIN: SJMP AGAIN	; Continuosly loop here until an interrupt occurs


ORG 90H
SERIAL:			; Serial Reception ISR
MOV A, SBUF
MOVC A, @A+DPTR	; Conversion from ASCII to binary using look up table
MOV P1, A
CLR RI
RETI

END