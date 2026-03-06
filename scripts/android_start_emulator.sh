#!/bin/bash
set -euo pipefail

# Start Android emulator from cached AVD snapshot and wait for boot.
# Used by android_device_ci.yml to decouple emulator lifecycle from test execution.

AVD=$(${ANDROID_HOME}/emulator/emulator -list-avds | head -1)
echo "Starting emulator with AVD: $AVD"

${ANDROID_HOME}/emulator/emulator -avd "$AVD" \
  -no-snapshot-save -no-window -gpu swiftshader_indirect \
  -noaudio -no-boot-anim -camera-back none &

adb wait-for-device
echo "Device connected, waiting for boot..."

# Poll until boot completes (timeout after 120s)
TIMEOUT=120
ELAPSED=0
while [ "$(adb shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')" != "1" ]; do
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
