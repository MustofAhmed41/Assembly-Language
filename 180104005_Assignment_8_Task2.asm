.MODEL SMALL
 .STACK 100H

 .DATA
   PROMPT          DB  0DH,0AH,'Enter an Algebraic Expression : ','$' 
   PROMPT2         DB  0DH,0AH,'Enter an Algebraic Expression : ','$'
   CORRECT         DB  0DH,0AH,'Expression is Correct.$'
   LEFT_BRACKETS_ERROR   DB  0DH,0AH,'Too many Left Brackets.$'
   RIGHT_BRACKETS_ERROR  DB  0DH,0AH,'Too many Right Brackets.$'
   MISMATCH_ERROR        DB  0DH,0AH,'Bracket Mismatch. Begin Again.$'
   CONTINUE        DB  0DH,0AH,'Type Y if you want to Continue : $'
              
 .CODE
   MAIN PROC
     MOV AX, @DATA                
     MOV DS, AX

     START:                    

     LEA DX, PROMPT2               
     MOV AH, 9
     INT 21H

     XOR CX, CX            

     MOV AH, 1            

     INPUT:                     
       INT 21H                   

       CMP AL, 0DH            
       JE END_INPUT              

       CMP AL, "["               
       JE PUSH_BRACKET           

       CMP AL, "{"            
       JE PUSH_BRACKET          

       CMP AL, "("              
       JE PUSH_BRACKET          

       CMP AL, ")"               
       JE ROUND_BRACKET         
                                   
       CMP AL, "}"               
       JE CURLY_BRACKET         

       CMP AL, "]"             
       JE SQUARE_BRACKET     

       JMP INPUT             

       PUSH_BRACKET:          

       PUSH AX                 
       INC CX                 
       JMP INPUT                

       ROUND_BRACKET:       

       POP DX                  
       DEC CX                

       CMP CX, 0                
       JL RIGHT_BRACKETS       

       CMP DL, "("             
       JNE MISMATCH              
       JMP INPUT             
       
       CURLY_BRACKET:           

       POP DX                    
       DEC CX                  

       CMP CX, 0               
       JL RIGHT_BRACKETS     

       CMP DL, "{"             
       JNE MISMATCH          
       JMP INPUT             

       SQUARE_BRACKET:        
                                   
       POP DX                   
       DEC CX                 

       CMP CX, 0                
       JL RIGHT_BRACKETS 

       CMP DL, "["          
       JNE MISMATCH          
     JMP INPUT             

     END_INPUT:            

     CMP CX, 0                 
     JNE LEFT_BRACKETS           ;all left brackets not used up    
                                
     MOV AH, 9                 

     LEA DX, CORRECT        
     INT 21H                      
     
     CONTINUE_MESSAGE:   
        
        
     LEA DX, CONTINUE           
     INT 21H                       

     MOV AH, 1                
     INT 21H               

     CMP AL, "Y"                
     JNE EXIT                 
     JMP START               

     MISMATCH:                

     LEA DX, MISMATCH_ERROR          
     MOV AH, 9                     
     INT 21H

     JMP START: 

     LEFT_BRACKETS:          

     LEA DX, LEFT_BRACKETS_ERROR     
     MOV AH, 9
     INT 21H

     JMP CONTINUE_MESSAGE:                

     RIGHT_BRACKETS:        

     LEA DX, RIGHT_BRACKETS_ERROR      
     MOV AH, 9
     INT 21H

     JMP START                 

     EXIT:                       

     MOV AH, 4CH              
     INT 21H
   MAIN ENDP
 END MAIN