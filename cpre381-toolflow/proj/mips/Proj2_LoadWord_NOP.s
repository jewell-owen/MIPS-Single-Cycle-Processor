.data
value:   .word 42

.text
main:
lw   $s0, value
NOP
addi $s1, $s0, 8