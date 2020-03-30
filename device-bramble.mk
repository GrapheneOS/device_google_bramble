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

# LOCAL_PATH is device/google/redbull before this
LOCAL_PATH := device/google/bramble

PRODUCT_SOONG_NAMESPACES += \
    device/google/bramble

DEVICE_PACKAGE_OVERLAYS += device/google/bramble/bramble/overlay

# Audio XMLs for bramble

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/mixer_paths_bolero_snd.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_bolero_snd.xml \
    $(LOCAL_PATH)/audio/audio_platform_info_bolero_snd.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_platform_info_bolero_snd.xml \
    $(LOCAL_PATH)/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/a2dp_in_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_in_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/bluetooth_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/hearing_aid_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/hearing_aid_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml

# Audio ACDB data
ifeq ($(wildcard vendor/google_cei/factory/prebuilt/ftm.mk),)
PRODUCT_COPY_FILES += \
     $(LOCAL_PATH)/audio/acdbdata/Bluetooth_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/Bluetooth_cal.acdb \
     $(LOCAL_PATH)/audio/acdbdata/General_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/General_cal.acdb \
     $(LOCAL_PATH)/audio/acdbdata/Global_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/Global_cal.acdb \
     $(LOCAL_PATH)/audio/acdbdata/Handset_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/Handset_cal.acdb \
     $(LOCAL_PATH)/audio/acdbdata/Hdmi_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/Hdmi_cal.acdb \
     $(LOCAL_PATH)/audio/acdbdata/Headset_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/Headset_cal.acdb \
     $(LOCAL_PATH)/audio/acdbdata/Speaker_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/Speaker_cal.acdb \
     $(LOCAL_PATH)/audio/acdbdata/adsp_avs_config.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/adsp_avs_config.acdb

# Audio ACDB workspace files for QACT
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
PRODUCT_COPY_FILES += \
     $(LOCAL_PATH)/audio/acdbdata/workspaceFile.qwsp:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/workspaceFile.qwsp
endif
endif

# CS35L41 SPEAKER AMP
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/cs35l41/cs35l41-dsp1-spk-cali.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/cs35l41-dsp1-spk-cali.bin \
    $(LOCAL_PATH)/audio/cs35l41/cs35l41-dsp1-spk-cali.wmfw:$(TARGET_COPY_OUT_VENDOR)/firmware/cs35l41-dsp1-spk-cali.wmfw \
    $(LOCAL_PATH)/audio/cs35l41/R-cs35l41-dsp1-spk-cali.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/R-cs35l41-dsp1-spk-cali.bin \
    $(LOCAL_PATH)/audio/cs35l41/cs35l41-dsp1-spk-prot.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/cs35l41-dsp1-spk-prot.bin \
    $(LOCAL_PATH)/audio/cs35l41/cs35l41-dsp1-spk-prot.wmfw:$(TARGET_COPY_OUT_VENDOR)/firmware/cs35l41-dsp1-spk-prot.wmfw \
    $(LOCAL_PATH)/audio/cs35l41/R-cs35l41-dsp1-spk-prot.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/R-cs35l41-dsp1-spk-prot.bin \
    $(LOCAL_PATH)/audio/cs35l41/cs35l41-dsp1-spk-diag.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/cs35l41-dsp1-spk-diag.bin \
    $(LOCAL_PATH)/audio/cs35l41/cs35l41-dsp1-spk-diag.wmfw:$(TARGET_COPY_OUT_VENDOR)/firmware/cs35l41-dsp1-spk-diag.wmfw \
    $(LOCAL_PATH)/audio/cs35l41/R-cs35l41-dsp1-spk-diag.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/R-cs35l41-dsp1-spk-diag.bin

# Audio CS35L41 speaker calibration tool
PRODUCT_PACKAGES += \
    crus_sp_cal

ifeq ($(wildcard vendor/google_devices/bramble/proprietary/device-vendor-bramble.mk),)
    BUILD_WITHOUT_VENDOR := true
endif

PRODUCT_PACKAGES += \
    android.hardware.usb@1.2-service.bramble

# Vibrator HAL
PRODUCT_PACKAGES += \
    android.hardware.vibrator-service.bramble

# DRV2624 Haptics Waveform
PRODUCT_COPY_FILES += \
    device/google/bramble/vibrator/drv2624/drv2624.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/drv2624.bin

# Vibrator HAL
PRODUCT_PRODUCT_PROPERTIES +=\
    ro.vibrator.hal.config.dynamic=1 \
    ro.vibrator.hal.click.duration=7 \
    ro.vibrator.hal.tick.duration=7 \
    ro.vibrator.hal.heavyclick.duration=7 \
    ro.vibrator.hal.short.voltage=161 \
    ro.vibrator.hal.long.voltage=161 \
    ro.vibrator.hal.long.frequency.shift=10 \
    ro.vibrator.hal.steady.shape=1 \
    ro.vibrator.hal.lptrigger=0


# Hint expensive blurs for device with larger display
PRODUCT_PRODUCT_PROPERTIES += \
    ro.sf.blurs_are_expensive=1

# Dumpstate HAL
PRODUCT_PACKAGES += \
    android.hardware.dumpstate@1.1-service.bramble

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

# Support to disable thermal protection at run time
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
    PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/init.hardware.chamber.rc.userdebug:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.$(PRODUCT_HARDWARE).chamber.rc
endif

# Audio effects
PRODUCT_PACKAGES += \
    libqcomvoiceprocessingdescriptors

# Fingerprint HIDL
include device/google/bramble/fingerprint.mk
