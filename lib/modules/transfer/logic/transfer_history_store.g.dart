// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_history_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TransferHistoryStore on _TransferHistoryStoreBase, Store {
  late final _$transactionsAtom =
      Atom(name: '_TransferHistoryStoreBase.transactions', context: context);

  @override
  List<Transaction>? get transactions {
    _$transactionsAtom.reportRead();
    return super.transactions;
  }

  @override
  set transactions(List<Transaction>? value) {
    _$transactionsAtom.reportWrite(value, super.transactions, () {
      super.transactions = value;
    });
  }

  late final _$_getTransfersAsyncAction =
      AsyncAction('_TransferHistoryStoreBase._getTransfers', context: context);

  @override
  Future<void> _getTransfers() {
    return _$_getTransfersAsyncAction.run(() => super._getTransfers());
  }

  @override
  String toString() {
    return '''
transactions: ${transactions}
    ''';
  }
}
