#!/bin/bash

set -e

git clone https://github.com/Alioth-Tree/device_xiaomi_sm8250-common.git \
    device/xiaomi/sm8250-common -b 14 || true

git clone --depth=1 https://github.com/zen0s-aospforge/proprietary_vendor_xiaomi_sm8250-common.git \
    vendor/xiaomi/sm8250-common -b 16 || true

git clone --depth=1 https://github.com/zen0s-aospforge/vendor_xiaomi_alioth.git \
    vendor/xiaomi/alioth -b 16 || true

git clone https://github.com/ArrowOS-alioth/android_device_xiaomi_alioth.git \
    device/xiaomi/alioth -b 13.2 || true

git clone https://github.com/Alioth-Tree/hardware_xiaomi.git \
    hardware/xiaomi -b 14 || true

git clone --depth=1 https://github.com/kvsnr113/xiaomi_sm8250_kernel.git \
    kernel/xiaomi/sm8250 -b main || true

(
set -e

if [ ! -d "system/libhwbinder" ]; then
    exit 1
fi

cd system/libhwbinder

if git fetch https://github.com/custom-crdroid/system_libhwbinder.git \
    d9d46e78cec0d09498fd5890eed9f7195baed0fd 2>/dev/null; then
    if ! git cherry-pick d9d46e78cec0d09498fd5890eed9f7195baed0fd 2>/dev/null; then
        git cherry-pick --abort 2>/dev/null || true
    fi
fi

cd - > /dev/null
)
