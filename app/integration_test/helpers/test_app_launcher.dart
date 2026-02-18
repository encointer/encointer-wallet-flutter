import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';

import 'package:encointer_wallet/main.dart' as app;
import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/modules/modules.dart';

class TestAppLauncher {
  late final AppSettings appSettings;
  late final IntegrationTestWidgetsFlutterBinding binding;
  List<String> locales = [];

  Future<void> launch(WidgetTester tester) async {
    binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    const localeEnv = String.fromEnvironment('locales');
    locales = localeEnv.isEmpty ? [] : localeEnv.split(',');

    const appcastURL = 'https://encointer.github.io/feed/app_cast/testappcast.xml';
    const appConfig = AppConfig(appCastUrl: appcastURL, isIntegrationTest: true);

    await Upgrader.clearSavedSettings();
    final pref = await SharedPreferences.getInstance();
    final appService = AppService(pref);
    appSettings = AppSettings(appService)..isIntegrationTest = true;

    await app.main(appConfig: appConfig, settings: appSettings);
    await tester.pumpAndSettle();
  }
}
