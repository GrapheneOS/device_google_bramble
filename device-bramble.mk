#
# Copyright 2016 The Android Open Source Project
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

PRODUCT_HARDWARE := bramble

ifeq ($(TARGET_PREBUILT_KERNEL),)
    LOCAL_KERNEL := device/google/bramble-kernel/Image.lz4
else
    LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_VENDOR_KERNEL_HEADERS := device/google/bramble-kernel/sm7250/kernel-headers

include device/google/redbull/device-common.mk

PRODUCT_SOONG_NAMESPACES += \
    device/google/bramble

DEVICE_PACKAGE_OVERLAYS += device/google/bramble/bramble/overlay

# Audio XMLs for bramble

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio_policy_configuration_a2dp_offload_disabled.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration_a2dp_offload_disabled.xml \
    $(LOCAL_PATH)/audio_policy_configuration_bluetooth_legacy_hal.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration_bluetooth_legacy_hal.xml \
    $(LOCAL_PATH)/bluetooth_hearing_aid_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_hearing_aid_audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/a2dp_in_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_in_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/bluetooth_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/hearing_aid_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/hearing_aid_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml

# LOCAL_PATH is device/google/redbull before this
LOCAL_PATH := device/google/bramble

ifeq ($(wildcard vendor/google_devices/bramble/proprietary/device-vendor-bramble.mk),)
    BUILD_WITHOUT_VENDOR := true
endif

PRODUCT_PACKAGES += \
    android.hardware.usb@1.2-service.bramble

# Vibrator HAL
PRODUCT_PACKAGES += \
    android.hardware.vibrator@1.3-service.bramble

# Dumpstate HAL
PRODUCT_PACKAGES += \
    android.hardware.dumpstate@1.0-service.bramble

#per device
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/bramble/init.bramble.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.bramble.rc

# insmod files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.insmod.bramble.cfg:$(TARGET_COPY_OUT_VENDOR)/etc/init.insmod.bramble.cfg

# Recovery
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.recovery.device.rc:recovery/root/init.recovery.bramble.rc \
    $(LOCAL_PATH)/thermal-engine-$(PRODUCT_HARDWARE).conf:$(TARGET_COPY_OUT_VENDOR)/etc/thermal-engine-$(PRODUCT_HARDWARE).conf

PRODUCT_PACKAGES += \
    sensors.$(PRODUCT_HARDWARE) \

# Thermal HAL config
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/thermal_info_config_$(PRODUCT_HARDWARE).json:$(TARGET_COPY_OUT_VENDOR)/etc/thermal_info_config.json

# Audio effects
PRODUCT_PACKAGES += \
    libqcomvoiceprocessingdescriptors
