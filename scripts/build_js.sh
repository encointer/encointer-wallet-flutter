#!/bin/bash

set -o pipefail

CURRENT_DIR=$(pwd)

cd "$ENCOINTER_JS_DIR" || exit

ls
echo "debug ENCOINTER_JS_DIR: $ENCOINTER_JS_DIR"

yarn install
yarn run build

cd "$CURRENT_DIR" || exit