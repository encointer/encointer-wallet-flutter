import 'dart:io';

import 'package:flutter_svg/svg.dart';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/ipfs/http_api.dart';
import 'package:encointer_wallet/service/log/log_service.dart';

class MockIpfs extends Ipfs {
  MockIpfs({gateway = ipfs_gateway_local}) : super(gateway: gateway);

  @override
  Future getJson(String cid) async {
    Log.d('unimplemented getJson', 'MockIpfs');
  }

  @override
  Future<SvgPicture> getCommunityIcon(String? cid) {
    final mockIcon = 'assets/images/assets/icon_leu.svg';
    Log.d('Getting mock icon: $mockIcon', 'MockIpfs');
    return Future.value(SvgPicture.asset(mockIcon));
  }

  @override
  Future<String> uploadImage(File image) async {
    Log.d('unimplemented uploadImage', 'MockIpfs');
    return 'unimplemented uploadImage';
  }

  @override
  Future<String> uploadJson(Map<String, dynamic> json) async {
    Log.d('unimplemented uploadJson', 'MockIpfs');
    return 'unimplemented uploadJson';
  }
}
