import 'dart:convert';

import 'package:dart_geohash/dart_geohash.dart';
import 'package:encointer_wallet/page-encointer/common/encointerMap.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart";

class CommunityChooserOnMap extends StatelessWidget {
  final AppStore store;

  final communityDataAt = Map<LatLng, CidName>();

  List<Marker> get _markers => getMarkers(store);

  CommunityChooserOnMap(this.store) {
    if (store.encointer.communities != null) {
      for (var community in store.encointer.communities) {
        communityDataAt[coordinatesOf(community)] = community;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context).translationsForLocale();

    return EncointerMap(
      store,
      popupBuilder: (BuildContext context, Marker marker) =>
          CommunityDetailsPopup(store, marker, communityDataAt[marker.point]),
      markers: _markers,
      title: dic.assets.communityChoose,
      center: LatLng(47.389712, 8.517076),
      initialZoom: 0,
    );
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
        key: Key('${widget.marker.key.toString().substring(3, widget.marker.key.toString().length - 3)}-description'),
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
              const Padding(
                padding: EdgeInsets.only(bottom: 2.0),
              ),
              Text(
                widget.dataForThisMarker.cid.toFmtString(),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Marker> getMarkers(AppStore store) {
  List<Marker> markers = [];
  if (store.encointer.communities != null) {
    for (num index = 0; index < store.encointer.communities.length; index++) {
      CidName community = store.encointer.communities[index];
      markers.add(
        Marker(
          // marker is not a widget, hence test_driver cannot find it (it can find it in the Icon inside, though).
          // But we need the key to derive the popup key
          key: Key('cid-$index-marker'),
          point: coordinatesOf(community),
          width: 40,
          height: 40,
          builder: (_) => Icon(
            Icons.location_on,
            size: 40,
            color: Colors.blueAccent,
            key: Key('cid-$index-marker-icon'), // used for test_driver
          ),
          anchorPos: AnchorPos.align(AnchorAlign.top),
        ),
      );
    }
  }

  return markers;
}

LatLng coordinatesOf(CidName community) {
  GeoHash coordinates = GeoHash(utf8.decode(community.cid.geohash));
  return LatLng(coordinates.latitude(), coordinates.longitude());
}
