// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/modules/settings/settings.dart';
import 'package:encointer_wallet/theme/theme.dart';

part 'app_settings_store.g.dart';

class AppSettings = _AppSettingsBase with _$AppSettings;

abstract class _AppSettingsBase with Store {
  _AppSettingsBase(this._service);

  final LangService _service;

  @observable
  Locale _locale = const Locale('en');

  final locales = const <Locale>[
    Locale('en', ''),
    Locale('de', ''),
    Locale('fr', ''),
    Locale('ru', ''),
  ];

  @computed
  Locale get locale => _locale;

  @observable
  ColorScheme colorScheme = AppColors.leu;

  @computed
  CustomTheme get theme => CustomTheme(colorScheme);

  @action
  void init() => _locale = _service.init();

  @action
  Future<void> setLocale(int index) async {
    _locale = await _service.setLocale(index, locales);
  }

  String getName(String code) => _service.getName(code);

  @observable
  bool developerMode = false;

  @action
  void toggleDeveloperMode() => developerMode = !developerMode;

  // When we get the colors for greenbay dollars from desiner, we can activate it.
  // @action
  void changeTheme(String? cid) {
    // final community = Community.fromCid(cid);
    // if (colorScheme != community.colorScheme) colorScheme = community.colorScheme;
  }
}
