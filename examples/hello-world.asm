.data

HW: .asciiz "Hello World \n"

.text

main:
	li $v0, 4
	la $a0, HW
	syscall
	
	li $v0, 10
	syscall
