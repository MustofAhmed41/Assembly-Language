.MODEL SMALL
.STACK 100H     
.DATA
MSG1 DB 0AH,0DH,'Enter a string : ','$' 
MSG2 DB 0AH,0DH,'The reversed string is : ','$'

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX 
    
    MOV AH,9 
    LEA DX,MSG1
    INT 21H    
             
    XOR CX,CX ; need to clear before starting
    
    MOV AH,1
    INT 21H
    
    WHILE_:
    CMP AL,0DH
    JE END_WHILE
    

    PUSH AX
    INC CX
   
    INT 21H    ;read a character
    JMP WHILE_
    
    END_WHILE:

    MOV AH,9
    LEA DX,MSG2
    INT 21H

    JCXZ EXIT  ; if CX register is 0
    
    MOV AH,2
    TOP:

    POP DX

    INT 21H
    LOOP TOP

    EXIT: 
    
    MOV AH,4CH
    INT 21H
    MAIN ENDP   

END MAIN 
 
