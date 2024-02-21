import 'dart:async';
import 'dart:convert';

import 'package:encointer_wallet/config/consts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/communities/community_metadata.dart';
import 'package:encointer_wallet/models/encointer_balance_data/balance_entry.dart';
import 'package:encointer_wallet/models/location/location.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/encointer/sub_stores/community_store/community_account_store/community_account_store.dart';

part 'community_store.g.dart';

/// Stores data specific to an encointer community.
///
/// It also contains sub-stores for account and community specific data.
@JsonSerializable(explicitToJson: true)
class CommunityStore extends _CommunityStore with _$CommunityStore {
  CommunityStore(super.network, super.cid);

  factory CommunityStore.fromJson(Map<String, dynamic> json) => _$CommunityStoreFromJson(json);
  Map<String, dynamic> toJson() => _$CommunityStoreToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

abstract class _CommunityStore with Store {
  _CommunityStore(this.network, this.cid);

  @JsonKey(includeFromJson: false, includeToJson: false)
  Future<void> Function()? _cacheFn;

  /// Applies demurrage to the `BalanceEntry`
  ///
  /// It is initialized as a field to prevent a cyclic dependency with the rootStore.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @observable
  String? communityIcon;

  @computed
  SvgPicture get icon {
    if (communityIcon != null) {
      return SvgPicture.string(communityIcon!);
    } else {
      return SvgPicture.asset(fallBackCommunityIcon);
    }
  }

  double? Function(BalanceEntry)? get applyDemurrage => _applyDemurrage;

  @action
  Future<String?> getCommunityIcon() async {
    try {
      if (assetsCid != null) {
        Log.e('[getCommunityIcon] get icon with cid: $assetsCid');
        final maybeIcon = await webApi.ipfsApi.getCommunityIcon(assetsCid!);
        Log.e('[getCommunityIcon]: got icon: $maybeIcon');
        if (maybeIcon != null) communityIcon = maybeIcon;
      }
    } catch (e) {
      Log.e('getCommunityIcon $e', 'App Store getCommunityIcon');
    }
    return communityIcon;
  }

  @action
  Future<void> initCommunityAccountStore(String address) {
    if (!communityAccountStores!.containsKey(address)) {
      Log.d('Adding new communityAccountStore for cid: ${cid.toFmtString()} and account: $address', 'CommunityStore');

      final store = CommunityAccountStore(network, cid, address)..initStore(_cacheFn);

      communityAccountStores![address] = store;
      return writeToCache();
    } else {
      Log.d(
        "Don't add already existing communityAccountStore for cid: ${cid.toFmtString()} and account: $address",
        'CommunityStore',
      );
      return Future.value();
    }
  }

  @action
  void setDemurrage(double? d) {
    demurrage = d;
    writeToCache();
  }

  @action
  Future<void> setBootstrappers(List<String> bs) async {
    Log.d('set bootstrappers to $bs', 'CommunityStore');
    bootstrappers = bs;
    unawaited(writeToCache());
  }

  @action
  Future<void> setCommunityMetadata(CommunityMetadata meta) async {
    Log.d('set metadata to $meta', 'CommunityStore');

    metadata = meta;
    await getCommunityIcon();
    unawaited(writeToCache());
  }

  @action
  void setMeetupTime([int? time]) {
    Log.d('set meetupTime to $time', 'CommunityStore');

    if (meetupTime != time) {
      meetupTime = time;
      writeToCache();
    }
  }

  @action
  void setMeetupTimeOverride([int? time]) {
    Log.d('set meetupTimeOverride to $time', 'CommunityStore');

    if (meetupTimeOverride != time) {
      meetupTimeOverride = time;
      writeToCache();
    }
  }

  @action
  void setMeetupLocations(List<Location> locations) {
    Log.d('store: set meetupLocations to $locations', 'CommunityStore');
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
      return Future.value();
    }
  }
}
