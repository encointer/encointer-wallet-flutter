// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;

enum Error {
  unreachable('Unreachable', 0),
  sendFailure('SendFailure', 1),
  filtered('Filtered', 2),
  unweighableMessage('UnweighableMessage', 3),
  destinationNotInvertible('DestinationNotInvertible', 4),
  empty('Empty', 5),
  cannotReanchor('CannotReanchor', 6),
  tooManyAssets('TooManyAssets', 7),
  invalidOrigin('InvalidOrigin', 8),
  badVersion('BadVersion', 9),
  badLocation('BadLocation', 10),
  noSubscription('NoSubscription', 11),
  alreadySubscribed('AlreadySubscribed', 12),
  invalidAsset('InvalidAsset', 13),
  lowBalance('LowBalance', 14),
  tooManyLocks('TooManyLocks', 15),
  accountNotSovereign('AccountNotSovereign', 16),
  feesNotMet('FeesNotMet', 17),
  lockNotFound('LockNotFound', 18),
  inUse('InUse', 19);

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
        return Error.unreachable;
      case 1:
        return Error.sendFailure;
      case 2:
        return Error.filtered;
      case 3:
        return Error.unweighableMessage;
      case 4:
        return Error.destinationNotInvertible;
      case 5:
        return Error.empty;
      case 6:
        return Error.cannotReanchor;
      case 7:
        return Error.tooManyAssets;
      case 8:
        return Error.invalidOrigin;
      case 9:
        return Error.badVersion;
      case 10:
        return Error.badLocation;
      case 11:
        return Error.noSubscription;
      case 12:
        return Error.alreadySubscribed;
      case 13:
        return Error.invalidAsset;
      case 14:
        return Error.lowBalance;
      case 15:
        return Error.tooManyLocks;
      case 16:
        return Error.accountNotSovereign;
      case 17:
        return Error.feesNotMet;
      case 18:
        return Error.lockNotFound;
      case 19:
        return Error.inUse;
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
