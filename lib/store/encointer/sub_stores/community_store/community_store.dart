import 'dart:convert';

import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/communities/community_metadata.dart';
import 'package:encointer_wallet/models/encointer_balance_data/balance_entry.dart';
import 'package:encointer_wallet/models/location/location.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/encointer/sub_stores/community_store/community_account_store/community_account_store.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'community_store.g.dart';

/// Stores data specific to an encointer community.
///
/// It also contains sub-stores for account and community specific data.
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
  Future<void> Function()? _cacheFn;

  /// Applies demurrage to the `BalanceEntry`
  ///
  /// It is initialized as a field to prevent a cyclic dependency with the rootStore.
  @JsonKey(ignore: true)
  double? Function(BalanceEntry)? _applyDemurrage;

  final String network;

  final CommunityIdentifier cid;

  @observable
  CommunityMetadata? metadata;

  @observable
  double? demurrage;

  @computed
  String? get name => metadata?.name;

  @computed
  String? get symbol => metadata?.symbol;

  @computed
  String? get assetsCid => metadata?.assets;

  @observable
  int? meetupTime;

  /// Override set by the encointer feed.
  @observable
  int? meetupTimeOverride;

  @observable
  List<String>? bootstrappers;

  @observable
  ObservableList<Location>? meetupLocations = ObservableList();

  @observable
  ObservableMap<String, CommunityAccountStore>? communityAccountStores = ObservableMap();

  get applyDemurrage => _applyDemurrage;

  @action
  Future<void> initCommunityAccountStore(String address) {
    if (!communityAccountStores!.containsKey(address)) {
      _log('Adding new communityAccountStore for cid: ${cid.toFmtString()} and account: $address');

      var store = CommunityAccountStore(network, cid, address);
      store.initStore(_cacheFn);

      communityAccountStores![address] = store;
      return writeToCache();
    } else {
      _log("Don't add already existing communityAccountStore for cid: ${cid.toFmtString()} and account: $address");
      return Future.value(null);
    }
  }

  @action
  void setDemurrage(double? d) {
    demurrage = d;
    writeToCache();
  }

  @action
  void setBootstrappers(List<String> bs) {
    _log('set bootstrappers to $bs');
    bootstrappers = bs;
    writeToCache();
  }

  @action
  void setCommunityMetadata(CommunityMetadata meta) {
    _log('set metadata to $meta');
    metadata = meta;
    writeToCache();
  }

  @action
  void setMeetupTime([int? time]) {
    _log('set meetupTime to $time');
    if (meetupTime != time) {
      meetupTime = time;
      writeToCache();
    }
  }

  @action
  void setMeetupTimeOverride([int? time]) {
    _log('set meetupTimeOverride to $time');
    if (meetupTimeOverride != time) {
      meetupTimeOverride = time;
      writeToCache();
    }
  }

  @action
  void setMeetupLocations(List<Location> locations) {
    _log('store: set meetupLocations to ${locations.toString()}');
    meetupLocations = ObservableList.of(locations);
    writeToCache();

    // There is no race-condition with the `getMeetupTime` call in `setMeetupLocation` because `getMeetupTime` uses
    // internally the `meetupLocation`. Hence, the worst case scenario is a redundant rpc call.
    webApi.encointer.getMeetupTime();
  }

  /// Purges state that is only relevant for one Ceremony.
  ///
  /// This should be called when a transition to the next ceremony happens.
  @action
  void purgeCeremonySpecificState() {
    setMeetupTime();
    communityAccountStores!.forEach((key, value) => value.purgeCeremonySpecificState());
  }

  void initStore(Function? cacheFn, double? Function(BalanceEntry)? applyDemurrage) {
    _cacheFn = cacheFn as Future<void> Function()?;
    _applyDemurrage = applyDemurrage;

    communityAccountStores!.forEach((_, store) => store.initStore(cacheFn));
  }

  Future<void> writeToCache() {
    if (_cacheFn != null) {
      return _cacheFn!();
    } else {
      return Future.value(null);
    }
  }
}

void _log(String msg) {
  print('[communityStore] $msg');
}
