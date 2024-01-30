#!/bin/bash
set -euo pipefail

# script that sets the correct environment variables to execute other scripts

export SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export PROJ_ROOT="$(dirname "$SCRIPT_DIR")"

echo "Set environment variables:"
echo "  BASH_SCRIPT_DIR: $SCRIPT_DIR"
echo "  PROJ_ROOT: $PROJ_ROOT"
