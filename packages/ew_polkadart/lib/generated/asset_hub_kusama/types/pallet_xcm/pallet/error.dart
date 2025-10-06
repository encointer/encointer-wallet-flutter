// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../errors/execution_error.dart' as _i3;

/// The `Error` enum of this pallet.
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

  Unreachable unreachable() {
    return Unreachable();
  }

  SendFailure sendFailure() {
    return SendFailure();
  }

  Filtered filtered() {
    return Filtered();
  }

  UnweighableMessage unweighableMessage() {
    return UnweighableMessage();
  }

  DestinationNotInvertible destinationNotInvertible() {
    return DestinationNotInvertible();
  }

  Empty empty() {
    return Empty();
  }

  CannotReanchor cannotReanchor() {
    return CannotReanchor();
  }

  TooManyAssets tooManyAssets() {
    return TooManyAssets();
  }

  InvalidOrigin invalidOrigin() {
    return InvalidOrigin();
  }

  BadVersion badVersion() {
    return BadVersion();
  }

  BadLocation badLocation() {
    return BadLocation();
  }

  NoSubscription noSubscription() {
    return NoSubscription();
  }

  AlreadySubscribed alreadySubscribed() {
    return AlreadySubscribed();
  }

  CannotCheckOutTeleport cannotCheckOutTeleport() {
    return CannotCheckOutTeleport();
  }

  LowBalance lowBalance() {
    return LowBalance();
  }

  TooManyLocks tooManyLocks() {
    return TooManyLocks();
  }

  AccountNotSovereign accountNotSovereign() {
    return AccountNotSovereign();
  }

  FeesNotMet feesNotMet() {
    return FeesNotMet();
  }

  LockNotFound lockNotFound() {
    return LockNotFound();
  }

  InUse inUse() {
    return InUse();
  }

  InvalidAssetUnknownReserve invalidAssetUnknownReserve() {
    return InvalidAssetUnknownReserve();
  }

  InvalidAssetUnsupportedReserve invalidAssetUnsupportedReserve() {
    return InvalidAssetUnsupportedReserve();
  }

  TooManyReserves tooManyReserves() {
    return TooManyReserves();
  }

  LocalExecutionIncomplete localExecutionIncomplete() {
    return LocalExecutionIncomplete();
  }

  TooManyAuthorizedAliases tooManyAuthorizedAliases() {
    return TooManyAuthorizedAliases();
  }

  ExpiresInPast expiresInPast() {
    return ExpiresInPast();
  }

  AliasNotFound aliasNotFound() {
    return AliasNotFound();
  }

  LocalExecutionIncompleteWithError localExecutionIncompleteWithError({
    required int index,
    required _i3.ExecutionError error,
  }) {
    return LocalExecutionIncompleteWithError(
      index: index,
      error: error,
    );
  }
}

class $ErrorCodec with _i1.Codec<Error> {
  const $ErrorCodec();

  @override
  Error decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Unreachable();
      case 1:
        return const SendFailure();
      case 2:
        return const Filtered();
      case 3:
        return const UnweighableMessage();
      case 4:
        return const DestinationNotInvertible();
      case 5:
        return const Empty();
      case 6:
        return const CannotReanchor();
      case 7:
        return const TooManyAssets();
      case 8:
        return const InvalidOrigin();
      case 9:
        return const BadVersion();
      case 10:
        return const BadLocation();
      case 11:
        return const NoSubscription();
      case 12:
        return const AlreadySubscribed();
      case 13:
        return const CannotCheckOutTeleport();
      case 14:
        return const LowBalance();
      case 15:
        return const TooManyLocks();
      case 16:
        return const AccountNotSovereign();
      case 17:
        return const FeesNotMet();
      case 18:
        return const LockNotFound();
      case 19:
        return const InUse();
      case 21:
        return const InvalidAssetUnknownReserve();
      case 22:
        return const InvalidAssetUnsupportedReserve();
      case 23:
        return const TooManyReserves();
      case 24:
        return const LocalExecutionIncomplete();
      case 25:
        return const TooManyAuthorizedAliases();
      case 26:
        return const ExpiresInPast();
      case 27:
        return const AliasNotFound();
      case 28:
        return LocalExecutionIncompleteWithError._decode(input);
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
      case Unreachable:
        (value as Unreachable).encodeTo(output);
        break;
      case SendFailure:
        (value as SendFailure).encodeTo(output);
        break;
      case Filtered:
        (value as Filtered).encodeTo(output);
        break;
      case UnweighableMessage:
        (value as UnweighableMessage).encodeTo(output);
        break;
      case DestinationNotInvertible:
        (value as DestinationNotInvertible).encodeTo(output);
        break;
      case Empty:
        (value as Empty).encodeTo(output);
        break;
      case CannotReanchor:
        (value as CannotReanchor).encodeTo(output);
        break;
      case TooManyAssets:
        (value as TooManyAssets).encodeTo(output);
        break;
      case InvalidOrigin:
        (value as InvalidOrigin).encodeTo(output);
        break;
      case BadVersion:
        (value as BadVersion).encodeTo(output);
        break;
      case BadLocation:
        (value as BadLocation).encodeTo(output);
        break;
      case NoSubscription:
        (value as NoSubscription).encodeTo(output);
        break;
      case AlreadySubscribed:
        (value as AlreadySubscribed).encodeTo(output);
        break;
      case CannotCheckOutTeleport:
        (value as CannotCheckOutTeleport).encodeTo(output);
        break;
      case LowBalance:
        (value as LowBalance).encodeTo(output);
        break;
      case TooManyLocks:
        (value as TooManyLocks).encodeTo(output);
        break;
      case AccountNotSovereign:
        (value as AccountNotSovereign).encodeTo(output);
        break;
      case FeesNotMet:
        (value as FeesNotMet).encodeTo(output);
        break;
      case LockNotFound:
        (value as LockNotFound).encodeTo(output);
        break;
      case InUse:
        (value as InUse).encodeTo(output);
        break;
      case InvalidAssetUnknownReserve:
        (value as InvalidAssetUnknownReserve).encodeTo(output);
        break;
      case InvalidAssetUnsupportedReserve:
        (value as InvalidAssetUnsupportedReserve).encodeTo(output);
        break;
      case TooManyReserves:
        (value as TooManyReserves).encodeTo(output);
        break;
      case LocalExecutionIncomplete:
        (value as LocalExecutionIncomplete).encodeTo(output);
        break;
      case TooManyAuthorizedAliases:
        (value as TooManyAuthorizedAliases).encodeTo(output);
        break;
      case ExpiresInPast:
        (value as ExpiresInPast).encodeTo(output);
        break;
      case AliasNotFound:
        (value as AliasNotFound).encodeTo(output);
        break;
      case LocalExecutionIncompleteWithError:
        (value as LocalExecutionIncompleteWithError).encodeTo(output);
        break;
      default:
        throw Exception('Error: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Error value) {
    switch (value.runtimeType) {
      case Unreachable:
        return 1;
      case SendFailure:
        return 1;
      case Filtered:
        return 1;
      case UnweighableMessage:
        return 1;
      case DestinationNotInvertible:
        return 1;
      case Empty:
        return 1;
      case CannotReanchor:
        return 1;
      case TooManyAssets:
        return 1;
      case InvalidOrigin:
        return 1;
      case BadVersion:
        return 1;
      case BadLocation:
        return 1;
      case NoSubscription:
        return 1;
      case AlreadySubscribed:
        return 1;
      case CannotCheckOutTeleport:
        return 1;
      case LowBalance:
        return 1;
      case TooManyLocks:
        return 1;
      case AccountNotSovereign:
        return 1;
      case FeesNotMet:
        return 1;
      case LockNotFound:
        return 1;
      case InUse:
        return 1;
      case InvalidAssetUnknownReserve:
        return 1;
      case InvalidAssetUnsupportedReserve:
        return 1;
      case TooManyReserves:
        return 1;
      case LocalExecutionIncomplete:
        return 1;
      case TooManyAuthorizedAliases:
        return 1;
      case ExpiresInPast:
        return 1;
      case AliasNotFound:
        return 1;
      case LocalExecutionIncompleteWithError:
        return (value as LocalExecutionIncompleteWithError)._sizeHint();
      default:
        throw Exception('Error: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// The desired destination was unreachable, generally because there is a no way of routing
/// to it.
class Unreachable extends Error {
  const Unreachable();

  @override
  Map<String, dynamic> toJson() => {'Unreachable': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Unreachable;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// There was some other issue (i.e. not to do with routing) in sending the message.
/// Perhaps a lack of space for buffering the message.
class SendFailure extends Error {
  const SendFailure();

  @override
  Map<String, dynamic> toJson() => {'SendFailure': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is SendFailure;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The message execution fails the filter.
class Filtered extends Error {
  const Filtered();

  @override
  Map<String, dynamic> toJson() => {'Filtered': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Filtered;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The message's weight could not be determined.
class UnweighableMessage extends Error {
  const UnweighableMessage();

  @override
  Map<String, dynamic> toJson() => {'UnweighableMessage': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is UnweighableMessage;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The destination `Location` provided cannot be inverted.
class DestinationNotInvertible extends Error {
  const DestinationNotInvertible();

  @override
  Map<String, dynamic> toJson() => {'DestinationNotInvertible': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is DestinationNotInvertible;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The assets to be sent are empty.
class Empty extends Error {
  const Empty();

  @override
  Map<String, dynamic> toJson() => {'Empty': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Empty;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Could not re-anchor the assets to declare the fees for the destination chain.
class CannotReanchor extends Error {
  const CannotReanchor();

  @override
  Map<String, dynamic> toJson() => {'CannotReanchor': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is CannotReanchor;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Too many assets have been attempted for transfer.
class TooManyAssets extends Error {
  const TooManyAssets();

  @override
  Map<String, dynamic> toJson() => {'TooManyAssets': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is TooManyAssets;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Origin is invalid for sending.
class InvalidOrigin extends Error {
  const InvalidOrigin();

  @override
  Map<String, dynamic> toJson() => {'InvalidOrigin': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is InvalidOrigin;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The version of the `Versioned` value used is not able to be interpreted.
class BadVersion extends Error {
  const BadVersion();

  @override
  Map<String, dynamic> toJson() => {'BadVersion': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is BadVersion;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The given location could not be used (e.g. because it cannot be expressed in the
/// desired version of XCM).
class BadLocation extends Error {
  const BadLocation();

  @override
  Map<String, dynamic> toJson() => {'BadLocation': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is BadLocation;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The referenced subscription could not be found.
class NoSubscription extends Error {
  const NoSubscription();

  @override
  Map<String, dynamic> toJson() => {'NoSubscription': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is NoSubscription;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The location is invalid since it already has a subscription from us.
class AlreadySubscribed extends Error {
  const AlreadySubscribed();

  @override
  Map<String, dynamic> toJson() => {'AlreadySubscribed': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is AlreadySubscribed;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Could not check-out the assets for teleportation to the destination chain.
class CannotCheckOutTeleport extends Error {
  const CannotCheckOutTeleport();

  @override
  Map<String, dynamic> toJson() => {'CannotCheckOutTeleport': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is CannotCheckOutTeleport;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The owner does not own (all) of the asset that they wish to do the operation on.
class LowBalance extends Error {
  const LowBalance();

  @override
  Map<String, dynamic> toJson() => {'LowBalance': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      14,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is LowBalance;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The asset owner has too many locks on the asset.
class TooManyLocks extends Error {
  const TooManyLocks();

  @override
  Map<String, dynamic> toJson() => {'TooManyLocks': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      15,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is TooManyLocks;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The given account is not an identifiable sovereign account for any location.
class AccountNotSovereign extends Error {
  const AccountNotSovereign();

  @override
  Map<String, dynamic> toJson() => {'AccountNotSovereign': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      16,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is AccountNotSovereign;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The operation required fees to be paid which the initiator could not meet.
class FeesNotMet extends Error {
  const FeesNotMet();

  @override
  Map<String, dynamic> toJson() => {'FeesNotMet': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      17,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is FeesNotMet;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// A remote lock with the corresponding data could not be found.
class LockNotFound extends Error {
  const LockNotFound();

  @override
  Map<String, dynamic> toJson() => {'LockNotFound': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      18,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is LockNotFound;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The unlock operation cannot succeed because there are still consumers of the lock.
class InUse extends Error {
  const InUse();

  @override
  Map<String, dynamic> toJson() => {'InUse': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      19,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is InUse;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Invalid asset, reserve chain could not be determined for it.
class InvalidAssetUnknownReserve extends Error {
  const InvalidAssetUnknownReserve();

  @override
  Map<String, dynamic> toJson() => {'InvalidAssetUnknownReserve': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      21,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is InvalidAssetUnknownReserve;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Invalid asset, do not support remote asset reserves with different fees reserves.
class InvalidAssetUnsupportedReserve extends Error {
  const InvalidAssetUnsupportedReserve();

  @override
  Map<String, dynamic> toJson() => {'InvalidAssetUnsupportedReserve': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      22,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is InvalidAssetUnsupportedReserve;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Too many assets with different reserve locations have been attempted for transfer.
class TooManyReserves extends Error {
  const TooManyReserves();

  @override
  Map<String, dynamic> toJson() => {'TooManyReserves': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      23,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is TooManyReserves;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Local XCM execution incomplete.
class LocalExecutionIncomplete extends Error {
  const LocalExecutionIncomplete();

  @override
  Map<String, dynamic> toJson() => {'LocalExecutionIncomplete': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      24,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is LocalExecutionIncomplete;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Too many locations authorized to alias origin.
class TooManyAuthorizedAliases extends Error {
  const TooManyAuthorizedAliases();

  @override
  Map<String, dynamic> toJson() => {'TooManyAuthorizedAliases': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      25,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is TooManyAuthorizedAliases;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Expiry block number is in the past.
class ExpiresInPast extends Error {
  const ExpiresInPast();

  @override
  Map<String, dynamic> toJson() => {'ExpiresInPast': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      26,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is ExpiresInPast;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The alias to remove authorization for was not found.
class AliasNotFound extends Error {
  const AliasNotFound();

  @override
  Map<String, dynamic> toJson() => {'AliasNotFound': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      27,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is AliasNotFound;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Local XCM execution incomplete with the actual XCM error and the index of the
/// instruction that caused the error.
class LocalExecutionIncompleteWithError extends Error {
  const LocalExecutionIncompleteWithError({
    required this.index,
    required this.error,
  });

  factory LocalExecutionIncompleteWithError._decode(_i1.Input input) {
    return LocalExecutionIncompleteWithError(
      index: _i1.U8Codec.codec.decode(input),
      error: _i3.ExecutionError.codec.decode(input),
    );
  }

  /// InstructionIndex
  final int index;

  /// ExecutionError
  final _i3.ExecutionError error;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'LocalExecutionIncompleteWithError': {
          'index': index,
          'error': error.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8Codec.codec.sizeHint(index);
    size = size + _i3.ExecutionError.codec.sizeHint(error);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      28,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      index,
      output,
    );
    _i3.ExecutionError.codec.encodeTo(
      error,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is LocalExecutionIncompleteWithError && other.index == index && other.error == error;

  @override
  int get hashCode => Object.hash(
        index,
        error,
      );
}
