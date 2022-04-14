import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

import 'communityAccountStore/communityAccountStore.dart';

part 'communityStore.g.dart';

/// Stores data specific to an encointer community.
///
///
@JsonSerializable(explicitToJson: true)
class CommunityStore extends _CommunityStore with _$CommunityStore {
  CommunityStore() : super();

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory CommunityStore.fromJson(Map<String, dynamic> json) => _$CommunityStoreFromJson(json);
  Map<String, dynamic> toJson() => _$CommunityStoreToJson(this);
}

abstract class _CommunityStore with Store {
  _CommunityStore();

  @JsonKey(ignore: true)
  Function cacheFn;

  @observable
  ObservableMap<String, CommunityAccountStore> _communityAccountStores;
}
