// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bazaarStore.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BazaarStore _$BazaarStoreFromJson(Map<String, dynamic> json) {
  return BazaarStore(
    json['network'] as String,
    json['cid'] == null ? null : CommunityIdentifier.fromJson(json['cid'] as Map<String, dynamic>),
  )..businessRegistry = json['businessRegistry'] != null
      ? ObservableList<AccountBusinessTuple>.of((json['businessRegistry'] as List)
          .map((e) => e == null ? null : AccountBusinessTuple.fromJson(e as Map<String, dynamic>)))
      : null;
}

Map<String, dynamic> _$BazaarStoreToJson(BazaarStore instance) => <String, dynamic>{
      'network': instance.network,
      'cid': instance.cid?.toJson(),
      'businessRegistry': instance.businessRegistry?.map((e) => e?.toJson())?.toList(),
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BazaarStore on _BazaarStore, Store {
  final _$businessRegistryAtom = Atom(name: '_BazaarStore.businessRegistry');

  @override
  ObservableList<AccountBusinessTuple> get businessRegistry {
    _$businessRegistryAtom.reportRead();
    return super.businessRegistry;
  }

  @override
  set businessRegistry(ObservableList<AccountBusinessTuple> value) {
    _$businessRegistryAtom.reportWrite(value, super.businessRegistry, () {
      super.businessRegistry = value;
    });
  }

  final _$_BazaarStoreActionController = ActionController(name: '_BazaarStore');

  @override
  void setBusinessRegistry(List<AccountBusinessTuple> accBusinesses) {
    final _$actionInfo = _$_BazaarStoreActionController.startAction(name: '_BazaarStore.setBusinessRegistry');
    try {
      return super.setBusinessRegistry(accBusinesses);
    } finally {
      _$_BazaarStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
businessRegistry: ${businessRegistry}
    ''';
  }
}
