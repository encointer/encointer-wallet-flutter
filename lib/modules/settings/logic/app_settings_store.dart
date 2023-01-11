// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';

import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/modules/modules.dart';

part 'app_settings_store.g.dart';

class AppSettings = _AppSettingsBase with _$AppSettings;

abstract class _AppSettingsBase with Store {
  _AppSettingsBase(this.langService, this.logService);

  final LangService langService;
  final LogService logService;

  @observable
  Locale _locale = const Locale('en');

  @observable
  bool _sendToTrelloLog = true;

  final locales = const <Locale>[
    Locale('en', ''),
    Locale('de', ''),
    Locale('fr', ''),
    Locale('ru', ''),
  ];

  @computed
  Locale get locale => _locale;

  @computed
  bool get sendToTrelloLog => _sendToTrelloLog;

  @action
  void init() {
    _locale = langService.init();
    _sendToTrelloLog = logService.getSendToTrello();
  }

  @action
  Future<void> setLocale(int index) async {
    _locale = await langService.setLocale(index, locales);
  }

  @action
  Future<void> setSendToTrelloLog(bool value) async {
    _sendToTrelloLog = value;
    await logService.setSendToTrello(value);
  }

  Future<void> sendToTrello(
    String message, [
    String? description,
    StackTrace? stackTrace,
  ]) async {
    if (_sendToTrelloLog) await logService.sendToTrelloLog(message, description, stackTrace);
  }

  String getName(String code) => langService.getName(code);
}
