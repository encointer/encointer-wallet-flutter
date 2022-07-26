import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/types/location.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import "package:latlong2/latlong.dart";

class EncointerMap extends StatelessWidget {
  EncointerMap(this.store, {this.popupBuilder, this.markers, this.title, this.center, this.initialZoom = 0});

  final AppStore store;

  /// Used to trigger showing/hiding of popups.
  final PopupController _popupLayerController = PopupController();
  final Widget Function(BuildContext, Marker)? popupBuilder;
  final List<Marker>? markers;
  final String? title;
  final LatLng? center;
  final double initialZoom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
        leading: Container(),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: encointerGrey,
            ),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      body: markers!.isNotEmpty
          ? FlutterMap(
              options: MapOptions(
                center: center,
                zoom: initialZoom,
                maxZoom: 18.4,
                onTap: (_, __) => _popupLayerController.hideAllPopups(), // Hide popup when the map is tapped.
              ),
              children: [
                TileLayerWidget(
                  options: TileLayerOptions(
                    backgroundColor: Colors.white,
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                ),
                PopupMarkerLayerWidget(
                  options: PopupMarkerLayerOptions(
                    popupController: _popupLayerController,
                    markers: markers!,
                    markerRotateAlignment: PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.top),
                    popupBuilder: popupBuilder,
                  ),
                ),
              ],
            )
          : Container(
              color: Colors.white,
              child: noCommunityDialog(context),
            ),
    );
  }
}

Widget noCommunityDialog(BuildContext context) {
  var translations = I18n.of(context)!.translationsForLocale();

  return CupertinoAlertDialog(
    title: Container(),
    content: Text(translations.encointer.noCommunitiesAreYouOffline),
    actions: <Widget>[
      CupertinoButton(
        child: Text(translations.home.ok),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}

Future<void> showOnEncointerMap(
  BuildContext context,
  AppStore store,
  Location location, {
  double initialZoom = 14,
}) {
  var dic = I18n.of(context)!.translationsForLocale();

  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) {
        return EncointerMap(
          store,
          popupBuilder: (BuildContext context, Marker marker) => SizedBox(),
          markers: buildMarkers(location),
          title: dic.encointer.meetupLocation,
          center: location.toLatLng(),
          initialZoom: initialZoom,
        );
      },
    ),
  );
}

List<Marker> buildMarkers(Location meetupLocation) {
  List<Marker> markers = <Marker>[];
  markers.add(
    Marker(
      // marker is not a widget, hence test_driver cannot find it (it can find it in the Icon inside, though).
      // But we need the key to derive the popup key
      key: Key('meetup-location'),
      point: meetupLocation.toLatLng(),
      width: 40,
      height: 40,
      builder: (_) => Icon(
        Icons.location_on,
        size: 40,
        color: Colors.blueAccent,
        key: Key('meetup-location-icon'), // used for test_driver
      ),
      anchorPos: AnchorPos.align(AnchorAlign.top),
    ),
  );
  return markers;
}
