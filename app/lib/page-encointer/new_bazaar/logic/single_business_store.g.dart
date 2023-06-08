// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_business_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SingleBusinessStore on _SingleBusinessStoreBase, Store {
  late final _$singleBusinessAtom = Atom(name: '_SingleBusinessStoreBase.singleBusiness', context: context);

  @override
  List<SingleBusiness>? get singleBusiness {
    _$singleBusinessAtom.reportRead();
    return super.singleBusiness;
  }

  @override
  set singleBusiness(List<SingleBusiness>? value) {
    _$singleBusinessAtom.reportWrite(value, super.singleBusiness, () {
      super.singleBusiness = value;
    });
  }

  late final _$fetchStatusAtom = Atom(name: '_SingleBusinessStoreBase.fetchStatus', context: context);

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

  late final _$getSingleBusinessAsyncAction =
      AsyncAction('_SingleBusinessStoreBase.getSingleBusiness', context: context);

  @override
  Future<void> getSingleBusiness() {
    return _$getSingleBusinessAsyncAction.run(() => super.getSingleBusiness());
  }

  @override
  String toString() {
    return '''
singleBusiness: ${singleBusiness},
fetchStatus: ${fetchStatus}
    ''';
  }
}
