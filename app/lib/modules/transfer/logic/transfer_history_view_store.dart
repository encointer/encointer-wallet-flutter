// ignore_for_file: library_private_types_in_public_api
import 'package:ew_http/ew_http.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/models/index.dart';
// import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';

part 'transfer_history_view_store.g.dart';

class TransferHistoryViewStore = _TransferHistoryViewStoreBase with _$TransferHistoryViewStore;

abstract class _TransferHistoryViewStoreBase with Store {
  _TransferHistoryViewStoreBase(this.ewHttp);

  final EwHttp ewHttp;

  List<Transaction>? transactions;

  @observable
  FetchStatus fetchStatus = FetchStatus.loading;

  @action
  Future<void> getTransfers(AppStore appStore) async {
    fetchStatus = FetchStatus.loading;
    // final address = Fmt.ss58Encode(
    //   appStore.account.currentAccountPubKey ?? '',
    //   prefix: appStore.settings.endpoint.ss58 ?? 42,
    // );

    // final response = await ewHttp.getTypeList<Transaction>(
    //   getTransactionHistoryUrl(appStore.encointer.community?.cid.toFmtString() ?? '', address),
    //   fromJson: Transaction.fromJson,
    // );
    final response = await ewHttp.getTypeList<Transaction>(
      getTransactionHistoryUrl('u0qj944rhWE', 'HxunEG4C3pzFGMKHYAVt3D6LgCSoLcodReJ4xziFPsNWCew'),
      fromJson: Transaction.fromJson,
    );

    response.fold(
      (l) => fetchStatus = FetchStatus.error,
      (r) {
        fetchStatus = FetchStatus.success;
        transactions = r.reversed.toList();
      },
    );
  }
}
