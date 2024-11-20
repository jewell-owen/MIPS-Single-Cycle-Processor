.text
main:
addi $t1, $0, 5
bne $t1, $0, skipAdd
addi $t1, $t1, 1

skipAdd:
addi $t1, $t1, 5