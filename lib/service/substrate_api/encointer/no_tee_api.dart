import 'dart:convert';

import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/encointer_balance_data/balance_entry.dart';
import 'package:encointer_wallet/service/substrate_api/core/js_api.dart';

class NoTeeApi {
  const NoTeeApi(this.jsApi);

  final JSApi jsApi;

  Future<BalanceEntry> balance(CommunityIdentifier cid, String? pubKey) async {
    final balance = await jsApi.evalJavascript<Map<String, dynamic>>(
      'encointer.getBalance(${jsonEncode(cid)}, "$pubKey")',
    );
    return BalanceEntry.fromJson(balance);
  }
}
