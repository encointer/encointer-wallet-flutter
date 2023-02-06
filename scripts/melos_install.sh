#!/bin/bash

set -euxo pipefail

export PATH="$PATH":"$HOME/.pub-cache/bin"

./flutterw pub global activate melos
