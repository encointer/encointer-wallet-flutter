import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';

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
  var result = await changeNetwork(store, api, networkInfo, cid);

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
  var network;

  try {
    network = networkEndpoints.firstWhere(
      (network) => network.info == networkInfo,
      orElse: () => throw FormatException('Invalid network in QrCode: $networkInfo'),
    );
  } catch (e) {
    return ChangeResult.invalidNetwork;
  }

  await store.settings.reloadNetwork(network);

  while (!store.settings.isConnected) {
    // This is not very nice, but unfortunately we can't await the
    // webView init until it is completely connected without some
    // refactoring.
    await Future.delayed(const Duration(milliseconds: 500), () {
      _log("Waiting until we connected to new network...");
    });
  }

  return ChangeResult.ok;
}

Future<ChangeResult> changeCommunity(
  AppStore store,
  Api api,
  String networkInfo,
  CommunityIdentifier cid,
) async {
  var cids = await api.encointer.getCommunityIdentifiers();

  if (cids.contains(cid)) {
    store.encointer.setChosenCid(cid);
    return ChangeResult.ok;
  } else {
    return ChangeResult.invalidCommunity;
  }
}

void _log(String msg) {
  print("[ReapVoucherPage/utils] $msg");
}
