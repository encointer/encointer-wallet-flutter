// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:typed_data' as _i9;

import 'package:polkadart/polkadart.dart' as _i1;

import '../types/asset_hub_kusama_runtime/runtime_call.dart' as _i10;
import '../types/pallet_assets/pallet/call_2.dart' as _i12;
import '../types/pallet_assets/types/approval.dart' as _i6;
import '../types/pallet_assets/types/asset_account.dart' as _i5;
import '../types/pallet_assets/types/asset_details.dart' as _i3;
import '../types/pallet_assets/types/asset_metadata_2.dart' as _i7;
import '../types/sp_core/crypto/account_id32.dart' as _i4;
import '../types/sp_runtime/multiaddress/multi_address.dart' as _i11;
import '../types/staging_xcm/v5/location/location.dart' as _i2;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.Location, _i3.AssetDetails> _asset = const _i1.StorageMap<_i2.Location, _i3.AssetDetails>(
    prefix: 'ForeignAssets',
    storage: 'Asset',
    valueCodec: _i3.AssetDetails.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i2.Location.codec),
  );

  final _i1.StorageDoubleMap<_i2.Location, _i4.AccountId32, _i5.AssetAccount> _account =
      const _i1.StorageDoubleMap<_i2.Location, _i4.AccountId32, _i5.AssetAccount>(
    prefix: 'ForeignAssets',
    storage: 'Account',
    valueCodec: _i5.AssetAccount.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i2.Location.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i4.AccountId32Codec()),
  );

  final _i1.StorageTripleMap<_i2.Location, _i4.AccountId32, _i4.AccountId32, _i6.Approval> _approvals =
      const _i1.StorageTripleMap<_i2.Location, _i4.AccountId32, _i4.AccountId32, _i6.Approval>(
    prefix: 'ForeignAssets',
    storage: 'Approvals',
    valueCodec: _i6.Approval.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i2.Location.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i4.AccountId32Codec()),
    hasher3: _i1.StorageHasher.blake2b128Concat(_i4.AccountId32Codec()),
  );

  final _i1.StorageMap<_i2.Location, _i7.AssetMetadata> _metadata =
      const _i1.StorageMap<_i2.Location, _i7.AssetMetadata>(
    prefix: 'ForeignAssets',
    storage: 'Metadata',
    valueCodec: _i7.AssetMetadata.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i2.Location.codec),
  );

  final _i1.StorageValue<_i2.Location> _nextAssetId = const _i1.StorageValue<_i2.Location>(
    prefix: 'ForeignAssets',
    storage: 'NextAssetId',
    valueCodec: _i2.Location.codec,
  );

  /// Details of an asset.
  _i8.Future<_i3.AssetDetails?> asset(
    _i2.Location key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _asset.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _asset.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The holdings of a specific account for a specific asset.
  _i8.Future<_i5.AssetAccount?> account(
    _i2.Location key1,
    _i4.AccountId32 key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _account.hashedKeyFor(
      key1,
      key2,
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

  /// Approved balance transfers. First balance is the amount approved for transfer. Second
  /// is the amount of `T::Currency` reserved for storing this.
  /// First key is the asset ID, second key is the owner and third key is the delegate.
  _i8.Future<_i6.Approval?> approvals(
    _i2.Location key1,
    _i4.AccountId32 key2,
    _i4.AccountId32 key3, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _approvals.hashedKeyFor(
      key1,
      key2,
      key3,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _approvals.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Metadata of an asset.
  _i8.Future<_i7.AssetMetadata> metadata(
    _i2.Location key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _metadata.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _metadata.decodeValue(bytes);
    }
    return _i7.AssetMetadata(
      deposit: BigInt.zero,
      name: List<int>.filled(
        0,
        0,
        growable: true,
      ),
      symbol: List<int>.filled(
        0,
        0,
        growable: true,
      ),
      decimals: 0,
      isFrozen: false,
    ); /* Default */
  }

  /// The asset ID enforced for the next asset creation, if any present. Otherwise, this storage
  /// item has no effect.
  ///
  /// This can be useful for setting up constraints for IDs of the new assets. For example, by
  /// providing an initial [`NextAssetId`] and using the [`crate::AutoIncAssetId`] callback, an
  /// auto-increment model can be applied to all new asset IDs.
  ///
  /// The initial next asset ID can be set using the [`GenesisConfig`] or the
  /// [SetNextAssetId](`migration::next_asset_id::SetNextAssetId`) migration.
  _i8.Future<_i2.Location?> nextAssetId({_i1.BlockHash? at}) async {
    final hashedKey = _nextAssetId.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nextAssetId.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Details of an asset.
  _i8.Future<List<_i3.AssetDetails?>> multiAsset(
    List<_i2.Location> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _asset.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _asset.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// Metadata of an asset.
  _i8.Future<List<_i7.AssetMetadata>> multiMetadata(
    List<_i2.Location> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _metadata.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _metadata.decodeValue(v.key)).toList();
    }
    return keys
        .map((key) => _i7.AssetMetadata(
              deposit: BigInt.zero,
              name: List<int>.filled(
                0,
                0,
                growable: true,
              ),
              symbol: List<int>.filled(
                0,
                0,
                growable: true,
              ),
              decimals: 0,
              isFrozen: false,
            ))
        .toList(); /* Default */
  }

  /// Returns the storage key for `asset`.
  _i9.Uint8List assetKey(_i2.Location key1) {
    final hashedKey = _asset.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `account`.
  _i9.Uint8List accountKey(
    _i2.Location key1,
    _i4.AccountId32 key2,
  ) {
    final hashedKey = _account.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `approvals`.
  _i9.Uint8List approvalsKey(
    _i2.Location key1,
    _i4.AccountId32 key2,
    _i4.AccountId32 key3,
  ) {
    final hashedKey = _approvals.hashedKeyFor(
      key1,
      key2,
      key3,
    );
    return hashedKey;
  }

  /// Returns the storage key for `metadata`.
  _i9.Uint8List metadataKey(_i2.Location key1) {
    final hashedKey = _metadata.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `nextAssetId`.
  _i9.Uint8List nextAssetIdKey() {
    final hashedKey = _nextAssetId.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `asset`.
  _i9.Uint8List assetMapPrefix() {
    final hashedKey = _asset.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `account`.
  _i9.Uint8List accountMapPrefix(_i2.Location key1) {
    final hashedKey = _account.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `metadata`.
  _i9.Uint8List metadataMapPrefix() {
    final hashedKey = _metadata.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Issue a new class of fungible assets from a public origin.
  ///
  /// This new asset class has no assets initially and its owner is the origin.
  ///
  /// The origin must conform to the configured `CreateOrigin` and have sufficient funds free.
  ///
  /// Funds of sender are reserved by `AssetDeposit`.
  ///
  /// Parameters:
  /// - `id`: The identifier of the new asset. This must not be currently in use to identify
  /// an existing asset. If [`NextAssetId`] is set, then this must be equal to it.
  /// - `admin`: The admin of this class of assets. The admin is the initial address of each
  /// member of the asset class's admin team.
  /// - `min_balance`: The minimum balance of this new asset that any single account must
  /// have. If an account's balance is reduced below this, then it collapses to zero.
  ///
  /// Emits `Created` event when successful.
  ///
  /// Weight: `O(1)`
  _i10.ForeignAssets create({
    required _i2.Location id,
    required _i11.MultiAddress admin,
    required BigInt minBalance,
  }) {
    return _i10.ForeignAssets(_i12.Create(
      id: id,
      admin: admin,
      minBalance: minBalance,
    ));
  }

  /// Issue a new class of fungible assets from a privileged origin.
  ///
  /// This new asset class has no assets initially.
  ///
  /// The origin must conform to `ForceOrigin`.
  ///
  /// Unlike `create`, no funds are reserved.
  ///
  /// - `id`: The identifier of the new asset. This must not be currently in use to identify
  /// an existing asset. If [`NextAssetId`] is set, then this must be equal to it.
  /// - `owner`: The owner of this class of assets. The owner has full superuser permissions
  /// over this asset, but may later change and configure the permissions using
  /// `transfer_ownership` and `set_team`.
  /// - `min_balance`: The minimum balance of this new asset that any single account must
  /// have. If an account's balance is reduced below this, then it collapses to zero.
  ///
  /// Emits `ForceCreated` event when successful.
  ///
  /// Weight: `O(1)`
  _i10.ForeignAssets forceCreate({
    required _i2.Location id,
    required _i11.MultiAddress owner,
    required bool isSufficient,
    required BigInt minBalance,
  }) {
    return _i10.ForeignAssets(_i12.ForceCreate(
      id: id,
      owner: owner,
      isSufficient: isSufficient,
      minBalance: minBalance,
    ));
  }

  /// Start the process of destroying a fungible asset class.
  ///
  /// `start_destroy` is the first in a series of extrinsics that should be called, to allow
  /// destruction of an asset class.
  ///
  /// The origin must conform to `ForceOrigin` or must be `Signed` by the asset's `owner`.
  ///
  /// - `id`: The identifier of the asset to be destroyed. This must identify an existing
  ///  asset.
  ///
  /// It will fail with either [`Error::ContainsHolds`] or [`Error::ContainsFreezes`] if
  /// an account contains holds or freezes in place.
  _i10.ForeignAssets startDestroy({required _i2.Location id}) {
    return _i10.ForeignAssets(_i12.StartDestroy(id: id));
  }

  /// Destroy all accounts associated with a given asset.
  ///
  /// `destroy_accounts` should only be called after `start_destroy` has been called, and the
  /// asset is in a `Destroying` state.
  ///
  /// Due to weight restrictions, this function may need to be called multiple times to fully
  /// destroy all accounts. It will destroy `RemoveItemsLimit` accounts at a time.
  ///
  /// - `id`: The identifier of the asset to be destroyed. This must identify an existing
  ///  asset.
  ///
  /// Each call emits the `Event::DestroyedAccounts` event.
  _i10.ForeignAssets destroyAccounts({required _i2.Location id}) {
    return _i10.ForeignAssets(_i12.DestroyAccounts(id: id));
  }

  /// Destroy all approvals associated with a given asset up to the max (T::RemoveItemsLimit).
  ///
  /// `destroy_approvals` should only be called after `start_destroy` has been called, and the
  /// asset is in a `Destroying` state.
  ///
  /// Due to weight restrictions, this function may need to be called multiple times to fully
  /// destroy all approvals. It will destroy `RemoveItemsLimit` approvals at a time.
  ///
  /// - `id`: The identifier of the asset to be destroyed. This must identify an existing
  ///  asset.
  ///
  /// Each call emits the `Event::DestroyedApprovals` event.
  _i10.ForeignAssets destroyApprovals({required _i2.Location id}) {
    return _i10.ForeignAssets(_i12.DestroyApprovals(id: id));
  }

  /// Complete destroying asset and unreserve currency.
  ///
  /// `finish_destroy` should only be called after `start_destroy` has been called, and the
  /// asset is in a `Destroying` state. All accounts or approvals should be destroyed before
  /// hand.
  ///
  /// - `id`: The identifier of the asset to be destroyed. This must identify an existing
  ///  asset.
  ///
  /// Each successful call emits the `Event::Destroyed` event.
  _i10.ForeignAssets finishDestroy({required _i2.Location id}) {
    return _i10.ForeignAssets(_i12.FinishDestroy(id: id));
  }

  /// Mint assets of a particular class.
  ///
  /// The origin must be Signed and the sender must be the Issuer of the asset `id`.
  ///
  /// - `id`: The identifier of the asset to have some amount minted.
  /// - `beneficiary`: The account to be credited with the minted assets.
  /// - `amount`: The amount of the asset to be minted.
  ///
  /// Emits `Issued` event when successful.
  ///
  /// Weight: `O(1)`
  /// Modes: Pre-existing balance of `beneficiary`; Account pre-existence of `beneficiary`.
  _i10.ForeignAssets mint({
    required _i2.Location id,
    required _i11.MultiAddress beneficiary,
    required BigInt amount,
  }) {
    return _i10.ForeignAssets(_i12.Mint(
      id: id,
      beneficiary: beneficiary,
      amount: amount,
    ));
  }

  /// Reduce the balance of `who` by as much as possible up to `amount` assets of `id`.
  ///
  /// Origin must be Signed and the sender should be the Manager of the asset `id`.
  ///
  /// Bails with `NoAccount` if the `who` is already dead.
  ///
  /// - `id`: The identifier of the asset to have some amount burned.
  /// - `who`: The account to be debited from.
  /// - `amount`: The maximum amount by which `who`'s balance should be reduced.
  ///
  /// Emits `Burned` with the actual amount burned. If this takes the balance to below the
  /// minimum for the asset, then the amount burned is increased to take it to zero.
  ///
  /// Weight: `O(1)`
  /// Modes: Post-existence of `who`; Pre & post Zombie-status of `who`.
  _i10.ForeignAssets burn({
    required _i2.Location id,
    required _i11.MultiAddress who,
    required BigInt amount,
  }) {
    return _i10.ForeignAssets(_i12.Burn(
      id: id,
      who: who,
      amount: amount,
    ));
  }

  /// Move some assets from the sender account to another.
  ///
  /// Origin must be Signed.
  ///
  /// - `id`: The identifier of the asset to have some amount transferred.
  /// - `target`: The account to be credited.
  /// - `amount`: The amount by which the sender's balance of assets should be reduced and
  /// `target`'s balance increased. The amount actually transferred may be slightly greater in
  /// the case that the transfer would otherwise take the sender balance above zero but below
  /// the minimum balance. Must be greater than zero.
  ///
  /// Emits `Transferred` with the actual amount transferred. If this takes the source balance
  /// to below the minimum for the asset, then the amount transferred is increased to take it
  /// to zero.
  ///
  /// Weight: `O(1)`
  /// Modes: Pre-existence of `target`; Post-existence of sender; Account pre-existence of
  /// `target`.
  _i10.ForeignAssets transfer({
    required _i2.Location id,
    required _i11.MultiAddress target,
    required BigInt amount,
  }) {
    return _i10.ForeignAssets(_i12.Transfer(
      id: id,
      target: target,
      amount: amount,
    ));
  }

  /// Move some assets from the sender account to another, keeping the sender account alive.
  ///
  /// Origin must be Signed.
  ///
  /// - `id`: The identifier of the asset to have some amount transferred.
  /// - `target`: The account to be credited.
  /// - `amount`: The amount by which the sender's balance of assets should be reduced and
  /// `target`'s balance increased. The amount actually transferred may be slightly greater in
  /// the case that the transfer would otherwise take the sender balance above zero but below
  /// the minimum balance. Must be greater than zero.
  ///
  /// Emits `Transferred` with the actual amount transferred. If this takes the source balance
  /// to below the minimum for the asset, then the amount transferred is increased to take it
  /// to zero.
  ///
  /// Weight: `O(1)`
  /// Modes: Pre-existence of `target`; Post-existence of sender; Account pre-existence of
  /// `target`.
  _i10.ForeignAssets transferKeepAlive({
    required _i2.Location id,
    required _i11.MultiAddress target,
    required BigInt amount,
  }) {
    return _i10.ForeignAssets(_i12.TransferKeepAlive(
      id: id,
      target: target,
      amount: amount,
    ));
  }

  /// Move some assets from one account to another.
  ///
  /// Origin must be Signed and the sender should be the Admin of the asset `id`.
  ///
  /// - `id`: The identifier of the asset to have some amount transferred.
  /// - `source`: The account to be debited.
  /// - `dest`: The account to be credited.
  /// - `amount`: The amount by which the `source`'s balance of assets should be reduced and
  /// `dest`'s balance increased. The amount actually transferred may be slightly greater in
  /// the case that the transfer would otherwise take the `source` balance above zero but
  /// below the minimum balance. Must be greater than zero.
  ///
  /// Emits `Transferred` with the actual amount transferred. If this takes the source balance
  /// to below the minimum for the asset, then the amount transferred is increased to take it
  /// to zero.
  ///
  /// Weight: `O(1)`
  /// Modes: Pre-existence of `dest`; Post-existence of `source`; Account pre-existence of
  /// `dest`.
  _i10.ForeignAssets forceTransfer({
    required _i2.Location id,
    required _i11.MultiAddress source,
    required _i11.MultiAddress dest,
    required BigInt amount,
  }) {
    return _i10.ForeignAssets(_i12.ForceTransfer(
      id: id,
      source: source,
      dest: dest,
      amount: amount,
    ));
  }

  /// Disallow further unprivileged transfers of an asset `id` from an account `who`. `who`
  /// must already exist as an entry in `Account`s of the asset. If you want to freeze an
  /// account that does not have an entry, use `touch_other` first.
  ///
  /// Origin must be Signed and the sender should be the Freezer of the asset `id`.
  ///
  /// - `id`: The identifier of the asset to be frozen.
  /// - `who`: The account to be frozen.
  ///
  /// Emits `Frozen`.
  ///
  /// Weight: `O(1)`
  _i10.ForeignAssets freeze({
    required _i2.Location id,
    required _i11.MultiAddress who,
  }) {
    return _i10.ForeignAssets(_i12.Freeze(
      id: id,
      who: who,
    ));
  }

  /// Allow unprivileged transfers to and from an account again.
  ///
  /// Origin must be Signed and the sender should be the Admin of the asset `id`.
  ///
  /// - `id`: The identifier of the asset to be frozen.
  /// - `who`: The account to be unfrozen.
  ///
  /// Emits `Thawed`.
  ///
  /// Weight: `O(1)`
  _i10.ForeignAssets thaw({
    required _i2.Location id,
    required _i11.MultiAddress who,
  }) {
    return _i10.ForeignAssets(_i12.Thaw(
      id: id,
      who: who,
    ));
  }

  /// Disallow further unprivileged transfers for the asset class.
  ///
  /// Origin must be Signed and the sender should be the Freezer of the asset `id`.
  ///
  /// - `id`: The identifier of the asset to be frozen.
  ///
  /// Emits `Frozen`.
  ///
  /// Weight: `O(1)`
  _i10.ForeignAssets freezeAsset({required _i2.Location id}) {
    return _i10.ForeignAssets(_i12.FreezeAsset(id: id));
  }

  /// Allow unprivileged transfers for the asset again.
  ///
  /// Origin must be Signed and the sender should be the Admin of the asset `id`.
  ///
  /// - `id`: The identifier of the asset to be thawed.
  ///
  /// Emits `Thawed`.
  ///
  /// Weight: `O(1)`
  _i10.ForeignAssets thawAsset({required _i2.Location id}) {
    return _i10.ForeignAssets(_i12.ThawAsset(id: id));
  }

  /// Change the Owner of an asset.
  ///
  /// Origin must be Signed and the sender should be the Owner of the asset `id`.
  ///
  /// - `id`: The identifier of the asset.
  /// - `owner`: The new Owner of this asset.
  ///
  /// Emits `OwnerChanged`.
  ///
  /// Weight: `O(1)`
  _i10.ForeignAssets transferOwnership({
    required _i2.Location id,
    required _i11.MultiAddress owner,
  }) {
    return _i10.ForeignAssets(_i12.TransferOwnership(
      id: id,
      owner: owner,
    ));
  }

  /// Change the Issuer, Admin and Freezer of an asset.
  ///
  /// Origin must be Signed and the sender should be the Owner of the asset `id`.
  ///
  /// - `id`: The identifier of the asset to be frozen.
  /// - `issuer`: The new Issuer of this asset.
  /// - `admin`: The new Admin of this asset.
  /// - `freezer`: The new Freezer of this asset.
  ///
  /// Emits `TeamChanged`.
  ///
  /// Weight: `O(1)`
  _i10.ForeignAssets setTeam({
    required _i2.Location id,
    required _i11.MultiAddress issuer,
    required _i11.MultiAddress admin,
    required _i11.MultiAddress freezer,
  }) {
    return _i10.ForeignAssets(_i12.SetTeam(
      id: id,
      issuer: issuer,
      admin: admin,
      freezer: freezer,
    ));
  }

  /// Set the metadata for an asset.
  ///
  /// Origin must be Signed and the sender should be the Owner of the asset `id`.
  ///
  /// Funds of sender are reserved according to the formula:
  /// `MetadataDepositBase + MetadataDepositPerByte * (name.len + symbol.len)` taking into
  /// account any already reserved funds.
  ///
  /// - `id`: The identifier of the asset to update.
  /// - `name`: The user friendly name of this asset. Limited in length by `StringLimit`.
  /// - `symbol`: The exchange symbol for this asset. Limited in length by `StringLimit`.
  /// - `decimals`: The number of decimals this asset uses to represent one unit.
  ///
  /// Emits `MetadataSet`.
  ///
  /// Weight: `O(1)`
  _i10.ForeignAssets setMetadata({
    required _i2.Location id,
    required List<int> name,
    required List<int> symbol,
    required int decimals,
  }) {
    return _i10.ForeignAssets(_i12.SetMetadata(
      id: id,
      name: name,
      symbol: symbol,
      decimals: decimals,
    ));
  }

  /// Clear the metadata for an asset.
  ///
  /// Origin must be Signed and the sender should be the Owner of the asset `id`.
  ///
  /// Any deposit is freed for the asset owner.
  ///
  /// - `id`: The identifier of the asset to clear.
  ///
  /// Emits `MetadataCleared`.
  ///
  /// Weight: `O(1)`
  _i10.ForeignAssets clearMetadata({required _i2.Location id}) {
    return _i10.ForeignAssets(_i12.ClearMetadata(id: id));
  }

  /// Force the metadata for an asset to some value.
  ///
  /// Origin must be ForceOrigin.
  ///
  /// Any deposit is left alone.
  ///
  /// - `id`: The identifier of the asset to update.
  /// - `name`: The user friendly name of this asset. Limited in length by `StringLimit`.
  /// - `symbol`: The exchange symbol for this asset. Limited in length by `StringLimit`.
  /// - `decimals`: The number of decimals this asset uses to represent one unit.
  ///
  /// Emits `MetadataSet`.
  ///
  /// Weight: `O(N + S)` where N and S are the length of the name and symbol respectively.
  _i10.ForeignAssets forceSetMetadata({
    required _i2.Location id,
    required List<int> name,
    required List<int> symbol,
    required int decimals,
    required bool isFrozen,
  }) {
    return _i10.ForeignAssets(_i12.ForceSetMetadata(
      id: id,
      name: name,
      symbol: symbol,
      decimals: decimals,
      isFrozen: isFrozen,
    ));
  }

  /// Clear the metadata for an asset.
  ///
  /// Origin must be ForceOrigin.
  ///
  /// Any deposit is returned.
  ///
  /// - `id`: The identifier of the asset to clear.
  ///
  /// Emits `MetadataCleared`.
  ///
  /// Weight: `O(1)`
  _i10.ForeignAssets forceClearMetadata({required _i2.Location id}) {
    return _i10.ForeignAssets(_i12.ForceClearMetadata(id: id));
  }

  /// Alter the attributes of a given asset.
  ///
  /// Origin must be `ForceOrigin`.
  ///
  /// - `id`: The identifier of the asset.
  /// - `owner`: The new Owner of this asset.
  /// - `issuer`: The new Issuer of this asset.
  /// - `admin`: The new Admin of this asset.
  /// - `freezer`: The new Freezer of this asset.
  /// - `min_balance`: The minimum balance of this new asset that any single account must
  /// have. If an account's balance is reduced below this, then it collapses to zero.
  /// - `is_sufficient`: Whether a non-zero balance of this asset is deposit of sufficient
  /// value to account for the state bloat associated with its balance storage. If set to
  /// `true`, then non-zero balances may be stored without a `consumer` reference (and thus
  /// an ED in the Balances pallet or whatever else is used to control user-account state
  /// growth).
  /// - `is_frozen`: Whether this asset class is frozen except for permissioned/admin
  /// instructions.
  ///
  /// Emits `AssetStatusChanged` with the identity of the asset.
  ///
  /// Weight: `O(1)`
  _i10.ForeignAssets forceAssetStatus({
    required _i2.Location id,
    required _i11.MultiAddress owner,
    required _i11.MultiAddress issuer,
    required _i11.MultiAddress admin,
    required _i11.MultiAddress freezer,
    required BigInt minBalance,
    required bool isSufficient,
    required bool isFrozen,
  }) {
    return _i10.ForeignAssets(_i12.ForceAssetStatus(
      id: id,
      owner: owner,
      issuer: issuer,
      admin: admin,
      freezer: freezer,
      minBalance: minBalance,
      isSufficient: isSufficient,
      isFrozen: isFrozen,
    ));
  }

  /// Approve an amount of asset for transfer by a delegated third-party account.
  ///
  /// Origin must be Signed.
  ///
  /// Ensures that `ApprovalDeposit` worth of `Currency` is reserved from signing account
  /// for the purpose of holding the approval. If some non-zero amount of assets is already
  /// approved from signing account to `delegate`, then it is topped up or unreserved to
  /// meet the right value.
  ///
  /// NOTE: The signing account does not need to own `amount` of assets at the point of
  /// making this call.
  ///
  /// - `id`: The identifier of the asset.
  /// - `delegate`: The account to delegate permission to transfer asset.
  /// - `amount`: The amount of asset that may be transferred by `delegate`. If there is
  /// already an approval in place, then this acts additively.
  ///
  /// Emits `ApprovedTransfer` on success.
  ///
  /// Weight: `O(1)`
  _i10.ForeignAssets approveTransfer({
    required _i2.Location id,
    required _i11.MultiAddress delegate,
    required BigInt amount,
  }) {
    return _i10.ForeignAssets(_i12.ApproveTransfer(
      id: id,
      delegate: delegate,
      amount: amount,
    ));
  }

  /// Cancel all of some asset approved for delegated transfer by a third-party account.
  ///
  /// Origin must be Signed and there must be an approval in place between signer and
  /// `delegate`.
  ///
  /// Unreserves any deposit previously reserved by `approve_transfer` for the approval.
  ///
  /// - `id`: The identifier of the asset.
  /// - `delegate`: The account delegated permission to transfer asset.
  ///
  /// Emits `ApprovalCancelled` on success.
  ///
  /// Weight: `O(1)`
  _i10.ForeignAssets cancelApproval({
    required _i2.Location id,
    required _i11.MultiAddress delegate,
  }) {
    return _i10.ForeignAssets(_i12.CancelApproval(
      id: id,
      delegate: delegate,
    ));
  }

  /// Cancel all of some asset approved for delegated transfer by a third-party account.
  ///
  /// Origin must be either ForceOrigin or Signed origin with the signer being the Admin
  /// account of the asset `id`.
  ///
  /// Unreserves any deposit previously reserved by `approve_transfer` for the approval.
  ///
  /// - `id`: The identifier of the asset.
  /// - `delegate`: The account delegated permission to transfer asset.
  ///
  /// Emits `ApprovalCancelled` on success.
  ///
  /// Weight: `O(1)`
  _i10.ForeignAssets forceCancelApproval({
    required _i2.Location id,
    required _i11.MultiAddress owner,
    required _i11.MultiAddress delegate,
  }) {
    return _i10.ForeignAssets(_i12.ForceCancelApproval(
      id: id,
      owner: owner,
      delegate: delegate,
    ));
  }

  /// Transfer some asset balance from a previously delegated account to some third-party
  /// account.
  ///
  /// Origin must be Signed and there must be an approval in place by the `owner` to the
  /// signer.
  ///
  /// If the entire amount approved for transfer is transferred, then any deposit previously
  /// reserved by `approve_transfer` is unreserved.
  ///
  /// - `id`: The identifier of the asset.
  /// - `owner`: The account which previously approved for a transfer of at least `amount` and
  /// from which the asset balance will be withdrawn.
  /// - `destination`: The account to which the asset balance of `amount` will be transferred.
  /// - `amount`: The amount of assets to transfer.
  ///
  /// Emits `TransferredApproved` on success.
  ///
  /// Weight: `O(1)`
  _i10.ForeignAssets transferApproved({
    required _i2.Location id,
    required _i11.MultiAddress owner,
    required _i11.MultiAddress destination,
    required BigInt amount,
  }) {
    return _i10.ForeignAssets(_i12.TransferApproved(
      id: id,
      owner: owner,
      destination: destination,
      amount: amount,
    ));
  }

  /// Create an asset account for non-provider assets.
  ///
  /// A deposit will be taken from the signer account.
  ///
  /// - `origin`: Must be Signed; the signer account must have sufficient funds for a deposit
  ///  to be taken.
  /// - `id`: The identifier of the asset for the account to be created.
  ///
  /// Emits `Touched` event when successful.
  _i10.ForeignAssets touch({required _i2.Location id}) {
    return _i10.ForeignAssets(_i12.Touch(id: id));
  }

  /// Return the deposit (if any) of an asset account or a consumer reference (if any) of an
  /// account.
  ///
  /// The origin must be Signed.
  ///
  /// - `id`: The identifier of the asset for which the caller would like the deposit
  ///  refunded.
  /// - `allow_burn`: If `true` then assets may be destroyed in order to complete the refund.
  ///
  /// It will fail with either [`Error::ContainsHolds`] or [`Error::ContainsFreezes`] if
  /// the asset account contains holds or freezes in place.
  ///
  /// Emits `Refunded` event when successful.
  _i10.ForeignAssets refund({
    required _i2.Location id,
    required bool allowBurn,
  }) {
    return _i10.ForeignAssets(_i12.Refund(
      id: id,
      allowBurn: allowBurn,
    ));
  }

  /// Sets the minimum balance of an asset.
  ///
  /// Only works if there aren't any accounts that are holding the asset or if
  /// the new value of `min_balance` is less than the old one.
  ///
  /// Origin must be Signed and the sender has to be the Owner of the
  /// asset `id`.
  ///
  /// - `id`: The identifier of the asset.
  /// - `min_balance`: The new value of `min_balance`.
  ///
  /// Emits `AssetMinBalanceChanged` event when successful.
  _i10.ForeignAssets setMinBalance({
    required _i2.Location id,
    required BigInt minBalance,
  }) {
    return _i10.ForeignAssets(_i12.SetMinBalance(
      id: id,
      minBalance: minBalance,
    ));
  }

  /// Create an asset account for `who`.
  ///
  /// A deposit will be taken from the signer account.
  ///
  /// - `origin`: Must be Signed by `Freezer` or `Admin` of the asset `id`; the signer account
  ///  must have sufficient funds for a deposit to be taken.
  /// - `id`: The identifier of the asset for the account to be created.
  /// - `who`: The account to be created.
  ///
  /// Emits `Touched` event when successful.
  _i10.ForeignAssets touchOther({
    required _i2.Location id,
    required _i11.MultiAddress who,
  }) {
    return _i10.ForeignAssets(_i12.TouchOther(
      id: id,
      who: who,
    ));
  }

  /// Return the deposit (if any) of a target asset account. Useful if you are the depositor.
  ///
  /// The origin must be Signed and either the account owner, depositor, or asset `Admin`. In
  /// order to burn a non-zero balance of the asset, the caller must be the account and should
  /// use `refund`.
  ///
  /// - `id`: The identifier of the asset for the account holding a deposit.
  /// - `who`: The account to refund.
  ///
  /// It will fail with either [`Error::ContainsHolds`] or [`Error::ContainsFreezes`] if
  /// the asset account contains holds or freezes in place.
  ///
  /// Emits `Refunded` event when successful.
  _i10.ForeignAssets refundOther({
    required _i2.Location id,
    required _i11.MultiAddress who,
  }) {
    return _i10.ForeignAssets(_i12.RefundOther(
      id: id,
      who: who,
    ));
  }

  /// Disallow further unprivileged transfers of an asset `id` to and from an account `who`.
  ///
  /// Origin must be Signed and the sender should be the Freezer of the asset `id`.
  ///
  /// - `id`: The identifier of the account's asset.
  /// - `who`: The account to be unblocked.
  ///
  /// Emits `Blocked`.
  ///
  /// Weight: `O(1)`
  _i10.ForeignAssets block({
    required _i2.Location id,
    required _i11.MultiAddress who,
  }) {
    return _i10.ForeignAssets(_i12.Block(
      id: id,
      who: who,
    ));
  }

  /// Transfer the entire transferable balance from the caller asset account.
  ///
  /// NOTE: This function only attempts to transfer _transferable_ balances. This means that
  /// any held, frozen, or minimum balance (when `keep_alive` is `true`), will not be
  /// transferred by this function. To ensure that this function results in a killed account,
  /// you might need to prepare the account by removing any reference counters, storage
  /// deposits, etc...
  ///
  /// The dispatch origin of this call must be Signed.
  ///
  /// - `id`: The identifier of the asset for the account holding a deposit.
  /// - `dest`: The recipient of the transfer.
  /// - `keep_alive`: A boolean to determine if the `transfer_all` operation should send all
  ///  of the funds the asset account has, causing the sender asset account to be killed
  ///  (false), or transfer everything except at least the minimum balance, which will
  ///  guarantee to keep the sender asset account alive (true).
  _i10.ForeignAssets transferAll({
    required _i2.Location id,
    required _i11.MultiAddress dest,
    required bool keepAlive,
  }) {
    return _i10.ForeignAssets(_i12.TransferAll(
      id: id,
      dest: dest,
      keepAlive: keepAlive,
    ));
  }
}

class Constants {
  Constants();

  /// Max number of items to destroy per `destroy_accounts` and `destroy_approvals` call.
  ///
  /// Must be configured to result in a weight that makes each call fit in a block.
  final int removeItemsLimit = 1000;

  /// The basic amount of funds that must be reserved for an asset.
  final BigInt assetDeposit = BigInt.from(6729999930);

  /// The amount of funds that must be reserved for a non-provider asset account to be
  /// maintained.
  final BigInt assetAccountDeposit = BigInt.from(6671999988);

  /// The basic amount of funds that must be reserved when adding metadata to your asset.
  final BigInt metadataDepositBase = BigInt.from(6689333304);

  /// The additional funds that must be reserved for the number of bytes you store in your
  /// metadata.
  final BigInt metadataDepositPerByte = BigInt.from(333333);

  /// The amount of funds that must be reserved when creating a new approval.
  final BigInt approvalDeposit = BigInt.from(3333333);

  /// The maximum length of a name or symbol stored on-chain.
  final int stringLimit = 50;
}
