#!/bin/bash
set -euxo pipefail

# Orchestrator for the multi-device QR payment story test.
#
# Step 1: Run Alice's test with the custom driver that writes QR payload to file.
# Step 2: Read the QR payload from the file.
# Step 3: Run Bob's test with the QR payload injected via --dart-define.
#
# Requires: WS_ENDPOINT to be set.

if [ -z "${WS_ENDPOINT:-}" ]; then
    echo "WS_ENDPOINT not set, aborting tests"
    exit 1
fi

cd app

echo "=== Step 1: Running Alice's QR show test ==="
../.flutter/bin/flutter drive \
  --driver=test_driver/alice_qr_driver.dart \
  --target=integration_test/stories/alice_show_qr_test.dart \
  --flavor dev \
  --dart-define=WS_ENDPOINT="$WS_ENDPOINT"

echo "=== Step 2: Reading QR payload ==="
QR_PAYLOAD=$(cat build/alice_qr_payload.b64)
echo "QR payload: ${QR_PAYLOAD:0:40}..."

echo "=== Step 3: Running Bob's scan and pay test ==="
../.flutter/bin/flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/stories/bob_scan_and_pay_test.dart \
  --flavor dev \
  --dart-define=WS_ENDPOINT="$WS_ENDPOINT" \
  --dart-define=QR_PAYLOAD="$QR_PAYLOAD"

echo "=== Multi-device QR payment story complete ==="
