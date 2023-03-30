// ignore_for_file: library_private_types_in_public_api

import 'package:encointer_wallet/models/index.dart';
import 'package:mobx/mobx.dart';

part 'transfer_gistory_store.g.dart';

class TransferHistoryStore = _TransferHistoryStoreBase with _$TransferHistoryStore;

abstract class _TransferHistoryStoreBase with Store {
  @observable
  List<Transaction>? transactions;

  @action
  Future<void> getTransfers() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    final data = transferHistoryMockData['transfer_history'];
    transactions = data?.map(Transaction.fromJson).toList();
  }
}
