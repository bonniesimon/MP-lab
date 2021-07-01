ASSUME CS: CODE, DS: DATA

DATA SEGMENT
original db 100 dup(0)
find     db 100 dup(0)
subst    db 100 dup(0)
result   db 100 dup('$')
i        dw ?       
j        dw ?          
DATA ENDS

CODE SEGMENT
start:   MOV AX, DATA
        MOV DS, AX
	MOV SI, OFFSET ORIGINAL
L1: MOV AH,1
        INT 21H
        CMP AL,13
        JE L2
        MOV [SI], AL
        INC SI
        JMP L1
L2: MOV SI, OFFSET FIND
L3: MOV AH,1
        INT 21H
        CMP AL,13
        JE L4
        MOV [SI], AL
        INC SI
        JMP L3
L4: MOV SI, OFFSET SUBST
L5: MOV AH,1
        INT 21H
        CMP AL,13
        JE L6
        MOV [SI], AL
        INC SI
        JMP L5


L6: mov  i, offset original 
   mov  j, offset result   
   mov  si, i
   lea  di, find
search:                        
   mov  al, [di]       
   cmp  al, 0          
   je   match           
   cmp  byte ptr [si], 0
   je   mismatch  
   cmp  [si], al        
   jne  mismatch        
   inc  si             
   inc  di          
   jmp  search         
match:
   mov  i, si           
   dec  i             
   lea  di, subst     


replace:
   mov  al, [di]        
   cmp  al, 0           
   je   next
   mov  si, j          
   mov  [si], al       
   inc  j              
   inc  di            
   jmp  replace
mismatch:    
   mov  si, i           
   mov  di, j           
   mov  al, [si]
   mov  [di], al
   inc  j               
next:
   lea  di, find       
   inc  i              
   mov  si, i
   cmp  byte ptr [si], 0
   jne  search          
finale:
   MOV DX, OFFSET result
   MOV AH, 09H
   INT 21H
   mov  ah, 4ch
   int  21h
CODE ENDS
        END START