import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/modules/settings/settings.dart';
import 'package:encointer_wallet/config/prod_community.dart';
import 'package:encointer_wallet/theme/theme.dart';

part 'app_settings_store.g.dart';

// ignore: library_private_types_in_public_api
class AppSettings = _AppSettingsBase with _$AppSettings;

abstract class _AppSettingsBase with Store {
  _AppSettingsBase(this._service);

  final AppService _service;

  @observable
  Locale locale = const Locale('en');

  @observable
  bool developerMode = false;

  @observable
  bool _isIntegrationTest = false;

  set isIntegrationTest(bool v) => _isIntegrationTest = v;

  @computed
  bool get isIntegrationTest => _isIntegrationTest;

  @observable
  ColorScheme colorScheme = AppColors.leu;

  @computed
  CustomTheme get theme => CustomTheme(colorScheme);

  @action
  void init() => locale = _service.getLocale;

  @action
  Future<void> setLocale(String languageCode) async {
    locale = await _service.setLocale(languageCode);
  }

  @action
  void toggleDeveloperMode() => developerMode = !developerMode;

  @action
  void changeTheme(String? cid) {
    final community = CommunityConfig.fromCid(cid);
    if (colorScheme != community.colorScheme) colorScheme = community.colorScheme;
  }
}
