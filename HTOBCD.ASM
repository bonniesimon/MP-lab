ASSUME CS:CODE,DS:DATA

DATA SEGMENT
HEXN DB 5 DUP(?)
BCDN DW 1 DUP(?)
MS1 DB 0DH, 0AH, "Enter HEX number:-> $"
MS2 DB 0DH, 0AH, "Result in BCD:-> $"
DATA ENDS

CODE SEGMENT
START:  MOV AX,DATA
	MOV DS,AX
        MOV DX, OFFSET MS1
        MOV AH,09H
        INT 21H
        MOV DX, OFFSET HEXN
        MOV AH,3FH
        INT 21H
	MOV DX,0000H
	MOV CL,04
	LEA SI,HEXN
 LABEL1:MOV AL,[SI]
        CMP AL,48H
        JZ CONVERT
        CMP AL,39H
        JG LABEL5
        AND AL,0FH
        JMP LABEL2
 LABEL5:SUB AL,37H 
 LABEL2:SHL DX,CL
        ADD DL,AL
        INC SI
        JNE LABEL1
CONVERT:LEA DI,BCDN
	MOV [DI],DX
        MOV DX, OFFSET MS2
        MOV AH,09H
        INT 21H
	MOV AX,[DI]
        MOV BX,10
        MOV CL,00
 LABEL3:MOV DX,0000H
        DIV BX
        PUSH DX
        INC CL
        CMP AX,0
        JNE LABEL3  
 LABEL4:POP DX
        ADD DX,30H
        MOV AH,02H
        INT 21H
        LOOP LABEL4
        MOV AH,4CH
        INT 21H
CODE ENDS
END START 