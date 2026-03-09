#!/bin/bash
set -euo pipefail

echo "Looking for simulator: ${DEVICE_ID}"

# Determine runtime version from Xcode (e.g. 26.2.0 → 26.2)
XCODE_VER="${XCODE_TEST_VERSION:-}"
RUNTIME="${XCODE_VER%.*}"  # strip patch → 26.2

echo "Available devices:"
xcrun xctrace list devices 2>&1

# Prefer simulator matching current Xcode runtime, exclude paired-watch entries
UUID=""
if [ -n "$RUNTIME" ]; then
  UUID=$(xcrun xctrace list devices 2>&1 \
    | grep "$DEVICE_ID" \
    | grep "Simulator ($RUNTIME)" \
    | grep -v " + " \
    | head -1 \
    | grep -oE '([A-F0-9]{8}-[A-F0-9]{4}-4[A-F0-9]{3}-[89AB][A-F0-9]{3}-[A-F0-9]{12})') || true
fi

# Fallback: any matching simulator (excludes paired-watch entries)
if [ -z "$UUID" ]; then
  echo "Warning: no simulator found for runtime ${RUNTIME:-unknown}, falling back to first match"
  UUID=$(xcrun xctrace list devices 2>&1 \
    | grep "$DEVICE_ID" \
    | grep -v " + " \
    | head -1 \
    | grep -oE '([A-F0-9]{8}-[A-F0-9]{4}-4[A-F0-9]{3}-[89AB][A-F0-9]{3}-[A-F0-9]{12})')
fi

echo "Selected UUID: ${UUID:?No simulator found for $DEVICE_ID}"

echo "Booting simulator..."
xcrun simctl boot "$UUID"

echo "Waiting for boot completion..."
xcrun simctl bootstatus "$UUID" -b

echo "Setting notification permissions..."
applesimutils --byId "$UUID" --bundle "org.encointer.wallet" --setPermissions "notifications=YES"

echo "Simulator ready"
