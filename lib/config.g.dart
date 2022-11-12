// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfig _$AppConfigFromJson(Map<String, dynamic> json) => AppConfig(
      initialRoute: json['initialRoute'] as String? ?? SplashView.route,
      mockSubstrateApi: json['mockSubstrateApi'] as bool? ?? false,
      isTest: json['isTest'] as bool? ?? false,
    );

Map<String, dynamic> _$AppConfigToJson(AppConfig instance) => <String, dynamic>{
      'initialRoute': instance.initialRoute,
      'mockSubstrateApi': instance.mockSubstrateApi,
      'isTest': instance.isTest,
    };
