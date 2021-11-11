.MODEL SMALL
.DATA
M1 DB 0AH,0DH,'TYPE A HEXA NUMBER 0 - FFFF :$'
M2 DB 0AH,0DH,'THE SUM IN HEXA IS $'
M3 DB 0AH,0DH,'ILLEGAL HEXA DIGIT, TRY AGAIN : ','$'
COUNTER DB 4
NUM DW ?      

.CODE

MAIN PROC
        
    MOV AX,@DATA 
    MOV DS,AX           
    
    CALL READ
    MOV NUM,BX 
    
    CALL READ 
 
    MOV AH,9 ;display result msg
    LEA DX,M2
    INT 21H
    ADD BX,NUM
    
    JC SHOWCY 
    MOV AH,2 
    MOV DL,'0'
    INT 21H
    JMP NEXT       
    
    SHOWCY:
    MOV AH,2
    MOV DL,'1'
    INT 21H
    
    NEXT: 
    CALL SHOW
    MOV AH,4CH 
    INT 21H
    
    MAIN ENDP 
    
    
    READ PROC 
    
    READ_START:
    
    MOV AH,9 
    LEA DX,M1
    INT 21H     
        
    XOR BX,BX ; clears the contents of BX
    MOV CL,4
    MOV AH,1 ;preparing for input
    INT 21H
    
    WHILE_: 
    
    CMP AL,0DH      
    JE END_W        
    
    CMP AL,'0' 
    JL ERROR 
    
    CMP AL,'9' 
    JG LETTER 
    
    AND AL,0FH
    JMP SHIFT 
                     
    LETTER: 
    
    CMP AL,'F'
    JG ERROR     ; check if input above F
    CMP AL,'A'
    JL ERROR
    
    SUB AL,37H 
        
    SHIFT: 
    SHL BX,CL ; clearing space for new value
    OR BL,AL 
    INT 21H
    
    JMP WHILE_ 
    
    ERROR:  
    
    MOV AH,9 
    LEA DX,M3 ;display error MSG
    INT 21H    
    
    JMP READ_START 
    
    END_W:
        RET
    READ ENDP
 
    SHOW PROC ;to display result of addition
        
    MOV CL,4
    START: 
    MOV DL,BH 
    SHR DL,CL ; DL contains 4 digit MSB of BH
    CMP DL,9 
    
    JG LETTER1
    ADD DL,30H
    JMP SHOW1
    
    LETTER1:
    ADD DL,37H 
    
    SHOW1: 
    MOV AH,2
    INT 21H
    
    ROL BX,CL 
    DEC COUNTER
    CMP COUNTER,0
    JNE START
    
    RET
    SHOW ENDP    
 
END MAIN