import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_qr_scan/flutter_qr_reader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/logo/participant_avatar.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:ew_log/ew_log.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:ew_l10n/l10n.dart';
import 'package:ew_keyring/ew_keyring.dart' show AddressUtils, Address;

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
    currentAddressPrefix42 = AddressUtils.pubKeyHexToAddress(store.account.currentAccountPubKey!);
    allParticipantsPrefix42 = store.encointer.communityAccount?.meetup?.registry ?? [];
    super.initState();
  }

  /// Checks that the `attendeeAddress` is not equal to self and part of the meetup registry.
  void validateAndStoreParticipant(AppStore store, String attendeeAddress, AppLocalizations l10n) {
    final attendeeAddressPrefix42 = Address.decode(attendeeAddress).encode(prefix: 42);

    if (attendeeAddressPrefix42 == currentAddressPrefix42) {
      RootSnackBar.showMsg(l10n.meetupClaimantEqualToSelf);
      Log.d('Claimant: $attendeeAddressPrefix42 is equal to self', 'ScanClaimQrCode');
    } else {
      if (!allParticipantsPrefix42.contains(attendeeAddressPrefix42)) {
        // this is important because the runtime checks if there are too many claims trying to be registered.
        RootSnackBar.showMsg(l10n.meetupClaimantInvalid);
        Log.d(
            'Claimant: $attendeeAddressPrefix42 is not part of registry: $allParticipantsPrefix42', 'ScanClaimQrCode');
      } else {
        final msg = store.encointer.communityAccount!.containsAttendee(attendeeAddressPrefix42)
            ? l10n.claimsScannedAlready
            : l10n.claimsScannedNew;

        store.encointer.communityAccount!.addAttendee(attendeeAddressPrefix42);
        RootSnackBar.showMsg(msg);
      }
    }
  }

  void onScan(AppStore store, AppLocalizations l10n, String address) {
    if (Fmt.isAddress(address)) {
      validateAndStoreParticipant(store, address, l10n);
    } else {
      Log.e('Claim is not an address: $address', 'ScanClaimQrCode');
      RootSnackBar.showMsg(l10n.claimsScannedDecodeFailed, durationMillis: 3000);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final store = context.watch<AppStore>();
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        actions: [
          IconButton(
            key: const Key(EWTestKeys.closeScanner),
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
                QrcodeReaderView(
                  onScan: (barcode, args) async {
                    if (barcode == null) {
                      Log.e('Failed to scan Barcode', 'ScanClaimQrCode');
                      return true;
                    } else {
                      onScan(context.read<AppStore>(), l10n, barcode);
                      return true;
                    }
                  },
                  helpWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Observer(builder: (_) {
                        final txt = l10n.claimsScannedNOfM(
                          store.encointer.communityAccount!.scannedAttendeesCount,
                          widget.confirmedParticipantsCount - 1,
                        );
                        return Text(
                          txt,
                          style: context.headlineLarge.copyWith(
                            color: Colors.white,
                            backgroundColor: Colors.black38,
                          ),
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
  final l10n = context.l10n;
  return CupertinoAlertDialog(
    title: Container(),
    content: Text(l10n.cameraPermissionError),
    actions: <Widget>[
      CupertinoButton(
        child: Text(l10n.ok),
        onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
      ),
      CupertinoButton(
        onPressed: openAppSettings,
        child: Text(l10n.appSettings),
      ),
    ],
  );
}
