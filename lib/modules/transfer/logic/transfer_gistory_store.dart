// ignore_for_file: library_private_types_in_public_api

import 'package:encointer_wallet/models/index.dart';
import 'package:mobx/mobx.dart';

part 'transfer_gistory_store.g.dart';

class TransferHistoryStore = _TransferHistoryStoreBase with _$TransferHistoryStore;

abstract class _TransferHistoryStoreBase with Store {
  @observable
  List<TransferHistory>? transfers;

  @action
  Future<void> getTransfers() async {
    final data = transferHistoryMockData['transfer_history'];
    transfers = data?.map(TransferHistory.fromJson).toList();
  }
}
