import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:polka_wallet/common/consts/settings.dart';
import 'package:polka_wallet/service/faucet.dart';
import 'package:polka_wallet/store/app.dart';
import 'package:polka_wallet/service/substrateApi/api.dart';
import 'package:polka_wallet/utils/format.dart';

import 'package:polka_wallet/store/encointer/types/encointerTypes.dart';

class ApiEncointer {
  ApiEncointer(this.apiRoot);

  final Api apiRoot;
  final store = globalAppStore;

  Future<void> fetchCurrentPhase() async {
    Map res = await apiRoot.evalJavascript('encointer.fetchCurrentPhase(api)');

    var phase = getEnumFromString(
        CeremonyPhase.values, res.values.toList()[0].toString().toUpperCase());
    print("Phase enum: " + phase.toString());
    store.encointer.setCurrentPhase(phase);
  }

  Future<void> subscribeCurrentPhase(String channel, Function callback) async {
    apiRoot.msgHandlers[channel] = callback;
    apiRoot.evalJavascript(
        'encointer.subscribeCurrentPhase(api, $channel)');
  }

  Future<void> subscribeTimestamp() async {
    apiRoot.msgHandlers["unsubtimestamp"] = (data) => {
      print("timestamp" + data.toString())
    };
    await apiRoot.evalJavascript(
        'encointer.subscribeTimestamp(api)');
  }

  void unsubscribeCurrentPhase(String channel) {
    apiRoot.unsubscribeMessage(channel);
    apiRoot.unsubscribeMessage("unsubtimestamp");
  }

  Future<Map> fetchCurrencyIdentifiers() async {
    Map res = await apiRoot.evalJavascript('encointer.fetchCurrencyIdentifiers(api)');
    print("CID: " + res.toString());
    return res;
  }
}
