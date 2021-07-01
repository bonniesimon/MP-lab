ASSUME CS: CODE, DS: DATA

DATA SEGMENT
SUBSTR1 db 100 dup('$')
REPLS     db 100 dup('$')
SUBST    db 100 dup('$')
FINA   db 100 dup('$')
FIR        dw ?       
LAS        dw ?          
MS1   DB 0DH, 0AH, "ENTER STRING=>$"
MS2   DB 0DH, 0AH, "ENTER SUBSTRING FROM ABOVE STRING->$"
MS3   DB 0DH, 0AH, "ENTER SUBSTRING TO BE CHANGED->$"
MS4   DB 0DH, 0AH, "FINAL->$"
DATA ENDS

CODE SEGMENT
start:   MOV AX, DATA
        MOV DS, AX
        
	MOV SI, OFFSET SUBSTR1
   LEA DX,MS1
    MOV AH, 09H
    INT 21H
LABEL1: MOV AH,1
        INT 21H
        CMP AL,13
        JE LABEL2
        MOV [SI], AL
        INC SI
        JMP LABEL1
        
LABEL2: MOV SI, OFFSET REPLS
LEA DX,MS2
    MOV AH, 09H
    INT 21H
LABEL3: MOV AH,1
        INT 21H
        CMP AL,13
        JE LABEL4
        MOV [SI], AL
        INC SI
        JMP LABEL3
LABEL4: MOV SI, OFFSET SUBST
LEA DX,MS3
    MOV AH, 09H
    INT 21H
LABEL5: MOV AH,1
        INT 21H
        CMP AL,13
        JE LABEL6
        MOV [SI], AL
        INC SI
        JMP LABEL5
LABEL6: mov  FIR, offset SUBSTR1 
   mov  LAS, offset FINA   
   mov  si, FIR
   lea  di, REPLS
SEARCHSUB:                        
   mov  al, [di]       
   cmp  al, '$'         
   je   SUBFOUND           
   cmp  byte ptr [si], '$'
   je   SUBNOTFOUND  
   cmp  [si], al        
   jne  SUBNOTFOUND        
   inc  si             
   inc  di          
   jmp  SEARCHSUB         
SUBFOUND:
   mov  FIR, si           
   dec  FIR             
   lea  di, SUBST     
CHANGE:
   mov  al, [di]        
   cmp  al, '$'          
   je   NEXTSTRING
   mov  si, LAS          
   mov  [si], al       
   inc  LAS              
   inc  di            
   jmp  CHANGE
SUBNOTFOUND:    
   mov  si, FIR           
   mov  di, LAS           
   mov  al, [si]
   mov  [di], al
   inc  LAS               
NEXTSTRING:
   lea  di, REPLS       
   inc  FIR              
   mov  si, FIR
   cmp  byte ptr [si], '$'
   jne  SEARCHSUB          
LEA DX,MS4
    MOV AH, 09H
    INT 21H
   MOV DX, OFFSET FINA
   MOV AH, 09H
   INT 21H
   mov  ah, 4ch
   int  21h
CODE ENDS
        END START