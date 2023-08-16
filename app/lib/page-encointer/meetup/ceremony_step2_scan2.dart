import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/common/components/qr_code_view/qr_code_image_view.dart';
import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/common/components/wake_lock_and_brightness_enhancer.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/common/components/logo/participant_avatar.dart';
import 'package:encointer_wallet/page-encointer/meetup/ceremony_progress_bar.dart';
import 'package:encointer_wallet/page-encointer/meetup/ceremony_step3_finish.dart';
import 'package:encointer_wallet/page-encointer/meetup/scan_claim_qr_code.dart';

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
    final l10n = context.l10n;
    final appSettingsStore = context.watch<AppSettings>();
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.keySigningCycle),
        actions: [
          UserMeetupAvatar(index: meetupIndexOfAccount(store.account.currentAccountPubKey!)),
          const SizedBox(width: 20)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(height: 24),
            const CeremonyProgressBar(progress: 2),
            const SizedBox(height: 38),
            Center(
              child: Text(
                l10n.scan,
                style: context.titleLarge.copyWith(color: context.colorScheme.primary),
              ),
            ),
            Center(
              child: Text(
                l10n.scanDescriptionForMeetup,
                textAlign: TextAlign.center,
                style: context.titleLarge.copyWith(height: 1.25),
              ),
            ),
            const SizedBox(height: 12),
            // Enhance brightness for the QR-code
            const WakeLockAndBrightnessEnhancer(brightness: 1),
            QrCodeImage(qrCode: claimantAddress),
            const SizedBox(height: 12),
            ElevatedButton(
              key: const Key(EWTestKeys.closeMeetup),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Iconsax.arrow_right_2),
                  const SizedBox(width: 12, height: 60),
                  Text(
                    l10n.closeGathering,
                    style: context.titleMedium.copyWith(color: context.colorScheme.primary),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(context, CupertinoPageRoute<void>(builder: (_) => CeremonyStep3Finish(store, api)));
              },
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Iconsax.scan_barcode),
                  const SizedBox(width: 12),
                  Text(
                    l10n.scanOthers,
                    style: context.titleMedium.copyWith(color: context.colorScheme.background),
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
            Observer(builder: (_) {
              if (appSettingsStore.developerMode) {
                return SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    key: const Key(EWTestKeys.attestAllParticipantsDev),
                    child: const Text('DEV ONLY: attest all participants'),
                    onPressed: () => attestAllParticipants(store, store.account.currentAddress),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
            const SizedBox(height: 12)
          ],
        ),
      ),
    );
  }

  int meetupIndexOfAccount(String accountPubKey) {
    final participants = store.encointer.communityAccount!.meetup!.registry;
    final address = Fmt.ss58Encode(accountPubKey);

    // the addresses of the meetup are encoded with the default prefix: 42.
    return participants.indexOf(address);
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
