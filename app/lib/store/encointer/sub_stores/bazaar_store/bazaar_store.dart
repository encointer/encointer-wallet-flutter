import 'dart:convert';
import 'dart:developer';

import 'package:encointer_wallet/models/bazaar/account_business_tuple.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'bazaar_store.g.dart';

/// Stores data concerning the bazaar specific to a community
///
@JsonSerializable(explicitToJson: true)
class BazaarStore extends _BazaarStore with _$BazaarStore {
  BazaarStore(super.network, super.cid);

  factory BazaarStore.fromJson(Map<String, dynamic> json) => _$BazaarStoreFromJson(json);
  Map<String, dynamic> toJson() => _$BazaarStoreToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

abstract class _BazaarStore with Store {
  _BazaarStore(this.network, this.cid);

  /// Function that writes the store to local storage.
  @JsonKey(includeFromJson: false, includeToJson: false)
  Future<void> Function()? _cacheFn;

  /// The network this store belongs to.
  final String? network;

  /// The community this store belongs to.
  final CommunityIdentifier? cid;

  /// List of registered businesses in this community.
  @observable
  ObservableList<AccountBusinessTuple>? businessRegistry;

  @action
  void setBusinessRegistry(List<AccountBusinessTuple> accBusinesses) {
    businessRegistry = ObservableList.of(accBusinesses);
    writeToCache();
  }

  void initStore(Function? cacheFn) {
    _cacheFn = cacheFn as Future<void> Function()?;
  }

  Future<void> bazaarGetBusinesses(CommunityIdentifier cid) async {
    final bazaars = await webApi.encointer.bazaarGetBusinesses(cid);
    log('bazaarGetBusinesses bazaars: $bazaars');
    setBusinessRegistry(bazaars);
  }

  Future<void> writeToCache() {
    if (_cacheFn != null) {
      return _cacheFn!();
    } else {
      return Future.value();
    }
  }
}
