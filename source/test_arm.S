/*
* Basic assembly
*/

.text
.globl __increment
.globl __func_setup

__increment:
	ADD x0, x0, #1                        //add 1 to the passed argument
	RET  x30                                 // return ('ret x30' - link register)

/* 
__func_setup_callee(int arg)
	return arg + 13;

__func_setup(int arg)
	arg = func_setup_callee(arg);
	return arg;
*/
__func_setup_callee:
	SUB SP, SP, #16                         // SP must always be aligned to 16-byte boundary
	STR x0, [SP, #8]                         // store arg
	LDR x0, [SP, #8]                         // load arg
	ADD x0, x0, #13                           // add 13 to arg
	STR x0, [SP, #8]                         // store arg
	LDR x0, [SP, #8]                         // load arg
	ADD SP, SP, #16                          
	RET

__func_setup:
	STP x29, x30, [SP, #-32]!                     // store FP & LR 
	MOV x29, SP    
	STR x0, [x29, #28]                               // save arg variable
	LDR x0, [x29, #28]                               // load arg variable for passing argument
	BL __func_setup_callee                        // branch
	STR x0, [x29, #28]                              // save return value to arg
	LDR   x0, [x29, #28]                            // load arg to return
	LDP x29, x30, [SP], #32                     // restore FP & LR 
	RET

