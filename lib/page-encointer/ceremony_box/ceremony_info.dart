import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/components/ceremony_info_and_calendar.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/components/ceremony_progress_bar.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/components/ceremony_schedule.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class CeremonyInfo extends StatelessWidget {
  const CeremonyInfo({
    super.key,
    required this.currentTime,
    required this.assigningPhaseStart,
    required this.meetupTime,
    required this.ceremonyPhaseDurations,
    required this.meetupCompleted,
    this.devMode = false,
  });

  final int currentTime;
  final int? assigningPhaseStart;
  final int? meetupTime;
  final Map<CeremonyPhase, int> ceremonyPhaseDurations;
  final bool meetupCompleted;
  final bool devMode;

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final dic = I18n.of(context)!.translationsForLocale();

    final infoLink = ceremonyInfoLink(languageCode);

    return Container(
      child: meetupTime != null
          ? Column(
              children: [
                const SizedBox(height: 8),
                CeremonyProgressBar(
                  currentTime: currentTime,
                  assigningPhaseStart: assigningPhaseStart,
                  meetupTime: meetupTime,
                  ceremonyPhaseDurations: ceremonyPhaseDurations,
                  width: 262,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (!meetupCompleted)
                      CeremonySchedule(
                        nextCeremonyDate: DateTime.fromMillisecondsSinceEpoch(meetupTime!),
                        languageCode: languageCode,
                      )
                    else
                      Text(
                        dic.encointer.gatheringSuccessfullyCompleted,
                        style: Theme.of(context).textTheme.headline4!.copyWith(color: encointerBlack),
                      ),
                    CeremonyInfoAndCalendar(
                      nextCeremonyDate: DateTime.fromMillisecondsSinceEpoch(meetupTime!),
                      infoLink: infoLink,
                      devMode: devMode,
                    ),
                  ],
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CupertinoActivityIndicator(),
              ],
            ),
    );
  }
}
