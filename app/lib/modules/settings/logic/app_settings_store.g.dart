// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppSettings on _AppSettingsBase, Store {
  Computed<CustomTheme>? _$themeComputed;

  @override
  CustomTheme get theme =>
      (_$themeComputed ??= Computed<CustomTheme>(() => super.theme, name: '_AppSettingsBase.theme')).value;

  late final _$localeAtom = Atom(name: '_AppSettingsBase.locale', context: context);

  @override
  Locale get locale {
    _$localeAtom.reportRead();
    return super.locale;
  }

  @override
  set locale(Locale value) {
    _$localeAtom.reportWrite(value, super.locale, () {
      super.locale = value;
    });
  }

  late final _$isBiometricAuthenticationEnabledAtom =
      Atom(name: '_AppSettingsBase.isBiometricAuthenticationEnabled', context: context);

  @override
  bool get isBiometricAuthenticationEnabled {
    _$isBiometricAuthenticationEnabledAtom.reportRead();
    return super.isBiometricAuthenticationEnabled;
  }

  @override
  set isBiometricAuthenticationEnabled(bool value) {
    _$isBiometricAuthenticationEnabledAtom.reportWrite(value, super.isBiometricAuthenticationEnabled, () {
      super.isBiometricAuthenticationEnabled = value;
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

  late final _$colorSchemeAtom = Atom(name: '_AppSettingsBase.colorScheme', context: context);

  @override
  ColorScheme get colorScheme {
    _$colorSchemeAtom.reportRead();
    return super.colorScheme;
  }

  @override
  set colorScheme(ColorScheme value) {
    _$colorSchemeAtom.reportWrite(value, super.colorScheme, () {
      super.colorScheme = value;
    });
  }

  late final _$setLocaleAsyncAction = AsyncAction('_AppSettingsBase.setLocale', context: context);

  @override
  Future<void> setLocale(String languageCode) {
    return _$setLocaleAsyncAction.run(() => super.setLocale(languageCode));
  }

  late final _$setIsBiometricAuthenticationEnabledAsyncAction =
      AsyncAction('_AppSettingsBase.setIsBiometricAuthenticationEnabled', context: context);

  @override
  Future<void> setIsBiometricAuthenticationEnabled(bool value) {
    return _$setIsBiometricAuthenticationEnabledAsyncAction.run(() => super.setIsBiometricAuthenticationEnabled(value));
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
  bool getIsBiometricAuthenticationEnabled() {
    final _$actionInfo =
        _$_AppSettingsBaseActionController.startAction(name: '_AppSettingsBase.getIsBiometricAuthenticationEnabled');
    try {
      return super.getIsBiometricAuthenticationEnabled();
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
  void changeTheme(String? cid) {
    final _$actionInfo = _$_AppSettingsBaseActionController.startAction(name: '_AppSettingsBase.changeTheme');
    try {
      return super.changeTheme(cid);
    } finally {
      _$_AppSettingsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
locale: ${locale},
isBiometricAuthenticationEnabled: ${isBiometricAuthenticationEnabled},
developerMode: ${developerMode},
colorScheme: ${colorScheme},
theme: ${theme}
    ''';
  }
}
