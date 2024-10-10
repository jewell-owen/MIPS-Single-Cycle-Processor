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
    .word 5, 4, 3, 2, 1  # Unsorted array
size:
    .word 5              # Placeholder for size of array


.text
.globl main
main:
    # store size
    lw $t1, size
    # store size - 1 (n-1)
    #addi $t1, $t1, -1
    # store i and j starting at 1
    addi $t2, $0, 0	#i
    addi $t3, $0, 0	#j
    
for1:
    beq $t2, $t1, exit # for(i = 0; i < n-1;)
    addi $t2, $t2, 1 # (i++)
    addi $t3, $0, 0 # j = 1
    j for2
for2:
    beq $t3, $t1, for1 # for(j = 0; j < n-1;)
    addi $t7, $t2, -1
    sll $s1, $t7, 2
    sll $s2, $t3, 2
    lw $t4, arr($s1)
    lw $t5, arr($s2)
    slt $t6, $t4, $t5
    addi $t3, $t3, 1 # (j++)
    bne $t6, $0, swap 
swap: 
    add $t7, $0, $t4
    add $t4, $0, $t5
    add $t5, $0, $t7
    sw $t4, arr($s1)
    sw $t5, arr($s2)
    
    j for2
exit:
    lw $t1, arr
    add $a0, $0, $t1
    addi $v0, $0, 1
    syscall
    
    addi $t2, $0, 4
    lw $t2, arr($t2)
    add $a0, $0, $t2
    addi $v0, $0, 1
    syscall
    
    addi $t3, $0, 8
    lw $t3, arr($t3)
    add $a0, $0, $t3
    addi $v0, $0, 1
    syscall
    
    addi $t4, $0, 12
    lw $t4, arr($t4)
    add $a0, $0, $t4
    addi $v0, $0, 1
    syscall
    
    addi $t5, $0, 16
    lw $t5, arr($t5)
    add $a0, $0, $t5
    addi $v0, $0, 1
    syscall
    #halt
