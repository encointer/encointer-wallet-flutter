#!/usr/bin/env bash

# Setup file for the f-droid build. The idea is that we do not need to update the
#
# https://gitlab.com/fdroid/fdroiddata/-/blob/master/metadata/org.encointer.wallet.yml
#
# if something in the build-process changes. However, we still need to manually update the flutter version in the
# `srclibs` key.
#
# NOTE: The fdroiddata YAML needs `sudo: apt-get install -y build-essential` for the C linker
# required by Rust cross-compilation.

set -exuo pipefail

# init env vars needed for scripts
source ./scripts/init_env.sh

# --- Rust toolchain (needed for ew_zk_prover native library) ---
# Pin versions for reproducible builds.
RUST_VERSION="1.83.0"
CARGO_NDK_VERSION="3.5.7"
ANDROID_TARGETS="aarch64-linux-android armv7-linux-androideabi x86_64-linux-android"

if ! command -v rustup &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    --default-toolchain "$RUST_VERSION" --profile minimal
  # shellcheck source=/dev/null
  source "$HOME/.cargo/env"
else
  echo "rustup already installed, ensuring correct toolchain"
  rustup install "$RUST_VERSION" --profile minimal
  rustup default "$RUST_VERSION"
fi

# Add Android cross-compilation targets
for target in $ANDROID_TARGETS; do
  rustup target add "$target"
done

# Install cargo-ndk for Android NDK integration
if ! cargo ndk --version &>/dev/null; then
  cargo install cargo-ndk --version "$CARGO_NDK_VERSION" --locked
else
  echo "cargo-ndk already installed: $(cargo ndk --version)"
fi

echo "Rust setup complete: $(rustc --version), cargo-ndk $(cargo ndk --version)"