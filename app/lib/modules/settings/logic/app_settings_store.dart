// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/modules/settings/settings.dart';
import 'package:encointer_wallet/config/prod_community.dart';
import 'package:encointer_wallet/theme/theme.dart';

part 'app_settings_store.g.dart';

class AppSettings = _AppSettingsBase with _$AppSettings;

abstract class _AppSettingsBase with Store {
  _AppSettingsBase(this._service);

  final AppService _service;

  @observable
  Locale locale = const Locale('en');

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

  @observable
  ColorScheme colorScheme = AppColors.leu;

  @computed
  CustomTheme get theme => CustomTheme(colorScheme);

  @action
  void init() => locale = _service.init();

  @action
  bool getIsBiometricAuthenticationEnabled() {
    final value = _service.getIsBiometricAuthenticationEnabled();
    if (value != null) isBiometricAuthenticationEnabled = value;
    return isBiometricAuthenticationEnabled;
  }

  @action
  Future<void> setLocale(String languageCode) async {
    locale = await _service.setLocale(languageCode);
  }

  @action
  Future<void> setIsBiometricAuthenticationEnabled(bool value) async {
    isBiometricAuthenticationEnabled = value;
    await _service.setIsBiometricAuthenticationEnabled(value);
  }

  String getLocaleName(String code) => _service.getLocaleName(code);

  @action
  void toggleDeveloperMode() => developerMode = !developerMode;

  /// TODO(edliiar): Activate GBD colors when received from designer.
  @action
  void changeTheme(String? cid) {
    final community = Community.fromCid(cid);
    if (colorScheme != community.colorScheme) colorScheme = community.colorScheme;
  }
}
