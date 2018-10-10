/*
* Conditional and unconditional branching 
* if/else, goto, switch case
* Following examples have local variable/argument optimization
* (variables are stored in regs instead of stack)
*/

.globl __goto
.globl __if_else
.globl __switch_case

/* 
* Unconditional Jump - goto 
	__goto:
		goto done;
		i += 2;
		done: 
			i = 0;
*/
__goto:
	B set_10
	ADD x0, x0, #2                                          // increment by 2
set_10:
	MOV x0, #10
	RET

/* Conditionals */
/* __if_else
	if (i < 10)
		return 1;
	else 
		return 0
*/		
__if_else:
	CMP x0, #10                               // compare input with 10            
	B.gt false_if_else                        // take the 'else' path (not less that 10)
	MOV x0, #1                                // prepare return 1
	B done_if_else
false_if_else:
	MOV x0, #0                                // prepare return 0      
done_if_else: 
	RET

/*
__switch_case(int i)
        switch(i) {
        case 1:
                i = 10;
                break;
        case 3:
                i = 30;
        case 4:
                i = 40;
                break;
        case 7:
                i = 70;
                break;
        default:
                i = -1;
        }
        return i;
}
*/
 __switch_case:
	SUB     sp, sp, #0x10
	SUB     x0, x0, #0x1
	CMP     w0, #0x6
	B.hi    default_case  			// index is out of range, go to default case
	ADR     x1, rodata_base 		// load the base of the jump table
	ADD     x1, x1, #0x0
	LDR     w0, [x1,w0,uxtw #2]
	ADR     x1, first_case
	ADD     x0, x1, w0, sxtw #2
	BR      x0
first_case:
	MOV     w0, #10				// do case 1
	B       end_case
	MOV     w0, #30				// do case 3 and fall-through
	MOV     w0, #40				// do case 4
	B       end_case
	MOV     w0, #0x46			// do case 7
	B       end_case
default_case:
	MOV     w0, #-1                		// do default case 
end_case:
	ADD     sp, sp, #0x10
	RET

.rodata
rodata_base:
        .word   0x00000000
        .word   0x0000000b
        .word   0x00000003
        .word   0x00000005
        .word   0x0000000b
        .word   0x0000000b
        .word   0x00000008


