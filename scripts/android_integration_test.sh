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
    # Android screenrecord has a 180s hard limit per recording.
    # Chain up to 5 segments (15 min total) to cover long-running tests.
    (
      for i in 1 2 3 4 5; do
        adb shell screenrecord --time-limit 180 "/sdcard/${name}_part${i}.mp4" || break
      done
    ) &
    RECORDING_PID=$!
    CURRENT_RECORDING="$name"
    echo "Recording started: ${name} (pid: $RECORDING_PID, chained 180s segments)"
  fi
}

stop_recording() {
  if [ "${RECORD:-}" == "true" ] && [ -n "$RECORDING_PID" ]; then
    echo "Stopping recording: ${CURRENT_RECORDING}"
    kill "$RECORDING_PID" 2>/dev/null || true
    sleep 3
    mkdir -p "$TEMP_DIR"
    for i in 1 2 3 4 5; do
      adb pull "/sdcard/${CURRENT_RECORDING}_part${i}.mp4" "$TEMP_DIR" 2>/dev/null || true
    done
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
BAZAAR_EXIT=0

# --- Main integration test ---
if [ "${SKIP_MAIN:-}" != "true" ]; then
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
else
  echo "Skipping main integration test (SKIP_MAIN=true)"
fi

# --- QR payment story test ---
if [ "${SKIP_QR:-}" != "true" ]; then
  echo "Clearing app data before QR payment story"
  adb shell pm clear org.encointer.wallet || echo "Could not clear app data"

  start_recording "recording_qr_story"

  echo "Running QR payment story test"

  ./scripts/run_qr_payment_story.sh || QR_EXIT=$?

  stop_recording
else
  echo "Skipping QR payment story test (SKIP_QR=true)"
fi

# --- Bazaar business story test ---
if [ -n "${IPFS_GATEWAY:-}" ] && [ -n "${IPFS_AUTH_GATEWAY:-}" ]; then
  echo "Clearing app data before bazaar business story"
  adb shell pm clear org.encointer.wallet || echo "Could not clear app data"

  start_recording "recording_bazaar_story"

  echo "Running bazaar business story test"
  ./scripts/run_bazaar_business_story.sh || BAZAAR_EXIT=$?

  stop_recording
else
  echo "Skipping bazaar story (IPFS_GATEWAY not set)"
fi

# --- Report results ---
echo "Main test exit code: $MAIN_EXIT"
echo "QR story exit code: $QR_EXIT"
echo "Bazaar story exit code: $BAZAAR_EXIT"

if [ "$MAIN_EXIT" -ne 0 ] || [ "$QR_EXIT" -ne 0 ] || [ "$BAZAAR_EXIT" -ne 0 ]; then
  exit 1
fi
