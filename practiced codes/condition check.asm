.MODEL SMALL
.STACK 100H
.DATA

.CODE
    MAIN PROC
        
    MOV BL,-2
    
    CMP BL,0
    JL NEGATIVE
    JE ZERO
    JG POSITIVE

    NEGATIVE:
    ; prints -1 if value in BL is less than 0
    MOV BL,1
    MOV AH,2
    MOV DL,'-'
    INT 21H

    JMP END_CASE

    ZERO:
    ; prints 0 if value in BL is equal to 0
    MOV BL,0

    JMP END_CASE
    
    POSITIVE:
    ; prints 1 if value in BL is greater than 0
    MOV BL,1

    END_CASE:
    
    MOV AH,2
    ADD BL,48
    MOV DL,BL
    INT 21H
    
    MOV AH,4CH
    INT 21H    
    MAIN ENDP    
    
END MAIN


