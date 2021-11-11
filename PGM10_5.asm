.MODEL SMALL
.STACK 100H
.DATA
;alphabet ABCDEFGHIJKLMNOPORSTUVWXYZ
CODE_KEY DB 65 DUP('  '),'XQPOGHZBCADEIJWFMNKLRSTWY'
         DB 37 DUP('  ')
DECODE_KEY DB 65 DUP('  '),'JHIKLQEFMNTURSDCBVWXOPYAZG'
           DB 37  DUP('  ')
CODED DB 80 DUP('$')
PROMPT DB 'ENTER   A  MESSAGE:',0DH,0AH,'$'
CRLF DB 0DH,0AH,'$'

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    ;print input prompt
    MOV AH,9
    LEA DX,PROMPT
    INT 21H
    ;read and encode message
    MOV AH,1
    LEA BX,CODE_KEY
    LEA DI,CODED
    WHILE_:
    INT 21H
    CMP AL,0DH
    JE ENDWHILE
    XLAT
    MOV [DI],AL
    INC DI
    JMP WHILE_
    ENDWHILE:
    ;go to a new line
    MOV AH,9
    LEA DX,CRLF
    INT 21H
    ;print encoded message
    LEA DX,CODED
    INT 21H 
    ;go to a new line
    LEA DX,CRLF
    INT 21H
    ;decode message and print it
    MOV AH,2
    LEA BX,DECODE_KEY
    LEA SI,CODED
    WHILE1:
    MOV AL,[SI]
    CMP AL,'$'
    JE ENDWHILE1
    XLAT
    MOV DL,AL
    INT 21H
    INC SI
    JMP WHILE1
    ENDWHILE1:
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN 