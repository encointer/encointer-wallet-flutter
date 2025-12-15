#!/bin/bash
set -euxo pipefail

if [ -z "${WS_ENDPOINT:-}" ]; then
    echo "WS_ENDPOINT not set, aborting tests"
    exit 1
fi

./flutterw doctor -v

avdmanager list device || echo "error displaying emulator devices"

echo "🚀 Running Flutter integration tests with WS_ENDPOINT=$WS_ENDPOINT"

cd app

# Scanner print screen
#../.flutter/bin/flutter drive \
#  --no-enable-impeller \
#  --target=test_driver/scan_page.dart \
#  --flavor dev \
#  --dart-define=WS_ENDPOINT="$WS_ENDPOINT" \

# Regular Integration test
../.flutter/bin/flutter drive \
  --no-enable-impeller \
  --target=test_driver/app.dart \
  --flavor dev \
  --dart-define=WS_ENDPOINT="$WS_ENDPOINT" \
  --dart-define=locales=en

cd ..

echo "✅ Flutter integration tests completed successfully"
