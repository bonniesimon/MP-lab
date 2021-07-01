ASSUME DS:DATA, CS:CODE

DATA SEGMENT
STR1 DB "Bonnie7$"
SMA DB 1 DUP(?)
CAP DB 1 DUP(?)
MSG1 DB 0DH, 0AH, "UPPERCASE COUNT :  $"
MSG2 DB 0DH, 0AH, "LOWERCASE COUNT :  $"
DATA ENDS

CODE SEGMENT
START:  MOV AX, DATA
        MOV DS, AX

        MOV AX, 0000H
        MOV SMA, AL
        MOV CAP, AL
        MOV BX, AX
        MOV BH, '$'
        MOV SI, OFFSET STR1
L1:     MOV BL, [SI]
        CMP BL, BH
        JE ENDL

        ;-----CHECK IF NOT A ALPHABET
        CMP BL, 'A'
        JL L2
        CMP BL, 'z'
        JG L2

        ;-----CHECK IF ALPHABET & AND WHICH CASE
        CMP BL, 'a'
        JNC LOWL  ;-----IF BL > a, JMP TO LOWL
        CMP BL, 'Z'
        JC UPPL   ;-----IF BL < Z, JMP TO UPPL
        JMP L2

LOWL:   INC SMA
        INC AL
        JMP L2
UPPL:   INC CAP
        INC AH
        JMP L2

L2:     INC SI
        JMP L1

ENDL:   ;-----DISPLAYING UPPERCASE COUNT
        MOV DX, OFFSET MSG1
        MOV AH, 09H
        INT 21H
        MOV AL, CAP    ;-----MOV THE VALUE TO BE DISPLAYED TO AL
        ADD AL, 30H    ;-----CONVERTING DECIMAL NUMBER TO HEX
        MOV AH, 0EH    ;-----0EH IS THE FUNCTION TO DISPLAY ON SCREEN
        INT 10H
        ;-----DISPLAYING A SPACE
        MOV AL, 20H
        MOV AH, 0EH
        INT 10H
        ;-----DISPLAYING LOWERCASE COUNT
        MOV DX, OFFSET MSG2
        MOV AH, 09H
        INT 21H
        MOV AL, SMA    ;------STEPS SIMILAR TO ABOVE SEQUENCE
        ADD AL, 30H
        MOV AH, 0EH
        INT 10H   
        MOV AH, 4CH
        INT 21H

CODE ENDS
        END START
