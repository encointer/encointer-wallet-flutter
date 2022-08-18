import 'dart:io';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/ipfs/http_api.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MockIpfs extends Ipfs {
  MockIpfs({gateway = ipfs_gateway_local}) : super(gateway: gateway);

  @override
  Future getJson(String cid) async {
    _log("unimplemented getJson");
  }

  @override
  Future<SvgPicture> getCommunityIcon(String? cid) {
    final mockIcon = "assets/images/assets/icon_leu.svg";
    print("Getting mock icon: $mockIcon");
    return Future.value(SvgPicture.asset(mockIcon));
  }

  @override
  Future<String> uploadImage(File image) async {
    _log("unimplemented uploadImage");
    return "unimplemented uploadImage";
  }

  @override
  Future<String> uploadJson(Map<String, dynamic> json) async {
    _log("unimplemented uploadJson");
    return "unimplemented uploadJson";
  }
}

void _log(String msg) {
  print("[MockIpfs]: msg");
}
