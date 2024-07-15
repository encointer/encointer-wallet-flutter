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
///       we get guaranteed type safety when we extend the enum variant due to the
///       compiler check for exhaustive matching.
enum Network {
  encointerKusama,
  encointerRococo,
  gesell,
  gesellDev;

  factory Network.fromInfoOrDefault(String info) {
    return switch (info) {
      kusamaInfo => Network.encointerKusama,
      rococoInfo => Network.encointerRococo,
      gesellInfo => Network.gesell,
      gesellDevInfo => Network.gesellDev,
      _ => Network.encointerKusama,
    };
  }

  factory Network.tryFromInfo(String info) {
    return switch (info) {
      kusamaInfo => Network.encointerKusama,
      rococoInfo => Network.encointerRococo,
      gesellInfo => Network.gesell,
      gesellDevInfo => Network.gesellDev,
      _ => throw Exception(['Invalid network $info']),
    };
  }

  String info() {
    return switch (this) {
      encointerKusama => kusamaInfo,
      encointerRococo => rococoInfo,
      gesell => gesellInfo,
      gesellDev => gesellDevInfo,
    };
  }

  int ss58() {
    return switch (this) {
      encointerKusama => 2,
      encointerRococo => 42,
      gesell => 42,
      gesellDev => 42,
    };
  }

  String ipfsGateway() {
    return switch (this) {
      encointerKusama => ipfsGatewayEncointer,
      encointerRococo => ipfsGatewayEncointer,
      gesell => ipfsGatewayEncointer,
      // only dev network refers to the local one
      gesellDev => ipfsGatewayLocal,
    };
  }

  /// Exists for simple reverse compatibility.
  String value() {
    return switch (this) {
      encointerKusama => networkEndpoints().first.address,
      encointerRococo => networkEndpoints().first.address,
      gesell => networkEndpoints().first.address,
      // only dev network refers to the local one
      gesellDev => networkEndpoints().first.address,
    };
  }

  List<NetworkEndpoint> networkEndpoints() {
    return switch (this) {
      encointerKusama => kusamaEndpoints(),
      encointerRococo => rococoEndpoints(),
      gesell => gesellEndpoints(),
      gesellDev => gesellDevEndpoints(),
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
