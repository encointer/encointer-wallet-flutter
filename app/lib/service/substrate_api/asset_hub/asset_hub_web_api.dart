import 'dart:async';

import 'package:encointer_wallet/config/networks/networks.dart';
import 'package:encointer_wallet/service/substrate_api/asset_hub/asset_hub_api.dart';
import 'package:encointer_wallet/service/substrate_api/core/reconnecting_ws_provider.dart';
import 'package:ew_endpoint_manager/endpoint_manager.dart';
import 'package:ew_polkadart/ew_polkadart.dart' show WsProvider;
import 'package:encointer_wallet/service/log/log_service.dart';

const logTarget = 'assetHubWebApi';

class AssetHubNetworkEndpointChecker with EndpointChecker<NetworkEndpoint> {
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
    this.provider,
    this.api,
    this.endpoints,
  );

  factory AssetHubWebApi.endpoints(List<Endpoint> endpoints) {
    final provider = ReconnectingWsProvider(Uri.parse(endpoints.first.address()), autoConnect: false);
    return AssetHubWebApi(provider, AssetHubApi(provider), endpoints);
  }

  final List<Endpoint> endpoints;
  final ReconnectingWsProvider provider;
  final AssetHubApi api;

  Future<void>? _connecting;
  Timer? _timer;
  bool _started = false;

  Future<void> init() async {
    if (_started) return;
    _started = true;

    _connecting = _connect();

    _timer = Timer.periodic(const Duration(seconds: 10), (_) async {
      if (!provider.isConnected() && _connecting == null) {
        Log.p('Provider is disconnected. Trying to connect again...', logTarget);
        _connecting = _connect();
      }
    });
  }

  Future<void> _connect() async {
    Log.p('Looking for a healthy endpoint...', logTarget);
    final manager = EndpointManager.withEndpoints(AssetHubNetworkEndpointChecker(), endpoints);
    final endpoint = await manager.pollHealthyEndpoint(randomize: true);
    Log.p('Connecting to healthy endpoint: ${endpoint.address()}', logTarget);

    return provider.connectToNewEndpoint(Uri.parse(endpoint.address())).then((_) async {
      if (provider.isConnected()) {
        Log.p('Channel is ready...', logTarget);
        await _onConnected();
      } else {
        Log.p('Connection failed, will try again...', logTarget);
      }
    }).catchError((dynamic error) {
      Log.e('error during connection: $error', logTarget);
    }).whenComplete(() {
      _connecting = null;
    });
  }

  Future<void> _onConnected() async {
    Log.d('Connected to endpoint: ${provider.url}', logTarget);
    try {
      await provider.isReady();
      Log.d('Provider is fully ready', logTarget);
    } catch (e) {
      Log.e('Provider failed to become ready: $e', logTarget);
    }
  }

  /// Ensure that the provider is ready. Will trigger a reconnect if needed.
  Future<void> ensureReady({Duration timeout = const Duration(seconds: 20)}) async {
    // Already connected? Just wait until ready.
    if (provider.isConnected()) {
      await provider.isReady();
      return;
    }

    // Already trying to connect? Wait for that attempt.
    if (_connecting != null) {
      Log.p('ensureReady: waiting for ongoing connection attempt...', logTarget);
      await _connecting!.timeout(timeout);
      await provider.isReady();
      return;
    }

    // Otherwise, start a new attempt.
    Log.p('ensureReady: provider not connected, reconnecting...', logTarget);
    _connecting = _connect();
    await _connecting!.timeout(timeout);
    await provider.isReady();
  }

  Future<void> _disconnect() async {
    await provider.disconnect().timeout(const Duration(seconds: 5), onTimeout: () {
      Log.e('Provider disconnect timeout', logTarget);
    });
  }

  Future<void> close() async {
    _timer?.cancel();
    _timer = null;
    _connecting = null;
    _started = false;

    await _disconnect();
    Log.d('Closed webApi connections', logTarget);
  }

  Future<void> isReady() async {
    return provider.isReady();
  }

  bool isConnected() {
    final providerConnected = provider.isConnected();
    Log.d('Provider is connected: $providerConnected', logTarget);
    return providerConnected;
  }
}
