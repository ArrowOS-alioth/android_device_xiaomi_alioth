#!/bin/bash

# Clone ArrowOS-alioth repositories (branch 13)

# Remove and re-clone device/xiaomi/sm8250-common
if [ -d "device/xiaomi/sm8250-common" ]; then
    rm -rf device/xiaomi/sm8250-common
fi
git clone https://github.com/ArrowOS-alioth/android_device_xiaomi_sm8250-common.git device/xiaomi/sm8250-common -b 13.1


# Remove and re-clone vendor/xiaomi/sm8250-common
if [ -d "vendor/xiaomi/sm8250-common" ]; then
    rm -rf vendor/xiaomi/sm8250-common
fi
git clone https://github.com/ArrowOS-alioth/android_vendor_xiaomi_sm8250-common.git vendor/xiaomi/sm8250-common -b 13


# Remove and re-clone vendor/xiaomi/alioth
if [ -d "vendor/xiaomi/alioth" ]; then
    rm -rf vendor/xiaomi/alioth
fi
git clone https://github.com/ArrowOS-alioth/vendor_xiaomi_alioth.git vendor/xiaomi/alioth -b 13


# Remove and re-clone device/xiaomi/alioth
if [ -d "device/xiaomi/alioth" ]; then
    rm -rf device/xiaomi/alioth
fi
git clone https://github.com/ArrowOS-alioth/android_device_xiaomi_alioth.git device/xiaomi/alioth -b 13


# Remove and re-clone hardware/xiaomi
if [ -d "hardware/xiaomi" ]; then
    rm -rf hardware/xiaomi
fi
git clone https://github.com/ArrowOS-alioth/hardware_xiaomi.git hardware/xiaomi -b 13


# Remove and re-clone android_hardware_qcom-caf_sm8250_display
if [ -d "hardware/qcom-caf/sm8250/display" ]; then
    rm -rf hardware/qcom-caf/sm8250/display
fi
git clone https://github.com/ArrowOS-alioth/hardware_qcom-caf_display_sm8250.git hardware/qcom-caf/sm8250/display -b 13

# Script to apply Binder threadpool patch
(
set -e

echo "Applying Binder threadpool patch..."

if [ ! -d "system/libhwbinder" ]; then
    echo "Warning: system/libhwbinder directory not found."
    echo "Please run 'repo sync' first to fetch the source code."
    exit 1
fi

# Patch 1: system/libhwbinder
cd system/libhwbinder
echo "Fetching commit from custom-crdroid repository..."
if git fetch https://github.com/custom-crdroid/system_libhwbinder.git d9d46e78cec0d09498fd5890eed9f7195baed0fd 2>/dev/null; then
    echo "Applying commit d9d46e78cec0d09498fd5890eed9f7195baed0fd..."
    if git cherry-pick d9d46e78cec0d09498fd5890eed9f7195baed0fd 2>/dev/null; then
        echo "✅ Successfully applied Binder threadpool patch!"
    else
        echo "⚠️ Warning: Failed to cherry-pick libhwbinder commit. It may already be applied or have conflicts."
        echo "   Aborting this patch and continuing..."
        git cherry-pick --abort 2>/dev/null || true
    fi
else
    echo "⚠️ Warning: Failed to fetch libhwbinder commit from repository. Skipping this patch."
fi
cd - > /dev/null
)
