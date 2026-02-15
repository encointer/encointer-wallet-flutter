// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_history_view_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TransferHistoryViewStore on _TransferHistoryViewStoreBase, Store {
  Computed<List<OfflinePaymentRecord>>? _$offlinePaymentsComputed;

  @override
  List<OfflinePaymentRecord> get offlinePayments =>
      (_$offlinePaymentsComputed ??= Computed<List<OfflinePaymentRecord>>(() => super.offlinePayments,
              name: '_TransferHistoryViewStoreBase.offlinePayments'))
          .value;

  late final _$fetchStatusAtom = Atom(name: '_TransferHistoryViewStoreBase.fetchStatus', context: context);

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

  late final _$getTransfersAsyncAction = AsyncAction('_TransferHistoryViewStoreBase.getTransfers', context: context);

  @override
  Future<void> getTransfers() {
    return _$getTransfersAsyncAction.run(() => super.getTransfers());
  }

  @override
  String toString() {
    return '''
fetchStatus: ${fetchStatus},
offlinePayments: ${offlinePayments}
    ''';
  }
}
