/*
* Structs
*/

.text
.globl __struct_set_value

/*
struct my_car {
	float max_speed;
	int color;
	char is_automatic;
};

__struct_set_value(struct my_car *mc)
	mc->max_speed = 180.0;
	mc->color = 2;
	mc->is_automatic = 1;
*/

__struct_set_value:
	ADR x1, max_speed_value 	// load address of (max_speed)
	LDR x1, [x1] 			// load float : 180.4
	STR x1, [x0] 			// *x0 <- max_speed
	MOV x1, #2 			// load color
	STR x1, [x0, #4] 		// *(x0 + 1) <- color
	MOV x1, #1 			// load is_automatic
	STR x1, [x0, #8]		// *(x0 + 2) <- is_automatic
	RET

.data
	max_speed_value:
	.word 	0x43346666 	// 180.4 in floating point representation

