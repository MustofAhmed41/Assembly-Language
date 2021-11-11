.MODEL SMALL
.STACK 100H
.DATA
FIVE DW 5
SCORES DW 67,45,98,33 
       DW 70,56,87,44
       DW 82,72,89,40 
       DW 80,67,95,50 
       DW 78,76,92,60 
AVG DW 5 DUP (0)

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    ;j=4
    MOV SI,6
    REPEAT:
    MOV CX,5
    XOR BX,BX 
    XOR AX,AX
    ;sum scores in column j
    FOR:
    ADD AX,SCORES[BX+SI]
    ADD BX,8 
    LOOP FOR
    ;endfor
    ;compute average in column j
    XOR DX,DX
    DIV FIVE
    MOV AVG[SI],AX
    SUB SI,2
    ;until j=O
    JNL REPEAT
    ;dos exit
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN 