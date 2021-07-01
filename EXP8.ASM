ASSUME DS:DATA, CS:CODE

DATA SEGMENT
ARR DB 0A5H,0DCH,88H,05H,0ABH  
DATA ENDS

CODE SEGMENT
START:  MOV AX, DATA
        MOV DS, AX
  
        MOV AX, 0000H
        MOV CH, 05H
L1:     MOV CL, 05H
        LEA SI, ARR
L2:     MOV AL, ARR[SI]
        MOV BL, ARR[SI+1]
        CMP AL, BL
        JC L3
        MOV DL, ARR[SI]
        XCHG ARR[SI+1], DL
        MOV ARR[SI], DL
L3:     INC SI
        DEC CL
        JNZ L2
        DEC CH
        JNZ L1

        MOV AH, 4CH
        INT 21H
CODE ENDS
        END START
