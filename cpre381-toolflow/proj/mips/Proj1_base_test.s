#
# Project 1 Base Test
# (Each instruction tested at least once)
#

# data section
.data

# code/instruction section
.text
addi  $8,  $0,    1 		# Load 1 in register 8        ($r8  = 0000 0001 [1] )
addi  $9,  $0,    2		# Load 2 in register 9        ($r9  = 0000 0002 [2] )
addi  $10, $0,    5		# Load 5 in register 10       ($r10 = 0000 0005 [5] )
add   $11, $8,   $9		# Load 1 + 2 in register 11   ($r11 = 0000 0003 [3] )
addi  $12, $0,   -3		# Load -3 into register 12    ($r12 = FFFF FFFD [-3])
addu  $13, $8,  $12		# Load 1 + -3 into register 13($r13 = 0000 0002 [2] )
bne   $2, $13, Reg2NEReg13      # Branch to end if reg 2 and reg 13 are not equal to each other (2)
addiu $14, $0,   -6		# Load -6 but really 6 in 14  ($r14 = 0000 0006 [6] )
and   $15, $0,    7		# Load 2 AND 5 in register 15 ($r15 = 0000 0007 [7] )
andi  $16, $11,   4		# Load 3 AND 4 in register 16 ($r16 = 0000 0007 [7] )
beq   $15,$16, Next             # Branch to next if reg 15 and reg 16 are equal to each other (7=7)
jr $ra

Next:
sub   $17, $11,  17		# Load 3 - 7 in register 17   ($r17 = FFFF FFFC [-4])
sll   $18, $17,   1             # Load 4 * 2 into register 18 ($r18 = 0000 0008 [8] )
subu  $19, $11, $10		# Load 3 - 5 unsigned into 19 ($r19 = 0000 0002 [2] )
jal ors                         # Call ors function
srl   $10, $12,   4             # Load -3 shift right logic 4 ($r10 = 0FFF FFFF [268435455])
sra   $11, $12,   4             # Load -3 shift right arith 4 ($r11 = FFFF FFFF [-1])
slt   $14, $12,   $13           # Load -3 < 2 into register 14 ($r14 = 0000 0001 [1] )
slti  $15, $17,   0             # Load -3 < 0 into register 15($r15 = 0000 0001 [1] )
lui   $16, 8                    # Load 8 into upper 8 bits    ($r16 = 0008 0000 [524288])
j Finish                        # Go to finish

ors:
or    $20, $17, $10             # Load -4 OR 7 in register 20 ($r20 = FFFF FFFF [-1])
ori   $21, $8,    6             # Load 1 OR 6 in register 21  ($r21 = 0000 0007 [7] )
xor   $22, $14, $15             # Load 7 XOR 6 in register 22 ($r22 = 0000 0001 [1] )
sll   $23, $10,   1             # Load 5 * 2 into register 23 ($r23 = 0000 000A [10])
xori  $8, $23,    7             # Load 10 XOR 7 in register 8 ($r8 = 0000 000D [13])
nor   $9, $11,   14             # Load -4 NOR 6 in register 9 ($r9 = 0000 0001 [1] )

To-DO-------------------------------------------
lw
sw
------------------------------------------------


Reg2NEReg13:
jr $ra

Finish:
jr $ra

halt
