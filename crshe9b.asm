; Program to display counter from 00 to 99 using 7 segment displays.
; codeRSH	DS: 04.03.2011	DE: 04.03.2011

ORG 00H

MOV R0, #0	; Pointer for lower counter
MOV R1, #0	; Pointer for upper counter
MOV DPTR, #60H	; 7 seg values for digit saved at 60H M/M location
SETB P3.3	
CLR	P3.4	

STRT:
	SETB P3.3	; Set the 2nd..
	CLR	P3.4	; ..7-seg display
	MOV A, R1
	MOVC A, @A+DPTR
	MOV P1, A	; Show value on the display

	ACALL DELAY
	MOV P1, #0FFH	; Clears P1 i.e. LED of previous content.
	CJNE R1, #9, HERE
	MOV R1, #0FFH	; If R1 reaches 9 then roll over. FFH = -1
	HERE: INC R1

RPT:
	CLR P3.3	; Set the 1st.. 
	CLR P3.4	; ..7-seg Display
	MOV A, R0
	MOVC A, @A+DPTR	; Load in A value stored at specified M/M location.
	MOV P1, A	; Only P1 is connected to 7-seg display, so counters will have to be multiplexed.

	ACALL DELAY
	MOV P1, #0FFH
	CJNE R0, #9, THERE
	MOV R0, #0H
	SJMP STRT		; If smaller counter rolls over go to higher counter
	THERE: INC R0
	SJMP RPT

DELAY:
	MOV R2, #1	; Loop inside loop used for delay
	MORE: MOV R3, #1
	AGAIN: DJNZ R3, AGAIN
	DJNZ R2, MORE
	RET

ORG 60H
; These are hex codes for digits to be displayed on 7-seg Display. These are active-low values
DB C0H, 0F9H, 0A4H, 0B0H, 99H, 92H, 83H, F8H, 80H, 98H

END
