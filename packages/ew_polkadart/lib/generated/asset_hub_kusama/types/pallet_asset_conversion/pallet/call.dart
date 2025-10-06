// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../sp_core/crypto/account_id32.dart' as _i4;
import '../../staging_xcm/v5/location/location.dart' as _i3;

/// Pallet's callable functions.
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

  CreatePool createPool({
    required _i3.Location asset1,
    required _i3.Location asset2,
  }) {
    return CreatePool(
      asset1: asset1,
      asset2: asset2,
    );
  }

  AddLiquidity addLiquidity({
    required _i3.Location asset1,
    required _i3.Location asset2,
    required BigInt amount1Desired,
    required BigInt amount2Desired,
    required BigInt amount1Min,
    required BigInt amount2Min,
    required _i4.AccountId32 mintTo,
  }) {
    return AddLiquidity(
      asset1: asset1,
      asset2: asset2,
      amount1Desired: amount1Desired,
      amount2Desired: amount2Desired,
      amount1Min: amount1Min,
      amount2Min: amount2Min,
      mintTo: mintTo,
    );
  }

  RemoveLiquidity removeLiquidity({
    required _i3.Location asset1,
    required _i3.Location asset2,
    required BigInt lpTokenBurn,
    required BigInt amount1MinReceive,
    required BigInt amount2MinReceive,
    required _i4.AccountId32 withdrawTo,
  }) {
    return RemoveLiquidity(
      asset1: asset1,
      asset2: asset2,
      lpTokenBurn: lpTokenBurn,
      amount1MinReceive: amount1MinReceive,
      amount2MinReceive: amount2MinReceive,
      withdrawTo: withdrawTo,
    );
  }

  SwapExactTokensForTokens swapExactTokensForTokens({
    required List<_i3.Location> path,
    required BigInt amountIn,
    required BigInt amountOutMin,
    required _i4.AccountId32 sendTo,
    required bool keepAlive,
  }) {
    return SwapExactTokensForTokens(
      path: path,
      amountIn: amountIn,
      amountOutMin: amountOutMin,
      sendTo: sendTo,
      keepAlive: keepAlive,
    );
  }

  SwapTokensForExactTokens swapTokensForExactTokens({
    required List<_i3.Location> path,
    required BigInt amountOut,
    required BigInt amountInMax,
    required _i4.AccountId32 sendTo,
    required bool keepAlive,
  }) {
    return SwapTokensForExactTokens(
      path: path,
      amountOut: amountOut,
      amountInMax: amountInMax,
      sendTo: sendTo,
      keepAlive: keepAlive,
    );
  }

  Touch touch({
    required _i3.Location asset1,
    required _i3.Location asset2,
  }) {
    return Touch(
      asset1: asset1,
      asset2: asset2,
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
        return CreatePool._decode(input);
      case 1:
        return AddLiquidity._decode(input);
      case 2:
        return RemoveLiquidity._decode(input);
      case 3:
        return SwapExactTokensForTokens._decode(input);
      case 4:
        return SwapTokensForExactTokens._decode(input);
      case 5:
        return Touch._decode(input);
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
      case CreatePool:
        (value as CreatePool).encodeTo(output);
        break;
      case AddLiquidity:
        (value as AddLiquidity).encodeTo(output);
        break;
      case RemoveLiquidity:
        (value as RemoveLiquidity).encodeTo(output);
        break;
      case SwapExactTokensForTokens:
        (value as SwapExactTokensForTokens).encodeTo(output);
        break;
      case SwapTokensForExactTokens:
        (value as SwapTokensForExactTokens).encodeTo(output);
        break;
      case Touch:
        (value as Touch).encodeTo(output);
        break;
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case CreatePool:
        return (value as CreatePool)._sizeHint();
      case AddLiquidity:
        return (value as AddLiquidity)._sizeHint();
      case RemoveLiquidity:
        return (value as RemoveLiquidity)._sizeHint();
      case SwapExactTokensForTokens:
        return (value as SwapExactTokensForTokens)._sizeHint();
      case SwapTokensForExactTokens:
        return (value as SwapTokensForExactTokens)._sizeHint();
      case Touch:
        return (value as Touch)._sizeHint();
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Creates an empty liquidity pool and an associated new `lp_token` asset
/// (the id of which is returned in the `Event::PoolCreated` event).
///
/// Once a pool is created, someone may [`Pallet::add_liquidity`] to it.
class CreatePool extends Call {
  const CreatePool({
    required this.asset1,
    required this.asset2,
  });

  factory CreatePool._decode(_i1.Input input) {
    return CreatePool(
      asset1: _i3.Location.codec.decode(input),
      asset2: _i3.Location.codec.decode(input),
    );
  }

  /// Box<T::AssetKind>
  final _i3.Location asset1;

  /// Box<T::AssetKind>
  final _i3.Location asset2;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'create_pool': {
          'asset1': asset1.toJson(),
          'asset2': asset2.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(asset1);
    size = size + _i3.Location.codec.sizeHint(asset2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.Location.codec.encodeTo(
      asset1,
      output,
    );
    _i3.Location.codec.encodeTo(
      asset2,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CreatePool && other.asset1 == asset1 && other.asset2 == asset2;

  @override
  int get hashCode => Object.hash(
        asset1,
        asset2,
      );
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
class AddLiquidity extends Call {
  const AddLiquidity({
    required this.asset1,
    required this.asset2,
    required this.amount1Desired,
    required this.amount2Desired,
    required this.amount1Min,
    required this.amount2Min,
    required this.mintTo,
  });

  factory AddLiquidity._decode(_i1.Input input) {
    return AddLiquidity(
      asset1: _i3.Location.codec.decode(input),
      asset2: _i3.Location.codec.decode(input),
      amount1Desired: _i1.U128Codec.codec.decode(input),
      amount2Desired: _i1.U128Codec.codec.decode(input),
      amount1Min: _i1.U128Codec.codec.decode(input),
      amount2Min: _i1.U128Codec.codec.decode(input),
      mintTo: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// Box<T::AssetKind>
  final _i3.Location asset1;

  /// Box<T::AssetKind>
  final _i3.Location asset2;

  /// T::Balance
  final BigInt amount1Desired;

  /// T::Balance
  final BigInt amount2Desired;

  /// T::Balance
  final BigInt amount1Min;

  /// T::Balance
  final BigInt amount2Min;

  /// T::AccountId
  final _i4.AccountId32 mintTo;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'add_liquidity': {
          'asset1': asset1.toJson(),
          'asset2': asset2.toJson(),
          'amount1Desired': amount1Desired,
          'amount2Desired': amount2Desired,
          'amount1Min': amount1Min,
          'amount2Min': amount2Min,
          'mintTo': mintTo.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(asset1);
    size = size + _i3.Location.codec.sizeHint(asset2);
    size = size + _i1.U128Codec.codec.sizeHint(amount1Desired);
    size = size + _i1.U128Codec.codec.sizeHint(amount2Desired);
    size = size + _i1.U128Codec.codec.sizeHint(amount1Min);
    size = size + _i1.U128Codec.codec.sizeHint(amount2Min);
    size = size + const _i4.AccountId32Codec().sizeHint(mintTo);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.Location.codec.encodeTo(
      asset1,
      output,
    );
    _i3.Location.codec.encodeTo(
      asset2,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount1Desired,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount2Desired,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount1Min,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount2Min,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      mintTo,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AddLiquidity &&
          other.asset1 == asset1 &&
          other.asset2 == asset2 &&
          other.amount1Desired == amount1Desired &&
          other.amount2Desired == amount2Desired &&
          other.amount1Min == amount1Min &&
          other.amount2Min == amount2Min &&
          _i5.listsEqual(
            other.mintTo,
            mintTo,
          );

  @override
  int get hashCode => Object.hash(
        asset1,
        asset2,
        amount1Desired,
        amount2Desired,
        amount1Min,
        amount2Min,
        mintTo,
      );
}

/// Allows you to remove liquidity by providing the `lp_token_burn` tokens that will be
/// burned in the process. With the usage of `amount1_min_receive`/`amount2_min_receive`
/// it's possible to control the min amount of returned tokens you're happy with.
class RemoveLiquidity extends Call {
  const RemoveLiquidity({
    required this.asset1,
    required this.asset2,
    required this.lpTokenBurn,
    required this.amount1MinReceive,
    required this.amount2MinReceive,
    required this.withdrawTo,
  });

  factory RemoveLiquidity._decode(_i1.Input input) {
    return RemoveLiquidity(
      asset1: _i3.Location.codec.decode(input),
      asset2: _i3.Location.codec.decode(input),
      lpTokenBurn: _i1.U128Codec.codec.decode(input),
      amount1MinReceive: _i1.U128Codec.codec.decode(input),
      amount2MinReceive: _i1.U128Codec.codec.decode(input),
      withdrawTo: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// Box<T::AssetKind>
  final _i3.Location asset1;

  /// Box<T::AssetKind>
  final _i3.Location asset2;

  /// T::Balance
  final BigInt lpTokenBurn;

  /// T::Balance
  final BigInt amount1MinReceive;

  /// T::Balance
  final BigInt amount2MinReceive;

  /// T::AccountId
  final _i4.AccountId32 withdrawTo;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'remove_liquidity': {
          'asset1': asset1.toJson(),
          'asset2': asset2.toJson(),
          'lpTokenBurn': lpTokenBurn,
          'amount1MinReceive': amount1MinReceive,
          'amount2MinReceive': amount2MinReceive,
          'withdrawTo': withdrawTo.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(asset1);
    size = size + _i3.Location.codec.sizeHint(asset2);
    size = size + _i1.U128Codec.codec.sizeHint(lpTokenBurn);
    size = size + _i1.U128Codec.codec.sizeHint(amount1MinReceive);
    size = size + _i1.U128Codec.codec.sizeHint(amount2MinReceive);
    size = size + const _i4.AccountId32Codec().sizeHint(withdrawTo);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i3.Location.codec.encodeTo(
      asset1,
      output,
    );
    _i3.Location.codec.encodeTo(
      asset2,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      lpTokenBurn,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount1MinReceive,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount2MinReceive,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      withdrawTo,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RemoveLiquidity &&
          other.asset1 == asset1 &&
          other.asset2 == asset2 &&
          other.lpTokenBurn == lpTokenBurn &&
          other.amount1MinReceive == amount1MinReceive &&
          other.amount2MinReceive == amount2MinReceive &&
          _i5.listsEqual(
            other.withdrawTo,
            withdrawTo,
          );

  @override
  int get hashCode => Object.hash(
        asset1,
        asset2,
        lpTokenBurn,
        amount1MinReceive,
        amount2MinReceive,
        withdrawTo,
      );
}

/// Swap the exact amount of `asset1` into `asset2`.
/// `amount_out_min` param allows you to specify the min amount of the `asset2`
/// you're happy to receive.
///
/// [`AssetConversionApi::quote_price_exact_tokens_for_tokens`] runtime call can be called
/// for a quote.
class SwapExactTokensForTokens extends Call {
  const SwapExactTokensForTokens({
    required this.path,
    required this.amountIn,
    required this.amountOutMin,
    required this.sendTo,
    required this.keepAlive,
  });

  factory SwapExactTokensForTokens._decode(_i1.Input input) {
    return SwapExactTokensForTokens(
      path: const _i1.SequenceCodec<_i3.Location>(_i3.Location.codec).decode(input),
      amountIn: _i1.U128Codec.codec.decode(input),
      amountOutMin: _i1.U128Codec.codec.decode(input),
      sendTo: const _i1.U8ArrayCodec(32).decode(input),
      keepAlive: _i1.BoolCodec.codec.decode(input),
    );
  }

  /// Vec<Box<T::AssetKind>>
  final List<_i3.Location> path;

  /// T::Balance
  final BigInt amountIn;

  /// T::Balance
  final BigInt amountOutMin;

  /// T::AccountId
  final _i4.AccountId32 sendTo;

  /// bool
  final bool keepAlive;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'swap_exact_tokens_for_tokens': {
          'path': path.map((value) => value.toJson()).toList(),
          'amountIn': amountIn,
          'amountOutMin': amountOutMin,
          'sendTo': sendTo.toList(),
          'keepAlive': keepAlive,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.SequenceCodec<_i3.Location>(_i3.Location.codec).sizeHint(path);
    size = size + _i1.U128Codec.codec.sizeHint(amountIn);
    size = size + _i1.U128Codec.codec.sizeHint(amountOutMin);
    size = size + const _i4.AccountId32Codec().sizeHint(sendTo);
    size = size + _i1.BoolCodec.codec.sizeHint(keepAlive);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i1.SequenceCodec<_i3.Location>(_i3.Location.codec).encodeTo(
      path,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amountIn,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amountOutMin,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      sendTo,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      keepAlive,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SwapExactTokensForTokens &&
          _i5.listsEqual(
            other.path,
            path,
          ) &&
          other.amountIn == amountIn &&
          other.amountOutMin == amountOutMin &&
          _i5.listsEqual(
            other.sendTo,
            sendTo,
          ) &&
          other.keepAlive == keepAlive;

  @override
  int get hashCode => Object.hash(
        path,
        amountIn,
        amountOutMin,
        sendTo,
        keepAlive,
      );
}

/// Swap any amount of `asset1` to get the exact amount of `asset2`.
/// `amount_in_max` param allows to specify the max amount of the `asset1`
/// you're happy to provide.
///
/// [`AssetConversionApi::quote_price_tokens_for_exact_tokens`] runtime call can be called
/// for a quote.
class SwapTokensForExactTokens extends Call {
  const SwapTokensForExactTokens({
    required this.path,
    required this.amountOut,
    required this.amountInMax,
    required this.sendTo,
    required this.keepAlive,
  });

  factory SwapTokensForExactTokens._decode(_i1.Input input) {
    return SwapTokensForExactTokens(
      path: const _i1.SequenceCodec<_i3.Location>(_i3.Location.codec).decode(input),
      amountOut: _i1.U128Codec.codec.decode(input),
      amountInMax: _i1.U128Codec.codec.decode(input),
      sendTo: const _i1.U8ArrayCodec(32).decode(input),
      keepAlive: _i1.BoolCodec.codec.decode(input),
    );
  }

  /// Vec<Box<T::AssetKind>>
  final List<_i3.Location> path;

  /// T::Balance
  final BigInt amountOut;

  /// T::Balance
  final BigInt amountInMax;

  /// T::AccountId
  final _i4.AccountId32 sendTo;

  /// bool
  final bool keepAlive;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'swap_tokens_for_exact_tokens': {
          'path': path.map((value) => value.toJson()).toList(),
          'amountOut': amountOut,
          'amountInMax': amountInMax,
          'sendTo': sendTo.toList(),
          'keepAlive': keepAlive,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.SequenceCodec<_i3.Location>(_i3.Location.codec).sizeHint(path);
    size = size + _i1.U128Codec.codec.sizeHint(amountOut);
    size = size + _i1.U128Codec.codec.sizeHint(amountInMax);
    size = size + const _i4.AccountId32Codec().sizeHint(sendTo);
    size = size + _i1.BoolCodec.codec.sizeHint(keepAlive);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    const _i1.SequenceCodec<_i3.Location>(_i3.Location.codec).encodeTo(
      path,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amountOut,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amountInMax,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      sendTo,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      keepAlive,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SwapTokensForExactTokens &&
          _i5.listsEqual(
            other.path,
            path,
          ) &&
          other.amountOut == amountOut &&
          other.amountInMax == amountInMax &&
          _i5.listsEqual(
            other.sendTo,
            sendTo,
          ) &&
          other.keepAlive == keepAlive;

  @override
  int get hashCode => Object.hash(
        path,
        amountOut,
        amountInMax,
        sendTo,
        keepAlive,
      );
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
class Touch extends Call {
  const Touch({
    required this.asset1,
    required this.asset2,
  });

  factory Touch._decode(_i1.Input input) {
    return Touch(
      asset1: _i3.Location.codec.decode(input),
      asset2: _i3.Location.codec.decode(input),
    );
  }

  /// Box<T::AssetKind>
  final _i3.Location asset1;

  /// Box<T::AssetKind>
  final _i3.Location asset2;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'touch': {
          'asset1': asset1.toJson(),
          'asset2': asset2.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(asset1);
    size = size + _i3.Location.codec.sizeHint(asset2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i3.Location.codec.encodeTo(
      asset1,
      output,
    );
    _i3.Location.codec.encodeTo(
      asset2,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Touch && other.asset1 == asset1 && other.asset2 == asset2;

  @override
  int get hashCode => Object.hash(
        asset1,
        asset2,
      );
}
