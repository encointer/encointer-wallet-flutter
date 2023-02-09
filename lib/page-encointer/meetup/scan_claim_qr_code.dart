import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:encointer_wallet/common/components/logo/participant_avatar.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';

class ScanClaimQrCode extends StatelessWidget {
  const ScanClaimQrCode(this.store, this.confirmedParticipantsCount, {super.key});

  final AppStore store;
  final int confirmedParticipantsCount;

  void validateAndStoreParticipant(BuildContext context, String attendee, Translations dic) {
    final registry = store.encointer.communityAccount!.meetup!.registry;

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
      final msg = store.encointer.communityAccount!.containsAttendee(attendee)
          ? dic.encointer.claimsScannedAlready
          : dic.encointer.claimsScannedNew;

      store.encointer.communityAccount!.addAttendee(attendee);
      RootSnackBar.showMsg(msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();

    Future onScan(String address) async {
      if (Fmt.isAddress(address)) {
        validateAndStoreParticipant(context, address, dic);
      } else {
        Log.e('Claim is not an address: $address', 'ScanClaimQrCode');
        RootSnackBar.showMsg(dic.encointer.claimsScannedDecodeFailed, durationMillis: 3000);
      }
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
                MobileScanner(onDetect: (barcode, args) {
                  if (barcode.rawValue == null) {
                    Log.e('Failed to scan Barcode', 'ScanClaimQrCode');
                  } else {
                    onScan(barcode.rawValue!);
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
                          border: Border.all(color: Colors.white38, width: 2),
                          borderRadius: const BorderRadius.all(Radius.circular(24)),
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
                        return Text(
                          txt,
                          style: const TextStyle(color: Colors.white, backgroundColor: Colors.black38, fontSize: 16),
                        );
                      }),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: List.generate(
                          confirmedParticipantsCount,
                          (index) => ParticipantAvatar(index: index, isActive: index < 4),
                        ),
                      ),
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
        onPressed: openAppSettings,
        child: Text(dic.home.appSettings),
      ),
    ],
  );
}
