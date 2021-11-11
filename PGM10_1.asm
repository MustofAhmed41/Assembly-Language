REVERSE PROC 
    ;reverses a word array
    ;input:SI=offset of array and BX=number of elements
    ;output:reversed array
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH SI
    PUSH DI
    ;make DI point to nth word
    MOV DI,SI
    MOV CX,BX
    DEC BX
    SHL BX,1
    ADD DI,BX
    SHR CX,1
    ;swap elements
    XCHG_LOOP:
    MOV AX,[SI]
    XCHG AX,[DI]
    MOV [SI],AX  
    ADD SI,2
    SUB DI,2
    LOOP XCHG_LOOP
    POP DI
    POP SI
    POP CX
    POP BX
    POP AX
    RET
    REVERSE ENDP            