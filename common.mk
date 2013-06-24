#Common headers
common_includes := hardware/qcom/display-cafold/libgralloc
common_includes += hardware/qcom/display-cafold/libgenlock
common_includes += hardware/qcom/display-cafold/liboverlay
common_includes += hardware/qcom/display-cafold/libcopybit
common_includes += hardware/qcom/display-cafold/libqdutils
common_includes += hardware/qcom/display-cafold/libhwcomposer
common_includes += hardware/qcom/display-cafold/libexternal
common_includes += hardware/qcom/display-cafold/libqservice

ifeq ($(TARGET_USES_POST_PROCESSING),true)
    common_flags     += -DUSES_POST_PROCESSING
    common_includes += $(TARGET_OUT_HEADERS)/pp/inc
endif


#Common libraries external to display-caf HAL
common_libs := liblog libutils libcutils libhardware

#Common C flags
common_flags := -DDEBUG_CALC_FPS -Wno-missing-field-initializers
common_flags += -Werror

ifeq ($(ARCH_ARM_HAVE_NEON),true)
    common_flags += -D__ARM_HAVE_NEON
endif

ifeq ($(TARGET_BOARD_PLATFORM), msm8974)
    common_flags += -DVENUS_COLOR_FORMAT
endif

common_deps  :=
kernel_includes :=

# Executed only on QCOM BSPs
ifeq ($(TARGET_USES_QCOM_BSP),true)
    common_flags += -DQCOM_BSP
endif
ifeq ($(call is-vendor-board-platform,QCOM),true)
ifneq ($(BOARD_VENDOR),sony)
    common_deps += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr
    kernel_includes += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
endif
endif
