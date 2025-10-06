// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i9;
import 'dart:typed_data' as _i10;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/asset_hub_kusama_runtime/runtime_call.dart' as _i11;
import '../types/pallet_revive/pallet/call.dart' as _i12;
import '../types/pallet_revive/storage/account_info.dart' as _i6;
import '../types/pallet_revive/storage/deletion_queue_manager.dart' as _i7;
import '../types/pallet_revive/vm/code_info.dart' as _i4;
import '../types/primitive_types/h160.dart' as _i5;
import '../types/primitive_types/h256.dart' as _i2;
import '../types/primitive_types/u256.dart' as _i14;
import '../types/sp_arithmetic/per_things/perbill.dart' as _i15;
import '../types/sp_core/crypto/account_id32.dart' as _i8;
import '../types/sp_weights/weight_v2/weight.dart' as _i13;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.H256, List<int>> _pristineCode = const _i1.StorageMap<_i2.H256, List<int>>(
    prefix: 'Revive',
    storage: 'PristineCode',
    valueCodec: _i3.U8SequenceCodec.codec,
    hasher: _i1.StorageHasher.identity(_i2.H256Codec()),
  );

  final _i1.StorageMap<_i2.H256, _i4.CodeInfo> _codeInfoOf = const _i1.StorageMap<_i2.H256, _i4.CodeInfo>(
    prefix: 'Revive',
    storage: 'CodeInfoOf',
    valueCodec: _i4.CodeInfo.codec,
    hasher: _i1.StorageHasher.identity(_i2.H256Codec()),
  );

  final _i1.StorageMap<_i5.H160, _i6.AccountInfo> _accountInfoOf = const _i1.StorageMap<_i5.H160, _i6.AccountInfo>(
    prefix: 'Revive',
    storage: 'AccountInfoOf',
    valueCodec: _i6.AccountInfo.codec,
    hasher: _i1.StorageHasher.identity(_i5.H160Codec()),
  );

  final _i1.StorageMap<_i5.H160, List<int>> _immutableDataOf = const _i1.StorageMap<_i5.H160, List<int>>(
    prefix: 'Revive',
    storage: 'ImmutableDataOf',
    valueCodec: _i3.U8SequenceCodec.codec,
    hasher: _i1.StorageHasher.identity(_i5.H160Codec()),
  );

  final _i1.StorageMap<int, List<int>> _deletionQueue = const _i1.StorageMap<int, List<int>>(
    prefix: 'Revive',
    storage: 'DeletionQueue',
    valueCodec: _i3.U8SequenceCodec.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageValue<_i7.DeletionQueueManager> _deletionQueueCounter =
      const _i1.StorageValue<_i7.DeletionQueueManager>(
    prefix: 'Revive',
    storage: 'DeletionQueueCounter',
    valueCodec: _i7.DeletionQueueManager.codec,
  );

  final _i1.StorageMap<_i5.H160, _i8.AccountId32> _originalAccount = const _i1.StorageMap<_i5.H160, _i8.AccountId32>(
    prefix: 'Revive',
    storage: 'OriginalAccount',
    valueCodec: _i8.AccountId32Codec(),
    hasher: _i1.StorageHasher.identity(_i5.H160Codec()),
  );

  /// A mapping from a contract's code hash to its code.
  _i9.Future<List<int>?> pristineCode(
    _i2.H256 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _pristineCode.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _pristineCode.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// A mapping from a contract's code hash to its code info.
  _i9.Future<_i4.CodeInfo?> codeInfoOf(
    _i2.H256 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _codeInfoOf.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _codeInfoOf.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The data associated to a contract or externally owned account.
  _i9.Future<_i6.AccountInfo?> accountInfoOf(
    _i5.H160 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _accountInfoOf.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _accountInfoOf.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The immutable data associated with a given account.
  _i9.Future<List<int>?> immutableDataOf(
    _i5.H160 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _immutableDataOf.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _immutableDataOf.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Evicted contracts that await child trie deletion.
  ///
  /// Child trie deletion is a heavy operation depending on the amount of storage items
  /// stored in said trie. Therefore this operation is performed lazily in `on_idle`.
  _i9.Future<List<int>?> deletionQueue(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _deletionQueue.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _deletionQueue.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// A pair of monotonic counters used to track the latest contract marked for deletion
  /// and the latest deleted contract in queue.
  _i9.Future<_i7.DeletionQueueManager> deletionQueueCounter({_i1.BlockHash? at}) async {
    final hashedKey = _deletionQueueCounter.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _deletionQueueCounter.decodeValue(bytes);
    }
    return _i7.DeletionQueueManager(
      insertCounter: 0,
      deleteCounter: 0,
    ); /* Default */
  }

  /// Map a Ethereum address to its original `AccountId32`.
  ///
  /// When deriving a `H160` from an `AccountId32` we use a hash function. In order to
  /// reconstruct the original account we need to store the reverse mapping here.
  /// Register your `AccountId32` using [`Pallet::map_account`] in order to
  /// use it with this pallet.
  _i9.Future<_i8.AccountId32?> originalAccount(
    _i5.H160 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _originalAccount.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _originalAccount.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// A mapping from a contract's code hash to its code.
  _i9.Future<List<List<int>?>> multiPristineCode(
    List<_i2.H256> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _pristineCode.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _pristineCode.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// A mapping from a contract's code hash to its code info.
  _i9.Future<List<_i4.CodeInfo?>> multiCodeInfoOf(
    List<_i2.H256> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _codeInfoOf.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _codeInfoOf.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// The data associated to a contract or externally owned account.
  _i9.Future<List<_i6.AccountInfo?>> multiAccountInfoOf(
    List<_i5.H160> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _accountInfoOf.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _accountInfoOf.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// The immutable data associated with a given account.
  _i9.Future<List<List<int>?>> multiImmutableDataOf(
    List<_i5.H160> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _immutableDataOf.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _immutableDataOf.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// Evicted contracts that await child trie deletion.
  ///
  /// Child trie deletion is a heavy operation depending on the amount of storage items
  /// stored in said trie. Therefore this operation is performed lazily in `on_idle`.
  _i9.Future<List<List<int>?>> multiDeletionQueue(
    List<int> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _deletionQueue.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _deletionQueue.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// Map a Ethereum address to its original `AccountId32`.
  ///
  /// When deriving a `H160` from an `AccountId32` we use a hash function. In order to
  /// reconstruct the original account we need to store the reverse mapping here.
  /// Register your `AccountId32` using [`Pallet::map_account`] in order to
  /// use it with this pallet.
  _i9.Future<List<_i8.AccountId32?>> multiOriginalAccount(
    List<_i5.H160> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _originalAccount.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _originalAccount.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// Returns the storage key for `pristineCode`.
  _i10.Uint8List pristineCodeKey(_i2.H256 key1) {
    final hashedKey = _pristineCode.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `codeInfoOf`.
  _i10.Uint8List codeInfoOfKey(_i2.H256 key1) {
    final hashedKey = _codeInfoOf.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `accountInfoOf`.
  _i10.Uint8List accountInfoOfKey(_i5.H160 key1) {
    final hashedKey = _accountInfoOf.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `immutableDataOf`.
  _i10.Uint8List immutableDataOfKey(_i5.H160 key1) {
    final hashedKey = _immutableDataOf.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `deletionQueue`.
  _i10.Uint8List deletionQueueKey(int key1) {
    final hashedKey = _deletionQueue.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `deletionQueueCounter`.
  _i10.Uint8List deletionQueueCounterKey() {
    final hashedKey = _deletionQueueCounter.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `originalAccount`.
  _i10.Uint8List originalAccountKey(_i5.H160 key1) {
    final hashedKey = _originalAccount.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `pristineCode`.
  _i10.Uint8List pristineCodeMapPrefix() {
    final hashedKey = _pristineCode.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `codeInfoOf`.
  _i10.Uint8List codeInfoOfMapPrefix() {
    final hashedKey = _codeInfoOf.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `accountInfoOf`.
  _i10.Uint8List accountInfoOfMapPrefix() {
    final hashedKey = _accountInfoOf.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `immutableDataOf`.
  _i10.Uint8List immutableDataOfMapPrefix() {
    final hashedKey = _immutableDataOf.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `deletionQueue`.
  _i10.Uint8List deletionQueueMapPrefix() {
    final hashedKey = _deletionQueue.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `originalAccount`.
  _i10.Uint8List originalAccountMapPrefix() {
    final hashedKey = _originalAccount.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// A raw EVM transaction, typically dispatched by an Ethereum JSON-RPC server.
  ///
  /// # Parameters
  ///
  /// * `payload`: The encoded [`crate::evm::TransactionSigned`].
  /// * `gas_limit`: The gas limit enforced during contract execution.
  /// * `storage_deposit_limit`: The maximum balance that can be charged to the caller for
  ///  storage usage.
  ///
  /// # Note
  ///
  /// This call cannot be dispatched directly; attempting to do so will result in a failed
  /// transaction. It serves as a wrapper for an Ethereum transaction. When submitted, the
  /// runtime converts it into a [`sp_runtime::generic::CheckedExtrinsic`] by recovering the
  /// signer and validating the transaction.
  _i11.Revive ethTransact({required List<int> payload}) {
    return _i11.Revive(_i12.EthTransact(payload: payload));
  }

  /// Makes a call to an account, optionally transferring some balance.
  ///
  /// # Parameters
  ///
  /// * `dest`: Address of the contract to call.
  /// * `value`: The balance to transfer from the `origin` to `dest`.
  /// * `gas_limit`: The gas limit enforced when executing the constructor.
  /// * `storage_deposit_limit`: The maximum amount of balance that can be charged from the
  ///  caller to pay for the storage consumed.
  /// * `data`: The input data to pass to the contract.
  ///
  /// * If the account is a smart-contract account, the associated code will be
  /// executed and any value will be transferred.
  /// * If the account is a regular account, any value will be transferred.
  /// * If no account exists and the call value is not less than `existential_deposit`,
  /// a regular account will be created and any value will be transferred.
  _i11.Revive callVariant({
    required _i5.H160 dest,
    required BigInt value,
    required _i13.Weight gasLimit,
    required BigInt storageDepositLimit,
    required List<int> data,
  }) {
    return _i11.Revive(_i12.CallVariant(
      dest: dest,
      value: value,
      gasLimit: gasLimit,
      storageDepositLimit: storageDepositLimit,
      data: data,
    ));
  }

  /// Instantiates a contract from a previously deployed vm binary.
  ///
  /// This function is identical to [`Self::instantiate_with_code`] but without the
  /// code deployment step. Instead, the `code_hash` of an on-chain deployed vm binary
  /// must be supplied.
  _i11.Revive instantiate({
    required BigInt value,
    required _i13.Weight gasLimit,
    required BigInt storageDepositLimit,
    required _i2.H256 codeHash,
    required List<int> data,
    List<int>? salt,
  }) {
    return _i11.Revive(_i12.Instantiate(
      value: value,
      gasLimit: gasLimit,
      storageDepositLimit: storageDepositLimit,
      codeHash: codeHash,
      data: data,
      salt: salt,
    ));
  }

  /// Instantiates a new contract from the supplied `code` optionally transferring
  /// some balance.
  ///
  /// This dispatchable has the same effect as calling [`Self::upload_code`] +
  /// [`Self::instantiate`]. Bundling them together provides efficiency gains. Please
  /// also check the documentation of [`Self::upload_code`].
  ///
  /// # Parameters
  ///
  /// * `value`: The balance to transfer from the `origin` to the newly created contract.
  /// * `gas_limit`: The gas limit enforced when executing the constructor.
  /// * `storage_deposit_limit`: The maximum amount of balance that can be charged/reserved
  ///  from the caller to pay for the storage consumed.
  /// * `code`: The contract code to deploy in raw bytes.
  /// * `data`: The input data to pass to the contract constructor.
  /// * `salt`: Used for the address derivation. If `Some` is supplied then `CREATE2`
  /// 	semantics are used. If `None` then `CRATE1` is used.
  ///
  ///
  /// Instantiation is executed as follows:
  ///
  /// - The supplied `code` is deployed, and a `code_hash` is created for that code.
  /// - If the `code_hash` already exists on the chain the underlying `code` will be shared.
  /// - The destination address is computed based on the sender, code_hash and the salt.
  /// - The smart-contract account is created at the computed address.
  /// - The `value` is transferred to the new account.
  /// - The `deploy` function is executed in the context of the newly-created account.
  _i11.Revive instantiateWithCode({
    required BigInt value,
    required _i13.Weight gasLimit,
    required BigInt storageDepositLimit,
    required List<int> code,
    required List<int> data,
    List<int>? salt,
  }) {
    return _i11.Revive(_i12.InstantiateWithCode(
      value: value,
      gasLimit: gasLimit,
      storageDepositLimit: storageDepositLimit,
      code: code,
      data: data,
      salt: salt,
    ));
  }

  /// Same as [`Self::instantiate_with_code`], but intended to be dispatched **only**
  /// by an EVM transaction through the EVM compatibility layer.
  ///
  /// Calling this dispatchable ensures that the origin's nonce is bumped only once,
  /// via the `CheckNonce` transaction extension. In contrast, [`Self::instantiate_with_code`]
  /// also bumps the nonce after contract instantiation, since it may be invoked multiple
  /// times within a batch call transaction.
  _i11.Revive ethInstantiateWithCode({
    required _i14.U256 value,
    required _i13.Weight gasLimit,
    required BigInt storageDepositLimit,
    required List<int> code,
    required List<int> data,
  }) {
    return _i11.Revive(_i12.EthInstantiateWithCode(
      value: value,
      gasLimit: gasLimit,
      storageDepositLimit: storageDepositLimit,
      code: code,
      data: data,
    ));
  }

  /// Same as [`Self::call`], but intended to be dispatched **only**
  /// by an EVM transaction through the EVM compatibility layer.
  _i11.Revive ethCall({
    required _i5.H160 dest,
    required _i14.U256 value,
    required _i13.Weight gasLimit,
    required BigInt storageDepositLimit,
    required List<int> data,
  }) {
    return _i11.Revive(_i12.EthCall(
      dest: dest,
      value: value,
      gasLimit: gasLimit,
      storageDepositLimit: storageDepositLimit,
      data: data,
    ));
  }

  /// Upload new `code` without instantiating a contract from it.
  ///
  /// If the code does not already exist a deposit is reserved from the caller
  /// and unreserved only when [`Self::remove_code`] is called. The size of the reserve
  /// depends on the size of the supplied `code`.
  ///
  /// # Note
  ///
  /// Anyone can instantiate a contract from any uploaded code and thus prevent its removal.
  /// To avoid this situation a constructor could employ access control so that it can
  /// only be instantiated by permissioned entities. The same is true when uploading
  /// through [`Self::instantiate_with_code`].
  _i11.Revive uploadCode({
    required List<int> code,
    required BigInt storageDepositLimit,
  }) {
    return _i11.Revive(_i12.UploadCode(
      code: code,
      storageDepositLimit: storageDepositLimit,
    ));
  }

  /// Remove the code stored under `code_hash` and refund the deposit to its owner.
  ///
  /// A code can only be removed by its original uploader (its owner) and only if it is
  /// not used by any contract.
  _i11.Revive removeCode({required _i2.H256 codeHash}) {
    return _i11.Revive(_i12.RemoveCode(codeHash: codeHash));
  }

  /// Privileged function that changes the code of an existing contract.
  ///
  /// This takes care of updating refcounts and all other necessary operations. Returns
  /// an error if either the `code_hash` or `dest` do not exist.
  ///
  /// # Note
  ///
  /// This does **not** change the address of the contract in question. This means
  /// that the contract address is no longer derived from its code hash after calling
  /// this dispatchable.
  _i11.Revive setCode({
    required _i5.H160 dest,
    required _i2.H256 codeHash,
  }) {
    return _i11.Revive(_i12.SetCode(
      dest: dest,
      codeHash: codeHash,
    ));
  }

  /// Register the callers account id so that it can be used in contract interactions.
  ///
  /// This will error if the origin is already mapped or is a eth native `Address20`. It will
  /// take a deposit that can be released by calling [`Self::unmap_account`].
  _i11.Revive mapAccount() {
    return _i11.Revive(_i12.MapAccount());
  }

  /// Unregister the callers account id in order to free the deposit.
  ///
  /// There is no reason to ever call this function other than freeing up the deposit.
  /// This is only useful when the account should no longer be used.
  _i11.Revive unmapAccount() {
    return _i11.Revive(_i12.UnmapAccount());
  }

  /// Dispatch an `call` with the origin set to the callers fallback address.
  ///
  /// Every `AccountId32` can control its corresponding fallback account. The fallback account
  /// is the `AccountId20` with the last 12 bytes set to `0xEE`. This is essentially a
  /// recovery function in case an `AccountId20` was used without creating a mapping first.
  _i11.Revive dispatchAsFallbackAccount({required _i11.RuntimeCall call}) {
    return _i11.Revive(_i12.DispatchAsFallbackAccount(call: call));
  }
}

class Constants {
  Constants();

  /// The amount of balance a caller has to pay for each byte of storage.
  ///
  /// # Note
  ///
  /// It is safe to change this value on a live chain as all refunds are pro rata.
  final BigInt depositPerByte = BigInt.from(333333);

  /// The amount of balance a caller has to pay for each storage item.
  ///
  /// # Note
  ///
  /// It is safe to change this value on a live chain as all refunds are pro rata.
  final BigInt depositPerItem = BigInt.from(6666666660);

  /// The percentage of the storage deposit that should be held for using a code hash.
  /// Instantiating a contract, protects the code from being removed. In order to prevent
  /// abuse these actions are protected with a percentage of the code deposit.
  final _i15.Perbill codeHashLockupDepositPercent = 300000000;

  /// Make contract callable functions marked as `#[unstable]` available.
  ///
  /// Contracts that use `#[unstable]` functions won't be able to be uploaded unless
  /// this is set to `true`. This is only meant for testnets and dev nodes in order to
  /// experiment with new features.
  ///
  /// # Warning
  ///
  /// Do **not** set to `true` on productions chains.
  final bool unsafeUnstableInterface = false;

  /// The [EIP-155](https://eips.ethereum.org/EIPS/eip-155) chain ID.
  ///
  /// This is a unique identifier assigned to each blockchain network,
  /// preventing replay attacks.
  final BigInt chainId = BigInt.from(420420418);

  /// The ratio between the decimal representation of the native token and the ETH token.
  final int nativeToEthRatio = 1000000;
}
