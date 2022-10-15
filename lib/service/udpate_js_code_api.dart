import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/log/log_service.dart';

/// Class to update the js-code from in app.
///
/// Useful to be able to track upstream polkadot updates without having to update the
/// app in the respective app stores.
///
/// Todo: Decide if we keep this https://github.com/encointer/encointer-wallet-flutter/issues/517
class UpdateJSCodeApi {
  static const String _endpoint = 'https://api.polkawallet.io';

  static const String _jsCodeStorageKey = 'js_service_';
  static const String _jsCodeStorageVersionKey = 'js_service_version_';

  static Future<Map?> getLatestVersion() async {
    try {
      Response res = await get(Uri.parse('$_endpoint/versions.json'));
      return jsonDecode(utf8.decode(res.bodyBytes)) as Map?;
    } catch (e, s) {
      Log.e('$e', 'UpdateJSCodeApi', s);
      return Future.value(null);
    }
  }

  static Future<Map?> getRecommended() async {
    try {
      Response res = await get(Uri.parse('$_endpoint/recommended.json'));
      return jsonDecode(res.body);
    } catch (e, s) {
      Log.e('$e', 'UpdateJSCodeApi', s);
      return Future.value(null);
    }
  }

  static Future<int?> fetchPolkadotJSVersion(String networkName) async {
    try {
      Response res = await get(Uri.parse('$_endpoint/jsCodeVersions.json'));
      return Map.of(jsonDecode(res.body))[networkName];
    } catch (e, s) {
      Log.e('$e', 'UpdateJSCodeApi', s);
      return Future.value(null);
    }
  }

  static Future<String?> fetchPolkadotJSCode(String networkName) async {
    try {
      Response res = await get(Uri.parse('$_endpoint/js_service/$networkName.js'));
      return utf8.decode(res.bodyBytes);
    } catch (e, s) {
      Log.e('$e', 'UpdateJSCodeApi', s);
      return Future.value(null);
    }
  }

  static int? getPolkadotJSVersion(
    GetStorage jsStorage,
    String networkName,
  ) {
    String? version = jsStorage.read('$_jsCodeStorageVersionKey$networkName');
    if (version != null) {
      return int.parse(version);
    }
    // default version
    return js_code_version_map[networkName];
  }

  static String? getPolkadotJSCode(
    GetStorage jsStorage,
    String networkName,
  ) {
    String? jsCode = jsStorage.read('$_jsCodeStorageKey$networkName');
    return jsCode;
  }

  static void setPolkadotJSCode(
    GetStorage jsStorage,
    String networkName,
    String code,
    int version,
  ) {
    jsStorage.write('$_jsCodeStorageKey$networkName', code);
    jsStorage.write('$_jsCodeStorageVersionKey$networkName', version.toString());
  }

  static Future<List?> getAnnouncements() async {
    try {
      Response res = await get(Uri.parse('$_endpoint/announce.json'));
      return jsonDecode(utf8.decode(res.bodyBytes));
    } catch (e, s) {
      Log.e('$e', 'UpdateJSCodeApi', s);
      return Future.value(null);
    }
  }
}
