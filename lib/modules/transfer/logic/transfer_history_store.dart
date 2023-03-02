// ignore_for_file: library_private_types_in_public_api

import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:mobx/mobx.dart';

part 'transfer_history_store.g.dart';

const _tag = 'transfer_history_store';

class TransferHistoryStore = _TransferHistoryStoreBase with _$TransferHistoryStore;

abstract class _TransferHistoryStoreBase with Store {
  _TransferHistoryStoreBase() {
    _getTransfers();
  }

  @observable
  List<Transaction>? transactions;

  @action
  Future<void> _getTransfers() async {
    Log.d('_getTransfers', _tag);
    await Future<void>.delayed(const Duration(seconds: 1));
    final data = transferHistoryMockData['transfer_history'];
    transactions = data?.map(Transaction.fromJson).toList();
  }
}
