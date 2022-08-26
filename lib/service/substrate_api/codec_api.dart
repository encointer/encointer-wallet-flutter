import 'dart:convert';
import 'dart:typed_data';

import 'core/js_api.dart';

const String ClaimOfAttendanceJSRegistryName = 'ClaimOfAttendance';

class CodecApi {
  CodecApi(this.jsApi);

  final JSApi jsApi;

  /// scale-decodes [hexStr] with the codec of [type].
  ///
  /// [type] must exist in the polkadot-js/api's type registry.
  Future<dynamic> decodeHex(String type, String hexStr) {
    return jsApi.evalJavascript('codec.decode("$type", $hexStr)', allowRepeat: true);
  }

  /// scale-decodes [bytes] with the codec of [type].
  ///
  /// [type] must exist in the polkadot-js/api's type registry.
  Future<dynamic> decodeBytes(String type, Uint8List bytes) async {
    var res = await jsApi.evalJavascript('codec.decode("$type", $bytes)', allowRepeat: true);

    if (res['error'] != null) {
      throw Exception("Could not decode bytes into $type. Error: ${res["error"]}");
    }

    return res;
  }

  /// scale-encodes [obj] with the codec of [type].
  ///
  /// [obj] must implement `jsonSerializable`.
  /// [type] must exist in the polkadot-js/api's type registry.
  Future<String> encodeToHex(String type, dynamic obj) {
    return jsApi
        .evalJavascript('codec.encodeToHex("$type", ${jsonEncode(obj)})', allowRepeat: true)
        .then((res) => res.toString()); // cast `dynamic` to `String`
  }

  /// scale-encodes [obj] with the codec of [type].
  ///
  /// [obj] must implement `jsonSerializable`.
  /// [type] must exist in the polkadot-js/api's type registry.
  Future<Uint8List> encodeToBytes(String type, dynamic obj) {
    return jsApi
        .evalJavascript('codec.encode("$type", ${jsonEncode(obj)})', allowRepeat: true)
        .then((res) => List<int>.from(res.values))
        .then((l) => Uint8List.fromList(l));
  }
}
