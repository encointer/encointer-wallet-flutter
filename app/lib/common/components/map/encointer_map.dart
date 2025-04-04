import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';

class EncointerMap extends StatelessWidget {
  EncointerMap({
    super.key,
    required this.popupBuilder,
    required this.locations,
    this.initialZoom = 13,
    // Higher values than 17 result in the map going blank
    this.maxZoom = 17,
    this.center,
    this.mapController,
    this.onPointerDown,
  });

  final List<LatLng> locations;
  final double initialZoom;
  final double maxZoom;
  final LatLng? center;
  final Widget Function(BuildContext, Marker) popupBuilder;
  final MapController? mapController;
  final void Function(PointerDownEvent, LatLng)? onPointerDown;

  final _popupLayerController = PopupController();

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: center ?? const LatLng(47.389712, 8.517076),
        initialZoom: initialZoom,
        maxZoom: maxZoom,
        backgroundColor: Colors.white,
        onPointerDown: onPointerDown,
        onTap: (_, __) => _popupLayerController.hideAllPopups(disableAnimation: true),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
        PopupMarkerLayer(
          options: PopupMarkerLayerOptions(
            popupController: _popupLayerController,
            popupDisplayOptions: PopupDisplayOptions(builder: popupBuilder),
            markers: List.generate(
              locations.length,
              (index) => Marker(
                key: Key('cid-$index-marker'),
                point: locations[index],
                child: Icon(
                  Icons.location_on,
                  size: 40,
                  color: Colors.blueAccent,
                  key: Key(EWTestKeys.cidMarkerIcon(index)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PopupBuilder extends StatelessWidget {
  const PopupBuilder({
    super.key,
    required this.title,
    required this.description,
    this.bottom,
    this.maxWidth = 300,
    this.maxHeight = 800,
    this.onTap,
  });

  final String title;
  final String description;
  final double maxWidth;
  final double maxHeight;
  final Widget? bottom;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.loose(Size(maxWidth, maxHeight)),
      padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              description,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
            bottom ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
