.text
.globl __array_setup

/*
__array_setup(int arg)
        arr[0] = 3;
        arr[1] = arr[1] + 1;
        arr[2]  = 6;
	return arr[arg]
*/
//TODO
__array_setup:
	SUB SP, SP, #16
	MOV x4, x0 		// Move arg to x4
	ADR x0, my_array 	// load address of base of array

	LDR x1, [x0] 		// X1 <- arr[0]
	STR x1, [SP]
	LDR x1, [SP]
	MOV x1, #9 		// arr[0] = 9
	STR x1, [SP]
	LDR x1, [SP]

	LDR x1, [x0, #4] 	// X1 <- arr[1]
	STR x1, [SP, #4]
	LDR x1, [SP, #4]
	ADD x1, x1, 1 		// arr[1] = arr[1] + 1
	STR x1, [SP, #4]
	LDR x1, [SP, #4]

	LDR x1, [x0, #8] 	// X1 <- arr[2]
	STR x1, [SP, #8]
	LDR x1, [SP, #8]
	MOV x1, #6 		// arr[2] = 6
	STR x1, [SP, #8]
	LDR x1, [SP, #8]

	LSL x4, x4, #2 		// multiply index by 4 for 32-bit int
	LDR x0, [SP, x4] 	// Load to x0, (arr[i]) for return;
	ADD SP, SP, #16
	RET

.data
/* arr[3] = {4, 1, 3} ; */
	my_array:
	.word 0x00000004
	.word 0x00000001
	.word 0x00000003

