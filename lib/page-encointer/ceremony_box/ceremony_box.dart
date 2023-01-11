import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';

import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/ceremony_info.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/components/ceremony_register_button.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/components/ceremony_start_button.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/components/lower_ceremony_box_container.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/meetup_info/components/ceremony_notification.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/meetup_info/meetup_info.dart';
import 'package:encointer_wallet/page-encointer/meetup/ceremony_step1_count.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/tx/lib/tx.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class CeremonyBox extends StatelessWidget {
  const CeremonyBox(this.store, this.api, {super.key});

  final AppStore store;
  final Api api;

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();

    return Observer(builder: (BuildContext context) {
      final meetupTime = store.encointer.community?.meetupTimeOverride ??
          store.encointer.community?.meetupTime ??
          store.encointer.attestingPhaseStart;

      // I decided to not introduce anymore degrees of freedom for the demo overrides, otherwise
      // we want to do too much again. So I hardcode the assigning phase duration to 30 minutes
      // if we have meetup time overrides. Before we do something more complex here, I want to
      // think some more, of what we want to do with the feed in the future.
      final assigningPhaseStart = store.encointer.community?.meetupTimeOverride != null
          ? store.encointer.community!.meetupTimeOverride! - const Duration(minutes: 30).inMilliseconds
          : store.encointer.assigningPhaseStart;

      return Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            decoration: BoxDecoration(
              color: zurichLion.shade50,
              borderRadius: BorderRadius.vertical(
                top: const Radius.circular(15),
                bottom: Radius.circular(store.encointer.showMeetupInfo ? 0 : 15),
              ),
            ),
            child: Column(
              children: [
                CeremonyInfo(
                  currentTime: DateTime.now().millisecondsSinceEpoch,
                  assigningPhaseStart: assigningPhaseStart,
                  meetupTime: meetupTime,
                  ceremonyPhaseDurations: store.encointer.phaseDurations,
                  meetupCompleted: store.encointer.communityAccount?.meetupCompleted ?? false,
                  devMode: store.settings.developerMode,
                ),
                if (store.encointer.showRegisterButton)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: CeremonyRegisterButton(
                        key: const Key('registration-meetup-button'),
                        registerUntil: assigningPhaseStart,
                        onPressed: (context) async {
                          if (store.dataUpdate.expired) {
                            await awaitDataUpdateWithDialog(context, store);
                          }
                          await submitRegisterParticipant(context, store, api);
                        }),
                  ),
                if (store.encointer.showStartCeremonyButton)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: CeremonyStartButton(
                      key: const Key('start-meetup'),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) => CeremonyStep1Count(store, api),
                        ),
                      ),
                    ),
                  ),
                if (store.encointer.showSubmitClaimsButton)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: PrimaryButton(
                      // todo: this will be removed because we do it automatically
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Iconsax.login_1),
                          const SizedBox(width: 6),
                          Text(
                            dic.encointer.claimsSubmitN.replaceAll(
                              'N_COUNT',
                              store.encointer.communityAccount!.scannedAttendeesCount.toString(),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () => submitAttestClaims(context, store, api),
                    ),
                  )
              ],
            ),
          ),
          if (store.encointer.showMeetupInfo)
            LowerCeremonyBoxContainer(
              child: getMeetupInfoWidget(context, store),
            )
        ],
      );
    });
  }
}

Widget getMeetupInfoWidget(BuildContext context, AppStore store) {
  final dic = I18n.of(context)!.translationsForLocale();
  final communityAccount = store.encointer.communityAccount;

  switch (store.encointer.currentPhase) {
    case CeremonyPhase.Registering:
      if (communityAccount?.isRegistered ?? false) {
        return CeremonyNotification(
          key: const Key('is-registered-info'),
          notificationIconData: Iconsax.tick_square,
          notification: dic.encointer.youAreRegisteredAs.replaceAll(
            'PARTICIPANT_TYPE',
            store.encointer.communityAccount!.participantType!.toValue(),
          ),
        );
      } else {
        // showMeetupInfo == false in this case. So we don't show this widget at all.
        Log.d(
          "'getMeetupInfoWidget' trapped in an unexpected if statement: Registering phase + Unregistered",
          'CeremonyBox',
        );
        return Container();
      }
    case CeremonyPhase.Assigning:
      if (store.encointer.communityAccount?.isAssigned ?? false) {
        final meetup = store.encointer.communityAccount!.meetup!;
        final location = store.encointer.community!.meetupLocations![meetup.locationIndex];
        return MeetupInfo(meetup, location);
      } else {
        return CeremonyNotification(
          notificationIconData: Iconsax.close_square,
          notification: dic.encointer.youAreNotRegisteredPleaseRegisterNextTime,
        );
      }
    case CeremonyPhase.Attesting:
      if (!(store.encointer.communityAccount?.isAssigned ?? false)) {
        return CeremonyNotification(
          notificationIconData: Iconsax.close_square,
          notification: dic.encointer.youAreNotRegisteredPleaseRegisterNextTime,
        );
      } else {
        if (store.encointer.communityAccount?.meetupCompleted ?? false) {
          return CeremonyNotification(
            notificationIconData: Iconsax.tick_square,
            notification: dic.encointer.successfullySentNAttestations
                .replaceAll('P_COUNT', store.encointer.communityAccount!.scannedAttendeesCount.toString()),
          );
        } else {
          final meetup = store.encointer.communityAccount!.meetup!;
          final location = store.encointer.community!.meetupLocations![meetup.locationIndex];
          return MeetupInfo(meetup, location);
        }
      }
    default:
      Log.d("'getMeetupInfoWidget' trapped in an unexpected default case", 'CeremonyBox');
      return Container();
  }
}

Future<void> awaitDataUpdateWithDialog(BuildContext context, AppStore store) async {
  showCupertinoDialog<void>(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: Text(I18n.of(context)!.translationsForLocale().home.updatingAppState),
      content: const CupertinoActivityIndicator(),
    ),
  );

  await store.dataUpdate.executeUpdate().whenComplete(() => Navigator.of(context).pop());
}
