import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quiver/async.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/service/log/log_service.dart';

class CeremonyCountDown extends StatefulWidget {
  const CeremonyCountDown(this.nextCeremonyDate, {super.key});

  static const String route = '/encointer/assigning';

  final DateTime? nextCeremonyDate;

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
    var timeToMeetup =
        widget.nextCeremonyDate != null ? widget.nextCeremonyDate!.difference(DateTime.now()).inSeconds : 0;

    if (timeToMeetup <= 0) {
      timeToMeetup = 0;
      _cancelTimer();
    } else {
      this.timeToMeetup = timeToMeetup;
      resetTimer();
    }

    final timeLeftUntilCeremonyStarts = Duration(seconds: timeToMeetup);

    return Row(
      children: [
        const Icon(
          Iconsax.timer_start,
          color: encointerGrey,
          size: 18,
        ),
        const SizedBox(width: 8),
        Text(
          '${timeLeftUntilCeremonyStarts.inDays}d ${timeLeftUntilCeremonyStarts.inHours.remainder(24)}h ${timeLeftUntilCeremonyStarts.inMinutes.remainder(60)}min ${timeLeftUntilCeremonyStarts.inSeconds.remainder(60)}s',
          style: Theme.of(context).textTheme.headline2!.copyWith(color: encointerBlack),
        ),
      ],
    );
  }
}
