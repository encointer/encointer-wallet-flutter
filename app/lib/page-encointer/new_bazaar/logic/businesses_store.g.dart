// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'businesses_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BusinessesStore on _BusinessesStoreBase, Store {
  late final _$businessesAtom = Atom(name: '_BusinessesStoreBase.businesses', context: context);

  @override
  List<Businesses>? get businesses {
    _$businessesAtom.reportRead();
    return super.businesses;
  }

  @override
  set businesses(List<Businesses>? value) {
    _$businessesAtom.reportWrite(value, super.businesses, () {
      super.businesses = value;
    });
  }

  late final _$fetchStatusAtom = Atom(name: '_BusinessesStoreBase.fetchStatus', context: context);

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

  late final _$getBusinessesAsyncAction = AsyncAction('_BusinessesStoreBase.getBusinesses', context: context);

  @override
  Future<void> getBusinesses({Category category = Category.all}) {
    return _$getBusinessesAsyncAction.run(() => super.getBusinesses(category: category));
  }

  @override
  String toString() {
    return '''
businesses: ${businesses},
fetchStatus: ${fetchStatus}
    ''';
  }
}
