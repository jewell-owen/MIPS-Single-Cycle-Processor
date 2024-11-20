

.data


.text
.globl main
main:
    
                                                                
                                                                                       
    addi $t0, $0, 1          
    addi $t1, $0, 1 
    NOP                                                                                        
    beq $t0, $t1, exit 
    NOP
    addi $t2, $0, 3      
   
exit:
    halt
