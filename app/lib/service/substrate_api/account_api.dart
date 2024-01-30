import 'dart:async';

import 'package:encointer_wallet/service/notification/lib/notification.dart';
import 'package:encointer_wallet/service/tx/lib/src/tx_notification.dart';
import 'package:encointer_wallet/service/tx/lib/src/send_tx_dart.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:ew_polkadart/ew_polkadart.dart' show Provider;

class AccountApi {
  AccountApi(this.store, this.provider);

  final Provider provider;
  final AppStore store;
  void Function()? fetchAccountData;

  void setFetchAccountData(void Function()? fetchAccountData) {
    this.fetchAccountData = fetchAccountData;
  }

  Future<void> changeCurrentAccount({
    String? pubKey,
    bool fetchData = false,
  }) async {
    var current = pubKey;
    if (pubKey == null) {
      if (store.account.accountListAll.isNotEmpty) {
        current = store.account.accountListAll[0].pubKey;
      } else {
        current = '';
      }
    }
    await store.setCurrentAccount(current);

    await store.loadAccountCache();
    if (fetchData) fetchAccountData?.call();
  }

  Future<ExtrinsicReport> sendTxAndShowNotification(
    OpaqueExtrinsic xt,
    TxNotification? notification, {
    String? cid,
  }) async {
    final report = await EWAuthorApi(provider).submitAndWatchExtrinsicWithReport(xt);

    if (report.isExtrinsicSuccess && notification != null) {
      final hash = report.blockHash;
      unawaited(NotificationPlugin.showNotification(
        int.parse(hash.substring(0, 6)),
        notification.title,
        notification.body,
        cid: cid,
      ));
    }
    return report;
  }
}
