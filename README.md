# Encointer Wallet

Encointer wallet and client for mobile phones

[<img src="https://fdroid.gitlab.io/artwork/badge/get-it-on.png"
alt="Get it on F-Droid"
height="55">](https://f-droid.org/packages/org.encointer.wallet/)

[<img src="https://play.google.com/intl/en_us/badges/images/generic/en-play-badge.png"
alt="Get it on Google Play"
height="55">](https://play.google.com/store/apps/details?id=org.encointer.wallet)

<a href="https://apps.apple.com/us/app/encointer-wallet/id1535471655?itsct=apps_box_badge&amp;itscg=30200" style="display: inline-block; overflow: hidden; border-radius: 13px; width: 150px; height: 83px;"><img src="https://tools.applemediaservices.com/api/badges/download-on-the-app-store/black/en-us?size=250x83&amp;releaseDate=1619049600&h=f616bcfbdbf4c04f0ca6524a2a683d4b" alt="Download on the App Store" style="border-radius: 13px; width: 250px; height: 83px;"></a>

[![Build](https://github.com/encointer/encointer-wallet-flutter/actions/workflows/android_build.yml/badge.svg)](https://github.com/encointer/encointer-wallet-flutter/actions/workflows/android_build.yml)
[![Android](https://github.com/encointer/encointer-wallet-flutter/actions/workflows/android_integration_test.yml/badge.svg)](https://github.com/encointer/encointer-wallet-flutter/actions/workflows/android_integration_test.yml)
[![IOS](https://github.com/encointer/encointer-wallet-flutter/actions/workflows/ios_integration_test.yaml/badge.svg)](https://github.com/encointer/encointer-wallet-flutter/actions/workflows/ios_integration_test.yaml)
[![Tests](https://github.com/encointer/encointer-wallet-flutter/actions/workflows/unit_tests.yaml/badge.svg)](https://github.com/encointer/encointer-wallet-flutter/actions/workflows/unit_tests.yaml)

## Overview

<img src="./fastlane/metadata/android/en-US/images/phoneScreenshots/1.png" width=300>
<img src="./fastlane/metadata/android/en-US/images/phoneScreenshots/2.png" width=300>
<img src="./fastlane/metadata/android/en-US/images/phoneScreenshots/3.png" width=300>
<img src="./fastlane/metadata/android/en-US/images/phoneScreenshots/4.png" width=300>
<img src="./fastlane/metadata/android/en-US/images/phoneScreenshots/5.png" width=300>

## Build Instructions

### Install Flutter

Built with [Flutter](https://flutter.dev/), you need to have `Flutter` dev tools
installed on your computer to compile the project. check [Flutter Documentation](https://flutter.dev/docs)
to learn how to install `Flutter` and initialize a Flutter App.

### Build js dependencies

Encointer wallet connects to the chains with [polkadot-js/api](https://polkadot.js.org/api/), running in a hidden webview.
You'll need `Nodejs` and `yarn` installed to build the bundled `main.js` file:

See the js_service_encointer [Readme](lib/js_service_encointer/README.md) for more documentation.

```shell
cd lib/js_service_encointer/
# install nodejs dependencies
yarn install
# build main.js
yarn run build
```

### Requirements
- Dart sdk: ">=2.12.0 <3.0.0"
- Flutter: "3.7.0"
- Android: minSdkVersion 17
- iOS: --ios-language swift, Xcode version >= 14.0.0

### Flutter wrapper
This project uses [flutter_wrapper](https://github.com/passsy/flutter_wrapper). Flutter wrapper is a tool that enables
having the same flutter version across multiple developers. It installs automatically the flutter version form the
pubspec.yml into the `.flutter` submodule.

Vscode automatically uses the `.flutter` as we have checked in the `.vscode` folder. For setting up the Android Studio,
please refer to the [documentation](https://github.com/passsy/flutter_wrapper#ide-setup).

Further info can be found in the [Medium Article](https://passsy.medium.com/flutter-wrapper-bind-your-project-to-an-explicit-flutter-release-4062cfe6dcaf).

**Note:** Git sometimes fails to update the flutter submodule when it has been changed on remote. This can be fixed with:
```shell
git submodule update --init
```

#### Linux and MacOs
Linux and MacOs users can simply replace all `flutter` CLI commands with `./flutterw` and it will just work.

#### Windows
In windows, this does unfortunately not work, but you can still set up your IDE to use the flutter version in from the `.flutter` git submodule. And you can do the following workaround:

```shell
// initialize .flutter git submodule (also works on windows)
./scripts/install_flutter_wrapper.sh

// refer to the flutter installation in your git submodule
./.flutter/bin/flutter doctor
```

### Run App

If you have an AVD or real device attached, you can do

```shell
./flutterw run --flavor dev
```

### Build APK

You may build the App with Flutter's [Deployment Documentation](https://flutter.dev/docs).

In order to build a fat APK, you can do
```shell
./flutterw build apk --flavor fdroid
```
and find the output in `build/app/outputs/apk/fdroid/release/app-fdroid-release.apk`

For the play store, an appbundle is preferred:
```shell
./flutterw build appbundle
```
and find the output in `build/app/outputs/bundle/release/app-release.aab`

#### Dev hints

### Flutter version
The following file contains the supported flutter version:

* [install_flutter_wrapper.sh](./scripts/install_flutter_wrapper.sh)

### Run tests

* run all tests from the command line:
```shell
./flutterw test
```
* exclude e2e-tests that need a running encointer node:
```shell
./flutterw test --exclude-tags encointer-node-e2e
```
* run e2e-tests that need a running encointer node:
```shell
./flutterw test --tags encointer-node-e2e
```

### Integration tests
* run all integration tests in `test_driver` directory:
```shell
./flutterw drive --target=test_driver/app.dart --flavor dev
```

### Automated screenshots
* Github actions is used to create automated screenshots for the specified devices there. However, running the integration tests locally will create screenshots for the currently running device.

#### Android Studio
To run the in Android Studio a build flavor must be specified. Go to Run/Debug configurations and add the build flavor `dev` in the appropriate field. Other available values are in the in the android/app/src/build.gradle file.

>Note that this project can be compiled both in Android and IOS,
>But there is an Issue running it on an IOS simulator, that the
>substrate `sr25519` keyPair is generated within an `WASM` virtual
>machine which is **not supported** by IOS simulators.

## Developer Remarks

### Windows Local Dev-setup
Setup to talk from emulators and/or cellphones with an encointer-node in the same local network. In windows 10/11 some
OS fixes are needed to get this working. I don't know if all of these steps are required.

1. Make PC discoverable in local network.
2. Enable inbound connections in windows firewall:
    * Search: `Windows Defender Firewall with Advanced Security`.
    * Inbound Rules > New Rule > Rule Type: Port > Tick TCP and specify the node's port, e.g. 9944.
    * Click next until finished and give the rule a distinct name, e.g. `Substrate Node`.
    * Double check if the rule is activated.
3. Find your local IP in the network and enter it in the encointer-wallet's [config](https://github.com/encointer/encointer-wallet-flutter/blob/1abb8a1f54ef551f19598fb809dfd6378cf1ac43/lib/config/consts.dart#L16-L23).
4. Restart the computer to be sure that the new configs are active.
5. Run the node with the flags:
```shell
./target/release/encointer-node-notee --dev --enable-offchain-indexing true --rpc-methods unsafe -lencointer=debug --ws-external --rpc-external
```

If the node is run in WSL2 (WSL1 should be fine), some extra steps are needed:

6. WSL2 does only expose ports on the local interface, which means they only listen to `127.0.0.1`, hence WSL2 can't be
   accessed on `hostname/-ip` on other devices in the LAN. This can be fixed with a simple tool [WSLHostPatcher](https://github.com/CzBiX/WSLHostPatcher).
    * Download the release.zip
    * Run `WSLHostPatcher.exe`
    * (Re-)start the service in WSL2. A firewall warning will pop-up the first time and access must be granted.

7. Now you should be able to access the node with both, the emulator and a cellphone in the local network.

**Note**: The `WSLHostPatcher.exe` must be run after every OS restart. You can automatically run it with the following steps:
* Download the release.zip, unzip it and put it into the ProgramFiles folder, giving it a more suitable name.
* Press `windows key + r` and type `shell:startup`.
* Add a shortcut to the `WSLHostPatcher.exe` in the windows startup folder.

### Fmt
`dartfmt` lacks config file support, which implies that customizations need to be done by users individually. The default
limit of 80 characters line length conflicts with the deeply nested structure of flutter's declarative code for designing
widgets. This causes many unwanted linebreaks that reduce the readability of flutter code. Hence, we increase the line
length of the code to 120.

* Settings > Dart > Line length 120.
* Autoformat on save: Settings > Languages and Frameworks > then tick: `Format code on save`, `Organize imports on save`.
* Format the whole codebase with:
```shell
./flutterw format . --line-length 120
```

#### Other fmt hints:

* Define formatting with the help of [trailing commas](https://docs.flutter.dev/development/tools/formatting#using-trailing-commas).
* [Dartfmt FAQ](https://github.com/dart-lang/dart_style/wiki/FAQ).


### Update generated files.
The flutter build-runner is used to generate repetitive boiler-plate code that is generated based on code annotations,
e.g. `@JsonSerializable` or the mobx annotations. Whenever annotations are added, changed or removed, the following
command must be run to update the `*.g` files:
```shell
./flutterw pub run build_runner build --delete-conflicting-outputs
```

## GitHub Actions Hints

### IOS
Sometimes after a Github Actions Runner update, the Xcode version is updated, which changes the available IOS runtimes.
This makes the IPad simulator creation fail because our runtime is no longer available. We can simply replace the
runtime with one of the available runtimes printed in the `Prepare environment for IOS` stage.

### App Release

#### Pre-release testing
There is quite some manual testing, which we can't automate currently. Before a release, an issue should be created
based on the `Release Testing Rococo` template. It will generate an issue with a task list of the features that need to
be tested. Two things need to be inserted into the template: 1. The commit that is tested. 2. The version that should be
released after testing.

#### Release flow
* VersionName should follow the semver policy.
* VersionCode should monotonically increase by 1 for every tagged build

##### AppCenter (Google Play Store & Apple AppStore)
The AppCenter automatically builds and deploys the HEAD of `beta`.

```shell 
  git checkout master
  git pull
  git tag v0.9.0
  git push origin v0.9.0
  git checkout beta
  git merge v0.9.0
  git push
```

##### F-droid
F-droid triggers builds based on tags. We will use a special tag format for the f-droid releases:, e.g. `vx.x.x-fdroid`.

Note: We have a different release branch for f-droid, as we had to use another, less performant scanner library to meet
FOSS constraints.

## Acknowledgements
This app has been built based on [polkawallet.io](https://polkawallet.io)
