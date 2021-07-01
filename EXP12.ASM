ASSUME CS:CODE,DS:DATA


PRINTS MACRO P
MOV DX, OFFSET P
MOV AH,09H
INT 21H
ENDM


READS MACRO S
MOV DX, OFFSET S
MOV AH,3FH
INT 21H
ENDM

DATA SEGMENT
	MSG1 DB "ENTER YOUR HEX : $"
        MSG2 DB "BCD Form : $"
	NUM DW 1 DUP(?)
	NUMS DB 5 DUP(?)
                L DB 0AH,0DH,"$"
DATA ENDS

CODE SEGMENT
START:  MOV AX,DATA
	MOV DS,AX

	PRINTS MSG1
	PRINTS L
	READS NUMS

	
	MOV DX,0000H
	MOV CL,04
	LEA SI,NUMS

        ;--- The user input is in char
        ;--- we need to convert char to hex
        ;--- i.e if someone enters F, it will be in char form
        ;--- we need to convert it to hex F
L1:     MOV AL,[SI]
        CMP AL,48H ;---48h is hex equivalent of 'H'
        JZ CON
        CMP AL,39H ;---39h = 9
        JG ST1  
        AND AL,0FH ;--- if it is a digit, we only need last 4 bits
        JMP L2

ST1: SUB AL,37H ;---for F value is 46h. so 46h - 37h = F
        
L2:     SHL DX,CL
        ADD DL,AL
        INC SI
        JNE L1

        ;Converting Hex to BCD
CON:
	LEA DI,NUM
	MOV [DI],DX

	PRINTS MSG2
	PRINTS L
	MOV AX,[DI]
        MOV BX,10
        MOV CL,00
L3:     MOV DX,0000H
        DIV BX ;---Gets the last digit as remainder in DX
        PUSH DX
        INC CL
        CMP AX,0
        JNE L3
        
L4:     POP DX
        ADD DX,30H
        MOV AH,02H
        INT 21H
        LOOP L4

        MOV AH,4CH
        INT 21H

CODE ENDS
END START 
