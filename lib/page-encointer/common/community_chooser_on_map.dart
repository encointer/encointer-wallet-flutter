import 'dart:convert';

import 'package:dart_geohash/dart_geohash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:encointer_wallet/common/components/map/encointer_map.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/models/communities/cid_name.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:provider/provider.dart';

class CommunityChooserOnMap extends StatefulWidget {
  const CommunityChooserOnMap({super.key});

  static const route = '/community-chooser-on-map';

  @override
  State<CommunityChooserOnMap> createState() => _CommunityChooserOnMapState();
}

class _CommunityChooserOnMapState extends State<CommunityChooserOnMap> {
  late final List<LatLng> locations;
  late final Map<LatLng, CidName> communityDataAt;

  @override
  void initState() {
    locations = getLocations(context.read<AppStore>());
    communityDataAt = getCommunityDataAt(context.read<AppStore>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          dic.assets.communityChoose,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        leading: const SizedBox.shrink(),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close, color: encointerGrey),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      body: (locations.isNotEmpty && communityDataAt.isNotEmpty)
          ? EncointerMap(
              locations: locations,
              center: LatLng(47.389712, 8.517076),
              initialZoom: 2,
              popupBuilder: (BuildContext context, Marker marker) {
                return PopupBuilder(
                  inkWellKey: Key(
                    '${marker.key.toString().substring(3, marker.key.toString().length - 3)}-description',
                  ),
                  title: communityDataAt[marker.point]!.name,
                  description: communityDataAt[marker.point]!.cid.toFmtString(),
                  onTap: () async {
                    await context.read<AppStore>().encointer.setChosenCid(communityDataAt[marker.point]!.cid);
                    if (context.mounted) Navigator.pop(context);
                  },
                );
              },
            )
          : ColoredBox(
              color: Colors.white,
              child: CupertinoAlertDialog(
                title: Container(),
                content: Text(dic.encointer.noCommunitiesAreYouOffline),
                actions: <Widget>[
                  CupertinoButton(
                    child: Text(dic.home.ok),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
    );
  }
}

List<LatLng> getLocations(AppStore store) {
  return store.encointer.communities?.map(coordinatesOf).toList() ?? [];
}

LatLng coordinatesOf(CidName community) {
  final coordinates = GeoHash(utf8.decode(community.cid.geohash));
  return LatLng(coordinates.latitude(), coordinates.longitude());
}

Map<LatLng, CidName> getCommunityDataAt(AppStore store) {
  final communityDataAt = <LatLng, CidName>{};
  if (store.encointer.communities != null) {
    for (final community in store.encointer.communities!) {
      communityDataAt[coordinatesOf(community)] = community;
    }
  }
  return communityDataAt;
}
