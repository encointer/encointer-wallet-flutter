# Testing

## Flutter version

The following file contains the supported flutter version:

* [install_flutter_wrapper.sh](../scripts/install_flutter_wrapper.sh)

## Run tests

* run all tests from the command line: `.flutter/bin/dart run melos unit-test-app-exclude-e2e`
* exclude e2e-tests that need a running encointer node:
```shell
.flutter/bin/dart run melos unit-test-app-exclude-e2e
```
* run e2e-tests that need a running encointer node:
```shell
.flutter/bin/dart run melos unit-test-app-with-encointer-node-e2e
```

## Integration tests

Run all integration tests in `test_driver` directory:

Integration test app.dart for Android system
```shell
.flutter/bin/dart run melos integration-app-test-android
```
Integration test app.dart for iOS system
```shell
.flutter/bin/dart run melos integration-app-test-ios
```

### Automated screenshots

Github actions is used to create automated screenshots for the specified devices there. However, running the integration tests locally will create screenshots for the currently running device.
