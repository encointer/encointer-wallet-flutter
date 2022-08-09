import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/index.dart';
import 'components/ceremony_info_and_calendar.dart';
import 'components/ceremony_progress_bar.dart';
import 'components/ceremony_schedule.dart';

class CeremonyInfo extends StatelessWidget {
  CeremonyInfo({
    Key? key,
    required this.currentTime,
    required this.assigningPhaseStart,
    required this.meetupTime,
    required this.ceremonyPhaseDurations,
    required this.meetupCompleted,
    this.devMode = false,
  }) : super(key: key);

  final int currentTime;
  final int? assigningPhaseStart;
  final int? meetupTime;
  final Map<CeremonyPhase, int> ceremonyPhaseDurations;
  final bool meetupCompleted;
  final bool devMode;

  @override
  Widget build(BuildContext context) {
    String languageCode = Localizations.localeOf(context).languageCode;
    var dic = I18n.of(context)!.translationsForLocale();

    final String infoLink = ceremonyInfoLink(languageCode);

    return Container(
      child: meetupTime != null
          ? Column(
              children: [
                SizedBox(height: 8),
                CeremonyProgressBar(
                  currentTime: currentTime,
                  assigningPhaseStart: assigningPhaseStart,
                  meetupTime: meetupTime,
                  ceremonyPhaseDurations: ceremonyPhaseDurations,
                  width: 262,
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    !meetupCompleted
                        ? CeremonySchedule(
                            nextCeremonyDate: DateTime.fromMillisecondsSinceEpoch(meetupTime!),
                            languageCode: languageCode,
                          )
                        : Text(
                            dic.encointer.ceremonySuccessfullyCompleted,
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
              children: [
                CupertinoActivityIndicator(),
              ],
            ),
    );
  }
}
