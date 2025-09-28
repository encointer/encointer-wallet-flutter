// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:typed_data' as _i7;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i5;

import '../types/asset_hub_kusama_runtime/runtime_call.dart' as _i8;
import '../types/frame_support/pallet_id.dart' as _i13;
import '../types/pallet_asset_conversion/pallet/call.dart' as _i9;
import '../types/pallet_asset_conversion/types/pool_info.dart' as _i4;
import '../types/sp_arithmetic/per_things/permill.dart' as _i12;
import '../types/sp_core/crypto/account_id32.dart' as _i10;
import '../types/staging_xcm/v5/junctions/junctions.dart' as _i11;
import '../types/staging_xcm/v5/location/location.dart' as _i3;
import '../types/tuples.dart' as _i2;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.Tuple2<_i3.Location, _i3.Location>, _i4.PoolInfo> _pools =
      const _i1.StorageMap<_i2.Tuple2<_i3.Location, _i3.Location>, _i4.PoolInfo>(
    prefix: 'AssetConversion',
    storage: 'Pools',
    valueCodec: _i4.PoolInfo.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i2.Tuple2Codec<_i3.Location, _i3.Location>(
      _i3.Location.codec,
      _i3.Location.codec,
    )),
  );

  final _i1.StorageValue<int> _nextPoolAssetId = const _i1.StorageValue<int>(
    prefix: 'AssetConversion',
    storage: 'NextPoolAssetId',
    valueCodec: _i5.U32Codec.codec,
  );

  /// Map from `PoolAssetId` to `PoolInfo`. This establishes whether a pool has been officially
  /// created rather than people sending tokens directly to a pool's public account.
  _i6.Future<_i4.PoolInfo?> pools(
    _i2.Tuple2<_i3.Location, _i3.Location> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _pools.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _pools.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Stores the `PoolAssetId` that is going to be used for the next lp token.
  /// This gets incremented whenever a new lp pool is created.
  _i6.Future<int?> nextPoolAssetId({_i1.BlockHash? at}) async {
    final hashedKey = _nextPoolAssetId.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nextPoolAssetId.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Map from `PoolAssetId` to `PoolInfo`. This establishes whether a pool has been officially
  /// created rather than people sending tokens directly to a pool's public account.
  _i6.Future<List<_i4.PoolInfo?>> multiPools(
    List<_i2.Tuple2<_i3.Location, _i3.Location>> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _pools.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _pools.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// Returns the storage key for `pools`.
  _i7.Uint8List poolsKey(_i2.Tuple2<_i3.Location, _i3.Location> key1) {
    final hashedKey = _pools.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `nextPoolAssetId`.
  _i7.Uint8List nextPoolAssetIdKey() {
    final hashedKey = _nextPoolAssetId.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `pools`.
  _i7.Uint8List poolsMapPrefix() {
    final hashedKey = _pools.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Creates an empty liquidity pool and an associated new `lp_token` asset
  /// (the id of which is returned in the `Event::PoolCreated` event).
  ///
  /// Once a pool is created, someone may [`Pallet::add_liquidity`] to it.
  _i8.AssetConversion createPool({
    required _i3.Location asset1,
    required _i3.Location asset2,
  }) {
    return _i8.AssetConversion(_i9.CreatePool(
      asset1: asset1,
      asset2: asset2,
    ));
  }

  /// Provide liquidity into the pool of `asset1` and `asset2`.
  /// NOTE: an optimal amount of asset1 and asset2 will be calculated and
  /// might be different than the provided `amount1_desired`/`amount2_desired`
  /// thus you should provide the min amount you're happy to provide.
  /// Params `amount1_min`/`amount2_min` represent that.
  /// `mint_to` will be sent the liquidity tokens that represent this share of the pool.
  ///
  /// NOTE: when encountering an incorrect exchange rate and non-withdrawable pool liquidity,
  /// batch an atomic call with [`Pallet::add_liquidity`] and
  /// [`Pallet::swap_exact_tokens_for_tokens`] or [`Pallet::swap_tokens_for_exact_tokens`]
  /// calls to render the liquidity withdrawable and rectify the exchange rate.
  ///
  /// Once liquidity is added, someone may successfully call
  /// [`Pallet::swap_exact_tokens_for_tokens`].
  _i8.AssetConversion addLiquidity({
    required _i3.Location asset1,
    required _i3.Location asset2,
    required BigInt amount1Desired,
    required BigInt amount2Desired,
    required BigInt amount1Min,
    required BigInt amount2Min,
    required _i10.AccountId32 mintTo,
  }) {
    return _i8.AssetConversion(_i9.AddLiquidity(
      asset1: asset1,
      asset2: asset2,
      amount1Desired: amount1Desired,
      amount2Desired: amount2Desired,
      amount1Min: amount1Min,
      amount2Min: amount2Min,
      mintTo: mintTo,
    ));
  }

  /// Allows you to remove liquidity by providing the `lp_token_burn` tokens that will be
  /// burned in the process. With the usage of `amount1_min_receive`/`amount2_min_receive`
  /// it's possible to control the min amount of returned tokens you're happy with.
  _i8.AssetConversion removeLiquidity({
    required _i3.Location asset1,
    required _i3.Location asset2,
    required BigInt lpTokenBurn,
    required BigInt amount1MinReceive,
    required BigInt amount2MinReceive,
    required _i10.AccountId32 withdrawTo,
  }) {
    return _i8.AssetConversion(_i9.RemoveLiquidity(
      asset1: asset1,
      asset2: asset2,
      lpTokenBurn: lpTokenBurn,
      amount1MinReceive: amount1MinReceive,
      amount2MinReceive: amount2MinReceive,
      withdrawTo: withdrawTo,
    ));
  }

  /// Swap the exact amount of `asset1` into `asset2`.
  /// `amount_out_min` param allows you to specify the min amount of the `asset2`
  /// you're happy to receive.
  ///
  /// [`AssetConversionApi::quote_price_exact_tokens_for_tokens`] runtime call can be called
  /// for a quote.
  _i8.AssetConversion swapExactTokensForTokens({
    required List<_i3.Location> path,
    required BigInt amountIn,
    required BigInt amountOutMin,
    required _i10.AccountId32 sendTo,
    required bool keepAlive,
  }) {
    return _i8.AssetConversion(_i9.SwapExactTokensForTokens(
      path: path,
      amountIn: amountIn,
      amountOutMin: amountOutMin,
      sendTo: sendTo,
      keepAlive: keepAlive,
    ));
  }

  /// Swap any amount of `asset1` to get the exact amount of `asset2`.
  /// `amount_in_max` param allows to specify the max amount of the `asset1`
  /// you're happy to provide.
  ///
  /// [`AssetConversionApi::quote_price_tokens_for_exact_tokens`] runtime call can be called
  /// for a quote.
  _i8.AssetConversion swapTokensForExactTokens({
    required List<_i3.Location> path,
    required BigInt amountOut,
    required BigInt amountInMax,
    required _i10.AccountId32 sendTo,
    required bool keepAlive,
  }) {
    return _i8.AssetConversion(_i9.SwapTokensForExactTokens(
      path: path,
      amountOut: amountOut,
      amountInMax: amountInMax,
      sendTo: sendTo,
      keepAlive: keepAlive,
    ));
  }

  /// Touch an existing pool to fulfill prerequisites before providing liquidity, such as
  /// ensuring that the pool's accounts are in place. It is typically useful when a pool
  /// creator removes the pool's accounts and does not provide a liquidity. This action may
  /// involve holding assets from the caller as a deposit for creating the pool's accounts.
  ///
  /// The origin must be Signed.
  ///
  /// - `asset1`: The asset ID of an existing pool with a pair (asset1, asset2).
  /// - `asset2`: The asset ID of an existing pool with a pair (asset1, asset2).
  ///
  /// Emits `Touched` event when successful.
  _i8.AssetConversion touch({
    required _i3.Location asset1,
    required _i3.Location asset2,
  }) {
    return _i8.AssetConversion(_i9.Touch(
      asset1: asset1,
      asset2: asset2,
    ));
  }
}

class Constants {
  Constants();

  /// A % the liquidity providers will take of every swap. Represents 10ths of a percent.
  final int lPFee = 3;

  /// A one-time fee to setup the pool.
  final BigInt poolSetupFee = BigInt.from(13397999922);

  /// Asset class from [`Config::Assets`] used to pay the [`Config::PoolSetupFee`].
  final _i3.Location poolSetupFeeAsset = const _i3.Location(
    parents: 1,
    interior: _i11.Here(),
  );

  /// A fee to withdraw the liquidity.
  final _i12.Permill liquidityWithdrawalFee = 0;

  /// The minimum LP token amount that could be minted. Ameliorates rounding errors.
  final BigInt mintMinLiquidity = BigInt.from(100);

  /// The max number of hops in a swap.
  final int maxSwapPathLength = 3;

  /// The pallet's id, used for deriving its sovereign account ID.
  final _i13.PalletId palletId = const <int>[
    112,
    121,
    47,
    97,
    115,
    99,
    111,
    110,
  ];
}
