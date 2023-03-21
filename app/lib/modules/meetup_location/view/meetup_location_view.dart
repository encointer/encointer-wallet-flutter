import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:encointer_wallet/common/components/map/encointer_map.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
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
        center: meetupLocation.toLatLng(),
        // zoom level is equivalent to 1 km^2.
        initialZoom: 17,
        popupBuilder: (BuildContext context, Marker marker) => PopupBuilder(
          title: dic.encointer.showRouteMeetupLocation,
          description: '',
          onTap: () => AppLaunch.launchMap(meetupLocation),
          height: 40,
        ),
        mapController: _mapController,
        onPointerDown: (e, lt) {
          if (!ensureZoomWithinLimits(_mapController)) {
            AppAlert.showConfirmDialog<void>(
              context: context,
              onOK: () => AppLaunch.launchMap(meetupLocation),
              onCancel: () => Navigator.pop(context),
              title: Text(dic.home.openMapApplication),
            );
          }
        },
      ),
    );
  }

  /// Keeps the zoom level of the given [MapController] object within a certain limit.
  /// If the zoom level is below a certain limit, it zooms it into the limit, keeping the center the same.
  ///
  /// Returns `true` if zoom within the limit, `false` otherwise.
  bool ensureZoomWithinLimits(MapController controller) {
    if (_mapController.zoom < 18) return true;
    _mapController.move(_mapController.center, 17);
    return false;
  }
}
