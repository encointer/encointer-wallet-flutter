import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';

class EncointerMap extends StatelessWidget {
  EncointerMap({
    super.key,
    required this.locations,
    this.initialZoom,
    this.maxZoom,
    this.center,
    this.popupBuilder,
    this.mapController,
    this.onPointerDown,
  });

  final List<LatLng> locations;
  final double? initialZoom;
  final double? maxZoom;
  final LatLng? center;
  final Widget Function(BuildContext, Marker)? popupBuilder;
  final MapController? mapController;
  final void Function(PointerDownEvent, LatLng)? onPointerDown;

  final _popupLayerController = PopupController();

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: center ?? LatLng(47.389712, 8.517076),
        zoom: initialZoom ?? 13,
        maxZoom: maxZoom ?? 18,
        onPointerDown: onPointerDown,
        onTap: (_, __) => _popupLayerController.hideAllPopups(disableAnimation: true),
      ),
      children: [
        TileLayer(
          backgroundColor: Colors.white,
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
        ),
        PopupMarkerLayerWidget(
          options: PopupMarkerLayerOptions(
            popupController: _popupLayerController,
            markers: List.generate(
              locations.length,
              (index) => Marker(
                key: Key('cid-$index-marker'),
                point: locations[index],
                builder: (_) => Icon(
                  Icons.location_on,
                  size: 40,
                  color: Colors.blueAccent,
                  key: Key('cid-$index-marker-icon'),
                ),
                anchorPos: AnchorPos.align(AnchorAlign.top),
              ),
            ),
            markerRotateAlignment: Alignment.bottomCenter,
            popupBuilder: popupBuilder,
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
    this.inkWellKey,
    this.onTap,
    this.width = 150,
    this.height = 70,
  });

  final String title;
  final String description;
  final Key? inkWellKey;
  final double width;
  final double height;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        key: inkWellKey,
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Text(
              description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
