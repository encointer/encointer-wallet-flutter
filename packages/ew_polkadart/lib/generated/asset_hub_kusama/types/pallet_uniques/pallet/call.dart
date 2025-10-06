// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../sp_runtime/multiaddress/multi_address.dart' as _i3;
import '../types/destroy_witness.dart' as _i4;

/// Contains a variant per dispatchable extrinsic that this pallet has.
abstract class Call {
  const Call();

  factory Call.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CallCodec codec = $CallCodec();

  static const $Call values = $Call();

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

class $Call {
  const $Call();

  Create create({
    required int collection,
    required _i3.MultiAddress admin,
  }) {
    return Create(
      collection: collection,
      admin: admin,
    );
  }

  ForceCreate forceCreate({
    required int collection,
    required _i3.MultiAddress owner,
    required bool freeHolding,
  }) {
    return ForceCreate(
      collection: collection,
      owner: owner,
      freeHolding: freeHolding,
    );
  }

  Destroy destroy({
    required int collection,
    required _i4.DestroyWitness witness,
  }) {
    return Destroy(
      collection: collection,
      witness: witness,
    );
  }

  Mint mint({
    required int collection,
    required int item,
    required _i3.MultiAddress owner,
  }) {
    return Mint(
      collection: collection,
      item: item,
      owner: owner,
    );
  }

  Burn burn({
    required int collection,
    required int item,
    _i3.MultiAddress? checkOwner,
  }) {
    return Burn(
      collection: collection,
      item: item,
      checkOwner: checkOwner,
    );
  }

  Transfer transfer({
    required int collection,
    required int item,
    required _i3.MultiAddress dest,
  }) {
    return Transfer(
      collection: collection,
      item: item,
      dest: dest,
    );
  }

  Redeposit redeposit({
    required int collection,
    required List<int> items,
  }) {
    return Redeposit(
      collection: collection,
      items: items,
    );
  }

  Freeze freeze({
    required int collection,
    required int item,
  }) {
    return Freeze(
      collection: collection,
      item: item,
    );
  }

  Thaw thaw({
    required int collection,
    required int item,
  }) {
    return Thaw(
      collection: collection,
      item: item,
    );
  }

  FreezeCollection freezeCollection({required int collection}) {
    return FreezeCollection(collection: collection);
  }

  ThawCollection thawCollection({required int collection}) {
    return ThawCollection(collection: collection);
  }

  TransferOwnership transferOwnership({
    required int collection,
    required _i3.MultiAddress newOwner,
  }) {
    return TransferOwnership(
      collection: collection,
      newOwner: newOwner,
    );
  }

  SetTeam setTeam({
    required int collection,
    required _i3.MultiAddress issuer,
    required _i3.MultiAddress admin,
    required _i3.MultiAddress freezer,
  }) {
    return SetTeam(
      collection: collection,
      issuer: issuer,
      admin: admin,
      freezer: freezer,
    );
  }

  ApproveTransfer approveTransfer({
    required int collection,
    required int item,
    required _i3.MultiAddress delegate,
  }) {
    return ApproveTransfer(
      collection: collection,
      item: item,
      delegate: delegate,
    );
  }

  CancelApproval cancelApproval({
    required int collection,
    required int item,
    _i3.MultiAddress? maybeCheckDelegate,
  }) {
    return CancelApproval(
      collection: collection,
      item: item,
      maybeCheckDelegate: maybeCheckDelegate,
    );
  }

  ForceItemStatus forceItemStatus({
    required int collection,
    required _i3.MultiAddress owner,
    required _i3.MultiAddress issuer,
    required _i3.MultiAddress admin,
    required _i3.MultiAddress freezer,
    required bool freeHolding,
    required bool isFrozen,
  }) {
    return ForceItemStatus(
      collection: collection,
      owner: owner,
      issuer: issuer,
      admin: admin,
      freezer: freezer,
      freeHolding: freeHolding,
      isFrozen: isFrozen,
    );
  }

  SetAttribute setAttribute({
    required int collection,
    int? maybeItem,
    required List<int> key,
    required List<int> value,
  }) {
    return SetAttribute(
      collection: collection,
      maybeItem: maybeItem,
      key: key,
      value: value,
    );
  }

  ClearAttribute clearAttribute({
    required int collection,
    int? maybeItem,
    required List<int> key,
  }) {
    return ClearAttribute(
      collection: collection,
      maybeItem: maybeItem,
      key: key,
    );
  }

  SetMetadata setMetadata({
    required int collection,
    required int item,
    required List<int> data,
    required bool isFrozen,
  }) {
    return SetMetadata(
      collection: collection,
      item: item,
      data: data,
      isFrozen: isFrozen,
    );
  }

  ClearMetadata clearMetadata({
    required int collection,
    required int item,
  }) {
    return ClearMetadata(
      collection: collection,
      item: item,
    );
  }

  SetCollectionMetadata setCollectionMetadata({
    required int collection,
    required List<int> data,
    required bool isFrozen,
  }) {
    return SetCollectionMetadata(
      collection: collection,
      data: data,
      isFrozen: isFrozen,
    );
  }

  ClearCollectionMetadata clearCollectionMetadata({required int collection}) {
    return ClearCollectionMetadata(collection: collection);
  }

  SetAcceptOwnership setAcceptOwnership({int? maybeCollection}) {
    return SetAcceptOwnership(maybeCollection: maybeCollection);
  }

  SetCollectionMaxSupply setCollectionMaxSupply({
    required int collection,
    required int maxSupply,
  }) {
    return SetCollectionMaxSupply(
      collection: collection,
      maxSupply: maxSupply,
    );
  }

  SetPrice setPrice({
    required int collection,
    required int item,
    BigInt? price,
    _i3.MultiAddress? whitelistedBuyer,
  }) {
    return SetPrice(
      collection: collection,
      item: item,
      price: price,
      whitelistedBuyer: whitelistedBuyer,
    );
  }

  BuyItem buyItem({
    required int collection,
    required int item,
    required BigInt bidPrice,
  }) {
    return BuyItem(
      collection: collection,
      item: item,
      bidPrice: bidPrice,
    );
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Create._decode(input);
      case 1:
        return ForceCreate._decode(input);
      case 2:
        return Destroy._decode(input);
      case 3:
        return Mint._decode(input);
      case 4:
        return Burn._decode(input);
      case 5:
        return Transfer._decode(input);
      case 6:
        return Redeposit._decode(input);
      case 7:
        return Freeze._decode(input);
      case 8:
        return Thaw._decode(input);
      case 9:
        return FreezeCollection._decode(input);
      case 10:
        return ThawCollection._decode(input);
      case 11:
        return TransferOwnership._decode(input);
      case 12:
        return SetTeam._decode(input);
      case 13:
        return ApproveTransfer._decode(input);
      case 14:
        return CancelApproval._decode(input);
      case 15:
        return ForceItemStatus._decode(input);
      case 16:
        return SetAttribute._decode(input);
      case 17:
        return ClearAttribute._decode(input);
      case 18:
        return SetMetadata._decode(input);
      case 19:
        return ClearMetadata._decode(input);
      case 20:
        return SetCollectionMetadata._decode(input);
      case 21:
        return ClearCollectionMetadata._decode(input);
      case 22:
        return SetAcceptOwnership._decode(input);
      case 23:
        return SetCollectionMaxSupply._decode(input);
      case 24:
        return SetPrice._decode(input);
      case 25:
        return BuyItem._decode(input);
      default:
        throw Exception('Call: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Call value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Create:
        (value as Create).encodeTo(output);
        break;
      case ForceCreate:
        (value as ForceCreate).encodeTo(output);
        break;
      case Destroy:
        (value as Destroy).encodeTo(output);
        break;
      case Mint:
        (value as Mint).encodeTo(output);
        break;
      case Burn:
        (value as Burn).encodeTo(output);
        break;
      case Transfer:
        (value as Transfer).encodeTo(output);
        break;
      case Redeposit:
        (value as Redeposit).encodeTo(output);
        break;
      case Freeze:
        (value as Freeze).encodeTo(output);
        break;
      case Thaw:
        (value as Thaw).encodeTo(output);
        break;
      case FreezeCollection:
        (value as FreezeCollection).encodeTo(output);
        break;
      case ThawCollection:
        (value as ThawCollection).encodeTo(output);
        break;
      case TransferOwnership:
        (value as TransferOwnership).encodeTo(output);
        break;
      case SetTeam:
        (value as SetTeam).encodeTo(output);
        break;
      case ApproveTransfer:
        (value as ApproveTransfer).encodeTo(output);
        break;
      case CancelApproval:
        (value as CancelApproval).encodeTo(output);
        break;
      case ForceItemStatus:
        (value as ForceItemStatus).encodeTo(output);
        break;
      case SetAttribute:
        (value as SetAttribute).encodeTo(output);
        break;
      case ClearAttribute:
        (value as ClearAttribute).encodeTo(output);
        break;
      case SetMetadata:
        (value as SetMetadata).encodeTo(output);
        break;
      case ClearMetadata:
        (value as ClearMetadata).encodeTo(output);
        break;
      case SetCollectionMetadata:
        (value as SetCollectionMetadata).encodeTo(output);
        break;
      case ClearCollectionMetadata:
        (value as ClearCollectionMetadata).encodeTo(output);
        break;
      case SetAcceptOwnership:
        (value as SetAcceptOwnership).encodeTo(output);
        break;
      case SetCollectionMaxSupply:
        (value as SetCollectionMaxSupply).encodeTo(output);
        break;
      case SetPrice:
        (value as SetPrice).encodeTo(output);
        break;
      case BuyItem:
        (value as BuyItem).encodeTo(output);
        break;
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case Create:
        return (value as Create)._sizeHint();
      case ForceCreate:
        return (value as ForceCreate)._sizeHint();
      case Destroy:
        return (value as Destroy)._sizeHint();
      case Mint:
        return (value as Mint)._sizeHint();
      case Burn:
        return (value as Burn)._sizeHint();
      case Transfer:
        return (value as Transfer)._sizeHint();
      case Redeposit:
        return (value as Redeposit)._sizeHint();
      case Freeze:
        return (value as Freeze)._sizeHint();
      case Thaw:
        return (value as Thaw)._sizeHint();
      case FreezeCollection:
        return (value as FreezeCollection)._sizeHint();
      case ThawCollection:
        return (value as ThawCollection)._sizeHint();
      case TransferOwnership:
        return (value as TransferOwnership)._sizeHint();
      case SetTeam:
        return (value as SetTeam)._sizeHint();
      case ApproveTransfer:
        return (value as ApproveTransfer)._sizeHint();
      case CancelApproval:
        return (value as CancelApproval)._sizeHint();
      case ForceItemStatus:
        return (value as ForceItemStatus)._sizeHint();
      case SetAttribute:
        return (value as SetAttribute)._sizeHint();
      case ClearAttribute:
        return (value as ClearAttribute)._sizeHint();
      case SetMetadata:
        return (value as SetMetadata)._sizeHint();
      case ClearMetadata:
        return (value as ClearMetadata)._sizeHint();
      case SetCollectionMetadata:
        return (value as SetCollectionMetadata)._sizeHint();
      case ClearCollectionMetadata:
        return (value as ClearCollectionMetadata)._sizeHint();
      case SetAcceptOwnership:
        return (value as SetAcceptOwnership)._sizeHint();
      case SetCollectionMaxSupply:
        return (value as SetCollectionMaxSupply)._sizeHint();
      case SetPrice:
        return (value as SetPrice)._sizeHint();
      case BuyItem:
        return (value as BuyItem)._sizeHint();
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Issue a new collection of non-fungible items from a public origin.
///
/// This new collection has no items initially and its owner is the origin.
///
/// The origin must conform to the configured `CreateOrigin` and have sufficient funds free.
///
/// `ItemDeposit` funds of sender are reserved.
///
/// Parameters:
/// - `collection`: The identifier of the new collection. This must not be currently in use.
/// - `admin`: The admin of this collection. The admin is the initial address of each
/// member of the collection's admin team.
///
/// Emits `Created` event when successful.
///
/// Weight: `O(1)`
class Create extends Call {
  const Create({
    required this.collection,
    required this.admin,
  });

  factory Create._decode(_i1.Input input) {
    return Create(
      collection: _i1.U32Codec.codec.decode(input),
      admin: _i3.MultiAddress.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress admin;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'create': {
          'collection': collection,
          'admin': admin.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i3.MultiAddress.codec.sizeHint(admin);
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
    _i3.MultiAddress.codec.encodeTo(
      admin,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Create && other.collection == collection && other.admin == admin;

  @override
  int get hashCode => Object.hash(
        collection,
        admin,
      );
}

/// Issue a new collection of non-fungible items from a privileged origin.
///
/// This new collection has no items initially.
///
/// The origin must conform to `ForceOrigin`.
///
/// Unlike `create`, no funds are reserved.
///
/// - `collection`: The identifier of the new item. This must not be currently in use.
/// - `owner`: The owner of this collection of items. The owner has full superuser
///  permissions
/// over this item, but may later change and configure the permissions using
/// `transfer_ownership` and `set_team`.
///
/// Emits `ForceCreated` event when successful.
///
/// Weight: `O(1)`
class ForceCreate extends Call {
  const ForceCreate({
    required this.collection,
    required this.owner,
    required this.freeHolding,
  });

  factory ForceCreate._decode(_i1.Input input) {
    return ForceCreate(
      collection: _i1.U32Codec.codec.decode(input),
      owner: _i3.MultiAddress.codec.decode(input),
      freeHolding: _i1.BoolCodec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress owner;

  /// bool
  final bool freeHolding;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'force_create': {
          'collection': collection,
          'owner': owner.toJson(),
          'freeHolding': freeHolding,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i3.MultiAddress.codec.sizeHint(owner);
    size = size + _i1.BoolCodec.codec.sizeHint(freeHolding);
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
    _i3.MultiAddress.codec.encodeTo(
      owner,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      freeHolding,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceCreate &&
          other.collection == collection &&
          other.owner == owner &&
          other.freeHolding == freeHolding;

  @override
  int get hashCode => Object.hash(
        collection,
        owner,
        freeHolding,
      );
}

/// Destroy a collection of fungible items.
///
/// The origin must conform to `ForceOrigin` or must be `Signed` and the sender must be the
/// owner of the `collection`.
///
/// - `collection`: The identifier of the collection to be destroyed.
/// - `witness`: Information on the items minted in the collection. This must be
/// correct.
///
/// Emits `Destroyed` event when successful.
///
/// Weight: `O(n + m)` where:
/// - `n = witness.items`
/// - `m = witness.item_metadatas`
/// - `a = witness.attributes`
class Destroy extends Call {
  const Destroy({
    required this.collection,
    required this.witness,
  });

  factory Destroy._decode(_i1.Input input) {
    return Destroy(
      collection: _i1.U32Codec.codec.decode(input),
      witness: _i4.DestroyWitness.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// DestroyWitness
  final _i4.DestroyWitness witness;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'destroy': {
          'collection': collection,
          'witness': witness.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i4.DestroyWitness.codec.sizeHint(witness);
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
    _i4.DestroyWitness.codec.encodeTo(
      witness,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Destroy && other.collection == collection && other.witness == witness;

  @override
  int get hashCode => Object.hash(
        collection,
        witness,
      );
}

/// Mint an item of a particular collection.
///
/// The origin must be Signed and the sender must be the Issuer of the `collection`.
///
/// - `collection`: The collection of the item to be minted.
/// - `item`: The item value of the item to be minted.
/// - `beneficiary`: The initial owner of the minted item.
///
/// Emits `Issued` event when successful.
///
/// Weight: `O(1)`
class Mint extends Call {
  const Mint({
    required this.collection,
    required this.item,
    required this.owner,
  });

  factory Mint._decode(_i1.Input input) {
    return Mint(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      owner: _i3.MultiAddress.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress owner;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'mint': {
          'collection': collection,
          'item': item,
          'owner': owner.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + _i3.MultiAddress.codec.sizeHint(owner);
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
    _i3.MultiAddress.codec.encodeTo(
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
      other is Mint && other.collection == collection && other.item == item && other.owner == owner;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        owner,
      );
}

/// Destroy a single item.
///
/// Origin must be Signed and the signing account must be either:
/// - the Admin of the `collection`;
/// - the Owner of the `item`;
///
/// - `collection`: The collection of the item to be burned.
/// - `item`: The item of the item to be burned.
/// - `check_owner`: If `Some` then the operation will fail with `WrongOwner` unless the
///  item is owned by this value.
///
/// Emits `Burned` with the actual amount burned.
///
/// Weight: `O(1)`
/// Modes: `check_owner.is_some()`.
class Burn extends Call {
  const Burn({
    required this.collection,
    required this.item,
    this.checkOwner,
  });

  factory Burn._decode(_i1.Input input) {
    return Burn(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      checkOwner: const _i1.OptionCodec<_i3.MultiAddress>(_i3.MultiAddress.codec).decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// Option<AccountIdLookupOf<T>>
  final _i3.MultiAddress? checkOwner;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'burn': {
          'collection': collection,
          'item': item,
          'checkOwner': checkOwner?.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + const _i1.OptionCodec<_i3.MultiAddress>(_i3.MultiAddress.codec).sizeHint(checkOwner);
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
    const _i1.OptionCodec<_i3.MultiAddress>(_i3.MultiAddress.codec).encodeTo(
      checkOwner,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Burn && other.collection == collection && other.item == item && other.checkOwner == checkOwner;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        checkOwner,
      );
}

/// Move an item from the sender account to another.
///
/// This resets the approved account of the item.
///
/// Origin must be Signed and the signing account must be either:
/// - the Admin of the `collection`;
/// - the Owner of the `item`;
/// - the approved delegate for the `item` (in this case, the approval is reset).
///
/// Arguments:
/// - `collection`: The collection of the item to be transferred.
/// - `item`: The item of the item to be transferred.
/// - `dest`: The account to receive ownership of the item.
///
/// Emits `Transferred`.
///
/// Weight: `O(1)`
class Transfer extends Call {
  const Transfer({
    required this.collection,
    required this.item,
    required this.dest,
  });

  factory Transfer._decode(_i1.Input input) {
    return Transfer(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      dest: _i3.MultiAddress.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress dest;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'transfer': {
          'collection': collection,
          'item': item,
          'dest': dest.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + _i3.MultiAddress.codec.sizeHint(dest);
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
    _i3.MultiAddress.codec.encodeTo(
      dest,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Transfer && other.collection == collection && other.item == item && other.dest == dest;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        dest,
      );
}

/// Reevaluate the deposits on some items.
///
/// Origin must be Signed and the sender should be the Owner of the `collection`.
///
/// - `collection`: The collection to be frozen.
/// - `items`: The items of the collection whose deposits will be reevaluated.
///
/// NOTE: This exists as a best-effort function. Any items which are unknown or
/// in the case that the owner account does not have reservable funds to pay for a
/// deposit increase are ignored. Generally the owner isn't going to call this on items
/// whose existing deposit is less than the refreshed deposit as it would only cost them,
/// so it's of little consequence.
///
/// It will still return an error in the case that the collection is unknown of the signer
/// is not permitted to call it.
///
/// Weight: `O(items.len())`
class Redeposit extends Call {
  const Redeposit({
    required this.collection,
    required this.items,
  });

  factory Redeposit._decode(_i1.Input input) {
    return Redeposit(
      collection: _i1.U32Codec.codec.decode(input),
      items: _i1.U32SequenceCodec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// Vec<T::ItemId>
  final List<int> items;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'redeposit': {
          'collection': collection,
          'items': items,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32SequenceCodec.codec.sizeHint(items);
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
    _i1.U32SequenceCodec.codec.encodeTo(
      items,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Redeposit &&
          other.collection == collection &&
          _i5.listsEqual(
            other.items,
            items,
          );

  @override
  int get hashCode => Object.hash(
        collection,
        items,
      );
}

/// Disallow further unprivileged transfer of an item.
///
/// Origin must be Signed and the sender should be the Freezer of the `collection`.
///
/// - `collection`: The collection of the item to be frozen.
/// - `item`: The item of the item to be frozen.
///
/// Emits `Frozen`.
///
/// Weight: `O(1)`
class Freeze extends Call {
  const Freeze({
    required this.collection,
    required this.item,
  });

  factory Freeze._decode(_i1.Input input) {
    return Freeze(
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
        'freeze': {
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
      other is Freeze && other.collection == collection && other.item == item;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
      );
}

/// Re-allow unprivileged transfer of an item.
///
/// Origin must be Signed and the sender should be the Freezer of the `collection`.
///
/// - `collection`: The collection of the item to be thawed.
/// - `item`: The item of the item to be thawed.
///
/// Emits `Thawed`.
///
/// Weight: `O(1)`
class Thaw extends Call {
  const Thaw({
    required this.collection,
    required this.item,
  });

  factory Thaw._decode(_i1.Input input) {
    return Thaw(
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
        'thaw': {
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
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Thaw && other.collection == collection && other.item == item;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
      );
}

/// Disallow further unprivileged transfers for a whole collection.
///
/// Origin must be Signed and the sender should be the Freezer of the `collection`.
///
/// - `collection`: The collection to be frozen.
///
/// Emits `CollectionFrozen`.
///
/// Weight: `O(1)`
class FreezeCollection extends Call {
  const FreezeCollection({required this.collection});

  factory FreezeCollection._decode(_i1.Input input) {
    return FreezeCollection(collection: _i1.U32Codec.codec.decode(input));
  }

  /// T::CollectionId
  final int collection;

  @override
  Map<String, Map<String, int>> toJson() => {
        'freeze_collection': {'collection': collection}
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
      other is FreezeCollection && other.collection == collection;

  @override
  int get hashCode => collection.hashCode;
}

/// Re-allow unprivileged transfers for a whole collection.
///
/// Origin must be Signed and the sender should be the Admin of the `collection`.
///
/// - `collection`: The collection to be thawed.
///
/// Emits `CollectionThawed`.
///
/// Weight: `O(1)`
class ThawCollection extends Call {
  const ThawCollection({required this.collection});

  factory ThawCollection._decode(_i1.Input input) {
    return ThawCollection(collection: _i1.U32Codec.codec.decode(input));
  }

  /// T::CollectionId
  final int collection;

  @override
  Map<String, Map<String, int>> toJson() => {
        'thaw_collection': {'collection': collection}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
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
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ThawCollection && other.collection == collection;

  @override
  int get hashCode => collection.hashCode;
}

/// Change the Owner of a collection.
///
/// Origin must be Signed and the sender should be the Owner of the `collection`.
///
/// - `collection`: The collection whose owner should be changed.
/// - `owner`: The new Owner of this collection. They must have called
///  `set_accept_ownership` with `collection` in order for this operation to succeed.
///
/// Emits `OwnerChanged`.
///
/// Weight: `O(1)`
class TransferOwnership extends Call {
  const TransferOwnership({
    required this.collection,
    required this.newOwner,
  });

  factory TransferOwnership._decode(_i1.Input input) {
    return TransferOwnership(
      collection: _i1.U32Codec.codec.decode(input),
      newOwner: _i3.MultiAddress.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress newOwner;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'transfer_ownership': {
          'collection': collection,
          'newOwner': newOwner.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i3.MultiAddress.codec.sizeHint(newOwner);
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
    _i3.MultiAddress.codec.encodeTo(
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
      other is TransferOwnership && other.collection == collection && other.newOwner == newOwner;

  @override
  int get hashCode => Object.hash(
        collection,
        newOwner,
      );
}

/// Change the Issuer, Admin and Freezer of a collection.
///
/// Origin must be Signed and the sender should be the Owner of the `collection`.
///
/// - `collection`: The collection whose team should be changed.
/// - `issuer`: The new Issuer of this collection.
/// - `admin`: The new Admin of this collection.
/// - `freezer`: The new Freezer of this collection.
///
/// Emits `TeamChanged`.
///
/// Weight: `O(1)`
class SetTeam extends Call {
  const SetTeam({
    required this.collection,
    required this.issuer,
    required this.admin,
    required this.freezer,
  });

  factory SetTeam._decode(_i1.Input input) {
    return SetTeam(
      collection: _i1.U32Codec.codec.decode(input),
      issuer: _i3.MultiAddress.codec.decode(input),
      admin: _i3.MultiAddress.codec.decode(input),
      freezer: _i3.MultiAddress.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress issuer;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress admin;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress freezer;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'set_team': {
          'collection': collection,
          'issuer': issuer.toJson(),
          'admin': admin.toJson(),
          'freezer': freezer.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i3.MultiAddress.codec.sizeHint(issuer);
    size = size + _i3.MultiAddress.codec.sizeHint(admin);
    size = size + _i3.MultiAddress.codec.sizeHint(freezer);
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
    _i3.MultiAddress.codec.encodeTo(
      issuer,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      admin,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
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
      other is SetTeam &&
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

/// Approve an item to be transferred by a delegated third-party account.
///
/// The origin must conform to `ForceOrigin` or must be `Signed` and the sender must be
/// either the owner of the `item` or the admin of the collection.
///
/// - `collection`: The collection of the item to be approved for delegated transfer.
/// - `item`: The item of the item to be approved for delegated transfer.
/// - `delegate`: The account to delegate permission to transfer the item.
///
/// Important NOTE: The `approved` account gets reset after each transfer.
///
/// Emits `ApprovedTransfer` on success.
///
/// Weight: `O(1)`
class ApproveTransfer extends Call {
  const ApproveTransfer({
    required this.collection,
    required this.item,
    required this.delegate,
  });

  factory ApproveTransfer._decode(_i1.Input input) {
    return ApproveTransfer(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      delegate: _i3.MultiAddress.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress delegate;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'approve_transfer': {
          'collection': collection,
          'item': item,
          'delegate': delegate.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + _i3.MultiAddress.codec.sizeHint(delegate);
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
    _i3.MultiAddress.codec.encodeTo(
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
      other is ApproveTransfer && other.collection == collection && other.item == item && other.delegate == delegate;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        delegate,
      );
}

/// Cancel the prior approval for the transfer of an item by a delegate.
///
/// Origin must be either:
/// - the `Force` origin;
/// - `Signed` with the signer being the Admin of the `collection`;
/// - `Signed` with the signer being the Owner of the `item`;
///
/// Arguments:
/// - `collection`: The collection of the item of whose approval will be cancelled.
/// - `item`: The item of the item of whose approval will be cancelled.
/// - `maybe_check_delegate`: If `Some` will ensure that the given account is the one to
///  which permission of transfer is delegated.
///
/// Emits `ApprovalCancelled` on success.
///
/// Weight: `O(1)`
class CancelApproval extends Call {
  const CancelApproval({
    required this.collection,
    required this.item,
    this.maybeCheckDelegate,
  });

  factory CancelApproval._decode(_i1.Input input) {
    return CancelApproval(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      maybeCheckDelegate: const _i1.OptionCodec<_i3.MultiAddress>(_i3.MultiAddress.codec).decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// Option<AccountIdLookupOf<T>>
  final _i3.MultiAddress? maybeCheckDelegate;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'cancel_approval': {
          'collection': collection,
          'item': item,
          'maybeCheckDelegate': maybeCheckDelegate?.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + const _i1.OptionCodec<_i3.MultiAddress>(_i3.MultiAddress.codec).sizeHint(maybeCheckDelegate);
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
    const _i1.OptionCodec<_i3.MultiAddress>(_i3.MultiAddress.codec).encodeTo(
      maybeCheckDelegate,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CancelApproval &&
          other.collection == collection &&
          other.item == item &&
          other.maybeCheckDelegate == maybeCheckDelegate;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        maybeCheckDelegate,
      );
}

/// Alter the attributes of a given item.
///
/// Origin must be `ForceOrigin`.
///
/// - `collection`: The identifier of the item.
/// - `owner`: The new Owner of this item.
/// - `issuer`: The new Issuer of this item.
/// - `admin`: The new Admin of this item.
/// - `freezer`: The new Freezer of this item.
/// - `free_holding`: Whether a deposit is taken for holding an item of this collection.
/// - `is_frozen`: Whether this collection is frozen except for permissioned/admin
/// instructions.
///
/// Emits `ItemStatusChanged` with the identity of the item.
///
/// Weight: `O(1)`
class ForceItemStatus extends Call {
  const ForceItemStatus({
    required this.collection,
    required this.owner,
    required this.issuer,
    required this.admin,
    required this.freezer,
    required this.freeHolding,
    required this.isFrozen,
  });

  factory ForceItemStatus._decode(_i1.Input input) {
    return ForceItemStatus(
      collection: _i1.U32Codec.codec.decode(input),
      owner: _i3.MultiAddress.codec.decode(input),
      issuer: _i3.MultiAddress.codec.decode(input),
      admin: _i3.MultiAddress.codec.decode(input),
      freezer: _i3.MultiAddress.codec.decode(input),
      freeHolding: _i1.BoolCodec.codec.decode(input),
      isFrozen: _i1.BoolCodec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress owner;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress issuer;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress admin;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress freezer;

  /// bool
  final bool freeHolding;

  /// bool
  final bool isFrozen;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'force_item_status': {
          'collection': collection,
          'owner': owner.toJson(),
          'issuer': issuer.toJson(),
          'admin': admin.toJson(),
          'freezer': freezer.toJson(),
          'freeHolding': freeHolding,
          'isFrozen': isFrozen,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i3.MultiAddress.codec.sizeHint(owner);
    size = size + _i3.MultiAddress.codec.sizeHint(issuer);
    size = size + _i3.MultiAddress.codec.sizeHint(admin);
    size = size + _i3.MultiAddress.codec.sizeHint(freezer);
    size = size + _i1.BoolCodec.codec.sizeHint(freeHolding);
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
    _i3.MultiAddress.codec.encodeTo(
      owner,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      issuer,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      admin,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      freezer,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      freeHolding,
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
      other is ForceItemStatus &&
          other.collection == collection &&
          other.owner == owner &&
          other.issuer == issuer &&
          other.admin == admin &&
          other.freezer == freezer &&
          other.freeHolding == freeHolding &&
          other.isFrozen == isFrozen;

  @override
  int get hashCode => Object.hash(
        collection,
        owner,
        issuer,
        admin,
        freezer,
        freeHolding,
        isFrozen,
      );
}

/// Set an attribute for a collection or item.
///
/// Origin must be either `ForceOrigin` or Signed and the sender should be the Owner of the
/// `collection`.
///
/// If the origin is Signed, then funds of signer are reserved according to the formula:
/// `MetadataDepositBase + DepositPerByte * (key.len + value.len)` taking into
/// account any already reserved funds.
///
/// - `collection`: The identifier of the collection whose item's metadata to set.
/// - `maybe_item`: The identifier of the item whose metadata to set.
/// - `key`: The key of the attribute.
/// - `value`: The value to which to set the attribute.
///
/// Emits `AttributeSet`.
///
/// Weight: `O(1)`
class SetAttribute extends Call {
  const SetAttribute({
    required this.collection,
    this.maybeItem,
    required this.key,
    required this.value,
  });

  factory SetAttribute._decode(_i1.Input input) {
    return SetAttribute(
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
        'set_attribute': {
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
      16,
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
      other is SetAttribute &&
          other.collection == collection &&
          other.maybeItem == maybeItem &&
          _i5.listsEqual(
            other.key,
            key,
          ) &&
          _i5.listsEqual(
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

/// Clear an attribute for a collection or item.
///
/// Origin must be either `ForceOrigin` or Signed and the sender should be the Owner of the
/// `collection`.
///
/// Any deposit is freed for the collection's owner.
///
/// - `collection`: The identifier of the collection whose item's metadata to clear.
/// - `maybe_item`: The identifier of the item whose metadata to clear.
/// - `key`: The key of the attribute.
///
/// Emits `AttributeCleared`.
///
/// Weight: `O(1)`
class ClearAttribute extends Call {
  const ClearAttribute({
    required this.collection,
    this.maybeItem,
    required this.key,
  });

  factory ClearAttribute._decode(_i1.Input input) {
    return ClearAttribute(
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
        'clear_attribute': {
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
      17,
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
      other is ClearAttribute &&
          other.collection == collection &&
          other.maybeItem == maybeItem &&
          _i5.listsEqual(
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

/// Set the metadata for an item.
///
/// Origin must be either `ForceOrigin` or Signed and the sender should be the Owner of the
/// `collection`.
///
/// If the origin is Signed, then funds of signer are reserved according to the formula:
/// `MetadataDepositBase + DepositPerByte * data.len` taking into
/// account any already reserved funds.
///
/// - `collection`: The identifier of the collection whose item's metadata to set.
/// - `item`: The identifier of the item whose metadata to set.
/// - `data`: The general information of this item. Limited in length by `StringLimit`.
/// - `is_frozen`: Whether the metadata should be frozen against further changes.
///
/// Emits `MetadataSet`.
///
/// Weight: `O(1)`
class SetMetadata extends Call {
  const SetMetadata({
    required this.collection,
    required this.item,
    required this.data,
    required this.isFrozen,
  });

  factory SetMetadata._decode(_i1.Input input) {
    return SetMetadata(
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
        'set_metadata': {
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
      other is SetMetadata &&
          other.collection == collection &&
          other.item == item &&
          _i5.listsEqual(
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

/// Clear the metadata for an item.
///
/// Origin must be either `ForceOrigin` or Signed and the sender should be the Owner of the
/// `item`.
///
/// Any deposit is freed for the collection's owner.
///
/// - `collection`: The identifier of the collection whose item's metadata to clear.
/// - `item`: The identifier of the item whose metadata to clear.
///
/// Emits `MetadataCleared`.
///
/// Weight: `O(1)`
class ClearMetadata extends Call {
  const ClearMetadata({
    required this.collection,
    required this.item,
  });

  factory ClearMetadata._decode(_i1.Input input) {
    return ClearMetadata(
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
        'clear_metadata': {
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
      other is ClearMetadata && other.collection == collection && other.item == item;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
      );
}

/// Set the metadata for a collection.
///
/// Origin must be either `ForceOrigin` or `Signed` and the sender should be the Owner of
/// the `collection`.
///
/// If the origin is `Signed`, then funds of signer are reserved according to the formula:
/// `MetadataDepositBase + DepositPerByte * data.len` taking into
/// account any already reserved funds.
///
/// - `collection`: The identifier of the item whose metadata to update.
/// - `data`: The general information of this item. Limited in length by `StringLimit`.
/// - `is_frozen`: Whether the metadata should be frozen against further changes.
///
/// Emits `CollectionMetadataSet`.
///
/// Weight: `O(1)`
class SetCollectionMetadata extends Call {
  const SetCollectionMetadata({
    required this.collection,
    required this.data,
    required this.isFrozen,
  });

  factory SetCollectionMetadata._decode(_i1.Input input) {
    return SetCollectionMetadata(
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
        'set_collection_metadata': {
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
      20,
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
      other is SetCollectionMetadata &&
          other.collection == collection &&
          _i5.listsEqual(
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

/// Clear the metadata for a collection.
///
/// Origin must be either `ForceOrigin` or `Signed` and the sender should be the Owner of
/// the `collection`.
///
/// Any deposit is freed for the collection's owner.
///
/// - `collection`: The identifier of the collection whose metadata to clear.
///
/// Emits `CollectionMetadataCleared`.
///
/// Weight: `O(1)`
class ClearCollectionMetadata extends Call {
  const ClearCollectionMetadata({required this.collection});

  factory ClearCollectionMetadata._decode(_i1.Input input) {
    return ClearCollectionMetadata(collection: _i1.U32Codec.codec.decode(input));
  }

  /// T::CollectionId
  final int collection;

  @override
  Map<String, Map<String, int>> toJson() => {
        'clear_collection_metadata': {'collection': collection}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
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
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ClearCollectionMetadata && other.collection == collection;

  @override
  int get hashCode => collection.hashCode;
}

/// Set (or reset) the acceptance of ownership for a particular account.
///
/// Origin must be `Signed` and if `maybe_collection` is `Some`, then the signer must have a
/// provider reference.
///
/// - `maybe_collection`: The identifier of the collection whose ownership the signer is
///  willing to accept, or if `None`, an indication that the signer is willing to accept no
///  ownership transferal.
///
/// Emits `OwnershipAcceptanceChanged`.
class SetAcceptOwnership extends Call {
  const SetAcceptOwnership({this.maybeCollection});

  factory SetAcceptOwnership._decode(_i1.Input input) {
    return SetAcceptOwnership(maybeCollection: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input));
  }

  /// Option<T::CollectionId>
  final int? maybeCollection;

  @override
  Map<String, Map<String, int?>> toJson() => {
        'set_accept_ownership': {'maybeCollection': maybeCollection}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(maybeCollection);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      22,
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
      other is SetAcceptOwnership && other.maybeCollection == maybeCollection;

  @override
  int get hashCode => maybeCollection.hashCode;
}

/// Set the maximum amount of items a collection could have.
///
/// Origin must be either `ForceOrigin` or `Signed` and the sender should be the Owner of
/// the `collection`.
///
/// Note: This function can only succeed once per collection.
///
/// - `collection`: The identifier of the collection to change.
/// - `max_supply`: The maximum amount of items a collection could have.
///
/// Emits `CollectionMaxSupplySet` event when successful.
class SetCollectionMaxSupply extends Call {
  const SetCollectionMaxSupply({
    required this.collection,
    required this.maxSupply,
  });

  factory SetCollectionMaxSupply._decode(_i1.Input input) {
    return SetCollectionMaxSupply(
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
        'set_collection_max_supply': {
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
      other is SetCollectionMaxSupply && other.collection == collection && other.maxSupply == maxSupply;

  @override
  int get hashCode => Object.hash(
        collection,
        maxSupply,
      );
}

/// Set (or reset) the price for an item.
///
/// Origin must be Signed and must be the owner of the asset `item`.
///
/// - `collection`: The collection of the item.
/// - `item`: The item to set the price for.
/// - `price`: The price for the item. Pass `None`, to reset the price.
/// - `buyer`: Restricts the buy operation to a specific account.
///
/// Emits `ItemPriceSet` on success if the price is not `None`.
/// Emits `ItemPriceRemoved` on success if the price is `None`.
class SetPrice extends Call {
  const SetPrice({
    required this.collection,
    required this.item,
    this.price,
    this.whitelistedBuyer,
  });

  factory SetPrice._decode(_i1.Input input) {
    return SetPrice(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      price: const _i1.OptionCodec<BigInt>(_i1.U128Codec.codec).decode(input),
      whitelistedBuyer: const _i1.OptionCodec<_i3.MultiAddress>(_i3.MultiAddress.codec).decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// Option<ItemPrice<T, I>>
  final BigInt? price;

  /// Option<AccountIdLookupOf<T>>
  final _i3.MultiAddress? whitelistedBuyer;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'set_price': {
          'collection': collection,
          'item': item,
          'price': price,
          'whitelistedBuyer': whitelistedBuyer?.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + const _i1.OptionCodec<BigInt>(_i1.U128Codec.codec).sizeHint(price);
    size = size + const _i1.OptionCodec<_i3.MultiAddress>(_i3.MultiAddress.codec).sizeHint(whitelistedBuyer);
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
    const _i1.OptionCodec<BigInt>(_i1.U128Codec.codec).encodeTo(
      price,
      output,
    );
    const _i1.OptionCodec<_i3.MultiAddress>(_i3.MultiAddress.codec).encodeTo(
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
      other is SetPrice &&
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

/// Allows to buy an item if it's up for sale.
///
/// Origin must be Signed and must not be the owner of the `item`.
///
/// - `collection`: The collection of the item.
/// - `item`: The item the sender wants to buy.
/// - `bid_price`: The price the sender is willing to pay.
///
/// Emits `ItemBought` on success.
class BuyItem extends Call {
  const BuyItem({
    required this.collection,
    required this.item,
    required this.bidPrice,
  });

  factory BuyItem._decode(_i1.Input input) {
    return BuyItem(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      bidPrice: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// ItemPrice<T, I>
  final BigInt bidPrice;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'buy_item': {
          'collection': collection,
          'item': item,
          'bidPrice': bidPrice,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + _i1.U128Codec.codec.sizeHint(bidPrice);
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
    _i1.U128Codec.codec.encodeTo(
      bidPrice,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BuyItem && other.collection == collection && other.item == item && other.bidPrice == bidPrice;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        bidPrice,
      );
}
