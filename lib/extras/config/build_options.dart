import 'dart:io';

import 'package:encointer_wallet/common/constants/consts.dart';
import 'package:encointer_wallet/store/settings.dart';
import 'package:upgrader/upgrader.dart';

/// Whether we are in the process of running tests
bool get flutterTestRunning => Platform.environment.containsKey('FLUTTER_TEST');

/// Environment variants
enum Environment {
  debug,
  dev,
  beta,
  apk,
  prod,
  test,
  integrationTest,
}

/// Set the build variant
void setEnvironment(
  Environment build, {
  AppcastConfiguration? appCast,
}) {
  switch (build) {
    case Environment.debug:
      buildConfig = BuildConfig.debug;
      break;
    case Environment.dev:
      buildConfig = BuildConfig.dev;
      break;
    case Environment.beta:
      buildConfig = BuildConfig.beta;
      break;
    case Environment.apk:
      buildConfig = BuildConfig.apk;
      break;
    case Environment.prod:
      buildConfig = BuildConfig.prod;
      break;
    case Environment.test:
      buildConfig = BuildConfig.unitTest;

      break;
    case Environment.integrationTest:
      buildConfig = BuildConfig.integrationTest;
      break;
  }
}

/// Current build configuration
BuildConfig? _buildConfig;

/// Таким образом защищаемся от смены конфига
set buildConfig(BuildConfig buildConfig) {
  if (_buildConfig != null) return;
  _buildConfig = buildConfig;
}

BuildConfig get buildConfig => _buildConfig!;

/// Configuration of build options, here can be (colors, url, etc.)
class BuildConfig {
  const BuildConfig({
    this.mockSubstrateApi = false,
    this.isTestMode = false,
    this.appCast,
    required this.endpoint,
  });

  /// [mockSubstrateApi] indicates whether the app uses a mocked api `MockApi` or the real api `Api`.
  final bool mockSubstrateApi;

  /// [isTestMode] indicates whether the app is running in test mode.
  final bool isTestMode;

  /// [appCast] is used to provide fake information about the app version for `Upgrader` package.
  final AppcastConfiguration? appCast;

  final EndpointData endpoint;

  /// If [AppcastConfiguration] variable is not null, the app is running real integration test.
  /// If [isIntegrationTest] value is `true`, test will close upgrader alert and won't ask notifications permission.
  bool get isIntegrationTest => appCast != null;

  static BuildConfig dev = BuildConfig(
    isTestMode: true,
    endpoint: networkEndpointEncointerGesellDev,
  );

  static BuildConfig debug = BuildConfig(endpoint: networkEndpointEncointerMainnet);

  static BuildConfig beta = BuildConfig(endpoint: networkEndpointEncointerMainnet);

  static BuildConfig apk = BuildConfig(endpoint: networkEndpointEncointerMainnet);

  static BuildConfig prod = BuildConfig(endpoint: networkEndpointEncointerMainnet);

  static BuildConfig unitTest = BuildConfig(
    isTestMode: true,
    mockSubstrateApi: true,
    endpoint: EndpointData(),
  );

  static BuildConfig integrationTest = BuildConfig(
    appCast: getAppCast(),
    endpoint: EndpointData(),
  );
}

AppcastConfiguration getAppCast() {
  const appcastURL = 'https://encointer.github.io/feed/app_cast/testappcast.xml';
  return AppcastConfiguration(url: appcastURL, supportedOS: ['android']);
}
