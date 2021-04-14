#!/bin/bash

flutter pub get

# due to a bug in xcode need to sleep a while, else the recording is empty

xcrun simctl io booted recordVideo recording.mov & sleep 5

export RECORDING_PID=${!}
echo "Recording process up with pid: ${RECORDING_PID}"

flutter drive --target=test_driver/app.dart

sleep 5
kill -SIGINT $RECORDING_PID
sleep 10

mkdir "$TEMP_DIR"
cp recording.mov "$TEMP_DIR"