#!/bin/bash
set -euxo pipefail

melos doctor

./flutterw pub global run melos integration-scan-test-ios
./flutterw pub global run melos integration-app-test-ios-screenshot
