#!/bin/bash
set -euo pipefail

# Start Android emulator from cached AVD snapshot and wait for boot.
# Used by android_device_ci.yml to decouple emulator lifecycle from test execution.
#
# Required env: API_LEVEL (e.g. 33)
# Optional env: EMU_TARGET (default: google_apis), EMU_ARCH (default: x86_64)

API_LEVEL="${API_LEVEL:?API_LEVEL must be set}"
EMU_TARGET="${EMU_TARGET:-google_apis}"
EMU_ARCH="${EMU_ARCH:-x86_64}"

# Install system image and emulator (reactivecircus/android-emulator-runner does this internally)
echo "Installing system image for API ${API_LEVEL}..."
sdkmanager --install "system-images;android-${API_LEVEL};${EMU_TARGET};${EMU_ARCH}" emulator "platforms;android-${API_LEVEL}"

AVD=$("${ANDROID_HOME}/emulator/emulator" -list-avds | head -1)
if [ -z "$AVD" ]; then
  echo "No AVD found. Creating one..."
  echo "no" | avdmanager create avd -n test -k "system-images;android-${API_LEVEL};${EMU_TARGET};${EMU_ARCH}" --force
  AVD="test"
fi
echo "Starting emulator with AVD: $AVD"

"${ANDROID_HOME}/emulator/emulator" -avd "$AVD" \
  -no-snapshot-save -no-window -gpu swiftshader_indirect \
  -noaudio -no-boot-anim -camera-back none &
EMU_PID=$!

adb wait-for-device
echo "Device connected, waiting for boot..."

# Poll until boot completes (timeout after 180s)
TIMEOUT=180
ELAPSED=0
while [ "$(adb shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')" != "1" ]; do
  if ! kill -0 "$EMU_PID" 2>/dev/null; then
    echo "Emulator process died unexpectedly"
    exit 1
  fi
  sleep 2
  ELAPSED=$((ELAPSED + 2))
  if [ "$ELAPSED" -ge "$TIMEOUT" ]; then
    echo "Emulator boot timed out after ${TIMEOUT}s"
    exit 1
  fi
done

echo "Emulator booted in ${ELAPSED}s"

# Disable animations
adb shell settings put global window_animation_scale 0
adb shell settings put global transition_animation_scale 0
adb shell settings put global animator_duration_scale 0

echo "Animations disabled, emulator ready"
