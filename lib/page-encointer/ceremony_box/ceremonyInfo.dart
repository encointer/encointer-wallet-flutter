import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../models/index.dart';
import 'components/ceremonyInfoAndCalendar.dart';
import 'components/ceremonyProgressBar.dart';
import 'components/ceremonySchedule.dart';

class CeremonyInfo extends StatelessWidget {
  CeremonyInfo({
    Key key,
    this.currentTime,
    this.assigningPhaseStart,
    this.meetupTime,
    this.ceremonyPhaseDurations,
  }) : super(key: key);

  final int currentTime;
  final int assigningPhaseStart;
  final int meetupTime;
  final Map<CeremonyPhase, int> ceremonyPhaseDurations;

  @override
  Widget build(BuildContext context) {
    final Uri infoLink = Uri.http("example.org", "/path", {"q": "dart"});

    String languageCode = Localizations.localeOf(context).languageCode;
    return Observer(
      builder: (BuildContext context) => Container(
        padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Column(
          children: [
            SizedBox(height: 8),
            CeremonyProgressBar(
              currentTime: currentTime,
              assigningPhaseStart: assigningPhaseStart,
              meetupTime: meetupTime,
              ceremonyPhaseDurations: ceremonyPhaseDurations,
              width: 262,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CeremonySchedule(
                  nextCeremonyDate: new DateTime(meetupTime),
                  languageCode: languageCode,
                ),
                CeremonyInfoAndCalendar(
                  nextCeremonyDate: new DateTime(meetupTime),
                  infoLink: infoLink,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
