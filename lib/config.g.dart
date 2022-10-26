// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfig _$AppConfigFromJson(Map<String, dynamic> json) => AppConfig(
      initialRoute: json['initialRoute'] as String? ?? SplashView.route,
      mockSubstrateApi: json['mockSubstrateApi'] as bool? ?? false,
      appStoreConfig: $enumDecodeNullable(_$StoreConfigEnumMap, json['appStoreConfig']) ?? StoreConfig.Normal,
    );

Map<String, dynamic> _$AppConfigToJson(AppConfig instance) => <String, dynamic>{
      'initialRoute': instance.initialRoute,
      'mockSubstrateApi': instance.mockSubstrateApi,
      'appStoreConfig': _$StoreConfigEnumMap[instance.appStoreConfig]!,
    };

const _$StoreConfigEnumMap = {
  StoreConfig.Normal: 'Normal',
  StoreConfig.Test: 'Test',
};
