import 'dart:io';

import 'package:encointer_wallet/config/consts.dart';

class NetworkEndpoint {
  NetworkEndpoint({required this.name, required this.address});

  final String name;
  final String address;
}

const String gesellInfo = 'nctr-gsl';
const String gesellDevInfo = 'nctr-gsl-dev';
const String rococoInfo = 'nctr-r';
const String kusamaInfo = 'nctr-k';

/// Enum representing the different networks.
///
/// NOTE: We shouldn't do `_` wildcard matching in the switch statement so that
///       we get guaranteed type safety when we extend the enum variant due to
///       compiler check for exhaustive matching.
enum Network {
  gesell,
  gesellDev,
  rococo,
  kusama;

  factory Network.fromInfoOrDefault(String info) {
    return switch (info) {
      gesellInfo => Network.gesell,
      rococoInfo => Network.rococo,
      kusamaInfo => Network.kusama,
      gesellDevInfo => Network.gesellDev,
      _ => Network.kusama,
    };
  }

  factory Network.tryFromInfo(String info) {
    return switch (info) {
      gesellInfo => Network.gesell,
      rococoInfo => Network.rococo,
      kusamaInfo => Network.kusama,
      gesellDevInfo => Network.gesellDev,
      _ => throw Exception(['Invalid network $info']),
    };
  }

  String info() {
    return switch (this) {
      gesell => gesellInfo,
      gesellDev => gesellDevInfo,
      rococo => rococoInfo,
      kusama => kusamaInfo,
    };
  }

  int ss58() {
    return switch (this) {
      gesell => 42,
      gesellDev => 42,
      rococo => 42,
      kusama => 2,
    };
  }

  String ipfsGateway() {
    return switch (this) {
      gesell => ipfsGatewayEncointer,
      rococo => ipfsGatewayEncointer,
      kusama => ipfsGatewayEncointer,
      // only dev network refers to the local one
      gesellDev => ipfsGatewayLocal,
    };
  }

  /// Exists for simple reverse compatibility.
  String value() {
    return switch (this) {
      gesell => networkEndpoints().first.address,
      rococo => networkEndpoints().first.address,
      kusama => networkEndpoints().first.address,
    // only dev network refers to the local one
      gesellDev => networkEndpoints().first.address,
    };
  }


  List<NetworkEndpoint> networkEndpoints() {
    return switch (this) {
      gesell => gesellEndpoints(),
      gesellDev => gesellDevEndpoints(),
      rococo => rococoEndpoints(),
      kusama => kusamaEndpoints(),
    };
  }
}

List<NetworkEndpoint> gesellEndpoints() {
  return [
    NetworkEndpoint(name: 'Encointer Gesell (Hosted by Encointer Association)', address: 'wss://gesell.encointer.org')
  ];
}

List<NetworkEndpoint> gesellDevEndpoints() {
  return [
    NetworkEndpoint(
        name: 'Encointer Gesell Local DevNet',
        address: 'ws://${Platform.isAndroid ? androidLocalHost : iosLocalHost}:9944')
  ];
}

List<NetworkEndpoint> rococoEndpoints() {
  return [
    NetworkEndpoint(
        name: 'Encointer Lietaer on Rococo (Hosted by Encointer Association)',
        address: 'wss://rococo.api.encointer.org')
  ];
}

List<NetworkEndpoint> kusamaEndpoints() {
  return [
    NetworkEndpoint(
        name: 'Encointer Network on Kusama (Hosted by Encointer Association)',
        address: 'wss://kusama.api.encointer.org')
  ];
}
