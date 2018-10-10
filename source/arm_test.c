
#include <stdio.h>

extern int __increment(int i);
void test_increment()
{
	int i = 1;

	printf("\n\nTest incement:\n\n");
	printf("i before inc =  %d\n", i);
	printf("===BEGIN ASM===\n");

	i = __increment(i);

	printf("===END ASM===\n");
	printf("i after inc = %d\n", i);
}

extern int __func_setup();
void test_function_setup()
{
	int i = 1;

	printf("\n\nTest function setup:\n\n");

	printf("i before func =  %d\n", i);
	printf("===BEGIN ASM===\n");

	i = __func_setup(i);

	printf("===END ASM===\n");
	printf("i after func =  %d\n", i); // should be 3
}

extern int __bit_clear();
void test_bit_clear()
{
	int i = 0xd36F; // 0b1101001101101111
	int bit = (1 << 1);

	printf("\n\nTest bit clear:\n\n");
	printf("i before bit clear =  0x%x\n", i);
	printf("===BEGIN ASM===\n");

	i = __bit_clear(i, bit);

	printf("===END ASM===\n");
	printf("i after bit clear = 0x%x\n", i); // should be 0xD36D ( 0b1101001101101011)
}

extern int __bit_set();
void test_bit_set()
{
	int i = 0xd36F; // 0b1101001101101111
	int bit = (1 << 4);

	printf("\n\nTest bit set:\n\n");
	printf("i before bit set =  0x%x\n", i);
	printf("===BEGIN ASM===\n");

	i = __bit_set(i, bit);

	printf("===END ASM===\n");
	printf("i after bitset = 0x%x\n", i); // should be 0xD37F ( 0b1101001101111111)
}

extern int __bit_toggle();
void test_bit_toggle()
{
	int i = 0xd36F; // 0b1101001101101111

	int bit = (1 << 3);

	printf("\n\nTest bit toggle:\n\n");
	printf("i before bit toggle =  0x%x\n", i);
	printf("===BEGIN ASM===\n");

	i = __bit_toggle(i, bit);

	printf("===END ASM===\n");
	printf("i after bit toggle = 0x%x\n", i); // should be 0xD367 ( 0b1101001101100111)
}

void test_bit_ops()
{
	test_bit_clear();
	test_bit_set();
	test_bit_toggle();
}

extern int __logical_and(int a, int b);
void test_logical_and()
{
	int i = 1;
	int a = 4, b = 0;

	printf("\n\nTest logical and:\n\n");
	printf("i before logical and =  0x%x\n", i);
	printf("===BEGIN ASM===\n");

	i = __logical_and(a, b);

	printf("===END ASM===\n");
	printf("i after logical and = 0x%x\n", i);
}

extern int __logical_or(int a, int b);
void test_logical_or()
{
	int i = 0;
	int a = 4, b = 0;

	printf("\n\nTest logical or:\n\n");
	printf("i before logical or =  0x%x\n", i);
	printf("===BEGIN ASM===\n");

	i = __logical_or(a, b);

	printf("===END ASM===\n");
	printf("i after logical or = 0x%x\n", i);
}

extern int __logical_not(int a);
void test_logical_not()
{
	int i = 0;

	printf("\n\nTest logical not:\n\n");
	printf("i before logical not =  0x%x\n", i);
	printf("===BEGIN ASM===\n");

	i = __logical_not(i);

	printf("===END ASM===\n");
	printf("i after logical not = 0x%x\n", i);
}

void test_logical_ops()
{
	test_logical_and();
	test_logical_or();
	test_logical_not();
}

extern void __NULL_dereference();
void test_NULL_dereference()
{
	int *ptr = NULL;

	printf("\n\nTest NULL dereference:\n\n");
	printf("ptr =  0x%p\n", ptr);
	printf("===BEGIN ASM===\n");

	__NULL_dereference(ptr);

	printf("===END ASM===\n");
}

extern int __goto();
void test_goto()
{
	/*unconditional jump to i = 10; */
	int i = 4;

	printf("\n\nTest goto:\n\n");
	printf("i before goto =  %d\n", i);
	printf("===BEGIN ASM===\n");

	i = __goto(i);

	printf("===END ASM===\n");
	printf("i after goto =  %d\n", i);
}

extern int __if_else(int i);
void test_if_else()
{
	/* test if  i < 10, if true -> set i = 1 else set i = 0 */
	int i = 4;

	printf("\n\nTest if else:\n\n");
	printf("i before condition =  %d\n", i);
	printf("===BEGIN ASM===\n");

	i = __if_else(i);

	printf("===END ASM===\n");
	printf("i after condition =  %d\n", i);
}

extern int __switch_case(int i);
void test_switch_case()
{
	/* switch i : 1->10, 3->30 (fall-through to 4:), 4->40 7 -> 70, default -1 */
	int i = 4;

	printf("\n\nTest switch case:\n\n");
	printf("i before condition =  %d\n", i);
	printf("===BEGIN ASM===\n");

	i = __switch_case(i);

	printf("===END ASM===\n");
	printf("i after condition =  %d\n", i);
}

void test_branching()
{
	/* Unconditional Jumps - goto */
	test_goto();

	/* Conditionals */
	test_if_else();
	test_switch_case();
}


extern int  __do_while_loop(int i);
void test_do_while_loop()
{
	/* loop do while i < 10 */
	int i = 0;

	printf("\n\nTest do_while loop:\n\n");
	printf("i before condition =  %d\n", i);
	printf("===BEGIN ASM===\n");

	i = __do_while_loop(i);

	printf("===END ASM===\n");
	printf("i after condition =  %d\n", i);
}

extern int __while_loop(int i);
void test_while_loop()
{
	/* loop while i < 10 */
	int i = 0;

	printf("\n\nTest while loop:\n\n");
	printf("i before condition =  %d\n", i);
	printf("===BEGIN ASM===\n");

	i = __while_loop(i);

	printf("===END ASM===\n");
	printf("i after condition =  %d\n", i);
}

extern int __for_loop(int i);
void test_for_loop()
{
	/* loop for i = 0; i < 10; i++ */
	int i = 0;

	printf("\n\nTest for loop:\n\n");
	printf("i before condition =  %d\n", i);
	printf("===BEGIN ASM===\n");

	i = __for_loop(i);

	printf("===END ASM===\n");
	printf("i after condition =  %d\n", i);
}

void test_loops()
{
	test_do_while_loop();
	test_while_loop();
	test_for_loop();

}

extern int __pointer_setup(int i);
void test_pointer_setup()
{
	/* add 2 to i using pointers */
	int i = 3;

	printf("\n\nTest pointer setup:\n\n");
	printf("i before test =  %d\n", i);
	printf("===BEGIN ASM===\n");

	i = __pointer_setup(i);

	printf("===END ASM===\n");
	printf("i after test =  %d\n", i);
}

extern int __array_setup(int i);
void test_array_setup()
{
	/* arr[3] = {4, 1, 3} ; 
	arr[0] = 9; arr[1] = arr[1] + 1 -> 2; arr[2] = 6 return value at index i 
	*/
	int i = 1;

	printf("\n\nTest array setup:\n\n");
	printf("i before test =  %d\n", i);
	printf("===BEGIN ASM===\n");

	i = __array_setup(i);

	printf("===END ASM===\n");
	printf("i after test =  %d\n", i);
}

int main()
{
	printf("Arm assembly test...\n");

	/* Basic Assembly Testing */
	test_increment();
	test_function_setup();

	/* Bit manipulation */
	test_bit_ops();

	/* Logical operators */
	test_logical_ops();

	/* Branching - conditional/unconditional */
	test_branching();

	/* Loops */
	test_loops();

	/* Pointers */
	test_pointer_setup();
	/* Arrays */
	test_array_setup();

	/* Error conditions */
	//	test_NULL_dereference();

	// struct, bit fields

	/* TODO */
	// bit invert
	// arithmetic ops
	// relational
	// signed/unsigned int handling
	// float
	// pre vs post increment
	// TODO continue, break
	// TODO shifts - logical/arithmetic on signed/unsigned


	printf("Arm assembly test...DONE\n");

	return 0;
}

