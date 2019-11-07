#
# Copyright (C) 2018 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

TARGET_BOOTLOADER_BOARD_NAME := bramble
TARGET_SCREEN_DENSITY := 420
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 165

CAMERA_VSYNC_COUNT := 2

include device/google/redbull/BoardConfig-common.mk
include device/google/bramble-sepolicy/bramble-sepolicy.mk

TARGET_BOARD_INFO_FILE := device/google/bramble/board-info.txt
USES_DEVICE_GOOGLE_BRAMBLE := true

TARGET_BOARD_COMMON_PATH := device/google/bramble/sm7250

# DTBO partition definitions
BOARD_PREBUILT_DTBOIMAGE := device/google/bramble-kernel/dtbo.img

TARGET_RECOVERY_UI_LIB := \
  librecovery_ui_bramble \
  libnos_citadel_for_recovery \
  libnos_for_recovery

TARGET_FS_CONFIG_GEN := device/google/bramble/config.fs

# Kernel modules
ifeq (,$(filter-out bramble_kasan, $(TARGET_PRODUCT)))
BOARD_VENDOR_KERNEL_MODULES += \
    $(wildcard device/google/bramble-kernel/kasan/*.ko)
else ifeq (,$(filter-out bramble_kernel_debug_memory, $(TARGET_PRODUCT)))
BOARD_VENDOR_KERNEL_MODULES += \
    $(wildcard device/google/bramble-kernel/debug_memory/*.ko)
else ifeq (,$(filter-out bramble_kernel_debug_locking, $(TARGET_PRODUCT)))
BOARD_VENDOR_KERNEL_MODULES += \
    $(wildcard device/google/bramble-kernel/debug_locking/*.ko)
else ifeq (,$(filter-out bramble_kernel_debug_hang, $(TARGET_PRODUCT)))
BOARD_VENDOR_KERNEL_MODULES += \
    $(wildcard device/google/bramble-kernel/debug_hang/*.ko)
else ifeq (,$(filter-out bramble_kernel_debug_api, $(TARGET_PRODUCT)))
BOARD_VENDOR_KERNEL_MODULES += \
    $(wildcard device/google/bramble-kernel/debug_api/*.ko)
else
BOARD_VENDOR_KERNEL_MODULES += \
    $(wildcard device/google/bramble-kernel/*.ko)
endif

# DTB
ifeq (,$(filter-out bramble_kasan, $(TARGET_PRODUCT)))
BOARD_PREBUILT_DTBIMAGE_DIR := device/google/bramble-kernel/kasan
else ifeq (,$(filter-out bramble_kernel_debug_memory, $(TARGET_PRODUCT)))
BOARD_PREBUILT_DTBIMAGE_DIR := device/google/bramble-kernel/debug_memory
else ifeq (,$(filter-out bramble_kernel_debug_locking, $(TARGET_PRODUCT)))
BOARD_PREBUILT_DTBIMAGE_DIR := device/google/bramble-kernel/debug_locking
else ifeq (,$(filter-out bramble_kernel_debug_hang, $(TARGET_PRODUCT)))
BOARD_PREBUILT_DTBIMAGE_DIR := device/google/bramble-kernel/debug_hang
else ifeq (,$(filter-out bramble_kernel_debug_api, $(TARGET_PRODUCT)))
BOARD_PREBUILT_DTBIMAGE_DIR := device/google/bramble-kernel/debug_api
else
BOARD_PREBUILT_DTBIMAGE_DIR := device/google/bramble-kernel
endif

# Testing related defines
#BOARD_PERFSETUP_SCRIPT := platform_testing/scripts/perf-setup/b5-setup.sh

-include vendor/google_devices/bramble/proprietary/BoardConfigVendor.mk
