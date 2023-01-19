import 'package:ew_translation/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:encointer_wallet/common/components/map/encointer_map.dart';
import 'package:encointer_wallet/models/location/location.dart';
import 'package:encointer_wallet/service/launch/app_launch.dart';

class MeetupLocationPage extends StatelessWidget {
  const MeetupLocationPage(this.meetupLocation, {super.key});

  final Location meetupLocation;

  static const route = '/meetup-location';

  @override
  Widget build(BuildContext context) {
    final dic = context.dic;
    return Scaffold(
      appBar: AppBar(
        title: Text(dic.encointer.meetupLocation),
      ),
      body: EncointerMap(
        locations: [meetupLocation.toLatLng()],
        center: meetupLocation.toLatLng(),
        initialZoom: 10,
        popupBuilder: (BuildContext context, Marker marker) => PopupBuilder(
          title: dic.encointer.showRouteMeetupLocation,
          description: '',
          onTap: () => AppLaunch.launchMap(meetupLocation),
          height: 40,
        ),
      ),
    );
  }
}
