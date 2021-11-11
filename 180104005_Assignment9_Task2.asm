.MODEL SMALL
.DATA
M1 DB 0AH,0DH,'ENTER M : $'
M2 DB 0AH,0DH,'ENTER N : $'
M3 DB 0AH,0DH,'GCD IS : $' 

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    MOV AH,9
    LEA DX,M1
    INT 21H        
    
    CALL INDEC  
    
    PUSH AX 
    MOV AH,9
    LEA DX,M2
    INT 21H     
    
    CALL INDEC 
    PUSH AX 

    POP BX
    POP AX
    
    L1: 
    MOV DX,0
    DIV BX 
    CMP DX,0
    JE GCD_FOUND 

    MOV AX,BX 
    MOV BX,DX 
    JMP L1 
    
    GCD_FOUND: 
    
    MOV AH,9
    LEA DX,M3
    INT 21H 
    
    MOV AX,BX    
    
    CALL OUTDEC

    MOV AH,4CH
    INT 21H
    
MAIN ENDP

    INDEC PROC

    PUSH BX
    PUSH CX
    PUSH DX
    
    BEGIN:
    
    
    XOR BX,BX 
    
    XOR CX,CX

    MOV AH,1
    INT 21H  
    
    CMP AL,'-'
    JE MINUS
    CMP AL,'+'
    JE PLUS
    JMP REPEAT2 
    
    MINUS:
    MOV CX,1
    PLUS:
    INT 21H
    ;end_case 
    
    REPEAT2:

    CMP AL,'0'        
    JNGE NOT_DIGIT
    CMP AL,'9'
    JNLE NOT_DIGIT   
    
    AND  AX,000FH 
    PUSH AX      
    
    MOV AX,10   
    MUL BX
    POP BX
    ADD BX,AX   
    
    MOV AH,1 
    INT 21H
    CMP AL,0DH
    JNE REPEAT2  
    
    MOV AX,BX
        
    EXIT:
    POP DX
    POP CX
    POP BX
    RET

    NOT_DIGIT:
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    JMP BEGIN 
    RET 
    
    INDEC ENDP    
    
    OUTDEC PROC

    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    XOR CX,CX
    MOV BX,10D
    REPEAT1:   
    
    XOR DX,DX
    DIV BX 
    PUSH DX
    INC CX

    OR AX,AX
    JNE REPEAT1 
    
    MOV AH,2

    PRINT_LOOP: 
    POP DX
    OR DL,30H  
    INT 21H 
    LOOP PRINT_LOOP  
    
    POP DX 
    POP CX
    POP BX
    POP AX    
    
    RET
    OUTDEC ENDP     
    
END MAIN