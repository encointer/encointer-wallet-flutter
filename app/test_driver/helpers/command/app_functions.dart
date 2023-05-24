part of '../../app.dart';

Future<String> changeLocale(AppSettings appSettings, String languageCode) async {
  if (appSettings.locale.languageCode != languageCode) {
    await appSettings.setLocale(languageCode);
  }
  return appSettings.locale.languageCode;
}

String toggleDeveloperMode(AppSettings appSettings, bool devMode) {
  if (appSettings.developerMode != devMode) appSettings.toggleDeveloperMode();
  return 'dev mode-${appSettings.developerMode}';
}
