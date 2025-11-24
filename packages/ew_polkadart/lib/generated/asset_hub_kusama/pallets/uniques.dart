// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i9;
import 'dart:typed_data' as _i10;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/asset_hub_kusama_runtime/runtime_call.dart' as _i11;
import '../types/pallet_uniques/pallet/call.dart' as _i13;
import '../types/pallet_uniques/types/collection_details.dart' as _i2;
import '../types/pallet_uniques/types/collection_metadata.dart' as _i6;
import '../types/pallet_uniques/types/destroy_witness.dart' as _i14;
import '../types/pallet_uniques/types/item_details.dart' as _i5;
import '../types/pallet_uniques/types/item_metadata.dart' as _i7;
import '../types/sp_core/crypto/account_id32.dart' as _i4;
import '../types/sp_runtime/multiaddress/multi_address.dart' as _i12;
import '../types/tuples.dart' as _i8;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<int, _i2.CollectionDetails> _class = const _i1.StorageMap<int, _i2.CollectionDetails>(
    prefix: 'Uniques',
    storage: 'Class',
    valueCodec: _i2.CollectionDetails.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageMap<_i4.AccountId32, int> _ownershipAcceptance = const _i1.StorageMap<_i4.AccountId32, int>(
    prefix: 'Uniques',
    storage: 'OwnershipAcceptance',
    valueCodec: _i3.U32Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i4.AccountId32Codec()),
  );

  final _i1.StorageTripleMap<_i4.AccountId32, int, int, dynamic> _account =
      const _i1.StorageTripleMap<_i4.AccountId32, int, int, dynamic>(
    prefix: 'Uniques',
    storage: 'Account',
    valueCodec: _i3.NullCodec.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i4.AccountId32Codec()),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
    hasher3: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageDoubleMap<_i4.AccountId32, int, dynamic> _classAccount =
      const _i1.StorageDoubleMap<_i4.AccountId32, int, dynamic>(
    prefix: 'Uniques',
    storage: 'ClassAccount',
    valueCodec: _i3.NullCodec.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i4.AccountId32Codec()),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageDoubleMap<int, int, _i5.ItemDetails> _asset = const _i1.StorageDoubleMap<int, int, _i5.ItemDetails>(
    prefix: 'Uniques',
    storage: 'Asset',
    valueCodec: _i5.ItemDetails.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageMap<int, _i6.CollectionMetadata> _classMetadataOf =
      const _i1.StorageMap<int, _i6.CollectionMetadata>(
    prefix: 'Uniques',
    storage: 'ClassMetadataOf',
    valueCodec: _i6.CollectionMetadata.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageDoubleMap<int, int, _i7.ItemMetadata> _instanceMetadataOf =
      const _i1.StorageDoubleMap<int, int, _i7.ItemMetadata>(
    prefix: 'Uniques',
    storage: 'InstanceMetadataOf',
    valueCodec: _i7.ItemMetadata.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageTripleMap<int, int?, List<int>, _i8.Tuple2<List<int>, BigInt>> _attribute =
      const _i1.StorageTripleMap<int, int?, List<int>, _i8.Tuple2<List<int>, BigInt>>(
    prefix: 'Uniques',
    storage: 'Attribute',
    valueCodec: _i8.Tuple2Codec<List<int>, BigInt>(
      _i3.U8SequenceCodec.codec,
      _i3.U128Codec.codec,
    ),
    hasher1: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.OptionCodec<int>(_i3.U32Codec.codec)),
    hasher3: _i1.StorageHasher.blake2b128Concat(_i3.U8SequenceCodec.codec),
  );

  final _i1.StorageDoubleMap<int, int, _i8.Tuple2<BigInt, _i4.AccountId32?>> _itemPriceOf =
      const _i1.StorageDoubleMap<int, int, _i8.Tuple2<BigInt, _i4.AccountId32?>>(
    prefix: 'Uniques',
    storage: 'ItemPriceOf',
    valueCodec: _i8.Tuple2Codec<BigInt, _i4.AccountId32?>(
      _i3.U128Codec.codec,
      _i3.OptionCodec<_i4.AccountId32>(_i4.AccountId32Codec()),
    ),
    hasher1: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageMap<int, int> _collectionMaxSupply = const _i1.StorageMap<int, int>(
    prefix: 'Uniques',
    storage: 'CollectionMaxSupply',
    valueCodec: _i3.U32Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  /// Details of a collection.
  _i9.Future<_i2.CollectionDetails?> class_(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _class.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _class.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The collection, if any, of which an account is willing to take ownership.
  _i9.Future<int?> ownershipAcceptance(
    _i4.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _ownershipAcceptance.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _ownershipAcceptance.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The items held by any given account; set out this way so that items owned by a single
  /// account can be enumerated.
  _i9.Future<dynamic> account(
    _i4.AccountId32 key1,
    int key2,
    int key3, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _account.hashedKeyFor(
      key1,
      key2,
      key3,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _account.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The collections owned by any given account; set out this way so that collections owned by
  /// a single account can be enumerated.
  _i9.Future<dynamic> classAccount(
    _i4.AccountId32 key1,
    int key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _classAccount.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _classAccount.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The items in existence and their ownership details.
  _i9.Future<_i5.ItemDetails?> asset(
    int key1,
    int key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _asset.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _asset.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Metadata of a collection.
  _i9.Future<_i6.CollectionMetadata?> classMetadataOf(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _classMetadataOf.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _classMetadataOf.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Metadata of an item.
  _i9.Future<_i7.ItemMetadata?> instanceMetadataOf(
    int key1,
    int key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _instanceMetadataOf.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _instanceMetadataOf.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Attributes of a collection.
  _i9.Future<_i8.Tuple2<List<int>, BigInt>?> attribute(
    int key1,
    int? key2,
    List<int> key3, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _attribute.hashedKeyFor(
      key1,
      key2,
      key3,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _attribute.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Price of an asset instance.
  _i9.Future<_i8.Tuple2<BigInt, _i4.AccountId32?>?> itemPriceOf(
    int key1,
    int key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _itemPriceOf.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _itemPriceOf.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Keeps track of the number of items a collection might have.
  _i9.Future<int?> collectionMaxSupply(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _collectionMaxSupply.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _collectionMaxSupply.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Details of a collection.
  _i9.Future<List<_i2.CollectionDetails?>> multiClass(
    List<int> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _class.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _class.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// The collection, if any, of which an account is willing to take ownership.
  _i9.Future<List<int?>> multiOwnershipAcceptance(
    List<_i4.AccountId32> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _ownershipAcceptance.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _ownershipAcceptance.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// Metadata of a collection.
  _i9.Future<List<_i6.CollectionMetadata?>> multiClassMetadataOf(
    List<int> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _classMetadataOf.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _classMetadataOf.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// Keeps track of the number of items a collection might have.
  _i9.Future<List<int?>> multiCollectionMaxSupply(
    List<int> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _collectionMaxSupply.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _collectionMaxSupply.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// Returns the storage key for `class`.
  _i10.Uint8List classKey(int key1) {
    final hashedKey = _class.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `ownershipAcceptance`.
  _i10.Uint8List ownershipAcceptanceKey(_i4.AccountId32 key1) {
    final hashedKey = _ownershipAcceptance.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `account`.
  _i10.Uint8List accountKey(
    _i4.AccountId32 key1,
    int key2,
    int key3,
  ) {
    final hashedKey = _account.hashedKeyFor(
      key1,
      key2,
      key3,
    );
    return hashedKey;
  }

  /// Returns the storage key for `classAccount`.
  _i10.Uint8List classAccountKey(
    _i4.AccountId32 key1,
    int key2,
  ) {
    final hashedKey = _classAccount.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `asset`.
  _i10.Uint8List assetKey(
    int key1,
    int key2,
  ) {
    final hashedKey = _asset.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `classMetadataOf`.
  _i10.Uint8List classMetadataOfKey(int key1) {
    final hashedKey = _classMetadataOf.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `instanceMetadataOf`.
  _i10.Uint8List instanceMetadataOfKey(
    int key1,
    int key2,
  ) {
    final hashedKey = _instanceMetadataOf.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `attribute`.
  _i10.Uint8List attributeKey(
    int key1,
    int? key2,
    List<int> key3,
  ) {
    final hashedKey = _attribute.hashedKeyFor(
      key1,
      key2,
      key3,
    );
    return hashedKey;
  }

  /// Returns the storage key for `itemPriceOf`.
  _i10.Uint8List itemPriceOfKey(
    int key1,
    int key2,
  ) {
    final hashedKey = _itemPriceOf.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `collectionMaxSupply`.
  _i10.Uint8List collectionMaxSupplyKey(int key1) {
    final hashedKey = _collectionMaxSupply.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `class`.
  _i10.Uint8List classMapPrefix() {
    final hashedKey = _class.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `ownershipAcceptance`.
  _i10.Uint8List ownershipAcceptanceMapPrefix() {
    final hashedKey = _ownershipAcceptance.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `classAccount`.
  _i10.Uint8List classAccountMapPrefix(_i4.AccountId32 key1) {
    final hashedKey = _classAccount.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `asset`.
  _i10.Uint8List assetMapPrefix(int key1) {
    final hashedKey = _asset.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `classMetadataOf`.
  _i10.Uint8List classMetadataOfMapPrefix() {
    final hashedKey = _classMetadataOf.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `instanceMetadataOf`.
  _i10.Uint8List instanceMetadataOfMapPrefix(int key1) {
    final hashedKey = _instanceMetadataOf.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `itemPriceOf`.
  _i10.Uint8List itemPriceOfMapPrefix(int key1) {
    final hashedKey = _itemPriceOf.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `collectionMaxSupply`.
  _i10.Uint8List collectionMaxSupplyMapPrefix() {
    final hashedKey = _collectionMaxSupply.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

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
  _i11.Uniques create({
    required int collection,
    required _i12.MultiAddress admin,
  }) {
    return _i11.Uniques(_i13.Create(
      collection: collection,
      admin: admin,
    ));
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
  _i11.Uniques forceCreate({
    required int collection,
    required _i12.MultiAddress owner,
    required bool freeHolding,
  }) {
    return _i11.Uniques(_i13.ForceCreate(
      collection: collection,
      owner: owner,
      freeHolding: freeHolding,
    ));
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
  _i11.Uniques destroy({
    required int collection,
    required _i14.DestroyWitness witness,
  }) {
    return _i11.Uniques(_i13.Destroy(
      collection: collection,
      witness: witness,
    ));
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
  _i11.Uniques mint({
    required int collection,
    required int item,
    required _i12.MultiAddress owner,
  }) {
    return _i11.Uniques(_i13.Mint(
      collection: collection,
      item: item,
      owner: owner,
    ));
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
  _i11.Uniques burn({
    required int collection,
    required int item,
    _i12.MultiAddress? checkOwner,
  }) {
    return _i11.Uniques(_i13.Burn(
      collection: collection,
      item: item,
      checkOwner: checkOwner,
    ));
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
  _i11.Uniques transfer({
    required int collection,
    required int item,
    required _i12.MultiAddress dest,
  }) {
    return _i11.Uniques(_i13.Transfer(
      collection: collection,
      item: item,
      dest: dest,
    ));
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
  _i11.Uniques redeposit({
    required int collection,
    required List<int> items,
  }) {
    return _i11.Uniques(_i13.Redeposit(
      collection: collection,
      items: items,
    ));
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
  _i11.Uniques freeze({
    required int collection,
    required int item,
  }) {
    return _i11.Uniques(_i13.Freeze(
      collection: collection,
      item: item,
    ));
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
  _i11.Uniques thaw({
    required int collection,
    required int item,
  }) {
    return _i11.Uniques(_i13.Thaw(
      collection: collection,
      item: item,
    ));
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
  _i11.Uniques freezeCollection({required int collection}) {
    return _i11.Uniques(_i13.FreezeCollection(collection: collection));
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
  _i11.Uniques thawCollection({required int collection}) {
    return _i11.Uniques(_i13.ThawCollection(collection: collection));
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
  _i11.Uniques transferOwnership({
    required int collection,
    required _i12.MultiAddress newOwner,
  }) {
    return _i11.Uniques(_i13.TransferOwnership(
      collection: collection,
      newOwner: newOwner,
    ));
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
  _i11.Uniques setTeam({
    required int collection,
    required _i12.MultiAddress issuer,
    required _i12.MultiAddress admin,
    required _i12.MultiAddress freezer,
  }) {
    return _i11.Uniques(_i13.SetTeam(
      collection: collection,
      issuer: issuer,
      admin: admin,
      freezer: freezer,
    ));
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
  _i11.Uniques approveTransfer({
    required int collection,
    required int item,
    required _i12.MultiAddress delegate,
  }) {
    return _i11.Uniques(_i13.ApproveTransfer(
      collection: collection,
      item: item,
      delegate: delegate,
    ));
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
  _i11.Uniques cancelApproval({
    required int collection,
    required int item,
    _i12.MultiAddress? maybeCheckDelegate,
  }) {
    return _i11.Uniques(_i13.CancelApproval(
      collection: collection,
      item: item,
      maybeCheckDelegate: maybeCheckDelegate,
    ));
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
  _i11.Uniques forceItemStatus({
    required int collection,
    required _i12.MultiAddress owner,
    required _i12.MultiAddress issuer,
    required _i12.MultiAddress admin,
    required _i12.MultiAddress freezer,
    required bool freeHolding,
    required bool isFrozen,
  }) {
    return _i11.Uniques(_i13.ForceItemStatus(
      collection: collection,
      owner: owner,
      issuer: issuer,
      admin: admin,
      freezer: freezer,
      freeHolding: freeHolding,
      isFrozen: isFrozen,
    ));
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
  _i11.Uniques setAttribute({
    required int collection,
    int? maybeItem,
    required List<int> key,
    required List<int> value,
  }) {
    return _i11.Uniques(_i13.SetAttribute(
      collection: collection,
      maybeItem: maybeItem,
      key: key,
      value: value,
    ));
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
  _i11.Uniques clearAttribute({
    required int collection,
    int? maybeItem,
    required List<int> key,
  }) {
    return _i11.Uniques(_i13.ClearAttribute(
      collection: collection,
      maybeItem: maybeItem,
      key: key,
    ));
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
  _i11.Uniques setMetadata({
    required int collection,
    required int item,
    required List<int> data,
    required bool isFrozen,
  }) {
    return _i11.Uniques(_i13.SetMetadata(
      collection: collection,
      item: item,
      data: data,
      isFrozen: isFrozen,
    ));
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
  _i11.Uniques clearMetadata({
    required int collection,
    required int item,
  }) {
    return _i11.Uniques(_i13.ClearMetadata(
      collection: collection,
      item: item,
    ));
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
  _i11.Uniques setCollectionMetadata({
    required int collection,
    required List<int> data,
    required bool isFrozen,
  }) {
    return _i11.Uniques(_i13.SetCollectionMetadata(
      collection: collection,
      data: data,
      isFrozen: isFrozen,
    ));
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
  _i11.Uniques clearCollectionMetadata({required int collection}) {
    return _i11.Uniques(_i13.ClearCollectionMetadata(collection: collection));
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
  _i11.Uniques setAcceptOwnership({int? maybeCollection}) {
    return _i11.Uniques(_i13.SetAcceptOwnership(maybeCollection: maybeCollection));
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
  _i11.Uniques setCollectionMaxSupply({
    required int collection,
    required int maxSupply,
  }) {
    return _i11.Uniques(_i13.SetCollectionMaxSupply(
      collection: collection,
      maxSupply: maxSupply,
    ));
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
  _i11.Uniques setPrice({
    required int collection,
    required int item,
    BigInt? price,
    _i12.MultiAddress? whitelistedBuyer,
  }) {
    return _i11.Uniques(_i13.SetPrice(
      collection: collection,
      item: item,
      price: price,
      whitelistedBuyer: whitelistedBuyer,
    ));
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
  _i11.Uniques buyItem({
    required int collection,
    required int item,
    required BigInt bidPrice,
  }) {
    return _i11.Uniques(_i13.BuyItem(
      collection: collection,
      item: item,
      bidPrice: bidPrice,
    ));
  }
}

class Constants {
  Constants();

  /// The basic amount of funds that must be reserved for collection.
  final BigInt collectionDeposit = BigInt.from(100000000000);

  /// The basic amount of funds that must be reserved for an item.
  final BigInt itemDeposit = BigInt.from(1000000000);

  /// The basic amount of funds that must be reserved when adding metadata to your item.
  final BigInt metadataDepositBase = BigInt.from(6709666617);

  /// The basic amount of funds that must be reserved when adding an attribute to an item.
  final BigInt attributeDepositBase = BigInt.from(6666666660);

  /// The additional funds that must be reserved for the number of bytes store in metadata,
  /// either "normal" metadata or attribute metadata.
  final BigInt depositPerByte = BigInt.from(333333);

  /// The maximum length of data stored on-chain.
  final int stringLimit = 128;

  /// The maximum length of an attribute key.
  final int keyLimit = 32;

  /// The maximum length of an attribute value.
  final int valueLimit = 64;
}
