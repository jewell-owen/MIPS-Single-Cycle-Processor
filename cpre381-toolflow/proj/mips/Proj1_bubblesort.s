#
# Implement a mips program that sorts an array with N elements using the BubbleSort algorithm
# 
# add, addi, addiu, addu, and, andi, lui, lw, nor, xor, xori, or, ori, slt, slti, sll, srl, sra, sw, sub, subu, beq, bne, j, jal, jr
#
.data
arr:
    .word 5, 4, 3, 2, 1  # Unsorted array
    .word 0              # Placeholder for size of array

.text
.globl main

main:
    li $sp, 0x10011000    # Initialize stack pointer
    sub $sp, $sp, 32      # Allocate stack space

    # Load array elements
    la $a0, arr           # Load address of the array
    li $t1, 5             # Number of elements in the array
    sw $t1, 20($sp)       # Store size of array for reference

bubble_sort:
    addi $t7, $zero, 0    # Swapped flag, 0 = false
    addi $t6, $zero, 0     # Index i = 0

outer_loop:
    slt $t9, $t6, $t1      # Compare i with n
    bne $t9, $zero, inner_loop # If i < n, continue inner loop

    # Check if any swaps occurred
    bne $t7, $zero, bubble_sort # If swapped, repeat outer loop
    j end                   # If no swaps, sorting is complete

inner_loop:
    lw $s1, 0($a0)         # Load a[i]
    lw $s2, 4($a0)         # Load a[i + 1]
    bgt $s1, $s2, pass_swap # If a[i] > a[i + 1], swap

pass_next:
    addi $a0, $a0, 4       # Move to the next element
    addi $t6, $t6, 1       # Increment i
    slt $t9, $t6, $t1      # Check if i < n
    bne $t9, $zero, inner_loop # If i < n, continue inner loop
    j outer_loop           # Go back to outer loop

pass_swap:
    sw $s2, 0($a0)         # Store a[i + 1] in a[i]
    sw $s1, 4($a0)         # Store a[i] in a[i + 1]
    li $t7, 1               # Set swapped flag to true
    j pass_next             # Continue to next pair

end:
    li $v0, 10             # Exit syscall
    syscall
