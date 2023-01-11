// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppSettings on _AppSettingsBase, Store {
  Computed<Locale>? _$localeComputed;

  @override
  Locale get locale =>
      (_$localeComputed ??= Computed<Locale>(() => super.locale, name: '_AppSettingsBase.locale')).value;
  Computed<bool>? _$sendToTrelloLogComputed;

  @override
  bool get sendToTrelloLog => (_$sendToTrelloLogComputed ??=
          Computed<bool>(() => super.sendToTrelloLog, name: '_AppSettingsBase.sendToTrelloLog'))
      .value;

  late final _$_localeAtom = Atom(name: '_AppSettingsBase._locale', context: context);

  @override
  Locale get _locale {
    _$_localeAtom.reportRead();
    return super._locale;
  }

  @override
  set _locale(Locale value) {
    _$_localeAtom.reportWrite(value, super._locale, () {
      super._locale = value;
    });
  }

  late final _$_sendToTrelloLogAtom = Atom(name: '_AppSettingsBase._sendToTrelloLog', context: context);

  @override
  bool get _sendToTrelloLog {
    _$_sendToTrelloLogAtom.reportRead();
    return super._sendToTrelloLog;
  }

  @override
  set _sendToTrelloLog(bool value) {
    _$_sendToTrelloLogAtom.reportWrite(value, super._sendToTrelloLog, () {
      super._sendToTrelloLog = value;
    });
  }

  late final _$setLocaleAsyncAction = AsyncAction('_AppSettingsBase.setLocale', context: context);

  @override
  Future<void> setLocale(int index) {
    return _$setLocaleAsyncAction.run(() => super.setLocale(index));
  }

  late final _$setSendToTrelloLogAsyncAction = AsyncAction('_AppSettingsBase.setSendToTrelloLog', context: context);

  @override
  Future<void> setSendToTrelloLog(bool value) {
    return _$setSendToTrelloLogAsyncAction.run(() => super.setSendToTrelloLog(value));
  }

  late final _$_AppSettingsBaseActionController = ActionController(name: '_AppSettingsBase', context: context);

  @override
  void init() {
    final _$actionInfo = _$_AppSettingsBaseActionController.startAction(name: '_AppSettingsBase.init');
    try {
      return super.init();
    } finally {
      _$_AppSettingsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
locale: ${locale},
sendToTrelloLog: ${sendToTrelloLog}
    ''';
  }
}
