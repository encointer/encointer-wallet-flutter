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

######################### Setup phase

DISTRO="linux-x64"
NODE_VERSION="14.17.1" # should match the value from the CI.
SHA_SUM="2921eba80c839e06d68b60b27fbbcbc7822df437f3f8d58717ec5a7703563ba4"
NODE="node-v${NODE_VERSION}-${DISTRO}"

curl -Lo node.tar.xz "https://nodejs.org/dist/v${NODE_VERSION}/${NODE}.tar.xz"
echo "${SHA_SUM} node.tar.xz" | sha256sum -c -

tar -vxf node.tar.xz && rm node.tar.xz

export PATH=$PATH:$PWD/${NODE}/bin

echo "Path: $PATH"

node -v

# Build JS
./scripts/build_js.sh

######################### Cleanup phase

echo "Remove all binary files as f-droid does not allow them the repository"
rm -r ${NODE}
rm -r "${ENCOINTER_JS_DIR}/node_modules"
rm -r "${ENCOINTER_JS_DIR}/.yarn"