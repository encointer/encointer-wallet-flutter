#!/bin/bash

set -o pipefail

echo "looking for emulator with device id: ${DEVICE_ID}"

echo "Available devices are:"
xcrun xctrace list devices 2>&1

DEVICE_MATCHER="($DEVICE_ID \(.*\).*)"
UUID=$(xcrun xctrace list devices 2>&1 | grep -oE "(${DEVICE_MATCHER})" | grep -oE "([A-F0-9]{8}-[A-F0-9]{4}-4[A-F0-9]{3}-[89AB][A-F0-9]{3}-[A-F0-9]{12})")

xcrun simctl boot "${UUID:?No Simulator with this name found}"