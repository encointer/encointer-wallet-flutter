#!/bin/bash
set -euo pipefail

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew tap sconaway/brew https://github.com/SConaway/homebrew-brew/tree/patch-1
brew install applesimutils

# show available simulator runtimes
xcrun simctl list