// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// Account balance must be greater than or equal to the transfer amount.
  balanceLow('BalanceLow', 0),

  /// The account to alter does not exist.
  noAccount('NoAccount', 1),

  /// The signing account has no permission to do the operation.
  noPermission('NoPermission', 2),

  /// The given asset ID is unknown.
  unknown('Unknown', 3),

  /// The origin account is frozen.
  frozen('Frozen', 4),

  /// The asset ID is already taken.
  inUse('InUse', 5),

  /// Invalid witness data given.
  badWitness('BadWitness', 6),

  /// Minimum balance should be non-zero.
  minBalanceZero('MinBalanceZero', 7),

  /// Unable to increment the consumer reference counters on the account. Either no provider
  /// reference exists to allow a non-zero balance of a non-self-sufficient asset, or one
  /// fewer then the maximum number of consumers has been reached.
  unavailableConsumer('UnavailableConsumer', 8),

  /// Invalid metadata given.
  badMetadata('BadMetadata', 9),

  /// No approval exists that would allow the transfer.
  unapproved('Unapproved', 10),

  /// The source account would not survive the transfer and it needs to stay alive.
  wouldDie('WouldDie', 11),

  /// The asset-account already exists.
  alreadyExists('AlreadyExists', 12),

  /// The asset-account doesn't have an associated deposit.
  noDeposit('NoDeposit', 13),

  /// The operation would result in funds being burned.
  wouldBurn('WouldBurn', 14),

  /// The asset is a live asset and is actively being used. Usually emit for operations such
  /// as `start_destroy` which require the asset to be in a destroying state.
  liveAsset('LiveAsset', 15),

  /// The asset is not live, and likely being destroyed.
  assetNotLive('AssetNotLive', 16),

  /// The asset status is not the expected status.
  incorrectStatus('IncorrectStatus', 17),

  /// The asset should be frozen before the given operation.
  notFrozen('NotFrozen', 18),

  /// Callback action resulted in error
  callbackFailed('CallbackFailed', 19),

  /// The asset ID must be equal to the [`NextAssetId`].
  badAssetId('BadAssetId', 20),

  /// The asset cannot be destroyed because some accounts for this asset contain freezes.
  containsFreezes('ContainsFreezes', 21),

  /// The asset cannot be destroyed because some accounts for this asset contain holds.
  containsHolds('ContainsHolds', 22);

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
        return Error.balanceLow;
      case 1:
        return Error.noAccount;
      case 2:
        return Error.noPermission;
      case 3:
        return Error.unknown;
      case 4:
        return Error.frozen;
      case 5:
        return Error.inUse;
      case 6:
        return Error.badWitness;
      case 7:
        return Error.minBalanceZero;
      case 8:
        return Error.unavailableConsumer;
      case 9:
        return Error.badMetadata;
      case 10:
        return Error.unapproved;
      case 11:
        return Error.wouldDie;
      case 12:
        return Error.alreadyExists;
      case 13:
        return Error.noDeposit;
      case 14:
        return Error.wouldBurn;
      case 15:
        return Error.liveAsset;
      case 16:
        return Error.assetNotLive;
      case 17:
        return Error.incorrectStatus;
      case 18:
        return Error.notFrozen;
      case 19:
        return Error.callbackFailed;
      case 20:
        return Error.badAssetId;
      case 21:
        return Error.containsFreezes;
      case 22:
        return Error.containsHolds;
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
