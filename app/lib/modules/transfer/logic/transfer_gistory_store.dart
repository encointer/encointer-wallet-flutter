// ignore_for_file: library_private_types_in_public_api

import 'package:ew_http/ew_http.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/models/index.dart';

part 'transfer_gistory_store.g.dart';

class TransferHistoryStore = _TransferHistoryStoreBase with _$TransferHistoryStore;

abstract class _TransferHistoryStoreBase with Store {
  _TransferHistoryStoreBase(this.ewHttp);

  final EwHttp ewHttp;

  List<Transaction>? transactions;

  @observable
  FetchStatus fetchStatus = FetchStatus.initial;

  @action
  Future<void> getTransfers() async {
    fetchStatus = FetchStatus.loading;
    final data = await ewHttp.getTypeList<Transaction>(
      'https://api.encointer.org/v1/accounting/transaction-log?cid=dpcmj33LUs9&start=1670000000000&end=1676250900000&account=PBK',
      fromJson: Transaction.fromJson,
    );
    fetchStatus = data == null ? FetchStatus.error : FetchStatus.success;
    if (fetchStatus == FetchStatus.success) transactions = data;
  }
}

enum FetchStatus { initial, loading, success, error }
