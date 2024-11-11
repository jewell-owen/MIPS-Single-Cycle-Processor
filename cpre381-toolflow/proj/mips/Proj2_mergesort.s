#
# Implement a mips program that sorts an array with N elements using the MergeSort algorithm
# 
# add, addi, addiu, addu, and, andi, lui, lw, nor, xor, xori, or, ori, slt, slti, sll, srl, sra, sw, sub, subu, beq, bne, j, jal, jr
#
#// C program for the implementation of merge sort
##include <stdio.h>
##include <stdlib.h>
#
#// Merges two subarrays of arr[].
#// First subarray is arr[left..mid]
#// Second subarray is arr[mid+1..right]
#void merge(int arr[], int left, int mid, int right) {
#    int i, j, k;
#    int n1 = mid - left + 1;
#    int n2 = right - mid;#
#
#    // Create temporary arrays
#    int leftArr[n1], rightArr[n2];##
#
#    // Copy data to temporary arrays
#    for (i = 0; i < n1; i++)
#        leftArr[i] = arr[left + i];
#    for (j = 0; j < n2; j++)
#        rightArr[j] = arr[mid + 1 + j];
#
#    // Merge the temporary arrays back into arr[left..right]
#    i = 0;
#    j = 0;
#    k = left;
#    while (i < n1 && j < n2) {
#        if (leftArr[i] <= rightArr[j]) {
#            arr[k] = leftArr[i];
#            i++;
#        }
#        else {
#            arr[k] = rightArr[j];
#            j++;
#        }
#        k++;
#    }
#
#    // Copy the remaining elements of leftArr[], if any
#    while (i < n1) {
#        arr[k] = leftArr[i];
#        i++;
#        k++;
#    }#
#
#    // Copy the remaining elements of rightArr[], if any
#    while (j < n2) {
#        arr[k] = rightArr[j];
#        j++;
#        k++;
#    }
#}
#
#// The subarray to be sorted is in the index range [left-right]
#void mergeSort(int arr[], int left, int right) {
#    if (left < right) {
#      
#        // Calculate the midpoint
#        int mid = left + (right - left) / 2;
#
#        // Sort first and second halves
#        mergeSort(arr, left, mid);
#        mergeSort(arr, mid + 1, right);
#
#        // Merge the sorted halves
#        merge(arr, left, mid, right);
#    }
#}
#
#int main() {
#    int arr[] = { 12, 11, 13, 5, 6, 7 };
#    int n = sizeof(arr) / sizeof(arr[0]);
#    
#      // Sorting arr using mergesort
#    mergeSort(arr, 0, n - 1);
#
#    for (int i = 0; i < n; i++)
#        printf("%d ", arr[i]);
#    return 0;
#}

.data
arr:
    .word 11, 12, 10, 5, 3, 4   # Unsorted array
size:
    .word 6              # Placeholder for size of array
space: .asciiz "\n"


.text
.globl main
main:
    # store size
    addi $s3, $0, 1 # $s3 is temporary 1
    addi $s2, $0, 0 # left = 0
    lw $s1, size    # size
    sub $s3, $s1, $s3 # right = size - 1

mergeSort:
    #Debug Print
    sll $t5, $s2, 2
    sll $t6, $t3, 2
    lw $s5, arr($t5) # $s3 = arr[0]
    lw $s6, arr($t6) # $s6 = 

    add $a0, $0, $s5           # Load $s5 (arr[0]) into $a0 for printing
    addi $v0, $0, 1            # syscall for print integer
    syscall
    add $a0, $0, $s6           # Load $s6 (arr[0]) into $a0 for printing
    addi $v0, $0, 1            # syscall for print integer
    syscall

    
    slt $t1, $s2, $s3 # if (left < right)
    beq $t1, $0, exit

    # Calculate Midpoint
    sub $t2, $s3, $s2 # mid = right-left
    srl $t2, $t2, 1 # mid = (right-left)/2
    add $t2, $s2, $t2 # mid = left + (right-left) / 2

    # Sort First and second halves
    # First Half
    add $s3, $0, $t2 # Right of first half is mid
    jal mergeSort

    # Second Half
    addi $t3, $t2, 1 # mid + 1
    add $s2, $0, $t3 # left = mid + 1
    add $s3, $0, $s1 # right = right
    
exit:
    
    halt
