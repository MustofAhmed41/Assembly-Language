.MODEL SMALL
.STACK 200H
.DATA

MSG1 DB 0DH,0AH,'THE DOUBLED VARIABLE VALUE IS : $'  
MSG2 DB 0DH,0AH,'THE VARIABLE VALUE IS : $'  
MYVARIABLE DB ? 

.CODE                      

MAIN PROC
           
    MOV AX,@DATA
    MOV DS,AX 
    
    MOV MYVARIABLE,17    
    
    MOV AH,9
    LEA DX,MSG2
    INT 21H
    
    MOV AL,MYVARIABLE
    XOR AH,AH
    CALL OUTDEC
    
    ADD AL,MYVARIABLE
    MOV MYVARIABLE,AL       
    
    PUSH AX
    
    MOV AH,9
    LEA DX,MSG1
    INT 21H
    
    POP AX
    
    CALL OUTDEC
        
    MOV AX,4C00H
    INT 21H                                                        
                 
    MAIN ENDP  

    OUTDEC PROC
	PUSH AX
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
	POP AX

	RET
OUTDEC ENDP
        
END MAIN
    
    