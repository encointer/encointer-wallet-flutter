// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewStore on _HomeViewStoreBase, Store {
  Computed<AppStore>? _$appStoreComputed;

  @override
  AppStore get appStore =>
      (_$appStoreComputed ??= Computed<AppStore>(() => super.appStore,
              name: '_HomeViewStoreBase.appStore'))
          .value;

  late final _$initAsyncAction =
      AsyncAction('_HomeViewStoreBase.init', context: context);

  @override
  Future<void> init(BuildContext context) {
    return _$initAsyncAction.run(() => super.init(context));
  }

  late final _$initDeepLinksAsyncAction =
      AsyncAction('_HomeViewStoreBase.initDeepLinks', context: context);

  @override
  Future<void> initDeepLinks(BuildContext context) {
    return _$initDeepLinksAsyncAction.run(() => super.initDeepLinks(context));
  }

  late final _$fetchMessagesAndScheduleNotificationsAsyncAction = AsyncAction(
      '_HomeViewStoreBase.fetchMessagesAndScheduleNotifications',
      context: context);

  @override
  Future<void> fetchMessagesAndScheduleNotifications(BuildContext context) {
    return _$fetchMessagesAndScheduleNotificationsAsyncAction
        .run(() => super.fetchMessagesAndScheduleNotifications(context));
  }

  late final _$runCeremonyNotificationsAsyncAction = AsyncAction(
      '_HomeViewStoreBase.runCeremonyNotifications',
      context: context);

  @override
  Future<void> runCeremonyNotifications(BuildContext context) {
    return _$runCeremonyNotificationsAsyncAction
        .run(() => super.runCeremonyNotifications(context));
  }

  @override
  String toString() {
    return '''
appStore: ${appStore}
    ''';
  }
}
