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

  /// The approval had a deadline that expired, so the approval isn't valid anymore.
  approvalExpired('ApprovalExpired', 3),

  /// The owner turned out to be different to what was expected.
  wrongOwner('WrongOwner', 4),

  /// The witness data given does not match the current state of the chain.
  badWitness('BadWitness', 5),

  /// Collection ID is already taken.
  collectionIdInUse('CollectionIdInUse', 6),

  /// Items within that collection are non-transferable.
  itemsNonTransferable('ItemsNonTransferable', 7),

  /// The provided account is not a delegate.
  notDelegate('NotDelegate', 8),

  /// The delegate turned out to be different to what was expected.
  wrongDelegate('WrongDelegate', 9),

  /// No approval exists that would allow the transfer.
  unapproved('Unapproved', 10),

  /// The named owner has not signed ownership acceptance of the collection.
  unaccepted('Unaccepted', 11),

  /// The item is locked (non-transferable).
  itemLocked('ItemLocked', 12),

  /// Item's attributes are locked.
  lockedItemAttributes('LockedItemAttributes', 13),

  /// Collection's attributes are locked.
  lockedCollectionAttributes('LockedCollectionAttributes', 14),

  /// Item's metadata is locked.
  lockedItemMetadata('LockedItemMetadata', 15),

  /// Collection's metadata is locked.
  lockedCollectionMetadata('LockedCollectionMetadata', 16),

  /// All items have been minted.
  maxSupplyReached('MaxSupplyReached', 17),

  /// The max supply is locked and can't be changed.
  maxSupplyLocked('MaxSupplyLocked', 18),

  /// The provided max supply is less than the number of items a collection already has.
  maxSupplyTooSmall('MaxSupplyTooSmall', 19),

  /// The given item ID is unknown.
  unknownItem('UnknownItem', 20),

  /// Swap doesn't exist.
  unknownSwap('UnknownSwap', 21),

  /// The given item has no metadata set.
  metadataNotFound('MetadataNotFound', 22),

  /// The provided attribute can't be found.
  attributeNotFound('AttributeNotFound', 23),

  /// Item is not for sale.
  notForSale('NotForSale', 24),

  /// The provided bid is too low.
  bidTooLow('BidTooLow', 25),

  /// The item has reached its approval limit.
  reachedApprovalLimit('ReachedApprovalLimit', 26),

  /// The deadline has already expired.
  deadlineExpired('DeadlineExpired', 27),

  /// The duration provided should be less than or equal to `MaxDeadlineDuration`.
  wrongDuration('WrongDuration', 28),

  /// The method is disabled by system settings.
  methodDisabled('MethodDisabled', 29),

  /// The provided setting can't be set.
  wrongSetting('WrongSetting', 30),

  /// Item's config already exists and should be equal to the provided one.
  inconsistentItemConfig('InconsistentItemConfig', 31),

  /// Config for a collection or an item can't be found.
  noConfig('NoConfig', 32),

  /// Some roles were not cleared.
  rolesNotCleared('RolesNotCleared', 33),

  /// Mint has not started yet.
  mintNotStarted('MintNotStarted', 34),

  /// Mint has already ended.
  mintEnded('MintEnded', 35),

  /// The provided Item was already used for claiming.
  alreadyClaimed('AlreadyClaimed', 36),

  /// The provided data is incorrect.
  incorrectData('IncorrectData', 37),

  /// The extrinsic was sent by the wrong origin.
  wrongOrigin('WrongOrigin', 38),

  /// The provided signature is incorrect.
  wrongSignature('WrongSignature', 39),

  /// The provided metadata might be too long.
  incorrectMetadata('IncorrectMetadata', 40),

  /// Can't set more attributes per one call.
  maxAttributesLimitReached('MaxAttributesLimitReached', 41),

  /// The provided namespace isn't supported in this call.
  wrongNamespace('WrongNamespace', 42),

  /// Can't delete non-empty collections.
  collectionNotEmpty('CollectionNotEmpty', 43),

  /// The witness data should be provided.
  witnessRequired('WitnessRequired', 44);

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
        return Error.approvalExpired;
      case 4:
        return Error.wrongOwner;
      case 5:
        return Error.badWitness;
      case 6:
        return Error.collectionIdInUse;
      case 7:
        return Error.itemsNonTransferable;
      case 8:
        return Error.notDelegate;
      case 9:
        return Error.wrongDelegate;
      case 10:
        return Error.unapproved;
      case 11:
        return Error.unaccepted;
      case 12:
        return Error.itemLocked;
      case 13:
        return Error.lockedItemAttributes;
      case 14:
        return Error.lockedCollectionAttributes;
      case 15:
        return Error.lockedItemMetadata;
      case 16:
        return Error.lockedCollectionMetadata;
      case 17:
        return Error.maxSupplyReached;
      case 18:
        return Error.maxSupplyLocked;
      case 19:
        return Error.maxSupplyTooSmall;
      case 20:
        return Error.unknownItem;
      case 21:
        return Error.unknownSwap;
      case 22:
        return Error.metadataNotFound;
      case 23:
        return Error.attributeNotFound;
      case 24:
        return Error.notForSale;
      case 25:
        return Error.bidTooLow;
      case 26:
        return Error.reachedApprovalLimit;
      case 27:
        return Error.deadlineExpired;
      case 28:
        return Error.wrongDuration;
      case 29:
        return Error.methodDisabled;
      case 30:
        return Error.wrongSetting;
      case 31:
        return Error.inconsistentItemConfig;
      case 32:
        return Error.noConfig;
      case 33:
        return Error.rolesNotCleared;
      case 34:
        return Error.mintNotStarted;
      case 35:
        return Error.mintEnded;
      case 36:
        return Error.alreadyClaimed;
      case 37:
        return Error.incorrectData;
      case 38:
        return Error.wrongOrigin;
      case 39:
        return Error.wrongSignature;
      case 40:
        return Error.incorrectMetadata;
      case 41:
        return Error.maxAttributesLimitReached;
      case 42:
        return Error.wrongNamespace;
      case 43:
        return Error.collectionNotEmpty;
      case 44:
        return Error.witnessRequired;
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
