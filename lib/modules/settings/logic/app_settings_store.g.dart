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
  Computed<bool>? _$shouldSendToTrelloComputed;

  @override
  bool get shouldSendToTrello => (_$shouldSendToTrelloComputed ??=
          Computed<bool>(() => super.shouldSendToTrello, name: '_AppSettingsBase.shouldSendToTrello'))
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

  late final _$_shouldSendToTrelloAtom = Atom(name: '_AppSettingsBase._shouldSendToTrello', context: context);

  @override
  bool get _shouldSendToTrello {
    _$_shouldSendToTrelloAtom.reportRead();
    return super._shouldSendToTrello;
  }

  @override
  set _shouldSendToTrello(bool value) {
    _$_shouldSendToTrelloAtom.reportWrite(value, super._shouldSendToTrello, () {
      super._shouldSendToTrello = value;
    });
  }

  late final _$setLocaleAsyncAction = AsyncAction('_AppSettingsBase.setLocale', context: context);

  @override
  Future<void> setLocale(int index) {
    return _$setLocaleAsyncAction.run(() => super.setLocale(index));
  }

  late final _$setShouldSendToTrelloAsyncAction =
      AsyncAction('_AppSettingsBase.setShouldSendToTrello', context: context);

  @override
  Future<void> setShouldSendToTrello(bool value) {
    return _$setShouldSendToTrelloAsyncAction.run(() => super.setShouldSendToTrello(value));
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
shouldSendToTrello: ${shouldSendToTrello}
    ''';
  }
}
