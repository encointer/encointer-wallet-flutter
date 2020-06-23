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
    Map res = await apiRoot.evalJavascript('encointer.fetchCurrentPhase()');

    var phase = getEnumFromString(
        CeremonyPhase.values, res.values.toList()[0].toString().toUpperCase());
    print("Phase enum: " + phase.toString());
    store.encointer.setCurrentPhase(phase);
  }

  Future<void> fetchCurrentCeremonyIndex() async {
    var c_index = await apiRoot.evalJavascript('encointer.fetchCurrentCeremonyIndex()');
    print("Current Ceremony index: " + c_index.toString());
    store.encointer.setCurrentCeremonyIndex(c_index);
  }

  Future<void> fetchNextMeetupTime() async {
    var address = store.account.currentAddress;
    var cid = store.encointer.currentCeremonyIndex;
    var time = await apiRoot.evalJavascript('encointer.fetchNextMeetupTime("$cid", "$address")');
    print("Next Meetup Time: " + time.toString());
    store.encointer.setNextMeetupTime(time);
  }

  Future<void> fetchNextMeetupLocation() async {
    var address = store.account.currentAddress;
    var cid = store.encointer.currentCeremonyIndex;
    Location loc = await apiRoot.evalJavascript('encointer.fetchNextMeetupLocation($cid, $address)');
    print("Next Meetup Location: " + loc.toString());
    store.encointer.setNextMeetupLocation(loc);
  }

  Future<void> subscribeCurrentPhase(String channel, Function callback) async {
    apiRoot.msgHandlers[channel] = callback;
    apiRoot.evalJavascript(
        'encointer.subscribeCurrentPhase("$channel")');
  }

  Future<void> subscribeTimestamp(String channel) async {
    apiRoot.msgHandlers[channel] = (data) => {}; // we get logs in the message handler
    await apiRoot.evalJavascript(
        'encointer.subscribeTimestamp("$channel")');
  }

  Future<Map> fetchCurrencyIdentifiers() async {
    Map res = await apiRoot.evalJavascript('encointer.fetchCurrencyIdentifiers()');
    print("CID: " + res.toString());
    return res;
  }
}
