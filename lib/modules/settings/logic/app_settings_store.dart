// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';

import 'package:encointer_wallet/modules/settings/settings.dart';
import 'package:encointer_wallet/service_locator/service_locator.dart';
import 'package:mobx/mobx.dart';

part 'app_settings_store.g.dart';

class AppSettings = _AppSettingsBase with _$AppSettings;

abstract class _AppSettingsBase with Store {
  _AppSettingsBase() : _service = sl();

  final LangService _service;

  static const enLocale = Locale('en', '');
  static const deLocale = Locale('de', '');
  static const frLocale = Locale('fr', '');
  static const ruLocale = Locale('ru', '');

  @observable
  Locale _locale = const Locale('en');

  final locales = const <Locale>[
    enLocale,
    deLocale,
    frLocale,
    ruLocale,
  ];

  @computed
  Locale get locale => _locale;

  @action
  Future<void> setLocale(int index) async {
    _locale = await _service.setLocale(index, locales);
  }

  String getName(String code) => _service.getName(code);
}
