// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_gistory_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TransferHistoryStore on _TransferHistoryStoreBase, Store {
  late final _$transfersAtom = Atom(name: '_TransferHistoryStoreBase.transfers', context: context);

  @override
  List<TransferHistory>? get transfers {
    _$transfersAtom.reportRead();
    return super.transfers;
  }

  @override
  set transfers(List<TransferHistory>? value) {
    _$transfersAtom.reportWrite(value, super.transfers, () {
      super.transfers = value;
    });
  }

  late final _$getTransfersAsyncAction = AsyncAction('_TransferHistoryStoreBase.getTransfers', context: context);

  @override
  Future<void> getTransfers() {
    return _$getTransfersAsyncAction.run(() => super.getTransfers());
  }

  @override
  String toString() {
    return '''
transfers: ${transfers}
    ''';
  }
}
