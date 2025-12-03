import 'package:encointer_wallet/config/networks/networks.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:ew_log/ew_log.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';

enum ChangeResult {
  ok,
  invalidNetwork,
  invalidCommunity,
}

Future<ChangeResult> changeNetworkAndCommunity(
  AppStore store,
  Api api,
  String networkInfo,
  CommunityIdentifier cid,
) async {
  final result = await changeNetwork(store, api, networkInfo, cid);

  if (result != ChangeResult.ok) {
    return result;
  }

  return changeCommunity(store, api, networkInfo, cid);
}

Future<ChangeResult> changeNetwork(
  AppStore store,
  Api api,
  String networkInfo,
  CommunityIdentifier cid,
) async {
  try {
    final network = Network.tryFromInfo(networkInfo);
    await store.settings.reloadNetwork(network);
  } catch (e) {
    Log.e('Invalid Network error: $e');
    return ChangeResult.invalidNetwork;
  }

  while (!store.settings.isConnected) {
    // This is not very nice, but unfortunately we can't await the
    // webView init until it is completely connected without some
    // refactoring.
    await Future.delayed(const Duration(milliseconds: 500), () {
      Log.d('Waiting until we connected to new network...', 'changeNetwork');
    });
  }

  return ChangeResult.ok;
}

Future<ChangeResult> changeCommunity(
  AppStore store,
  Api api,
  String? networkInfo,
  CommunityIdentifier cid,
) async {
  final cids = await api.encointer.getCommunityIdentifiers();

  if (cids.contains(cid)) {
    await store.encointer.setChosenCid(cid);
    return ChangeResult.ok;
  } else {
    return ChangeResult.invalidCommunity;
  }
}
