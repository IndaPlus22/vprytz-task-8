# Author: Vilhelm Prytz <vilhelm@prytznet.se> / <vprytz@kth.se>

# int multiply(int a, int b) {
#     int i, sum = 0;
#     for (i = 0; i < a; i++)
#         sum += b;
#     return sum;
# }

.globl  main

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

.text
main:




