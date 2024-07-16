import 'dart:async';

import 'package:encointer_wallet/config/networks/networks.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/mocks/ipfs_api.dart';
import 'package:encointer_wallet/service/ipfs/ipfs_api.dart';
import 'package:encointer_wallet/service/substrate_api/account_api.dart';
import 'package:encointer_wallet/service/substrate_api/assets_api.dart';
import 'package:encointer_wallet/service/substrate_api/chain_api.dart';
import 'package:encointer_wallet/service/substrate_api/core/dart_api.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointer_api.dart';
import 'package:encointer_wallet/service/substrate_api/core/reconnecting_ws_provider.dart';
import 'package:ew_endpoint_manager/endpoint_manager.dart';
import 'package:ew_http/ew_http.dart';
import 'package:ew_polkadart/ew_polkadart.dart';
import 'package:encointer_wallet/service/log/log_service.dart';

/// Global api instance
///
/// `late final` because it will be initialized exactly once in lib/app.dart.
late Api webApi;

class NetworkEndpointChecker with EndpointChecker<NetworkEndpoint> {
  // Trivial check if we can connect to an endpoint.
  @override
  Future<bool> checkHealth(NetworkEndpoint endpoint) async {
    Log.d('[NetworkEndpointChecker] Checking health of: ${endpoint.address()}', 'Api');

    final provider = WsProvider(Uri.parse(endpoint.address()));
    final ready = await provider.ready();

    Log.d('[NetworkEndpointChecker] Endpoint ${endpoint.address()} ready: $ready', 'Api');

    if (!ready) {
      await provider.disconnect();
      return false;
    }

    final offchainIndexing = await SubstrateDartApi(provider).offchainIndexingEnabled();
    Log.d('[NetworkEndpointChecker] Endpoint ${endpoint.address()} offchainIndexingEnabled: $offchainIndexing', 'Api');

    await provider.disconnect();
    // only allow nodes that have offchain indexing enabled
    return offchainIndexing;
  }
}

class Api {
  Api(
    this.store,
    this.provider,
    this.account,
    this.assets,
    this.chain,
    this.encointer,
    this.ipfsApi,
  );

  factory Api.create(
    AppStore store,
    EwHttp ewHttp, {
    bool isIntegrationTest = false,
  }) {
    // Initialize with default endpoint, will check for healthiness later.
    final provider = ReconnectingWsProvider(Uri.parse(store.settings.currentNetwork.defaultEndpoint()), autoConnect: false);
    return Api(
      store,
      provider,
      AccountApi(store, provider),
      AssetsApi(store, EncointerKusama(provider)),
      ChainApi(store, provider),
      EncointerApi(store, SubstrateDartApi(provider), ewHttp, EncointerKusama(provider)),
      isIntegrationTest ? MockIpfsApi(ewHttp) : IpfsApi(ewHttp, gateway: store.settings.ipfsGateway),
    );
  }

  final AppStore store;

  final ReconnectingWsProvider provider;
  final AccountApi account;
  final AssetsApi assets;
  final ChainApi chain;
  final EncointerApi encointer;
  final IpfsApi ipfsApi;

  Future<void>? _connecting;

  /// Timer to regularly check for network connections. This periodic timer will be
  /// paused when the app goes into background, and resumes when the app comes into
  /// the foreground again.
  Timer? _timer;

  Future<void> init() async {
    await close();
    _connecting = _connect();

    _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      if (!provider.isConnected()) {
        if (_connecting == null) {
          Log.p('[webApi] provider is disconnected. Trying to connect again...');
          await close();
          _connecting = _connect();
        } else {
          Log.p('[webApi] still trying to connect..');
        }
      }
    });
  }

  Future<void> _connect() async{
    Log.p('[webApi] Looking for a healthy endpoint...', 'Api');
    final manager = EndpointManager.withEndpoints(NetworkEndpointChecker(), store.settings.currentNetwork.networkEndpoints());
    final endpoint = await manager.pollHealthyEndpoint(randomize: true);

    Log.p('[webApi] Connecting to healthy endpoint: ${endpoint.address()}', 'Api');

    store.settings.setNetworkLoading(true);

    return provider.connectToNewEndpoint(Uri.parse(endpoint.address())).then((voidValue) async {
      Log.p('[webApi] channel is ready...');
      if (await isConnected()) {
        return _onConnected();
      } else {
        Log.p('[webApi] connection failed will try again...');
      }
    }).catchError((dynamic error) {
      // mostly timeouts if the endpoint is not available
      Log.e('[webApi] error during connection: $error}');
    }).whenComplete(() => _connecting == null);
  }

  Future<void> _onConnected() async {
    Log.d('[webApi] Connected to endpoint: ${provider.url}', 'Api');

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

    Log.d('[webApi] Obtained basic network data: ${provider.url}');

    // need to do this from here as we can't access instance fields in constructor.
    account.setFetchAccountData(fetchAccountData);

    fetchAccountData();
  }

  Future<void> close() async {
    _timer?.cancel();
    _timer = null;
    _connecting = null;

    final futures = [
      stopSubscriptions()
          .timeout(const Duration(seconds: 5), onTimeout: () => Log.e('[webApi] stopping subscriptions timeout')),
      provider
          .disconnect()
          .timeout(const Duration(seconds: 5), onTimeout: () => Log.e('[webApi] provider disconnect timeout')),
    ];

    await Future.wait(futures);

    Log.d('[webApi] Closed webApi connections');
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

  Future<void> stopSubscriptions() async {
    await Future.wait([
      encointer.stopSubscriptions(),
      chain.stopSubscriptions(),
      assets.stopSubscriptions(),
    ]);
  }

  Future<bool> isConnected() async {
    final providerConnected = provider.isConnected();

    Log.d('[webApi] Provider is connected: $providerConnected');

    return providerConnected;
  }
}
