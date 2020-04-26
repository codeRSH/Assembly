;Program to find the decimal equivalent of hexadecimal number.
;codeRSH	DS: 03.18.2011	DE: 03.18.2011

ORG 00H		;Program will be loaded in RAM from 00H

MOV P1, #0FFH	;All 1s in P1 to make it an input port

MOV A, P1		;Load value from Port to Accumulator

MOV B, #10		;We divide each digit by 10
DIV AB
MOV R2, B		;Move first remainder (LSB of decimal number) to R2

MOV B, #10		;Divide the quotient of previous devision again by 10
DIV AB
MOV R3, B		;Move 2nd remainder to R3

MOV B, #10
DIV AB
MOV R4, B

END
