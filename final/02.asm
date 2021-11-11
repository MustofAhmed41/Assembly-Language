.MODEL SMALL
.STACK 200H
.DATA

MSG1 DB 'THE SUM OF THE SERIES IS :  $'   

.CODE                      

MAIN PROC
           
    MOV AX,@DATA
    MOV DS,AX
    
    MOV DX,0
    MOV CX,10
    MOV AX,100
    
    LOOPER:
    ADD DX,AX
    SUB AX,10
    LOOP LOOPER
    
    CALL NEWLINE  
    
    PUSH DX
    
    MOV AH,9
    LEA DX,MSG1
    INT 21H
    
    POP DX
    
    MOV AX,DX    
       
    CALL OUTDEC
           
            
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
                  
                  
                  
                  
    
    OUTDEC PROC  
        
    PUSH DX    

	END_IF1:
	XOR CX,CX
	MOV BX,10D

	REPEAT1:
	XOR DX,DX
	DIV BX
	PUSH DX
	INC CX
	CMP AX,0
	JNE REPEAT1

	MOV AH,2
	PRINT_LOOP:
	POP DX
	OR DL,30H
	INT 21H
	LOOP PRINT_LOOP
    
    POP DX

	RET
OUTDEC ENDP
    
    
        
END MAIN
    
    