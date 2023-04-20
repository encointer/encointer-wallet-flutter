import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/qr_code_view/qr_code_image_view.dart';
import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/common/components/wake_lock_and_brightness_enhancer.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/common/components/logo/participant_avatar.dart';
import 'package:encointer_wallet/page-encointer/meetup/ceremony_progress_bar.dart';
import 'package:encointer_wallet/page-encointer/meetup/ceremony_step3_finish.dart';
import 'package:encointer_wallet/page-encointer/meetup/scan_claim_qr_code.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class CeremonyStep2Scan extends StatelessWidget {
  const CeremonyStep2Scan(
    this.store,
    this.api, {
    required this.claimantAddress,
    required this.confirmedParticipantsCount,
    super.key,
  });

  final AppStore store;
  final Api api;
  final String claimantAddress;
  final int confirmedParticipantsCount;

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final appSettingsStore = context.watch<AppSettings>();
    return Scaffold(
      appBar: AppBar(
        title: Text(dic.encointer.keySigningCycle),
        actions: [
          UserMeetupAvatar(index: getCurrentAccountIndex()),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: CeremonyProgressBar(progress: 2),
          ),
          const SizedBox(height: 38),
          Center(
            child: Text(
              dic.encointer.scan,
              style: context.textTheme.displayMedium,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                dic.encointer.scanDescriptionForMeetup,
                textAlign: TextAlign.center,
                style: context.textTheme.displayMedium!.copyWith(color: Colors.black, height: 1.25),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Enhance brightness for the QR-code
          const WakeLockAndBrightnessEnhancer(brightness: 1),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                QrCodeImage(qrCode: claimantAddress),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ElevatedButton(
              key: const Key('close-meetup'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Iconsax.arrow_right_2),
                  const SizedBox(width: 12, height: 60),
                  Text(dic.encointer.closeGathering, style: context.textTheme.displaySmall),
                ],
              ),
              onPressed: () {
                Navigator.push(context, CupertinoPageRoute<void>(builder: (_) => CeremonyStep3Finish(store, api)));
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
                    style: context.textTheme.displaySmall,
                  ),
                ],
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => ScanClaimQrCode(confirmedParticipantsCount),
                  ),
                );
              },
            ),
          ),
          if (appSettingsStore.developerMode)
            SizedBox(
              height: 40,
              child: ElevatedButton(
                key: const Key('attest-all-participants-dev'),
                child: const Text('DEV ONLY: attest all participants'),
                onPressed: () => attestAllParticipants(store, store.account.currentAddress),
              ),
            ),
          const SizedBox(height: 12)
        ],
      ),
    );
  }

  int getCurrentAccountIndex() {
    final currentAddress = store.account.currentAddress;
    final participiants = store.encointer.communityAccount!.meetup!.registry;
    return participiants.indexOf(currentAddress);
  }
}

/// Attest all assigned meetup participants.
///
/// Only intended for development purposes.
void attestAllParticipants(AppStore store, String claimantAddress) {
  final registry = store.encointer.communityAccount!.meetup!.registry;
  for (final attendee in registry) {
    if (attendee != claimantAddress) store.encointer.communityAccount!.addAttendee(attendee);
  }

  RootSnackBar.showMsg('Added all meetup participants to attendees');
}
