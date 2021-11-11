.MODEL SMALL
.STACK 200H
.DATA

MSG1 DB 0DH,0AH,'ENTER A CHARACTER : $'  

.CODE                      

MAIN PROC
           
    MOV AX,@DATA
    MOV DS,AX
           
    MOV AH,9
    LEA DX,MSG1
    INT 21H
    
    MOV AH,1
    INT 21H
    
    CALL NEWLINE
    
    CMP AL,'Y'
    JE PRINT
    
    CMP AL,'y'
    JE PRINT        
    
    JMP TERMINATE
    
    PRINT:
    MOV AH,2
    MOV DL,AL
    INT 21H
    
    
    TERMINATE:
    
            
    MOV AX,4C00H
    INT 21H                                                        
                 
    MAIN ENDP  

    PROC NEWLINE
    
    PUSH AX
    PUSH DX
    
    MOV AH,2
    MOV DL,0DH
    INT 21H
            
    MOV DL,0AH
    INT 21H
    
    POP DX
    POP AX
    
    RET
    NEWLINE ENDP          
        
END MAIN
    
    