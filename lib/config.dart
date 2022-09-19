import 'package:json_annotation/json_annotation.dart';

import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/store/app.dart';

part 'config.g.dart';

@JsonSerializable()
class Config {
  const Config({
    this.initialRoute = SplashView.route,
    this.mockLocalStorage = false,
    this.mockSubstrateApi = false,
    this.appStoreConfig = StoreConfig.Normal,
  });

  final String initialRoute;
  final bool mockLocalStorage;
  final bool mockSubstrateApi;
  final StoreConfig appStoreConfig;

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigToJson(this);
}
