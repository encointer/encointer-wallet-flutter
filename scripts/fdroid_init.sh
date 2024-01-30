#!/usr/bin/env bash

# Setup file for the f-droid build. The idea is that we do not need to update the
#
# https://gitlab.com/fdroid/fdroiddata/-/blob/master/metadata/org.encointer.wallet.yml
#
# if something in the build-process changes. However, we still need to manually update the flutter version in the
# `srclibs` key.

set -exuo pipefail

# init env vars needed for scripts
source ./scripts/init_env.sh