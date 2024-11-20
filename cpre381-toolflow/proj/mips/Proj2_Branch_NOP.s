.data
value:   .word 42

.text
main:
lw   $s0, value
addi $s1, $s0, 8