import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

@JsonSerializable()
class Config {
  const Config({
    this.initialRoute = SplashView.route,
    this.mockLocalStorage = false,
    this.mockSubstrateApi = false,
    this.appStoreConfig = StoreConfig.Normal,
    required this.js,
  });

  final String initialRoute;
  final bool mockLocalStorage;
  final bool mockSubstrateApi;
  final StoreConfig appStoreConfig;
  final String js;

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigToJson(this);
}
