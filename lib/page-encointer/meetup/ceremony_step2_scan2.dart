import 'dart:convert';
import 'dart:typed_data';

import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qr_flutter_fork/qr_flutter_fork.dart';

import 'package:encointer_wallet/common/components/gr_code_view/gr_code_image_view.dart';
import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/common/components/wake_lock_and_brightness_enhancer.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/meetup/ceremony_progress_bar.dart';
import 'package:encointer_wallet/page-encointer/meetup/ceremony_step3_finish.dart';
import 'package:encointer_wallet/page-encointer/meetup/scan_claim_qr_code.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class CeremonyStep2Scan extends StatelessWidget {
  const CeremonyStep2Scan(
    this.store,
    this.api, {
    required this.claim,
    required this.confirmedParticipantsCount,
    Key? key,
  }) : super(key: key);

  final AppStore store;
  final Api api;

  final Future<Uint8List> claim;
  final int confirmedParticipantsCount;

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(dic.encointer.keySigningCycle),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(height: 24),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: CeremonyProgressBar(progress: 2),
                  ),
                  const SizedBox(height: 48),
                  Center(
                    child: Text(
                      dic.encointer.scan,
                      style: Theme.of(context).textTheme.headline2!.copyWith(color: ZurichLion.shade600),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        dic.encointer.scanDescriptionForMeetup,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.black, height: 1.25),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Enhance brightness for the QR-code
                  const WakeLockAndBrightnessEnhancer(brightness: 1),
                  FutureBuilder<Uint8List>(
                    future: claim,
                    builder: (_, AsyncSnapshot<Uint8List> snapshot) {
                      if (snapshot.hasData) {
                        return QrCodeImage(
                          qrCode: base64.encode(snapshot.data!),
                          errorCorrectionLevel: QrErrorCorrectLevel.L,
                        );
                      } else {
                        return const CupertinoActivityIndicator();
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Iconsax.arrow_right_2),
                    const SizedBox(width: 12, height: 60),
                    Text(dic.encointer.closeGathering, style: Theme.of(context).textTheme.headline3),
                  ],
                ),
                onPressed: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (_) => CeremonyStep3Finish(store, api)));
                },
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: PrimaryButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Iconsax.scan_barcode),
                    const SizedBox(width: 12),
                    Text(
                      dic.encointer.scanOthers,
                      style: Theme.of(context).textTheme.headline3!.copyWith(color: ZurichLion.shade50),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ScanClaimQrCode(store, confirmedParticipantsCount),
                    ),
                  );
                },
              ),
            ),
            store.settings.developerMode
                ? ElevatedButton(
                    child: const Text('DEV ONLY: attest all participants'),
                    onPressed: () => attestAllParticipants(store, store.account.currentAddress),
                  )
                : Container(),
            const SizedBox(height: 12)
          ],
        ),
      ),
    );
  }
}

/// Attest all assigned meetup participants.
///
/// Only intended for development purposes.
void attestAllParticipants(AppStore store, String claimantAddress) {
  List<String> registry = store.encointer.communityAccount!.meetup!.registry;

  registry.removeWhere((a) => a == claimantAddress);
  registry.forEach((attendee) => store.encointer.communityAccount!.addAttendee(attendee));

  RootSnackBar.showMsg('Added all meetup participants to attendees');
}
