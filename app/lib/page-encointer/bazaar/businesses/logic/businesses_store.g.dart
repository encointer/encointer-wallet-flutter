// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'businesses_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BusinessesStore on _BusinessesStoreBase, Store {
  late final _$businessesAtom =
      Atom(name: '_BusinessesStoreBase.businesses', context: context);

  @override
  List<IpfsBusiness> get businesses {
    _$businessesAtom.reportRead();
    return super.businesses;
  }

  @override
  set businesses(List<IpfsBusiness> value) {
    _$businessesAtom.reportWrite(value, super.businesses, () {
      super.businesses = value;
    });
  }

  late final _$sortedBusinessesAtom =
      Atom(name: '_BusinessesStoreBase.sortedBusinesses', context: context);

  @override
  List<IpfsBusiness> get sortedBusinesses {
    _$sortedBusinessesAtom.reportRead();
    return super.sortedBusinesses;
  }

  @override
  set sortedBusinesses(List<IpfsBusiness> value) {
    _$sortedBusinessesAtom.reportWrite(value, super.sortedBusinesses, () {
      super.sortedBusinesses = value;
    });
  }

  late final _$fetchStatusAtom =
      Atom(name: '_BusinessesStoreBase.fetchStatus', context: context);

  @override
  FetchStatus get fetchStatus {
    _$fetchStatusAtom.reportRead();
    return super.fetchStatus;
  }

  @override
  set fetchStatus(FetchStatus value) {
    _$fetchStatusAtom.reportWrite(value, super.fetchStatus, () {
      super.fetchStatus = value;
    });
  }

  late final _$errorAtom =
      Atom(name: '_BusinessesStoreBase.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$getBusinessesAsyncAction =
      AsyncAction('_BusinessesStoreBase.getBusinesses', context: context);

  @override
  Future<void> getBusinesses(CommunityIdentifier cid) {
    return _$getBusinessesAsyncAction.run(() => super.getBusinesses(cid));
  }

  late final _$_BusinessesStoreBaseActionController =
      ActionController(name: '_BusinessesStoreBase', context: context);

  @override
  void filterBusinessesByCategory({required Category category}) {
    final _$actionInfo = _$_BusinessesStoreBaseActionController.startAction(
        name: '_BusinessesStoreBase.filterBusinessesByCategory');
    try {
      return super.filterBusinessesByCategory(category: category);
    } finally {
      _$_BusinessesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
businesses: ${businesses},
sortedBusinesses: ${sortedBusinesses},
fetchStatus: ${fetchStatus},
error: ${error}
    ''';
  }
}
