import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import "package:latlong2/latlong.dart";

class CommunityChooserOnMap extends StatelessWidget {
  final AppStore store;

  /// Used to trigger showing/hiding of popups.
  final PopupController _popupLayerController = PopupController();
  final communityDataAt = Map<LatLng, CidName>();

  CommunityChooserOnMap(this.store) {
    if (store.encointer.communities == null) return;
    for (var community in store.encointer.communities) {
      communityDataAt[coordinatesOf(community)] = community;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map dic = I18n.of(context).assets;
    return Scaffold(
      appBar: AppBar(
        title: Text(dic['community.choose']),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(47.389712, 8.517076),
          zoom: 0.0,
          maxZoom: 18.4,
          onTap: (_) => _popupLayerController.hideAllPopups(), // Hide popup when the map is tapped.
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
              markers: _markers,
              markerRotateAlignment: PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.top),
              popupBuilder: (BuildContext context, Marker marker) =>
                  CommunityDetailsPopup(store, marker, communityDataAt[marker.point]),
            ),
          ),
        ],
      ),
    );
  }

  List<Marker> get _markers {
    return store.encointer.communities == null? []:store.encointer.communities
        .map((community) => Marker(
            point: coordinatesOf(community),
            width: 40,
            height: 40,
            builder: (_) => Icon(Icons.location_on, size: 40, color: Colors.blueAccent),
            anchorPos: AnchorPos.align(AnchorAlign.top)))
        .toList();
  }

  LatLng coordinatesOf(CidName community) {
    return LatLng(47.389712, 8.517076); // TODO obtain LatLng from geoHash in CidName
  }
}

class CommunityDetailsPopup extends StatefulWidget {
  final AppStore store;
  final Marker marker;
  final CidName dataForThisMarker;

  CommunityDetailsPopup(this.store, this.marker, this.dataForThisMarker);

  @override
  _CommunityDetailsPopupState createState() => _CommunityDetailsPopupState(store);
}

class _CommunityDetailsPopupState extends State<CommunityDetailsPopup> {
  final AppStore store;

  _CommunityDetailsPopupState(this.store);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          setState(() {
            store.encointer.setChosenCid(widget.dataForThisMarker.cid);
          });
          Navigator.pop(context);
        },
        child: Container(
          width: 150,
          height: 70,
          padding: EdgeInsets.fromLTRB(6, 4, 6, 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.dataForThisMarker.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
