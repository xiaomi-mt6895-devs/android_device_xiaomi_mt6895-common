#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

ONLY_COMMON=
ONLY_FIRMWARE=
ONLY_TARGET=
KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        --only-common )
                ONLY_COMMON=true
                ;;
        --only-firmware )
                ONLY_FIRMWARE=true
                ;;
        --only-target )
                ONLY_TARGET=true
                ;;
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

function blob_fixup {
    case "$1" in
        system_ext/lib64/libsink.so)
            grep -q "libshim_sink.so" "${2}" || "${PATCHELF}" --add-needed "libshim_sink.so" "${2}"
            ;;
        system_ext/lib64/libsource.so)
            grep -q "libui_shim.so" "${2}" || "${PATCHELF}" --add-needed "libui_shim.so" "${2}"
            ;;
        system_ext/etc/init/init.vtservice.rc|\
        vendor/etc/init/android.hardware.neuralnetworks-shim-service-mtk.rc)
            sed -i "s|start|enable|g" "${2}"
            ;;
        vendor/bin/hw/android.hardware.media.c2@1.2-mediatek-64b)
            grep -q "libstagefright_foundation-v33.so" "${2}" || "${PATCHELF}" --add-needed "libstagefright_foundation-v33.so" "${2}"
            ;;
        vendor/bin/hw/android.hardware.security.keymint@1.0-service.beanpod)
            grep -q "android.hardware.security.rkp-V1-ndk.so" "${2}" || "${PATCHELF}" --add-needed "android.hardware.security.rkp-V1-ndk.so" "${2}"
            ;;
        vendor/bin/hw/android.hardware.security.keymint@1.0-service.mitee)
            grep -q "android.hardware.security.rkp-V3-ndk.so" "${2}" || "${PATCHELF}" --add-needed "android.hardware.security.rkp-V3-ndk.so" "${2}"
            ;;
        vendor/lib64/mt6895/libaalservice.so|\
        vendor/bin/mnld)
            grep -q "libshim_sensors.so" "${2}" || "${PATCHELF}" --add-needed "libshim_sensors.so" "${2}"
            ;;
        vendor/lib64/hw/mt6895/vendor.mediatek.hardware.pq@2.15-impl.so)
            "${PATCHELF}" --replace-needed "libutils.so" "libutils-v32.so" "${2}"
            grep -q "libshim_sensors.so" "${2}" || "${PATCHELF}" --add-needed "libshim_sensors.so" "${2}"
            ;;
        vendor/lib64/hw/audio.primary.mediatek.so)
            grep -q "libstagefright_foundation-v33.so" "${2}" || "${PATCHELF}" --add-needed "libstagefright_foundation-v33.so" "${2}"
            "${PATCHELF}" --replace-needed "libalsautils.so" "libalsautils-v31.so" "${2}"
            ;;
        vendor/lib64/mt6895/libmtkcam_stdutils.so|\
        vendor/lib64/hw/mt6895/android.hardware.camera.provider@2.6-impl-mediatek.so)
            "${PATCHELF}" --replace-needed "libutils.so" "libutils-v32.so" "${2}"
            ;;
    esac
}

if [ -z "${ONLY_FIRMWARE}" ] && [ -z "${ONLY_TARGET}" ]; then
    # Initialize the helper for common device
    setup_vendor "${DEVICE_COMMON}" "${VENDOR_COMMON:-$VENDOR}" "${ANDROID_ROOT}" true "${CLEAN_VENDOR}"

    extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"
fi

if [ -z "${ONLY_COMMON}" ] && [ -s "${MY_DIR}/../../${VENDOR}/${DEVICE}/proprietary-files.txt" ]; then
    # Reinitialize the helper for device
    source "${MY_DIR}/../../${VENDOR}/${DEVICE}/extract-files.sh"
    setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

    if [ -z "${ONLY_FIRMWARE}" ]; then
        extract "${MY_DIR}/../../${VENDOR}/${DEVICE}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"
    fi

    if [ "${TARGET_TEE}" == "beanpod" ]; then
        extract "${MY_DIR}/../../${VENDOR_COMMON}/${DEVICE_COMMON}/proprietary-files-beanpod.txt" "${SRC}" "${KANG}" --section "${SECTION}"
    elif [ "${TARGET_TEE}" == "mitee" ]; then
        extract "${MY_DIR}/../../${VENDOR_COMMON}/${DEVICE_COMMON}/proprietary-files-mitee.txt" "${SRC}" "${KANG}" --section "${SECTION}"
    fi

    if [ -z "${SECTION}" ] && [ -f "${MY_DIR}/../../${VENDOR}/${DEVICE}/proprietary-firmware.txt" ]; then
        extract_firmware "${MY_DIR}/../../${VENDOR}/${DEVICE}/proprietary-firmware.txt" "${SRC}"
    fi
fi

"${MY_DIR}/setup-makefiles.sh"
