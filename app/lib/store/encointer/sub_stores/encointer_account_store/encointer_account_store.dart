import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/encointer_balance_data/balance_entry.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/models/proof_of_attendance/proof_of_attendance.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/assets/types/transfer_data.dart';
import 'package:encointer_wallet/utils/format.dart';

part 'encointer_account_store.g.dart';

/// Stores data specific to an account across all communities.
///
///
@JsonSerializable(explicitToJson: true)
class EncointerAccountStore extends _EncointerAccountStore with _$EncointerAccountStore {
  EncointerAccountStore(super.network, super.address);

  factory EncointerAccountStore.fromJson(Map<String, dynamic> json) => _$EncointerAccountStoreFromJson(json);
  Map<String, dynamic> toJson() => _$EncointerAccountStoreToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

abstract class _EncointerAccountStore with Store {
  _EncointerAccountStore(this.network, this.address);

  @JsonKey(includeFromJson: false, includeToJson: false)
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
  /// Normally, we are more interested in the computed [verifiedReputations], as this map may
  /// contain all potential reputation values: UnverifiedReputable, VerifiedUnlinked and VerifiedLinked.
  ///
  /// Map: ceremony index -> CommunityReputation
  ///
  /// Note: must be nullable for json-deserialization of old stores.
  @observable
  Map<int, CommunityReputation>? _reputationsV2;

  Map<int, CommunityReputation> get reputations => _reputationsV2 ?? {};

  /// Returns all reputations associated with a meetup.
  @computed
  Map<int, CommunityReputation> get verifiedReputations {
    final entries = reputations.entries.where((e) => e.value.reputation.isVerified());
    return Map.fromEntries(entries);
  }

  /// Number of successfully attended meetups in the range of reputation lifetime.
  @computed
  int get verifiedReputationCount => verifiedReputations.length;

  @observable
  ObservableList<TransferData> txsTransfer = ObservableList<TransferData>();

  @observable
  int numberOfNewbieTicketsForReputable = 0;

  int? ceremonyIndexForNextProofOfAttendance(int currentCeremonyIndex) {
    if (verifiedReputations.isNotEmpty) {
      try {
        // returns the first reputation that hasn't been linked, or has been linked to a non-current cIndex.
        return verifiedReputations.entries.firstWhere((e) {
          if (e.value.reputation.runtimeType == VerifiedUnlinked) {
            Log.d('Found unlinked reputation with cIndex ${e.key}');
            return true;
          }

          if (e.value.reputation.runtimeType == VerifiedLinked &&
              (e.value.reputation as VerifiedLinked).value0 != currentCeremonyIndex) {
            Log.d('Found linked reputation that has been linked to previous cycle with cIndex ${e.key}');
            return true;
          }

          return false;
        }).key;
      } catch (e, s) {
        Log.e('$address has reputation, but none that has not been linked with the current cIndex',
            'EncointerAccountStore', s);
        return 0;
      }
    } else {
      return 0;
    }
  }

  /// Proof of attendance used for the last registration.
  ///
  /// We need to supply parts of it when unregistering to
  /// reclaim the reputation.
  @observable
  ProofOfAttendance? lastProofOfAttendance;

  @action
  void addBalanceEntry(CommunityIdentifier cid, BalanceEntry balanceEntry) {
    Log.d('balanceEntry $balanceEntry added to cid $cid added', 'EncointerAccountStore');
    balanceEntries[cid.toFmtString()] = balanceEntry;
    writeToCache();
  }

  @action
  double addBalanceEntryAndReturnDelta(
    CommunityIdentifier cid,
    BalanceEntry balanceEntry,
    double? Function(BalanceEntry) demurrageFn,
  ) {
    final cidStr = cid.toFmtString();
    Log.d('balanceEntry $balanceEntry added to cid $cidStr added', 'EncointerAccountStore');

    final oldBalanceEntry = balanceEntries[cidStr];
    final oldBalance = oldBalanceEntry != null ? demurrageFn(oldBalanceEntry) ?? 0 : 0;
    final newBalance = demurrageFn(balanceEntry) ?? 0;

    balanceEntries[cid.toFmtString()] = balanceEntry;
    writeToCache();

    return newBalance - oldBalance;
  }

  @action
  Future<void> setReputations(Map<int, CommunityReputation> reps) async {
    _reputationsV2 = reps;
    unawaited(writeToCache());
    await getNumberOfNewbieTicketsForReputable();
  }

  @action
  void purgeReputations() {
    reputations.clear();
    writeToCache();
  }

  @action
  void purgeCeremonySpecificState() {
    purgeReputations();
    lastProofOfAttendance = null;
  }

  @action
  Future<void> setTransferTxs(List list, String address, {bool reset = false, bool needCache = true}) async {
    if (this.address != address) {
      Log.d("Tried to cached transfer tx's for wrong account. This is a bug.", 'EncointerAccountStore');
      return Future.value();
    }

    final transfers = list.map((i) {
      return {
        // Here, for now, [setTransferTxs] is not called at all.
        // Because this function is related to transaction history and is not used at the moment,
        // but we will integrate it in the future, so we can't know the type of [List list] for now,
        // please check the type of [List list] again when integrated.
        'block_timestamp': (i as Map<String, dynamic>)['time'],
        'hash': i['hash'],
        'success': true,
        'from': address,
        'to': (i['params'] as Map<String, dynamic>)[0],
        'token': CommunityIdentifier.fromJson((i['params'] as Map<String, dynamic>)[1] as Map<String, dynamic>)
            .toFmtString(),
        'amount': Fmt.numberFormat((i['params'] as Map<String, dynamic>)[2] as String?),
      };
    }).toList();
    if (reset) {
      txsTransfer = ObservableList.of(transfers.map((i) => TransferData.fromJson(Map<String, dynamic>.from(i))));
    } else {
      txsTransfer.addAll(transfers.map((i) => TransferData.fromJson(Map<String, dynamic>.from(i))));
    }

    if (needCache && txsTransfer.isNotEmpty) {
      unawaited(writeToCache());
    }
  }

  @action
  Future<void> getNumberOfNewbieTicketsForReputable({Uint8List? at}) async {
    numberOfNewbieTicketsForReputable = await webApi.encointer.getNumberOfNewbieTicketsForReputable(at: at);
  }

  void initStore(Function? cacheFn) {
    _cacheFn = cacheFn as Future<void> Function()?;
  }

  Future<void> writeToCache() {
    if (_cacheFn != null) {
      return _cacheFn!();
    } else {
      return Future.value();
    }
  }
}
