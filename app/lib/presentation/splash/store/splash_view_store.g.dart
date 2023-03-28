// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_view_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SplashViewStore on _SplashViewStore, Store {
  Computed<AppStore>? _$appStoreComputed;

  @override
  AppStore get appStore =>
      (_$appStoreComputed ??= Computed<AppStore>(() => super.appStore, name: '_SplashViewStore.appStore')).value;

  late final _$initAsyncAction = AsyncAction('_SplashViewStore.init', context: context);

  @override
  Future<void> init(BuildContext context) {
    return _$initAsyncAction.run(() => super.init(context));
  }

  late final _$_initWebApiAsyncAction = AsyncAction('_SplashViewStore._initWebApi', context: context);

  @override
  Future<void> _initWebApi(BuildContext context) {
    return _$_initWebApiAsyncAction.run(() => super._initWebApi(context));
  }

  late final _$_setupUpdateReactionAsyncAction = AsyncAction('_SplashViewStore._setupUpdateReaction', context: context);

  @override
  Future<void> _setupUpdateReaction() {
    return _$_setupUpdateReactionAsyncAction.run(() => super._setupUpdateReaction());
  }

  @override
  String toString() {
    return '''
appStore: ${appStore}
    ''';
  }
}
