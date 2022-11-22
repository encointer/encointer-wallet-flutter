// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';

import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/modules/settings/settings.dart';

part 'settings_store.g.dart';

class SettingsStore2 = _SettingsStore2Base with _$SettingsStore2;

abstract class _SettingsStore2Base with Store {
  _SettingsStore2Base(this._service);

  final LangService _service;

  @observable
  Locale _locale = const Locale('en');

  final locales = const <Locale>[
    Locale('en', ''),
    Locale('de', ''),
    // Locale('fr', ''),
    Locale('ru', ''),
  ];

  @computed
  Locale get locale => _locale;

  @action
  void init() => _locale = _service.init();

  @action
  Future<void> setLocale(int index) async {
    _locale = await _service.setLocale(index, locales);
  }

  String getName(String code) => _service.getName(code);
}
