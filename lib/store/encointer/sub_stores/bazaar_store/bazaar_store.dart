import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import '../../../../models/bazaar/account_business_tuple.dart';
import '../../../../models/communities/community_identifier.dart';
part 'bazaar_store.g.dart';

/// Stores data concerning the bazaar specific to a community
///
@JsonSerializable(explicitToJson: true)
class BazaarStore extends _BazaarStore with _$BazaarStore {
  BazaarStore(String? network, CommunityIdentifier? cid) : super(network, cid);

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory BazaarStore.fromJson(Map<String, dynamic> json) => _$BazaarStoreFromJson(json);
  Map<String, dynamic> toJson() => _$BazaarStoreToJson(this);
}

abstract class _BazaarStore with Store {
  _BazaarStore(this.network, this.cid);

  /// Function that writes the store to local storage.
  @JsonKey(ignore: true)
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
    this._cacheFn = cacheFn as Future<void> Function()?;
  }

  Future<void> writeToCache() {
    if (_cacheFn != null) {
      return _cacheFn!();
    } else {
      return Future.value(null);
    }
  }
}
