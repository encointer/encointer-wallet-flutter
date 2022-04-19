import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/store/app.dart';
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
  final Function popupBuilder;
  final List<Marker> markers;
  final String title;
  final LatLng center;
  final double initialZoom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
      body: markers.isNotEmpty
          ? FlutterMap(
              options: MapOptions(
                center: center,
                zoom: initialZoom,
                maxZoom: 18.4,
                onTap: (_) => _popupLayerController.hideAllPopups(), // Hide popup when the map is tapped.
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
                    markers: markers,
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
  var translations = I18n.of(context).translationsForLocale();

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
