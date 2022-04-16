import 'dart:convert';

import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:encointer_wallet/store/encointer/types/encointerBalanceData.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'encointerAccountStore.g.dart';

/// Stores data specific to an account across all communities.
///
///
@JsonSerializable(explicitToJson: true)
class EncointerAccountStore extends _EncointerAccountStore with _$EncointerAccountStore {
  EncointerAccountStore(String network, String address) : super(network, address);

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory EncointerAccountStore.fromJson(Map<String, dynamic> json) => _$EncointerAccountStoreFromJson(json);
  Map<String, dynamic> toJson() => _$EncointerAccountStoreToJson(this);
}

abstract class _EncointerAccountStore with Store {
  _EncointerAccountStore(this.network, this.address);

  @JsonKey(ignore: true)
  Future<void> Function() cacheFn;

  /// The network this store belongs to.
  final String network;

  /// The account (SS58) this store belongs to.
  final String address;

  /// `BalanceEntries` for the respective community
  ///
  /// Map: cid.toFmtString() -> BalanceEntry
  @observable
  ObservableMap<String, BalanceEntry> balanceEntries = new ObservableMap();

  /// `CommunityReputations` across all communities keyed by the respective ceremony index.
  ///
  /// Map: ceremony index -> CommunityReputation
  @observable
  Map<int, CommunityReputation> reputations;

  @computed
  get ceremonyIndexForProofOfAttendance {
    if (reputations != null && reputations.isNotEmpty) {
      try {
        return reputations.entries.firstWhere((e) => e.value.reputation == Reputation.VerifiedUnlinked).key;
      } catch (_e) {
        _log("$address has reputation, but none that has not been linked yet");
        return 0;
      }
    }
  }

  @action
  void addBalanceEntry(CommunityIdentifier cid, BalanceEntry balanceEntry) {
    _log("balanceEntry $balanceEntry added to cid $cid added");
    balanceEntries[cid.toFmtString()] = balanceEntry;
    cacheFn();
  }

  @action
  void setReputations(Map<int, CommunityReputation> reps) {
    reputations = reps;
    cacheFn();
  }

  @action
  void purgeReputations() {
    if (reputations != null) {
      reputations.clear();
      cacheFn();
    }
  }

  @action
  void purgeCeremonySpecificState() {
    purgeReputations();
  }

  void setCacheFn(Function cacheFn) {
    this.cacheFn = cacheFn;
  }
}

void _log(String msg) {
  print("[encointerAccountStore] $msg");
}
