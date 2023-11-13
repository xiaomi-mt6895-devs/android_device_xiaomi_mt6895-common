#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit generic_ramdisk product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit the proprietary files
$(call inherit-product, vendor/xiaomi/mt6895-common/mt6895-common-vendor.mk)
