import 'package:encointer_wallet/models/ceremonies/ceremonies.dart';
import 'package:encointer_wallet/models/communities/community_metadata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:encointer_wallet/common/components/map/encointer_map.dart';
import 'package:encointer_wallet/models/location/location.dart';
import 'package:encointer_wallet/service/launch/app_launch.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class MeetupLocationArgs {
  MeetupLocationArgs(
    this.meetupLocation,
    this.meetup,
    this.communityRules,
  );

  final Location meetupLocation;
  final Meetup meetup;
  final CommunityRules communityRules;
}

class MeetupLocationPage extends StatelessWidget {
  MeetupLocationPage(
    this.meetupLocationArgs, {
    super.key,
  });

  final MeetupLocationArgs meetupLocationArgs;

  static const route = '/meetup-location';
  final _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final meetupLocation = meetupLocationArgs.meetupLocation;
    final communityRules = meetupLocationArgs.communityRules;

    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.meetupLocation),
      ),
      body: EncointerMap(
        locations: [meetupLocation.toLatLng()],
        center: meetupLocation.toLatLng(),
        // zoom level is equivalent to 1 km^2.
        initialZoom: 17,
        popupBuilder: (BuildContext context, Marker marker) =>
        communityRules.isLoCoFlex ?
            _loCoFlexPopupBuilder(context, marker, meetupLocationArgs) :
            _loCoPopupBuilder(context, marker, meetupLocationArgs),
        mapController: _mapController,
      ),
    );
  }

  PopupBuilder _loCoFlexPopupBuilder(BuildContext context, Marker marker, MeetupLocationArgs meetupLocationArgs) {
    final l10n = context.l10n;

    return PopupBuilder(
      title: l10n.meetupIndex(meetupLocationArgs.meetup.index),
      description: l10n.meetupIndexPopupExplanation,
      bottom: InkWell(
        child: Text(
          l10n.showRouteMeetupLocation,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        onTap:  () => AppLaunch.launchMap(meetupLocationArgs.meetupLocation),
      ),
      maxHeight: 300,
    );
  }

  PopupBuilder _loCoPopupBuilder(BuildContext context, Marker marker, MeetupLocationArgs meetupLocationArgs) {
    final l10n = context.l10n;

    return PopupBuilder(
      title: l10n.meetupLocation,
      description: '',
      bottom: InkWell(
        child: Text(
          l10n.showRouteMeetupLocation,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        onTap:  () => AppLaunch.launchMap(meetupLocationArgs.meetupLocation),
      ),
    );
  }
}
