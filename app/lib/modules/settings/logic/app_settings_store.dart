// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';

import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/modules/settings/settings.dart';

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

  @action
  void init() => _locale = _service.init();

  @action
  Future<void> setLocale(String languageCode) async {
    _locale = await _service.setLocale(languageCode);
  }

  String getName(String code) => _service.getName(code);

  @observable
  bool developerMode = false;

  @action
  void toggleDeveloperMode() => developerMode = !developerMode;
}
