import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/encointer_balance_data/balance_entry.dart';
import 'package:ew_log/ew_log.dart';
import 'package:encointer_wallet/utils/extensions/extensions.dart';

// Fixme #589: add nominal income dependent fee computation instead
// of arbitrary defined threshold.
const _minimalPaymentBalance = 0.013;

abstract class EncointerStoreService {
  /// Returns either the preferred or another cid that as enough balance to pay a transaction.
  ///
  /// Returns null if none is available.
  static CommunityIdentifier? getTxPaymentAsset(
    CommunityIdentifier? preferredCid,
    Map<String, BalanceEntry> balanceEntries,
    int latestHeaderNumber,
    double demurrage,
  ) {
    // Allow more concise code by avoiding redundant argument passing.
    bool canPayTxFn(BalanceEntry entry) => canPayTx(entry, latestHeaderNumber, demurrage);

    final preferredEntry = balanceEntries[preferredCid?.toFmtString()];

    if (preferredEntry != null && canPayTxFn(preferredEntry)) {
      Log.d('[TxPaymentAsset]: Enough funds in preferred cid $preferredEntry to pay tx fee.');
      return preferredCid;
    }

    final maybeFallbackEntry = balanceEntries.entries.firstWhereOrNull((e) => canPayTxFn(e.value));

    if (maybeFallbackEntry != null) {
      Log.d('[TxPaymentAsset]: Using fallback cid to pay tx: $maybeFallbackEntry');
      return CommunityIdentifier.fromFmtString(maybeFallbackEntry.key);
    } else {
      Log.e('[TxPaymentAsset]: Not enough funds in any community. Returning null to pay tx in native token');
      return null;
    }
  }

  static bool canPayTx(BalanceEntry entry, int latestHeaderNumber, double demurrage) {
    return entry.applyDemurrage(latestHeaderNumber, demurrage) > _minimalPaymentBalance;
  }
}
