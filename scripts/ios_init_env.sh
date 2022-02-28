#!/bin/bash
set -euo pipefail

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew update

brew tap SConaway/brew
brew install applesimutils

# show available simulator runtimes
xcrun simctl list