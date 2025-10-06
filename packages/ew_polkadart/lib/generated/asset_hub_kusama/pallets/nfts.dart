// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i16;
import 'dart:typed_data' as _i17;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/asset_hub_kusama_runtime/runtime_call.dart' as _i18;
import '../types/bounded_collections/bounded_btree_set/bounded_b_tree_set_2.dart' as _i12;
import '../types/pallet_nfts/pallet/call.dart' as _i20;
import '../types/pallet_nfts/types/attribute_deposit.dart' as _i11;
import '../types/pallet_nfts/types/attribute_namespace.dart' as _i9;
import '../types/pallet_nfts/types/bit_flags_1.dart' as _i23;
import '../types/pallet_nfts/types/bit_flags_3.dart' as _i5;
import '../types/pallet_nfts/types/bit_flags_4.dart' as _i31;
import '../types/pallet_nfts/types/cancel_attributes_approval_witness.dart' as _i24;
import '../types/pallet_nfts/types/collection_config.dart' as _i14;
import '../types/pallet_nfts/types/collection_details.dart' as _i2;
import '../types/pallet_nfts/types/collection_metadata.dart' as _i7;
import '../types/pallet_nfts/types/destroy_witness.dart' as _i21;
import '../types/pallet_nfts/types/item_config.dart' as _i15;
import '../types/pallet_nfts/types/item_details.dart' as _i6;
import '../types/pallet_nfts/types/item_metadata.dart' as _i8;
import '../types/pallet_nfts/types/item_tip.dart' as _i26;
import '../types/pallet_nfts/types/mint_settings.dart' as _i25;
import '../types/pallet_nfts/types/mint_witness.dart' as _i22;
import '../types/pallet_nfts/types/pending_swap.dart' as _i13;
import '../types/pallet_nfts/types/pre_signed_attributes.dart' as _i30;
import '../types/pallet_nfts/types/pre_signed_mint.dart' as _i28;
import '../types/pallet_nfts/types/price_with_direction.dart' as _i27;
import '../types/sp_core/crypto/account_id32.dart' as _i4;
import '../types/sp_runtime/multi_signature.dart' as _i29;
import '../types/sp_runtime/multiaddress/multi_address.dart' as _i19;
import '../types/tuples.dart' as _i10;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<int, _i2.CollectionDetails> _collection = const _i1.StorageMap<int, _i2.CollectionDetails>(
    prefix: 'Nfts',
    storage: 'Collection',
    valueCodec: _i2.CollectionDetails.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageMap<_i4.AccountId32, int> _ownershipAcceptance = const _i1.StorageMap<_i4.AccountId32, int>(
    prefix: 'Nfts',
    storage: 'OwnershipAcceptance',
    valueCodec: _i3.U32Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i4.AccountId32Codec()),
  );

  final _i1.StorageTripleMap<_i4.AccountId32, int, int, dynamic> _account =
      const _i1.StorageTripleMap<_i4.AccountId32, int, int, dynamic>(
    prefix: 'Nfts',
    storage: 'Account',
    valueCodec: _i3.NullCodec.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i4.AccountId32Codec()),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
    hasher3: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageDoubleMap<_i4.AccountId32, int, dynamic> _collectionAccount =
      const _i1.StorageDoubleMap<_i4.AccountId32, int, dynamic>(
    prefix: 'Nfts',
    storage: 'CollectionAccount',
    valueCodec: _i3.NullCodec.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i4.AccountId32Codec()),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageDoubleMap<int, _i4.AccountId32, _i5.BitFlags> _collectionRoleOf =
      const _i1.StorageDoubleMap<int, _i4.AccountId32, _i5.BitFlags>(
    prefix: 'Nfts',
    storage: 'CollectionRoleOf',
    valueCodec: _i5.BitFlagsCodec(),
    hasher1: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i4.AccountId32Codec()),
  );

  final _i1.StorageDoubleMap<int, int, _i6.ItemDetails> _item = const _i1.StorageDoubleMap<int, int, _i6.ItemDetails>(
    prefix: 'Nfts',
    storage: 'Item',
    valueCodec: _i6.ItemDetails.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageMap<int, _i7.CollectionMetadata> _collectionMetadataOf =
      const _i1.StorageMap<int, _i7.CollectionMetadata>(
    prefix: 'Nfts',
    storage: 'CollectionMetadataOf',
    valueCodec: _i7.CollectionMetadata.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageDoubleMap<int, int, _i8.ItemMetadata> _itemMetadataOf =
      const _i1.StorageDoubleMap<int, int, _i8.ItemMetadata>(
    prefix: 'Nfts',
    storage: 'ItemMetadataOf',
    valueCodec: _i8.ItemMetadata.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1
      .StorageQuadrupleMap<int, int?, _i9.AttributeNamespace, List<int>, _i10.Tuple2<List<int>, _i11.AttributeDeposit>>
      _attribute = const _i1.StorageQuadrupleMap<int, int?, _i9.AttributeNamespace, List<int>,
          _i10.Tuple2<List<int>, _i11.AttributeDeposit>>(
    prefix: 'Nfts',
    storage: 'Attribute',
    valueCodec: _i10.Tuple2Codec<List<int>, _i11.AttributeDeposit>(
      _i3.U8SequenceCodec.codec,
      _i11.AttributeDeposit.codec,
    ),
    hasher1: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.OptionCodec<int>(_i3.U32Codec.codec)),
    hasher3: _i1.StorageHasher.blake2b128Concat(_i9.AttributeNamespace.codec),
    hasher4: _i1.StorageHasher.blake2b128Concat(_i3.U8SequenceCodec.codec),
  );

  final _i1.StorageDoubleMap<int, int, _i10.Tuple2<BigInt, _i4.AccountId32?>> _itemPriceOf =
      const _i1.StorageDoubleMap<int, int, _i10.Tuple2<BigInt, _i4.AccountId32?>>(
    prefix: 'Nfts',
    storage: 'ItemPriceOf',
    valueCodec: _i10.Tuple2Codec<BigInt, _i4.AccountId32?>(
      _i3.U128Codec.codec,
      _i3.OptionCodec<_i4.AccountId32>(_i4.AccountId32Codec()),
    ),
    hasher1: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageDoubleMap<int, int, _i12.BoundedBTreeSet> _itemAttributesApprovalsOf =
      const _i1.StorageDoubleMap<int, int, _i12.BoundedBTreeSet>(
    prefix: 'Nfts',
    storage: 'ItemAttributesApprovalsOf',
    valueCodec: _i12.BoundedBTreeSetCodec(),
    hasher1: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageValue<int> _nextCollectionId = const _i1.StorageValue<int>(
    prefix: 'Nfts',
    storage: 'NextCollectionId',
    valueCodec: _i3.U32Codec.codec,
  );

  final _i1.StorageDoubleMap<int, int, _i13.PendingSwap> _pendingSwapOf =
      const _i1.StorageDoubleMap<int, int, _i13.PendingSwap>(
    prefix: 'Nfts',
    storage: 'PendingSwapOf',
    valueCodec: _i13.PendingSwap.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageMap<int, _i14.CollectionConfig> _collectionConfigOf =
      const _i1.StorageMap<int, _i14.CollectionConfig>(
    prefix: 'Nfts',
    storage: 'CollectionConfigOf',
    valueCodec: _i14.CollectionConfig.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageDoubleMap<int, int, _i15.ItemConfig> _itemConfigOf =
      const _i1.StorageDoubleMap<int, int, _i15.ItemConfig>(
    prefix: 'Nfts',
    storage: 'ItemConfigOf',
    valueCodec: _i15.ItemConfig.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  /// Details of a collection.
  _i16.Future<_i2.CollectionDetails?> collection(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _collection.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _collection.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The collection, if any, of which an account is willing to take ownership.
  _i16.Future<int?> ownershipAcceptance(
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
  _i16.Future<dynamic> account(
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
  _i16.Future<dynamic> collectionAccount(
    _i4.AccountId32 key1,
    int key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _collectionAccount.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _collectionAccount.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The items in existence and their ownership details.
  /// Stores collection roles as per account.
  _i16.Future<_i5.BitFlags?> collectionRoleOf(
    int key1,
    _i4.AccountId32 key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _collectionRoleOf.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _collectionRoleOf.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The items in existence and their ownership details.
  _i16.Future<_i6.ItemDetails?> item(
    int key1,
    int key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _item.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _item.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Metadata of a collection.
  _i16.Future<_i7.CollectionMetadata?> collectionMetadataOf(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _collectionMetadataOf.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _collectionMetadataOf.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Metadata of an item.
  _i16.Future<_i8.ItemMetadata?> itemMetadataOf(
    int key1,
    int key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _itemMetadataOf.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _itemMetadataOf.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Attributes of a collection.
  _i16.Future<_i10.Tuple2<List<int>, _i11.AttributeDeposit>?> attribute(
    int key1,
    int? key2,
    _i9.AttributeNamespace key3,
    List<int> key4, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _attribute.hashedKeyFor(
      key1,
      key2,
      key3,
      key4,
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

  /// A price of an item.
  _i16.Future<_i10.Tuple2<BigInt, _i4.AccountId32?>?> itemPriceOf(
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

  /// Item attribute approvals.
  _i16.Future<_i12.BoundedBTreeSet> itemAttributesApprovalsOf(
    int key1,
    int key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _itemAttributesApprovalsOf.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _itemAttributesApprovalsOf.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Stores the `CollectionId` that is going to be used for the next collection.
  /// This gets incremented whenever a new collection is created.
  _i16.Future<int?> nextCollectionId({_i1.BlockHash? at}) async {
    final hashedKey = _nextCollectionId.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nextCollectionId.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Handles all the pending swaps.
  _i16.Future<_i13.PendingSwap?> pendingSwapOf(
    int key1,
    int key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _pendingSwapOf.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _pendingSwapOf.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Config of a collection.
  _i16.Future<_i14.CollectionConfig?> collectionConfigOf(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _collectionConfigOf.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _collectionConfigOf.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Config of an item.
  _i16.Future<_i15.ItemConfig?> itemConfigOf(
    int key1,
    int key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _itemConfigOf.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _itemConfigOf.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Details of a collection.
  _i16.Future<List<_i2.CollectionDetails?>> multiCollection(
    List<int> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _collection.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _collection.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// The collection, if any, of which an account is willing to take ownership.
  _i16.Future<List<int?>> multiOwnershipAcceptance(
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
  _i16.Future<List<_i7.CollectionMetadata?>> multiCollectionMetadataOf(
    List<int> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _collectionMetadataOf.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _collectionMetadataOf.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// Config of a collection.
  _i16.Future<List<_i14.CollectionConfig?>> multiCollectionConfigOf(
    List<int> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _collectionConfigOf.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _collectionConfigOf.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// Returns the storage key for `collection`.
  _i17.Uint8List collectionKey(int key1) {
    final hashedKey = _collection.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `ownershipAcceptance`.
  _i17.Uint8List ownershipAcceptanceKey(_i4.AccountId32 key1) {
    final hashedKey = _ownershipAcceptance.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `account`.
  _i17.Uint8List accountKey(
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

  /// Returns the storage key for `collectionAccount`.
  _i17.Uint8List collectionAccountKey(
    _i4.AccountId32 key1,
    int key2,
  ) {
    final hashedKey = _collectionAccount.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `collectionRoleOf`.
  _i17.Uint8List collectionRoleOfKey(
    int key1,
    _i4.AccountId32 key2,
  ) {
    final hashedKey = _collectionRoleOf.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `item`.
  _i17.Uint8List itemKey(
    int key1,
    int key2,
  ) {
    final hashedKey = _item.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `collectionMetadataOf`.
  _i17.Uint8List collectionMetadataOfKey(int key1) {
    final hashedKey = _collectionMetadataOf.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `itemMetadataOf`.
  _i17.Uint8List itemMetadataOfKey(
    int key1,
    int key2,
  ) {
    final hashedKey = _itemMetadataOf.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `attribute`.
  _i17.Uint8List attributeKey(
    int key1,
    int? key2,
    _i9.AttributeNamespace key3,
    List<int> key4,
  ) {
    final hashedKey = _attribute.hashedKeyFor(
      key1,
      key2,
      key3,
      key4,
    );
    return hashedKey;
  }

  /// Returns the storage key for `itemPriceOf`.
  _i17.Uint8List itemPriceOfKey(
    int key1,
    int key2,
  ) {
    final hashedKey = _itemPriceOf.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `itemAttributesApprovalsOf`.
  _i17.Uint8List itemAttributesApprovalsOfKey(
    int key1,
    int key2,
  ) {
    final hashedKey = _itemAttributesApprovalsOf.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `nextCollectionId`.
  _i17.Uint8List nextCollectionIdKey() {
    final hashedKey = _nextCollectionId.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `pendingSwapOf`.
  _i17.Uint8List pendingSwapOfKey(
    int key1,
    int key2,
  ) {
    final hashedKey = _pendingSwapOf.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `collectionConfigOf`.
  _i17.Uint8List collectionConfigOfKey(int key1) {
    final hashedKey = _collectionConfigOf.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `itemConfigOf`.
  _i17.Uint8List itemConfigOfKey(
    int key1,
    int key2,
  ) {
    final hashedKey = _itemConfigOf.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage map key prefix for `collection`.
  _i17.Uint8List collectionMapPrefix() {
    final hashedKey = _collection.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `ownershipAcceptance`.
  _i17.Uint8List ownershipAcceptanceMapPrefix() {
    final hashedKey = _ownershipAcceptance.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `collectionAccount`.
  _i17.Uint8List collectionAccountMapPrefix(_i4.AccountId32 key1) {
    final hashedKey = _collectionAccount.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `collectionRoleOf`.
  _i17.Uint8List collectionRoleOfMapPrefix(int key1) {
    final hashedKey = _collectionRoleOf.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `item`.
  _i17.Uint8List itemMapPrefix(int key1) {
    final hashedKey = _item.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `collectionMetadataOf`.
  _i17.Uint8List collectionMetadataOfMapPrefix() {
    final hashedKey = _collectionMetadataOf.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `itemMetadataOf`.
  _i17.Uint8List itemMetadataOfMapPrefix(int key1) {
    final hashedKey = _itemMetadataOf.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `itemPriceOf`.
  _i17.Uint8List itemPriceOfMapPrefix(int key1) {
    final hashedKey = _itemPriceOf.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `itemAttributesApprovalsOf`.
  _i17.Uint8List itemAttributesApprovalsOfMapPrefix(int key1) {
    final hashedKey = _itemAttributesApprovalsOf.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `pendingSwapOf`.
  _i17.Uint8List pendingSwapOfMapPrefix(int key1) {
    final hashedKey = _pendingSwapOf.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `collectionConfigOf`.
  _i17.Uint8List collectionConfigOfMapPrefix() {
    final hashedKey = _collectionConfigOf.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `itemConfigOf`.
  _i17.Uint8List itemConfigOfMapPrefix(int key1) {
    final hashedKey = _itemConfigOf.mapPrefix(key1);
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Issue a new collection of non-fungible items from a public origin.
  ///
  /// This new collection has no items initially and its owner is the origin.
  ///
  /// The origin must be Signed and the sender must have sufficient funds free.
  ///
  /// `CollectionDeposit` funds of sender are reserved.
  ///
  /// Parameters:
  /// - `admin`: The admin of this collection. The admin is the initial address of each
  /// member of the collection's admin team.
  ///
  /// Emits `Created` event when successful.
  ///
  /// Weight: `O(1)`
  _i18.Nfts create({
    required _i19.MultiAddress admin,
    required _i14.CollectionConfig config,
  }) {
    return _i18.Nfts(_i20.Create(
      admin: admin,
      config: config,
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
  /// - `owner`: The owner of this collection of items. The owner has full superuser
  ///  permissions over this item, but may later change and configure the permissions using
  ///  `transfer_ownership` and `set_team`.
  ///
  /// Emits `ForceCreated` event when successful.
  ///
  /// Weight: `O(1)`
  _i18.Nfts forceCreate({
    required _i19.MultiAddress owner,
    required _i14.CollectionConfig config,
  }) {
    return _i18.Nfts(_i20.ForceCreate(
      owner: owner,
      config: config,
    ));
  }

  /// Destroy a collection of fungible items.
  ///
  /// The origin must conform to `ForceOrigin` or must be `Signed` and the sender must be the
  /// owner of the `collection`.
  ///
  /// NOTE: The collection must have 0 items to be destroyed.
  ///
  /// - `collection`: The identifier of the collection to be destroyed.
  /// - `witness`: Information on the items minted in the collection. This must be
  /// correct.
  ///
  /// Emits `Destroyed` event when successful.
  ///
  /// Weight: `O(m + c + a)` where:
  /// - `m = witness.item_metadatas`
  /// - `c = witness.item_configs`
  /// - `a = witness.attributes`
  _i18.Nfts destroy({
    required int collection,
    required _i21.DestroyWitness witness,
  }) {
    return _i18.Nfts(_i20.Destroy(
      collection: collection,
      witness: witness,
    ));
  }

  /// Mint an item of a particular collection.
  ///
  /// The origin must be Signed and the sender must comply with the `mint_settings` rules.
  ///
  /// - `collection`: The collection of the item to be minted.
  /// - `item`: An identifier of the new item.
  /// - `mint_to`: Account into which the item will be minted.
  /// - `witness_data`: When the mint type is `HolderOf(collection_id)`, then the owned
  ///  item_id from that collection needs to be provided within the witness data object. If
  ///  the mint price is set, then it should be additionally confirmed in the `witness_data`.
  ///
  /// Note: the deposit will be taken from the `origin` and not the `owner` of the `item`.
  ///
  /// Emits `Issued` event when successful.
  ///
  /// Weight: `O(1)`
  _i18.Nfts mint({
    required int collection,
    required int item,
    required _i19.MultiAddress mintTo,
    _i22.MintWitness? witnessData,
  }) {
    return _i18.Nfts(_i20.Mint(
      collection: collection,
      item: item,
      mintTo: mintTo,
      witnessData: witnessData,
    ));
  }

  /// Mint an item of a particular collection from a privileged origin.
  ///
  /// The origin must conform to `ForceOrigin` or must be `Signed` and the sender must be the
  /// Issuer of the `collection`.
  ///
  /// - `collection`: The collection of the item to be minted.
  /// - `item`: An identifier of the new item.
  /// - `mint_to`: Account into which the item will be minted.
  /// - `item_config`: A config of the new item.
  ///
  /// Emits `Issued` event when successful.
  ///
  /// Weight: `O(1)`
  _i18.Nfts forceMint({
    required int collection,
    required int item,
    required _i19.MultiAddress mintTo,
    required _i15.ItemConfig itemConfig,
  }) {
    return _i18.Nfts(_i20.ForceMint(
      collection: collection,
      item: item,
      mintTo: mintTo,
      itemConfig: itemConfig,
    ));
  }

  /// Destroy a single item.
  ///
  /// The origin must conform to `ForceOrigin` or must be Signed and the signing account must
  /// be the owner of the `item`.
  ///
  /// - `collection`: The collection of the item to be burned.
  /// - `item`: The item to be burned.
  ///
  /// Emits `Burned`.
  ///
  /// Weight: `O(1)`
  _i18.Nfts burn({
    required int collection,
    required int item,
  }) {
    return _i18.Nfts(_i20.Burn(
      collection: collection,
      item: item,
    ));
  }

  /// Move an item from the sender account to another.
  ///
  /// Origin must be Signed and the signing account must be either:
  /// - the Owner of the `item`;
  /// - the approved delegate for the `item` (in this case, the approval is reset).
  ///
  /// Arguments:
  /// - `collection`: The collection of the item to be transferred.
  /// - `item`: The item to be transferred.
  /// - `dest`: The account to receive ownership of the item.
  ///
  /// Emits `Transferred`.
  ///
  /// Weight: `O(1)`
  _i18.Nfts transfer({
    required int collection,
    required int item,
    required _i19.MultiAddress dest,
  }) {
    return _i18.Nfts(_i20.Transfer(
      collection: collection,
      item: item,
      dest: dest,
    ));
  }

  /// Re-evaluate the deposits on some items.
  ///
  /// Origin must be Signed and the sender should be the Owner of the `collection`.
  ///
  /// - `collection`: The collection of the items to be reevaluated.
  /// - `items`: The items of the collection whose deposits will be reevaluated.
  ///
  /// NOTE: This exists as a best-effort function. Any items which are unknown or
  /// in the case that the owner account does not have reservable funds to pay for a
  /// deposit increase are ignored. Generally the owner isn't going to call this on items
  /// whose existing deposit is less than the refreshed deposit as it would only cost them,
  /// so it's of little consequence.
  ///
  /// It will still return an error in the case that the collection is unknown or the signer
  /// is not permitted to call it.
  ///
  /// Weight: `O(items.len())`
  _i18.Nfts redeposit({
    required int collection,
    required List<int> items,
  }) {
    return _i18.Nfts(_i20.Redeposit(
      collection: collection,
      items: items,
    ));
  }

  /// Disallow further unprivileged transfer of an item.
  ///
  /// Origin must be Signed and the sender should be the Freezer of the `collection`.
  ///
  /// - `collection`: The collection of the item to be changed.
  /// - `item`: The item to become non-transferable.
  ///
  /// Emits `ItemTransferLocked`.
  ///
  /// Weight: `O(1)`
  _i18.Nfts lockItemTransfer({
    required int collection,
    required int item,
  }) {
    return _i18.Nfts(_i20.LockItemTransfer(
      collection: collection,
      item: item,
    ));
  }

  /// Re-allow unprivileged transfer of an item.
  ///
  /// Origin must be Signed and the sender should be the Freezer of the `collection`.
  ///
  /// - `collection`: The collection of the item to be changed.
  /// - `item`: The item to become transferable.
  ///
  /// Emits `ItemTransferUnlocked`.
  ///
  /// Weight: `O(1)`
  _i18.Nfts unlockItemTransfer({
    required int collection,
    required int item,
  }) {
    return _i18.Nfts(_i20.UnlockItemTransfer(
      collection: collection,
      item: item,
    ));
  }

  /// Disallows specified settings for the whole collection.
  ///
  /// Origin must be Signed and the sender should be the Owner of the `collection`.
  ///
  /// - `collection`: The collection to be locked.
  /// - `lock_settings`: The settings to be locked.
  ///
  /// Note: it's possible to only lock(set) the setting, but not to unset it.
  ///
  /// Emits `CollectionLocked`.
  ///
  /// Weight: `O(1)`
  _i18.Nfts lockCollection({
    required int collection,
    required _i23.BitFlags lockSettings,
  }) {
    return _i18.Nfts(_i20.LockCollection(
      collection: collection,
      lockSettings: lockSettings,
    ));
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
  _i18.Nfts transferOwnership({
    required int collection,
    required _i19.MultiAddress newOwner,
  }) {
    return _i18.Nfts(_i20.TransferOwnership(
      collection: collection,
      newOwner: newOwner,
    ));
  }

  /// Change the Issuer, Admin and Freezer of a collection.
  ///
  /// Origin must be either `ForceOrigin` or Signed and the sender should be the Owner of the
  /// `collection`.
  ///
  /// Note: by setting the role to `None` only the `ForceOrigin` will be able to change it
  /// after to `Some(account)`.
  ///
  /// - `collection`: The collection whose team should be changed.
  /// - `issuer`: The new Issuer of this collection.
  /// - `admin`: The new Admin of this collection.
  /// - `freezer`: The new Freezer of this collection.
  ///
  /// Emits `TeamChanged`.
  ///
  /// Weight: `O(1)`
  _i18.Nfts setTeam({
    required int collection,
    _i19.MultiAddress? issuer,
    _i19.MultiAddress? admin,
    _i19.MultiAddress? freezer,
  }) {
    return _i18.Nfts(_i20.SetTeam(
      collection: collection,
      issuer: issuer,
      admin: admin,
      freezer: freezer,
    ));
  }

  /// Change the Owner of a collection.
  ///
  /// Origin must be `ForceOrigin`.
  ///
  /// - `collection`: The identifier of the collection.
  /// - `owner`: The new Owner of this collection.
  ///
  /// Emits `OwnerChanged`.
  ///
  /// Weight: `O(1)`
  _i18.Nfts forceCollectionOwner({
    required int collection,
    required _i19.MultiAddress owner,
  }) {
    return _i18.Nfts(_i20.ForceCollectionOwner(
      collection: collection,
      owner: owner,
    ));
  }

  /// Change the config of a collection.
  ///
  /// Origin must be `ForceOrigin`.
  ///
  /// - `collection`: The identifier of the collection.
  /// - `config`: The new config of this collection.
  ///
  /// Emits `CollectionConfigChanged`.
  ///
  /// Weight: `O(1)`
  _i18.Nfts forceCollectionConfig({
    required int collection,
    required _i14.CollectionConfig config,
  }) {
    return _i18.Nfts(_i20.ForceCollectionConfig(
      collection: collection,
      config: config,
    ));
  }

  /// Approve an item to be transferred by a delegated third-party account.
  ///
  /// Origin must be either `ForceOrigin` or Signed and the sender should be the Owner of the
  /// `item`.
  ///
  /// - `collection`: The collection of the item to be approved for delegated transfer.
  /// - `item`: The item to be approved for delegated transfer.
  /// - `delegate`: The account to delegate permission to transfer the item.
  /// - `maybe_deadline`: Optional deadline for the approval. Specified by providing the
  /// 	number of blocks after which the approval will expire
  ///
  /// Emits `TransferApproved` on success.
  ///
  /// Weight: `O(1)`
  _i18.Nfts approveTransfer({
    required int collection,
    required int item,
    required _i19.MultiAddress delegate,
    int? maybeDeadline,
  }) {
    return _i18.Nfts(_i20.ApproveTransfer(
      collection: collection,
      item: item,
      delegate: delegate,
      maybeDeadline: maybeDeadline,
    ));
  }

  /// Cancel one of the transfer approvals for a specific item.
  ///
  /// Origin must be either:
  /// - the `Force` origin;
  /// - `Signed` with the signer being the Owner of the `item`;
  ///
  /// Arguments:
  /// - `collection`: The collection of the item of whose approval will be cancelled.
  /// - `item`: The item of the collection of whose approval will be cancelled.
  /// - `delegate`: The account that is going to loose their approval.
  ///
  /// Emits `ApprovalCancelled` on success.
  ///
  /// Weight: `O(1)`
  _i18.Nfts cancelApproval({
    required int collection,
    required int item,
    required _i19.MultiAddress delegate,
  }) {
    return _i18.Nfts(_i20.CancelApproval(
      collection: collection,
      item: item,
      delegate: delegate,
    ));
  }

  /// Cancel all the approvals of a specific item.
  ///
  /// Origin must be either:
  /// - the `Force` origin;
  /// - `Signed` with the signer being the Owner of the `item`;
  ///
  /// Arguments:
  /// - `collection`: The collection of the item of whose approvals will be cleared.
  /// - `item`: The item of the collection of whose approvals will be cleared.
  ///
  /// Emits `AllApprovalsCancelled` on success.
  ///
  /// Weight: `O(1)`
  _i18.Nfts clearAllTransferApprovals({
    required int collection,
    required int item,
  }) {
    return _i18.Nfts(_i20.ClearAllTransferApprovals(
      collection: collection,
      item: item,
    ));
  }

  /// Disallows changing the metadata or attributes of the item.
  ///
  /// Origin must be either `ForceOrigin` or Signed and the sender should be the Admin
  /// of the `collection`.
  ///
  /// - `collection`: The collection if the `item`.
  /// - `item`: An item to be locked.
  /// - `lock_metadata`: Specifies whether the metadata should be locked.
  /// - `lock_attributes`: Specifies whether the attributes in the `CollectionOwner` namespace
  ///  should be locked.
  ///
  /// Note: `lock_attributes` affects the attributes in the `CollectionOwner` namespace only.
  /// When the metadata or attributes are locked, it won't be possible the unlock them.
  ///
  /// Emits `ItemPropertiesLocked`.
  ///
  /// Weight: `O(1)`
  _i18.Nfts lockItemProperties({
    required int collection,
    required int item,
    required bool lockMetadata,
    required bool lockAttributes,
  }) {
    return _i18.Nfts(_i20.LockItemProperties(
      collection: collection,
      item: item,
      lockMetadata: lockMetadata,
      lockAttributes: lockAttributes,
    ));
  }

  /// Set an attribute for a collection or item.
  ///
  /// Origin must be Signed and must conform to the namespace ruleset:
  /// - `CollectionOwner` namespace could be modified by the `collection` Admin only;
  /// - `ItemOwner` namespace could be modified by the `maybe_item` owner only. `maybe_item`
  ///  should be set in that case;
  /// - `Account(AccountId)` namespace could be modified only when the `origin` was given a
  ///  permission to do so;
  ///
  /// The funds of `origin` are reserved according to the formula:
  /// `AttributeDepositBase + DepositPerByte * (key.len + value.len)` taking into
  /// account any already reserved funds.
  ///
  /// - `collection`: The identifier of the collection whose item's metadata to set.
  /// - `maybe_item`: The identifier of the item whose metadata to set.
  /// - `namespace`: Attribute's namespace.
  /// - `key`: The key of the attribute.
  /// - `value`: The value to which to set the attribute.
  ///
  /// Emits `AttributeSet`.
  ///
  /// Weight: `O(1)`
  _i18.Nfts setAttribute({
    required int collection,
    int? maybeItem,
    required _i9.AttributeNamespace namespace,
    required List<int> key,
    required List<int> value,
  }) {
    return _i18.Nfts(_i20.SetAttribute(
      collection: collection,
      maybeItem: maybeItem,
      namespace: namespace,
      key: key,
      value: value,
    ));
  }

  /// Force-set an attribute for a collection or item.
  ///
  /// Origin must be `ForceOrigin`.
  ///
  /// If the attribute already exists and it was set by another account, the deposit
  /// will be returned to the previous owner.
  ///
  /// - `set_as`: An optional owner of the attribute.
  /// - `collection`: The identifier of the collection whose item's metadata to set.
  /// - `maybe_item`: The identifier of the item whose metadata to set.
  /// - `namespace`: Attribute's namespace.
  /// - `key`: The key of the attribute.
  /// - `value`: The value to which to set the attribute.
  ///
  /// Emits `AttributeSet`.
  ///
  /// Weight: `O(1)`
  _i18.Nfts forceSetAttribute({
    _i4.AccountId32? setAs,
    required int collection,
    int? maybeItem,
    required _i9.AttributeNamespace namespace,
    required List<int> key,
    required List<int> value,
  }) {
    return _i18.Nfts(_i20.ForceSetAttribute(
      setAs: setAs,
      collection: collection,
      maybeItem: maybeItem,
      namespace: namespace,
      key: key,
      value: value,
    ));
  }

  /// Clear an attribute for a collection or item.
  ///
  /// Origin must be either `ForceOrigin` or Signed and the sender should be the Owner of the
  /// attribute.
  ///
  /// Any deposit is freed for the collection's owner.
  ///
  /// - `collection`: The identifier of the collection whose item's metadata to clear.
  /// - `maybe_item`: The identifier of the item whose metadata to clear.
  /// - `namespace`: Attribute's namespace.
  /// - `key`: The key of the attribute.
  ///
  /// Emits `AttributeCleared`.
  ///
  /// Weight: `O(1)`
  _i18.Nfts clearAttribute({
    required int collection,
    int? maybeItem,
    required _i9.AttributeNamespace namespace,
    required List<int> key,
  }) {
    return _i18.Nfts(_i20.ClearAttribute(
      collection: collection,
      maybeItem: maybeItem,
      namespace: namespace,
      key: key,
    ));
  }

  /// Approve item's attributes to be changed by a delegated third-party account.
  ///
  /// Origin must be Signed and must be an owner of the `item`.
  ///
  /// - `collection`: A collection of the item.
  /// - `item`: The item that holds attributes.
  /// - `delegate`: The account to delegate permission to change attributes of the item.
  ///
  /// Emits `ItemAttributesApprovalAdded` on success.
  _i18.Nfts approveItemAttributes({
    required int collection,
    required int item,
    required _i19.MultiAddress delegate,
  }) {
    return _i18.Nfts(_i20.ApproveItemAttributes(
      collection: collection,
      item: item,
      delegate: delegate,
    ));
  }

  /// Cancel the previously provided approval to change item's attributes.
  /// All the previously set attributes by the `delegate` will be removed.
  ///
  /// Origin must be Signed and must be an owner of the `item`.
  ///
  /// - `collection`: Collection that the item is contained within.
  /// - `item`: The item that holds attributes.
  /// - `delegate`: The previously approved account to remove.
  ///
  /// Emits `ItemAttributesApprovalRemoved` on success.
  _i18.Nfts cancelItemAttributesApproval({
    required int collection,
    required int item,
    required _i19.MultiAddress delegate,
    required _i24.CancelAttributesApprovalWitness witness,
  }) {
    return _i18.Nfts(_i20.CancelItemAttributesApproval(
      collection: collection,
      item: item,
      delegate: delegate,
      witness: witness,
    ));
  }

  /// Set the metadata for an item.
  ///
  /// Origin must be either `ForceOrigin` or Signed and the sender should be the Admin of the
  /// `collection`.
  ///
  /// If the origin is Signed, then funds of signer are reserved according to the formula:
  /// `MetadataDepositBase + DepositPerByte * data.len` taking into
  /// account any already reserved funds.
  ///
  /// - `collection`: The identifier of the collection whose item's metadata to set.
  /// - `item`: The identifier of the item whose metadata to set.
  /// - `data`: The general information of this item. Limited in length by `StringLimit`.
  ///
  /// Emits `ItemMetadataSet`.
  ///
  /// Weight: `O(1)`
  _i18.Nfts setMetadata({
    required int collection,
    required int item,
    required List<int> data,
  }) {
    return _i18.Nfts(_i20.SetMetadata(
      collection: collection,
      item: item,
      data: data,
    ));
  }

  /// Clear the metadata for an item.
  ///
  /// Origin must be either `ForceOrigin` or Signed and the sender should be the Admin of the
  /// `collection`.
  ///
  /// Any deposit is freed for the collection's owner.
  ///
  /// - `collection`: The identifier of the collection whose item's metadata to clear.
  /// - `item`: The identifier of the item whose metadata to clear.
  ///
  /// Emits `ItemMetadataCleared`.
  ///
  /// Weight: `O(1)`
  _i18.Nfts clearMetadata({
    required int collection,
    required int item,
  }) {
    return _i18.Nfts(_i20.ClearMetadata(
      collection: collection,
      item: item,
    ));
  }

  /// Set the metadata for a collection.
  ///
  /// Origin must be either `ForceOrigin` or `Signed` and the sender should be the Admin of
  /// the `collection`.
  ///
  /// If the origin is `Signed`, then funds of signer are reserved according to the formula:
  /// `MetadataDepositBase + DepositPerByte * data.len` taking into
  /// account any already reserved funds.
  ///
  /// - `collection`: The identifier of the item whose metadata to update.
  /// - `data`: The general information of this item. Limited in length by `StringLimit`.
  ///
  /// Emits `CollectionMetadataSet`.
  ///
  /// Weight: `O(1)`
  _i18.Nfts setCollectionMetadata({
    required int collection,
    required List<int> data,
  }) {
    return _i18.Nfts(_i20.SetCollectionMetadata(
      collection: collection,
      data: data,
    ));
  }

  /// Clear the metadata for a collection.
  ///
  /// Origin must be either `ForceOrigin` or `Signed` and the sender should be the Admin of
  /// the `collection`.
  ///
  /// Any deposit is freed for the collection's owner.
  ///
  /// - `collection`: The identifier of the collection whose metadata to clear.
  ///
  /// Emits `CollectionMetadataCleared`.
  ///
  /// Weight: `O(1)`
  _i18.Nfts clearCollectionMetadata({required int collection}) {
    return _i18.Nfts(_i20.ClearCollectionMetadata(collection: collection));
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
  _i18.Nfts setAcceptOwnership({int? maybeCollection}) {
    return _i18.Nfts(_i20.SetAcceptOwnership(maybeCollection: maybeCollection));
  }

  /// Set the maximum number of items a collection could have.
  ///
  /// Origin must be either `ForceOrigin` or `Signed` and the sender should be the Owner of
  /// the `collection`.
  ///
  /// - `collection`: The identifier of the collection to change.
  /// - `max_supply`: The maximum number of items a collection could have.
  ///
  /// Emits `CollectionMaxSupplySet` event when successful.
  _i18.Nfts setCollectionMaxSupply({
    required int collection,
    required int maxSupply,
  }) {
    return _i18.Nfts(_i20.SetCollectionMaxSupply(
      collection: collection,
      maxSupply: maxSupply,
    ));
  }

  /// Update mint settings.
  ///
  /// Origin must be either `ForceOrigin` or `Signed` and the sender should be the Issuer
  /// of the `collection`.
  ///
  /// - `collection`: The identifier of the collection to change.
  /// - `mint_settings`: The new mint settings.
  ///
  /// Emits `CollectionMintSettingsUpdated` event when successful.
  _i18.Nfts updateMintSettings({
    required int collection,
    required _i25.MintSettings mintSettings,
  }) {
    return _i18.Nfts(_i20.UpdateMintSettings(
      collection: collection,
      mintSettings: mintSettings,
    ));
  }

  /// Set (or reset) the price for an item.
  ///
  /// Origin must be Signed and must be the owner of the `item`.
  ///
  /// - `collection`: The collection of the item.
  /// - `item`: The item to set the price for.
  /// - `price`: The price for the item. Pass `None`, to reset the price.
  /// - `buyer`: Restricts the buy operation to a specific account.
  ///
  /// Emits `ItemPriceSet` on success if the price is not `None`.
  /// Emits `ItemPriceRemoved` on success if the price is `None`.
  _i18.Nfts setPrice({
    required int collection,
    required int item,
    BigInt? price,
    _i19.MultiAddress? whitelistedBuyer,
  }) {
    return _i18.Nfts(_i20.SetPrice(
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
  _i18.Nfts buyItem({
    required int collection,
    required int item,
    required BigInt bidPrice,
  }) {
    return _i18.Nfts(_i20.BuyItem(
      collection: collection,
      item: item,
      bidPrice: bidPrice,
    ));
  }

  /// Allows to pay the tips.
  ///
  /// Origin must be Signed.
  ///
  /// - `tips`: Tips array.
  ///
  /// Emits `TipSent` on every tip transfer.
  _i18.Nfts payTips({required List<_i26.ItemTip> tips}) {
    return _i18.Nfts(_i20.PayTips(tips: tips));
  }

  /// Register a new atomic swap, declaring an intention to send an `item` in exchange for
  /// `desired_item` from origin to target on the current blockchain.
  /// The target can execute the swap during the specified `duration` of blocks (if set).
  /// Additionally, the price could be set for the desired `item`.
  ///
  /// Origin must be Signed and must be an owner of the `item`.
  ///
  /// - `collection`: The collection of the item.
  /// - `item`: The item an owner wants to give.
  /// - `desired_collection`: The collection of the desired item.
  /// - `desired_item`: The desired item an owner wants to receive.
  /// - `maybe_price`: The price an owner is willing to pay or receive for the desired `item`.
  /// - `duration`: A deadline for the swap. Specified by providing the number of blocks
  /// 	after which the swap will expire.
  ///
  /// Emits `SwapCreated` on success.
  _i18.Nfts createSwap({
    required int offeredCollection,
    required int offeredItem,
    required int desiredCollection,
    int? maybeDesiredItem,
    _i27.PriceWithDirection? maybePrice,
    required int duration,
  }) {
    return _i18.Nfts(_i20.CreateSwap(
      offeredCollection: offeredCollection,
      offeredItem: offeredItem,
      desiredCollection: desiredCollection,
      maybeDesiredItem: maybeDesiredItem,
      maybePrice: maybePrice,
      duration: duration,
    ));
  }

  /// Cancel an atomic swap.
  ///
  /// Origin must be Signed.
  /// Origin must be an owner of the `item` if the deadline hasn't expired.
  ///
  /// - `collection`: The collection of the item.
  /// - `item`: The item an owner wants to give.
  ///
  /// Emits `SwapCancelled` on success.
  _i18.Nfts cancelSwap({
    required int offeredCollection,
    required int offeredItem,
  }) {
    return _i18.Nfts(_i20.CancelSwap(
      offeredCollection: offeredCollection,
      offeredItem: offeredItem,
    ));
  }

  /// Claim an atomic swap.
  /// This method executes a pending swap, that was created by a counterpart before.
  ///
  /// Origin must be Signed and must be an owner of the `item`.
  ///
  /// - `send_collection`: The collection of the item to be sent.
  /// - `send_item`: The item to be sent.
  /// - `receive_collection`: The collection of the item to be received.
  /// - `receive_item`: The item to be received.
  /// - `witness_price`: A price that was previously agreed on.
  ///
  /// Emits `SwapClaimed` on success.
  _i18.Nfts claimSwap({
    required int sendCollection,
    required int sendItem,
    required int receiveCollection,
    required int receiveItem,
    _i27.PriceWithDirection? witnessPrice,
  }) {
    return _i18.Nfts(_i20.ClaimSwap(
      sendCollection: sendCollection,
      sendItem: sendItem,
      receiveCollection: receiveCollection,
      receiveItem: receiveItem,
      witnessPrice: witnessPrice,
    ));
  }

  /// Mint an item by providing the pre-signed approval.
  ///
  /// Origin must be Signed.
  ///
  /// - `mint_data`: The pre-signed approval that consists of the information about the item,
  ///  its metadata, attributes, who can mint it (`None` for anyone) and until what block
  ///  number.
  /// - `signature`: The signature of the `data` object.
  /// - `signer`: The `data` object's signer. Should be an Issuer of the collection.
  ///
  /// Emits `Issued` on success.
  /// Emits `AttributeSet` if the attributes were provided.
  /// Emits `ItemMetadataSet` if the metadata was not empty.
  _i18.Nfts mintPreSigned({
    required _i28.PreSignedMint mintData,
    required _i29.MultiSignature signature,
    required _i4.AccountId32 signer,
  }) {
    return _i18.Nfts(_i20.MintPreSigned(
      mintData: mintData,
      signature: signature,
      signer: signer,
    ));
  }

  /// Set attributes for an item by providing the pre-signed approval.
  ///
  /// Origin must be Signed and must be an owner of the `data.item`.
  ///
  /// - `data`: The pre-signed approval that consists of the information about the item,
  ///  attributes to update and until what block number.
  /// - `signature`: The signature of the `data` object.
  /// - `signer`: The `data` object's signer. Should be an Admin of the collection for the
  ///  `CollectionOwner` namespace.
  ///
  /// Emits `AttributeSet` for each provided attribute.
  /// Emits `ItemAttributesApprovalAdded` if the approval wasn't set before.
  /// Emits `PreSignedAttributesSet` on success.
  _i18.Nfts setAttributesPreSigned({
    required _i30.PreSignedAttributes data,
    required _i29.MultiSignature signature,
    required _i4.AccountId32 signer,
  }) {
    return _i18.Nfts(_i20.SetAttributesPreSigned(
      data: data,
      signature: signature,
      signer: signer,
    ));
  }
}

class Constants {
  Constants();

  /// The basic amount of funds that must be reserved for collection.
  final BigInt collectionDeposit = BigInt.from(6709999950);

  /// The basic amount of funds that must be reserved for an item.
  final BigInt itemDeposit = BigInt.from(168033331);

  /// The basic amount of funds that must be reserved when adding metadata to your item.
  final BigInt metadataDepositBase = BigInt.from(670966661);

  /// The basic amount of funds that must be reserved when adding an attribute to an item.
  final BigInt attributeDepositBase = BigInt.from(666666666);

  /// The additional funds that must be reserved for the number of bytes store in metadata,
  /// either "normal" metadata or attribute metadata.
  final BigInt depositPerByte = BigInt.from(333333);

  /// The maximum length of data stored on-chain.
  final int stringLimit = 256;

  /// The maximum length of an attribute key.
  final int keyLimit = 64;

  /// The maximum length of an attribute value.
  final int valueLimit = 256;

  /// The maximum approvals an item could have.
  final int approvalsLimit = 20;

  /// The maximum attributes approvals an item could have.
  final int itemAttributesApprovalsLimit = 30;

  /// The max number of tips a user could send.
  final int maxTips = 10;

  /// The max duration in blocks for deadlines.
  final int maxDeadlineDuration = 5184000;

  /// The max number of attributes a user could set per call.
  final int maxAttributesPerCall = 10;

  /// Disables some of pallet's features.
  final _i31.BitFlags features = BigInt.zero;
}
