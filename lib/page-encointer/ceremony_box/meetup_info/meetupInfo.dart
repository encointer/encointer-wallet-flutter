import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/store/encointer/types/location.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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

    return Column(
      children: [
        CeremonyNotification(notificationIconData: Iconsax.tick_square, notification: info),
        SizedBox(height: 16),
        CeremonyLocationButton(onPressed: onLocationPressed)
      ],
    );
  }
}
