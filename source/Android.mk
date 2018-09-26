LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:=\
	arm_test.c \
	test_arm.S \
	
#LOCAL_SYSTEM_SHARED_LIBRARIES := libc

LOCAL_CFLAGS:=-O0 -ggdb

LOCAL_MODULE_TAGS := eng

#LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)

LOCAL_MODULE := arm_test

LOCAL_LDFLAGS += -Wl,--no-fatal-warnings,-Map,arm_test.map

include $(BUILD_EXECUTABLE)
