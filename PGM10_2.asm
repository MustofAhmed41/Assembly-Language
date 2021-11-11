SELECT PROC
    ;sorts a byte array by the selectsort method
    ;input: SI = array offset address and BX = number of elements
    ;output: SI = offset of sorted array
    ;uses : SWAP
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    DEC BX
    JE END_SORT
    MOV DX,SI
    ;for N-1 times do
    SORT_LOOP:
    MOV SI,DX
    MOV CX,BX
    MOV DI,SI
    MOV AL,[DI]
    ;locate biggest of remaining elements
    FIND_BIG:
    INC SI
    CMP [SI],AL
    JNG NEXT
    MOV DI,SI
    MOV AL,[DI]
    NEXT:
    LOOP FIND_BIG
    ;swap biggest element with last element
    CALL SWAP
    DEC BX
    JNE SORT_LOOP
    END_SORT:
    POP SI
    POP DX
    POP CX
    POP BX
    RET
    SELECT ENDP
SWAP PROC
    ;swaps two array elements
    ;input: SI = one element AND DI = other element
    ;output: exchange-elements
    PUSH AX
    MOV AL,[SI]
    XCHG AL,[DI]
    MOV [SI],AL
    POP AX
    RET
    SWAP ENDP 