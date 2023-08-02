import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/page_encointer/ceremony_box/ceremony_box_service.dart';
import 'package:encointer_wallet/service/log/log_service.dart';

/// Shows the progress of a ceremony cycle.
///
/// It indicates the individual `CeremonyPhase`s and allows disproportionate emphasis
/// on certain phases.
class CeremonyProgressBar extends StatelessWidget {
  const CeremonyProgressBar({
    required this.currentTime,
    required this.assigningPhaseStart,
    required this.meetupTime,
    required this.ceremonyPhaseDurations,
    required this.width,
    this.assigningPhaseFractionalWidth = 0.15,
    this.attestingPhaseFractionalWidth = 0.15,
    this.registeringPhaseFractionalWidth = 0.70,
    super.key,
  });

  final int? currentTime;
  final int? assigningPhaseStart;
  final int? meetupTime;
  final Map<CeremonyPhase, int>? ceremonyPhaseDurations;

  /// Total width of the progress bar.
  final double width;

  /// Fractional width of the registering phase segment of the progress bar.
  final double registeringPhaseFractionalWidth;

  /// Fractional width of the assigning segment of the progress bar.
  final double assigningPhaseFractionalWidth;

  /// Fractional width of the attesting segment of the progress bar.
  final double attestingPhaseFractionalWidth;

  double? _getCeremonyProgress() {
    try {
      // todo inject this service for mocking
      return CeremonyBoxService.getProgressElapsed(
        currentTime!,
        assigningPhaseStart!,
        meetupTime,
        ceremonyPhaseDurations!,
        registeringPhaseFractionalWidth,
        assigningPhaseFractionalWidth,
        attestingPhaseFractionalWidth,
      );
    } catch (e, s) {
      Log.e('Error getting ceremony progress $e', 'CeremonyProgressBar', s);
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final progressElapsed = _getCeremonyProgress()!;
    Log.d('ceremony progress: $progressElapsed', 'CeremonyProgressBar');

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: context.colorScheme.secondary),
        color: Colors.white,
      ),
      height: 10,
      child: Stack(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              gradient: AppColors.primaryGradient(context),
            ),
            child: SizedBox(width: width * progressElapsed, height: 10),
          ),
          Row(
            children: [
              SizedBox(width: width * registeringPhaseFractionalWidth),
              SizedBox(
                width: width * assigningPhaseFractionalWidth,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 1),
                  foregroundDecoration: BoxDecoration(
                    // draw the vertical phase dividers
                    border: Border.symmetric(
                      vertical: BorderSide(color: context.colorScheme.secondary),
                    ),
                  ),
                ),
              ),
              SizedBox(width: width * attestingPhaseFractionalWidth),
            ],
          ),
        ],
      ),
    );
  }
}
