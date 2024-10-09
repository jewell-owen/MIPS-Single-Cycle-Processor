#
# Test program for mips control flow instructions and has a call depth of at least 5 
# beq, bne, j, jal, jr
# The program should jump (in order) init, RUN2, RUN1, RUN4, RUN3, Finish RUN4 halt
# There's a chance 3 and 4 loop forever
#

# data section
.data

# code/instruction section
.text
init:
    addi  $1,  $0,  1 		# Place 1 in $1
    j RUN2                  # Jump to RUN2
RUN1
    addi $1, $1, 1          # Add 1 to $1
    addi $4, $0, 4          # Place 4 in $4
    bne  $1, $4, RUN4       # Jump 

RUN2
    addi $1, $1, 1          # Add 1 to $1
    addi $2, $0, 2          # Place 2 in $2
    beq  $1, $2, RUN1       # If $1(2) and $2(2) are equal, jump to RUN1

RUN3
    addi $1, $1, 1          # Add 1 to $1
    jr $ra                  # Jump to the return address $ra

RUN4
    addi $1, $1, 1          # Add 1 to $1
    jal RUN3                # Jump and write return address to $ra
    addi $1, $1, 5          # Add 5 to $1 after returning from RUN3

halt:
    lui $2, $0, 10         # This is after the exit comment in homework code, but it might be unnecessary 