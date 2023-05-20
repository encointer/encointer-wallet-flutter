import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/logo/participant_avatar.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';

class ScanClaimQrCode extends StatefulWidget {
  const ScanClaimQrCode(this.confirmedParticipantsCount, {super.key});

  final int confirmedParticipantsCount;

  @override
  State<ScanClaimQrCode> createState() => _ScanClaimQrCodeState();
}

class _ScanClaimQrCodeState extends State<ScanClaimQrCode> {
  late final List<String> allParticipantsPrefix42;
  late final String currentAddressPrefix42;

  @override
  void initState() {
    final store = context.read<AppStore>();
    currentAddressPrefix42 = Fmt.ss58Encode(store.account.currentAccountPubKey!);
    allParticipantsPrefix42 = store.encointer.communityAccount?.meetup?.registry ?? [];
    super.initState();
  }

  /// Checks that the `attendeeAddress` is not equal to self and part of the meetup registry.
  void validateAndStoreParticipant(AppStore store, String attendeeAddress, Translations dic) {
    final attendeePubKey = Fmt.ss58Decode(attendeeAddress).pubKey;
    final attendeeAddressPrefix42 = Fmt.ss58Encode(attendeePubKey);

    if (attendeeAddressPrefix42 == currentAddressPrefix42) {
      RootSnackBar.showMsg(dic.encointer.meetupClaimantEqualToSelf);
      Log.d('Claimant: $attendeeAddressPrefix42 is equal to self', 'ScanClaimQrCode');
    } else {
      if (!allParticipantsPrefix42.contains(attendeeAddressPrefix42)) {
        // this is important because the runtime checks if there are too many claims trying to be registered.
        RootSnackBar.showMsg(dic.encointer.meetupClaimantInvalid);
        Log.d(
            'Claimant: $attendeeAddressPrefix42 is not part of registry: $allParticipantsPrefix42', 'ScanClaimQrCode');
      } else {
        final msg = store.encointer.communityAccount!.containsAttendee(attendeeAddressPrefix42)
            ? dic.encointer.claimsScannedAlready
            : dic.encointer.claimsScannedNew;

        store.encointer.communityAccount!.addAttendee(attendeeAddressPrefix42);
        RootSnackBar.showMsg(msg);
      }
    }
  }

  Future<void> onScan(AppStore store, Translations dic, String address) async {
    if (Fmt.isAddress(address)) {
      validateAndStoreParticipant(store, address, dic);
    } else {
      Log.e('Claim is not an address: $address', 'ScanClaimQrCode');
      RootSnackBar.showMsg(dic.encointer.claimsScannedDecodeFailed, durationMillis: 3000);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final store = context.watch<AppStore>();
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
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
                MobileScanner(onDetect: (barcode, args) async {
                  if (barcode.rawValue == null) {
                    Log.e('Failed to scan Barcode', 'ScanClaimQrCode');
                  } else {
                    await onScan(context.read<AppStore>(), dic, barcode.rawValue!);
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
                              (widget.confirmedParticipantsCount - 1).toString(),
                            );
                        return Text(
                          txt,
                          style: const TextStyle(color: Colors.white, backgroundColor: Colors.black38, fontSize: 16),
                        );
                      }),
                      const SizedBox(height: 10),
                      Observer(builder: (_) {
                        return Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          alignment: WrapAlignment.center,
                          children: List.generate(
                            allParticipantsPrefix42.length,
                            (index) {
                              if (allParticipantsPrefix42[index] == currentAddressPrefix42) {
                                return const SizedBox.shrink();
                              } else if (store.encointer.communityAccount!.attendees!
                                  .contains(allParticipantsPrefix42[index])) {
                                return ParticipantAvatar(index: index, isActive: true);
                              } else {
                                return ParticipantAvatar(index: index);
                              }
                            },
                          ),
                        );
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

Future<PermissionStatus> canOpenCamera() {
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
