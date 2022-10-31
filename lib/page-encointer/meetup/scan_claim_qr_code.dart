import 'dart:convert';

import 'package:encointer_wallet/utils/format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:encointer_wallet/models/claim_of_attendance/claim_of_attendance.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/substrate_api/codec_api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';

class ScanClaimQrCode extends StatelessWidget {
  ScanClaimQrCode(this.store, this.confirmedParticipantsCount, {Key? key}) : super(key: key);

  final AppStore store;
  final int confirmedParticipantsCount;

  void validateAndStoreParticipant(BuildContext context, String attendee, Translations dic) {
    List<String> registry = store.encointer.communityAccount!.meetup!.registry;

    if (attendee == store.account.currentAddress) {
      RootSnackBar.showMsg(dic.encointer.meetupClaimantEqualToSelf);
      Log.d(
        'Claimant: $attendee is equal to self',
        'ScanClaimQrCode',
      );
      return;
    }

    if (!registry.contains(attendee)) {
      // this is important because the runtime checks if there are too many claims trying to be registered.
      RootSnackBar.showMsg(dic.encointer.meetupClaimantInvalid);
      Log.d(
        'Claimant: $attendee is not part of registry: $registry',
        'ScanClaimQrCode',
      );
    } else {
      String msg = store.encointer.communityAccount!.containsAttendee(attendee)
          ? dic.encointer.claimsScannedAlready
          : dic.encointer.claimsScannedNew;

      store.encointer.communityAccount!.addAttendee(attendee);
      RootSnackBar.showMsg(msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context)!.translationsForLocale();

    Future _onScan(String claimOrAddress) async {
      // Show a cupertino activity indicator as long as we are decoding
      _showActivityIndicatorOverlay(context);

      try {
        var address = await addressFromClaimOrAddress(claimOrAddress);

        validateAndStoreParticipant(context, address, dic);
      } catch (e, s) {
        Log.e('Error decoding claim: $e', 'ScanClaimQrCode', s);
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
              Log.d('[scanPage] Permission Status: ${snapshot.data}', 'ScanClaimQrCode');
              return permissionErrorDialog(context);
            }

            return Stack(
              children: [
                MobileScanner(
                    allowDuplicates: false,
                    onDetect: (barcode, args) {
                      if (barcode.rawValue == null) {
                        Log.e('Failed to scan Barcode', 'ScanClaimQrCode');
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
                                'SCANNED_COUNT', store.encointer.communityAccount!.scannedAttendeesCount.toString())
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

Widget permissionErrorDialog(BuildContext context) {
  final dic = I18n.of(context)!.translationsForLocale();

  return CupertinoAlertDialog(
    title: Container(),
    content: Text(dic.home.cameraPermissionError),
    actions: <Widget>[
      CupertinoButton(
        child: Text(dic.home.ok),
        onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
      ),
      CupertinoButton(
        child: Text(dic.home.appSettings),
        onPressed: () => openAppSettings(),
      ),
    ],
  );
}

/// For backwards compatibility wit phones pre-v1.8.9
Future<String> addressFromClaimOrAddress(String claimOrAddress) async {
  if (Fmt.isAddress(claimOrAddress)) {
    return Future.value(claimOrAddress);
  }

  var data = base64.decode(claimOrAddress);

  var claim =
      await webApi.codec.decodeBytes(ClaimOfAttendanceJSRegistryName, data).then((c) => ClaimOfAttendance.fromJson(c));

  return claim.claimantPublic!;
}
