import 'package:json_annotation/json_annotation.dart';
import 'package:encointer_wallet/page-encointer/homePage.dart';

import 'store/app.dart';

part 'config.g.dart';

@JsonSerializable()
class Config {
  const Config({
    this.initialRoute = EncointerHomePage.route,
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
