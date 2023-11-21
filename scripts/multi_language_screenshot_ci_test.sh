#!/bin/bash
set -euxo pipefail

.flutter/bin/dart run melos integration-scan-test-ios
.flutter/bin/dart run melos integration-app-test-ios-screenshot-multi-language
