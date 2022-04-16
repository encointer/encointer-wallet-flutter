// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communityStore.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityStore _$CommunityStoreFromJson(Map<String, dynamic> json) {
  return CommunityStore(
    json['network'] as String,
    json['cid'] == null ? null : CommunityIdentifier.fromJson(json['cid'] as Map<String, dynamic>),
  )
    ..communityMetadata = json['communityMetadata'] == null
        ? null
        : CommunityMetadata.fromJson(json['communityMetadata'] as Map<String, dynamic>)
    ..demurrage = (json['demurrage'] as num)?.toDouble()
    ..meetupTime = json['meetupTime'] as int
    ..bootstrappers = (json['bootstrappers'] as List)?.map((e) => e as String)?.toList()
    ..communityAccountStores = json['communityAccountStores'] != null
        ? ObservableMap<String, CommunityAccountStore>.of((json['communityAccountStores'] as Map<String, dynamic>).map(
            (k, e) => MapEntry(k, e == null ? null : CommunityAccountStore.fromJson(e as Map<String, dynamic>)),
          ))
        : null;
}

Map<String, dynamic> _$CommunityStoreToJson(CommunityStore instance) => <String, dynamic>{
      'network': instance.network,
      'cid': instance.cid?.toJson(),
      'communityMetadata': instance.communityMetadata?.toJson(),
      'demurrage': instance.demurrage,
      'meetupTime': instance.meetupTime,
      'bootstrappers': instance.bootstrappers,
      'communityAccountStores': instance.communityAccountStores?.map((k, e) => MapEntry(k, e?.toJson())),
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CommunityStore on _CommunityStore, Store {
  Computed<String> _$nameComputed;

  @override
  String get name => (_$nameComputed ??= Computed<String>(() => super.name, name: '_CommunityStore.name')).value;
  Computed<String> _$symbolComputed;

  @override
  String get symbol =>
      (_$symbolComputed ??= Computed<String>(() => super.symbol, name: '_CommunityStore.symbol')).value;
  Computed<String> _$assetsCidComputed;

  @override
  String get assetsCid =>
      (_$assetsCidComputed ??= Computed<String>(() => super.assetsCid, name: '_CommunityStore.assetsCid')).value;

  final _$communityMetadataAtom = Atom(name: '_CommunityStore.communityMetadata');

  @override
  CommunityMetadata get communityMetadata {
    _$communityMetadataAtom.reportRead();
    return super.communityMetadata;
  }

  @override
  set communityMetadata(CommunityMetadata value) {
    _$communityMetadataAtom.reportWrite(value, super.communityMetadata, () {
      super.communityMetadata = value;
    });
  }

  final _$demurrageAtom = Atom(name: '_CommunityStore.demurrage');

  @override
  double get demurrage {
    _$demurrageAtom.reportRead();
    return super.demurrage;
  }

  @override
  set demurrage(double value) {
    _$demurrageAtom.reportWrite(value, super.demurrage, () {
      super.demurrage = value;
    });
  }

  final _$meetupTimeAtom = Atom(name: '_CommunityStore.meetupTime');

  @override
  int get meetupTime {
    _$meetupTimeAtom.reportRead();
    return super.meetupTime;
  }

  @override
  set meetupTime(int value) {
    _$meetupTimeAtom.reportWrite(value, super.meetupTime, () {
      super.meetupTime = value;
    });
  }

  final _$bootstrappersAtom = Atom(name: '_CommunityStore.bootstrappers');

  @override
  List<String> get bootstrappers {
    _$bootstrappersAtom.reportRead();
    return super.bootstrappers;
  }

  @override
  set bootstrappers(List<String> value) {
    _$bootstrappersAtom.reportWrite(value, super.bootstrappers, () {
      super.bootstrappers = value;
    });
  }

  final _$communityAccountStoresAtom = Atom(name: '_CommunityStore.communityAccountStores');

  @override
  ObservableMap<String, CommunityAccountStore> get communityAccountStores {
    _$communityAccountStoresAtom.reportRead();
    return super.communityAccountStores;
  }

  @override
  set communityAccountStores(ObservableMap<String, CommunityAccountStore> value) {
    _$communityAccountStoresAtom.reportWrite(value, super.communityAccountStores, () {
      super.communityAccountStores = value;
    });
  }

  final _$_CommunityStoreActionController = ActionController(name: '_CommunityStore');

  @override
  void initCommunityAccountStore(String address) {
    final _$actionInfo =
        _$_CommunityStoreActionController.startAction(name: '_CommunityStore.initCommunityAccountStore');
    try {
      return super.initCommunityAccountStore(address);
    } finally {
      _$_CommunityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDemurrage(double d) {
    final _$actionInfo = _$_CommunityStoreActionController.startAction(name: '_CommunityStore.setDemurrage');
    try {
      return super.setDemurrage(d);
    } finally {
      _$_CommunityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBootstrappers(List<String> bs) {
    final _$actionInfo = _$_CommunityStoreActionController.startAction(name: '_CommunityStore.setBootstrappers');
    try {
      return super.setBootstrappers(bs);
    } finally {
      _$_CommunityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCommunityMetadata([CommunityMetadata meta]) {
    final _$actionInfo = _$_CommunityStoreActionController.startAction(name: '_CommunityStore.setCommunityMetadata');
    try {
      return super.setCommunityMetadata(meta);
    } finally {
      _$_CommunityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMeetupTime([int time]) {
    final _$actionInfo = _$_CommunityStoreActionController.startAction(name: '_CommunityStore.setMeetupTime');
    try {
      return super.setMeetupTime(time);
    } finally {
      _$_CommunityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void purgeCeremonySpecificState() {
    final _$actionInfo =
        _$_CommunityStoreActionController.startAction(name: '_CommunityStore.purgeCeremonySpecificState');
    try {
      return super.purgeCeremonySpecificState();
    } finally {
      _$_CommunityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
communityMetadata: ${communityMetadata},
demurrage: ${demurrage},
meetupTime: ${meetupTime},
bootstrappers: ${bootstrappers},
communityAccountStores: ${communityAccountStores},
name: ${name},
symbol: ${symbol},
assetsCid: ${assetsCid}
    ''';
  }
}
