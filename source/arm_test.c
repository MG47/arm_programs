
#include <stdio.h>

extern int __increment(int i);
void test_increment()
{
	int i = 1;

	int ret = i;

	printf("\n\nTest incement:\n\n");
	printf("ret before inc =  %d\n", ret);
	printf("===BEGIN ASM===\n");

	ret = __increment(i);

	printf("===END ASM===\n");
	printf("ret after inc = %d\n", ret);
}

extern int __func_setup();
void test_function_setup()
{
	int i = 1, ret;

	printf("\n\nTest function setup:\n\n");

	ret = i;
	printf("ret before func =  %d\n", ret);
	printf("===BEGIN ASM===\n");

	ret = __func_setup(i);

	printf("===END ASM===\n");
	printf("ret after func =  %d\n", ret); // should be 3
}

extern int __bit_clear();
void test_bit_clear()
{
	int i = 0xd36F; // 0b1101001101101111

	int ret = i, bit = (1 << 1);

	printf("\n\nTest bit clear:\n\n");
	printf("ret before bit clear =  0x%x\n", ret);
	printf("===BEGIN ASM===\n");

	ret = __bit_clear(i, bit);

	printf("===END ASM===\n");
	printf("ret after bit clear = 0x%x\n", ret); // should be 0xD36D ( 0b1101001101101011)
}

extern int __bit_set();
void test_bit_set()
{
	int i = 0xd36F; // 0b1101001101101111

	int ret = i, bit = (1 << 4);

	printf("\n\nTest bit set:\n\n");
	printf("ret before bit set =  0x%x\n", ret);
	printf("===BEGIN ASM===\n");

	ret = __bit_set(i, bit);

	printf("===END ASM===\n");
	printf("ret after bitset = 0x%x\n", ret); // should be 0xD37F ( 0b1101001101111111)
}

extern int __bit_toggle();
void test_bit_toggle()
{
	int i = 0xd36F; // 0b1101001101101111

	int ret = i, bit = (1 << 3);

	printf("\n\nTest bit toggle:\n\n");
	printf("ret before bit toggle =  0x%x\n", ret);
	printf("===BEGIN ASM===\n");

	ret = __bit_toggle(i, bit);

	printf("===END ASM===\n");
	printf("ret after bit toggle = 0x%x\n", ret); // should be 0xD367 ( 0b1101001101100111)
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

extern int __do_while_loop(int i);
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

extern int __pointer_setup(int i);
void test_pointer_setup()
{
	/* add 2 to i using with pointers */
	int i = 3;

	printf("\n\nTest pointer setup:\n\n");
	printf("i before test =  %d\n", i);
	printf("===BEGIN ASM===\n");

	i = __pointer_setup(i);

	printf("===END ASM===\n");
	printf("i after test =  %d\n", i);
}

int main()
{
	printf("Arm assembly test...\n");

	/* Basic Assembly Testing */
	test_increment();
	test_function_setup();

	/* Bit Manipulation */
	test_bit_clear();
	test_bit_set();
	test_bit_toggle();

	/* Unconditional Jumps - goto */
	test_goto();

	/* Conditionals */
	test_if_else();

	/* Loops */
	test_do_while_loop();
	test_while_loop();
	test_for_loop();

	/* Pointers */
	test_pointer_setup();

	/* Error conditions */
	//	test_NULL_dereference();

	printf("Arm assembly test...DONE\n");

	return 0;
}
