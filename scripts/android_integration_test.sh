#!/bin/bash
set -euxo pipefail

if [ -z "${WS_ENDPOINT:-}" ]; then
  echo "WS_ENDPOINT not set, defaulting to localhost"
else
  echo "Using WS_ENDPOINT=$WS_ENDPOINT"
fi

./flutterw doctor -v

avdmanager list device || echo "error displaying emulator devices"

if [ "$RECORD" == "true" ]
then
  # default / maximum recording time is 180 seconds
  adb shell screenrecord /sdcard/recording.mp4 &

  export RECORDING_PID=${!}
  echo "Recording process up with pid: ${RECORDING_PID}"
fi

.flutter/bin/dart run melos integration-scan-test-android
.flutter/bin/dart run melos integration-app-test-android-screenshot

mkdir -p "$TEMP_DIR"

if [ "$RECORD" == "true" ]
then
  echo "killing recording process"
  sleep 5

  kill -SIGINT $RECORDING_PID || echo "Recording process already stopped"
  sleep 10

  adb pull /sdcard/recording.mp4  "$TEMP_DIR" || echo "could not fetch recording from device"
fi

# copy screenshots to TEMP_DIR
cp -r "$TEMP_DIR/test"/* "$TEMP_DIR" || echo "no screenshots found..."
rm -r "$TEMP_DIR/test" || true
