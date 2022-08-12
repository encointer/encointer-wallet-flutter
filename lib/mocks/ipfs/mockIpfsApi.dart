import 'dart:io';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/ipfs/httpApi.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MockIpfs extends Ipfs {
  MockIpfs({gateway = ipfs_gateway_local}) : super(gateway: gateway);

  @override
  Future getJson(String cid) async {
    Log.p("unimplemented getJson");
  }

  @override
  Future<SvgPicture> getCommunityIcon(String? cid) {
    final mockIcon = "assets/images/assets/icon_leu.svg";
    Log.p("Getting mock icon: $mockIcon");
    return Future.value(SvgPicture.asset(mockIcon));
  }

  @override
  Future<String> uploadImage(File image) async {
    Log.p("unimplemented uploadImage");
    return "unimplemented uploadImage";
  }

  @override
  Future<String> uploadJson(Map<String, dynamic> json) async {
    Log.p("unimplemented uploadJson");
    return "unimplemented uploadJson";
  }
}
