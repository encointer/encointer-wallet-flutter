// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encointerAccountStore.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EncointerAccountStore _$EncointerAccountStoreFromJson(Map<String, dynamic> json) {
  return EncointerAccountStore(
    json['network'] as String,
    json['address'] as String,
  );
}

Map<String, dynamic> _$EncointerAccountStoreToJson(EncointerAccountStore instance) => <String, dynamic>{
      'network': instance.network,
      'address': instance.address,
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EncointerAccountStore on _EncointerAccountStore, Store {
  @override
  String toString() {
    return '''

    ''';
  }
}
