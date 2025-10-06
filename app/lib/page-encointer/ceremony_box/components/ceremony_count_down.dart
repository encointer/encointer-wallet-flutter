import 'dart:async';

import 'package:ew_l10n/l10n.dart';
import 'package:encointer_wallet/models/communities/community_metadata.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/ceremony_box_service.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quiver/async.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/service/log/log_service.dart';

class CeremonyCountDown extends StatefulWidget {
  const CeremonyCountDown({
    required this.nextCeremonyDate,
    required this.communityRules,
    this.languageCode,
    super.key,
  });

  static const String route = '/encointer/assigning';

  final DateTime nextCeremonyDate;
  final CommunityRules communityRules;
  final String? languageCode;

  @override
  State<CeremonyCountDown> createState() => _CeremonyCountDownState();
}

class _CeremonyCountDownState extends State<CeremonyCountDown> {
  _CeremonyCountDownState();

  late int timeToMeetup;

  // Todo: double check: is this a false positive?
  // ignore: cancel_subscriptions
  StreamSubscription<CountdownTimer>? sub;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (sub != null) sub!.cancel();
    super.dispose();
  }

  void resetTimer() {
    _cancelTimer();

    final countDownTimer = CountdownTimer(
      Duration(seconds: timeToMeetup),
      const Duration(seconds: 1),
    );

    sub = countDownTimer.listen(null);
    sub!.onData((duration) {
      setState(() {
        timeToMeetup = duration.remaining.inSeconds;
      });
    });

    sub!.onDone(() {
      Log.d('Done', 'CeremonyCountDown');
      sub!.cancel();
    });
  }

  void _cancelTimer() {
    if (sub != null) {
      sub!.cancel();
      sub = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var timeToMeetup = widget.nextCeremonyDate.difference(DateTime.now()).inSeconds;

    if (timeToMeetup <= 0) {
      timeToMeetup = 0;
      _cancelTimer();
    } else {
      this.timeToMeetup = timeToMeetup;
      resetTimer();
    }

    final timeLeftUntilCeremonyStarts = Duration(seconds: timeToMeetup);

    final countDownDisplay = widget.communityRules.isLoCoFlex
        ? CeremonyBoxService.formatDayRelative(widget.nextCeremonyDate, context.l10n, widget.languageCode)
        : '${timeLeftUntilCeremonyStarts.inDays}d ${timeLeftUntilCeremonyStarts.inHours.remainder(24)}h ${timeLeftUntilCeremonyStarts.inMinutes.remainder(60)}min ${timeLeftUntilCeremonyStarts.inSeconds.remainder(60)}s';

    return Row(
      children: [
        const Icon(
          Iconsax.timer_start,
          color: AppColors.encointerGrey,
          size: 18,
        ),
        const SizedBox(width: 8),
        Text(
          countDownDisplay,
          style: context.headlineMedium.copyWith(color: AppColors.encointerBlack),
        ),
      ],
    );
  }
}
