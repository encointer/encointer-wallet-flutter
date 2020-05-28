import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:polka_wallet/common/consts/settings.dart';
import 'package:polka_wallet/service/faucet.dart';
import 'package:polka_wallet/store/app.dart';
import 'package:polka_wallet/service/substrateApi/api.dart';
import 'package:polka_wallet/utils/format.dart';

class ApiEncointer {
  ApiEncointer(this.apiRoot);

  final Api apiRoot;
  final store = globalAppStore;

  Future<void> fetchCurrentPhase() async {
    Map res = await apiRoot
        .evalJavascript('encointer.fetchCurrentPhase(api)');
    //store.encointer.setCurrentPhase(res);
  }
}
