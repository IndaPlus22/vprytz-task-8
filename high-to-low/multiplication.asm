# int multiply(int a, int b) {
#     int i, sum = 0;
#     for (i = 0; i < a; i++)
#         sum += b;
#     return sum;
# }

##
# Push value to application stack.
# PARAM: Registry with value.
##
.macro	PUSH (%reg)
	addi	$sp,$sp,-4              # decrement stack pointer (stack builds "downwards" in memory)
	sw	%reg,0($sp)             # save value to stack
.end_macro

##
# Pop value from application stack.
# PARAM: Registry which to save value to.
##
.macro	POP (%reg)
	lw	%reg,0($sp)             # load value from stack to given registry
	addi	$sp,$sp,4               # increment stack pointer (stack builds "downwards" in memory)
.end_macro


main:
	li $t0, 10 # t0 is a constant 10
	li $t1, 0 # t1 is our counter (i)
	loop:
	beq $t1, $t0, end # if t1 == 10 we are done
	
	# print output
	li  $v0, 1                          # set system call code to "print integer"
	syscall                             # print square of input integer to output stream
	
	addi $t1, $t1, 1 # add 1 to t1
	j loop # jump back to the top
	end: