/*
* Arithmetic operations (integer and floating points)
* MUL and DIV are used instead of shifts
* Following examples have local variable/argument optimization
* (variables are stored in regs instead of stack)
*/

.globl __basic_int_arith

/*
__basic_int_arith(int a, int b) 	//a = 3, b = 4;
	a = a + b; --> a = 7
	b = a - b; --> b = 3
	a = a * b; --> a = 21
	b = a / b; --> b = 7
	a++;
	i = a % b; --> 1
	return i;
*/
__basic_int_arith:
	ADD x0, x0, x1 		// x0 <- x0 + x1 (a + b)
	SUB x1, x0, x1		// x1 <- x0 - x1 (a - b)
	MUL x0, x0, x1		// x0 <- x0 * x1 (a * b)
	SDIV x1, x0, x1 	// x1 <- x0 / x1 (a / b)
	ADD x0, x0, #1 		// x0 <- x0 + 1
	SDIV x2, x0, x1 	// x2 <- x0 / x1 (a / b)	// to get %
	MUL x2, x2, x1 		// x2 <- x2 * x1 ((a / b) * b)
	SUB x0, x0, x2		// x0 <- x0 - x2 ((a) - ((a / b) * b)
	RET

