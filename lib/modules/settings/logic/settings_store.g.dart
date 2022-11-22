// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsStore2 on _SettingsStore2Base, Store {
  Computed<Locale>? _$localeComputed;

  @override
  Locale get locale =>
      (_$localeComputed ??= Computed<Locale>(() => super.locale, name: '_SettingsStore2Base.locale')).value;

  late final _$_localeAtom = Atom(name: '_SettingsStore2Base._locale', context: context);

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

  late final _$setLocaleAsyncAction = AsyncAction('_SettingsStore2Base.setLocale', context: context);

  @override
  Future<void> setLocale(int index) {
    return _$setLocaleAsyncAction.run(() => super.setLocale(index));
  }

  late final _$_SettingsStore2BaseActionController = ActionController(name: '_SettingsStore2Base', context: context);

  @override
  void init() {
    final _$actionInfo = _$_SettingsStore2BaseActionController.startAction(name: '_SettingsStore2Base.init');
    try {
      return super.init();
    } finally {
      _$_SettingsStore2BaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
locale: ${locale}
    ''';
  }
}
