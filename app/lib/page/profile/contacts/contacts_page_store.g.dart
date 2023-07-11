// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ContactsPageStore on _ContactsPageStore, Store {
  late final _$appStoreAtom = Atom(name: '_ContactsPageStore.appStore', context: context);

  @override
  AppStore get appStore {
    _$appStoreAtom.reportRead();
    return super.appStore;
  }

  @override
  set appStore(AppStore value) {
    _$appStoreAtom.reportWrite(value, super.appStore, () {
      super.appStore = value;
    });
  }

  late final _$isLoadingAtom = Atom(name: '_ContactsPageStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$contactListAtom = Atom(name: '_ContactsPageStore.contactList', context: context);

  @override
  ObservableList<AccountData> get contactList {
    _$contactListAtom.reportRead();
    return super.contactList;
  }

  @override
  set contactList(ObservableList<AccountData> value) {
    _$contactListAtom.reportWrite(value, super.contactList, () {
      super.contactList = value;
    });
  }

  late final _$initAsyncAction = AsyncAction('_ContactsPageStore.init', context: context);

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$_getContactsReputationAsyncAction =
      AsyncAction('_ContactsPageStore._getContactsReputation', context: context);

  @override
  Future<void> _getContactsReputation() {
    return _$_getContactsReputationAsyncAction.run(() => super._getContactsReputation());
  }

  @override
  String toString() {
    return '''
appStore: ${appStore},
isLoading: ${isLoading},
contactList: ${contactList}
    ''';
  }
}
