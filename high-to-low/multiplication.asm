# Author: Vilhelm Prytz <vilhelm@prytznet.se> / <vprytz@kth.se>
# Reference sheet used https://www.kth.se/social/files/563c63c9f276547044e8695f/mips-ref-sheet.pdf

# int multiply(int a, int b) {
#     int i, sum = 0;
#     for (i = 0; i < a; i++)
#         sum += b;
#     return sum;
# }

# int faculty(int n) {
#     int i, fac = 1;
#     for (i = n; i > 1; i--)
#         fac = multiply(fac, i);
#     return fac;
# }

main:
    li $v0 5		# set system call code to "read integer"
    syscall		# read integer from standard input stream to $v0
    move $a0 $v0	# $a0 = $v0
    
    jal faculty		# "Jump and Link", basically run "faculty" subroutine
    
    move $a0 $v0	# $a0 = $v0
    li $v0 1		# set system call code to "print integer"
    syscall		# print out the value of $a0
    

multiply:
	# i = $t0
	# sum = $t1
	# a = $a0
	# b = $a1
	move $t0 $0	# both i and sum start
	move $t1 $0	# with the value 0

	# iterate from 0 up to first integer provided 
	m_loop:
		add $t1 $t1 $a1		# sum = sum + b
		addi $t0 $t0 1		# i++
		slt $t3 $t0 $a0		# "set less than", if $t0/i less than $a0/a then $t3=1 else $t3=0
		bne $t3 $0 m_loop	# start from top of loop until $t3 = 0
		nop

	move $v0 $t1	# $v0 = sum of a*b! :)
	jr $ra		# go back to where this was "called"

faculty:
	# n = $a0
	# i = $s0
	# fac = $s1
	li $s1 1	# set sum to 1
	move $s0 $a0	# $s0 = $a0 ($s0 = n, input argument)
    
	f_loop:
		move $a0 $s1 # $a0 = $s1
		move $a1 $s0 # $a1 = s0
		move $s3 $ra # $s3 = $ra
		jal multiply # call multiply
		move $ra $s3 # $r1 = $s3
		move $s1 $v0 # $s1 = v0
		addi $s0 $s0 -1 # subtract 1 from $s0
		bne $s0 1 f_loop # start from beginning of loop until $s0 = 1
		nop
	move $v0 $s1 # $v0=$s1 (return value)
	jr $ra
