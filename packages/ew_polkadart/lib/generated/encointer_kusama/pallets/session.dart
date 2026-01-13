// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i9;
import 'dart:typed_data' as _i10;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i4;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/encointer_kusama_runtime/runtime_call.dart' as _i11;
import '../types/encointer_kusama_runtime/session_keys.dart' as _i6;
import '../types/pallet_session/pallet/call.dart' as _i12;
import '../types/sp_core/crypto/account_id32.dart' as _i3;
import '../types/sp_core/crypto/key_type_id.dart' as _i8;
import '../types/sp_staking/offence/offence_severity.dart' as _i7;
import '../types/tuples.dart' as _i5;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageValue<List<_i3.AccountId32>> _validators = const _i2.StorageValue<List<_i3.AccountId32>>(
    prefix: 'Session',
    storage: 'Validators',
    valueCodec: _i4.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec()),
  );

  final _i2.StorageValue<int> _currentIndex = const _i2.StorageValue<int>(
    prefix: 'Session',
    storage: 'CurrentIndex',
    valueCodec: _i4.U32Codec.codec,
  );

  final _i2.StorageValue<bool> _queuedChanged = const _i2.StorageValue<bool>(
    prefix: 'Session',
    storage: 'QueuedChanged',
    valueCodec: _i4.BoolCodec.codec,
  );

  final _i2.StorageValue<List<_i5.Tuple2<_i3.AccountId32, _i6.SessionKeys>>> _queuedKeys =
      const _i2.StorageValue<List<_i5.Tuple2<_i3.AccountId32, _i6.SessionKeys>>>(
    prefix: 'Session',
    storage: 'QueuedKeys',
    valueCodec: _i4.SequenceCodec<_i5.Tuple2<_i3.AccountId32, _i6.SessionKeys>>(
        _i5.Tuple2Codec<_i3.AccountId32, _i6.SessionKeys>(
      _i3.AccountId32Codec(),
      _i6.SessionKeys.codec,
    )),
  );

  final _i2.StorageValue<List<_i5.Tuple2<int, _i7.OffenceSeverity>>> _disabledValidators =
      const _i2.StorageValue<List<_i5.Tuple2<int, _i7.OffenceSeverity>>>(
    prefix: 'Session',
    storage: 'DisabledValidators',
    valueCodec: _i4.SequenceCodec<_i5.Tuple2<int, _i7.OffenceSeverity>>(_i5.Tuple2Codec<int, _i7.OffenceSeverity>(
      _i4.U32Codec.codec,
      _i7.OffenceSeverityCodec(),
    )),
  );

  final _i2.StorageMap<_i3.AccountId32, _i6.SessionKeys> _nextKeys =
      const _i2.StorageMap<_i3.AccountId32, _i6.SessionKeys>(
    prefix: 'Session',
    storage: 'NextKeys',
    valueCodec: _i6.SessionKeys.codec,
    hasher: _i2.StorageHasher.twoxx64Concat(_i3.AccountId32Codec()),
  );

  final _i2.StorageMap<_i5.Tuple2<_i8.KeyTypeId, List<int>>, _i3.AccountId32> _keyOwner =
      const _i2.StorageMap<_i5.Tuple2<_i8.KeyTypeId, List<int>>, _i3.AccountId32>(
    prefix: 'Session',
    storage: 'KeyOwner',
    valueCodec: _i3.AccountId32Codec(),
    hasher: _i2.StorageHasher.twoxx64Concat(_i5.Tuple2Codec<_i8.KeyTypeId, List<int>>(
      _i8.KeyTypeIdCodec(),
      _i4.U8SequenceCodec.codec,
    )),
  );

  /// The current set of validators.
  _i9.Future<List<_i3.AccountId32>> validators({_i1.BlockHash? at}) async {
    final hashedKey = _validators.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _validators.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Current index of the session.
  _i9.Future<int> currentIndex({_i1.BlockHash? at}) async {
    final hashedKey = _currentIndex.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _currentIndex.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// True if the underlying economic identities or weighting behind the validators
  /// has changed in the queued validator set.
  _i9.Future<bool> queuedChanged({_i1.BlockHash? at}) async {
    final hashedKey = _queuedChanged.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _queuedChanged.decodeValue(bytes);
    }
    return false; /* Default */
  }

  /// The queued keys for the next session. When the next session begins, these keys
  /// will be used to determine the validator's session keys.
  _i9.Future<List<_i5.Tuple2<_i3.AccountId32, _i6.SessionKeys>>> queuedKeys({_i1.BlockHash? at}) async {
    final hashedKey = _queuedKeys.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _queuedKeys.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Indices of disabled validators.
  ///
  /// The vec is always kept sorted so that we can find whether a given validator is
  /// disabled using binary search. It gets cleared when `on_session_ending` returns
  /// a new set of identities.
  _i9.Future<List<_i5.Tuple2<int, _i7.OffenceSeverity>>> disabledValidators({_i1.BlockHash? at}) async {
    final hashedKey = _disabledValidators.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _disabledValidators.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The next session keys for a validator.
  _i9.Future<_i6.SessionKeys?> nextKeys(
    _i3.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _nextKeys.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nextKeys.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The owner of a key. The key is the `KeyTypeId` + the encoded key.
  _i9.Future<_i3.AccountId32?> keyOwner(
    _i5.Tuple2<_i8.KeyTypeId, List<int>> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _keyOwner.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _keyOwner.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The next session keys for a validator.
  _i9.Future<List<_i6.SessionKeys?>> multiNextKeys(
    List<_i3.AccountId32> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _nextKeys.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _nextKeys.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// The owner of a key. The key is the `KeyTypeId` + the encoded key.
  _i9.Future<List<_i3.AccountId32?>> multiKeyOwner(
    List<_i5.Tuple2<_i8.KeyTypeId, List<int>>> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _keyOwner.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _keyOwner.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// Returns the storage key for `validators`.
  _i10.Uint8List validatorsKey() {
    final hashedKey = _validators.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `currentIndex`.
  _i10.Uint8List currentIndexKey() {
    final hashedKey = _currentIndex.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `queuedChanged`.
  _i10.Uint8List queuedChangedKey() {
    final hashedKey = _queuedChanged.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `queuedKeys`.
  _i10.Uint8List queuedKeysKey() {
    final hashedKey = _queuedKeys.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `disabledValidators`.
  _i10.Uint8List disabledValidatorsKey() {
    final hashedKey = _disabledValidators.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `nextKeys`.
  _i10.Uint8List nextKeysKey(_i3.AccountId32 key1) {
    final hashedKey = _nextKeys.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `keyOwner`.
  _i10.Uint8List keyOwnerKey(_i5.Tuple2<_i8.KeyTypeId, List<int>> key1) {
    final hashedKey = _keyOwner.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `nextKeys`.
  _i10.Uint8List nextKeysMapPrefix() {
    final hashedKey = _nextKeys.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `keyOwner`.
  _i10.Uint8List keyOwnerMapPrefix() {
    final hashedKey = _keyOwner.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Sets the session key(s) of the function caller to `keys`.
  /// Allows an account to set its session key prior to becoming a validator.
  /// This doesn't take effect until the next session.
  ///
  /// The dispatch origin of this function must be signed.
  ///
  /// ## Complexity
  /// - `O(1)`. Actual cost depends on the number of length of `T::Keys::key_ids()` which is
  ///  fixed.
  _i11.Session setKeys({
    required _i6.SessionKeys keys,
    required List<int> proof,
  }) {
    return _i11.Session(_i12.SetKeys(
      keys: keys,
      proof: proof,
    ));
  }

  /// Removes any session key(s) of the function caller.
  ///
  /// This doesn't take effect until the next session.
  ///
  /// The dispatch origin of this function must be Signed and the account must be either be
  /// convertible to a validator ID using the chain's typical addressing system (this usually
  /// means being a controller account) or directly convertible into a validator ID (which
  /// usually means being a stash account).
  ///
  /// ## Complexity
  /// - `O(1)` in number of key types. Actual cost depends on the number of length of
  ///  `T::Keys::key_ids()` which is fixed.
  _i11.Session purgeKeys() {
    return _i11.Session(_i12.PurgeKeys());
  }
}

class Constants {
  Constants();

  /// The amount to be held when setting keys.
  final BigInt keyDeposit = BigInt.zero;
}
