import 'package:encointer_wallet/router/app_router.dart';
import 'package:json_annotation/json_annotation.dart';

import 'store/app.dart';

part 'config.g.dart';

@JsonSerializable()
class Config {
  const Config({
    this.initialRoute = AppRoute.splash,
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
