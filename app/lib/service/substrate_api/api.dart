import 'dart:async';

import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/mocks/ipfs_api.dart';
import 'package:encointer_wallet/service/ipfs/ipfs_api.dart';
import 'package:encointer_wallet/service/substrate_api/account_api.dart';
import 'package:encointer_wallet/service/substrate_api/assets_api.dart';
import 'package:encointer_wallet/service/substrate_api/chain_api.dart';
import 'package:encointer_wallet/service/substrate_api/core/dart_api.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointer_api.dart';
import 'package:encointer_wallet/service/substrate_api/core/reconnecting_ws_provider.dart';
import 'package:ew_http/ew_http.dart';
import 'package:ew_polkadart/ew_polkadart.dart';
import 'package:encointer_wallet/service/log/log_service.dart';

/// Global api instance
///
/// `late final` because it will be initialized exactly once in lib/app.dart.
late Api webApi;

class Api {
  const Api(
    this.store,
    this.provider,
    this.dartApi,
    this.account,
    this.assets,
    this.chain,
    this.encointer,
    this.ipfsApi,
  );

  factory Api.create(
    AppStore store,
    SubstrateDartApi dartApi,
    EwHttp ewHttp, {
    bool isIntegrationTest = false,
  }) {
    final provider = ReconnectingWsProvider(Uri.parse(store.settings.endpoint.value!), autoConnect: false);
    return Api(
      store,
      provider,
      dartApi,
      AccountApi(store, provider),
      AssetsApi(store, EncointerKusama(provider)),
      ChainApi(store, provider),
      EncointerApi(store, dartApi, ewHttp, EncointerKusama(provider)),
      isIntegrationTest ? MockIpfsApi(ewHttp) : IpfsApi(ewHttp, gateway: store.settings.ipfsGateway),
    );
  }

  final AppStore store;

  final ReconnectingWsProvider provider;
  final SubstrateDartApi dartApi;
  final AccountApi account;
  final AssetsApi assets;
  final ChainApi chain;
  final EncointerApi encointer;
  final IpfsApi ipfsApi;

  Future<void> init() async {
    await Future.wait([
      dartApi.connect(store.settings.endpoint.value!),
      provider.connectToNewEndpoint(Uri.parse(store.settings.endpoint.value!)),
    ]);

    Log.d('Connected to endpoint: ${store.settings.endpoint.value!}', 'Api');

    if (store.account.currentAddress.isNotEmpty) {
      await store.encointer.initializeUninitializedStores(store.account.currentAddress);
    }

    // await subscriptions here because we want
    // to fetch the bestHead before making
    // other requests.
    await startSubscriptions();

    await Future.wait([
      webApi.encointer.getPhaseDurations(),
      webApi.encointer.getCurrentPhase(),
      webApi.encointer.getNextPhaseTimestamp(),
    ]);

    store.settings.setNetworkLoading(false);

    Log.d('Obtained basic network data: ${store.settings.endpoint.value!}', 'Api');

    encointer.getCommunityData();

    // need to do this from here as we can't access instance fields in constructor.
    account.setFetchAccountData(fetchAccountData);
  }

  Future<void> close() async {
    final futures = [
      stopSubscriptions(),
      encointer.close(),
      provider.disconnect(),
    ];

    await Future.wait(futures);
  }

  void fetchAccountData() {
    assets.fetchBalance();
    encointer.getCommunityData();
  }

  Future<void> startSubscriptions() {
    return Future.wait([
      encointer.startSubscriptions(),
      chain.startSubscriptions(),
      assets.startSubscriptions(),
    ]);
  }

  Future<void> stopSubscriptions() {
    return Future.wait([
      encointer.stopSubscriptions(),
      chain.stopSubscriptions(),
      assets.stopSubscriptions(),
    ]);
  }

  Future<bool> isConnected() async {
    final dartConnected = dartApi.isConnected();
    final providerConnected = provider.isConnected();

    Log.d('Dart Rpc Api is connected: $dartConnected', 'Api');
    Log.d('Provider is connected: $providerConnected', 'Api');

    return dartConnected && providerConnected;
  }
}
