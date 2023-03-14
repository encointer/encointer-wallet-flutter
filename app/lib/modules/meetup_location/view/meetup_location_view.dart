import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:encointer_wallet/common/components/map/encointer_map.dart';
import 'package:encointer_wallet/models/location/location.dart';
import 'package:encointer_wallet/service/launch/app_launch.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class MeetupLocationPage extends StatelessWidget {
  MeetupLocationPage(this.meetupLocation, {super.key});

  final Location meetupLocation;

  static const route = '/meetup-location';
  final _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    return Scaffold(
      appBar: AppBar(
        title: Text(dic.encointer.meetupLocation),
      ),
      body: EncointerMap(
        locations: [meetupLocation.toLatLng()],
        center: LatLng(1.290270, 103.851959),
        // center: meetupLocation.toLatLng(),
        initialZoom: 15,
        popupBuilder: (BuildContext context, Marker marker) => PopupBuilder(
          title: dic.encointer.showRouteMeetupLocation,
          description: '',
          onTap: () => AppLaunch.launchMap(meetupLocation),
          height: 40,
        ),
        mapController: _mapController,
        onPointerDown: (e, lt) {
          if (ensureZoomWithinLimits(_mapController)) {
            showCupertinoDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  content: Text(dic.home.openMapInBrowser),
                  actions: <Widget>[
                    CupertinoButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(dic.home.cancel),
                    ),
                    CupertinoButton(
                      onPressed: () => AppLaunch.launchMap(meetupLocation),
                      child: Text(dic.home.ok),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  /// Ensure that the zoom factor stays within the limits such that the map doesn't blank out.
  ///
  /// Returns true if the limit was reached.
  bool ensureZoomWithinLimits(MapController controller) {
    if (_mapController.zoom > 17) {
      _mapController.move(_mapController.center, 17);
      return true;
    }
    return false;
  }
}
