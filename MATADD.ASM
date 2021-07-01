ASSUME CS:CODE,DS:DATA

PRINTMAT MACRO P,P1,P2 ;print matrix

 LEA SI, P            
 MOV CX, ROW                   
 P1:                    
       MOV BX, COL                 
 P2:                  
        PRINTS S        

      MOV AX, [SI]            
      CALL OUTD           
       ADD SI, 2               
       DEC BX                 
       JNZ P2 
             
       PRINTS L       
       LOOP P1 
               
ENDM

PRINTS MACRO P ;print string

MOV DX, OFFSET P
MOV AH,09H
INT 21H

ENDM


DATA SEGMENT

    MSG1 DB  "The first array $"
    MSG2 DB  "The  second array$"
    MSG3 DB  "The sum is $"
   S DB " $"
    L DB 0AH,0DH,"$"
     A   DW  34H,0A0H,00H
         DW  20H,30H,40H   
         DW  0BBH,0CCH,0DDH 
     B    DW  6AH,3AH,00H
          DW  02H,03H,04H  
          DW  11H,11H,11H  
 ROW DW 03H
 COL DW 03H
            
DATA ENDS

CODE SEGMENT

   MAIN PROC
START:

     MOV AX, DATA               
     MOV DS, AX

     PRINTS MSG1
     PRINTS L
     PRINTMAT A,N1,N2
     PRINTS L
     PRINTS MSG2
     PRINTS L
     PRINTMAT B,C1,C2
     PRINTS MSG3
     PRINTS L
  

     LEA SI, A   
     LEA  DI,B         
      MOV CX,ROW                    
      LABEL1:                   
       MOV BX, COL                  

       LO2:                  
         PRINTS S             

        MOV AX, [SI]            
         ADD AX,[DI]
       CALL OUTD
        ADD SI, 2             
         ADD DI,2      
         DEC BX            
         JNZ LO2
                      
       PRINTS L
       LOOP LABEL1

     MOV AH, 4CH             
     INT 21H
   MAIN ENDP





;---OUTD takes hex value in AX and converts it into ascii value
 OUTD PROC
   ; display a decimal number
   PUSH BX                      
   PUSH CX                        
   PUSH DX              
       
        
L1:     
        MOV BX,10H
        MOV DX,0000H
        MOV CH,00H
L2:     MOV DX,0000H
        DIV BX ;---Getting last digit
        PUSH DX
        INC CH
        CMP AX,0
        JNE L2
        
L3:     POP DX
        CMP DX,000AH ;---check if less than 10
        JNGE L4
        ADD DX,37H ;---if not num, then convert to ascii char
        MOV AH,02H
        INT 21H
        JMP L5
L4:     ADD DX,30H ;---if num, then convert to ascii char
        MOV AH,02H
        INT 21H
L5:     DEC CH
        JNZ L3

    POP DX                      
   POP CX                       
   POP BX        
        RET

 OUTD ENDP





 
CODE ENDS
END START
