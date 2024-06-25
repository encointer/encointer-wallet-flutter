// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityStore _$CommunityStoreFromJson(Map<String, dynamic> json) =>
    CommunityStore(
      json['network'] as String,
      CommunityIdentifier.fromJson(json['cid'] as Map<String, dynamic>),
    )
      ..metadata = json['metadata'] == null
          ? null
          : CommunityMetadata.fromJson(json['metadata'] as Map<String, dynamic>)
      ..demurrage = (json['demurrage'] as num?)?.toDouble()
      ..meetupTime = json['meetupTime'] as int?
      ..meetupTimeOverride = json['meetupTimeOverride'] as int?
      ..bootstrappers = (json['bootstrappers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..meetupLocations = json['meetupLocations'] != null
          ? ObservableList<Location>.of((json['meetupLocations'] as List)
              .map((e) => Location.fromJson(e as Map<String, dynamic>)))
          : null
      ..communityAccountStores = json['communityAccountStores'] != null
          ? ObservableMap<String, CommunityAccountStore>.of(
              (json['communityAccountStores'] as Map<String, dynamic>).map(
              (k, e) => MapEntry(
                  k, CommunityAccountStore.fromJson(e as Map<String, dynamic>)),
            ))
          : null
      ..communityIcon = json['communityIcon'] as String?;

Map<String, dynamic> _$CommunityStoreToJson(CommunityStore instance) =>
    <String, dynamic>{
      'network': instance.network,
      'cid': instance.cid.toJson(),
      'metadata': instance.metadata?.toJson(),
      'demurrage': instance.demurrage,
      'meetupTime': instance.meetupTime,
      'meetupTimeOverride': instance.meetupTimeOverride,
      'bootstrappers': instance.bootstrappers,
      'meetupLocations':
          instance.meetupLocations?.map((e) => e.toJson()).toList(),
      'communityAccountStores': instance.communityAccountStores
          ?.map((k, e) => MapEntry(k, e.toJson())),
      'communityIcon': instance.communityIcon,
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CommunityStore on _CommunityStore, Store {
  Computed<String?>? _$nameComputed;

  @override
  String? get name => (_$nameComputed ??=
          Computed<String?>(() => super.name, name: '_CommunityStore.name'))
      .value;
  Computed<String?>? _$symbolComputed;

  @override
  String? get symbol => (_$symbolComputed ??=
          Computed<String?>(() => super.symbol, name: '_CommunityStore.symbol'))
      .value;
  Computed<String?>? _$assetsCidComputed;

  @override
  String? get assetsCid =>
      (_$assetsCidComputed ??= Computed<String?>(() => super.assetsCid,
              name: '_CommunityStore.assetsCid'))
          .value;
  Computed<SvgPicture>? _$iconComputed;

  @override
  SvgPicture get icon => (_$iconComputed ??=
          Computed<SvgPicture>(() => super.icon, name: '_CommunityStore.icon'))
      .value;

  late final _$metadataAtom =
      Atom(name: '_CommunityStore.metadata', context: context);

  @override
  CommunityMetadata? get metadata {
    _$metadataAtom.reportRead();
    return super.metadata;
  }

  @override
  set metadata(CommunityMetadata? value) {
    _$metadataAtom.reportWrite(value, super.metadata, () {
      super.metadata = value;
    });
  }

  late final _$demurrageAtom =
      Atom(name: '_CommunityStore.demurrage', context: context);

  @override
  double? get demurrage {
    _$demurrageAtom.reportRead();
    return super.demurrage;
  }

  @override
  set demurrage(double? value) {
    _$demurrageAtom.reportWrite(value, super.demurrage, () {
      super.demurrage = value;
    });
  }

  late final _$meetupTimeAtom =
      Atom(name: '_CommunityStore.meetupTime', context: context);

  @override
  int? get meetupTime {
    _$meetupTimeAtom.reportRead();
    return super.meetupTime;
  }

  @override
  set meetupTime(int? value) {
    _$meetupTimeAtom.reportWrite(value, super.meetupTime, () {
      super.meetupTime = value;
    });
  }

  late final _$meetupTimeOverrideAtom =
      Atom(name: '_CommunityStore.meetupTimeOverride', context: context);

  @override
  int? get meetupTimeOverride {
    _$meetupTimeOverrideAtom.reportRead();
    return super.meetupTimeOverride;
  }

  @override
  set meetupTimeOverride(int? value) {
    _$meetupTimeOverrideAtom.reportWrite(value, super.meetupTimeOverride, () {
      super.meetupTimeOverride = value;
    });
  }

  late final _$bootstrappersAtom =
      Atom(name: '_CommunityStore.bootstrappers', context: context);

  @override
  List<String>? get bootstrappers {
    _$bootstrappersAtom.reportRead();
    return super.bootstrappers;
  }

  @override
  set bootstrappers(List<String>? value) {
    _$bootstrappersAtom.reportWrite(value, super.bootstrappers, () {
      super.bootstrappers = value;
    });
  }

  late final _$meetupLocationsAtom =
      Atom(name: '_CommunityStore.meetupLocations', context: context);

  @override
  ObservableList<Location>? get meetupLocations {
    _$meetupLocationsAtom.reportRead();
    return super.meetupLocations;
  }

  @override
  set meetupLocations(ObservableList<Location>? value) {
    _$meetupLocationsAtom.reportWrite(value, super.meetupLocations, () {
      super.meetupLocations = value;
    });
  }

  late final _$communityAccountStoresAtom =
      Atom(name: '_CommunityStore.communityAccountStores', context: context);

  @override
  ObservableMap<String, CommunityAccountStore>? get communityAccountStores {
    _$communityAccountStoresAtom.reportRead();
    return super.communityAccountStores;
  }

  @override
  set communityAccountStores(
      ObservableMap<String, CommunityAccountStore>? value) {
    _$communityAccountStoresAtom
        .reportWrite(value, super.communityAccountStores, () {
      super.communityAccountStores = value;
    });
  }

  late final _$communityIconAtom =
      Atom(name: '_CommunityStore.communityIcon', context: context);

  @override
  String? get communityIcon {
    _$communityIconAtom.reportRead();
    return super.communityIcon;
  }

  @override
  set communityIcon(String? value) {
    _$communityIconAtom.reportWrite(value, super.communityIcon, () {
      super.communityIcon = value;
    });
  }

  late final _$getCommunityIconAsyncAction =
      AsyncAction('_CommunityStore.getCommunityIcon', context: context);

  @override
  Future<String?> getCommunityIcon() {
    return _$getCommunityIconAsyncAction.run(() => super.getCommunityIcon());
  }

  late final _$setBootstrappersAsyncAction =
      AsyncAction('_CommunityStore.setBootstrappers', context: context);

  @override
  Future<void> setBootstrappers(List<String> bs) {
    return _$setBootstrappersAsyncAction.run(() => super.setBootstrappers(bs));
  }

  late final _$setCommunityMetadataAsyncAction =
      AsyncAction('_CommunityStore.setCommunityMetadata', context: context);

  @override
  Future<void> setCommunityMetadata(CommunityMetadata meta) {
    return _$setCommunityMetadataAsyncAction
        .run(() => super.setCommunityMetadata(meta));
  }

  late final _$_CommunityStoreActionController =
      ActionController(name: '_CommunityStore', context: context);

  @override
  Future<void> initCommunityAccountStore(String address) {
    final _$actionInfo = _$_CommunityStoreActionController.startAction(
        name: '_CommunityStore.initCommunityAccountStore');
    try {
      return super.initCommunityAccountStore(address);
    } finally {
      _$_CommunityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDemurrage(double? d) {
    final _$actionInfo = _$_CommunityStoreActionController.startAction(
        name: '_CommunityStore.setDemurrage');
    try {
      return super.setDemurrage(d);
    } finally {
      _$_CommunityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMeetupTime([int? time]) {
    final _$actionInfo = _$_CommunityStoreActionController.startAction(
        name: '_CommunityStore.setMeetupTime');
    try {
      return super.setMeetupTime(time);
    } finally {
      _$_CommunityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMeetupTimeOverride([int? time]) {
    final _$actionInfo = _$_CommunityStoreActionController.startAction(
        name: '_CommunityStore.setMeetupTimeOverride');
    try {
      return super.setMeetupTimeOverride(time);
    } finally {
      _$_CommunityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMeetupLocations(List<Location> locations) {
    final _$actionInfo = _$_CommunityStoreActionController.startAction(
        name: '_CommunityStore.setMeetupLocations');
    try {
      return super.setMeetupLocations(locations);
    } finally {
      _$_CommunityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void purgeCeremonySpecificState() {
    final _$actionInfo = _$_CommunityStoreActionController.startAction(
        name: '_CommunityStore.purgeCeremonySpecificState');
    try {
      return super.purgeCeremonySpecificState();
    } finally {
      _$_CommunityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
metadata: ${metadata},
demurrage: ${demurrage},
meetupTime: ${meetupTime},
meetupTimeOverride: ${meetupTimeOverride},
bootstrappers: ${bootstrappers},
meetupLocations: ${meetupLocations},
communityAccountStores: ${communityAccountStores},
communityIcon: ${communityIcon},
name: ${name},
symbol: ${symbol},
assetsCid: ${assetsCid},
icon: ${icon}
    ''';
  }
}
