import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/ceremonyRegisterButton.dart';
import 'package:encointer_wallet/service/ceremonyBoxService.dart';
import "package:latlong2/latlong.dart";

import 'ceremonyLocationButton.dart';
import 'ceremonyNotification.dart';
import 'ceremonyInfoAndCalendar.dart';
import 'ceremonyProgressBar.dart';
import 'ceremonySchedule.dart';
import 'ceremonyStartButton.dart';

class CeremonyBox extends StatelessWidget {
  final bool isRegistered = false;
  final int groupSizeAssigned = 9;
  final LatLng coordinatesOfCeremony = LatLng(47.389712, 8.517076);
  final DateTime registerUntilDate = DateTime.now().subtract(Duration(hours: 16));
  final DateTime nextCeremonyDate = DateTime.now().subtract(Duration(minutes: 15));
  final String notification = 'you are assigned bla bla bla bla bla asdf asdf sadf ';
  final IconData notificationIconData = Iconsax.tick_square;
  final Uri infoLink = Uri.http("example.org", "/path", {"q": "dart"});
  final Function onPressedRegister = () => print('TODO register for ceremony');
  final Function onPressedLocation = () => print('TODO show map');
  final Function onPressedStartCeremony = () => print('TODO start ceremony');

  @override
  Widget build(BuildContext context) {
    String languageCode = Localizations.localeOf(context).languageCode;
    CeremonyPhase currentPhase = CeremonyBoxService.getCurrentPhase(registerUntilDate, nextCeremonyDate);
    bool showRegisterButton = CeremonyBoxService.shouldShowRegisterButton(currentPhase, isRegistered);
    bool showStartCeremonyButton = CeremonyBoxService.shouldShowStartCeremonyButton(currentPhase, isRegistered);
    bool showTwoBoxes = !showRegisterButton && !showStartCeremonyButton;
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(15), bottom: Radius.circular(showTwoBoxes ? 0 : 15)),
            color: ZurichLion.shade50,
          ),
          child: Column(
            children: [
              CeremonyProgressBar(
                registerUntilDate: registerUntilDate,
                nextCeremonyDate: nextCeremonyDate,
                currentPhase: currentPhase,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CeremonySchedule(
                    nextCeremonyDate: nextCeremonyDate,
                    languageCode: languageCode,
                  ),
                  CeremonyInfoAndCalendar(
                    nextCeremonyDate: nextCeremonyDate,
                    infoLink: infoLink,
                  ),
                ],
              ),
              if (showRegisterButton)
                CeremonyRegisterButton(
                  languageCode: languageCode,
                  registerUntilDate: registerUntilDate,
                  onPressed: onPressedRegister,
                ),
              if (showStartCeremonyButton)
                CeremonyStartButton(
                  onPressed: onPressedStartCeremony,
                )
            ],
          ),
        ),
        if (showTwoBoxes) // dart "collection if"
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
    );
  }
}
