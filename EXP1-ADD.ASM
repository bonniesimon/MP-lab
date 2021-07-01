ASSUME DS:DATA, CS:CODE

DATA SEGMENT
NUM1 DW 0FFFFH
NUM2 DW 0FFFFH
NUM3 DW 0EEEEH
SUM DW 1 DUP(?)
CARRY DW 1 DUP(?)
DATA ENDS

CODE SEGMENT
START : MOV AX, DATA
        MOV DS, AX

        MOV CX, 0000H
        MOV AX, NUM1
        MOV BX, NUM2
        ADD AX, BX
        JNC L1
        INC CX
L1:     MOV BX, NUM3
        ADD AX, BX
        JNC L2
        INC CX
L2:     MOV SUM, AX
        MOV CARRY, CX

        MOV AH, 4CH
        INT 21H
CODE ENDS
        END START

