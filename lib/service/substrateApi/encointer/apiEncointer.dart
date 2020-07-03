import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:polka_wallet/common/consts/settings.dart';
import 'package:polka_wallet/service/faucet.dart';
import 'package:polka_wallet/store/app.dart';
import 'package:polka_wallet/service/substrateApi/api.dart';
import 'package:polka_wallet/store/encointer/types/claimOfAttendance.dart';
import 'package:polka_wallet/store/encointer/types/location.dart';
import 'package:polka_wallet/utils/format.dart';

import 'package:polka_wallet/store/encointer/types/encointerTypes.dart';

/// Api to interface with the `js_encointer_service.js`
///
/// Note: If a call fails on the js side, the corresponding message completer will not be
/// freed. This means that the same call cannot be launched a second time as from the dart
/// side if allow multiple==false in evalJavascript, which is the default.
///
/// NOTE: In this case a `hot_restart` instead of `hot_reload` is needed in order to clear that cache.
///
/// NOTE: If the js-code was changed a rebuild of the application is needed to update the code.

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
    if (store.encointer.currencyIdentifiers == null) {
      return;
    }
    var cid = store.encointer.chosenCid ?? store.encointer.currencyIdentifiers[0];
    var loc = jsonEncode({
      "lat": store.encointer.nextMeetupLocation.lat,
      "lon": store.encointer.nextMeetupLocation.lon,
    });
    var time = await apiRoot.evalJavascript('encointer.fetchNextMeetupTime("$cid", $loc)');
    print("Next Meetup Time: " + time.toString());
    store.encointer.setNextMeetupTime(time);
  }

  Future<void> fetchMeetupIndex() async {
    var address = store.account.currentAccountPubKey;
    var cid = store.encointer.chosenCid;
    var cIndex = store.encointer.currentCeremonyIndex;
    var mIndex = await apiRoot.evalJavascript('encointer.fetchMeetupIndex("$cid", "$cIndex","$address")');
    print("Next Meetup Index: " + mIndex.toString());
    store.encointer.setMeetupIndex(mIndex);
  }

  Future<void> fetchNextMeetupLocation() async {
    var address = store.account.currentAccountPubKey;
    var cid = store.encointer.chosenCid;
    var mIndex = store.encointer.meetupIndex;
    var locj = await apiRoot.evalJavascript('encointer.fetchNextMeetupLocation("$cid", "$mIndex","$address")');
    print("Next Meetup Location: " + locj.toString());
    Location loc = Location.fromJson(locj);
    store.encointer.setNextMeetupLocation(loc);
  }

  Future<void> fetchParticipantIndex() async {
    var address = store.account.currentAccountPubKey;
    var cid = store.encointer.chosenCid;
    var cIndex = store.encointer.currentCeremonyIndex;
    print("Fetching participant index for " + address);
    var pIndex = await apiRoot.evalJavascript('encointer.fetchParticipantIndex("$cid", "$cIndex" ,"$address")');
    print("Participant Index: " + pIndex.toString());
    store.encointer.setParticipantIndex(pIndex);
  }

  Future<void> fetchParticipantCount() async {
    var cid = store.encointer.chosenCid;
    var cIndex = store.encointer.currentCeremonyIndex;
    var pCount = await apiRoot.evalJavascript('encointer.fetchParticipantCount("$cid", "$cIndex")');
    print("Participant Count: " + pCount.toString());
    store.encointer.setParticipantCount(pCount);
  }

  Future<dynamic> fetchMeetupRegistry() async {
    var cIndex = store.encointer.currentCeremonyIndex;
    var cid = store.encointer.chosenCid;
    var mIndex = store.encointer.meetupIndex;
    print("fetch meetup registry for cindex " + cIndex.toString() + " mindex " + mIndex.toString() + " cid " + cid);
    var meetupRegistry = await apiRoot.evalJavascript('encointer.fetchMeetupRegistry("$cid", "$cIndex", "$mIndex")');
    print("Participants: " + meetupRegistry.toString());
    // generate all icons for these participants
    /*
    TODO: I guess we'll have to generate icons before using them. the app currently only generates them for known keys
    List res = await apiRoot.evalJavascript(
        'account.genIcons(${jsonEncode(meetupRegistry)})',
        allowRepeat: true);
    store.account.setAddressIconsMap(res);

     */
    return meetupRegistry;
  }

  Future<void> subscribeCurrentPhase(String channel, Function callback) async {
    apiRoot.msgHandlers[channel] = callback;
    apiRoot.evalJavascript(
        'encointer.subscribeCurrentPhase("$channel")');
  }

  Future<void> subscribeTimestamp(String channel) async {
    apiRoot.msgHandlers[channel] = (data) => {
      store.encointer.setTimestamp(data)
    };
    await apiRoot.evalJavascript(
        'encointer.subscribeTimestamp("$channel")');
  }

  Future<List<dynamic>> fetchCurrencyIdentifiers() async {
    Map<String, dynamic> res = await apiRoot.evalJavascript('encointer.fetchCurrencyIdentifiers()');
    print("CID: " + res['cids'].toString());
    store.encointer.setCurrencyIdentifiers(res['cids']);
    return res['cids'];
  }

  Future<dynamic> getClaimOfAttendance(participants) async {
    var claim = jsonEncode(ClaimOfAttendance(
        store.account.currentAccountPubKey,
        store.encointer.currentCeremonyIndex,
        store.encointer.chosenCid,
        store.encointer.meetupIndex,
        store.encointer.nextMeetupLocation,
        store.encointer.timeStamp,
        participants
    ));
    print(claim);
    var claimHex = await apiRoot.evalJavascript('encointer.getClaimOfAttendance($claim)');
    return claimHex;
  }

  Future<dynamic> attestClaimOfAttendance(String claimHex, String password) async{
    var pubKey = store.account.currentAccountPubKey;
    print("Public key:" + pubKey);
    var att = await apiRoot.evalJavascript('account.attestClaimOfAttendance("$claimHex", "$pubKey", "$password")');
    return att;
  }
}
