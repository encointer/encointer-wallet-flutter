import 'package:encointer_wallet/config/consts.dart';
import 'package:flutter/material.dart';

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
    this.devMode = false,
  }) : super(key: key);

  final int currentTime;
  final int assigningPhaseStart;
  final int meetupTime;
  final Map<CeremonyPhase, int> ceremonyPhaseDurations;
  final bool devMode;

  @override
  Widget build(BuildContext context) {
    String languageCode = Localizations.localeOf(context).languageCode;

    final String infoLink = ceremonyInfoLink(languageCode);

    return Container(
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
                nextCeremonyDate: DateTime.fromMillisecondsSinceEpoch(meetupTime),
                languageCode: languageCode,
              ),
              CeremonyInfoAndCalendar(
                nextCeremonyDate: DateTime.fromMillisecondsSinceEpoch(meetupTime),
                infoLink: infoLink,
                devMode: devMode,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
