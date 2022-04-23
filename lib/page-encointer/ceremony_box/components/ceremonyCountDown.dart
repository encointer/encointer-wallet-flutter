import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiver/async.dart';
import 'package:encointer_wallet/common/theme.dart';

class CeremonyCountDown extends StatefulWidget {
  // CeremonyCountDown(this.store);

  static const String route = '/encointer/assigning';
  // final AppStore store;

  @override
  _CeremonyCountDownState createState() => _CeremonyCountDownState();
}

class _CeremonyCountDownState extends State<CeremonyCountDown> {
  _CeremonyCountDownState();

  int timeToMeetup;
  StreamSubscription<CountdownTimer> sub;

  @override
  void initState() {
    // TODO replace following line
    this.timeToMeetup = 30; //widget.store.encointer.getTimeToMeetup();
    super.initState();
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: timeToMeetup),
      new Duration(seconds: 1),
    );

    sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        timeToMeetup = duration.remaining.inSeconds;
      });
    });

    sub.onDone(() {
      print("Done");
      sub.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (sub == null) {
      startTimer();
    }

    Duration timeLeftUntilCeremonyStarts = Duration(seconds: timeToMeetup);

    return Text(
      '${timeLeftUntilCeremonyStarts.inDays}d ${timeLeftUntilCeremonyStarts.inHours.remainder(24)}h ${timeLeftUntilCeremonyStarts.inMinutes.remainder(60)}min ${timeLeftUntilCeremonyStarts.inSeconds.remainder(60)}s',
      style: Theme.of(context).textTheme.headline2.copyWith(color: encointerBlack),
    );
  }
}

/// TODO remove this mockup
class AppStore {}
