#
# Copyright (C) 2020 The Evolution X Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/realme/RMX2001

# Installs gsi keys into ramdisk, to boot a GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Setup dalvik vm configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-4096-dalvik-heap.mk)

# Inherit vendor
$(call inherit-product, vendor/realme/RMX2001/RMX2001-vendor.mk)

# Define Dynamic Partition support
PRODUCT_TARGET_VNDK_VERSION := 29
PRODUCT_SHIPPING_API_LEVEL := 29
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_BUILD_SUPER_PARTITION := false

# A/B
AB_OTA_UPDATER := false

# Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    libaacwrapper

# Boot animation
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080

# Camera
PRODUCT_PACKAGES += \
    Snap

# Device Settings
PRODUCT_PACKAGES += \
    devicesettings

# fastbootd
PRODUCT_PACKAGES += \
    fastbootd

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/etc/fstab.mt6785:$(TARGET_COPY_OUT_RAMDISK)/fstab.mt6785

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.1-service.wasabi \
    vendor.oppo.hardware.biometrics.fingerprint@2.1

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.fingerprint.xml

# HIDL
PRODUCT_PACKAGES += \
    android.hidl.base@1.0_system \
    android.hidl.manager@1.0_system

# Hotword Enrollement
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/hotword-hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/hotword-hiddenapi-package-whitelist.xml \
    $(DEVICE_PATH)/configs/permissions/privapp-permissions-hotword.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-hotword.xml

# ImsInit hack
PRODUCT_PACKAGES += \
    ImsInit
    
# Init
PRODUCT_PACKAGES += \
    init.mt6785.rc \
    init.devicesetting.rc \
    fstab.mt6785 \
	fstab.swap \
	init.swap.rc \
	set_zram.sh

# Keylayouts
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/idc/mtk-kpd.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/mtk-kpd.idc \
    $(DEVICE_PATH)/configs/keylayout/mtk-kpd.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/mtk-kpd.kl

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service.wasabi

# NFC
PRODUCT_PACKAGES += \
    NfcNci

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(DEVICE_PATH)/overlay

# Overlays -- replace official
PRODUCT_PACKAGES += \
    FrameworkResOverlay

# Screen density
PRODUCT_AAPT_CONFIG := xxxhdpi
PRODUCT_AAPT_PREF_CONFIG := xxxhdpi

# Power
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/power/powercontable.xml:$(TARGET_COPY_OUT_VENDOR)/etc/powercontable.xml \
    $(LOCAL_PATH)/configs/power/powerscntbl.xml:$(TARGET_COPY_OUT_VENDOR)/etc/powerscntbl.xml

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += $(DEVICE_PATH)

# Telephony Jars
PRODUCT_BOOT_JARS += \
    mediatek-common \
    mediatek-framework \
    mediatek-ims-base \
    mediatek-ims-common \
    mediatek-telecom-common \
    mediatek-telephony-base \
    mediatek-telephony-common

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/permissions/privapp-permissions-mediatek.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-mediatek.xml

# Trustonic TEE
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/public.libraries-trustonic.txt:$(TARGET_COPY_OUT_SYSTEM)/etc/public.libraries-trustonic.txt

# Properties
-include $(DEVICE_PATH)/properties.mk
PRODUCT_COMPATIBLE_PROPERTY_OVERRIDE := true

# Open GAPPs
#GAPPS_VARIANT  := nano
#$(call inherit-product, vendor/opengapps/build/opengapps-packages.mk)
