#!/bin/bash

set -o pipefail

CURRENT_DIR=$(pwd)

cd "$PROJ_ROOT" || exit

/Users/runner/Library/Android/sdk/tools/bin/avdmanager list
sleep 20
flutter doctor -v
flutter pub get && flutter drive --target=test_driver/app.dart

cd "$CURRENT_DIR" || exit