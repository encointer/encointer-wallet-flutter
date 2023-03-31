// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_language_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppLanguageStore on _AppLanguageStoreBase, Store {
  Computed<Locale>? _$localeComputed;

  @override
  Locale get locale =>
      (_$localeComputed ??= Computed<Locale>(() => super.locale, name: '_AppLanguageStoreBase.locale')).value;

  late final _$_localeAtom = Atom(name: '_AppLanguageStoreBase._locale', context: context);

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

  late final _$_initAsyncAction = AsyncAction('_AppLanguageStoreBase._init', context: context);

  @override
  Future<void> _init() {
    return _$_initAsyncAction.run(() => super._init());
  }

  late final _$setLocaleAsyncAction = AsyncAction('_AppLanguageStoreBase.setLocale', context: context);

  @override
  Future<void> setLocale(int index) {
    return _$setLocaleAsyncAction.run(() => super.setLocale(index));
  }

  @override
  String toString() {
    return '''
locale: ${locale}
    ''';
  }
}