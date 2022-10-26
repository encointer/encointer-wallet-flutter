import 'package:json_annotation/json_annotation.dart';

import 'package:encointer_wallet/modules/modules.dart';

part 'config.g.dart';

@JsonSerializable()
class AppConfig {
  const AppConfig({
    this.initialRoute = SplashView.route,
    this.mockSubstrateApi = false,
    this.isTest = false,
  });

  final String initialRoute;
  final bool mockSubstrateApi;
  final bool isTest;

  factory AppConfig.fromJson(Map<String, dynamic> json) => _$AppConfigFromJson(json);
  Map<String, dynamic> toJson() => _$AppConfigToJson(this);
}

// enum StoreConfig {
//   Normal,
//   Test,
// }

// extension StoreConfigExtensions on StoreConfig {
//   bool isTest() {
//     return this == StoreConfig.Test;
//   }

//   bool isNormal() {
//     return this == StoreConfig.Normal;
//   }
// }
