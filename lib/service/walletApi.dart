import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:encointer_wallet/config/consts.dart';

class WalletApi {
  static const String _endpoint = 'https://api.polkawallet.io';

  static const String _jsCodeStorageKey = 'js_service_';
  static const String _jsCodeStorageVersionKey = 'js_service_version_';

  static Future<Map> getLatestVersion() async {
    try {
      Response res = await get('$_endpoint/versions.json');
      if (res == null) {
        return null;
      } else {
        return jsonDecode(utf8.decode(res.bodyBytes)) as Map;
      }
    } catch (err) {
      print(err);
      return null;
    }
  }

  static Future<Map> getRecommended() async {
    try {
      Response res = await get('$_endpoint/recommended.json');
      if (res == null) {
        return null;
      } else {
        return jsonDecode(res.body) as Map;
      }
    } catch (err) {
      print(err);
      return null;
    }
  }

  static Future<int> fetchPolkadotJSVersion(String networkName) async {
    try {
      Response res = await get('$_endpoint/jsCodeVersions.json');
      if (res == null) {
        return null;
      } else {
        return Map.of(jsonDecode(res.body))[networkName];
      }
    } catch (err) {
      print(err);
      return null;
    }
  }

  static Future<String> fetchPolkadotJSCode(String networkName) async {
    try {
      Response res = await get('$_endpoint/js_service/$networkName.js');
      if (res == null) {
        return null;
      } else {
        return utf8.decode(res.bodyBytes);
      }
    } catch (err) {
      print(err);
      return null;
    }
  }

  static int getPolkadotJSVersion(
    GetStorage jsStorage,
    String networkName,
  ) {
    String version = jsStorage.read('$_jsCodeStorageVersionKey$networkName');
    if (version != null) {
      return int.parse(version);
    }
    // default version
    return js_code_version_map[networkName];
  }

  static String getPolkadotJSCode(
    GetStorage jsStorage,
    String networkName,
  ) {
    String jsCode = jsStorage.read('$_jsCodeStorageKey$networkName');
    return jsCode;
  }

  static void setPolkadotJSCode(
    GetStorage jsStorage,
    String networkName,
    String code,
    int version,
  ) {
    jsStorage.write('$_jsCodeStorageKey$networkName', code);
    jsStorage.write(
        '$_jsCodeStorageVersionKey$networkName', version.toString());
  }

  static Future<List> getAnnouncements() async {
    try {
      Response res = await get('$_endpoint/announce.json');
      if (res == null) {
        return null;
      } else {
        return jsonDecode(utf8.decode(res.bodyBytes));
      }
    } catch (err) {
      print(err);
      return null;
    }
  }
}
