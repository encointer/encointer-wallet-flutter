import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/models/location/location.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/meetup_info/components/ceremony_location_button.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/meetup_info/components/ceremony_notification.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class MeetupInfo extends StatelessWidget {
  const MeetupInfo(
    this.meetup,
    this.meetupLocation, {
    super.key,
    this.onPressed,
  });

  final Meetup meetup;
  final Location meetupLocation;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final info = context.l10n.youAreAssignedToAGatheringWithNParticipants(meetup.registry.length);
    return Column(
      children: [
        CeremonyNotification(notificationIconData: Iconsax.tick_square, notification: info),
        const SizedBox(height: 16),
        CeremonyLocationButton(onPressed: onPressed),
      ],
    );
  }
}
