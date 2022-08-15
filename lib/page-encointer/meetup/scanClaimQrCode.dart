import 'dart:convert';

import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/substrate_api/codecApi.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/types/claimOfAttendance.dart';
import 'package:encointer_wallet/utils/snackBar.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanClaimQrCode extends StatelessWidget {
  ScanClaimQrCode(this.store, this.confirmedParticipantsCount);

  final AppStore store;
  final int confirmedParticipantsCount;

  void validateAndStoreClaim(BuildContext context, ClaimOfAttendance claim, Translations dic) {
    List<String> registry = store.encointer.communityAccount!.meetup!.registry;
    if (!registry.contains(claim.claimantPublic)) {
      // this is important because the runtime checks if there are too many claims trying to be registered.
      RootSnackBar.showMsg(dic.encointer.meetupClaimantInvalid);
      Log.d(
        "[scanClaimQrCode] Claimant: ${claim.claimantPublic} is not part of registry: ${registry.toString()}",
        'scanClaimQrCode.dart',
      );
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
        Log.d("Error decoding claim: ${e.toString()}", 'scanClaimQrCode.dart');
        RootSnackBar.showMsg(dic.encointer.claimsScannedDecodeFailed);
      }

      // pops the cupertino activity indicator.
      Navigator.of(context).pop();
    }

    return Scaffold(
      body: FutureBuilder<bool>(
        future: canOpenCamera(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).cardColor,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                MobileScanner(
                    allowDuplicates: false,
                    onDetect: (barcode, args) {
                      if (barcode.rawValue == null) {
                        Log.p('Failed to scan Barcode', 'scanClaimQrCode.dart');
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
                            style: TextStyle(color: Colors.white, backgroundColor: Colors.black38, fontSize: 16));
                      }),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return CupertinoActivityIndicator();
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
        child: CupertinoActivityIndicator()),
  );
}

Future<bool> canOpenCamera() async {
  // will do nothing if already granted
  return Permission.camera.request().isGranted;
}
