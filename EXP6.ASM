ASSUME DS:DATA, CS:CODE

DATA SEGMENT
ARR DW 0AAAAH, 6534H, 0012H, 0AABBH, 8888H
LAR DW 1 DUP(?)
SMA DW 1 DUP(?)
DATA ENDS

CODE SEGMENT
START:  MOV AX, DATA
        MOV DS, AX

        MOV CX, 0000H
        MOV CL, 05H
        LEA SI, ARR
        MOV BX, ARR [SI]
        MOV AX, 0000H
L1:     CMP AX, ARR[SI]
        JNC L2
        MOV AX, ARR[SI]
L2:     CMP ARR[SI], BX
        JNC L3
        MOV BX, ARR[SI]
L3:     INC SI
        INC SI
        LOOP L1
        MOV LAR, AX
        MOV SMA, BX

        MOV AH, 4CH
        INT 21H
CODE ENDS
        END START
