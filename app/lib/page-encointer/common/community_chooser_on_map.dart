import 'dart:convert';

import 'package:dart_geohash/dart_geohash.dart';
import 'package:encointer_wallet/service/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:encointer_wallet/common/components/map/encointer_map.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/models/communities/cid_name.dart';
import 'package:encointer_wallet/utils/repository_provider.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:provider/provider.dart';

class CommunityChooserOnMap extends StatefulWidget {
  const CommunityChooserOnMap({super.key});

  static const route = '/community-chooser-on-map';

  @override
  State<CommunityChooserOnMap> createState() => _CommunityChooserOnMapState();
}

class _CommunityChooserOnMapState extends State<CommunityChooserOnMap> {
  late final Future<(List<LatLng>, Map<LatLng, CidName>)> _initFuture;

  @override
  void initState() {
    super.initState();
    final store = context.read<AppStore>();
    _initFuture = _loadCommunityData(store);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final loginStore = context.read<LoginStore>();
      if (loginStore.getBiometricAuthState == null) {
        await LoginDialog.showToggleBiometricAuthAlert(context);
      }
    });
  }

  Future<(List<LatLng>, Map<LatLng, CidName>)> _loadCommunityData(AppStore store) async {
    // Make sure that we have finished fetching communities
    await webApi.encointer.initialCommunityFetch;
    final locations = getLocations(store);
    final communityDataAt = getCommunityDataAt(store);
    return (locations, communityDataAt);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.communityChoose,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        leading: const SizedBox.shrink(),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.encointerGrey),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      body: FutureBuilder<(List<LatLng>, Map<LatLng, CidName>)>(
        future: _initFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          final (locations, communityDataAt) = snapshot.data!;
          if (locations.isEmpty || communityDataAt.isEmpty) {
            return ColoredBox(
              color: Colors.white,
              child: CupertinoAlertDialog(
                title: Container(),
                content: Text(l10n.noCommunitiesAreYouOffline),
                actions: <Widget>[
                  CupertinoButton(
                    child: Text(l10n.ok),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            );
          }

          return EncointerMap(
            locations: locations,
            center: const LatLng(47.389712, 8.517076),
            initialZoom: 2,
            popupBuilder: (BuildContext context, Marker marker) {
              return PopupBuilder(
                key: Key(
                  '${marker.key.toString().substring(3, marker.key.toString().length - 3)}-description',
                ),
                title: communityDataAt[marker.point]!.name,
                description: communityDataAt[marker.point]!.cid.toFmtString(),
                onTap: () async {
                  final store = context.read<AppStore>();
                  await store.encointer.setChosenCid(communityDataAt[marker.point]!.cid);
                  if (RepositoryProvider.of<AppSettings>(context).developerMode) {
                    context.read<AppSettings>().changeTheme(store.encointer.community?.cid.toFmtString());
                  }
                  Navigator.pop(context);
                },
                bottom: Text(
                  l10n.communityDoChoose,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

List<LatLng> getLocations(AppStore store) {
  return store.encointer.communities?.map(coordinatesOf).toList() ?? [];
}

LatLng coordinatesOf(CidName community) {
  /// EdisonPaula has similar map data as to Leu
  /// thus it is too close to Zurich Leu,
  /// and very hard to choose it from map
  /// thus moved little bit to the left on map
  if (community.name == 'EdisonPaula') {
    return const LatLng(47.3962467, 8.4815019);
  }
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
