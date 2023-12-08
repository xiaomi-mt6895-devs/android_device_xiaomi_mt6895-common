#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Inherit generic_ramdisk product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

# Installs gsi keys into ramdisk, to boot a developer GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)

# Project ID Quota
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Dalvik VM Configuration
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio@7.1-impl:64 \
    android.hardware.audio.effect@7.0-impl:64 \
    android.hardware.soundtrigger@2.3-impl:64 \
    android.hardware.audio.service

PRODUCT_PACKAGES += \
    audio.primary.default:64 \
    audio.bluetooth.default:64 \
    audio.usb.default:64 \
    android.hardware.bluetooth.audio-impl:64

PRODUCT_PACKAGES += \
    MtkInCallService

PRODUCT_PACKAGES += \
    libaudiofoundation.vendor:64 \
    libaudiopreprocessing:64 \
    libbluetooth_audio_session:64 \
    libbundlewrapper:64 \
    libalsautils:64 \
    libdownmix:64 \
    libdynproc:64 \
    libeffectproxy:64 \
    libhapticgenerator:64 \
    libldnhncr:64 \
    libnbaio_mono:64 \
    libreverbwrapper:64 \
    libtinycompress:64 \
    libvisualizer:64

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/audio/,$(TARGET_COPY_OUT_VENDOR)/etc)

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/bluetooth_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml

# Boot Control
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-mtkimpl:64 \
    android.hardware.boot@1.2-mtkimpl.recovery:64 \
    android.hardware.boot@1.2-service

PRODUCT_PACKAGES_DEBUG += \
    bootctl

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.1.vendor:64

# ConsumerIR
PRODUCT_PACKAGES += \
    android.hardware.ir-service.example

# Display
PRODUCT_PACKAGES += \
    android.hardware.graphics.composer@2.3-service \
    android.hardware.memtrack-service.mediatek-mali

PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@4.0.vendor:64 \
    android.frameworks.sensorservice@1.0.vendor:64 \
    libdrm.vendor:64 \
    libutils-v32

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm-service.clearkey

PRODUCT_PACKAGES += \
    android.hardware.drm@1.4.vendor:64

# Dynamic Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_BUILD_SUPER_PARTITION := false

PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl.custom:64 \
    fastbootd

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.3-service.xiaomi \

ifeq ($(TARGET_HAS_UDFPS),true)
PRODUCT_PACKAGES += \
    libudfpshandler \
    sensors.mt6895:64
endif

PRODUCT_PACKAGES += \
    vendor.xiaomi.hardware.fx.tunnel@1.0.vendor:64

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-impl:64 \
    android.hardware.gatekeeper@1.0-service

# GNSS
PRODUCT_PACKAGES += \
    android.hardware.gnss.measurement_corrections@1.1.vendor:64 \
    android.hardware.gnss.visibility_control@1.0.vendor:64 \
    android.hardware.gnss@1.1.vendor:64 \
    android.hardware.gnss@2.1.vendor:64 \
    android.hardware.gnss-V1-ndk_platform.vendor:64

# Health
PRODUCT_PACKAGES += \
    android.hardware.health-service.example \
    android.hardware.health-service.example_recovery

PRODUCT_PACKAGES += \
    android.hardware.health@1.0.vendor:64

# HIDL
PRODUCT_PACKAGES += \
    libhidltransport.vendor:64 \
    libhwbinder.vendor:64 \
    android.hidl.allocator@1.0.vendor:64

# IFAA manager
PRODUCT_PACKAGES += \
    IFAAService

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.0.vendor:64 \
    libkeymaster_messages.vendor:64 \
    libkeymaster_portable.vendor:64

# Keymint
PRODUCT_PACKAGES += \
    android.hardware.security.keymint-V1-ndk_platform.vendor:64 \
    android.hardware.security.secureclock-V1-ndk_platform.vendor:64 \
    android.hardware.security.sharedsecret-V1-ndk_platform.vendor:64 \
    android.hardware.security.rkp-V1-ndk.vendor:64 \
    lib_android_keymaster_keymint_utils.vendor:64 \
    libkeymint.vendor:64

PRODUCT_PACKAGES += \
    android.hardware.hardware_keystore.xml

# Light
PRODUCT_PACKAGES += \
    android.hardware.light-service.xiaomi

# Media
PRODUCT_PACKAGES += \
    libcodec2_hidl@1.1.vendor:64 \
    libcodec2_hidl@1.2.vendor:64 \
    libavservices_minijail_vendor:64 \
    libstagefright_softomx_plugin.vendor:64 \
    libsfplugin_ccodec_utils.vendor:64 \
    libcodec2_soft_common.vendor:64 \
    libstagefright_foundation-v33

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/seccomp,$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy) \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/media,$(TARGET_COPY_OUT_VENDOR)/etc)

# Overlays
PRODUCT_PACKAGES += \
    FrameworksResOverlayMT6895 \
    TetheringResOverlayMT6895 \
    SettingsOverlayMT6895 \
    SystemUIOverlayMT6895 \
    WifiResOverlayMT6895

# Radio
PRODUCT_PACKAGES += \
    android.hardware.radio.config@1.3.vendor:64 \
    android.hardware.radio@1.6.vendor:64

# Rootdir
PRODUCT_PACKAGES += \
    fstab.mt6895 \
    fstab.mt6895.vendor_ramdisk \
    init.batterysecret.rc \
    init.connectivity.rc \
    init.fingerprint.rc \
    init.mi_thermald.rc \
    init.modem.rc \
    init.mt6895.rc \
    init.mt6895.power.rc \
    init.mt6895.usb.rc \
    init.mtkgki.rc \
    init.sensor_2_0.rc \
    init.recovery.mt6895.rc \
    ueventd.mt6895.rc

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.consumerir.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.consumerir.xml \
    frameworks/native/data/etc/android.hardware.faketouch.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.faketouch.xml \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml \
    frameworks/native/data/etc/android.hardware.keystore.app_attest_key.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.keystore.app_attest_key.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.se.omapi.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.se.omapi.uicc.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.ims.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.ims.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.compute.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.passpoint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.passpoint.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.ipsec_tunnels.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.ipsec_tunnels.xml \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml \
    frameworks/native/data/etc/android.software.opengles.deqp.level-2021-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.opengles.deqp.level.xml \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.verified_boot.xml \
    frameworks/native/data/etc/android.software.vulkan.deqp.level-2021-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.vulkan.deqp.level.xml

# Power
PRODUCT_PACKAGES += \
    android.hardware.power-service.xiaomi-libperfmgr \
    vendor.mediatek.hardware.mtkpower@1.2-service.stub \
    libmtkperf_client_vendor:64 \
    libmtkperf_client:64

PRODUCT_PACKAGES += \
    android.hardware.power@1.2.vendor:64 \
    vendor.mediatek.hardware.mtkpower@1.0.vendor:64 \
    vendor.mediatek.hardware.mtkpower@1.1.vendor:64 \
    vendor.mediatek.hardware.mtkpower@1.2.vendor:64

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/powerhint.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.json

# Protobuf
PRODUCT_PACKAGES += \
    libprotobuf-cpp-lite-3.9.1-vendorcompat:64

# Modules
PRODUCT_PACKAGES += \
    init.insmod.sh \
    init.insmod.mt6895.cfg

# Secure Element
PRODUCT_PACKAGES += \
    android.hardware.secure_element@1.2.vendor:64 \
    libchrome.vendor:64

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors@1.0-service \
    android.hardware.sensors@1.0-impl-xiaomi:64 \
    libsensorndkbridge:64 \
    libshim_sensors

PRODUCT_PACKAGES += \
    sensors.dynamic_sensor_hal:64

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/google/pixel \
    hardware/google/interfaces \
    hardware/mediatek \
    hardware/xiaomi

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb@1.0.vendor:64 \
    android.hardware.usb@1.1.vendor:64 \
    android.hardware.usb@1.2.vendor:64 \
    android.hardware.usb@1.3.vendor:64 \
    android.hardware.usb.gadget@1.0.vendor:64 \
    android.hardware.usb.gadget@1.1.vendor:64

# Vibrator
PRODUCT_PACKAGES += \
    vendor.qti.hardware.vibrator.service.xiaomi_mt6895

# Wi-Fi
PRODUCT_PACKAGES += \
    wpa_supplicant \
    hostapd \
    android.hardware.wifi-service

PRODUCT_PACKAGES += \
    android.hardware.tetheroffload.config@1.0.vendor:64 \
    android.hardware.tetheroffload.control@1.0.vendor:64 \
    android.hardware.tetheroffload.control@1.1.vendor:64

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/wifi/,$(TARGET_COPY_OUT_VENDOR)/etc/wifi)

# Xiaomi
PRODUCT_PACKAGES += \
    vendor.xiaomi.hardware.mtdservice@1.3.vendor:64 \
    vendor.xiaomi.hardware.mlipay@1.1.vendor:64 \
    vendor.xiaomi.hardware.mfidoca@1.0.vendor:64

# Inherit the proprietary files
$(call inherit-product, vendor/xiaomi/mt6895-common/mt6895-common-vendor.mk)
