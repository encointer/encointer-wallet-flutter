import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/service/ceremonyBoxService.dart';
import 'package:encointer_wallet/store/encointer/types/ceremonies.dart';
import 'package:flutter/material.dart';

/// This bar shows the progress in the meetup cycle, it visualizes the overall progress
/// and indicates the three phases.
///
/// progressElapsed + progressAhead = widthOfTheWholeBar, these are flex
/// factors (integers) to draw the progress in the right proportions,
/// automatically adapting to screen width
class CeremonyProgressBar extends StatelessWidget {
  const CeremonyProgressBar({
    this.registerUntilDate,
    this.nextCeremonyDate,
    this.currentPhase,
    Key key,
  }) : super(key: key);

  final DateTime registerUntilDate;
  final DateTime nextCeremonyDate;
  final CeremonyPhase currentPhase;
  final int phase1register = 6;
  final int phase2assign = 1;
  final int phase3attest = 1;
  final int totalProgress = 128; // cf. getProgressElapsed

  @override
  Widget build(BuildContext context) {
    int progressElapsed = CeremonyBoxService.getProgressElapsed(
        registerUntilDate, nextCeremonyDate, currentPhase, phase1register, phase2assign, phase3attest);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: ZurichLion.shade300),
        color: Colors.white,
      ),
      height: 10,
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                  flex: progressElapsed,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      gradient: primaryGradient,
                    ),
                  )),
              Expanded(
                flex: totalProgress - progressElapsed,
                child: SizedBox(),
              )
            ],
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
