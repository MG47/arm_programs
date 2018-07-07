
.text
.globl __increment
.globl __bit_clear
.globl __bit_set
.globl __bit_toggle
.globl __NULL_dereference
.globl __func_setup
.globl __goto
.globl __if_else
.globl __while_loop
.globl __for_loop
.globl __pointer_setup

__increment:
        ADD x0, x0, #1                        //add 1 to the passed argument
        RET  x30                                 // return ('ret x30' - link register)

__bit_clear:
        BIC x0, x0, x1                          // clear bits in x0, as given by x1
        RET

__bit_set:
        ORR x0, x0, x1                          // set bits in x0, as given by x1
        RET

__bit_toggle:
        EOR x0, x0, x1                          // toggle bits in x0, as given x1
        RET

__NULL_dereference:                     
        LDR x0, [x0]                            // load from address given in x0
        RET

__func_setup_callee:
        /* __func_setup_callee(int arg)
                       return arg + 13;
        */
        SUB SP, SP, #16                         // SP must always be aligned to 16-byte boundary
        STR x0, [SP, #8]                         // store arg
        LDR x0, [SP, #8]                         // load arg
        ADD x0, x0, #13                           // add 13 to arg
        STR x0, [SP, #8]                         // store arg
        LDR x0, [SP, #8]                         // load arg
        ADD SP, SP, #16                          
        RET

/*
        __func_setup(int arg)
                arg = func_setup_callee(arg);
                return arg;
*/
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

/* Unconditional */
__goto:
        B set_10
        ADD x0, x0, #2                                          // increment by 2
set_10:
        MOV x0, #10
        RET

/* Conditionals */
__if_else:
        CMP x0, #10                             // compare input with 10            
        B.gt false_if_else                        // take the 'else' path (not less that 10)
        MOV x0, #1                                // prepare return 1
        B done_if_else
false_if_else:
        MOV x0, #0                                // prepare return 0      
done_if_else: 
        RET

/* Loops - no optimization*/
/* TODO no optimization - do load and store of i */
__while_loop:
        ADD x0, x0, #1                          // add 1
        CMP x0, #10                              // check if less than 10
        B.le __while_loop                      // loop while less than 10
        RET

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

/* Pointers */
__pointer_setup:
        /* 
        __pointer_setup(int arg)
        int *ptr_to_arg = &arg;
        *ptr_to_arg += 2;
        return i;
         */
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
