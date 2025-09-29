import 'dart:async';

import 'package:encointer_wallet/config/networks/networks.dart';
import 'package:encointer_wallet/service/substrate_api/asset_hub/asset_hub_api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/service/substrate_api/core/reconnecting_ws_provider.dart';
import 'package:ew_endpoint_manager/endpoint_manager.dart';
import 'package:ew_polkadart/ew_polkadart.dart' show WsProvider;
import 'package:encointer_wallet/service/log/log_service.dart';

const logTarget = 'assetHubWebApi';

class AssetHubNetworkEndpointChecker with EndpointChecker<NetworkEndpoint> {
  // Trivial check if we can connect to an endpoint.
  @override
  Future<bool> checkHealth(NetworkEndpoint endpoint) async {
    Log.d('[NetworkEndpointChecker] Checking health of: ${endpoint.address()}', logTarget);

    final provider = WsProvider(Uri.parse(endpoint.address()));
    await provider.isReady();

    Log.d('[NetworkEndpointChecker] Endpoint ${endpoint.address()} is ready', logTarget);

    await provider.disconnect();
    return true;
  }
}

class AssetHubWebApi {
  AssetHubWebApi(
    this.store,
    this.provider,
    this.api,
  );

  factory AssetHubWebApi.create(AppStore store) {
    // Initialize with default endpoint, will check for healthiness later.
    final provider =
        ReconnectingWsProvider(Uri.parse(store.settings.currentNetwork.defaultAssetHubEndpoint()), autoConnect: false);
    return AssetHubWebApi(
      store,
      provider,
      AssetHubApi(store, provider),
    );
  }

  final AppStore store;

  final ReconnectingWsProvider provider;
  final AssetHubApi api;

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
          Log.p('Provider is disconnected. Trying to connect again...', logTarget);
          await close();
          _connecting = _connect();
        } else {
          Log.p('Still trying to connect..', logTarget);
        }
      }
    });
  }

  Future<void> _connect() async {
    Log.p('Looking for a healthy endpoint...', logTarget);
    final manager = EndpointManager.withEndpoints(
        AssetHubNetworkEndpointChecker(), store.settings.currentNetwork.assetHubEndpoints());
    final endpoint = await manager.pollHealthyEndpoint(randomize: true);
    Log.p('Connecting to healthy endpoint: ${endpoint.address()}', logTarget);

    return provider.connectToNewEndpoint(Uri.parse(endpoint.address())).then((voidValue) async {
      Log.p('Channel is ready...', logTarget);
      if (await isConnected()) {
        return _onConnected();
      } else {
        Log.p('Connection failed will try again...', logTarget);
      }
    }).catchError((dynamic error) {
      // mostly timeouts if the endpoint is not available
      Log.e('error during connection: $error}', logTarget);
    }).whenComplete(() => _connecting == null);
  }

  Future<void> _onConnected() async {
    Log.d('Connected to endpoint: ${provider.url}', logTarget);

    return Future.value();
  }

  Future<void> close() async {
    _timer?.cancel();
    _timer = null;
    _connecting = null;

    await provider
        .disconnect()
        .timeout(const Duration(seconds: 5), onTimeout: () => Log.e('Provider disconnect timeout', logTarget));

    Log.d('Closed webApi connections', logTarget);
  }

  Future<bool> isConnected() async {
    final providerConnected = provider.isConnected();

    Log.d('Provider is connected: $providerConnected', logTarget);

    return providerConnected;
  }
}
