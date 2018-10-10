/*
* Logical operations - AND, OR, NOT
* Following examples have local variable/argument optimization
* (variables are stored in regs instead of stack)
*/

.globl __logical_and
.globl __logical_or
.globl __logical_not

/*
__logical_and(int a, int b)
	return a && b;
*/
__logical_and:
	CMP x0, #0 		// check arg 1 == 0
	B.eq and_set_zero 	// return zero if arg 1 == 0
	CMP x1, #0 		// check arg 2 == 0
	B.eq and_set_zero	// return zero if arg 2 == 0
	MOV x0, #1 		// return 1
	B and_done
and_set_zero:
	MOV x0, #0
and_done:
	RET

/*
__logical_or(int a, int b)
	return a || b;
*/
__logical_or:
	CMP x0, #0 		// check if arg 1 != 0
	B.ne or_set_one 	// return one if arg 1 != 0
	CMP x1, #0 		// check if arg 2 != 0
	B.ne or_set_one 	// return one if arg 2 != 0
	MOV x0, #0 		// return zero
	B or_done
or_set_one:
	MOV x0, #1
or_done:
	RET

/*
__logical_not(int a)
	return  !a;
*/
__logical_not:
	CMP x0, #0 			// compare arg with 0
	b.eq not_set_one 		// set 1 if arg == 0
	MOV x0, #0 			// set 0 otherwise
	b not_done
not_set_one:
	MOV x0, #1
not_done:
	RET

