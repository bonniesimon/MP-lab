ASSUME CS: CODE, DS: DATA

DATA SEGMENT
NUMB     DW      ?
MS1      DB      0AH,0DH,'Enter A number->$'
MS2      DB      0AH,0DH,'NOT PRIME $'
MS3      DB      0AH,0DH,'PRIME$'
DATA ENDS

CODE SEGMENT
START:  MOV AX, DATA
        MOV DS, AX

        LEA DX, MS1           
	MOV AH, 9
     	INT 21H    
        MOV BX,0000H
        MOV CX,0000H     
        MOV AH, 1 ;---input ascii char from keyboard
        INT 21H                
        INPUT:AND AX, 000FH ;---converting ascii num to hex num         
        PUSH AX
        MOV AX, 10       
        MUL BX              
        MOV BX, AX         
        POP AX                
        ADD BX, AX           
        MOV AH, 1           
        INT 21H            
        CMP AL, 0DH ;-- 0DH is return key          
        JNE INPUT                                                       
        MOV NUMB, BX                
        MOV AX, BX
	CMP AX, 01H
	JZ LABEL6  
        MOV NUMB,AX
	MOV CX, 0000   
	MOV BX,0002
	MOV AX,NUMB
	MOV DX,0001
	CMP AX,0002
	JZ LABEL3
        LABEL2: MOV DX, 0000
	DIV BX
	CMP DX,0000
	JZ LABEL4
	MOV AX,NUMB
	INC BX
	CMP AX, BX
	JNZ LABEL2
        LABEL3: MOV CX, 0001
	JMP LABEL5
        LABEL4: MOV CX, 0000
        LABEL5: CMP CX, 0000
	JZ LABEL6
	MOV AH,09H
        LEA DX,MS3
        INT 21H
        JMP FINAL    
        LABEL6:MOV AH,09H
	LEA DX,MS2
        INT 21H
        FINAL:MOV AH,4CH
        INT 21H
CODE ENDS
        END START
