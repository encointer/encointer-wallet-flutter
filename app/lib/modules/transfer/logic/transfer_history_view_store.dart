// ignore_for_file: library_private_types_in_public_api
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:ew_http/ew_http.dart';
import 'package:ew_keyring/ew_keyring.dart';

part 'transfer_history_view_store.g.dart';

class TransferHistoryViewStore extends _TransferHistoryViewStoreBase with _$TransferHistoryViewStore {
  TransferHistoryViewStore(super.appStore, super.ewHttp);
}

const _target = 'transfer_history_view_store';

abstract class _TransferHistoryViewStoreBase with Store {
  _TransferHistoryViewStoreBase(this.appStore, this.ewHttp);

  final EwHttp ewHttp;

  final AppStore appStore;

  List<Transaction> transactions = [];

  @observable
  FetchStatus fetchStatus = FetchStatus.loading;

  @action
  Future<void> getTransfers() async {
    fetchStatus = FetchStatus.loading;

    final pubKey = appStore.account.currentAccountPubKey;
    final cid = appStore.encointer.community?.cid;

    if (pubKey == null || pubKey.isEmpty) {
      Log.e('currentAccountPubKey is not set', _target);
      return;
    }

    if (cid == null) {
      Log.e('chosen community is not set', _target);
      return;
    }

    try {
      final address = AddressUtils.pubKeyHexToAddress(
        pubKey,
        prefix: appStore.settings.endpoint.ss58(),
      );

      final response = await ewHttp.getTypeList<Transaction>(
        getTransactionHistoryUrl(cid.toFmtString(), address),
        fromJson: Transaction.fromJson,
      );

      response.fold(
        (l) {
          fetchStatus = FetchStatus.error;
          throw l;
        },
        (r) {
          fetchStatus = FetchStatus.success;
          transactions = r.reversed.toList();
        },
      );
    } catch (e) {
      Log.e('Error getting transfers: $e');
      fetchStatus = FetchStatus.error;
    }
  }
}
