// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i7;

import '../../sp_core/crypto/account_id32.dart' as _i3;
import '../types/attribute_namespace.dart' as _i4;
import '../types/pallet_attributes.dart' as _i6;
import '../types/price_with_direction.dart' as _i5;

/// The `Event` enum of this pallet
abstract class Event {
  const Event();

  factory Event.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $EventCodec codec = $EventCodec();

  static const $Event values = $Event();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, dynamic>> toJson();
}

class $Event {
  const $Event();

  Created created({
    required int collection,
    required _i3.AccountId32 creator,
    required _i3.AccountId32 owner,
  }) {
    return Created(
      collection: collection,
      creator: creator,
      owner: owner,
    );
  }

  ForceCreated forceCreated({
    required int collection,
    required _i3.AccountId32 owner,
  }) {
    return ForceCreated(
      collection: collection,
      owner: owner,
    );
  }

  Destroyed destroyed({required int collection}) {
    return Destroyed(collection: collection);
  }

  Issued issued({
    required int collection,
    required int item,
    required _i3.AccountId32 owner,
  }) {
    return Issued(
      collection: collection,
      item: item,
      owner: owner,
    );
  }

  Transferred transferred({
    required int collection,
    required int item,
    required _i3.AccountId32 from,
    required _i3.AccountId32 to,
  }) {
    return Transferred(
      collection: collection,
      item: item,
      from: from,
      to: to,
    );
  }

  Burned burned({
    required int collection,
    required int item,
    required _i3.AccountId32 owner,
  }) {
    return Burned(
      collection: collection,
      item: item,
      owner: owner,
    );
  }

  ItemTransferLocked itemTransferLocked({
    required int collection,
    required int item,
  }) {
    return ItemTransferLocked(
      collection: collection,
      item: item,
    );
  }

  ItemTransferUnlocked itemTransferUnlocked({
    required int collection,
    required int item,
  }) {
    return ItemTransferUnlocked(
      collection: collection,
      item: item,
    );
  }

  ItemPropertiesLocked itemPropertiesLocked({
    required int collection,
    required int item,
    required bool lockMetadata,
    required bool lockAttributes,
  }) {
    return ItemPropertiesLocked(
      collection: collection,
      item: item,
      lockMetadata: lockMetadata,
      lockAttributes: lockAttributes,
    );
  }

  CollectionLocked collectionLocked({required int collection}) {
    return CollectionLocked(collection: collection);
  }

  OwnerChanged ownerChanged({
    required int collection,
    required _i3.AccountId32 newOwner,
  }) {
    return OwnerChanged(
      collection: collection,
      newOwner: newOwner,
    );
  }

  TeamChanged teamChanged({
    required int collection,
    _i3.AccountId32? issuer,
    _i3.AccountId32? admin,
    _i3.AccountId32? freezer,
  }) {
    return TeamChanged(
      collection: collection,
      issuer: issuer,
      admin: admin,
      freezer: freezer,
    );
  }

  TransferApproved transferApproved({
    required int collection,
    required int item,
    required _i3.AccountId32 owner,
    required _i3.AccountId32 delegate,
    int? deadline,
  }) {
    return TransferApproved(
      collection: collection,
      item: item,
      owner: owner,
      delegate: delegate,
      deadline: deadline,
    );
  }

  ApprovalCancelled approvalCancelled({
    required int collection,
    required int item,
    required _i3.AccountId32 owner,
    required _i3.AccountId32 delegate,
  }) {
    return ApprovalCancelled(
      collection: collection,
      item: item,
      owner: owner,
      delegate: delegate,
    );
  }

  AllApprovalsCancelled allApprovalsCancelled({
    required int collection,
    required int item,
    required _i3.AccountId32 owner,
  }) {
    return AllApprovalsCancelled(
      collection: collection,
      item: item,
      owner: owner,
    );
  }

  CollectionConfigChanged collectionConfigChanged({required int collection}) {
    return CollectionConfigChanged(collection: collection);
  }

  CollectionMetadataSet collectionMetadataSet({
    required int collection,
    required List<int> data,
  }) {
    return CollectionMetadataSet(
      collection: collection,
      data: data,
    );
  }

  CollectionMetadataCleared collectionMetadataCleared({required int collection}) {
    return CollectionMetadataCleared(collection: collection);
  }

  ItemMetadataSet itemMetadataSet({
    required int collection,
    required int item,
    required List<int> data,
  }) {
    return ItemMetadataSet(
      collection: collection,
      item: item,
      data: data,
    );
  }

  ItemMetadataCleared itemMetadataCleared({
    required int collection,
    required int item,
  }) {
    return ItemMetadataCleared(
      collection: collection,
      item: item,
    );
  }

  Redeposited redeposited({
    required int collection,
    required List<int> successfulItems,
  }) {
    return Redeposited(
      collection: collection,
      successfulItems: successfulItems,
    );
  }

  AttributeSet attributeSet({
    required int collection,
    int? maybeItem,
    required List<int> key,
    required List<int> value,
    required _i4.AttributeNamespace namespace,
  }) {
    return AttributeSet(
      collection: collection,
      maybeItem: maybeItem,
      key: key,
      value: value,
      namespace: namespace,
    );
  }

  AttributeCleared attributeCleared({
    required int collection,
    int? maybeItem,
    required List<int> key,
    required _i4.AttributeNamespace namespace,
  }) {
    return AttributeCleared(
      collection: collection,
      maybeItem: maybeItem,
      key: key,
      namespace: namespace,
    );
  }

  ItemAttributesApprovalAdded itemAttributesApprovalAdded({
    required int collection,
    required int item,
    required _i3.AccountId32 delegate,
  }) {
    return ItemAttributesApprovalAdded(
      collection: collection,
      item: item,
      delegate: delegate,
    );
  }

  ItemAttributesApprovalRemoved itemAttributesApprovalRemoved({
    required int collection,
    required int item,
    required _i3.AccountId32 delegate,
  }) {
    return ItemAttributesApprovalRemoved(
      collection: collection,
      item: item,
      delegate: delegate,
    );
  }

  OwnershipAcceptanceChanged ownershipAcceptanceChanged({
    required _i3.AccountId32 who,
    int? maybeCollection,
  }) {
    return OwnershipAcceptanceChanged(
      who: who,
      maybeCollection: maybeCollection,
    );
  }

  CollectionMaxSupplySet collectionMaxSupplySet({
    required int collection,
    required int maxSupply,
  }) {
    return CollectionMaxSupplySet(
      collection: collection,
      maxSupply: maxSupply,
    );
  }

  CollectionMintSettingsUpdated collectionMintSettingsUpdated({required int collection}) {
    return CollectionMintSettingsUpdated(collection: collection);
  }

  NextCollectionIdIncremented nextCollectionIdIncremented({int? nextId}) {
    return NextCollectionIdIncremented(nextId: nextId);
  }

  ItemPriceSet itemPriceSet({
    required int collection,
    required int item,
    required BigInt price,
    _i3.AccountId32? whitelistedBuyer,
  }) {
    return ItemPriceSet(
      collection: collection,
      item: item,
      price: price,
      whitelistedBuyer: whitelistedBuyer,
    );
  }

  ItemPriceRemoved itemPriceRemoved({
    required int collection,
    required int item,
  }) {
    return ItemPriceRemoved(
      collection: collection,
      item: item,
    );
  }

  ItemBought itemBought({
    required int collection,
    required int item,
    required BigInt price,
    required _i3.AccountId32 seller,
    required _i3.AccountId32 buyer,
  }) {
    return ItemBought(
      collection: collection,
      item: item,
      price: price,
      seller: seller,
      buyer: buyer,
    );
  }

  TipSent tipSent({
    required int collection,
    required int item,
    required _i3.AccountId32 sender,
    required _i3.AccountId32 receiver,
    required BigInt amount,
  }) {
    return TipSent(
      collection: collection,
      item: item,
      sender: sender,
      receiver: receiver,
      amount: amount,
    );
  }

  SwapCreated swapCreated({
    required int offeredCollection,
    required int offeredItem,
    required int desiredCollection,
    int? desiredItem,
    _i5.PriceWithDirection? price,
    required int deadline,
  }) {
    return SwapCreated(
      offeredCollection: offeredCollection,
      offeredItem: offeredItem,
      desiredCollection: desiredCollection,
      desiredItem: desiredItem,
      price: price,
      deadline: deadline,
    );
  }

  SwapCancelled swapCancelled({
    required int offeredCollection,
    required int offeredItem,
    required int desiredCollection,
    int? desiredItem,
    _i5.PriceWithDirection? price,
    required int deadline,
  }) {
    return SwapCancelled(
      offeredCollection: offeredCollection,
      offeredItem: offeredItem,
      desiredCollection: desiredCollection,
      desiredItem: desiredItem,
      price: price,
      deadline: deadline,
    );
  }

  SwapClaimed swapClaimed({
    required int sentCollection,
    required int sentItem,
    required _i3.AccountId32 sentItemOwner,
    required int receivedCollection,
    required int receivedItem,
    required _i3.AccountId32 receivedItemOwner,
    _i5.PriceWithDirection? price,
    required int deadline,
  }) {
    return SwapClaimed(
      sentCollection: sentCollection,
      sentItem: sentItem,
      sentItemOwner: sentItemOwner,
      receivedCollection: receivedCollection,
      receivedItem: receivedItem,
      receivedItemOwner: receivedItemOwner,
      price: price,
      deadline: deadline,
    );
  }

  PreSignedAttributesSet preSignedAttributesSet({
    required int collection,
    required int item,
    required _i4.AttributeNamespace namespace,
  }) {
    return PreSignedAttributesSet(
      collection: collection,
      item: item,
      namespace: namespace,
    );
  }

  PalletAttributeSet palletAttributeSet({
    required int collection,
    int? item,
    required _i6.PalletAttributes attribute,
    required List<int> value,
  }) {
    return PalletAttributeSet(
      collection: collection,
      item: item,
      attribute: attribute,
      value: value,
    );
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Created._decode(input);
      case 1:
        return ForceCreated._decode(input);
      case 2:
        return Destroyed._decode(input);
      case 3:
        return Issued._decode(input);
      case 4:
        return Transferred._decode(input);
      case 5:
        return Burned._decode(input);
      case 6:
        return ItemTransferLocked._decode(input);
      case 7:
        return ItemTransferUnlocked._decode(input);
      case 8:
        return ItemPropertiesLocked._decode(input);
      case 9:
        return CollectionLocked._decode(input);
      case 10:
        return OwnerChanged._decode(input);
      case 11:
        return TeamChanged._decode(input);
      case 12:
        return TransferApproved._decode(input);
      case 13:
        return ApprovalCancelled._decode(input);
      case 14:
        return AllApprovalsCancelled._decode(input);
      case 15:
        return CollectionConfigChanged._decode(input);
      case 16:
        return CollectionMetadataSet._decode(input);
      case 17:
        return CollectionMetadataCleared._decode(input);
      case 18:
        return ItemMetadataSet._decode(input);
      case 19:
        return ItemMetadataCleared._decode(input);
      case 20:
        return Redeposited._decode(input);
      case 21:
        return AttributeSet._decode(input);
      case 22:
        return AttributeCleared._decode(input);
      case 23:
        return ItemAttributesApprovalAdded._decode(input);
      case 24:
        return ItemAttributesApprovalRemoved._decode(input);
      case 25:
        return OwnershipAcceptanceChanged._decode(input);
      case 26:
        return CollectionMaxSupplySet._decode(input);
      case 27:
        return CollectionMintSettingsUpdated._decode(input);
      case 28:
        return NextCollectionIdIncremented._decode(input);
      case 29:
        return ItemPriceSet._decode(input);
      case 30:
        return ItemPriceRemoved._decode(input);
      case 31:
        return ItemBought._decode(input);
      case 32:
        return TipSent._decode(input);
      case 33:
        return SwapCreated._decode(input);
      case 34:
        return SwapCancelled._decode(input);
      case 35:
        return SwapClaimed._decode(input);
      case 36:
        return PreSignedAttributesSet._decode(input);
      case 37:
        return PalletAttributeSet._decode(input);
      default:
        throw Exception('Event: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Event value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Created:
        (value as Created).encodeTo(output);
        break;
      case ForceCreated:
        (value as ForceCreated).encodeTo(output);
        break;
      case Destroyed:
        (value as Destroyed).encodeTo(output);
        break;
      case Issued:
        (value as Issued).encodeTo(output);
        break;
      case Transferred:
        (value as Transferred).encodeTo(output);
        break;
      case Burned:
        (value as Burned).encodeTo(output);
        break;
      case ItemTransferLocked:
        (value as ItemTransferLocked).encodeTo(output);
        break;
      case ItemTransferUnlocked:
        (value as ItemTransferUnlocked).encodeTo(output);
        break;
      case ItemPropertiesLocked:
        (value as ItemPropertiesLocked).encodeTo(output);
        break;
      case CollectionLocked:
        (value as CollectionLocked).encodeTo(output);
        break;
      case OwnerChanged:
        (value as OwnerChanged).encodeTo(output);
        break;
      case TeamChanged:
        (value as TeamChanged).encodeTo(output);
        break;
      case TransferApproved:
        (value as TransferApproved).encodeTo(output);
        break;
      case ApprovalCancelled:
        (value as ApprovalCancelled).encodeTo(output);
        break;
      case AllApprovalsCancelled:
        (value as AllApprovalsCancelled).encodeTo(output);
        break;
      case CollectionConfigChanged:
        (value as CollectionConfigChanged).encodeTo(output);
        break;
      case CollectionMetadataSet:
        (value as CollectionMetadataSet).encodeTo(output);
        break;
      case CollectionMetadataCleared:
        (value as CollectionMetadataCleared).encodeTo(output);
        break;
      case ItemMetadataSet:
        (value as ItemMetadataSet).encodeTo(output);
        break;
      case ItemMetadataCleared:
        (value as ItemMetadataCleared).encodeTo(output);
        break;
      case Redeposited:
        (value as Redeposited).encodeTo(output);
        break;
      case AttributeSet:
        (value as AttributeSet).encodeTo(output);
        break;
      case AttributeCleared:
        (value as AttributeCleared).encodeTo(output);
        break;
      case ItemAttributesApprovalAdded:
        (value as ItemAttributesApprovalAdded).encodeTo(output);
        break;
      case ItemAttributesApprovalRemoved:
        (value as ItemAttributesApprovalRemoved).encodeTo(output);
        break;
      case OwnershipAcceptanceChanged:
        (value as OwnershipAcceptanceChanged).encodeTo(output);
        break;
      case CollectionMaxSupplySet:
        (value as CollectionMaxSupplySet).encodeTo(output);
        break;
      case CollectionMintSettingsUpdated:
        (value as CollectionMintSettingsUpdated).encodeTo(output);
        break;
      case NextCollectionIdIncremented:
        (value as NextCollectionIdIncremented).encodeTo(output);
        break;
      case ItemPriceSet:
        (value as ItemPriceSet).encodeTo(output);
        break;
      case ItemPriceRemoved:
        (value as ItemPriceRemoved).encodeTo(output);
        break;
      case ItemBought:
        (value as ItemBought).encodeTo(output);
        break;
      case TipSent:
        (value as TipSent).encodeTo(output);
        break;
      case SwapCreated:
        (value as SwapCreated).encodeTo(output);
        break;
      case SwapCancelled:
        (value as SwapCancelled).encodeTo(output);
        break;
      case SwapClaimed:
        (value as SwapClaimed).encodeTo(output);
        break;
      case PreSignedAttributesSet:
        (value as PreSignedAttributesSet).encodeTo(output);
        break;
      case PalletAttributeSet:
        (value as PalletAttributeSet).encodeTo(output);
        break;
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case Created:
        return (value as Created)._sizeHint();
      case ForceCreated:
        return (value as ForceCreated)._sizeHint();
      case Destroyed:
        return (value as Destroyed)._sizeHint();
      case Issued:
        return (value as Issued)._sizeHint();
      case Transferred:
        return (value as Transferred)._sizeHint();
      case Burned:
        return (value as Burned)._sizeHint();
      case ItemTransferLocked:
        return (value as ItemTransferLocked)._sizeHint();
      case ItemTransferUnlocked:
        return (value as ItemTransferUnlocked)._sizeHint();
      case ItemPropertiesLocked:
        return (value as ItemPropertiesLocked)._sizeHint();
      case CollectionLocked:
        return (value as CollectionLocked)._sizeHint();
      case OwnerChanged:
        return (value as OwnerChanged)._sizeHint();
      case TeamChanged:
        return (value as TeamChanged)._sizeHint();
      case TransferApproved:
        return (value as TransferApproved)._sizeHint();
      case ApprovalCancelled:
        return (value as ApprovalCancelled)._sizeHint();
      case AllApprovalsCancelled:
        return (value as AllApprovalsCancelled)._sizeHint();
      case CollectionConfigChanged:
        return (value as CollectionConfigChanged)._sizeHint();
      case CollectionMetadataSet:
        return (value as CollectionMetadataSet)._sizeHint();
      case CollectionMetadataCleared:
        return (value as CollectionMetadataCleared)._sizeHint();
      case ItemMetadataSet:
        return (value as ItemMetadataSet)._sizeHint();
      case ItemMetadataCleared:
        return (value as ItemMetadataCleared)._sizeHint();
      case Redeposited:
        return (value as Redeposited)._sizeHint();
      case AttributeSet:
        return (value as AttributeSet)._sizeHint();
      case AttributeCleared:
        return (value as AttributeCleared)._sizeHint();
      case ItemAttributesApprovalAdded:
        return (value as ItemAttributesApprovalAdded)._sizeHint();
      case ItemAttributesApprovalRemoved:
        return (value as ItemAttributesApprovalRemoved)._sizeHint();
      case OwnershipAcceptanceChanged:
        return (value as OwnershipAcceptanceChanged)._sizeHint();
      case CollectionMaxSupplySet:
        return (value as CollectionMaxSupplySet)._sizeHint();
      case CollectionMintSettingsUpdated:
        return (value as CollectionMintSettingsUpdated)._sizeHint();
      case NextCollectionIdIncremented:
        return (value as NextCollectionIdIncremented)._sizeHint();
      case ItemPriceSet:
        return (value as ItemPriceSet)._sizeHint();
      case ItemPriceRemoved:
        return (value as ItemPriceRemoved)._sizeHint();
      case ItemBought:
        return (value as ItemBought)._sizeHint();
      case TipSent:
        return (value as TipSent)._sizeHint();
      case SwapCreated:
        return (value as SwapCreated)._sizeHint();
      case SwapCancelled:
        return (value as SwapCancelled)._sizeHint();
      case SwapClaimed:
        return (value as SwapClaimed)._sizeHint();
      case PreSignedAttributesSet:
        return (value as PreSignedAttributesSet)._sizeHint();
      case PalletAttributeSet:
        return (value as PalletAttributeSet)._sizeHint();
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// A `collection` was created.
class Created extends Event {
  const Created({
    required this.collection,
    required this.creator,
    required this.owner,
  });

  factory Created._decode(_i1.Input input) {
    return Created(
      collection: _i1.U32Codec.codec.decode(input),
      creator: const _i1.U8ArrayCodec(32).decode(input),
      owner: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::AccountId
  final _i3.AccountId32 creator;

  /// T::AccountId
  final _i3.AccountId32 owner;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Created': {
          'collection': collection,
          'creator': creator.toList(),
          'owner': owner.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + const _i3.AccountId32Codec().sizeHint(creator);
    size = size + const _i3.AccountId32Codec().sizeHint(owner);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      creator,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      owner,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Created &&
          other.collection == collection &&
          _i7.listsEqual(
            other.creator,
            creator,
          ) &&
          _i7.listsEqual(
            other.owner,
            owner,
          );

  @override
  int get hashCode => Object.hash(
        collection,
        creator,
        owner,
      );
}

/// A `collection` was force-created.
class ForceCreated extends Event {
  const ForceCreated({
    required this.collection,
    required this.owner,
  });

  factory ForceCreated._decode(_i1.Input input) {
    return ForceCreated(
      collection: _i1.U32Codec.codec.decode(input),
      owner: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::AccountId
  final _i3.AccountId32 owner;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ForceCreated': {
          'collection': collection,
          'owner': owner.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + const _i3.AccountId32Codec().sizeHint(owner);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      owner,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceCreated &&
          other.collection == collection &&
          _i7.listsEqual(
            other.owner,
            owner,
          );

  @override
  int get hashCode => Object.hash(
        collection,
        owner,
      );
}

/// A `collection` was destroyed.
class Destroyed extends Event {
  const Destroyed({required this.collection});

  factory Destroyed._decode(_i1.Input input) {
    return Destroyed(collection: _i1.U32Codec.codec.decode(input));
  }

  /// T::CollectionId
  final int collection;

  @override
  Map<String, Map<String, int>> toJson() => {
        'Destroyed': {'collection': collection}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Destroyed && other.collection == collection;

  @override
  int get hashCode => collection.hashCode;
}

/// An `item` was issued.
class Issued extends Event {
  const Issued({
    required this.collection,
    required this.item,
    required this.owner,
  });

  factory Issued._decode(_i1.Input input) {
    return Issued(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      owner: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// T::AccountId
  final _i3.AccountId32 owner;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Issued': {
          'collection': collection,
          'item': item,
          'owner': owner.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + const _i3.AccountId32Codec().sizeHint(owner);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      owner,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Issued &&
          other.collection == collection &&
          other.item == item &&
          _i7.listsEqual(
            other.owner,
            owner,
          );

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        owner,
      );
}

/// An `item` was transferred.
class Transferred extends Event {
  const Transferred({
    required this.collection,
    required this.item,
    required this.from,
    required this.to,
  });

  factory Transferred._decode(_i1.Input input) {
    return Transferred(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      from: const _i1.U8ArrayCodec(32).decode(input),
      to: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// T::AccountId
  final _i3.AccountId32 from;

  /// T::AccountId
  final _i3.AccountId32 to;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Transferred': {
          'collection': collection,
          'item': item,
          'from': from.toList(),
          'to': to.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + const _i3.AccountId32Codec().sizeHint(from);
    size = size + const _i3.AccountId32Codec().sizeHint(to);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      from,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      to,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Transferred &&
          other.collection == collection &&
          other.item == item &&
          _i7.listsEqual(
            other.from,
            from,
          ) &&
          _i7.listsEqual(
            other.to,
            to,
          );

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        from,
        to,
      );
}

/// An `item` was destroyed.
class Burned extends Event {
  const Burned({
    required this.collection,
    required this.item,
    required this.owner,
  });

  factory Burned._decode(_i1.Input input) {
    return Burned(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      owner: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// T::AccountId
  final _i3.AccountId32 owner;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Burned': {
          'collection': collection,
          'item': item,
          'owner': owner.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + const _i3.AccountId32Codec().sizeHint(owner);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      owner,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Burned &&
          other.collection == collection &&
          other.item == item &&
          _i7.listsEqual(
            other.owner,
            owner,
          );

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        owner,
      );
}

/// An `item` became non-transferable.
class ItemTransferLocked extends Event {
  const ItemTransferLocked({
    required this.collection,
    required this.item,
  });

  factory ItemTransferLocked._decode(_i1.Input input) {
    return ItemTransferLocked(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  @override
  Map<String, Map<String, int>> toJson() => {
        'ItemTransferLocked': {
          'collection': collection,
          'item': item,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ItemTransferLocked && other.collection == collection && other.item == item;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
      );
}

/// An `item` became transferable.
class ItemTransferUnlocked extends Event {
  const ItemTransferUnlocked({
    required this.collection,
    required this.item,
  });

  factory ItemTransferUnlocked._decode(_i1.Input input) {
    return ItemTransferUnlocked(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  @override
  Map<String, Map<String, int>> toJson() => {
        'ItemTransferUnlocked': {
          'collection': collection,
          'item': item,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ItemTransferUnlocked && other.collection == collection && other.item == item;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
      );
}

/// `item` metadata or attributes were locked.
class ItemPropertiesLocked extends Event {
  const ItemPropertiesLocked({
    required this.collection,
    required this.item,
    required this.lockMetadata,
    required this.lockAttributes,
  });

  factory ItemPropertiesLocked._decode(_i1.Input input) {
    return ItemPropertiesLocked(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      lockMetadata: _i1.BoolCodec.codec.decode(input),
      lockAttributes: _i1.BoolCodec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// bool
  final bool lockMetadata;

  /// bool
  final bool lockAttributes;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ItemPropertiesLocked': {
          'collection': collection,
          'item': item,
          'lockMetadata': lockMetadata,
          'lockAttributes': lockAttributes,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + _i1.BoolCodec.codec.sizeHint(lockMetadata);
    size = size + _i1.BoolCodec.codec.sizeHint(lockAttributes);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      lockMetadata,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      lockAttributes,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ItemPropertiesLocked &&
          other.collection == collection &&
          other.item == item &&
          other.lockMetadata == lockMetadata &&
          other.lockAttributes == lockAttributes;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        lockMetadata,
        lockAttributes,
      );
}

/// Some `collection` was locked.
class CollectionLocked extends Event {
  const CollectionLocked({required this.collection});

  factory CollectionLocked._decode(_i1.Input input) {
    return CollectionLocked(collection: _i1.U32Codec.codec.decode(input));
  }

  /// T::CollectionId
  final int collection;

  @override
  Map<String, Map<String, int>> toJson() => {
        'CollectionLocked': {'collection': collection}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CollectionLocked && other.collection == collection;

  @override
  int get hashCode => collection.hashCode;
}

/// The owner changed.
class OwnerChanged extends Event {
  const OwnerChanged({
    required this.collection,
    required this.newOwner,
  });

  factory OwnerChanged._decode(_i1.Input input) {
    return OwnerChanged(
      collection: _i1.U32Codec.codec.decode(input),
      newOwner: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::AccountId
  final _i3.AccountId32 newOwner;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'OwnerChanged': {
          'collection': collection,
          'newOwner': newOwner.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + const _i3.AccountId32Codec().sizeHint(newOwner);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      newOwner,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is OwnerChanged &&
          other.collection == collection &&
          _i7.listsEqual(
            other.newOwner,
            newOwner,
          );

  @override
  int get hashCode => Object.hash(
        collection,
        newOwner,
      );
}

/// The management team changed.
class TeamChanged extends Event {
  const TeamChanged({
    required this.collection,
    this.issuer,
    this.admin,
    this.freezer,
  });

  factory TeamChanged._decode(_i1.Input input) {
    return TeamChanged(
      collection: _i1.U32Codec.codec.decode(input),
      issuer: const _i1.OptionCodec<_i3.AccountId32>(_i3.AccountId32Codec()).decode(input),
      admin: const _i1.OptionCodec<_i3.AccountId32>(_i3.AccountId32Codec()).decode(input),
      freezer: const _i1.OptionCodec<_i3.AccountId32>(_i3.AccountId32Codec()).decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// Option<T::AccountId>
  final _i3.AccountId32? issuer;

  /// Option<T::AccountId>
  final _i3.AccountId32? admin;

  /// Option<T::AccountId>
  final _i3.AccountId32? freezer;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'TeamChanged': {
          'collection': collection,
          'issuer': issuer?.toList(),
          'admin': admin?.toList(),
          'freezer': freezer?.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + const _i1.OptionCodec<_i3.AccountId32>(_i3.AccountId32Codec()).sizeHint(issuer);
    size = size + const _i1.OptionCodec<_i3.AccountId32>(_i3.AccountId32Codec()).sizeHint(admin);
    size = size + const _i1.OptionCodec<_i3.AccountId32>(_i3.AccountId32Codec()).sizeHint(freezer);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    const _i1.OptionCodec<_i3.AccountId32>(_i3.AccountId32Codec()).encodeTo(
      issuer,
      output,
    );
    const _i1.OptionCodec<_i3.AccountId32>(_i3.AccountId32Codec()).encodeTo(
      admin,
      output,
    );
    const _i1.OptionCodec<_i3.AccountId32>(_i3.AccountId32Codec()).encodeTo(
      freezer,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is TeamChanged &&
          other.collection == collection &&
          other.issuer == issuer &&
          other.admin == admin &&
          other.freezer == freezer;

  @override
  int get hashCode => Object.hash(
        collection,
        issuer,
        admin,
        freezer,
      );
}

/// An `item` of a `collection` has been approved by the `owner` for transfer by
/// a `delegate`.
class TransferApproved extends Event {
  const TransferApproved({
    required this.collection,
    required this.item,
    required this.owner,
    required this.delegate,
    this.deadline,
  });

  factory TransferApproved._decode(_i1.Input input) {
    return TransferApproved(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      owner: const _i1.U8ArrayCodec(32).decode(input),
      delegate: const _i1.U8ArrayCodec(32).decode(input),
      deadline: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// T::AccountId
  final _i3.AccountId32 owner;

  /// T::AccountId
  final _i3.AccountId32 delegate;

  /// Option<BlockNumberFor<T, I>>
  final int? deadline;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'TransferApproved': {
          'collection': collection,
          'item': item,
          'owner': owner.toList(),
          'delegate': delegate.toList(),
          'deadline': deadline,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + const _i3.AccountId32Codec().sizeHint(owner);
    size = size + const _i3.AccountId32Codec().sizeHint(delegate);
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(deadline);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      owner,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      delegate,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      deadline,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is TransferApproved &&
          other.collection == collection &&
          other.item == item &&
          _i7.listsEqual(
            other.owner,
            owner,
          ) &&
          _i7.listsEqual(
            other.delegate,
            delegate,
          ) &&
          other.deadline == deadline;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        owner,
        delegate,
        deadline,
      );
}

/// An approval for a `delegate` account to transfer the `item` of an item
/// `collection` was cancelled by its `owner`.
class ApprovalCancelled extends Event {
  const ApprovalCancelled({
    required this.collection,
    required this.item,
    required this.owner,
    required this.delegate,
  });

  factory ApprovalCancelled._decode(_i1.Input input) {
    return ApprovalCancelled(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      owner: const _i1.U8ArrayCodec(32).decode(input),
      delegate: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// T::AccountId
  final _i3.AccountId32 owner;

  /// T::AccountId
  final _i3.AccountId32 delegate;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ApprovalCancelled': {
          'collection': collection,
          'item': item,
          'owner': owner.toList(),
          'delegate': delegate.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + const _i3.AccountId32Codec().sizeHint(owner);
    size = size + const _i3.AccountId32Codec().sizeHint(delegate);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      owner,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      delegate,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ApprovalCancelled &&
          other.collection == collection &&
          other.item == item &&
          _i7.listsEqual(
            other.owner,
            owner,
          ) &&
          _i7.listsEqual(
            other.delegate,
            delegate,
          );

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        owner,
        delegate,
      );
}

/// All approvals of an item got cancelled.
class AllApprovalsCancelled extends Event {
  const AllApprovalsCancelled({
    required this.collection,
    required this.item,
    required this.owner,
  });

  factory AllApprovalsCancelled._decode(_i1.Input input) {
    return AllApprovalsCancelled(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      owner: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// T::AccountId
  final _i3.AccountId32 owner;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'AllApprovalsCancelled': {
          'collection': collection,
          'item': item,
          'owner': owner.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + const _i3.AccountId32Codec().sizeHint(owner);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      14,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      owner,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AllApprovalsCancelled &&
          other.collection == collection &&
          other.item == item &&
          _i7.listsEqual(
            other.owner,
            owner,
          );

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        owner,
      );
}

/// A `collection` has had its config changed by the `Force` origin.
class CollectionConfigChanged extends Event {
  const CollectionConfigChanged({required this.collection});

  factory CollectionConfigChanged._decode(_i1.Input input) {
    return CollectionConfigChanged(collection: _i1.U32Codec.codec.decode(input));
  }

  /// T::CollectionId
  final int collection;

  @override
  Map<String, Map<String, int>> toJson() => {
        'CollectionConfigChanged': {'collection': collection}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      15,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CollectionConfigChanged && other.collection == collection;

  @override
  int get hashCode => collection.hashCode;
}

/// New metadata has been set for a `collection`.
class CollectionMetadataSet extends Event {
  const CollectionMetadataSet({
    required this.collection,
    required this.data,
  });

  factory CollectionMetadataSet._decode(_i1.Input input) {
    return CollectionMetadataSet(
      collection: _i1.U32Codec.codec.decode(input),
      data: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// BoundedVec<u8, T::StringLimit>
  final List<int> data;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'CollectionMetadataSet': {
          'collection': collection,
          'data': data,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(data);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      16,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      data,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CollectionMetadataSet &&
          other.collection == collection &&
          _i7.listsEqual(
            other.data,
            data,
          );

  @override
  int get hashCode => Object.hash(
        collection,
        data,
      );
}

/// Metadata has been cleared for a `collection`.
class CollectionMetadataCleared extends Event {
  const CollectionMetadataCleared({required this.collection});

  factory CollectionMetadataCleared._decode(_i1.Input input) {
    return CollectionMetadataCleared(collection: _i1.U32Codec.codec.decode(input));
  }

  /// T::CollectionId
  final int collection;

  @override
  Map<String, Map<String, int>> toJson() => {
        'CollectionMetadataCleared': {'collection': collection}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      17,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CollectionMetadataCleared && other.collection == collection;

  @override
  int get hashCode => collection.hashCode;
}

/// New metadata has been set for an item.
class ItemMetadataSet extends Event {
  const ItemMetadataSet({
    required this.collection,
    required this.item,
    required this.data,
  });

  factory ItemMetadataSet._decode(_i1.Input input) {
    return ItemMetadataSet(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      data: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// BoundedVec<u8, T::StringLimit>
  final List<int> data;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ItemMetadataSet': {
          'collection': collection,
          'item': item,
          'data': data,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(data);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      18,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      data,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ItemMetadataSet &&
          other.collection == collection &&
          other.item == item &&
          _i7.listsEqual(
            other.data,
            data,
          );

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        data,
      );
}

/// Metadata has been cleared for an item.
class ItemMetadataCleared extends Event {
  const ItemMetadataCleared({
    required this.collection,
    required this.item,
  });

  factory ItemMetadataCleared._decode(_i1.Input input) {
    return ItemMetadataCleared(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  @override
  Map<String, Map<String, int>> toJson() => {
        'ItemMetadataCleared': {
          'collection': collection,
          'item': item,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      19,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ItemMetadataCleared && other.collection == collection && other.item == item;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
      );
}

/// The deposit for a set of `item`s within a `collection` has been updated.
class Redeposited extends Event {
  const Redeposited({
    required this.collection,
    required this.successfulItems,
  });

  factory Redeposited._decode(_i1.Input input) {
    return Redeposited(
      collection: _i1.U32Codec.codec.decode(input),
      successfulItems: _i1.U32SequenceCodec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// Vec<T::ItemId>
  final List<int> successfulItems;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Redeposited': {
          'collection': collection,
          'successfulItems': successfulItems,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32SequenceCodec.codec.sizeHint(successfulItems);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      20,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32SequenceCodec.codec.encodeTo(
      successfulItems,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Redeposited &&
          other.collection == collection &&
          _i7.listsEqual(
            other.successfulItems,
            successfulItems,
          );

  @override
  int get hashCode => Object.hash(
        collection,
        successfulItems,
      );
}

/// New attribute metadata has been set for a `collection` or `item`.
class AttributeSet extends Event {
  const AttributeSet({
    required this.collection,
    this.maybeItem,
    required this.key,
    required this.value,
    required this.namespace,
  });

  factory AttributeSet._decode(_i1.Input input) {
    return AttributeSet(
      collection: _i1.U32Codec.codec.decode(input),
      maybeItem: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      key: _i1.U8SequenceCodec.codec.decode(input),
      value: _i1.U8SequenceCodec.codec.decode(input),
      namespace: _i4.AttributeNamespace.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// Option<T::ItemId>
  final int? maybeItem;

  /// BoundedVec<u8, T::KeyLimit>
  final List<int> key;

  /// BoundedVec<u8, T::ValueLimit>
  final List<int> value;

  /// AttributeNamespace<T::AccountId>
  final _i4.AttributeNamespace namespace;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'AttributeSet': {
          'collection': collection,
          'maybeItem': maybeItem,
          'key': key,
          'value': value,
          'namespace': namespace.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(maybeItem);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(key);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(value);
    size = size + _i4.AttributeNamespace.codec.sizeHint(namespace);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      21,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      maybeItem,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      key,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      value,
      output,
    );
    _i4.AttributeNamespace.codec.encodeTo(
      namespace,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AttributeSet &&
          other.collection == collection &&
          other.maybeItem == maybeItem &&
          _i7.listsEqual(
            other.key,
            key,
          ) &&
          _i7.listsEqual(
            other.value,
            value,
          ) &&
          other.namespace == namespace;

  @override
  int get hashCode => Object.hash(
        collection,
        maybeItem,
        key,
        value,
        namespace,
      );
}

/// Attribute metadata has been cleared for a `collection` or `item`.
class AttributeCleared extends Event {
  const AttributeCleared({
    required this.collection,
    this.maybeItem,
    required this.key,
    required this.namespace,
  });

  factory AttributeCleared._decode(_i1.Input input) {
    return AttributeCleared(
      collection: _i1.U32Codec.codec.decode(input),
      maybeItem: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      key: _i1.U8SequenceCodec.codec.decode(input),
      namespace: _i4.AttributeNamespace.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// Option<T::ItemId>
  final int? maybeItem;

  /// BoundedVec<u8, T::KeyLimit>
  final List<int> key;

  /// AttributeNamespace<T::AccountId>
  final _i4.AttributeNamespace namespace;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'AttributeCleared': {
          'collection': collection,
          'maybeItem': maybeItem,
          'key': key,
          'namespace': namespace.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(maybeItem);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(key);
    size = size + _i4.AttributeNamespace.codec.sizeHint(namespace);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      22,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      maybeItem,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      key,
      output,
    );
    _i4.AttributeNamespace.codec.encodeTo(
      namespace,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AttributeCleared &&
          other.collection == collection &&
          other.maybeItem == maybeItem &&
          _i7.listsEqual(
            other.key,
            key,
          ) &&
          other.namespace == namespace;

  @override
  int get hashCode => Object.hash(
        collection,
        maybeItem,
        key,
        namespace,
      );
}

/// A new approval to modify item attributes was added.
class ItemAttributesApprovalAdded extends Event {
  const ItemAttributesApprovalAdded({
    required this.collection,
    required this.item,
    required this.delegate,
  });

  factory ItemAttributesApprovalAdded._decode(_i1.Input input) {
    return ItemAttributesApprovalAdded(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      delegate: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// T::AccountId
  final _i3.AccountId32 delegate;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ItemAttributesApprovalAdded': {
          'collection': collection,
          'item': item,
          'delegate': delegate.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + const _i3.AccountId32Codec().sizeHint(delegate);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      23,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      delegate,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ItemAttributesApprovalAdded &&
          other.collection == collection &&
          other.item == item &&
          _i7.listsEqual(
            other.delegate,
            delegate,
          );

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        delegate,
      );
}

/// A new approval to modify item attributes was removed.
class ItemAttributesApprovalRemoved extends Event {
  const ItemAttributesApprovalRemoved({
    required this.collection,
    required this.item,
    required this.delegate,
  });

  factory ItemAttributesApprovalRemoved._decode(_i1.Input input) {
    return ItemAttributesApprovalRemoved(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      delegate: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// T::AccountId
  final _i3.AccountId32 delegate;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ItemAttributesApprovalRemoved': {
          'collection': collection,
          'item': item,
          'delegate': delegate.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + const _i3.AccountId32Codec().sizeHint(delegate);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      24,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      delegate,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ItemAttributesApprovalRemoved &&
          other.collection == collection &&
          other.item == item &&
          _i7.listsEqual(
            other.delegate,
            delegate,
          );

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        delegate,
      );
}

/// Ownership acceptance has changed for an account.
class OwnershipAcceptanceChanged extends Event {
  const OwnershipAcceptanceChanged({
    required this.who,
    this.maybeCollection,
  });

  factory OwnershipAcceptanceChanged._decode(_i1.Input input) {
    return OwnershipAcceptanceChanged(
      who: const _i1.U8ArrayCodec(32).decode(input),
      maybeCollection: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 who;

  /// Option<T::CollectionId>
  final int? maybeCollection;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'OwnershipAcceptanceChanged': {
          'who': who.toList(),
          'maybeCollection': maybeCollection,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(who);
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(maybeCollection);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      25,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      maybeCollection,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is OwnershipAcceptanceChanged &&
          _i7.listsEqual(
            other.who,
            who,
          ) &&
          other.maybeCollection == maybeCollection;

  @override
  int get hashCode => Object.hash(
        who,
        maybeCollection,
      );
}

/// Max supply has been set for a collection.
class CollectionMaxSupplySet extends Event {
  const CollectionMaxSupplySet({
    required this.collection,
    required this.maxSupply,
  });

  factory CollectionMaxSupplySet._decode(_i1.Input input) {
    return CollectionMaxSupplySet(
      collection: _i1.U32Codec.codec.decode(input),
      maxSupply: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// u32
  final int maxSupply;

  @override
  Map<String, Map<String, int>> toJson() => {
        'CollectionMaxSupplySet': {
          'collection': collection,
          'maxSupply': maxSupply,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(maxSupply);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      26,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      maxSupply,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CollectionMaxSupplySet && other.collection == collection && other.maxSupply == maxSupply;

  @override
  int get hashCode => Object.hash(
        collection,
        maxSupply,
      );
}

/// Mint settings for a collection had changed.
class CollectionMintSettingsUpdated extends Event {
  const CollectionMintSettingsUpdated({required this.collection});

  factory CollectionMintSettingsUpdated._decode(_i1.Input input) {
    return CollectionMintSettingsUpdated(collection: _i1.U32Codec.codec.decode(input));
  }

  /// T::CollectionId
  final int collection;

  @override
  Map<String, Map<String, int>> toJson() => {
        'CollectionMintSettingsUpdated': {'collection': collection}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      27,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CollectionMintSettingsUpdated && other.collection == collection;

  @override
  int get hashCode => collection.hashCode;
}

/// Event gets emitted when the `NextCollectionId` gets incremented.
class NextCollectionIdIncremented extends Event {
  const NextCollectionIdIncremented({this.nextId});

  factory NextCollectionIdIncremented._decode(_i1.Input input) {
    return NextCollectionIdIncremented(nextId: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input));
  }

  /// Option<T::CollectionId>
  final int? nextId;

  @override
  Map<String, Map<String, int?>> toJson() => {
        'NextCollectionIdIncremented': {'nextId': nextId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(nextId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      28,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      nextId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is NextCollectionIdIncremented && other.nextId == nextId;

  @override
  int get hashCode => nextId.hashCode;
}

/// The price was set for the item.
class ItemPriceSet extends Event {
  const ItemPriceSet({
    required this.collection,
    required this.item,
    required this.price,
    this.whitelistedBuyer,
  });

  factory ItemPriceSet._decode(_i1.Input input) {
    return ItemPriceSet(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      price: _i1.U128Codec.codec.decode(input),
      whitelistedBuyer: const _i1.OptionCodec<_i3.AccountId32>(_i3.AccountId32Codec()).decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// ItemPrice<T, I>
  final BigInt price;

  /// Option<T::AccountId>
  final _i3.AccountId32? whitelistedBuyer;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ItemPriceSet': {
          'collection': collection,
          'item': item,
          'price': price,
          'whitelistedBuyer': whitelistedBuyer?.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + _i1.U128Codec.codec.sizeHint(price);
    size = size + const _i1.OptionCodec<_i3.AccountId32>(_i3.AccountId32Codec()).sizeHint(whitelistedBuyer);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      29,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      price,
      output,
    );
    const _i1.OptionCodec<_i3.AccountId32>(_i3.AccountId32Codec()).encodeTo(
      whitelistedBuyer,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ItemPriceSet &&
          other.collection == collection &&
          other.item == item &&
          other.price == price &&
          other.whitelistedBuyer == whitelistedBuyer;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        price,
        whitelistedBuyer,
      );
}

/// The price for the item was removed.
class ItemPriceRemoved extends Event {
  const ItemPriceRemoved({
    required this.collection,
    required this.item,
  });

  factory ItemPriceRemoved._decode(_i1.Input input) {
    return ItemPriceRemoved(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  @override
  Map<String, Map<String, int>> toJson() => {
        'ItemPriceRemoved': {
          'collection': collection,
          'item': item,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      30,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ItemPriceRemoved && other.collection == collection && other.item == item;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
      );
}

/// An item was bought.
class ItemBought extends Event {
  const ItemBought({
    required this.collection,
    required this.item,
    required this.price,
    required this.seller,
    required this.buyer,
  });

  factory ItemBought._decode(_i1.Input input) {
    return ItemBought(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      price: _i1.U128Codec.codec.decode(input),
      seller: const _i1.U8ArrayCodec(32).decode(input),
      buyer: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// ItemPrice<T, I>
  final BigInt price;

  /// T::AccountId
  final _i3.AccountId32 seller;

  /// T::AccountId
  final _i3.AccountId32 buyer;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ItemBought': {
          'collection': collection,
          'item': item,
          'price': price,
          'seller': seller.toList(),
          'buyer': buyer.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + _i1.U128Codec.codec.sizeHint(price);
    size = size + const _i3.AccountId32Codec().sizeHint(seller);
    size = size + const _i3.AccountId32Codec().sizeHint(buyer);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      31,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      price,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      seller,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      buyer,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ItemBought &&
          other.collection == collection &&
          other.item == item &&
          other.price == price &&
          _i7.listsEqual(
            other.seller,
            seller,
          ) &&
          _i7.listsEqual(
            other.buyer,
            buyer,
          );

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        price,
        seller,
        buyer,
      );
}

/// A tip was sent.
class TipSent extends Event {
  const TipSent({
    required this.collection,
    required this.item,
    required this.sender,
    required this.receiver,
    required this.amount,
  });

  factory TipSent._decode(_i1.Input input) {
    return TipSent(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      sender: const _i1.U8ArrayCodec(32).decode(input),
      receiver: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// T::AccountId
  final _i3.AccountId32 sender;

  /// T::AccountId
  final _i3.AccountId32 receiver;

  /// DepositBalanceOf<T, I>
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'TipSent': {
          'collection': collection,
          'item': item,
          'sender': sender.toList(),
          'receiver': receiver.toList(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + const _i3.AccountId32Codec().sizeHint(sender);
    size = size + const _i3.AccountId32Codec().sizeHint(receiver);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      32,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      sender,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      receiver,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is TipSent &&
          other.collection == collection &&
          other.item == item &&
          _i7.listsEqual(
            other.sender,
            sender,
          ) &&
          _i7.listsEqual(
            other.receiver,
            receiver,
          ) &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        sender,
        receiver,
        amount,
      );
}

/// An `item` swap intent was created.
class SwapCreated extends Event {
  const SwapCreated({
    required this.offeredCollection,
    required this.offeredItem,
    required this.desiredCollection,
    this.desiredItem,
    this.price,
    required this.deadline,
  });

  factory SwapCreated._decode(_i1.Input input) {
    return SwapCreated(
      offeredCollection: _i1.U32Codec.codec.decode(input),
      offeredItem: _i1.U32Codec.codec.decode(input),
      desiredCollection: _i1.U32Codec.codec.decode(input),
      desiredItem: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      price: const _i1.OptionCodec<_i5.PriceWithDirection>(_i5.PriceWithDirection.codec).decode(input),
      deadline: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int offeredCollection;

  /// T::ItemId
  final int offeredItem;

  /// T::CollectionId
  final int desiredCollection;

  /// Option<T::ItemId>
  final int? desiredItem;

  /// Option<PriceWithDirection<ItemPrice<T, I>>>
  final _i5.PriceWithDirection? price;

  /// BlockNumberFor<T, I>
  final int deadline;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'SwapCreated': {
          'offeredCollection': offeredCollection,
          'offeredItem': offeredItem,
          'desiredCollection': desiredCollection,
          'desiredItem': desiredItem,
          'price': price?.toJson(),
          'deadline': deadline,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(offeredCollection);
    size = size + _i1.U32Codec.codec.sizeHint(offeredItem);
    size = size + _i1.U32Codec.codec.sizeHint(desiredCollection);
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(desiredItem);
    size = size + const _i1.OptionCodec<_i5.PriceWithDirection>(_i5.PriceWithDirection.codec).sizeHint(price);
    size = size + _i1.U32Codec.codec.sizeHint(deadline);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      33,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      offeredCollection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      offeredItem,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      desiredCollection,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      desiredItem,
      output,
    );
    const _i1.OptionCodec<_i5.PriceWithDirection>(_i5.PriceWithDirection.codec).encodeTo(
      price,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      deadline,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SwapCreated &&
          other.offeredCollection == offeredCollection &&
          other.offeredItem == offeredItem &&
          other.desiredCollection == desiredCollection &&
          other.desiredItem == desiredItem &&
          other.price == price &&
          other.deadline == deadline;

  @override
  int get hashCode => Object.hash(
        offeredCollection,
        offeredItem,
        desiredCollection,
        desiredItem,
        price,
        deadline,
      );
}

/// The swap was cancelled.
class SwapCancelled extends Event {
  const SwapCancelled({
    required this.offeredCollection,
    required this.offeredItem,
    required this.desiredCollection,
    this.desiredItem,
    this.price,
    required this.deadline,
  });

  factory SwapCancelled._decode(_i1.Input input) {
    return SwapCancelled(
      offeredCollection: _i1.U32Codec.codec.decode(input),
      offeredItem: _i1.U32Codec.codec.decode(input),
      desiredCollection: _i1.U32Codec.codec.decode(input),
      desiredItem: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      price: const _i1.OptionCodec<_i5.PriceWithDirection>(_i5.PriceWithDirection.codec).decode(input),
      deadline: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int offeredCollection;

  /// T::ItemId
  final int offeredItem;

  /// T::CollectionId
  final int desiredCollection;

  /// Option<T::ItemId>
  final int? desiredItem;

  /// Option<PriceWithDirection<ItemPrice<T, I>>>
  final _i5.PriceWithDirection? price;

  /// BlockNumberFor<T, I>
  final int deadline;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'SwapCancelled': {
          'offeredCollection': offeredCollection,
          'offeredItem': offeredItem,
          'desiredCollection': desiredCollection,
          'desiredItem': desiredItem,
          'price': price?.toJson(),
          'deadline': deadline,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(offeredCollection);
    size = size + _i1.U32Codec.codec.sizeHint(offeredItem);
    size = size + _i1.U32Codec.codec.sizeHint(desiredCollection);
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(desiredItem);
    size = size + const _i1.OptionCodec<_i5.PriceWithDirection>(_i5.PriceWithDirection.codec).sizeHint(price);
    size = size + _i1.U32Codec.codec.sizeHint(deadline);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      34,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      offeredCollection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      offeredItem,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      desiredCollection,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      desiredItem,
      output,
    );
    const _i1.OptionCodec<_i5.PriceWithDirection>(_i5.PriceWithDirection.codec).encodeTo(
      price,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      deadline,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SwapCancelled &&
          other.offeredCollection == offeredCollection &&
          other.offeredItem == offeredItem &&
          other.desiredCollection == desiredCollection &&
          other.desiredItem == desiredItem &&
          other.price == price &&
          other.deadline == deadline;

  @override
  int get hashCode => Object.hash(
        offeredCollection,
        offeredItem,
        desiredCollection,
        desiredItem,
        price,
        deadline,
      );
}

/// The swap has been claimed.
class SwapClaimed extends Event {
  const SwapClaimed({
    required this.sentCollection,
    required this.sentItem,
    required this.sentItemOwner,
    required this.receivedCollection,
    required this.receivedItem,
    required this.receivedItemOwner,
    this.price,
    required this.deadline,
  });

  factory SwapClaimed._decode(_i1.Input input) {
    return SwapClaimed(
      sentCollection: _i1.U32Codec.codec.decode(input),
      sentItem: _i1.U32Codec.codec.decode(input),
      sentItemOwner: const _i1.U8ArrayCodec(32).decode(input),
      receivedCollection: _i1.U32Codec.codec.decode(input),
      receivedItem: _i1.U32Codec.codec.decode(input),
      receivedItemOwner: const _i1.U8ArrayCodec(32).decode(input),
      price: const _i1.OptionCodec<_i5.PriceWithDirection>(_i5.PriceWithDirection.codec).decode(input),
      deadline: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int sentCollection;

  /// T::ItemId
  final int sentItem;

  /// T::AccountId
  final _i3.AccountId32 sentItemOwner;

  /// T::CollectionId
  final int receivedCollection;

  /// T::ItemId
  final int receivedItem;

  /// T::AccountId
  final _i3.AccountId32 receivedItemOwner;

  /// Option<PriceWithDirection<ItemPrice<T, I>>>
  final _i5.PriceWithDirection? price;

  /// BlockNumberFor<T, I>
  final int deadline;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'SwapClaimed': {
          'sentCollection': sentCollection,
          'sentItem': sentItem,
          'sentItemOwner': sentItemOwner.toList(),
          'receivedCollection': receivedCollection,
          'receivedItem': receivedItem,
          'receivedItemOwner': receivedItemOwner.toList(),
          'price': price?.toJson(),
          'deadline': deadline,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(sentCollection);
    size = size + _i1.U32Codec.codec.sizeHint(sentItem);
    size = size + const _i3.AccountId32Codec().sizeHint(sentItemOwner);
    size = size + _i1.U32Codec.codec.sizeHint(receivedCollection);
    size = size + _i1.U32Codec.codec.sizeHint(receivedItem);
    size = size + const _i3.AccountId32Codec().sizeHint(receivedItemOwner);
    size = size + const _i1.OptionCodec<_i5.PriceWithDirection>(_i5.PriceWithDirection.codec).sizeHint(price);
    size = size + _i1.U32Codec.codec.sizeHint(deadline);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      35,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      sentCollection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      sentItem,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      sentItemOwner,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      receivedCollection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      receivedItem,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      receivedItemOwner,
      output,
    );
    const _i1.OptionCodec<_i5.PriceWithDirection>(_i5.PriceWithDirection.codec).encodeTo(
      price,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      deadline,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SwapClaimed &&
          other.sentCollection == sentCollection &&
          other.sentItem == sentItem &&
          _i7.listsEqual(
            other.sentItemOwner,
            sentItemOwner,
          ) &&
          other.receivedCollection == receivedCollection &&
          other.receivedItem == receivedItem &&
          _i7.listsEqual(
            other.receivedItemOwner,
            receivedItemOwner,
          ) &&
          other.price == price &&
          other.deadline == deadline;

  @override
  int get hashCode => Object.hash(
        sentCollection,
        sentItem,
        sentItemOwner,
        receivedCollection,
        receivedItem,
        receivedItemOwner,
        price,
        deadline,
      );
}

/// New attributes have been set for an `item` of the `collection`.
class PreSignedAttributesSet extends Event {
  const PreSignedAttributesSet({
    required this.collection,
    required this.item,
    required this.namespace,
  });

  factory PreSignedAttributesSet._decode(_i1.Input input) {
    return PreSignedAttributesSet(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      namespace: _i4.AttributeNamespace.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// AttributeNamespace<T::AccountId>
  final _i4.AttributeNamespace namespace;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'PreSignedAttributesSet': {
          'collection': collection,
          'item': item,
          'namespace': namespace.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + _i4.AttributeNamespace.codec.sizeHint(namespace);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      36,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
    _i4.AttributeNamespace.codec.encodeTo(
      namespace,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PreSignedAttributesSet &&
          other.collection == collection &&
          other.item == item &&
          other.namespace == namespace;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        namespace,
      );
}

/// A new attribute in the `Pallet` namespace was set for the `collection` or an `item`
/// within that `collection`.
class PalletAttributeSet extends Event {
  const PalletAttributeSet({
    required this.collection,
    this.item,
    required this.attribute,
    required this.value,
  });

  factory PalletAttributeSet._decode(_i1.Input input) {
    return PalletAttributeSet(
      collection: _i1.U32Codec.codec.decode(input),
      item: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      attribute: _i6.PalletAttributes.codec.decode(input),
      value: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// Option<T::ItemId>
  final int? item;

  /// PalletAttributes<T::CollectionId>
  final _i6.PalletAttributes attribute;

  /// BoundedVec<u8, T::ValueLimit>
  final List<int> value;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'PalletAttributeSet': {
          'collection': collection,
          'item': item,
          'attribute': attribute.toJson(),
          'value': value,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(item);
    size = size + _i6.PalletAttributes.codec.sizeHint(attribute);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(value);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      37,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      item,
      output,
    );
    _i6.PalletAttributes.codec.encodeTo(
      attribute,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PalletAttributeSet &&
          other.collection == collection &&
          other.item == item &&
          other.attribute == attribute &&
          _i7.listsEqual(
            other.value,
            value,
          );

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        attribute,
        value,
      );
}
