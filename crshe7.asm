; Program to send the name serially from uC to PC.
; codeRSH 	DS: 04.03.2011			DE: 04.03.2011

ORG 00H

MOV A, PCON	; Since EdSim's UART doesn't support baud rate..
SETB ACC.7	; .. of 9600. So doubling it to 19200 using PCON reg
MOV PCON, A	; This is the way to use, since PCON is not bit-addressable

MOV DPTR, #60H	;Value to be displayed is stored at 60h location
MOV TMOD, #20H	; Set Timer 1 Mode 2
MOV TH1, #-3	; Load T1 to set baud rate of 9600 * 2
MOV SCON, #50H	; 1 start, 1 stop bit with no parity mode.
SETB TR1		; start the timer

RPT: CLR A
MOVC A, @A+DPTR	; Load character from ROM in Accumulator
JZ EXIT			; If last character then exit

MOV SBUF, A	; Send the character
AGAIN: JNB TI, AGAIN	; Loop till last bit of character not sent serially.
CLR TI		; Clear Transmit Interrupt flag to enable transmission of next character

INC DPTR	; DPTR now points to next character
SJMP RPT	; Repeat again

EXIT: SJMP EXIT

; ------------------
ORG 60H
DB "codeRSH"		;Text to send
DB 0

END
