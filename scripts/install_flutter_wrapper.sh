#!/usr/bin/env bash

# To make the flutter cmd available to the calling shell, this script needs to be called with `source`

set -exuo pipefail

sh -c "$(curl -fsSL https://raw.githubusercontent.com/passsy/flutter_wrapper/cb2b1dee20f0c05b64b4df0961fa0e2189253b01/install.sh)"

# `precache` ensures that the correct Dart SDK and binaries for IOS and android exist.

./flutterw doctor
