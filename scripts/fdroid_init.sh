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
NODE_VERSION="16.13.1" # should match the value from the CI.
SHA_SUM="5f80197d654fd0b749cdeddf1f07a5eac1fcf6b423a00ffc8f2d3bea9c6dc8d1"
NODE="node-v${NODE_VERSION}-${DISTRO}"

curl -Lo node.tar.gz "https://nodejs.org/dist/v${NODE_VERSION}/${NODE}.tar.gz"
echo "${SHA_SUM} node.tar.gz" | sha256sum -c -

tar -vxf node.tar.gz && rm node.tar.gz

export PATH=$PATH:$PWD/${NODE}/bin

echo "Path: $PATH"

node -v

# enable binary proxies, which automatically install yarn, if needed.
corepack enable

# Build JS
./scripts/build_js.sh

######################### Cleanup phase

echo "Remove all binary files as f-droid does not allow them the repository"
rm -r ${NODE}
rm -r "${ENCOINTER_JS_DIR}/node_modules"
rm -r "${ENCOINTER_JS_DIR}/.yarn"