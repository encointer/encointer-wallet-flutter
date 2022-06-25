import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/page-encointer/common/encointerMap.dart';
import 'package:encointer_wallet/page-encointer/meetup/ceremonyStep1Count.dart';
import 'package:encointer_wallet/service/encointer_feed/feed.dart' as feed;
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/tx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';

import 'ceremonyInfo.dart';
import 'components/ceremonyRegisterButton.dart';
import 'components/ceremonyStartButton.dart';
import 'components/lowerCeremonyBoxContainer.dart';
import 'meetup_info/components/ceremonyNotification.dart';
import 'meetup_info/meetupInfo.dart';

class CeremonyBox extends StatefulWidget {
  CeremonyBox(
    this.store,
    this.api, {
    Key key,
  }) : super(key: key);

  final AppStore store;
  final Api api;

  @override
  _CeremonyBoxState createState() => _CeremonyBoxState(store, api);
}

class _CeremonyBoxState extends State<CeremonyBox> {
  _CeremonyBoxState(this.store, this.api);

  final AppStore store;
  final Api api;

  DateTime meetupTimeOverride;

  @override
  void initState() {
    super.initState();
    getMeetupOverride();
  }

  Future<void> getMeetupOverride() async {
    final overrides = await feed.getMeetupOverrides();

    final networkOverride = overrides.firstWhere(
      (o) => o.network == store.encointer.network,
      orElse: () => null,
    );

    if (networkOverride == null) {
      return Future.value(null);
    }

    if (networkOverride.communities.contains(store.encointer.chosenCid.toFmtString())) {
      meetupTimeOverride = networkOverride.getNextMeetupTime(DateTime.now(), store.encointer.currentPhase);
    }
  }

  @override
  Widget build(BuildContext context) {
    var dic = I18n.of(context).translationsForLocale();

    return Observer(builder: (BuildContext context) {
      int meetupTime = meetupTimeOverride?.millisecondsSinceEpoch ??
          store.encointer?.community?.meetupTime ??
          store.encointer.attestingPhaseStart;

      return Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(15), bottom: Radius.circular(store.encointer.showMeetupInfo ? 0 : 15)),
              color: ZurichLion.shade50,
            ),
            child: Column(
              children: [
                CeremonyInfo(
                  currentTime: DateTime.now().millisecondsSinceEpoch,
                  assigningPhaseStart: store.encointer?.assigningPhaseStart,
                  meetupTime: meetupTime,
                  ceremonyPhaseDurations: store.encointer.phaseDurations,
                  meetupCompleted: store.encointer?.communityAccount?.meetupCompleted,
                  devMode: store.settings.developerMode,
                ),
                if (store.encointer.showRegisterButton)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: CeremonyRegisterButton(
                      registerUntil: store.encointer?.assigningPhaseStart,
                      onPressed: (context) => submitRegisterParticipant(context, store, api),
                    ),
                  ),
                if (store.encointer.showStartCeremonyButton)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: CeremonyStartButton(
                      key: Key('start-meetup'),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
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
                          Icon(Iconsax.login_1),
                          SizedBox(width: 6),
                          Text(
                              '${dic.encointer.claimsSubmitN.replaceAll('N_COUNT', store.encointer.communityAccount.scannedClaimsCount.toString())}'),
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
  final dic = I18n.of(context).translationsForLocale();
  final communityAccount = store.encointer.communityAccount;

  switch (store.encointer.currentPhase) {
    case CeremonyPhase.Registering:
      if (communityAccount?.isRegistered ?? false) {
        return CeremonyNotification(
          notificationIconData: Iconsax.tick_square,
          notification: dic.encointer.youAreRegisteredAs.replaceAll(
            'PARTICIPANT_TYPE',
            store.encointer?.communityAccount?.participantType?.toValue(),
          ),
        );
      } else {
        // showMeetupInfo == false in this case. So we don't show this widget at all.
        _log("'getMeetupInfoWidget' trapped in an unexpected if statement: Registering phase + Unregistered");
        return Container();
      }
      break;
    case CeremonyPhase.Assigning:
      if (store.encointer.communityAccount?.isAssigned ?? false) {
        var meetup = store.encointer.communityAccount.meetup;
        var location = store.encointer.community.meetupLocations[meetup.locationIndex];
        return MeetupInfo(
          meetup,
          location,
          onLocationPressed: () => showOnEncointerMap(context, store, location),
        );
      } else {
        return CeremonyNotification(
          notificationIconData: Iconsax.close_square,
          notification: dic.encointer.youAreNotRegisteredPleaseRegisterNextTime,
        );
      }
      break;
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
                .replaceAll('P_COUNT', store.encointer.communityAccount?.scannedClaimsCount.toString()),
          );
        } else {
          var meetup = store.encointer.communityAccount.meetup;
          var location = store.encointer.community.meetupLocations[meetup.locationIndex];
          return MeetupInfo(
            meetup,
            location,
            onLocationPressed: () => showOnEncointerMap(context, store, location),
          );
        }
      }
      break;
    default:
      _log("'getMeetupInfoWidget' trapped in an unexpected default case");
      return Container();
  }
}

void _log(String msg) {
  print("[CeremonyBox] $msg");
}
