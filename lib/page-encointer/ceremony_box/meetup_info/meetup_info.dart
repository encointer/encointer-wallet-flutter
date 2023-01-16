import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/models/location/location.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/meetup_info/components/ceremony_location_button.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/meetup_info/components/ceremony_notification.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class MeetupInfo extends StatelessWidget {
  const MeetupInfo(this.meetup, this.meetupLocation, {super.key});

  final Meetup meetup;
  final Location meetupLocation;

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final info = dic.encointer.youAreAssignedToAGatheringWithNParticipants.replaceAll(
      'P_COUNT',
      meetup.registry.length.toString(),
    );

    return Column(
      children: [
        CeremonyNotification(notificationIconData: Iconsax.tick_square, notification: info),
        const SizedBox(height: 16),
        CeremonyLocationButton(
          onPressed: () async {
            Navigator.pushNamed(context, MeetupLocationPage.route, arguments: meetupLocation);
          },
        ),
      ],
    );
  }
}
