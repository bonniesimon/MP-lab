ASSUME CS: CODE, DS: DATA

DATA SEGMENT
PROMPT_1  DB  'Enter a Decimal number: $'
ILLEGAL   DB  0DH,0AH,'INVALID character.$'
INP DW ?
DATA ENDS

CODE SEGMENT

START:      MOV AX, DATA
            MOV DS, AX
	    LEA DX, PROMPT_1           
	MOV AH, 9
     	INT 21H
JMP READ               

   ERROR:                 
   LEA DX, ILLEGAL           
   MOV AH, 9                        
   INT 21H

   READ:              
   XOR BX, BX            
   XOR CX, CX         

   MOV AH, 1       
   INT 21H          

   CMP AL, "-"   
   JE MINUS       

   CMP AL, "+"              
   JE PLUS               
   JMP INPUT         

   MINUS:              
   MOV CX, 1         

   PLUS:              
   INT 21H                
   CMP AL, 0DH           
   JE ENDA               

   INPUT:    
     CMP AL, 30H    
     JL ERROR                

     CMP AL, 39H             
     JG ERROR               

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
     JNE INPUT                
                                   
   ENDA:                       

   OR CX, CX               
   JE EXIT                   
   NEG BX                 

   EXIT:  MOV INP, BX          
	JMP L1

L1: MOV AX, INP
	MOV CX, 0
	AND DX, 0
LABEL1: CMP AX, 0
	JE PRINT1
	MOV BX, 16
	DIV BX
	PUSH DX
	INC CX
	XOR DX, DX
	JMP LABEL1
PRINT1: CMP CX, 0
	JE EX2
	POP DX
	CMP DX, 9
	JLE CONTINUE
	ADD DX, 7
CONTINUE: ADD DX, 48
	  MOV AH, 02H
	  INT 21H
	  DEC CX
	  JMP PRINT1
EX2: MOV AH, 4CH
	INT 21H



CODE ENDS
        END START
