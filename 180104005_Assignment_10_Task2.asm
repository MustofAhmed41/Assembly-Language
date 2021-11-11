.MODEL SMALL
.STACK 100H  
.DATA

    
    MSG DB 'ENTER TEXT: $'
    MSG2 DB 'IN UPPERCASE: $'
    TEXT DB 100 DUP ('$')
    
    TABLE DB 97 DUP (' '), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
   
    
.CODE
   
    
    
    MAIN PROC  
                   
                   
        MOV AX, @DATA                
        MOV DS, AX         
        
        MOV AH, 9
        LEA DX, MSG
        INT 21H
        
        LEA SI, TEXT
        
        INPUT:
            MOV AH, 1
            INT 21H
            
            CMP AL, 13D  
            JE END_INPUT
            
            CMP AL, 'a' 
            JL BOTTOM
            CMP AL, 'z'    
            JG BOTTOM         
            

            

            LEA BX, TABLE
            XLAT
            
            BOTTOM:
                MOV [SI], AL
                INC SI
                
            JMP INPUT
        END_INPUT:
        
        CALL NEWL
        
        MOV AH, 9
        LEA DX, MSG2
        INT 21H           
        LEA DX, TEXT
        INT 21H
    
        MOV AH, 4CH      
        INT 21H           
    MAIN ENDP             
    
    PROC NEWL
        MOV AH, 2
        MOV DL, 10D
        INT 21H
        MOV DL, 13D
        INT 21H
        RET
    NEWL ENDP

END MAIN   