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
  Computed<CustomTheme>? _$themeComputed;

  @override
  CustomTheme get theme =>
      (_$themeComputed ??= Computed<CustomTheme>(() => super.theme, name: '_AppSettingsBase.theme')).value;

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

  late final _$primarySwatchAtom = Atom(name: '_AppSettingsBase.primarySwatch', context: context);

  @override
  MaterialColor get primarySwatch {
    _$primarySwatchAtom.reportRead();
    return super.primarySwatch;
  }

  @override
  set primarySwatch(MaterialColor value) {
    _$primarySwatchAtom.reportWrite(value, super.primarySwatch, () {
      super.primarySwatch = value;
    });
  }

  late final _$developerModeAtom = Atom(name: '_AppSettingsBase.developerMode', context: context);

  @override
  bool get developerMode {
    _$developerModeAtom.reportRead();
    return super.developerMode;
  }

  @override
  set developerMode(bool value) {
    _$developerModeAtom.reportWrite(value, super.developerMode, () {
      super.developerMode = value;
    });
  }

  late final _$setLocaleAsyncAction = AsyncAction('_AppSettingsBase.setLocale', context: context);

  @override
  Future<void> setLocale(int index) {
    return _$setLocaleAsyncAction.run(() => super.setLocale(index));
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
  void toggleDeveloperMode() {
    final _$actionInfo = _$_AppSettingsBaseActionController.startAction(name: '_AppSettingsBase.toggleDeveloperMode');
    try {
      return super.toggleDeveloperMode();
    } finally {
      _$_AppSettingsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
primarySwatch: ${primarySwatch},
developerMode: ${developerMode},
locale: ${locale},
theme: ${theme}
    ''';
  }
}
