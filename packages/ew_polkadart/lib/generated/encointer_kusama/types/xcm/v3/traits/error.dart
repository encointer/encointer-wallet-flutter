// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;
import '../../../sp_weights/weight_v2/weight.dart' as _i3;

abstract class Error {
  const Error();

  factory Error.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $ErrorCodec codec = $ErrorCodec();

  static const $Error values = $Error();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, dynamic> toJson();
}

class $Error {
  const $Error();

  Overflow overflow() {
    return const Overflow();
  }

  Unimplemented unimplemented() {
    return const Unimplemented();
  }

  UntrustedReserveLocation untrustedReserveLocation() {
    return const UntrustedReserveLocation();
  }

  UntrustedTeleportLocation untrustedTeleportLocation() {
    return const UntrustedTeleportLocation();
  }

  LocationFull locationFull() {
    return const LocationFull();
  }

  LocationNotInvertible locationNotInvertible() {
    return const LocationNotInvertible();
  }

  BadOrigin badOrigin() {
    return const BadOrigin();
  }

  InvalidLocation invalidLocation() {
    return const InvalidLocation();
  }

  AssetNotFound assetNotFound() {
    return const AssetNotFound();
  }

  FailedToTransactAsset failedToTransactAsset() {
    return const FailedToTransactAsset();
  }

  NotWithdrawable notWithdrawable() {
    return const NotWithdrawable();
  }

  LocationCannotHold locationCannotHold() {
    return const LocationCannotHold();
  }

  ExceedsMaxMessageSize exceedsMaxMessageSize() {
    return const ExceedsMaxMessageSize();
  }

  DestinationUnsupported destinationUnsupported() {
    return const DestinationUnsupported();
  }

  Transport transport() {
    return const Transport();
  }

  Unroutable unroutable() {
    return const Unroutable();
  }

  UnknownClaim unknownClaim() {
    return const UnknownClaim();
  }

  FailedToDecode failedToDecode() {
    return const FailedToDecode();
  }

  MaxWeightInvalid maxWeightInvalid() {
    return const MaxWeightInvalid();
  }

  NotHoldingFees notHoldingFees() {
    return const NotHoldingFees();
  }

  TooExpensive tooExpensive() {
    return const TooExpensive();
  }

  Trap trap({required BigInt value0}) {
    return Trap(
      value0: value0,
    );
  }

  ExpectationFalse expectationFalse() {
    return const ExpectationFalse();
  }

  PalletNotFound palletNotFound() {
    return const PalletNotFound();
  }

  NameMismatch nameMismatch() {
    return const NameMismatch();
  }

  VersionIncompatible versionIncompatible() {
    return const VersionIncompatible();
  }

  HoldingWouldOverflow holdingWouldOverflow() {
    return const HoldingWouldOverflow();
  }

  ExportError exportError() {
    return const ExportError();
  }

  ReanchorFailed reanchorFailed() {
    return const ReanchorFailed();
  }

  NoDeal noDeal() {
    return const NoDeal();
  }

  FeesNotMet feesNotMet() {
    return const FeesNotMet();
  }

  LockError lockError() {
    return const LockError();
  }

  NoPermission noPermission() {
    return const NoPermission();
  }

  Unanchored unanchored() {
    return const Unanchored();
  }

  NotDepositable notDepositable() {
    return const NotDepositable();
  }

  UnhandledXcmVersion unhandledXcmVersion() {
    return const UnhandledXcmVersion();
  }

  WeightLimitReached weightLimitReached({required _i3.Weight value0}) {
    return WeightLimitReached(
      value0: value0,
    );
  }

  Barrier barrier() {
    return const Barrier();
  }

  WeightNotComputable weightNotComputable() {
    return const WeightNotComputable();
  }

  ExceedsStackLimit exceedsStackLimit() {
    return const ExceedsStackLimit();
  }
}

class $ErrorCodec with _i1.Codec<Error> {
  const $ErrorCodec();

  @override
  Error decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Overflow();
      case 1:
        return const Unimplemented();
      case 2:
        return const UntrustedReserveLocation();
      case 3:
        return const UntrustedTeleportLocation();
      case 4:
        return const LocationFull();
      case 5:
        return const LocationNotInvertible();
      case 6:
        return const BadOrigin();
      case 7:
        return const InvalidLocation();
      case 8:
        return const AssetNotFound();
      case 9:
        return const FailedToTransactAsset();
      case 10:
        return const NotWithdrawable();
      case 11:
        return const LocationCannotHold();
      case 12:
        return const ExceedsMaxMessageSize();
      case 13:
        return const DestinationUnsupported();
      case 14:
        return const Transport();
      case 15:
        return const Unroutable();
      case 16:
        return const UnknownClaim();
      case 17:
        return const FailedToDecode();
      case 18:
        return const MaxWeightInvalid();
      case 19:
        return const NotHoldingFees();
      case 20:
        return const TooExpensive();
      case 21:
        return Trap._decode(input);
      case 22:
        return const ExpectationFalse();
      case 23:
        return const PalletNotFound();
      case 24:
        return const NameMismatch();
      case 25:
        return const VersionIncompatible();
      case 26:
        return const HoldingWouldOverflow();
      case 27:
        return const ExportError();
      case 28:
        return const ReanchorFailed();
      case 29:
        return const NoDeal();
      case 30:
        return const FeesNotMet();
      case 31:
        return const LockError();
      case 32:
        return const NoPermission();
      case 33:
        return const Unanchored();
      case 34:
        return const NotDepositable();
      case 35:
        return const UnhandledXcmVersion();
      case 36:
        return WeightLimitReached._decode(input);
      case 37:
        return const Barrier();
      case 38:
        return const WeightNotComputable();
      case 39:
        return const ExceedsStackLimit();
      default:
        throw Exception('Error: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Error value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Overflow:
        (value as Overflow).encodeTo(output);
        break;
      case Unimplemented:
        (value as Unimplemented).encodeTo(output);
        break;
      case UntrustedReserveLocation:
        (value as UntrustedReserveLocation).encodeTo(output);
        break;
      case UntrustedTeleportLocation:
        (value as UntrustedTeleportLocation).encodeTo(output);
        break;
      case LocationFull:
        (value as LocationFull).encodeTo(output);
        break;
      case LocationNotInvertible:
        (value as LocationNotInvertible).encodeTo(output);
        break;
      case BadOrigin:
        (value as BadOrigin).encodeTo(output);
        break;
      case InvalidLocation:
        (value as InvalidLocation).encodeTo(output);
        break;
      case AssetNotFound:
        (value as AssetNotFound).encodeTo(output);
        break;
      case FailedToTransactAsset:
        (value as FailedToTransactAsset).encodeTo(output);
        break;
      case NotWithdrawable:
        (value as NotWithdrawable).encodeTo(output);
        break;
      case LocationCannotHold:
        (value as LocationCannotHold).encodeTo(output);
        break;
      case ExceedsMaxMessageSize:
        (value as ExceedsMaxMessageSize).encodeTo(output);
        break;
      case DestinationUnsupported:
        (value as DestinationUnsupported).encodeTo(output);
        break;
      case Transport:
        (value as Transport).encodeTo(output);
        break;
      case Unroutable:
        (value as Unroutable).encodeTo(output);
        break;
      case UnknownClaim:
        (value as UnknownClaim).encodeTo(output);
        break;
      case FailedToDecode:
        (value as FailedToDecode).encodeTo(output);
        break;
      case MaxWeightInvalid:
        (value as MaxWeightInvalid).encodeTo(output);
        break;
      case NotHoldingFees:
        (value as NotHoldingFees).encodeTo(output);
        break;
      case TooExpensive:
        (value as TooExpensive).encodeTo(output);
        break;
      case Trap:
        (value as Trap).encodeTo(output);
        break;
      case ExpectationFalse:
        (value as ExpectationFalse).encodeTo(output);
        break;
      case PalletNotFound:
        (value as PalletNotFound).encodeTo(output);
        break;
      case NameMismatch:
        (value as NameMismatch).encodeTo(output);
        break;
      case VersionIncompatible:
        (value as VersionIncompatible).encodeTo(output);
        break;
      case HoldingWouldOverflow:
        (value as HoldingWouldOverflow).encodeTo(output);
        break;
      case ExportError:
        (value as ExportError).encodeTo(output);
        break;
      case ReanchorFailed:
        (value as ReanchorFailed).encodeTo(output);
        break;
      case NoDeal:
        (value as NoDeal).encodeTo(output);
        break;
      case FeesNotMet:
        (value as FeesNotMet).encodeTo(output);
        break;
      case LockError:
        (value as LockError).encodeTo(output);
        break;
      case NoPermission:
        (value as NoPermission).encodeTo(output);
        break;
      case Unanchored:
        (value as Unanchored).encodeTo(output);
        break;
      case NotDepositable:
        (value as NotDepositable).encodeTo(output);
        break;
      case UnhandledXcmVersion:
        (value as UnhandledXcmVersion).encodeTo(output);
        break;
      case WeightLimitReached:
        (value as WeightLimitReached).encodeTo(output);
        break;
      case Barrier:
        (value as Barrier).encodeTo(output);
        break;
      case WeightNotComputable:
        (value as WeightNotComputable).encodeTo(output);
        break;
      case ExceedsStackLimit:
        (value as ExceedsStackLimit).encodeTo(output);
        break;
      default:
        throw Exception('Error: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Error value) {
    switch (value.runtimeType) {
      case Overflow:
        return 1;
      case Unimplemented:
        return 1;
      case UntrustedReserveLocation:
        return 1;
      case UntrustedTeleportLocation:
        return 1;
      case LocationFull:
        return 1;
      case LocationNotInvertible:
        return 1;
      case BadOrigin:
        return 1;
      case InvalidLocation:
        return 1;
      case AssetNotFound:
        return 1;
      case FailedToTransactAsset:
        return 1;
      case NotWithdrawable:
        return 1;
      case LocationCannotHold:
        return 1;
      case ExceedsMaxMessageSize:
        return 1;
      case DestinationUnsupported:
        return 1;
      case Transport:
        return 1;
      case Unroutable:
        return 1;
      case UnknownClaim:
        return 1;
      case FailedToDecode:
        return 1;
      case MaxWeightInvalid:
        return 1;
      case NotHoldingFees:
        return 1;
      case TooExpensive:
        return 1;
      case Trap:
        return (value as Trap)._sizeHint();
      case ExpectationFalse:
        return 1;
      case PalletNotFound:
        return 1;
      case NameMismatch:
        return 1;
      case VersionIncompatible:
        return 1;
      case HoldingWouldOverflow:
        return 1;
      case ExportError:
        return 1;
      case ReanchorFailed:
        return 1;
      case NoDeal:
        return 1;
      case FeesNotMet:
        return 1;
      case LockError:
        return 1;
      case NoPermission:
        return 1;
      case Unanchored:
        return 1;
      case NotDepositable:
        return 1;
      case UnhandledXcmVersion:
        return 1;
      case WeightLimitReached:
        return (value as WeightLimitReached)._sizeHint();
      case Barrier:
        return 1;
      case WeightNotComputable:
        return 1;
      case ExceedsStackLimit:
        return 1;
      default:
        throw Exception('Error: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Overflow extends Error {
  const Overflow();

  @override
  Map<String, dynamic> toJson() => {'Overflow': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }
}

class Unimplemented extends Error {
  const Unimplemented();

  @override
  Map<String, dynamic> toJson() => {'Unimplemented': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }
}

class UntrustedReserveLocation extends Error {
  const UntrustedReserveLocation();

  @override
  Map<String, dynamic> toJson() => {'UntrustedReserveLocation': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }
}

class UntrustedTeleportLocation extends Error {
  const UntrustedTeleportLocation();

  @override
  Map<String, dynamic> toJson() => {'UntrustedTeleportLocation': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
  }
}

class LocationFull extends Error {
  const LocationFull();

  @override
  Map<String, dynamic> toJson() => {'LocationFull': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
  }
}

class LocationNotInvertible extends Error {
  const LocationNotInvertible();

  @override
  Map<String, dynamic> toJson() => {'LocationNotInvertible': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
  }
}

class BadOrigin extends Error {
  const BadOrigin();

  @override
  Map<String, dynamic> toJson() => {'BadOrigin': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
  }
}

class InvalidLocation extends Error {
  const InvalidLocation();

  @override
  Map<String, dynamic> toJson() => {'InvalidLocation': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
  }
}

class AssetNotFound extends Error {
  const AssetNotFound();

  @override
  Map<String, dynamic> toJson() => {'AssetNotFound': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
  }
}

class FailedToTransactAsset extends Error {
  const FailedToTransactAsset();

  @override
  Map<String, dynamic> toJson() => {'FailedToTransactAsset': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
  }
}

class NotWithdrawable extends Error {
  const NotWithdrawable();

  @override
  Map<String, dynamic> toJson() => {'NotWithdrawable': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
  }
}

class LocationCannotHold extends Error {
  const LocationCannotHold();

  @override
  Map<String, dynamic> toJson() => {'LocationCannotHold': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
  }
}

class ExceedsMaxMessageSize extends Error {
  const ExceedsMaxMessageSize();

  @override
  Map<String, dynamic> toJson() => {'ExceedsMaxMessageSize': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
  }
}

class DestinationUnsupported extends Error {
  const DestinationUnsupported();

  @override
  Map<String, dynamic> toJson() => {'DestinationUnsupported': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
  }
}

class Transport extends Error {
  const Transport();

  @override
  Map<String, dynamic> toJson() => {'Transport': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      14,
      output,
    );
  }
}

class Unroutable extends Error {
  const Unroutable();

  @override
  Map<String, dynamic> toJson() => {'Unroutable': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      15,
      output,
    );
  }
}

class UnknownClaim extends Error {
  const UnknownClaim();

  @override
  Map<String, dynamic> toJson() => {'UnknownClaim': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      16,
      output,
    );
  }
}

class FailedToDecode extends Error {
  const FailedToDecode();

  @override
  Map<String, dynamic> toJson() => {'FailedToDecode': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      17,
      output,
    );
  }
}

class MaxWeightInvalid extends Error {
  const MaxWeightInvalid();

  @override
  Map<String, dynamic> toJson() => {'MaxWeightInvalid': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      18,
      output,
    );
  }
}

class NotHoldingFees extends Error {
  const NotHoldingFees();

  @override
  Map<String, dynamic> toJson() => {'NotHoldingFees': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      19,
      output,
    );
  }
}

class TooExpensive extends Error {
  const TooExpensive();

  @override
  Map<String, dynamic> toJson() => {'TooExpensive': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      20,
      output,
    );
  }
}

class Trap extends Error {
  const Trap({required this.value0});

  factory Trap._decode(_i1.Input input) {
    return Trap(
      value0: _i1.U64Codec.codec.decode(input),
    );
  }

  final BigInt value0;

  @override
  Map<String, BigInt> toJson() => {'Trap': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      21,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      value0,
      output,
    );
  }
}

class ExpectationFalse extends Error {
  const ExpectationFalse();

  @override
  Map<String, dynamic> toJson() => {'ExpectationFalse': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      22,
      output,
    );
  }
}

class PalletNotFound extends Error {
  const PalletNotFound();

  @override
  Map<String, dynamic> toJson() => {'PalletNotFound': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      23,
      output,
    );
  }
}

class NameMismatch extends Error {
  const NameMismatch();

  @override
  Map<String, dynamic> toJson() => {'NameMismatch': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      24,
      output,
    );
  }
}

class VersionIncompatible extends Error {
  const VersionIncompatible();

  @override
  Map<String, dynamic> toJson() => {'VersionIncompatible': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      25,
      output,
    );
  }
}

class HoldingWouldOverflow extends Error {
  const HoldingWouldOverflow();

  @override
  Map<String, dynamic> toJson() => {'HoldingWouldOverflow': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      26,
      output,
    );
  }
}

class ExportError extends Error {
  const ExportError();

  @override
  Map<String, dynamic> toJson() => {'ExportError': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      27,
      output,
    );
  }
}

class ReanchorFailed extends Error {
  const ReanchorFailed();

  @override
  Map<String, dynamic> toJson() => {'ReanchorFailed': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      28,
      output,
    );
  }
}

class NoDeal extends Error {
  const NoDeal();

  @override
  Map<String, dynamic> toJson() => {'NoDeal': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      29,
      output,
    );
  }
}

class FeesNotMet extends Error {
  const FeesNotMet();

  @override
  Map<String, dynamic> toJson() => {'FeesNotMet': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      30,
      output,
    );
  }
}

class LockError extends Error {
  const LockError();

  @override
  Map<String, dynamic> toJson() => {'LockError': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      31,
      output,
    );
  }
}

class NoPermission extends Error {
  const NoPermission();

  @override
  Map<String, dynamic> toJson() => {'NoPermission': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      32,
      output,
    );
  }
}

class Unanchored extends Error {
  const Unanchored();

  @override
  Map<String, dynamic> toJson() => {'Unanchored': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      33,
      output,
    );
  }
}

class NotDepositable extends Error {
  const NotDepositable();

  @override
  Map<String, dynamic> toJson() => {'NotDepositable': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      34,
      output,
    );
  }
}

class UnhandledXcmVersion extends Error {
  const UnhandledXcmVersion();

  @override
  Map<String, dynamic> toJson() => {'UnhandledXcmVersion': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      35,
      output,
    );
  }
}

class WeightLimitReached extends Error {
  const WeightLimitReached({required this.value0});

  factory WeightLimitReached._decode(_i1.Input input) {
    return WeightLimitReached(
      value0: _i3.Weight.codec.decode(input),
    );
  }

  final _i3.Weight value0;

  @override
  Map<String, Map<String, BigInt>> toJson() => {'WeightLimitReached': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Weight.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      36,
      output,
    );
    _i3.Weight.codec.encodeTo(
      value0,
      output,
    );
  }
}

class Barrier extends Error {
  const Barrier();

  @override
  Map<String, dynamic> toJson() => {'Barrier': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      37,
      output,
    );
  }
}

class WeightNotComputable extends Error {
  const WeightNotComputable();

  @override
  Map<String, dynamic> toJson() => {'WeightNotComputable': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      38,
      output,
    );
  }
}

class ExceedsStackLimit extends Error {
  const ExceedsStackLimit();

  @override
  Map<String, dynamic> toJson() => {'ExceedsStackLimit': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      39,
      output,
    );
  }
}
