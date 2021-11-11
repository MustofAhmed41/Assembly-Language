.MODEL SMALL
.DATA
M1 DB 0AH,'ENTER A DECIMAL DIGIT STRING :$'
M2 DB 0AH,'THE SUM OF THE DIGIT IN HEX IS $' 
M3 DB 0AH,0DH,'ILLEGAL DIGIT, TRY AGAIN : ','$'
COUNTER DB 4
.CODE
MAIN PROC
    MOV AX,@DATA 
    MOV DS,AX                
    
    MOV AH,9 
    LEA DX,M1
    INT 21H          
    
    
    READ_START:
        
    XOR BX,BX   
    
    WHILE_:                             
        MOV AH,1
        INT 21H
        CMP AL,0DH 
        JE END_W
        
        CMP AL,'0' 
        JL ERROR
        CMP AL, '9' 
        JG ERROR
        
        AND AL,0FH ; 1 =00110001 AND 00001111 = 00000001, the first 4 bit are 
        CBW        ;reset and last 4 bit is preserved
        
        ADD BX,AX
        JMP WHILE_  
        
        
    ERROR:      
    
    MOV AH,9 
    LEA DX,M3 ;display error MSG
    INT 21H       
      
    JMP READ_START
        
    END_W:
        
    MOV AH,9
    LEA DX,M2 ;display result msg
    INT 21H    
    
    MOV CL,4  
    
    START: 
    MOV DL,BH
    SHR DL,CL ; creating space for new input
    CMP DL,9  ;comparing with binary 9 to check if letter
    
    JG LETTER1 
    ADD DL,30H 
    JMP SHOW1   
    
    LETTER1:   
    ADD DL,37H  
    
    SHOW1:
    MOV AH,2    
    INT 21H ; show the content of DL
    
    ROL BX,CL ; rotating to print new values
    DEC COUNTER 
    CMP COUNTER,0
    JNE START 
    
    
    MOV AH,4CH 
    INT 21H
    MAIN ENDP   

END MAIN