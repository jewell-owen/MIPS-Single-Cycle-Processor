#
# Test program for mips control flow instructions and has a call depth of at least 5 
# beq, bne, j, jal, jr
# The program should jump (in order) init, RUN2, RUN1, RUN4, RUN3, Finish RUN4, halt
# There's a chance 3 and 4 loop forever
#

# data section
.data

.text
.globl main

main:
    li $sp, 0x10011000        # Initialize stack pointer
    addi $a0, $zero, 5        # Set initial value
    jal recursive             # Call recursive function
    addi $t1, $zero, 15       # Set expected result
    bne $v0, $t1, failure     # Check result
    j exit                    # Jump to exit

recursive:
    addi $sp, $sp, -8       # Allocate stack space
    sw $ra, 4($sp)          # Save return address
    sw $a0, 0($sp)          # Save argument n

    slti $t0, $a0, 1            # Check if n < 1
    beq $t0, $zero, decrement   # If n >= 1, recurse
    li $v0, 0                   # Base case: return 0
    j return                    # Jump to return

decrement:
    addi $a0, $a0, -1        # Decrement n
    jal recursive            # Recursive call
    lw $a0, 0($sp)           # Restore n
    add $v0, $v0, $a0        # Return n + recursive(n - 1)

return:
    lw $ra, 4($sp)           # Restore return address
    addi $sp, $sp, 8         # Deallocate stack space
    jr $ra                   # Return to caller

failure:
    li $v0, 1               # Print failure code (1)
    j exit                  # Jump to exit

exit:
    li $v0, 10              # Exit syscall
    syscall
