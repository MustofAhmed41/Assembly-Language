.MODEL SMALL
.STACK 100H     
.DATA
MSG1 DB 0AH,0DH,'Enter a string : ','$' 
MSG2 DB 0AH,0DH,'The reversed string is :','$'    
TEXT DB 100 DUP('$')

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX 
    
    MOV AH,9 
    LEA DX,MSG1
    INT 21H    
             
    XOR CX,CX 
    
    LEA SI,TEXT
    MOV AH,1
       
    WHILE_: 
    MOV AH,1
    INT 21H
    CMP AL,0DH
    JE END_WHILE        
    
    CMP AL,' '
    JE STORE
 
    PUSH AX
    INC CX       
        
    JMP WHILE_             
    
    STORE:   
           
    
    LOOPER:
    POP AX
    MOV [SI],AL
    INC SI
    LOOP LOOPER          
    
    MOV [SI],' '
    INC SI
             
    JMP WHILE_:
    
    
    END_WHILE:  
    
    
    LOOPER2:
    POP AX
    MOV [SI],AL
    INC SI
    LOOP LOOPER2
    
    MOV AH,9
    LEA DX,MSG2
    INT 21H

    MOV AH,9
    LEA DX,TEXT
    INT 21H

    EXIT: 
    
    MOV AH,4CH
    INT 21H
    MAIN ENDP   

END MAIN 
 
