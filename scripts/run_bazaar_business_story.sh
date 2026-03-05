#!/bin/bash
set -euxo pipefail

# Bazaar business create/edit story test.
# Requires: WS_ENDPOINT, IPFS_GATEWAY, IPFS_AUTH_GATEWAY

if [ -z "${WS_ENDPOINT:-}" ]; then
    echo "WS_ENDPOINT not set, aborting tests"
    exit 1
fi

if [ -z "${IPFS_GATEWAY:-}" ] || [ -z "${IPFS_AUTH_GATEWAY:-}" ]; then
    echo "IPFS_GATEWAY or IPFS_AUTH_GATEWAY not set, aborting tests"
    exit 1
fi

cd app

../.flutter/bin/flutter drive \
  --no-enable-impeller \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/stories/bazaar_business_form_test.dart \
  --flavor dev \
  --dart-define=WS_ENDPOINT="$WS_ENDPOINT" \
  --dart-define=IPFS_GATEWAY="$IPFS_GATEWAY" \
  --dart-define=IPFS_AUTH_GATEWAY="$IPFS_AUTH_GATEWAY" \
  --dart-define=locales=en

echo "=== Bazaar business story complete ==="
