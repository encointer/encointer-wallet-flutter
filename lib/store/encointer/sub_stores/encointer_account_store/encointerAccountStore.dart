import 'dart:convert';

import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/store/assets/types/transferData.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:encointer_wallet/store/encointer/types/encointerBalanceData.dart';
import 'package:encointer_wallet/utils/format.dart';
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
  Future<void> Function() _cacheFn;

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

  @observable
  ObservableList<TransferData> txsTransfer = ObservableList<TransferData>();

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
    writeToCache();
  }

  @action
  void setReputations(Map<int, CommunityReputation> reps) {
    reputations = reps;
    writeToCache();
  }

  @action
  void purgeReputations() {
    if (reputations != null) {
      reputations.clear();
      writeToCache();
    }
  }

  @action
  void purgeCeremonySpecificState() {
    purgeReputations();
  }

  @action
  Future<void> setTransferTxs(List list, String address, {bool reset = false, needCache = true}) async {
    if (this.address != address) {
      _log("Tried to cached transfer tx's for wrong account. This is a bug.");
      return null;
    }

    List transfers = list.map((i) {
      return {
        "block_timestamp": i['time'],
        "hash": i['hash'],
        "success": true,
        "from": address,
        "to": i['params'][0],
        "token": CommunityIdentifier.fromJson(i['params'][1]).toFmtString(),
        "amount": Fmt.numberFormat(i['params'][2]),
      };
    }).toList();
    if (reset) {
      txsTransfer = ObservableList.of(transfers.map((i) => TransferData.fromJson(Map<String, dynamic>.from(i))));
    } else {
      txsTransfer.addAll(transfers.map((i) => TransferData.fromJson(Map<String, dynamic>.from(i))));
    }

    if (needCache && txsTransfer.length > 0) {
      writeToCache();
    }
  }

  void initStore(Function cacheFn) {
    this._cacheFn = cacheFn;
  }

  Future<void> writeToCache() {
    if (_cacheFn != null) {
      return _cacheFn();
    } else {
      return null;
    }
  }
}

void _log(String msg) {
  print("[encointerAccountStore] $msg");
}
