import 'dart:convert';

import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/encointer_balance_data/balance_entry.dart';
import 'package:encointer_wallet/models/worker_api/worker_api.dart';
import 'package:encointer_wallet/service/substrate_api/core/js_api.dart';

class TeeProxyApi {
  const TeeProxyApi(this.jsApi);

  final JSApi jsApi;

  Future<BalanceEntry> balance(CommunityIdentifier cid, String? pubKey, String pin) async {
    final balance = await jsApi.evalJavascript<Map<String, dynamic>>(
      'worker.getBalance(${jsonEncode(PubKeyPinPair(pubKey, pin))}, ${jsonEncode(cid)})',
    );
    return BalanceEntry.fromJson(balance);
  }
}
