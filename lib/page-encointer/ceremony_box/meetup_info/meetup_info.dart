import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/models/location/location.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/meetup_info/components/ceremony_location_button.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/meetup_info/components/ceremony_notification.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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
    final info = dic.encointer.youAreAssignedToAGatheringWithNParticipants.replaceAll(
      'P_COUNT',
      meetup.registry.length.toString(),
    );

    return Column(
      children: [
        CeremonyNotification(notificationIconData: Iconsax.tick_square, notification: info),
        const SizedBox(height: 16),
        CeremonyLocationButton(onPressed: onLocationPressed)
      ],
    );
  }
}
