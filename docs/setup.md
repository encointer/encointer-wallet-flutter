# Setup

## Ubuntu

Install Android Studio from snap and set it up as follows:
1. Tools > SDK manager > Install SDK Android 8.0 Oreo (not sure if version matters much)
2. ... Tools > Install SDK commandline tools
3. Settings > Plugins > Install Flutter

then:

```shell
sudo apt install cmake ninja-build libgtk-3-dev npm build-essential
./scripts/install_flutter_wrapper.sh
# install project deps (i.e., melos)
.flutter/bin/dart pub get
.flutter/bin/dart run melos bootstrap
```

### Rust toolchain (for ZK prover native library)

The `ew_zk_prover` package includes a Rust FFI crate that is cross-compiled during Android builds via `cargo-ndk`. Install the Rust toolchain and Android cross-compilation targets:

```shell
# Install Rust (if not already installed)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install cargo-ndk for Android cross-compilation
cargo install cargo-ndk

# Add Android targets
rustup target add aarch64-linux-android armv7-linux-androideabi x86_64-linux-android

# For running Dart FFI tests on the Linux host
rustup target add x86_64-unknown-linux-gnu
```

To build the host native library for running tests locally:
```shell
cd packages/ew_zk_prover/rust
cargo build --release
mkdir -p ../native/linux
cp target/release/libew_zk_prover.so ../native/linux/
```

In studio: under run configurations, add build flavor `dev`

Now: run!

## Windows

Essentially only a project wide flutter installation is needed. A simple trick to install flutter wrapper like above is
to open a Git Bash shell on windows to run the `./scripts/install_flutter_wrapper.sh`. All `.flutter\bin\dart`
commands work from a windows terminal, so the rest of the installation steps are the same.

## Additional Info

### Flutter wrapper and the .flutter git submodule

This project uses [flutter_wrapper](https://github.com/passsy/flutter_wrapper). Flutter wrapper is a tool that enables
having the same flutter version across multiple developers. It installs automatically the flutter version form the
pubspec.yaml into the `.flutter` submodule.

Vscode automatically uses the `.flutter` as we have checked in the `.vscode` folder. For setting up the Android Studio,
please refer to the [documentation](https://github.com/passsy/flutter_wrapper#ide-setup).

### Linux and MacOs
Linux and MacOs users can simply replace all `flutter` CLI commands with `./flutterw` and it will just work.

### Windows
In windows, this does unfortunately not work, but you can refer to the executables directly with:
`.flutter\bin\flutter` and `.flutter\bin\dart`.

**Note:** On windows, Git fails to update the flutter submodule when it has been changed on remote. This can be fixed with:
```shell
git submodule update --init
```
