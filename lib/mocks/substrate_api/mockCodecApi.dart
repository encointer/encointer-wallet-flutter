import 'dart:convert';
import 'dart:typed_data';

import 'package:encointer_wallet/service/substrate_api/codecApi.dart';

import 'mockJSApi.dart';

class MockCodecApi extends CodecApi {
  MockCodecApi(MockJSApi js) : super(js);

  @override
  Future<Uint8List> encodeToBytes(String type, dynamic obj) {
    _log(":encodeToBytes: Warn: returning mock data");
    return Future.value(Uint8List.fromList(utf8.encode(obj.toString())));
  }
}

_log(String msg) {
  print("[MockCodecApi] $msg");
}
