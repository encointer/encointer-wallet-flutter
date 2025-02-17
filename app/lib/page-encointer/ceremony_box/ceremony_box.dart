import 'dart:async';

import 'package:encointer_wallet/service/tx/lib/src/error_notifications.dart';
import 'package:encointer_wallet/service/tx/lib/src/submit_to_inner.dart';
import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';

import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/ceremony_info.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/components/ceremony_register_button.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/components/ceremony_start_button.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/components/unregister_link_button.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/components/lower_ceremony_box_container.dart';
import 'package:encointer_wallet/models/communities/community_metadata.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/meetup_info/components/ceremony_notification.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/meetup_info/meetup_info.dart';
import 'package:encointer_wallet/page-encointer/meetup/ceremony_step1_count.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/tx/lib/tx.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class CeremonyBox extends StatelessWidget {
  const CeremonyBox(this.store, this.api, {super.key});

  final AppStore store;
  final Api api;

  @override
  Widget build(BuildContext context) {
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
            padding: EdgeInsets.fromLTRB(24, 24, 24, store.encointer.showMeetupInfo ? 12 : 24),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
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
                  communityRules: store.encointer.community?.metadata?.rules ?? CommunityRules.LoCo,
                ),
                if (store.encointer.showRegisterButton)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: CeremonyRegisterButton(
                        key: const Key(EWTestKeys.registrationMeetupButton),
                        registerUntil: assigningPhaseStart,
                        onPressed: (context) async {
                          if (store.dataUpdate.expired) {
                            await awaitDataUpdateWithDialog(context, store);
                          }
                          await submitRegisterParticipant(
                              context,
                              store,
                              api,
                              store.account.getKeyringAccount(store.account.currentAccountPubKey!),
                              store.encointer.chosenCid!,
                              txPaymentAsset: store.encointer.getTxPaymentAsset(store.encointer.chosenCid),
                              onError: (dispatchError) {
                            final message = getLocalizedTxErrorMessage(context.l10n, dispatchError);
                            showTxErrorDialog(context, message);
                          });
                        }),
                  ),
                if (store.encointer.showRestartCeremonyButton)
                  TextButton(
                    key: const Key(EWTestKeys.restartMeetup),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(builder: (context) => CeremonyStep1Count(store, api)),
                    ),
                    child: Text(
                      context.l10n.restartGathering,
                      style: context.bodyMedium
                          .copyWith(color: AppColors.encointerBlack, decoration: TextDecoration.underline),
                    ),
                  ),
                if (store.encointer.showStartCeremonyButton)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: CeremonyStartButton(
                      key: const Key(EWTestKeys.startMeetup),
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
                          Text(context.l10n.claimsSubmitN(store.encointer.communityAccount!.scannedAttendeesCount)),
                        ],
                      ),
                      onPressed: () => submitAttestAttendees(
                          context,
                          store,
                          api,
                          store.account.getKeyringAccount(store.account.currentAccountPubKey!),
                          store.encointer.chosenCid!,
                          txPaymentAsset: store.encointer.getTxPaymentAsset(store.encointer.chosenCid),
                          onError: (dispatchError) {
                        final message = getLocalizedTxErrorMessage(context.l10n, dispatchError);
                        showTxErrorDialog(context, message);
                      }),
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
  final l10n = context.l10n;
  final communityAccount = store.encointer.communityAccount;

  switch (store.encointer.currentPhase) {
    case CeremonyPhase.Registering:
      if (communityAccount?.isRegistered ?? false) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CeremonyNotification(
              key: const Key(EWTestKeys.isRegisteredInfo),
              notificationIconData: Iconsax.tick_square,
              notification: l10n.youAreRegisteredAs(
                store.encointer.communityAccount!.participantType!.toValue(),
              ),
            ),
            const SizedBox(height: 4),
            const UnregisteredLinkButton(),
          ],
        );
      } else {
        // showMeetupInfo == false in this case. So we don't show this widget at all.
        Log.d(
          "'getMeetupInfoWidget' trapped in an unexpected if statement: Registering phase + Unregistered",
          'CeremonyBox',
        );
        return const SizedBox.shrink();
      }
    case CeremonyPhase.Assigning:
      if (store.encointer.communityAccount?.isAssigned ?? false) {
        return _meetupInfo(context, store);
      } else {
        return CeremonyNotification(
          key: const Key(EWTestKeys.accountUnassigned),
          notificationIconData: Iconsax.close_square,
          notification: l10n.youAreNotRegisteredPleaseRegisterNextTime,
        );
      }
    case CeremonyPhase.Attesting:
      if (!(store.encointer.communityAccount?.isAssigned ?? false)) {
        return CeremonyNotification(
          notificationIconData: Iconsax.close_square,
          notification: l10n.youAreNotRegisteredPleaseRegisterNextTime,
        );
      } else {
        if (store.encointer.communityAccount?.meetupCompleted ?? false) {
          return CeremonyNotification(
            notificationIconData: Iconsax.tick_square,
            notification: l10n.successfullySentNAttestations(
              store.encointer.communityAccount!.scannedAttendeesCount,
            ),
          );
        } else {
          return _meetupInfo(context, store);
        }
      }
  }
}

Widget _meetupInfo(BuildContext context, AppStore store) {
  final meetup = store.encointer.communityAccount!.meetup!;
  final location = store.encointer.community!.meetupLocations![meetup.locationIndex];
  final rules = store.encointer.community!.metadata!.communityRules;
  final args = MeetupLocationArgs(location, meetup, rules);
  return MeetupInfo(
    meetup,
    location,
    key: const Key(EWTestKeys.accountAssigned),
    onPressed: () {
      Navigator.pushNamed(context, MeetupLocationPage.route, arguments: args);
    },
  );
}

Future<void> awaitDataUpdateWithDialog(BuildContext context, AppStore store) async {
  unawaited(showCupertinoDialog<void>(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: Text(context.l10n.updatingAppState),
      content: const CupertinoActivityIndicator(),
    ),
  ));

  await store.dataUpdate.executeUpdate().whenComplete(() => Navigator.of(context).pop());
}
