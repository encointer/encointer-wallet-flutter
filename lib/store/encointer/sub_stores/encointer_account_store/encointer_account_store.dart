import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/encointer_balance_data/balance_entry.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/store/assets/types/transfer_data.dart';
import 'package:encointer_wallet/utils/format.dart';

part 'encointer_account_store.g.dart';

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
  Future<void> Function()? _cacheFn;

  /// The network this store belongs to.
  final String network;

  /// The account (SS58) this store belongs to.
  final String address;

  /// `BalanceEntries` for the respective community
  ///
  /// Map: cid.toFmtString() -> BalanceEntry
  @observable
  ObservableMap<String, BalanceEntry> balanceEntries = ObservableMap();

  /// `CommunityReputations` across all communities keyed by the respective ceremony index.
  ///
  /// Map: ceremony index -> CommunityReputation
  @observable
  Map<int, CommunityReputation> reputations = {};

  @observable
  ObservableList<TransferData> txsTransfer = ObservableList<TransferData>();

  @computed
  get ceremonyIndexForProofOfAttendance {
    if (reputations.isNotEmpty) {
      try {
        return reputations.entries.firstWhere((e) => e.value.reputation == Reputation.VerifiedUnlinked).key;
      } catch (_e, s) {
        Log.e('$address has reputation, but none that has not been linked yet', 'EncointerAccountStore', s);
        return 0;
      }
    }
  }

  @action
  void addBalanceEntry(CommunityIdentifier cid, BalanceEntry balanceEntry) {
    Log.d('balanceEntry $balanceEntry added to cid $cid added', 'EncointerAccountStore');
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
    reputations.clear();
    writeToCache();
  }

  @action
  void purgeCeremonySpecificState() {
    purgeReputations();
  }

  @action
  Future<void> setTransferTxs(List list, String address, {bool reset = false, needCache = true}) async {
    if (this.address != address) {
      Log.d("Tried to cached transfer tx's for wrong account. This is a bug.", 'EncointerAccountStore');
      return Future.value(null);
    }

    List transfers = list.map((i) {
      return {
        'block_timestamp': i['time'],
        'hash': i['hash'],
        'success': true,
        'from': address,
        'to': i['params'][0],
        'token': CommunityIdentifier.fromJson(i['params'][1]).toFmtString(),
        'amount': Fmt.numberFormat(i['params'][2]),
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

  void initStore(Function? cacheFn) {
    _cacheFn = cacheFn as Future<void> Function()?;
  }

  Future<void> writeToCache() {
    if (_cacheFn != null) {
      return _cacheFn!();
    } else {
      return Future.value(null);
    }
  }
}
