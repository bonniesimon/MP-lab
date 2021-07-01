ASSUME CS:CODE, DS:DATA

DATA SEGMENT
INPMSG DB 0DH, 0AH, "ENTER THE STRING :: $"
REVMSG DB 0DH, 0AH, "REVERSE OF STRING :: $"
PALMSG DB 0DH, 0AH, "INPUT IS PALINDROM.$"
NOTMSG DB 0DH, 0AH, "INPUT STRING NOT PALINDROME.$"
STRING DB 80H DUP(?)
RSTRING DB 80H DUP(?)
DATA ENDS

CODE SEGMENT
START:  MOV AX, DATA
        MOV DS, AX

        ;-----DISPLAY INPUT MESSAGE
        MOV DX, OFFSET INPMSG                
        MOV AH, 09H
        INT 21H
        ;------TAKE STRING FROM KEYBOARD CHARECTER BY CHARECTER
        MOV SI, OFFSET STRING
        MOV CX, 0000H
AGAIN:  MOV AH, 01H
        INT 21H
        CMP AL, 0DH
        JE NEXT
        MOV [SI], AL
        INC SI
        INC CL
        JMP AGAIN
NEXT:   MOV [SI], BYTE PTR '$'
        ;-----STRING INPUT FINISHED
        DEC SI
        MOV CH, CL
        ;-----REVERSE AND STORE IN RSTRING
        MOV DI, OFFSET RSTRING
BACK:   MOV AL, [SI]
        MOV [DI], AL
        DEC SI
        INC DI
        DEC CH
        JNZ BACK ;-----CHECKS IF COUNTER = 0
        ;-----REVERSING FINISHED
        MOV [DI], BYTE PTR '$'

        ;-----DISPLAY REVERSE STRING MESSAGE
        MOV DX, OFFSET REVMSG
        MOV AH, 09H
        INT 21H
        ;-----DISPLAY REVERSED STRING
        MOV DX, OFFSET RSTRING
        MOV AH, 09H
        INT 21H

        ;-----COMPARE STRING AND RSTRING
        MOV SI, OFFSET STRING
        MOV DI, OFFSET RSTRING
LOOPAG: MOV AL, [SI]
        CMP AL, [DI]
        JNE FAIL
        INC SI
        INC DI
        DEC CX
        JZ SUCCESS
        JMP LOOPAG
FAIL:   ;-----DISPLAY FAIL MSG
        MOV DX, OFFSET NOTMSG
        MOV AH, 09H
        INT 21H
        JMP FINAL
SUCCESS:        ;-----DISPLAY SUCCESS MSG
        MOV DX, OFFSET PALMSG
        MOV AH, 09H
        INT 21H

FINAL:  MOV AH, 4CH
        INT 21H


CODE ENDS
        END START
