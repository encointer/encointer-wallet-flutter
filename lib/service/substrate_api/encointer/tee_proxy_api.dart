import 'dart:convert';

import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/encointer_balance_data/balance_entry.dart';
import 'package:encointer_wallet/models/worker_api/worker_api.dart';
import 'package:encointer_wallet/service/substrate_api/core/js_api.dart';

class TeeProxyApi {
  TeeProxyApi(JSApi jsApi) : balances = Balances(jsApi);

  final Balances balances;
}

// class Ceremonies {
//   Ceremonies(this.jsApi);

//   final JSApi jsApi;

// Future<int> participantIndex(CommunityIdentifier cid, String pubKey, String pin) async {
//   return jsApi
//       .evalJavascript('worker.getParticipantIndex(${jsonEncode(PubKeyPinPair(pubKey, pin))}, ${jsonEncode(cid)})')
//       .then((value) => int.parse(value as String));
// }

// Future<int> meetupIndex(CommunityIdentifier cid, String pubKey, String pin) async {
//   return jsApi
//       .evalJavascript('worker.getMeetupIndex(${jsonEncode(PubKeyPinPair(pubKey, pin))}, ${jsonEncode(cid)})')
//       .then((value) => int.parse(value as String));
// }

// Future<List<String>> meetupRegistry(CommunityIdentifier cid, String pubKey, String pin) async {
//   return jsApi
//       .evalJavascript('worker.getMeetupRegistry(${jsonEncode(PubKeyPinPair(pubKey, pin))}, ${jsonEncode(cid)})')
//       .then((value) => List<String>.from(value as Iterable));
// }
// }

class Balances {
  Balances(this.jsApi);

  final JSApi jsApi;

  Future<BalanceEntry> balance(CommunityIdentifier cid, String? pubKey, String pin) async {
    return jsApi
        .evalJavascript('worker.getBalance(${jsonEncode(PubKeyPinPair(pubKey, pin))}, ${jsonEncode(cid)})')
        .then((balance) => BalanceEntry.fromJson(balance as Map<String, dynamic>));
  }
}
