import 'package:encointer_wallet/models/index.dart';

import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../models/location/location.dart';
import 'components/ceremony_location_button.dart';
import 'components/ceremony_notification.dart';

class MeetupInfo extends StatelessWidget {
  MeetupInfo(
    this.meetup,
    this.meetupLocation, {
    this.onLocationPressed,
    Key? key,
  }) : super(key: key);

  final Meetup meetup;

  final Location meetupLocation;

  final Future<void> Function()? onLocationPressed;

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
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
