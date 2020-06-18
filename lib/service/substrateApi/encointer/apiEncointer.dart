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

  final String _currentPhaseSubscribeChannel = 'currentPhase';

  Future<void> fetchCurrentPhase() async {
    Map res = await apiRoot.evalJavascript('encointer.fetchCurrentPhase(api)');

    var phase = getEnumFromString(
        CeremonyPhase.values, res.values.toList()[0].toString().toUpperCase());
    print("Phase enum: " + phase.toString());
    store.encointer.setCurrentPhase(phase);
  }

  Future<void> subscribeCurrentPhase() async {
    apiRoot.subscribeMessage('encointerScheduler', 'currentPhase', [], _currentPhaseSubscribeChannel, (data) {
      var phase = getEnumFromString(
          CeremonyPhase.values, data.values.toList()[0].toString().toUpperCase());
      print("Phase enum subscription: " + phase.toString());
      store.encointer.setCurrentPhase(phase);
    });
  }

  void unsubscribeCurrentPhase() {
    apiRoot.unsubscribeMessage(_currentPhaseSubscribeChannel);
  }

  Future<Map> fetchCurrencyIdentifiers() async {
    Map res = await apiRoot.evalJavascript('encointer.fetchCurrencyIdentifiers(api)');

    print("CID: " + res.toString());
    return res;
//    store.encointer.setCurrentPhase(phase);
  }
}
