// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map<String, dynamic> json) {
  return Config(
    initialRoute: json['initialRoute'] as String,
    mockLocalStorage: json['mockLocalStorage'] as bool,
    mockSubstrateApi: json['mockSubstrateApi'] as bool,
    appStoreConfig: _$enumDecodeNullable(_$StoreConfigEnumMap, json['appStoreConfig']),
  );
}

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'initialRoute': instance.initialRoute,
      'mockLocalStorage': instance.mockLocalStorage,
      'mockSubstrateApi': instance.mockSubstrateApi,
      'appStoreConfig': _$StoreConfigEnumMap[instance.appStoreConfig],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries.singleWhere((e) => e.value == source, orElse: () => null)?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$StoreConfigEnumMap = {
  StoreConfig.Normal: 'Normal',
  StoreConfig.Test: 'Test',
};
