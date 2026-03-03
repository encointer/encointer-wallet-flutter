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

[![Build](https://github.com/encointer/encointer-wallet-flutter/actions/workflows/android_build_and_deploy.yml/badge.svg)](https://github.com/encointer/encointer-wallet-flutter/actions/workflows/android_build_and_deploy.yml)
[![Build](https://github.com/encointer/encointer-wallet-flutter/actions/workflows/ios_build_and_deploy.yml/badge.svg)](https://github.com/encointer/encointer-wallet-flutter/actions/workflows/ios_build_and_deploy.yml)
[![Tests](https://github.com/encointer/encointer-wallet-flutter/actions/workflows/unit_tests.yml/badge.svg)](https://github.com/encointer/encointer-wallet-flutter/actions/workflows/unit_tests.yml)

## Overview

<p align="left">
<img src="./fastlane/metadata/android/en-US/images/phoneScreenshots/1.png" width="32%">
<img src="./fastlane/metadata/android/en-US/images/phoneScreenshots/2.png" width="32%">
<img src="./fastlane/metadata/android/en-US/images/phoneScreenshots/3.png" width="32%">
</p>

### Requirements
- Dart sdk: ">=3.6.0 <4.0.0"
- Flutter: "3.35.0"
- Android: minSdkVersion 24
- iOS: platform 15.5, Xcode version >= 15.2

## Quick Start

```shell
./scripts/install_flutter_wrapper.sh
.flutter/bin/dart pub get
.flutter/bin/dart run melos bootstrap
.flutter/bin/flutter run --flavor dev
```

## Documentation

| Guide | Contents |
|---|---|
| [Setup](docs/setup.md) | Ubuntu, Windows, Rust toolchain, Flutter wrapper |
| [Building & Running](docs/building.md) | Run app, env vars, build APK, Android Studio config |
| [Local Services](docs/local-services.md) | Encointer node, IPFS (kubo + auth gateway), Zombienet |
| [Testing](docs/testing.md) | Unit tests, integration tests, automated screenshots |
| [Development](docs/development.md) | Formatting, code generation |
| [Releasing](docs/releasing.md) | Release flow, CI hints, F-Droid |

## Acknowledgements

This app has been built based on [polkawallet.io](https://polkawallet.io)
