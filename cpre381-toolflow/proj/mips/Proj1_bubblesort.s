#
# Implement a mips program that sorts an array with N elements using the BubbleSort algorithm
# 
# add, addi, addiu, addu, and, andi, lui, lw, nor, xor, xori, or, ori, slt, slti, sll, srl, sra, sw, sub, subu, beq, bne, j, jal, jr
#
#// Optimized implementation of Bubble sort
#include <stdbool.h>
#include <stdio.h>

#void swap(int* xp, int* yp){
#    int temp = *xp;
#    *xp = *yp;
#    *yp = temp;
#}
#
#// An optimized version of Bubble Sort
#void bubbleSort(int arr[], int n){
#    int i, j;
#    bool swapped;
#    for (i = 0; i < n - 1; i++) {
#        for (j = 0; j < n - i - 1; j++) {
#            if (arr[j] > arr[j + 1]) {
#                swap(&arr[j], &arr[j + 1]);
#                swapped = true;
#            }
#        }
#
#        // If no two elements were swapped by inner loop,
#        // then break
#        if (swapped == false)
#            break;
#    }
#}
#
#// Function to print an array
#void printArray(int arr[], int size){
#    int i;
#    for (i = 0; i < size; i++)
#        printf("%d ", arr[i]);
#}
#
#int main(){
#    int arr[] = { 64, 34, 25, 12, 22, 11, 90 };
#    int n = sizeof(arr) / sizeof(arr[0]);
#    bubbleSort(arr, n);
#    printf("Sorted array: \n");
#    printArray(arr, n);
#    return 0;
#}

.data
arr:
    .word 5, 4, 3, 2, 1   # Unsorted array
size:
    .word 5              # Placeholder for size of array
space: .asciiz "\n"


.text
.globl main
main:
    # store size
    lw $t1, size
    
    addi $t2, $0, 0	#i = 0
    addi $t3, $0, 0	#j = 0
    
for1:
    beq $t2, $t1, exit # for(i = 0; i < n-1;)
    add $t3, $0, $0 # j = 0
    addi $t2, $t2, 1 # (i++)
    
    j for2 # jump to for2
for2:
    beq $t3, $t1, for1 # for(j = 0; j < n-1;)
    addi $t7, $t3, 1 # j + 1
    sll $s1, $t3, 2 # current j shift left (multiply by 4)
    sll $s2, $t7, 2 # current j + 1shift left (multiply by 4)
    lw $t4, arr($s1) # load content of arr[j]
    lw $t5, arr($s2) # load content of arr[j + 1]
    slt $t6, $t4, $t5 # if (arr[j] > arr[j + 1])
    
    add $a0, $0, $t3
    addi $v0, $0, 1
    syscall
    
    add $a0, $0, $t7
    addi $v0, $0, 1
    syscall
    
    addi $v0, $0, 4
    la $a0 , space
    syscall
    
    lw $s5, arr
    add $a0, $0, $s5
    addi $v0, $0, 1
    syscall
    
    addi $s6, $0, 4
    lw $s6, arr($s6)
    add $a0, $0, $s6
    addi $v0, $0, 1
    syscall
    
    addi $s7, $0, 8
    lw $s7, arr($s7)
    add $a0, $0, $s7
    addi $v0, $0, 1
    syscall
    
    addi $t8, $0, 12
    lw $t8, arr($t8)
    add $a0, $0, $t8
    addi $v0, $0, 1
    syscall
    
    addi $t9, $0, 16
    lw $t9, arr($t9)
    add $a0, $0, $t9
    addi $v0, $0, 1
    syscall
    
    addi $v0, $0, 4
    la $a0 , space
    syscall
    
    bne $t6, $0, swap # if t6 = 1, swap
    addi $t3, $t3, 1 # (j++) if no swap
swap: 
    add $t7, $0, $t4 # temp = i
    add $t4, $0, $t5 # i = j
    add $t5, $0, $t7 # j = temp
    sw $t4, arr($s1) # store i
    sw $t5, arr($s2) # store j
    
    #addi $t3, $t3, 1 # (j++) after swap
    j for2 # return to for2
exit:
    
    halt
