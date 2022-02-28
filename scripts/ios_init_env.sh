#!/bin/bash
set -euo pipefail

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew tap wix/brew https://github.com/encointer/homebrew-brew
brew install applesimutils

# show available simulator runtimes
xcrun simctl list