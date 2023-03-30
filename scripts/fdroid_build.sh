#!/usr/bin/env bash

# Build file for the f-droid build. The idea is that we do not need to update the
#
# https://gitlab.com/fdroid/fdroiddata/-/blob/master/metadata/org.encointer.wallet.yml
#
# if something in the build-process changes.

set -exuo pipefail

cd app

../flutterw config --no-analytics
../flutterw build apk --flavor fdroid
