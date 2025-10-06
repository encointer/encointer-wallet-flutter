// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// Provided asset pair is not supported for pool.
  invalidAssetPair('InvalidAssetPair', 0),

  /// Pool already exists.
  poolExists('PoolExists', 1),

  /// Desired amount can't be zero.
  wrongDesiredAmount('WrongDesiredAmount', 2),

  /// Provided amount should be greater than or equal to the existential deposit/asset's
  /// minimal amount.
  amountOneLessThanMinimal('AmountOneLessThanMinimal', 3),

  /// Provided amount should be greater than or equal to the existential deposit/asset's
  /// minimal amount.
  amountTwoLessThanMinimal('AmountTwoLessThanMinimal', 4),

  /// Reserve needs to always be greater than or equal to the existential deposit/asset's
  /// minimal amount.
  reserveLeftLessThanMinimal('ReserveLeftLessThanMinimal', 5),

  /// Desired amount can't be equal to the pool reserve.
  amountOutTooHigh('AmountOutTooHigh', 6),

  /// The pool doesn't exist.
  poolNotFound('PoolNotFound', 7),

  /// An overflow happened.
  overflow('Overflow', 8),

  /// The minimal amount requirement for the first token in the pair wasn't met.
  assetOneDepositDidNotMeetMinimum('AssetOneDepositDidNotMeetMinimum', 9),

  /// The minimal amount requirement for the second token in the pair wasn't met.
  assetTwoDepositDidNotMeetMinimum('AssetTwoDepositDidNotMeetMinimum', 10),

  /// The minimal amount requirement for the first token in the pair wasn't met.
  assetOneWithdrawalDidNotMeetMinimum('AssetOneWithdrawalDidNotMeetMinimum', 11),

  /// The minimal amount requirement for the second token in the pair wasn't met.
  assetTwoWithdrawalDidNotMeetMinimum('AssetTwoWithdrawalDidNotMeetMinimum', 12),

  /// Optimal calculated amount is less than desired.
  optimalAmountLessThanDesired('OptimalAmountLessThanDesired', 13),

  /// Insufficient liquidity minted.
  insufficientLiquidityMinted('InsufficientLiquidityMinted', 14),

  /// Requested liquidity can't be zero.
  zeroLiquidity('ZeroLiquidity', 15),

  /// Amount can't be zero.
  zeroAmount('ZeroAmount', 16),

  /// Calculated amount out is less than provided minimum amount.
  providedMinimumNotSufficientForSwap('ProvidedMinimumNotSufficientForSwap', 17),

  /// Provided maximum amount is not sufficient for swap.
  providedMaximumNotSufficientForSwap('ProvidedMaximumNotSufficientForSwap', 18),

  /// The provided path must consists of 2 assets at least.
  invalidPath('InvalidPath', 19),

  /// The provided path must consists of unique assets.
  nonUniquePath('NonUniquePath', 20),

  /// It was not possible to get or increment the Id of the pool.
  incorrectPoolAssetId('IncorrectPoolAssetId', 21),

  /// The destination account cannot exist with the swapped funds.
  belowMinimum('BelowMinimum', 22);

  const Error(
    this.variantName,
    this.codecIndex,
  );

  factory Error.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ErrorCodec codec = $ErrorCodec();

  String toJson() => variantName;

  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ErrorCodec with _i1.Codec<Error> {
  const $ErrorCodec();

  @override
  Error decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Error.invalidAssetPair;
      case 1:
        return Error.poolExists;
      case 2:
        return Error.wrongDesiredAmount;
      case 3:
        return Error.amountOneLessThanMinimal;
      case 4:
        return Error.amountTwoLessThanMinimal;
      case 5:
        return Error.reserveLeftLessThanMinimal;
      case 6:
        return Error.amountOutTooHigh;
      case 7:
        return Error.poolNotFound;
      case 8:
        return Error.overflow;
      case 9:
        return Error.assetOneDepositDidNotMeetMinimum;
      case 10:
        return Error.assetTwoDepositDidNotMeetMinimum;
      case 11:
        return Error.assetOneWithdrawalDidNotMeetMinimum;
      case 12:
        return Error.assetTwoWithdrawalDidNotMeetMinimum;
      case 13:
        return Error.optimalAmountLessThanDesired;
      case 14:
        return Error.insufficientLiquidityMinted;
      case 15:
        return Error.zeroLiquidity;
      case 16:
        return Error.zeroAmount;
      case 17:
        return Error.providedMinimumNotSufficientForSwap;
      case 18:
        return Error.providedMaximumNotSufficientForSwap;
      case 19:
        return Error.invalidPath;
      case 20:
        return Error.nonUniquePath;
      case 21:
        return Error.incorrectPoolAssetId;
      case 22:
        return Error.belowMinimum;
      default:
        throw Exception('Error: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Error value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
