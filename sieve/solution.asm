# Author: Vilhelm Prytz <vilhelm@prytznet.se> / <vprytz@kth.se>
# Reference sheet used https://www.kth.se/social/files/563c63c9f276547044e8695f/mips-ref-sheet.pdf

.data

primes: .space 400000
err_msg: .asciiz "Invalid input! Expected integer n, where 1 < n < 1001.\n"

.text
main:
	# get input
	li      $v0,5                   # set system call code to "read integer"
	syscall                         # read integer from standard input stream to $v0
	
	move $s2, $v0			# save input n to s2

	# validate input
 	li 	    $t0,1001                # $t0 = 1001
 	slt	    $t1,$v0,$t0		        # $t1 = input < 1001
	beq     $t1,$zero,invalid_input # if !(input < 1001), jump to invalid_input
	nop
	li	    $t0,1                   # $t0 = 1
	slt     $t1,$t0,$v0		        # $t1 = 1 < input
	beq     $t1,$zero,invalid_input # if !(1 < input), jump to invalid_input
	nop
	
	# initialise primes array
	la	    $t0,primes              # $s1 = address of the first element in the array
	li 	    $t1,999
	li 	    $t2,2
	li	    $t3,2
init_loop:
	sb	    $t2, ($t0)              # primes[i] = 1
	addi    $t0, $t0, 1             # increment pointer
	addi    $t2, $t2, 1             # increment counter
	bne	    $t2, $t1, init_loop     # loop if counter != 999
	
	# do implementation
	li	$t2, 2		# counter
	
removeprimesloop:
	la	$s0, primes	# $s0 address of first element in array
	beq $t2, $s2, printlist
	
	subi $s0, $s0, 2	# this is so stupid
	add $s0, $s0, $t2	# 
	
	move $t4, $t2	# new counter for movemultiple label †
	removemultiple:
		add $s0, $s0, $t2	# increment pointer with the int we are on that we want too remooove
		add $t4, $t4, $t2
		sb $0, ($s0)
		blt $t4, $s2, removemultiple
	
	addi $s0, $s0, 1	# increment pointer
	addi $t2, $t2, 1	# increment counter
	j removeprimesloop

printlist:
	la	$s0, primes	# $s0 address of first element in array
	li	$t2, 1		# counter

printlistloop:
	beq $t2, $s2, exit_program	

        lb $a0, ($s0)		# värdet av $s0
        beq $0, $a0, if		# hoppa över om värdet är 0
        li $v0, 1		# print char
        syscall
        li $a0, 32		# space character
        li $v0, 11		# print char
        syscall
        if:
        	addi $t2, $t2, 1
        	addi $s0, $s0, 1
        
        j printlistloop
	
	# exit program
	j       exit_program
	nop


invalid_input:
	# print error message
	li      $v0, 4                  # set system call code "print string"
	la      $a0, err_msg            # load address of string err_msg into the system call argument registry
	syscall                         # print the message to standard output stream

exit_program:
	# exit program
	li $v0, 10                      # set system call code to "terminate program"
	syscall                         # exit program