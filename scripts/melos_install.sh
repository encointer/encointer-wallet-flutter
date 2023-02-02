#!/bin/bash

set -euxo pipefail

echo "Salam :)"

export PATH="$PATH":"$HOME/.pub-cache/bin"

./flutterw pub global activate melos
