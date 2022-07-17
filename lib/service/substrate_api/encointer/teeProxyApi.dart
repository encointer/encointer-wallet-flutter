import 'dart:convert';

import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:encointer_wallet/store/encointer/types/encointerBalanceData.dart';
import 'package:encointer_wallet/store/encointer/types/workerApi.dart';

import '../core/jsApi.dart';

class TeeProxyApi {
  TeeProxyApi(this.jsApi)
      : ceremonies = Ceremonies(jsApi),
        balances = Balances(jsApi);

  final JSApi? jsApi;
  final Ceremonies ceremonies;
  final Balances balances;
}

class Ceremonies {
  Ceremonies(this.jsApi);

  final JSApi? jsApi;

  Future<int> participantIndex(CommunityIdentifier cid, String pubKey, String pin) async {
    return jsApi!
        .evalJavascript('worker.getParticipantIndex(${jsonEncode(PubKeyPinPair(pubKey, pin))}, ${jsonEncode(cid)})')
        .then((value) => int.parse(value));
  }

  Future<int> meetupIndex(CommunityIdentifier cid, String pubKey, String pin) async {
    return jsApi!
        .evalJavascript('worker.getMeetupIndex(${jsonEncode(PubKeyPinPair(pubKey, pin))}, ${jsonEncode(cid)})')
        .then((value) => int.parse(value));
  }

  Future<List<String>> meetupRegistry(CommunityIdentifier cid, String pubKey, String pin) async {
    return jsApi!
        .evalJavascript('worker.getMeetupRegistry(${jsonEncode(PubKeyPinPair(pubKey, pin))}, ${jsonEncode(cid)})')
        .then((value) => List<String>.from(value));
  }
}

class Balances {
  Balances(this.jsApi);

  final JSApi? jsApi;

  Future<BalanceEntry> balance(CommunityIdentifier cid, String? pubKey, String pin) async {
    return jsApi!
        .evalJavascript('worker.getBalance(${jsonEncode(PubKeyPinPair(pubKey, pin))}, ${jsonEncode(cid)})')
        .then((balance) => BalanceEntry.fromJson(balance));
  }
}
