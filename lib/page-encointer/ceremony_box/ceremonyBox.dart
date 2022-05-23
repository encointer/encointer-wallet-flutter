import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/common/encointerMap.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/tx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'ceremonyInfo.dart';
import 'components/ceremonyRegisterButton.dart';
import 'components/ceremonyStartButton.dart';
import 'meetup_info/meetupInfo.dart';

class CeremonyBox extends StatelessWidget {
  CeremonyBox(
    this.store,
    this.api, {
    Key key,
  }) : super(key: key);

  final AppStore store;
  final Api api;
  final Function onPressedStartCeremony = () => print('TODO start ceremony');

  @override
  Widget build(BuildContext context) {
    String languageCode = Localizations.localeOf(context).languageCode;

    return Observer(
      builder: (BuildContext context) => Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(15), bottom: Radius.circular(store.encointer.showTwoBoxes ? 0 : 15)),
              color: ZurichLion.shade50,
            ),
            child: Column(
              children: [
                CeremonyInfo(
                  currentTime: DateTime.now().millisecondsSinceEpoch,
                  assigningPhaseStart: store.encointer?.assigningPhaseStart,
                  meetupTime: store.encointer?.community?.meetupTime ?? store.encointer.attestingPhaseStart,
                  ceremonyPhaseDurations: store.encointer.phaseDurations,
                  devMode: store.settings.developerMode,
                ),
                SizedBox(height: 12),
                if (store.encointer.showRegisterButton)
                  CeremonyRegisterButton(
                    languageCode: languageCode,
                    registerUntil: store.encointer?.assigningPhaseStart,
                    onPressed: (context) => submitRegisterParticipant(context, store, api),
                  ),
                if (store.settings.developerMode && store.encointer.showStartCeremonyButton)
                  CeremonyStartButton(
                    onPressed: onPressedStartCeremony,
                  )
              ],
            ),
          ),
          if (store.encointer.showTwoBoxes) getMeetupInfoWidget(context, store)
        ],
      ),
    );
  }
}

Widget getMeetupInfoWidget(BuildContext context, AppStore store) {
  if (store.encointer.communityAccount?.isAssigned ?? false) {
    var meetup = store.encointer.communityAccount.meetup;
    var location = store.encointer.community.meetupLocations[meetup.locationIndex];
    return MeetupInfo(
      meetup,
      location,
      onLocationPressed: () => showOnEncointerMap(context, store, location),
    );
  } else {
    return Text("Replace me with meetupInfo unassigned");
  }
}
