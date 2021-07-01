ASSUME CS:CODE, DS:DATA

DATA SEGMENT
NUM1 DW 1234H
NUM2 DW 3214H
SUM DW 1 DUP(?)
DATA ENDS

CODE SEGMENT
START:  MOV AX, DATA
        MOV DS, AX
        MOV AX, NUM1
        MOV BX, NUM2
        ADD AX, BX
        MOV SUM, AX

        MOV AH, 4CH
        INT 21H
CODE ENDS
        END START
                                                                                                                                                                                                                        
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
