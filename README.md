# Encointer Wallet

Encointer wallet and client for mobile phones

<p align="left">
  <a href="https://f-droid.org/packages/org.encointer.wallet/">
    <img src="https://fdroid.gitlab.io/artwork/badge/get-it-on.png" alt="Get it on F-Droid" height="55">
  </a>
  <a href="https://play.google.com/store/apps/details?id=org.encointer.wallet">
    <img src="https://play.google.com/intl/en_us/badges/images/generic/en-play-badge.png" alt="Get it on Google Play" height="55">
  </a>
  <a href="https://apps.apple.com/us/app/encointer-wallet/id1535471655?itsct=apps_box_badge&itscg=30200">
    <img src="https://tools.applemediaservices.com/api/badges/download-on-the-app-store/black/en-us?size=250x83&releaseDate=1619049600&h=f616bcfbdbf4c04f0ca6524a2a683d4b" alt="Download on the App Store" height="55">
  </a>
</p>

[![Build](https://github.com/encointer/encointer-wallet-flutter/actions/workflows/android_build.yml/badge.svg)](https://github.com/encointer/encointer-wallet-flutter/actions/workflows/android_build.yml)
[![Android](https://github.com/encointer/encointer-wallet-flutter/actions/workflows/android_integration_test.yml/badge.svg)](https://github.com/encointer/encointer-wallet-flutter/actions/workflows/android_integration_test.yml)
[![IOS](https://github.com/encointer/encointer-wallet-flutter/actions/workflows/ios_integration_test.yaml/badge.svg)](https://github.com/encointer/encointer-wallet-flutter/actions/workflows/ios_integration_test.yaml)
[![Tests](https://github.com/encointer/encointer-wallet-flutter/actions/workflows/unit_tests.yaml/badge.svg)](https://github.com/encointer/encointer-wallet-flutter/actions/workflows/unit_tests.yaml)

## Overview

<p align="left">
<img src="./fastlane/metadata/android/en-US/images/phoneScreenshots/1.png" width="32%">
<img src="./fastlane/metadata/android/en-US/images/phoneScreenshots/2.png" width="32%">
<img src="./fastlane/metadata/android/en-US/images/phoneScreenshots/3.png" width="32%">
</p>

### Requirements
- Dart sdk: ">=3.2.0 <4.0.0"
- flutter: "3.27.1"
- Android: minSdkVersion 21
- iOS: --ios-language swift, Xcode version >= 15.2

# Build Instructions

## Setup

### Ubuntu 22.04
Install Android Studio from snap and set it up as follows:
1. Tools > SDK manager > Install SDK Android 8.0 Oreo (not sure if version matters much)
2. ... Tools > Install SDK commandline tools
3. Settings > Plugins > Install Flutter

then:

```
sudo apt install cmake ninja-build libgtk-3-dev npm build-essentials
./scripts/install_flutter_wrapper.sh
# install project deps (i.e., melos)
.flutter/bin/dart pub get
.flutter/bin/dart melos bootstrap
```

In studio: under run configurations, add build flavor `dev`

Now: run!

### Windows
Essentially only a project wide flutter installation is needed. A simple trick to install flutter wrapper like above is
to open a Git Bash shell on windows to run the `./scripts/install_flutter_wrapper.sh`. All `./.flutter\bin\dart` 
commands work from a windows terminal, so the rest of the installation steps are the same.

### Additional Info

#### Flutter wrapper and the .flutter git submodule

This project uses [flutter_wrapper](https://github.com/passsy/flutter_wrapper). Flutter wrapper is a tool that enables
having the same flutter version across multiple developers. It installs automatically the flutter version form the
pubspec.yml into the `.flutter` submodule.

Vscode automatically uses the `.flutter` as we have checked in the `.vscode` folder. For setting up the Android Studio,
please refer to the [documentation](https://github.com/passsy/flutter_wrapper#ide-setup).

#### Linux and MacOs
Linux and MacOs users can simply replace all `flutter` CLI commands with `./flutterw` and it will just work.

#### Windows
In windows, this does unfortunately not work, but `.flutter` you can refer to the executables directly with: 
`./flutter/bin/flutter` and `./flutter/bin/dart`.

**Note:** On windows, Git fails to update the flutter submodule when it has been changed on remote. This can be fixed with:
```shell
git submodule update --init
```

### Run App
Run Android platform
```shell
./.flutter\bin\dart melos run run-android
```
Run IOS platform
```shell
./.flutter\bin\dart run melos run-ios
```
If you have an AVD or real device attached, you can do
```shell
./.flutter\bin\flutter run --flavor dev
```
### Build APK

You may build the App with Flutter's [Deployment Documentation](https://flutter.dev/docs).

In order to build a fat APK, you can do 
```shell
.\.flutter\bin\dart run melos build-apk-fdroid
```
and find the output in `build/app/outputs/apk/fdroid/release/app-fdroid-release.apk`

For the play store, an appbundle is preferred:
```shell
.\.flutter\bin\dart run melos build-appbundle
```
and find the output in `build/app/outputs/bundle/release/app-release.aab`

## Dev hints

### Flutter version
The following file contains the supported flutter version:

* [install_flutter_wrapper.sh](./scripts/install_flutter_wrapper.sh)

### Run tests

* run all tests from the command line:`./flutterw test`
* exclude e2e-tests that need a running encointer node:
```shell
.\.flutter\bin\dart run melos unit-test-app-exclude-e2e
```
* run e2e-tests that need a running encointer node:
```shell
.\.flutter\bin\dart run melos unit-test-app-with-encointer-node-e2e
```

### Integration tests
* run all integration tests in `test_driver` directory:
Integration test app.dart for Android system
```shell
.\.flutter\bin\dart run melos integration-app-test-android
```
Integration test app.dart for IOS system
```shell
.\.flutter\bin\dart run melos integration-app-test-ios
```

## Run Against Local Zombienet
Make sure that the parachain is compile with a runtime from this branch: https://github.com/encointer/runtimes/tree/cl/fast-encointer-runtime

Then choose the Zombienet in the network selection. The rest should work as usual.

### Automated screenshots
* Github actions is used to create automated screenshots for the specified devices there. However, running the integration tests locally will create screenshots for the currently running device.

#### Android Studio
To run the in Android Studio a build flavor must be specified. Go to Run/Debug configurations and add the build flavor `dev` in the appropriate field. Other available values are in the in the android/app/src/build.gradle file.

## Developer Remarks

### Fmt
`dartfmt` lacks config file support, which implies that customizations need to be done by users individually. The default
limit of 80 characters line length conflicts with the deeply nested structure of flutter's declarative code for designing
widgets. This causes many unwanted linebreaks that reduce the readability of flutter code. Hence, we increase the line
length of the code to 120.

* Settings > Dart > Line length 120.
* Autoformat on save: Settings > Languages and Frameworks > then tick: `Format code on save`, `Organize imports on save`.
* Format the whole codebase with: 
format all Dart code
```shell
.\.flutter\bin\dart run melos format
```

#### Other fmt hints:

* Define formatting with the help of [trailing commas](https://docs.flutter.dev/development/tools/formatting#using-trailing-commas).
* [Dartfmt FAQ](https://github.com/dart-lang/dart_style/wiki/FAQ).


### Update generated files.
The flutter build-runner is used to generate repetitive boiler-plate code that is generated based on code annotations,
e.g. `@JsonSerializable` or the mobx annotations. Whenever annotations are added, changed or removed, the following 
command must be run to update the `*.g` files.

```shell
.\.flutter\bin\dart run melos run-build-runner
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
