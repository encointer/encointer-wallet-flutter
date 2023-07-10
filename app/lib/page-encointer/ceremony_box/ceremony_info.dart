import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/components/ceremony_info_and_calendar.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/components/ceremony_progress_bar.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/components/ceremony_schedule.dart';
import 'package:encointer_wallet/service/launch/app_launch.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class CeremonyInfo extends StatelessWidget {
  const CeremonyInfo({
    super.key,
    required this.currentTime,
    required this.assigningPhaseStart,
    required this.meetupTime,
    required this.ceremonyPhaseDurations,
    required this.meetupCompleted,
  });

  final int currentTime;
  final int? assigningPhaseStart;
  final int? meetupTime;
  final Map<CeremonyPhase, int> ceremonyPhaseDurations;
  final bool meetupCompleted;

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
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
                        context.l10n.gatheringSuccessfullyCompleted,
                        style: context.titleMedium.copyWith(color: AppColors.encointerBlack),
                      ),
                    CeremonyInfoAndCalendar(
                      nextCeremonyDate: DateTime.fromMillisecondsSinceEpoch(meetupTime!),
                      onInfoPressed: () async {
                        final infoLink = ceremonyInfoLink(
                          languageCode,
                          context.read<AppStore>().encointer.community?.cid.toFmtString() ?? '',
                        );
                        await AppLaunch.launchURL(infoLink);
                      },
                    ),
                  ],
                ),
              ],
            )
          : const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoActivityIndicator(),
              ],
            ),
    );
  }
}
