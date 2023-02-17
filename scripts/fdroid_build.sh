#!/usr/bin/env bash

# Build file for the f-droid build. The idea is that we do not need to update the
#
# https://gitlab.com/fdroid/fdroiddata/-/blob/master/metadata/org.encointer.wallet.yml
#
# if something in the build-process changes.

set -exuo pipefail

./flutterw pub global run melos flutter-config-no-analytics
./flutterw pub global run melos build-apk
