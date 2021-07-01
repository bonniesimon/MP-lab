ASSUME CS: CODE, DS: DATA

DATA SEGMENT
NUM  DB  'Enter Decimal Number-> $'
DECN DW ?
DATA ENDS

CODE SEGMENT
START:  
      MOV AX, DATA
      MOV DS, AX
      LEA DX, NUM
	MOV AH, 9
     	INT 21H                           
      MOV BX,0000H
      MOV CX,0000H     
      MOV AH, 1       
      INT 21H          
      INPUT:AND AX, 000FH       
      PUSH AX             
      MOV AX, 10                
      MUL BX                 
      MOV BX, AX            
      POP AX               
      ADD BX, AX           
      MOV AH, 1           
      INT 21H                
      CMP AL, 0DH              
      JNE INPUT
      MOV DECN, BX          
      LABEL1: MOV AX, DECN
      MOV CX, 0
      AND DX, 0
      LABEL2:CMP AX, 0
      JE PRINT
      MOV BX, 16
      DIV BX
      PUSH DX
      INC CX
      MOV DX, 0000H
      JMP LABEL2
      PRINT: CMP CX, 0
      JE FINAL
      POP DX
      CMP DX, 9
	JLE NEXT
	ADD DX, 7
      NEXT: ADD DX, 48
      MOV AH, 02H
      INT 21H
      DEC CX
      JMP PRINT
      FINAL:MOV AH, 4CH
	INT 21H
CODE ENDS
END START