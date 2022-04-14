import 'dart:convert';

import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

import 'communityAccountStore/communityAccountStore.dart';

part 'communityStore.g.dart';

/// Stores data specific to an encointer community.
///
///
@JsonSerializable(explicitToJson: true)
class CommunityStore extends _CommunityStore with _$CommunityStore {
  CommunityStore(String network, CommunityIdentifier cid) : super(network, cid);

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory CommunityStore.fromJson(Map<String, dynamic> json) => _$CommunityStoreFromJson(json);
  Map<String, dynamic> toJson() => _$CommunityStoreToJson(this);
}

abstract class _CommunityStore with Store {
  _CommunityStore(this.network, this.cid);

  @JsonKey(ignore: true)
  Future<void> Function() cacheFn;

  final String network;

  final CommunityIdentifier cid;

  @observable
  ObservableMap<String, CommunityAccountStore> communityAccountStores;

  @action
  void initCommunityAccountStore(String account) {
    if (!communityAccountStores.containsKey(account)) {
      _log("Adding new communityAccountStore for cid: ${cid.toFmtString()} and account: $account");

      var store = CommunityAccountStore(network, cid, account);
      store.cacheFn = cacheFn;
      communityAccountStores[account] = store;
    } else {
      _log("Don't add already existing communityAccountStore for cid: ${cid.toFmtString()} and account: $account");
    }
  }
}

void _log(String msg) {
  print("[communityStore] $msg");
}
