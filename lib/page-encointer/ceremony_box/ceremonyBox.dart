import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';

import 'ceremonyInfo.dart';
import 'components/ceremonyLocationButton.dart';
import 'components/ceremonyNotification.dart';
import 'components/ceremonyRegisterButton.dart';
import 'components/ceremonyStartButton.dart';

class CeremonyBox extends StatelessWidget {
  final AppStore store;
  final int groupSizeAssigned = 9;
  final DateTime registerUntilDate = DateTime.now().subtract(Duration(hours: 1));
  final String notification = 'you are assigned bla bla bla bla bla asdf asdf sadf ';
  final IconData notificationIconData = Iconsax.tick_square;
  final Function onPressedRegister = () => print('TODO register for ceremony');
  final Function onPressedLocation = () => print('TODO show map');
  final Function onPressedStartCeremony = () => print('TODO start ceremony');

  CeremonyBox({Key key, this.store}) : super(key: key);

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
                  meetupTime: store.encointer?.community?.meetupTime ?? store.encointer.attestingPhaseStart ?? 0,
                  ceremonyPhaseDurations: store.encointer.phaseDurations,
                  devMode: store.settings.developerMode,
                ),
                if (store.settings.developerMode && store.encointer.showRegisterButton)
                  CeremonyRegisterButton(
                    languageCode: languageCode,
                    registerUntilDate: registerUntilDate,
                    onPressed: onPressedRegister,
                  ),
                if (store.settings.developerMode && store.encointer.showStartCeremonyButton)
                  CeremonyStartButton(
                    onPressed: onPressedStartCeremony,
                  )
              ],
            ),
          ),
          if (store.settings.developerMode && store.encointer.showTwoBoxes) // dart "collection if"
            Container(
              margin: EdgeInsets.only(top: 2),
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(0), bottom: Radius.circular(15)),
                color: ZurichLion.shade50,
              ),
              child: Column(
                children: [
                  CeremonyNotification(
                    notificationIconData: notificationIconData,
                    notification: notification,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  if (onPressedLocation != null)
                    CeremonyLocationButton(
                      onPressedLocation: onPressedLocation,
                    )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
