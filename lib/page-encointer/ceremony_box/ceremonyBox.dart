import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';
import "package:latlong2/latlong.dart";

import '../../models/index.dart';
import 'ceremonyInfo.dart';
import 'components/ceremonyLocationButton.dart';
import 'components/ceremonyNotification.dart';
import 'components/ceremonyRegisterButton.dart';
import 'components/ceremonyStartButton.dart';

class CeremonyBox extends StatelessWidget {
  final AppStore store;
  final int groupSizeAssigned = 9;
  final LatLng coordinatesOfCeremony = LatLng(47.389712, 8.517076);
  final DateTime registerUntilDate = DateTime.now().subtract(Duration(hours: 1));
  final DateTime nextCeremonyDate = DateTime.now().subtract(Duration(minutes: 15));
  final String notification = 'you are assigned bla bla bla bla bla asdf asdf sadf ';
  final IconData notificationIconData = Iconsax.tick_square;
  final Uri infoLink = Uri.http("example.org", "/path", {"q": "dart"});
  final Function onPressedRegister = () => print('TODO register for ceremony');
  final Function onPressedLocation = () => print('TODO show map');
  final Function onPressedStartCeremony = () => print('TODO start ceremony');

  CeremonyBox({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String languageCode = Localizations.localeOf(context).languageCode;

    final ceremonyPhaseDurations = Map<CeremonyPhase, int>.of({
      CeremonyPhase.Registering: 30,
      CeremonyPhase.Assigning: 5,
      CeremonyPhase.Attesting: 10,
    });

    return Observer(
      builder: (BuildContext context) => Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(15), bottom: Radius.circular(store.encointer.showTwoBoxes ? 0 : 15)),
              color: ZurichLion.shade50,
            ),
            child: Column(
              children: [
                Text(
                  "This box is only the skeleton. It has no features.", // this text will be removed
                  style: TextStyle(color: Colors.orange),
                ),
                SizedBox(height: 8),
                CeremonyInfo(
                  currentTime: 34,
                  assigningPhaseStart: 35,
                  meetupTime: 40,
                  ceremonyPhaseDurations: ceremonyPhaseDurations,
                ),
                if (store.encointer.showRegisterButton)
                  CeremonyRegisterButton(
                    languageCode: languageCode,
                    registerUntilDate: registerUntilDate,
                    onPressed: onPressedRegister,
                  ),
                if (store.encointer.showStartCeremonyButton)
                  CeremonyStartButton(
                    onPressed: onPressedStartCeremony,
                  )
              ],
            ),
          ),
          if (store.encointer.showTwoBoxes) // dart "collection if"
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
