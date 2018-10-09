/*
* loops - for, while, do while
* Following examples have local variable/argument optimization
* (variables are stored in regs instead of stack)
*/

.globl __do_while_loop
.globl __while_loop
.globl __for_loop

/*
__do_while_loop:
	do {
		i++
	} while (i < 10);
*/
__do_while_loop:
	ADD x0, x0, #1                          // add 1
	CMP x0, #9                              // check if less than 10
	B.le __do_while_loop                      // loop while less than 10
	RET

/*
__while_loop:
	while (i < 10)
	i++;
*/
__while_loop:
	B first_jump
run_loop:        
	ADD x0, x0, #1                  // add 1
first_jump:
	CMP x0, #9                      // check if less than 10
	B.le run_loop                    // loop while less than 10
	RET

/*
__for_loop:
	for (i = 0; i < 9; i ++)
		//NOP
*/
__for_loop:
	MOV x0, #0                              // loop initialization
do_for_loop:
	CMP x0, #9                             // condition
	B.gt done_for_loop
	NOP                                           // loop body
	ADD x0, x0, #1                          // increment
	B do_for_loop                           // loop
done_for_loop:                                  // done with loop
	RET

