// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:typed_data' as _i8;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i5;

import '../types/cumulus_pallet_dmp_queue/config_data.dart' as _i2;
import '../types/cumulus_pallet_dmp_queue/page_index_data.dart' as _i3;
import '../types/cumulus_pallet_dmp_queue/pallet/call.dart' as _i10;
import '../types/encointer_runtime/runtime_call.dart' as _i9;
import '../types/sp_weights/weight_v2/weight.dart' as _i7;
import '../types/tuples.dart' as _i4;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<_i2.ConfigData> _configuration = const _i1.StorageValue<_i2.ConfigData>(
    prefix: 'DmpQueue',
    storage: 'Configuration',
    valueCodec: _i2.ConfigData.codec,
  );

  final _i1.StorageValue<_i3.PageIndexData> _pageIndex = const _i1.StorageValue<_i3.PageIndexData>(
    prefix: 'DmpQueue',
    storage: 'PageIndex',
    valueCodec: _i3.PageIndexData.codec,
  );

  final _i1.StorageMap<int, List<_i4.Tuple2<int, List<int>>>> _pages =
      const _i1.StorageMap<int, List<_i4.Tuple2<int, List<int>>>>(
    prefix: 'DmpQueue',
    storage: 'Pages',
    valueCodec: _i5.SequenceCodec<_i4.Tuple2<int, List<int>>>(_i4.Tuple2Codec<int, List<int>>(
      _i5.U32Codec.codec,
      _i5.U8SequenceCodec.codec,
    )),
    hasher: _i1.StorageHasher.blake2b128Concat(_i5.U32Codec.codec),
  );

  final _i1.StorageMap<BigInt, _i4.Tuple2<int, List<int>>> _overweight =
      const _i1.StorageMap<BigInt, _i4.Tuple2<int, List<int>>>(
    prefix: 'DmpQueue',
    storage: 'Overweight',
    valueCodec: _i4.Tuple2Codec<int, List<int>>(
      _i5.U32Codec.codec,
      _i5.U8SequenceCodec.codec,
    ),
    hasher: _i1.StorageHasher.blake2b128Concat(_i5.U64Codec.codec),
  );

  final _i1.StorageValue<int> _counterForOverweight = const _i1.StorageValue<int>(
    prefix: 'DmpQueue',
    storage: 'CounterForOverweight',
    valueCodec: _i5.U32Codec.codec,
  );

  /// The configuration.
  _i6.Future<_i2.ConfigData> configuration({_i1.BlockHash? at}) async {
    final hashedKey = _configuration.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _configuration.decodeValue(bytes);
    }
    return _i2.ConfigData(
        maxIndividual: _i7.Weight(
      refTime: BigInt.from(10000000000),
      proofSize: BigInt.from(65536),
    )); /* Default */
  }

  /// The page index.
  _i6.Future<_i3.PageIndexData> pageIndex({_i1.BlockHash? at}) async {
    final hashedKey = _pageIndex.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _pageIndex.decodeValue(bytes);
    }
    return _i3.PageIndexData(
      beginUsed: 0,
      endUsed: 0,
      overweightCount: BigInt.zero,
    ); /* Default */
  }

  /// The queue pages.
  _i6.Future<List<_i4.Tuple2<int, List<int>>>> pages(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _pages.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _pages.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The overweight messages.
  _i6.Future<_i4.Tuple2<int, List<int>>?> overweight(
    BigInt key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _overweight.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _overweight.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Counter for the related counted storage map
  _i6.Future<int> counterForOverweight({_i1.BlockHash? at}) async {
    final hashedKey = _counterForOverweight.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _counterForOverweight.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Returns the storage key for `configuration`.
  _i8.Uint8List configurationKey() {
    final hashedKey = _configuration.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `pageIndex`.
  _i8.Uint8List pageIndexKey() {
    final hashedKey = _pageIndex.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `pages`.
  _i8.Uint8List pagesKey(int key1) {
    final hashedKey = _pages.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `overweight`.
  _i8.Uint8List overweightKey(BigInt key1) {
    final hashedKey = _overweight.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `counterForOverweight`.
  _i8.Uint8List counterForOverweightKey() {
    final hashedKey = _counterForOverweight.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `pages`.
  _i8.Uint8List pagesMapPrefix() {
    final hashedKey = _pages.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `overweight`.
  _i8.Uint8List overweightMapPrefix() {
    final hashedKey = _overweight.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// See [`Pallet::service_overweight`].
  _i9.RuntimeCall serviceOverweight({
    required index,
    required weightLimit,
  }) {
    final _call = _i10.Call.values.serviceOverweight(
      index: index,
      weightLimit: weightLimit,
    );
    return _i9.RuntimeCall.values.dmpQueue(_call);
  }
}
