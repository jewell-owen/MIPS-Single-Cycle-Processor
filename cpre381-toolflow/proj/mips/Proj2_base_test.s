#add, addi, addiu, addu, and, andi, lui, lw, nor, xor, xori, or,
#ori, slt, slti, sll, srl, sra, sw, sub, subu, beq, bne, j, jal, jr
.data
value: .word 15
#need to add lui, lw, sw
    .text
    .globl main
main:
    # Load upper immediate for memory access 
    lui $a0, 0x1000
    # Arithmetic instructions
    add $t0, $t1, $t2       # t0 = t1 + t2 (Initially t1 = 0, t2 = 0, so t0 = 0)
    addi $t1, $zero, 100    # t1 = 100
    addiu $t2, $zero, 200   # t2 = 200
    nop
    nop
    nop
    addu $t3, $t1, $t2      # t3 = t1 + t2 = 100 + 200 = 300
    

    nop
    nop
    nop
    sub $t4, $t3, $t1       # t4 = t3 - t1 = 300 - 100 = 200
    subu $t5, $t2, $t1      # t5 = t2 - t1 = 200 - 100 = 100
    
    # Load word from address of 'value' into $a1 (a1 = 15)
    lw $a1, value  
    nop
    nop
    nop         
    addi $a1, $a1, 10

    # Logical instructions
    and $t6, $t1, $t2       # t6 = t1 & t2 = 100 & 200 = 64
    andi $t7, $t1, 15       # t7 = t1 & 15 = 100 & 15 = 4

    or $t8, $t1, $t2        # t8 = t1 | t2 = 100 | 200 = 236
    ori $t9, $t1, 255       # t9 = t1 | 255 = 100 | 255 = 255

    xor $s0, $t1, $t2       # s0 = t1 ^ t2 = 100 ^ 200 = 172
    xori $s1, $t1, 128      # s1 = t1 ^ 128 = 100 ^ 128 = 228

    nor $s2, $t1, $t2       # s2 = ~(t1 | t2) = ~(100 | 200) = -237
    
    # Store word from $a1 into address 0x10000000
    sw $a1, value($0)

    # Shift instructions
    sll $s3, $t1, 2         # s3 = t1 << 2 = 100 << 2 = 400
    srl $s4, $t2, 1         # s4 = t2 >> 1 = 200 >> 1 = 100
    sra $s5, $t3, 1         # s5 = t3 >> 1 (arithmetic) = 300 >> 1 = 150

    # Comparison instructions
    slt $t6, $t1, $t2       # t6 = (t1 < t2) ? 1 : 0 = (100 < 200) ? 1 : 0 = 1
    slti $t7, $t1, 50       # t7 = (t1 < 50) ? 1 : 0 = (100 < 50) ? 1 : 0 = 0

    # Branch/Jump instructions
    beq $t1, $t2, skip      # t1 != t2, so no branch
    bne $t1, $t2, continue  # t1 != t2, so branch to continue
   
    
skip:
    j end                   # Jump to end

continue:
    jal dummy_function      # Jump and link to dummy_function
    j end 

dummy_function:
    # Dummy function to demonstrate jal and jr usage
    jr $ra                  # Jump to the return address (continue execution at end)

end:
    #halt
  

# Expected final register states:
# $a0 = 0x1000
# $a1 = 0x00000019
# $t0 = 0             # t0 = t1 + t2 = 0 + 0 = 0 (initial state)
# $t1 = 100           # t1 = 100 (after addi)
# $t2 = 200           # t2 = 200 (after addiu)
# $t3 = 300           # t3 = t1 + t2 = 100 + 200 = 300
# $t4 = 200           # t4 = t3 - t1 = 300 - 100 = 200
# $t5 = 100           # t5 = t2 - t1 = 200 - 100 = 100
# $t6 = 1             # t6 = (t1 < t2) ? 1 : 0 = 1
# $t7 = 0             # t7 = (t1 < 50) ? 1 : 0 = 0
# $t8 = 236           # t8 = t1 | t2 = 100 | 200 = 236
# $t9 = 255           # t9 = t1 | 255 = 100 | 255 = 255
# $s0 = 172           # s0 = t1 ^ t2 = 100 ^ 200 = 172
# $s1 = 228           # s1 = t1 ^ 128 = 100 ^ 128 = 228
# $s2 = -237          # s2 = ~(t1 | t2) = ~(100 | 200) = -237
# $s3 = 400           # s3 = t1 << 2 = 100 << 2 = 400
# $s4 = 100           # s4 = t2 >> 1 = 200 >> 1 = 100
# $s5 = 150           # s5 = t3 >> 1 (arithmetic) = 300 >> 1 = 150
# $ra = Address after jal (return to end)
