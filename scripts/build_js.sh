#!/bin/bash
set -euo pipefail

CURRENT_DIR=$(pwd)

cd "$ENCOINTER_JS_DIR" || exit

yarn install
yarn run build

cd "$CURRENT_DIR" || exit