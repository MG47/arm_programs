LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:=\
	arm_test.c \
	test_arm.S \
	test_arm_arrays.S \
	test_bit_ops.S \
	test_branching.S \
	test_loops.S \
	test_pointers.S \
	test_structs.S

LOCAL_CFLAGS:=-O0 -ggdb
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE := arm_test
LOCAL_LDFLAGS += -Wl,--no-fatal-warnings,-Map,arm_test.map

include $(BUILD_EXECUTABLE)
