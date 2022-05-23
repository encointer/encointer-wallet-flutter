import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/store/encointer/types/location.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/material.dart';

import 'components/ceremonyLocationButton.dart';
import 'components/ceremonyNotification.dart';

class MeetupInfo extends StatelessWidget {
  MeetupInfo(
    this.meetup,
    this.meetupLocation, {
    this.onLocationPressed,
    Key key,
  }) : super(key: key);

  /// Addresses of the all meetup participants.
  final Meetup meetup;

  final Location meetupLocation;

  final Future<void> Function() onLocationPressed;

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context).translationsForLocale();
    var info =
        dic.encointer.youAreAssignedToAMeetupWithNParticipants.replaceAll('P_COUNT', meetup.registry.length.toString());

    return Container(
      margin: EdgeInsets.only(top: 2),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0), bottom: Radius.circular(15)),
        color: ZurichLion.shade50,
      ),
      child: Column(
        children: [
          CeremonyNotification(notification: info),
          SizedBox(height: 16),
          CeremonyLocationButton(onPressed: onLocationPressed)
        ],
      ),
    );
  }
}
