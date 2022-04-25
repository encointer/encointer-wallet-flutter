import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/ceremonyBoxService.dart';
import 'package:flutter/material.dart';

import '../../../models/index.dart';

/// This bar shows the progress in the meetup cycle, it visualizes the overall progress
/// and indicates the three phases.
///
/// progressElapsed + progressAhead = widthOfTheWholeBar, these are flex
/// factors (integers) to draw the progress in the right proportions,
/// automatically adapting to screen width
class CeremonyProgressBar extends StatelessWidget {
  const CeremonyProgressBar({
    @required this.currentTime,
    @required this.assigningPhaseStart,
    @required this.meetupTime,
    @required this.ceremonyPhaseDurations,
    @required this.width,
    Key key,
  }) : super(key: key);

  final int currentTime;
  final int assigningPhaseStart;
  final int meetupTime;
  final Map<CeremonyPhase, int> ceremonyPhaseDurations;

  final double width;

  final int phase1register = 70;
  final int phase2assign = 15;
  final int phase3attest = 15;

  @override
  Widget build(BuildContext context) {
    double progressElapsed = CeremonyBoxService.getProgressElapsed(
      currentTime,
      assigningPhaseStart,
      ceremonyPhaseDurations,
    );

    _log("ceremony progress: $progressElapsed");
    _log("progress width: ${width * progressElapsed}");

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: ZurichLion.shade300),
        color: Colors.white,
      ),
      height: 10,
      child: Stack(
        children: [
          SizedBox(
            width: width * progressElapsed,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                gradient: primaryGradient,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: phase1register,
                child: SizedBox(),
              ),
              Expanded(
                flex: phase2assign,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 1),
                  foregroundDecoration: BoxDecoration(
                    // draw the vertical phase dividers
                    border: Border.symmetric(
                      vertical: BorderSide(color: ZurichLion.shade300),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: phase3attest,
                child: SizedBox(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

_log(String msg) {
  print("[CeremonyProgressBar] $msg");
}
