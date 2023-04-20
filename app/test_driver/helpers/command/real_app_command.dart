import 'package:encointer_wallet/modules/settings/logic/app_settings_store.dart';

class RealAppTestCommand {
  static const String getPlatform = 'getPlatform';
  static const String shouldTakeScreenshot = 'shouldTakeScreenshot';
  static const String localeEn = 'local-en';
  static const String localeDe = 'local-de';
  static const String localeFr = 'local-fr';
  static const String localeRu = 'local-ru';
  static const String devModeOn = 'dev-mode-on';
  static const String devModeOff = 'dev-mode-off';

  static Future<String> changeLocaleEn(AppSettings appSettings, String languageCode) async {
    if (appSettings.locale.languageCode != languageCode) {
      await appSettings.setLocale(languageCode);
    }
    return appSettings.locale.languageCode;
  }
}
