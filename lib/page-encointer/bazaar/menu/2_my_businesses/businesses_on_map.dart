import 'package:ew_translations/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';

import 'package:encointer_wallet/page-encointer/bazaar/3_businesses/business_detail.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/demo_data.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/model/bazaar_item_data.dart';

class BusinessesOnMap extends StatelessWidget {
  BusinessesOnMap({super.key});

  final data = allBusinesses;

  @override
  Widget build(BuildContext context) {
    final dic = context.dic;
    return Scaffold(
      appBar: AppBar(
        title: Text(dic.bazaar.businesses),
      ),
      body: BMap(data),
    );
  }
}

class BMap extends StatelessWidget {
  BMap(List<BazaarItemData> data, {super.key})
      // initializer (only use businesses, offerings do not have coordinates)
      : businessData = data.whereType<BazaarBusinessData>().map((item) => item).toList() {
    // construct a map using "collection for"
    bazaarBusinessDataFor.addAll({for (var business in businessData) business.coordinates: business});
  }

  /// Used to trigger showing/hiding of popups.
  final PopupController _popupLayerController = PopupController();
  final List<BazaarBusinessData> businessData;
  final bazaarBusinessDataFor = <LatLng, BazaarBusinessData>{};

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(47.389712, 8.517076),
        zoom: 15,
        maxZoom: 18.4,
        onTap: (_, __) => _popupLayerController.hideAllPopups(), // Hide popup when the map is tapped.
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
        ),
        PopupMarkerLayerWidget(
          options: PopupMarkerLayerOptions(
            popupController: _popupLayerController,
            markers: _markers,
            markerRotateAlignment: PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.top),
            popupBuilder: (BuildContext context, Marker marker) =>
                BusinessDetailsPopup(marker, bazaarBusinessDataFor[marker.point]),
          ),
        ),
      ],
    );
  }

  List<Marker> get _markers {
    return businessData
        .map((item) => Marker(
            point: item.coordinates,
            width: 40,
            height: 40,
            builder: (_) => const Icon(Icons.location_on, size: 40, color: Colors.blueAccent),
            anchorPos: AnchorPos.align(AnchorAlign.top)))
        .toList();
  }
}

class BusinessDetailsPopup extends StatelessWidget {
  const BusinessDetailsPopup(this.marker, this.dataForThisMarker, {super.key});

  final Marker marker;
  final BazaarBusinessData? dataForThisMarker;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => BusinessDetail(dataForThisMarker),
            ),
          );
        },
        child: Container(
          width: 150,
          height: 70,
          padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                dataForThisMarker!.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2)),
              Text(
                dataForThisMarker!.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
