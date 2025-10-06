// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../sp_core/crypto/account_id32.dart' as _i3;

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

  Frozen frozen({
    required int collection,
    required int item,
  }) {
    return Frozen(
      collection: collection,
      item: item,
    );
  }

  Thawed thawed({
    required int collection,
    required int item,
  }) {
    return Thawed(
      collection: collection,
      item: item,
    );
  }

  CollectionFrozen collectionFrozen({required int collection}) {
    return CollectionFrozen(collection: collection);
  }

  CollectionThawed collectionThawed({required int collection}) {
    return CollectionThawed(collection: collection);
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
    required _i3.AccountId32 issuer,
    required _i3.AccountId32 admin,
    required _i3.AccountId32 freezer,
  }) {
    return TeamChanged(
      collection: collection,
      issuer: issuer,
      admin: admin,
      freezer: freezer,
    );
  }

  ApprovedTransfer approvedTransfer({
    required int collection,
    required int item,
    required _i3.AccountId32 owner,
    required _i3.AccountId32 delegate,
  }) {
    return ApprovedTransfer(
      collection: collection,
      item: item,
      owner: owner,
      delegate: delegate,
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

  ItemStatusChanged itemStatusChanged({required int collection}) {
    return ItemStatusChanged(collection: collection);
  }

  CollectionMetadataSet collectionMetadataSet({
    required int collection,
    required List<int> data,
    required bool isFrozen,
  }) {
    return CollectionMetadataSet(
      collection: collection,
      data: data,
      isFrozen: isFrozen,
    );
  }

  CollectionMetadataCleared collectionMetadataCleared({required int collection}) {
    return CollectionMetadataCleared(collection: collection);
  }

  MetadataSet metadataSet({
    required int collection,
    required int item,
    required List<int> data,
    required bool isFrozen,
  }) {
    return MetadataSet(
      collection: collection,
      item: item,
      data: data,
      isFrozen: isFrozen,
    );
  }

  MetadataCleared metadataCleared({
    required int collection,
    required int item,
  }) {
    return MetadataCleared(
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
  }) {
    return AttributeSet(
      collection: collection,
      maybeItem: maybeItem,
      key: key,
      value: value,
    );
  }

  AttributeCleared attributeCleared({
    required int collection,
    int? maybeItem,
    required List<int> key,
  }) {
    return AttributeCleared(
      collection: collection,
      maybeItem: maybeItem,
      key: key,
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
        return Frozen._decode(input);
      case 7:
        return Thawed._decode(input);
      case 8:
        return CollectionFrozen._decode(input);
      case 9:
        return CollectionThawed._decode(input);
      case 10:
        return OwnerChanged._decode(input);
      case 11:
        return TeamChanged._decode(input);
      case 12:
        return ApprovedTransfer._decode(input);
      case 13:
        return ApprovalCancelled._decode(input);
      case 14:
        return ItemStatusChanged._decode(input);
      case 15:
        return CollectionMetadataSet._decode(input);
      case 16:
        return CollectionMetadataCleared._decode(input);
      case 17:
        return MetadataSet._decode(input);
      case 18:
        return MetadataCleared._decode(input);
      case 19:
        return Redeposited._decode(input);
      case 20:
        return AttributeSet._decode(input);
      case 21:
        return AttributeCleared._decode(input);
      case 22:
        return OwnershipAcceptanceChanged._decode(input);
      case 23:
        return CollectionMaxSupplySet._decode(input);
      case 24:
        return ItemPriceSet._decode(input);
      case 25:
        return ItemPriceRemoved._decode(input);
      case 26:
        return ItemBought._decode(input);
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
      case Frozen:
        (value as Frozen).encodeTo(output);
        break;
      case Thawed:
        (value as Thawed).encodeTo(output);
        break;
      case CollectionFrozen:
        (value as CollectionFrozen).encodeTo(output);
        break;
      case CollectionThawed:
        (value as CollectionThawed).encodeTo(output);
        break;
      case OwnerChanged:
        (value as OwnerChanged).encodeTo(output);
        break;
      case TeamChanged:
        (value as TeamChanged).encodeTo(output);
        break;
      case ApprovedTransfer:
        (value as ApprovedTransfer).encodeTo(output);
        break;
      case ApprovalCancelled:
        (value as ApprovalCancelled).encodeTo(output);
        break;
      case ItemStatusChanged:
        (value as ItemStatusChanged).encodeTo(output);
        break;
      case CollectionMetadataSet:
        (value as CollectionMetadataSet).encodeTo(output);
        break;
      case CollectionMetadataCleared:
        (value as CollectionMetadataCleared).encodeTo(output);
        break;
      case MetadataSet:
        (value as MetadataSet).encodeTo(output);
        break;
      case MetadataCleared:
        (value as MetadataCleared).encodeTo(output);
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
      case OwnershipAcceptanceChanged:
        (value as OwnershipAcceptanceChanged).encodeTo(output);
        break;
      case CollectionMaxSupplySet:
        (value as CollectionMaxSupplySet).encodeTo(output);
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
      case Frozen:
        return (value as Frozen)._sizeHint();
      case Thawed:
        return (value as Thawed)._sizeHint();
      case CollectionFrozen:
        return (value as CollectionFrozen)._sizeHint();
      case CollectionThawed:
        return (value as CollectionThawed)._sizeHint();
      case OwnerChanged:
        return (value as OwnerChanged)._sizeHint();
      case TeamChanged:
        return (value as TeamChanged)._sizeHint();
      case ApprovedTransfer:
        return (value as ApprovedTransfer)._sizeHint();
      case ApprovalCancelled:
        return (value as ApprovalCancelled)._sizeHint();
      case ItemStatusChanged:
        return (value as ItemStatusChanged)._sizeHint();
      case CollectionMetadataSet:
        return (value as CollectionMetadataSet)._sizeHint();
      case CollectionMetadataCleared:
        return (value as CollectionMetadataCleared)._sizeHint();
      case MetadataSet:
        return (value as MetadataSet)._sizeHint();
      case MetadataCleared:
        return (value as MetadataCleared)._sizeHint();
      case Redeposited:
        return (value as Redeposited)._sizeHint();
      case AttributeSet:
        return (value as AttributeSet)._sizeHint();
      case AttributeCleared:
        return (value as AttributeCleared)._sizeHint();
      case OwnershipAcceptanceChanged:
        return (value as OwnershipAcceptanceChanged)._sizeHint();
      case CollectionMaxSupplySet:
        return (value as CollectionMaxSupplySet)._sizeHint();
      case ItemPriceSet:
        return (value as ItemPriceSet)._sizeHint();
      case ItemPriceRemoved:
        return (value as ItemPriceRemoved)._sizeHint();
      case ItemBought:
        return (value as ItemBought)._sizeHint();
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
          _i4.listsEqual(
            other.creator,
            creator,
          ) &&
          _i4.listsEqual(
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
          _i4.listsEqual(
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
          _i4.listsEqual(
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
          _i4.listsEqual(
            other.from,
            from,
          ) &&
          _i4.listsEqual(
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
          _i4.listsEqual(
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

/// Some `item` was frozen.
class Frozen extends Event {
  const Frozen({
    required this.collection,
    required this.item,
  });

  factory Frozen._decode(_i1.Input input) {
    return Frozen(
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
        'Frozen': {
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
      other is Frozen && other.collection == collection && other.item == item;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
      );
}

/// Some `item` was thawed.
class Thawed extends Event {
  const Thawed({
    required this.collection,
    required this.item,
  });

  factory Thawed._decode(_i1.Input input) {
    return Thawed(
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
        'Thawed': {
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
      other is Thawed && other.collection == collection && other.item == item;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
      );
}

/// Some `collection` was frozen.
class CollectionFrozen extends Event {
  const CollectionFrozen({required this.collection});

  factory CollectionFrozen._decode(_i1.Input input) {
    return CollectionFrozen(collection: _i1.U32Codec.codec.decode(input));
  }

  /// T::CollectionId
  final int collection;

  @override
  Map<String, Map<String, int>> toJson() => {
        'CollectionFrozen': {'collection': collection}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
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
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CollectionFrozen && other.collection == collection;

  @override
  int get hashCode => collection.hashCode;
}

/// Some `collection` was thawed.
class CollectionThawed extends Event {
  const CollectionThawed({required this.collection});

  factory CollectionThawed._decode(_i1.Input input) {
    return CollectionThawed(collection: _i1.U32Codec.codec.decode(input));
  }

  /// T::CollectionId
  final int collection;

  @override
  Map<String, Map<String, int>> toJson() => {
        'CollectionThawed': {'collection': collection}
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
      other is CollectionThawed && other.collection == collection;

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
          _i4.listsEqual(
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
    required this.issuer,
    required this.admin,
    required this.freezer,
  });

  factory TeamChanged._decode(_i1.Input input) {
    return TeamChanged(
      collection: _i1.U32Codec.codec.decode(input),
      issuer: const _i1.U8ArrayCodec(32).decode(input),
      admin: const _i1.U8ArrayCodec(32).decode(input),
      freezer: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::AccountId
  final _i3.AccountId32 issuer;

  /// T::AccountId
  final _i3.AccountId32 admin;

  /// T::AccountId
  final _i3.AccountId32 freezer;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'TeamChanged': {
          'collection': collection,
          'issuer': issuer.toList(),
          'admin': admin.toList(),
          'freezer': freezer.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + const _i3.AccountId32Codec().sizeHint(issuer);
    size = size + const _i3.AccountId32Codec().sizeHint(admin);
    size = size + const _i3.AccountId32Codec().sizeHint(freezer);
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
    const _i1.U8ArrayCodec(32).encodeTo(
      issuer,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      admin,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
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
          _i4.listsEqual(
            other.issuer,
            issuer,
          ) &&
          _i4.listsEqual(
            other.admin,
            admin,
          ) &&
          _i4.listsEqual(
            other.freezer,
            freezer,
          );

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
class ApprovedTransfer extends Event {
  const ApprovedTransfer({
    required this.collection,
    required this.item,
    required this.owner,
    required this.delegate,
  });

  factory ApprovedTransfer._decode(_i1.Input input) {
    return ApprovedTransfer(
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
        'ApprovedTransfer': {
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
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ApprovedTransfer &&
          other.collection == collection &&
          other.item == item &&
          _i4.listsEqual(
            other.owner,
            owner,
          ) &&
          _i4.listsEqual(
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
          _i4.listsEqual(
            other.owner,
            owner,
          ) &&
          _i4.listsEqual(
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

/// A `collection` has had its attributes changed by the `Force` origin.
class ItemStatusChanged extends Event {
  const ItemStatusChanged({required this.collection});

  factory ItemStatusChanged._decode(_i1.Input input) {
    return ItemStatusChanged(collection: _i1.U32Codec.codec.decode(input));
  }

  /// T::CollectionId
  final int collection;

  @override
  Map<String, Map<String, int>> toJson() => {
        'ItemStatusChanged': {'collection': collection}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
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
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ItemStatusChanged && other.collection == collection;

  @override
  int get hashCode => collection.hashCode;
}

/// New metadata has been set for a `collection`.
class CollectionMetadataSet extends Event {
  const CollectionMetadataSet({
    required this.collection,
    required this.data,
    required this.isFrozen,
  });

  factory CollectionMetadataSet._decode(_i1.Input input) {
    return CollectionMetadataSet(
      collection: _i1.U32Codec.codec.decode(input),
      data: _i1.U8SequenceCodec.codec.decode(input),
      isFrozen: _i1.BoolCodec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// BoundedVec<u8, T::StringLimit>
  final List<int> data;

  /// bool
  final bool isFrozen;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'CollectionMetadataSet': {
          'collection': collection,
          'data': data,
          'isFrozen': isFrozen,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(data);
    size = size + _i1.BoolCodec.codec.sizeHint(isFrozen);
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
    _i1.U8SequenceCodec.codec.encodeTo(
      data,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      isFrozen,
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
          _i4.listsEqual(
            other.data,
            data,
          ) &&
          other.isFrozen == isFrozen;

  @override
  int get hashCode => Object.hash(
        collection,
        data,
        isFrozen,
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
      16,
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
class MetadataSet extends Event {
  const MetadataSet({
    required this.collection,
    required this.item,
    required this.data,
    required this.isFrozen,
  });

  factory MetadataSet._decode(_i1.Input input) {
    return MetadataSet(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      data: _i1.U8SequenceCodec.codec.decode(input),
      isFrozen: _i1.BoolCodec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// BoundedVec<u8, T::StringLimit>
  final List<int> data;

  /// bool
  final bool isFrozen;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'MetadataSet': {
          'collection': collection,
          'item': item,
          'data': data,
          'isFrozen': isFrozen,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(data);
    size = size + _i1.BoolCodec.codec.sizeHint(isFrozen);
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
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      data,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      isFrozen,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MetadataSet &&
          other.collection == collection &&
          other.item == item &&
          _i4.listsEqual(
            other.data,
            data,
          ) &&
          other.isFrozen == isFrozen;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        data,
        isFrozen,
      );
}

/// Metadata has been cleared for an item.
class MetadataCleared extends Event {
  const MetadataCleared({
    required this.collection,
    required this.item,
  });

  factory MetadataCleared._decode(_i1.Input input) {
    return MetadataCleared(
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
        'MetadataCleared': {
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
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MetadataCleared && other.collection == collection && other.item == item;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
      );
}

/// Metadata has been cleared for an item.
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
      19,
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
          _i4.listsEqual(
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
  });

  factory AttributeSet._decode(_i1.Input input) {
    return AttributeSet(
      collection: _i1.U32Codec.codec.decode(input),
      maybeItem: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      key: _i1.U8SequenceCodec.codec.decode(input),
      value: _i1.U8SequenceCodec.codec.decode(input),
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

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'AttributeSet': {
          'collection': collection,
          'maybeItem': maybeItem,
          'key': key,
          'value': value,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(maybeItem);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(key);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(value);
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
          _i4.listsEqual(
            other.key,
            key,
          ) &&
          _i4.listsEqual(
            other.value,
            value,
          );

  @override
  int get hashCode => Object.hash(
        collection,
        maybeItem,
        key,
        value,
      );
}

/// Attribute metadata has been cleared for a `collection` or `item`.
class AttributeCleared extends Event {
  const AttributeCleared({
    required this.collection,
    this.maybeItem,
    required this.key,
  });

  factory AttributeCleared._decode(_i1.Input input) {
    return AttributeCleared(
      collection: _i1.U32Codec.codec.decode(input),
      maybeItem: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      key: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// Option<T::ItemId>
  final int? maybeItem;

  /// BoundedVec<u8, T::KeyLimit>
  final List<int> key;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'AttributeCleared': {
          'collection': collection,
          'maybeItem': maybeItem,
          'key': key,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(maybeItem);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(key);
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
          _i4.listsEqual(
            other.key,
            key,
          );

  @override
  int get hashCode => Object.hash(
        collection,
        maybeItem,
        key,
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
      22,
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
          _i4.listsEqual(
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
      23,
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

/// The price was set for the instance.
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

/// The price for the instance was removed.
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
      25,
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
      26,
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
          _i4.listsEqual(
            other.seller,
            seller,
          ) &&
          _i4.listsEqual(
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
