import 'dart:io';

import 'package:encointer_wallet/config/consts.dart';
import 'package:ew_endpoint_manager/endpoint_manager.dart';

class NetworkEndpoint with Endpoint {
  NetworkEndpoint({required this.name, required String address}) : _address = address;

  final String name;
  final String _address;

  @override
  String address() => _address;
}

const String gesellId = 'nctr-gsl';
const String rococoId = 'nctr-r';
const String kusamaId = 'nctr-k';

// Dev networks
const String gesellDevId = 'nctr-gsl-dev';
const String zombienetId = 'nctr-zombienet';

/// Enum representing the different networks.
enum Network {
  encointerKusama,
  encointerRococo,
  gesell,
  gesellDev,
  zombienetLocal;

  factory Network.fromInfoOrDefault(String info) {
    return switch (info) {
      kusamaId => Network.encointerKusama,
      rococoId => Network.encointerRococo,
      gesellId => Network.gesell,
      gesellDevId => Network.gesellDev,
      zombienetId => Network.zombienetLocal,
      _ => Network.encointerKusama,
    };
  }

  factory Network.tryFromInfo(String info) {
    return switch (info) {
      kusamaId => Network.encointerKusama,
      rococoId => Network.encointerRococo,
      gesellId => Network.gesell,
      gesellDevId => Network.gesellDev,
      zombienetId => Network.zombienetLocal,
      _ => throw Exception(['Invalid network $info']),
    };
  }

  String id() {
    return switch (this) {
      encointerKusama => kusamaId,
      encointerRococo => rococoId,
      gesell => gesellId,
      gesellDev => gesellDevId,
      zombienetLocal => zombienetId,
    };
  }

  int ss58() {
    return switch (this) {
      encointerKusama => 2,
      encointerRococo => 42,
      gesell => 42,
      gesellDev => 42,
      zombienetLocal => 2,
    };
  }

  /// After #1603 is implemented, we can also replace this with multiple endpoints,
  /// such that we have fallback endpoints.
  String ipfsGateway() {
    return switch (this) {
      encointerKusama => ipfsGatewayEncointer,
      encointerRococo => ipfsGatewayEncointer,
      gesell => ipfsGatewayEncointer,
      // only dev network refers to the local one
      gesellDev => ipfsGatewayLocal,
      zombienetLocal => ipfsGatewayLocal,
    };
  }

  /// IPFS Auth Gateway URL for authenticated uploads.
  String ipfsAuthGateway() {
    return switch (this) {
      encointerKusama => ipfsAuthGatewayEncointer,
      encointerRococo => ipfsAuthGatewayEncointer,
      gesell => ipfsAuthGatewayEncointer,
      // only dev network refers to the local one
      gesellDev => ipfsAuthGatewayLocal,
      zombienetLocal => ipfsAuthGatewayLocal,
    };
  }

  String defaultEndpoint() {
    return switch (this) {
      encointerKusama => networkEndpoints().first.address(),
      encointerRococo => networkEndpoints().first.address(),
      gesell => networkEndpoints().first.address(),
      // only dev network refers to the local one
      gesellDev => networkEndpoints().first.address(),
      zombienetLocal => networkEndpoints().first.address(),
    };
  }

  List<NetworkEndpoint> networkEndpoints() {
    return switch (this) {
      encointerKusama => kusamaEndpoints(),
      encointerRococo => rococoEndpoints(),
      gesell => gesellEndpoints(),
      gesellDev => gesellDevEndpoints(),
      zombienetLocal => zombienetLocalEndpoints(),
    };
  }

  List<NetworkEndpoint> assetHubEndpoints() {
    return assetHubKusamaEndpoints();
  }

  String defaultAssetHubEndpoint() {
    return assetHubKusamaEndpoints().first.address();
  }
}

List<NetworkEndpoint> gesellEndpoints() {
  return [NetworkEndpoint(name: 'Encointer Association', address: 'wss://gesell.encointer.org')];
}

List<NetworkEndpoint> rococoEndpoints() {
  return [
    NetworkEndpoint(name: 'Encointer Association', address: 'wss://rococo.api.encointer.org'),
  ];
}

List<NetworkEndpoint> kusamaEndpoints() {
  return [
    NetworkEndpoint(name: 'Encointer Association', address: 'wss://kusama.api.encointer.org'),
    NetworkEndpoint(name: 'Dwellir', address: 'wss://encointer-kusama-rpc.dwellir.com'),
    NetworkEndpoint(name: 'IBP1', address: 'wss://sys.ibp.network/encointer-kusama'),
    // NetworkEndpoint(name: 'IBP2', address: 'wss://sys.dotters.network/encointer-kusama'),
    NetworkEndpoint(name: 'Lucky Friday', address: 'wss://rpc-encointer-kusama.luckyfriday.io'),
  ];
}

// Dev Endpoints
const wsAhFromEnv = String.fromEnvironment('WS_ENDPOINT_AH');

List<NetworkEndpoint> assetHubKusamaEndpoints() {
  final wsAhRemote = [
    NetworkEndpoint(name: 'Dwellir', address: 'wss://asset-hub-kusama-rpc.n.dwellir.com'),
    NetworkEndpoint(name: 'Dwellir Tunisia', address: 'wss://statemine-rpc-tn.dwellir.com'),
    NetworkEndpoint(name: 'IBP1', address: 'wss://sys.ibp.network/asset-hub-kusama'),
    NetworkEndpoint(name: 'IBP2', address: 'wss://asset-hub-kusama.dotters.network'),
    NetworkEndpoint(name: 'Lucky Friday', address: 'wss://rpc-asset-hub-kusama.luckyfriday.io'),
    NetworkEndpoint(name: 'OnFinality', address: 'wss://assethub-kusama.api.onfinality.io/public-ws'),
    NetworkEndpoint(name: 'RadiumBlock', address: 'wss://statemine.public.curie.radiumblock.co/ws'),
  ];
  return wsAhFromEnv.isNotEmpty ? [NetworkEndpoint(name: 'Local AhDevNet', address: wsAhFromEnv)] : wsAhRemote;
}

// Dev Endpoints
const wsFromEnv = String.fromEnvironment('WS_ENDPOINT');

List<NetworkEndpoint> zombienetLocalEndpoints() {
  final wsEndpoint =
      wsFromEnv.isNotEmpty ? wsFromEnv : 'ws://${Platform.isAndroid ? androidLocalHost : iosLocalHost}:9944';

  return [NetworkEndpoint(name: 'Local DevNet', address: wsEndpoint)];
}

List<NetworkEndpoint> gesellDevEndpoints() {
  final wsEndpoint =
      wsFromEnv.isNotEmpty ? wsFromEnv : 'ws://${Platform.isAndroid ? androidLocalHost : iosLocalHost}:9944';

  return [NetworkEndpoint(name: 'Local DevNet', address: wsEndpoint)];
}
