// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// The signing account has no permission to do the operation.
  noPermission('NoPermission', 0),

  /// The given item ID is unknown.
  unknownCollection('UnknownCollection', 1),

  /// The item ID has already been used for an item.
  alreadyExists('AlreadyExists', 2),

  /// The owner turned out to be different to what was expected.
  wrongOwner('WrongOwner', 3),

  /// Invalid witness data given.
  badWitness('BadWitness', 4),

  /// The item ID is already taken.
  inUse('InUse', 5),

  /// The item or collection is frozen.
  frozen('Frozen', 6),

  /// The delegate turned out to be different to what was expected.
  wrongDelegate('WrongDelegate', 7),

  /// There is no delegate approved.
  noDelegate('NoDelegate', 8),

  /// No approval exists that would allow the transfer.
  unapproved('Unapproved', 9),

  /// The named owner has not signed ownership of the collection is acceptable.
  unaccepted('Unaccepted', 10),

  /// The item is locked.
  locked('Locked', 11),

  /// All items have been minted.
  maxSupplyReached('MaxSupplyReached', 12),

  /// The max supply has already been set.
  maxSupplyAlreadySet('MaxSupplyAlreadySet', 13),

  /// The provided max supply is less to the amount of items a collection already has.
  maxSupplyTooSmall('MaxSupplyTooSmall', 14),

  /// The given item ID is unknown.
  unknownItem('UnknownItem', 15),

  /// Item is not for sale.
  notForSale('NotForSale', 16),

  /// The provided bid is too low.
  bidTooLow('BidTooLow', 17),

  /// No metadata is found.
  noMetadata('NoMetadata', 18),

  /// Wrong metadata key/value bytes supplied.
  wrongMetadata('WrongMetadata', 19),

  /// An attribute is not found.
  attributeNotFound('AttributeNotFound', 20),

  /// Wrong attribute key/value bytes supplied.
  wrongAttribute('WrongAttribute', 21);

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
        return Error.noPermission;
      case 1:
        return Error.unknownCollection;
      case 2:
        return Error.alreadyExists;
      case 3:
        return Error.wrongOwner;
      case 4:
        return Error.badWitness;
      case 5:
        return Error.inUse;
      case 6:
        return Error.frozen;
      case 7:
        return Error.wrongDelegate;
      case 8:
        return Error.noDelegate;
      case 9:
        return Error.unapproved;
      case 10:
        return Error.unaccepted;
      case 11:
        return Error.locked;
      case 12:
        return Error.maxSupplyReached;
      case 13:
        return Error.maxSupplyAlreadySet;
      case 14:
        return Error.maxSupplyTooSmall;
      case 15:
        return Error.unknownItem;
      case 16:
        return Error.notForSale;
      case 17:
        return Error.bidTooLow;
      case 18:
        return Error.noMetadata;
      case 19:
        return Error.wrongMetadata;
      case 20:
        return Error.attributeNotFound;
      case 21:
        return Error.wrongAttribute;
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
