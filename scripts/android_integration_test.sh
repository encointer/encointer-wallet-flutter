#!/bin/bash
set -euxo pipefail

if [ -z "${WS_ENDPOINT:-}" ]; then
    echo "WS_ENDPOINT not set, aborting tests"
    exit 1
fi

./flutterw doctor -v
avdmanager list device || echo "error displaying emulator devices"

RECORDING_PID=""

cleanup() {
  if [ "$RECORD" == "true" ] && [ -n "$RECORDING_PID" ]; then
    echo "🔹 Stopping screen recording..."
    kill -SIGINT "$RECORDING_PID" || echo "Recording process already stopped"
    sleep 5
    mkdir -p "$TEMP_DIR"
    adb pull /sdcard/recording.mp4 "$TEMP_DIR" || echo "⚠️ Could not fetch recording from device"
  fi
}

# Ensure cleanup runs on exit, even if the script fails
trap cleanup EXIT

if [ "$RECORD" == "true" ]; then
  # default / maximum recording time is 180 seconds
  adb shell screenrecord /sdcard/recording.mp4 &
  RECORDING_PID=${!}
  echo "Recording process started with pid: $RECORDING_PID"
fi

echo "🚀 Running Flutter integration tests with WS_ENDPOINT=$WS_ENDPOINT"

cd app

# Regular Integration test
../.flutter/bin/flutter drive \
  --no-enable-impeller \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/app_test.dart \
  --flavor dev \
  --dart-define=WS_ENDPOINT="$WS_ENDPOINT" \
  --dart-define=locales=en

cd ..

# copy screenshots to TEMP_DIR
mkdir -p "$TEMP_DIR"
cp -r "$TEMP_DIR/test"/* "$TEMP_DIR" || echo "⚠️ no screenshots found..."
rm -r "$TEMP_DIR/test" || true
