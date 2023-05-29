import 'dart:ui';

import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/modules/settings/settings.dart';

part 'app_settings_store.g.dart';

// ignore: library_private_types_in_public_api
class AppSettings = _AppSettingsBase with _$AppSettings;

abstract class _AppSettingsBase with Store {
  _AppSettingsBase(this._service);

  final AppService _service;

  @observable
  Locale _locale = const Locale('en');

  @computed
  Locale get locale => _locale;

  @observable
  bool isBiometricAuthenticationEnabled = false;

  @observable
  bool developerMode = false;

  final locales = const <Locale>[
    Locale('en', ''),
    Locale('de', ''),
    Locale('fr', ''),
    Locale('ru', ''),
  ];

  @action
  void init() => _locale = _service.init();

  @action
  bool getIsBiometricAuthenticationEnabled() {
    final value = _service.getIsBiometricAuthenticationEnabled();
    if (value != null) isBiometricAuthenticationEnabled = value;
    return isBiometricAuthenticationEnabled;
  }

  @action
  Future<void> setLocale(String languageCode) async {
    _locale = await _service.setLocale(languageCode);
  }

  @action
  Future<void> setIsBiometricAuthenticationEnabled(bool value) async {
    isBiometricAuthenticationEnabled = value;
    await _service.setIsBiometricAuthenticationEnabled(value);
  }

  String getLocaleName(String code) => _service.getLocaleName(code);

  @action
  void toggleDeveloperMode() => developerMode = !developerMode;
}
