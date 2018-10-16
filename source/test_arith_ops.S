/*
* Arithmetic operations (integer and floating points)
* MUL and DIV are used instead of shifts
* Following examples have local variable/argument optimization
* (variables are stored in regs instead of stack)
*/

.globl __basic_int_arith
.globl __float_arith

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

/*
NOTE: Stack is used in this example
__float_arith:
	float a = 65.00, b = -1.223
	a = sqrt a --> a = 8.062258
	b = abs a --> b = 1.223
	a = a + b; --> a = 9.285257
	b = a - b; --> b = 8.062258
	a = a * b; --> a = 74.860138
	b = a / b; --> b = 9.285257
	b = round-down b = 9.000000
	return b;
*/

__float_arith:
	SUB SP, SP, #16
	ADR x0, __float_data
	LDR x1, [x0]
	STR x1, [SP]
	LDR x2, [x0, #4]
	STR x2, [SP, #4]

	LDR s0, [SP]
	FSQRT s0, s0 		// s0 <- sqrt s0 // a = sqrt 65 = 8.062258
	STR s0, [SP]

	LDR s1, [SP, #4]
	FABS s1, s1		// s1 <- abs s1 // b = abs s = 1.223
	STR s1, [SP, #4]

	LDR s0, [SP]
	LDR s1, [SP, #4]
	FADD s0, s0, s1 	// s0 <- s0 + s1 // a = a + b = 9.285257
	STR s0, [SP]

	LDR s0, [SP]
	LDR s1, [SP, #4]
	FSUB s1, s0, s1 	// s1 <- s0 - s1 // b = a - b = 8.062258
	STR s1, [SP, #4]

	LDR s0, [SP]
	LDR s1, [SP, #4]
	FMUL s0, s0, s1 	// s0 <- s0 * s1 // a = a * b = 74.860138
	STR s0, [SP]

	LDR s0, [SP]
	LDR s1, [SP, #4]
	FDIV s1, s0, s1 	// s0 <- s0 * s1 // b = a / b = 9.285257
	STR s1, [SP, #4]

	LDR s1, [SP, #4]
	FRINTM S1, S1 		// s1 <- round s1 // b = 9.000000
	FMOV s0, s1
	ADD SP, SP, #16
	RET

.data
	__float_data:
	.word 0x42820000 	//float 65.00
	.word 0xbf9c8b44	//float -1.223
