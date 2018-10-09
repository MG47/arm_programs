/*
* Pointers, function pointers
*/

.globl __pointer_setup
.globl __NULL_dereference

/* 
__pointer_setup(int arg)
	int *ptr_to_arg = &arg;
	*ptr_to_arg += 2;
	return i;
*/
__pointer_setup:
	SUB SP, SP, #16
	STR x0, [SP, #12]                // store arg
	ADD x0,  SP, #12               // load pointer of arg to ptr_to_arg
	STR x0, [SP, #24]                // store pointer
	LDR x0, [SP, #24]                // load pointer
	LDR x1, [x0]                        // load value pointed to by the pointer
	ADD x1, x1, #2                   // add 2 to the value
	STR x1, [x0]                       // store at address pointed to by x0
	LDR x0, [SP, #12]                      // load arg for return
	ADD SP, SP, #16
	RET

/*
__NULL_dereference(int arg)
	*arg = 3;
*/
__NULL_dereference:                     
	LDR x0, [x0]                            // load from address given in x0
	MOV x0, #3
	RET

