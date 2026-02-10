// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:typed_data' as _i6;

import 'package:polkadart/polkadart.dart' as _i1;

import '../types/frame_support/traits/storage/no_drop.dart' as _i4;
import '../types/pallet_transaction_payment/releases.dart' as _i3;
import '../types/sp_arithmetic/fixed_point/fixed_u128.dart' as _i2;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<_i2.FixedU128> _nextFeeMultiplier = const _i1.StorageValue<_i2.FixedU128>(
    prefix: 'TransactionPayment',
    storage: 'NextFeeMultiplier',
    valueCodec: _i2.FixedU128Codec(),
  );

  final _i1.StorageValue<_i3.Releases> _storageVersion = const _i1.StorageValue<_i3.Releases>(
    prefix: 'TransactionPayment',
    storage: 'StorageVersion',
    valueCodec: _i3.Releases.codec,
  );

  final _i1.StorageValue<_i4.NoDrop> _txPaymentCredit = const _i1.StorageValue<_i4.NoDrop>(
    prefix: 'TransactionPayment',
    storage: 'TxPaymentCredit',
    valueCodec: _i4.NoDropCodec(),
  );

  _i5.Future<_i2.FixedU128> nextFeeMultiplier({_i1.BlockHash? at}) async {
    final hashedKey = _nextFeeMultiplier.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nextFeeMultiplier.decodeValue(bytes);
    }
    return BigInt.parse(
      '1000000000000000000',
      radix: 10,
    ); /* Default */
  }

  _i5.Future<_i3.Releases> storageVersion({_i1.BlockHash? at}) async {
    final hashedKey = _storageVersion.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _storageVersion.decodeValue(bytes);
    }
    return _i3.Releases.v1Ancient; /* Default */
  }

  /// The `OnChargeTransaction` stores the withdrawn tx fee here.
  ///
  /// Use `withdraw_txfee` and `remaining_txfee` to access from outside the crate.
  _i5.Future<_i4.NoDrop?> txPaymentCredit({_i1.BlockHash? at}) async {
    final hashedKey = _txPaymentCredit.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _txPaymentCredit.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `nextFeeMultiplier`.
  _i6.Uint8List nextFeeMultiplierKey() {
    final hashedKey = _nextFeeMultiplier.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `storageVersion`.
  _i6.Uint8List storageVersionKey() {
    final hashedKey = _storageVersion.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `txPaymentCredit`.
  _i6.Uint8List txPaymentCreditKey() {
    final hashedKey = _txPaymentCredit.hashedKey();
    return hashedKey;
  }
}

class Constants {
  Constants();

  /// A fee multiplier for `Operational` extrinsics to compute "virtual tip" to boost their
  /// `priority`
  ///
  /// This value is multiplied by the `final_fee` to obtain a "virtual tip" that is later
  /// added to a tip component in regular `priority` calculations.
  /// It means that a `Normal` transaction can front-run a similarly-sized `Operational`
  /// extrinsic (with no tip), by including a tip value greater than the virtual tip.
  ///
  /// ```rust,ignore
  /// // For `Normal`
  /// let priority = priority_calc(tip);
  ///
  /// // For `Operational`
  /// let virtual_tip = (inclusion_fee + tip) * OperationalFeeMultiplier;
  /// let priority = priority_calc(tip + virtual_tip);
  /// ```
  ///
  /// Note that since we use `final_fee` the multiplier applies also to the regular `tip`
  /// sent with the transaction. So, not only does the transaction get a priority bump based
  /// on the `inclusion_fee`, but we also amplify the impact of tips applied to `Operational`
  /// transactions.
  final int operationalFeeMultiplier = 5;
}
