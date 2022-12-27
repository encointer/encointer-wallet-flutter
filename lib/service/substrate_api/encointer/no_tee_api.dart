import 'dart:convert';

import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/encointer_balance_data/balance_entry.dart';
import 'package:encointer_wallet/service/substrate_api/core/js_api.dart';

class NoTeeApi {
  NoTeeApi(this.jsApi)
      : ceremonies = Ceremonies(jsApi),
        balances = Balances(jsApi);

  final JSApi jsApi;
  final Ceremonies ceremonies;
  final Balances balances;
}

class Ceremonies {
  Ceremonies(this.jsApi);

  final JSApi jsApi;

  Future<int> participantIndex(CommunityIdentifier cid, int cIndex, String pubKey) async {
    return jsApi
        .evalJavascript('encointer.getParticipantIndex(${jsonEncode(cid)}, "$cIndex" ,"$pubKey")')
        .then((value) => int.parse(value as String));
  }

  Future<int> meetupIndex(CommunityIdentifier cid, int cIndex, String pubKey) async {
    return jsApi
        .evalJavascript('encointer.getMeetupIndex(${jsonEncode(cid)}, "$cIndex","$pubKey")')
        .then((value) => int.parse(value as String));
  }

  Future<List<String>> meetupRegistry(CommunityIdentifier cid, int cIndex, int mIndex) async {
    return jsApi
        .evalJavascript('encointer.getMeetupRegistry(${jsonEncode(cid)}, "$cIndex", "$mIndex")')
        .then((value) => List<String>.from(value as Iterable));
  }
}

class Balances {
  Balances(this.jsApi);

  final JSApi jsApi;

  Future<BalanceEntry> balance(CommunityIdentifier cid, String? pubKey) async {
    final balance = await jsApi.evalJavascript('encointer.getBalance(${jsonEncode(cid)}, "$pubKey")');
    return BalanceEntry.fromJson(balance as Map<String, dynamic>);
  }
}
