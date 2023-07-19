import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:encointer_wallet/common/components/map/encointer_map.dart';
import 'package:encointer_wallet/models/location/location.dart';
import 'package:encointer_wallet/service/launch/app_launch.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class MeetupLocationPage extends StatelessWidget {
  MeetupLocationPage(this.meetupLocation, {super.key});

  final Location meetupLocation;

  static const route = '/meetup-location';
  final _mapController = MapController();

  @override
  Widget build(BuildContext context) {
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
        popupBuilder: (BuildContext context, Marker marker) => PopupBuilder(
          title: l10n.meetupLocation,
          description: l10n.showRouteMeetupLocation,
          onTap: () => AppLaunch.launchMap(meetupLocation),
          height: 50,
        ),
        mapController: _mapController,
      ),
    );
  }
}
