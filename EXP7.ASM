ASSUME DS:DATA, CS:CODE

DATA SEGMENT
ARR DB 05H, 0CCH, 78H, 0ABH, 0BEH, 15H, 98H, 45H
LEN DW 0008H
TEMP DB 1 DUP(?)
ANS DB 1 DUP(?)
CARRY DB 1 DUP(?)
DATA ENDS

CODE SEGMENT
START:  MOV AX, DATA
        MOV DS, AX

        MOV DX, 0000H
        MOV CX, LEN
        MOV AX, 0000H
        MOV BX, 0000H
        LEA SI, ARR
L1:     MOV BL, ARR[SI]
        MOV TEMP, BL
        ROR BL, 1
        JC L2
        ADD AL, TEMP
        JNC L2
        INC DL
L2:     INC SI
        MOV BX, 0000H
        LOOP L1
        MOV ANS, AL
        MOV CARRY, DL

        MOV AH, 4CH
        INT 21H

CODE ENDS
        END START
