import 'dart:convert';
import 'dart:async';
import 'package:encointer_wallet/common/consts/settings.dart';
import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/types/attestation.dart';
import 'package:encointer_wallet/store/encointer/types/claimOfAttendance.dart';
import 'package:encointer_wallet/store/encointer/types/encointerBalanceData.dart';
import 'package:encointer_wallet/store/encointer/types/encointerTypes.dart';
import 'package:encointer_wallet/store/encointer/types/location.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:convert' as JSON;
/*
class IpfsApiFunctions {
  IpfsApiFunctions(this.ipfsRoot);

  Future<String> addIpfsFile() async {
    print("api: uplodad IPFS file");
    //  Map res = await apiRoot.evalJavascript('encointer.getCurrentPhase()');

    //var phase = getEnumFromString(CeremonyPhase.values, res.values.toList()[0].toString().toUpperCase());
    // print("api: Phase enum: " + phase.toString());
    //store.encointer.setCurrentPhase(phase);
    //return phase;
  }
}*/
