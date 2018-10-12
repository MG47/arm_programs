/*
* Bit operations
* Following examples have local variable/argument optimization
* (variables are stored in regs instead of stack)
*/

.globl __bit_clear
.globl __bit_set
.globl __bit_toggle
.globl __bit_complement

/*
__bit_clear(i, bit):
	i & ~(1 << bit)
	return i;
*/
__bit_clear:
	BIC x0, x0, x1                          // clear bits in x0, as given by x1
	RET

/*
__bit_set(i, bit):
	i | (1 << bit)
	return i;
*/
__bit_set:
	ORR x0, x0, x1                          // set bits in x0, as given by x1
	RET

/*
__bit_toggle(i, bit):
	i ^ (1 << bit)
	return i;
*/
__bit_toggle:
	EOR x0, x0, x1                          // toggle bits in x0, as given x1
	RET

/*
__bit_complement(i):
	return ~i;
*/
__bit_complement:
	MVN x0, x0 				// perform bitwise NOT on x0 and store in x0
	RET
