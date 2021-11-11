.MODEL SMALL      

.DATA   

M1 DB 0AH,0DH,'TYPE A HEXA NUMBER of 4 digit : ','$'
M2 DB 0AH,0DH,'IN BINARY IT IS : ','$'
M3 DB 0AH,0DH,'ILLEGAL HEXA DIGIT, TRY AGAIN : ','$'
.CODE  

MAIN PROC
    MOV AX,@DATA 
    MOV DS,AX             
    
    MOV AH,9 
    LEA DX,M1
    INT 21H            
    
    START:
    XOR BX,BX 
    MOV CL,4
    MOV AH,1
    INT 21H 
    
    WHILE_: 
    
    CMP AL,0DH 
    JE END_WHILE
    
    CMP AL,'0' ;detect for error if less than 0
    JL ERROR                 
    
    CMP AL, '9'
    JG LETTER  
;00111001 = 9 in ascii code
;00001111 = 9 in binary 
;00001001 = we neeed
    AND AL,0FH 
                
    JMP SHIFT  
    
    LETTER:
    CMP AL,'F'
    JG ERROR     
    CMP AL,'A'
    JL ERROR     
    SUB AL,37H ; get numerical value
;when we substract with 37, we can convert the digit A to 1010, which is its binary representation   
; F =01000110 and after subtrating we get 00001111
;
    SHIFT:
    SHL BX,CL ; clearing for new input
    OR BL,AL 
    INT 21H
    JMP WHILE_ 
    
    END_WHILE:                  
    
    MOV AH,9 
    LEA DX,M2 ;display result
    INT 21H
    MOV CX,16 
    MOV AH,2 
    
    SHOW:    
    
    SHL BX,1   
    JC ONE
    MOV DL,'0'
    INT 21H    
    
    JMP LOOP1
    
    ONE: 
    
    MOV DL,'1'
    INT 21H
    
    LOOP1: 
    LOOP SHOW ;do it 16 times
    
    JMP OUT_
    
    ERROR:      
    
    MOV AH,9 
    LEA DX,M3 ;display error MSG
    INT 21H    
    
    JMP START ;and read again
    OUT_: 
    MOV AH,4CH
    INT 21H
    
MAIN ENDP
END MAIN