// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';

import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/modules/modules.dart';

part 'app_settings_store.g.dart';

class AppSettings = _AppSettingsBase with _$AppSettings;

abstract class _AppSettingsBase with Store {
  _AppSettingsBase(this.langService, this.sendErrorMessagesService);

  final LangService langService;
  final SendErrorMessagesService sendErrorMessagesService;

  @observable
  Locale _locale = const Locale('en');

  @observable
  bool _shouldSendToTrello = false;

  final locales = const <Locale>[
    Locale('en', ''),
    Locale('de', ''),
    Locale('fr', ''),
    Locale('ru', ''),
  ];

  @computed
  Locale get locale => _locale;

  @computed
  bool get shouldSendToTrello => _shouldSendToTrello;

  @action
  void init() {
    _locale = langService.init();
    _shouldSendToTrello = sendErrorMessagesService.getShouldSendToTrello();
  }

  @action
  Future<void> setLocale(int index) async {
    _locale = await langService.setLocale(index, locales);
  }

  @action
  Future<void> setShouldSendToTrello(bool value) async {
    _shouldSendToTrello = value;
    await sendErrorMessagesService.setShouldSendToTrello(value);
  }

  Future<void> sendMessageToTrello(
    String message, [
    String? description,
    StackTrace? stackTrace,
  ]) async {
    if (_shouldSendToTrello) {
      await sendErrorMessagesService.sendMessageToTrello(message, description, stackTrace);
    }
  }

  String getName(String code) => langService.getName(code);
}
