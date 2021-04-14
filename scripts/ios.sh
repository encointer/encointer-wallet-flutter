#!/bin/bash

set -o pipefail

echo "Available devices are:"
xcrun xctrace list devices

echo "Start device with ID ${DEVICE_ID}."
DEVICE_MATCHING="device=${DEVICE_ID}"
UDID=$(xcrun instruments -s | awk -F ' *[][]' -v "${DEVICE_MATCHING}" '$1 == device { print $2 }')
xcrun simctl boot "${UDID:?No Simulator with this name found}"