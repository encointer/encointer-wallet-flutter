import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/store/app.dart';
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
      body: FlutterMap(
        options: MapOptions(
          center: center,
          zoom: initialZoom,
          maxZoom: 18.4,
          onTap: (_, __) => _popupLayerController.hideAllPopups(), // Hide popup when the map is tapped.
        ),
        children: [
          TileLayerWidget(
            options: TileLayerOptions(
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
      ),
    );
  }
}
