// ignore_for_file: library_private_types_in_public_api
import 'package:ew_http/ew_http.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';

part 'transfer_gistory_store.g.dart';

class TransferHistoryStore = _TransferHistoryStoreBase with _$TransferHistoryStore;

abstract class _TransferHistoryStoreBase with Store {
  _TransferHistoryStoreBase(this.ewHttp);

  final EwHttp ewHttp;

  List<Transaction>? transactions;

  @observable
  FetchStatus fetchStatus = FetchStatus.initial;

  @action
  Future<void> getTransfers(AppStore appStore) async {
    fetchStatus = FetchStatus.loading;
    final address = Fmt.ss58Encode(
      appStore.account.currentAccountPubKey ?? '',
      prefix: appStore.settings.endpoint.ss58 ?? 42,
    );
    final data = await ewHttp.getTypeList<Transaction>(
      getTransactionHistoryUrl(appStore.encointer.community?.cid.toFmtString() ?? '', address),
      fromJson: Transaction.fromJson,
    );
    fetchStatus = data == null ? FetchStatus.error : FetchStatus.success;
    if (fetchStatus == FetchStatus.success) transactions = data!.reversed.toList();
  }
}
