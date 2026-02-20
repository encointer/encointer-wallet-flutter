#!/bin/bash
set -uxo pipefail

if [ -z "${WS_ENDPOINT:-}" ]; then
    echo "WS_ENDPOINT not set, aborting tests"
    exit 1
fi

./flutterw doctor -v
avdmanager list device || echo "error displaying emulator devices"

RECORDING_PID=""
CURRENT_RECORDING=""

start_recording() {
  local name="$1"
  if [ "${RECORD:-}" == "true" ]; then
    adb shell screenrecord "/sdcard/${name}.mp4" &
    RECORDING_PID=${!}
    CURRENT_RECORDING="$name"
    echo "Recording started: ${name}.mp4 (pid: $RECORDING_PID)"
  fi
}

stop_recording() {
  if [ "${RECORD:-}" == "true" ] && [ -n "$RECORDING_PID" ]; then
    echo "Stopping recording: ${CURRENT_RECORDING}.mp4"
    kill -SIGINT "$RECORDING_PID" || echo "Recording process already stopped"
    wait "$RECORDING_PID" 2>/dev/null || true
    sleep 5
    mkdir -p "$TEMP_DIR"
    adb pull "/sdcard/${CURRENT_RECORDING}.mp4" "$TEMP_DIR" || echo "Could not fetch recording from device"
    RECORDING_PID=""
    CURRENT_RECORDING=""
  fi
}

cleanup() {
  stop_recording
}

trap cleanup EXIT

MAIN_EXIT=0
QR_EXIT=0

# --- Main integration test ---
start_recording "recording_main"

echo "Running main integration test with WS_ENDPOINT=$WS_ENDPOINT"

cd app

../.flutter/bin/flutter drive \
  --no-enable-impeller \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/app_test.dart \
  --flavor dev \
  --dart-define=WS_ENDPOINT="$WS_ENDPOINT" \
  --dart-define=locales=en \
  || MAIN_EXIT=$?

cd ..

stop_recording

# Copy screenshots to TEMP_DIR
mkdir -p "$TEMP_DIR"
cp -r "$TEMP_DIR/test"/* "$TEMP_DIR" || echo "no screenshots found..."
rm -r "$TEMP_DIR/test" || true

# --- QR payment story test ---
start_recording "recording_qr_story"

echo "Running QR payment story test"

./scripts/run_qr_payment_story.sh || QR_EXIT=$?

stop_recording

# --- Report results ---
echo "Main test exit code: $MAIN_EXIT"
echo "QR story exit code: $QR_EXIT"

if [ "$MAIN_EXIT" -ne 0 ] || [ "$QR_EXIT" -ne 0 ]; then
  exit 1
fi
