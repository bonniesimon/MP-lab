ASSUME CS: CODE, DS: DATA

DATA SEGMENT
M  DB  'Num: $'
M1  DB  'ERROR ! $'
N1 DW ?
DATA ENDS

CODE SEGMENT

START:  MOV AX, DATA
        MOV DS, AX
	LEA DX, M           
	MOV AH, 9
     	INT 21H         
    
        MOV BX, 0000            
        MOV CX, 0000
        ;---reading from keyboard in ascii form into AL
        MOV AH, 1       
   	INT 21H

L1:  CMP AL, 30H    
     	JL ERR                
	CMP AL, 39H             
        JG ERR               
	AND AX, 000FH       
        PUSH AX             
        MOV AX, 10                
     	MUL BX                 
     	MOV BX, AX            
	POP AX               
     	ADD BX, AX       
    
     	MOV AH, 1         
  
     	INT 21H                
     	CMP AL, 0DH              
     	JNE L1                                                                 
	MOV N1, BX          
 	MOV AX, N1
	MOV CX, 0
	MOV DX, 0
L2: CMP AX, 0
	JE LABEL1
	MOV BX, 16
	DIV BX
	PUSH DX
	INC CX
	MOV DX, 0
	JMP L2
LABEL1: CMP CX, 0
	JE L3
	POP DX
	CMP DX, 9
	JLE LABEL2
	ADD DX, 7
LABEL2: ADD DX, 48
	  MOV AH, 02H
	  INT 21H
	  DEC CX
	  JMP LABEL1
ERR: LEA DX, M1           
	MOV AH, 9
     	INT 21H
L3: MOV AH, 4CH
	INT 21H
CODE ENDS
        END START
