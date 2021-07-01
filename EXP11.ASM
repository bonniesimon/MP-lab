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
        MSG2 DB 0DH, 0AH, "ENTER THE SUBSTRING TO BE FOUND :: $"
        MSG3 DB 0DH, 0AH, "ENTER THE SUBSTRING REPLACEMENT :: $"
        SUSS DB 0DH, 0AH, "SUBSTRING FOUND!!$"
        FAIL DB 0DH, 0AH, "SUBSTRING NOT FOUND!$"
        LENS DB 1 DUP(?)
        LENSB DB 1 DUP(?)
        STR DB 80H DUP(0)
        FIND DB 80H DUP(0)
        SBSTR DB 80H DUP(0)
        RESULT DB 80H DUP('$')
        I DW ?
        J DW ?
DATA ENDS

CODE SEGMENT
START:  MOV AX, DATA
        MOV DS, AX

        ;-----DISPLAY INPUT MSG
        DISPLAY MSG1
        ;------ INPUT STRING
        MOV SI, OFFSET STR
        MOV CX, 0000H
AGAIN:  MOV AH, 01H
        INT 21H
        CMP AL, 0DH
        JE NEXT
        MOV [SI], AL
        INC SI
        INC CL
        JMP AGAIN
NEXT:  ;------STRING INPUT FINISHED
        ;----MOVING LENGTH OF STRING TO LENS
        MOV LENS, CL

        ;----DISPLAY INPUT SUBSTRING MSG
        DISPLAY MSG2

        ;----INPUTING FIND STRING
        MOV SI, OFFSET FIND
        MOV CX, 0000H
AGAIN1:  MOV AH, 01H
        INT 21H
        CMP AL, 0DH
        JE NEXT1
        MOV [SI], AL
        INC SI
        INC CL
        JMP AGAIN1
NEXT1:  ;----FIND INPUT FINISHED
        ;---MOV LENGTH OF STRSB TO LENSB
        MOV LENSB, CL

        ;----DISPLAY INPUT MSG
        DISPLAY MSG3
        ;----INPUT SUBSTRING REPLACEMENT
        MOV SI, OFFSET SBSTR
AGAIN2: MOV AH, 01H
        INT 21H
        CMP AL, 0DH
        JE NEXT2
        MOV [SI], AL
        INC SI
        JMP AGAIN2
NEXT2:  ;----SBSTR INPUT FINISHED

        MOV I, OFFSET STR
        MOV J, OFFSET RESULT
        MOV SI, I
        LEA DI, FIND
SEARCH: MOV AL, [DI]
        CMP AL, 0
        JE MATCH
        CMP BYTE PTR [SI], 0
        JE MISMATCH
        CMP [SI], AL
        JNE MISMATCH
        INC SI
        INC DI
        JMP SEARCH
MATCH:  MOV I, SI
        DEC I
        LEA DI, SBSTR

REPLACE:
        MOV AL, [DI]
        CMP AL, 0
        JE NEXT3
        MOV SI, J
        MOV [SI], AL
        INC J
        INC DI
        JMP REPLACE

MISMATCH:
        MOV SI, I
        MOV DI, J
        MOV AL, [SI]
        MOV [DI], AL
        INC J
NEXT3:  LEA DI, FIND
        INC I
        MOV SI, I
        CMP BYTE PTR [SI], 0
        JNE SEARCH
FINAL:  DISPLAY RESULT

        MOV AH, 4CH
        INT 21H

CODE ENDS
        END START


