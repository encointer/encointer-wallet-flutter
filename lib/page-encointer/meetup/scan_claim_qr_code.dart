import 'dart:convert';

import 'package:encointer_wallet/models/claim_of_attendance/claim_of_attendance.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/substrate_api/codec_api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanClaimQrCode extends StatelessWidget {
  ScanClaimQrCode(this.store, this.confirmedParticipantsCount, {Key? key}) : super(key: key);

  final AppStore store;
  final int confirmedParticipantsCount;

  void validateAndStoreClaim(BuildContext context, ClaimOfAttendance claim, Translations dic) {
    List<String> registry = store.encointer.communityAccount!.meetup!.registry;
    if (!registry.contains(claim.claimantPublic)) {
      // this is important because the runtime checks if there are too many claims trying to be registered.
      RootSnackBar.showMsg(dic.encointer.meetupClaimantInvalid);
      print('[scanClaimQrCode] Claimant: ${claim.claimantPublic} is not part of registry: ${registry.toString()}');
    } else {
      String msg = store.encointer.communityAccount!.containsClaim(claim)
          ? dic.encointer.claimsScannedAlready
          : dic.encointer.claimsScannedNew;

      store.encointer.communityAccount!.addParticipantClaim(claim);
      RootSnackBar.showMsg(msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context)!.translationsForLocale();

    Future _onScan(String base64Data) async {
      // Show a cupertino activity indicator as long as we are decoding
      _showActivityIndicatorOverlay(context);

      try {
        var data = base64.decode(base64Data);

        // Todo: Not good to use the global webApi here, but I wanted to prevent big changes into the code for now.
        // Fix this when #132 is tackled.
        var claim = await webApi.codec
            .decodeBytes(ClaimOfAttendanceJSRegistryName, data)
            .then((c) => ClaimOfAttendance.fromJson(c));

        validateAndStoreClaim(context, claim, dic);
      } catch (e) {
        _log('Error decoding claim: ${e.toString()}');
        RootSnackBar.showMsg(dic.encointer.claimsScannedDecodeFailed);
      }

      // pops the cupertino activity indicator.
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          IconButton(
            key: const Key('close-scanner'),
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      body: FutureBuilder<PermissionStatus>(
        future: canOpenCamera(),
        builder: (BuildContext context, AsyncSnapshot<PermissionStatus> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != PermissionStatus.granted) {
              print('[scanPage] Permission Status: ${snapshot.data!.toString()}');
              return permissionErrorDialog(context);
            }

            return Stack(
              children: [
                MobileScanner(
                    allowDuplicates: false,
                    onDetect: (barcode, args) {
                      if (barcode.rawValue == null) {
                        debugPrint('Failed to scan Barcode');
                      } else {
                        _onScan(barcode.rawValue!);
                      }
                    }),
                //overlays a semi-transparent rounded square border that is 90% of screen width
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.white38, width: 2.0),
                          borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                        ),
                      ),
                      Observer(builder: (_) {
                        final txt = dic.encointer.claimsScannedNOfM
                            .replaceAll(
                                'SCANNED_COUNT', store.encointer.communityAccount!.scannedClaimsCount.toString())
                            .replaceAll(
                              'TOTAL_COUNT',
                              (confirmedParticipantsCount - 1).toString(),
                            );
                        return Text(txt,
                            style: const TextStyle(color: Colors.white, backgroundColor: Colors.black38, fontSize: 16));
                      }),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CupertinoActivityIndicator());
          }
        },
      ),
    );
  }
}

void _showActivityIndicatorOverlay(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (_) => Container(
        height: Size.infinite.height,
        width: Size.infinite.width,
        color: Colors.grey.withOpacity(0.5),
        child: const CupertinoActivityIndicator()),
  );
}

Future<PermissionStatus> canOpenCamera() async {
  // will do nothing if already granted
  return Permission.camera.request();
}

_log(String msg) {
  print('[ScanClaimQrCode] $msg');
}

Widget permissionErrorDialog(BuildContext context) {
  final dic = I18n.of(context)!.translationsForLocale();

  return CupertinoAlertDialog(
    title: Container(),
    content: Text(dic.home.cameraPermissionError),
    actions: <Widget>[
      CupertinoButton(
        child: Text(dic.home.ok),
        onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
      ),
      CupertinoButton(
        child: Text(dic.home.appSettings),
        onPressed: () => openAppSettings(),
      ),
    ],
  );
}
