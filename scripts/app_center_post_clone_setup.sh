#!/usr/bin/env bash

# This scripts expects to be called from the project root.

set -exuo pipefail

# init env vars needed for scripts
source ./scripts/init_env.sh

source ./scripts/install_flutter_wrapper.sh
