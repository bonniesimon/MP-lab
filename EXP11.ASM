ASSUME DS:DATA, CS:CODE

;----AFFECTED REGISTERS: AH, DX
DISPLAY MACRO MSG
        MOV AH, 09H
        LEA DX, MSG
        INT 21H
ENDM

;----AFFECTED REGISTERS: AH, DL
DISPLAYCHAR MACRO CHA
        MOV AH, 02H
        MOV DL, CHA
        INT 21H
ENDM

DISPLAYINT MACRO NUM
        MOV AH, 02H
        MOV DL, NUM
        ADD DL, 30H
        INT 21H
ENDM

DATA SEGMENT
        MSG1 DB 0DH, 0AH, "ENTER THE STRING :: $"
        MSG2 DB 0DH, 0AH, "ENTER THE SUBSTRING :: $"
        SUSS DB 0DH, 0AH, "SUBSTRING FOUND!!$"
        FAIL DB 0DH, 0AH, "SUBSTRING NOT FOUND!$"
        LENS DB 1 DUP(?)
        LENSB DB 1 DUP(?)
        STR DB 80H DUP(?)
        STRSB DB 80H DUP(?)
        TEMP DB 1 DUP(?)
DATA ENDS

CODE SEGMENT
START:  MOV AX, DATA
        MOV DS, AX

        ;-----DISPLAY INPUT MSG
        DISPLAY MSG1
        ;------ INPUT STRING
        MOV SI, OFFSET STR
        MOV CX, 0000H
AGAIN1:  MOV AH, 01H
        INT 21H
        CMP AL, 0DH
        JE NEXT1
        MOV [SI], AL
        INC SI
        INC CL
        JMP AGAIN1
NEXT1:   MOV [SI], BYTE PTR '$'
        ;------STRING INPUT FINISHED
        ;----MOVING LENGTH OF STRING TO LENS
        MOV LENS, CL

        ;----DISPLAY INPUT SUBSTRING MSG
        DISPLAY MSG2

        ;----INPUTING SUBSTRIN
        MOV SI, OFFSET STRSB
        MOV CX, 0000H
AGAIN2:  MOV AH, 01H
        INT 21H
        CMP AL, 0DH
        JE NEXT2
        MOV [SI], AL
        INC SI
        INC CL
        JMP AGAIN2
NEXT2:  MOV [SI], BYTE PTR '$'
        ;----STRSB INPUT FINISHED
        ;---MOV LENGTH OF STRSB TO LENSB
        MOV LENSB, CL

        ;----TODO: CONVERT LENS AND LENSB TO DW
        ; SO THAT WE CAN USE CX AND DX
        ;----FOR USING LOOP
        ;AS IN THE MRSARAF25 GITHUB REPO
        MOV CL, LENS ;----LENGTH OF STRING IN CX
        MOV BL, LENSB ;----LENGTH OF SUBSTRING IN BX
        MOV CH, 00H
        MOV BH, 00H
        MOV DX, 0000H ;----TO CHECK THE LENGTH OF POTENTION SUBSTRING IN THE STRING
        ;DISPLAYINT CH
        ;DISPLAYINT CL

        MOV SI, 0000H
        MOV DI, 0000H
        CLD
L1:     MOV AL, STRSB[DI] 
        CMP STR[SI], AL
        JE MATCH
        MOV DI, 0000H
        MOV DX, 0000H
        INC SI
        MOV AL, STR[SI]
        CMP AL, '$'
        JE CHECK
        JMP L1
MATCH:  INC DX
        INC SI
        INC DI
        CMP BX, DX
        JNZ L1

CHECK:  CMP BX, DX
        JNZ NFD
        DISPLAY SUSS
        JMP FINAL

NFD:    DISPLAY FAIL

FINAL:  MOV AH, 4CH
        INT 21H

CODE ENDS
        END START


