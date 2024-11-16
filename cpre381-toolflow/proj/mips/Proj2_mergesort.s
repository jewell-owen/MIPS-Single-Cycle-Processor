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
newline: .asciiz "\n"      # Newline string for output
tempArray:  .word 0:100    # Global array to store sorted values (c[100])
array:    .word 25, 92, 79, 80, 31, 63, 16, 10  # Sample array with 8 elements

.text

main:
    addi $a1, $zero, 0     # $a1 = left index = 0 (low index)
    addi $a2, $zero, 7     # $a2 = right index = 7 (high index)
    jal mergeSort          # Call mergeSort function 
    NOP
    NOP
    jal print              # Call print function to display sorted array
    NOP
    NOP

merge:
    add  $s0, $a1, $zero   # $s0 = i (low index), i = low
    add  $s1, $a1, $zero   # $s1 = k (index for tempArray), k = low
    addi $s2, $a3, 1       # $s2 = j (right half start), j = mid + 1

while1: 
    slt $t1, $a3, $s0	# If mid < i...
    NOP
    NOP
    NOP
    bne $t1, $0, while2 	# exit while1 loop
    NOP
    slt $t1, $a2, $s2	# If high < j
    NOP
    NOP
    NOP
    bne $t1, $0, while2	#exit while loop
    NOP
    j  if                      # If i <= mid && j <= high, proceed to if block
    NOP
    
if:
    sll  $t0, $s0, 2           # $t0 = i*4, offset for accessing array[i]
    #lw   $t1, array($t0)       # Load value of a[i] into $t1
    lui $1,4097
    NOP
    NOP
    NOP
    addu $1,$1,$8
    NOP
    NOP
    lw $9,404($1)
    sll  $t2, $s2, 2           # $t2 = j*4, offset for accessing array[j]
    #lw   $t3, array($t2)       # Load value of a[j] into $t3    
    lui $1,4097
    NOP
    NOP
    NOP
    addu $1,$1,$10
    NOP
    NOP
    lw $11, 404($1)
    NOP
    NOP
    NOP
    slt  $t4, $t3, $t1         # If a[j] < a[i], set $t4 = 1
    NOP
    NOP
    bne  $t4, $0, else          # Jump to else block if a[j] < a[i]
    NOP
    
    sll  $t5, $s1, 2           # $t5 = k*4, offset for storing in tempArray
    #sw   $t1, tempArray($t5)   # Store a[i] in tempArray[k]
    lui $1, 4097
    NOP
    NOP
    NOP
    addu $1, $1, $13
    NOP
    NOP
    sw $9,4($1)
    addi $s1, $s1, 1           # Increment k (s1)
    addi $s0, $s0, 1           # Increment i (s0)
    j    while1                # Go to next iteration of while1 loop
    NOP
    
else:
    sll  $t2, $s2, 2           # $t2 = j*4, offset for accessing array[j]
    #lw   $t3, array($t2)       # Load value of a[j] into $t3  
    lui $1,4097
    NOP
    NOP
    NOP
    addu $1,$1,$10
    NOP
    NOP
    lw $11,404($1)  
    sll  $t5, $s1, 2           # $t5 = k*4, offset for storing in tempArray
    #sw   $t3, tempArray($t5)   # Store a[j] in tempArray[k]
    lui $1, 4097
    NOP
    NOP
    NOP
    addu $1,$1,$13
    NOP
    NOP
    sw $11,4($1)
    addi $s1, $s1, 1           # Increment k (s1)
    addi $s2, $s2, 1           # Increment j (s2)
    j    while1                # Go to next iteration of while1 loop
    NOP
    
while2:
    slt  $t2, $a3, $s0         # If mid < i...
    #bne  $t2, 0, while3        # Jump to while3 if true
    addi $1,$0,0
    bne $1,$10,while3
    sll  $t0, $s0, 2           # $t0 = i*4
    #lw   $t1, array($t0)       # Load value of a[i] into $t1
    lui $1,4097
    addu $1,$1,$8
    lw $9,404($1)
    sll  $t3, $s1, 2           # $t3 = k*4
    #sw   $t1, tempArray($t3)   # Store a[i] in tempArray[k]
    lui $1,4097
    addu $1,$1,$11
    sw $9, 4($1)
    addi $s1, $s1, 1           # Increment k (s1)
    addi $s0, $s0, 1           # Increment i (s0)
    j    while2                # Go to next iteration of while2 loop
    NOP
    
while3:
    slt  $t2, $a2, $s1         # If high < j...
    #bne  $t2, 0, forInit       # Jump to forInit loop if true
    addi $1,$0,0
    NOP
    NOP
    bne $1,$10,forInit
    sll  $t2, $s2, 2           # $t2 = j*4, offset for accessing array[j]
    #lw   $t3, array($t2)       # Load value of a[j]
    lui $1,4097
    NOP
    NOP
    addu $1,$1,$10
    NOP
    NOP
    lw $11,404($1)
    sll  $t5, $s1, 2           # $t5 = k*4, offset for storing in tempArray
    #sw   $t3, tempArray($t5)   # Store a[j] in tempArray[k]
    lui $1,4097
    NOP
    NOP
    addu $1,$1,$13
    NOP
    NOP
    sw $11,4($1)
    addi $s1, $s1, 1           # Increment k (s1)
    addi $s2, $s2, 1           # Increment j (s2)
    j    while3                # Go to next iteration of while3 loop
    NOP

forInit:
    add  $t0, $a1, $zero       # Initialize $t0 to low for for loop
    addi $t1, $a2, 1           # Initialize $t1 to high + 1 for for loop
    NOP
    j    for                    # Jump to for loop
    NOP

for:
    slt  $t7, $t0, $t1         # If $t0 < $t1, $t7 = 1
    beq  $t7, $zero, sortEnd   # If $t7 = 0, end the loop and go to sortEnd
    sll  $t2, $t0, 2           # $t2 = $t0 * 4 to get the offset for tempArray
    #lw   $t6, tempArray($t2)   # Load value from tempArray[i] into $t6
    lui $1,4097
    NOP
    NOP
    NOP
    addu $1,$1,$10
    NOP
    NOP
    lw $14,4($1)
    #sw   $t6, array($t2)       # Store the value from tempArray[i] into array[i]
    lui $1,4097
    NOP
    NOP
    NOP
    addu $1,$1, $10
    NOP
    NOP
    sw $14,404($1)
    addi $t0, $t0, 1           # Increment $t0 (i++) for next iteration
    NOP
    j    for                   # Go to next iteration of for loop
    NOP

sortEnd:
    NOP
    NOP
    jr   $ra                    # Return from the merge function
    NOP
    
mergeSort:
    slt  $t0, $a1, $a2         # If low < high, set $t0 = 1
    NOP
    NOP
    beq  $t0, $zero, return     # If $t0 = 0, return (base case)
    NOP
    
    addi $sp, $sp, -16          # Allocate space on stack for 4 items
    NOP
    NOP
    NOP
    sw   $ra, 12($sp)           # Save return address on the stack
    sw   $a1, 8($sp)            # Save value of low in the stack
    sw   $a2, 4($sp)            # Save value of high in the stack

    add  $s0, $a1, $a2          # mid = low + high
    NOP
    NOP
    sra  $s0, $s0, 1            # mid = (low + high) / 2
    NOP
    NOP
    sw   $s0, 0($sp)            # Save mid to the stack
    NOP
    NOP    
    add  $a2, $s0, $zero        # Set high = mid to sort the first half of array
    NOP
    jal  mergeSort              # Recursive call to mergeSort for the first half
    NOP
    NOP
    
    lw   $s0, 0($sp)            # Load mid from the stack
    NOP
    NOP
    NOP
    addi $s1, $s0, 1            # Set low = mid + 1 for the second half
    NOP
    NOP
    add  $a1, $s1, $zero        # Set low = mid + 1
    lw   $a2, 4($sp)            # Load high from the stack
    NOP
    NOP
    jal  mergeSort              # Recursive call to mergeSort for the second half
    NOP
    NOP
    
    lw   $a1, 8($sp)            # Restore low from the stack
    lw   $a2, 4($sp)            # Restore high from the stack
    lw   $a3, 0($sp)            # Restore mid from the stack and pass it to merge
    jal  merge                  # Call merge function to merge the sorted halves
    NOP
    NOP
    
    lw   $ra, 12($sp)           # Restore return address from the stack
    addi $sp, $sp, 16           # Restore stack pointer
    jr   $ra                    # Return from mergeSort

return:
    NOP
    jr   $ra                    # Return to the calling routine
    NOP

print:
    lui $1,4097
    lw $8,404($1)
    lw $9,408($1)
    lw $10,412($1)
    lw $11,416($1)
    lw $12,420($1)
    lw $13,424($1)
    lw $14,428($1)
    lw $15,432($1)
    
exit:
    li   $v0, 10                # Exit program syscall
    syscall
    halt
    
    
    
    
    
    
    
    
    
    
