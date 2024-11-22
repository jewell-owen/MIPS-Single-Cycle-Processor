.data
x: .word 3
.text
.globl main

main:
    
                                                                
    addi $t0, $0, 10 
    la $t1, x                                                                                   
    sw $t0, 0($t1)
    addi $t2, $t1, 0   
    lw $t3, 0($t2)
   
exit:
    halt
