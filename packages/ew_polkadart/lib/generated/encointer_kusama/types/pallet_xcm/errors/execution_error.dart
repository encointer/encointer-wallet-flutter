// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

enum ExecutionError {
  overflow('Overflow', 0),
  unimplemented('Unimplemented', 1),
  untrustedReserveLocation('UntrustedReserveLocation', 2),
  untrustedTeleportLocation('UntrustedTeleportLocation', 3),
  locationFull('LocationFull', 4),
  locationNotInvertible('LocationNotInvertible', 5),
  badOrigin('BadOrigin', 6),
  invalidLocation('InvalidLocation', 7),
  assetNotFound('AssetNotFound', 8),
  failedToTransactAsset('FailedToTransactAsset', 9),
  notWithdrawable('NotWithdrawable', 10),
  locationCannotHold('LocationCannotHold', 11),
  exceedsMaxMessageSize('ExceedsMaxMessageSize', 12),
  destinationUnsupported('DestinationUnsupported', 13),
  transport('Transport', 14),
  unroutable('Unroutable', 15),
  unknownClaim('UnknownClaim', 16),
  failedToDecode('FailedToDecode', 17),
  maxWeightInvalid('MaxWeightInvalid', 18),
  notHoldingFees('NotHoldingFees', 19),
  tooExpensive('TooExpensive', 20),
  trap('Trap', 21),
  expectationFalse('ExpectationFalse', 22),
  palletNotFound('PalletNotFound', 23),
  nameMismatch('NameMismatch', 24),
  versionIncompatible('VersionIncompatible', 25),
  holdingWouldOverflow('HoldingWouldOverflow', 26),
  exportError('ExportError', 27),
  reanchorFailed('ReanchorFailed', 28),
  noDeal('NoDeal', 29),
  feesNotMet('FeesNotMet', 30),
  lockError('LockError', 31),
  noPermission('NoPermission', 32),
  unanchored('Unanchored', 33),
  notDepositable('NotDepositable', 34),
  tooManyAssets('TooManyAssets', 35),
  unhandledXcmVersion('UnhandledXcmVersion', 36),
  weightLimitReached('WeightLimitReached', 37),
  barrier('Barrier', 38),
  weightNotComputable('WeightNotComputable', 39),
  exceedsStackLimit('ExceedsStackLimit', 40);

  const ExecutionError(
    this.variantName,
    this.codecIndex,
  );

  factory ExecutionError.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ExecutionErrorCodec codec = $ExecutionErrorCodec();

  String toJson() => variantName;

  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ExecutionErrorCodec with _i1.Codec<ExecutionError> {
  const $ExecutionErrorCodec();

  @override
  ExecutionError decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return ExecutionError.overflow;
      case 1:
        return ExecutionError.unimplemented;
      case 2:
        return ExecutionError.untrustedReserveLocation;
      case 3:
        return ExecutionError.untrustedTeleportLocation;
      case 4:
        return ExecutionError.locationFull;
      case 5:
        return ExecutionError.locationNotInvertible;
      case 6:
        return ExecutionError.badOrigin;
      case 7:
        return ExecutionError.invalidLocation;
      case 8:
        return ExecutionError.assetNotFound;
      case 9:
        return ExecutionError.failedToTransactAsset;
      case 10:
        return ExecutionError.notWithdrawable;
      case 11:
        return ExecutionError.locationCannotHold;
      case 12:
        return ExecutionError.exceedsMaxMessageSize;
      case 13:
        return ExecutionError.destinationUnsupported;
      case 14:
        return ExecutionError.transport;
      case 15:
        return ExecutionError.unroutable;
      case 16:
        return ExecutionError.unknownClaim;
      case 17:
        return ExecutionError.failedToDecode;
      case 18:
        return ExecutionError.maxWeightInvalid;
      case 19:
        return ExecutionError.notHoldingFees;
      case 20:
        return ExecutionError.tooExpensive;
      case 21:
        return ExecutionError.trap;
      case 22:
        return ExecutionError.expectationFalse;
      case 23:
        return ExecutionError.palletNotFound;
      case 24:
        return ExecutionError.nameMismatch;
      case 25:
        return ExecutionError.versionIncompatible;
      case 26:
        return ExecutionError.holdingWouldOverflow;
      case 27:
        return ExecutionError.exportError;
      case 28:
        return ExecutionError.reanchorFailed;
      case 29:
        return ExecutionError.noDeal;
      case 30:
        return ExecutionError.feesNotMet;
      case 31:
        return ExecutionError.lockError;
      case 32:
        return ExecutionError.noPermission;
      case 33:
        return ExecutionError.unanchored;
      case 34:
        return ExecutionError.notDepositable;
      case 35:
        return ExecutionError.tooManyAssets;
      case 36:
        return ExecutionError.unhandledXcmVersion;
      case 37:
        return ExecutionError.weightLimitReached;
      case 38:
        return ExecutionError.barrier;
      case 39:
        return ExecutionError.weightNotComputable;
      case 40:
        return ExecutionError.exceedsStackLimit;
      default:
        throw Exception('ExecutionError: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    ExecutionError value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }

  @override
  bool isSizeZero() => false;
}
