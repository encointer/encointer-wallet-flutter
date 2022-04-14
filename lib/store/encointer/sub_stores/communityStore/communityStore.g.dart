// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communityStore.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityStore _$CommunityStoreFromJson(Map<String, dynamic> json) {
  return CommunityStore(
    json['network'] as String,
    json['cid'] == null
        ? null
        : CommunityIdentifier.fromJson(json['cid'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommunityStoreToJson(CommunityStore instance) =>
    <String, dynamic>{
      'network': instance.network,
      'cid': instance.cid?.toJson(),
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CommunityStore on _CommunityStore, Store {
  final _$_communityAccountStoresAtom =
      Atom(name: '_CommunityStore._communityAccountStores');

  @override
  ObservableMap<String, CommunityAccountStore> get _communityAccountStores {
    _$_communityAccountStoresAtom.reportRead();
    return super._communityAccountStores;
  }

  @override
  set _communityAccountStores(
      ObservableMap<String, CommunityAccountStore> value) {
    _$_communityAccountStoresAtom
        .reportWrite(value, super._communityAccountStores, () {
      super._communityAccountStores = value;
    });
  }

  final _$_CommunityStoreActionController =
      ActionController(name: '_CommunityStore');

  @override
  void initCommunityAccountStore(String account) {
    final _$actionInfo = _$_CommunityStoreActionController.startAction(
        name: '_CommunityStore.initCommunityAccountStore');
    try {
      return super.initCommunityAccountStore(account);
    } finally {
      _$_CommunityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
