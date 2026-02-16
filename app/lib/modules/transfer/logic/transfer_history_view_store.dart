// ignore_for_file: library_private_types_in_public_api
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/store/offline_payment/offline_payment_store.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';
import 'package:ew_log/ew_log.dart';
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

  @computed
  List<OfflinePaymentRecord> get offlinePayments => appStore.offlinePayment.currentAccountPayments;

  @observable
  FetchStatus fetchStatus = FetchStatus.loading;

  @observable
  bool fetchFailed = false;

  @action
  Future<void> getTransfers() async {
    fetchStatus = FetchStatus.loading;
    fetchFailed = false;

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
        prefix: appStore.settings.currentNetwork.ss58(),
      );

      // address with SwapEvent in LEU
      // const address = 'DGeoBv3E9xniabhyWsSjd25Te8ZmjQ7zndc2VVbmU8zmZQB';

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
      fetchFailed = true;
      transactions = [];
      // Show offline payments even when network fetch fails
      fetchStatus = offlinePayments.isNotEmpty ? FetchStatus.success : FetchStatus.error;
    }
  }
}
