// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map<String, dynamic> json) => Config(
      initialRoute: json['initialRoute'] as String? ?? SplashView.route,
      mockLocalStorage: json['mockLocalStorage'] as bool? ?? false,
      mockSubstrateApi: json['mockSubstrateApi'] as bool? ?? false,
      appStoreConfig:
          $enumDecodeNullable(_$StoreConfigEnumMap, json['appStoreConfig']) ??
              StoreConfig.Normal,
      js: json['js'] as String,
    );

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'initialRoute': instance.initialRoute,
      'mockLocalStorage': instance.mockLocalStorage,
      'mockSubstrateApi': instance.mockSubstrateApi,
      'appStoreConfig': _$StoreConfigEnumMap[instance.appStoreConfig]!,
      'js': instance.js,
    };

const _$StoreConfigEnumMap = {
  StoreConfig.Normal: 'Normal',
  StoreConfig.Test: 'Test',
};
