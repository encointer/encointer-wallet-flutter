// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i7;

import '../../sp_arithmetic/per_things/permill.dart' as _i6;
import '../../sp_core/crypto/account_id32.dart' as _i3;
import '../../staging_xcm/v5/location/location.dart' as _i5;
import '../../tuples.dart' as _i4;

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

  PoolCreated poolCreated({
    required _i3.AccountId32 creator,
    required _i4.Tuple2<_i5.Location, _i5.Location> poolId,
    required _i3.AccountId32 poolAccount,
    required int lpToken,
  }) {
    return PoolCreated(
      creator: creator,
      poolId: poolId,
      poolAccount: poolAccount,
      lpToken: lpToken,
    );
  }

  LiquidityAdded liquidityAdded({
    required _i3.AccountId32 who,
    required _i3.AccountId32 mintTo,
    required _i4.Tuple2<_i5.Location, _i5.Location> poolId,
    required BigInt amount1Provided,
    required BigInt amount2Provided,
    required int lpToken,
    required BigInt lpTokenMinted,
  }) {
    return LiquidityAdded(
      who: who,
      mintTo: mintTo,
      poolId: poolId,
      amount1Provided: amount1Provided,
      amount2Provided: amount2Provided,
      lpToken: lpToken,
      lpTokenMinted: lpTokenMinted,
    );
  }

  LiquidityRemoved liquidityRemoved({
    required _i3.AccountId32 who,
    required _i3.AccountId32 withdrawTo,
    required _i4.Tuple2<_i5.Location, _i5.Location> poolId,
    required BigInt amount1,
    required BigInt amount2,
    required int lpToken,
    required BigInt lpTokenBurned,
    required _i6.Permill withdrawalFee,
  }) {
    return LiquidityRemoved(
      who: who,
      withdrawTo: withdrawTo,
      poolId: poolId,
      amount1: amount1,
      amount2: amount2,
      lpToken: lpToken,
      lpTokenBurned: lpTokenBurned,
      withdrawalFee: withdrawalFee,
    );
  }

  SwapExecuted swapExecuted({
    required _i3.AccountId32 who,
    required _i3.AccountId32 sendTo,
    required BigInt amountIn,
    required BigInt amountOut,
    required List<_i4.Tuple2<_i5.Location, BigInt>> path,
  }) {
    return SwapExecuted(
      who: who,
      sendTo: sendTo,
      amountIn: amountIn,
      amountOut: amountOut,
      path: path,
    );
  }

  SwapCreditExecuted swapCreditExecuted({
    required BigInt amountIn,
    required BigInt amountOut,
    required List<_i4.Tuple2<_i5.Location, BigInt>> path,
  }) {
    return SwapCreditExecuted(
      amountIn: amountIn,
      amountOut: amountOut,
      path: path,
    );
  }

  Touched touched({
    required _i4.Tuple2<_i5.Location, _i5.Location> poolId,
    required _i3.AccountId32 who,
  }) {
    return Touched(
      poolId: poolId,
      who: who,
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
        return PoolCreated._decode(input);
      case 1:
        return LiquidityAdded._decode(input);
      case 2:
        return LiquidityRemoved._decode(input);
      case 3:
        return SwapExecuted._decode(input);
      case 4:
        return SwapCreditExecuted._decode(input);
      case 5:
        return Touched._decode(input);
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
      case PoolCreated:
        (value as PoolCreated).encodeTo(output);
        break;
      case LiquidityAdded:
        (value as LiquidityAdded).encodeTo(output);
        break;
      case LiquidityRemoved:
        (value as LiquidityRemoved).encodeTo(output);
        break;
      case SwapExecuted:
        (value as SwapExecuted).encodeTo(output);
        break;
      case SwapCreditExecuted:
        (value as SwapCreditExecuted).encodeTo(output);
        break;
      case Touched:
        (value as Touched).encodeTo(output);
        break;
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case PoolCreated:
        return (value as PoolCreated)._sizeHint();
      case LiquidityAdded:
        return (value as LiquidityAdded)._sizeHint();
      case LiquidityRemoved:
        return (value as LiquidityRemoved)._sizeHint();
      case SwapExecuted:
        return (value as SwapExecuted)._sizeHint();
      case SwapCreditExecuted:
        return (value as SwapCreditExecuted)._sizeHint();
      case Touched:
        return (value as Touched)._sizeHint();
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// A successful call of the `CreatePool` extrinsic will create this event.
class PoolCreated extends Event {
  const PoolCreated({
    required this.creator,
    required this.poolId,
    required this.poolAccount,
    required this.lpToken,
  });

  factory PoolCreated._decode(_i1.Input input) {
    return PoolCreated(
      creator: const _i1.U8ArrayCodec(32).decode(input),
      poolId: const _i4.Tuple2Codec<_i5.Location, _i5.Location>(
        _i5.Location.codec,
        _i5.Location.codec,
      ).decode(input),
      poolAccount: const _i1.U8ArrayCodec(32).decode(input),
      lpToken: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  /// The account that created the pool.
  final _i3.AccountId32 creator;

  /// T::PoolId
  /// The pool id associated with the pool. Note that the order of the assets may not be
  /// the same as the order specified in the create pool extrinsic.
  final _i4.Tuple2<_i5.Location, _i5.Location> poolId;

  /// T::AccountId
  /// The account ID of the pool.
  final _i3.AccountId32 poolAccount;

  /// T::PoolAssetId
  /// The id of the liquidity tokens that will be minted when assets are added to this
  /// pool.
  final int lpToken;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'PoolCreated': {
          'creator': creator.toList(),
          'poolId': [
            poolId.value0.toJson(),
            poolId.value1.toJson(),
          ],
          'poolAccount': poolAccount.toList(),
          'lpToken': lpToken,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(creator);
    size = size +
        const _i4.Tuple2Codec<_i5.Location, _i5.Location>(
          _i5.Location.codec,
          _i5.Location.codec,
        ).sizeHint(poolId);
    size = size + const _i3.AccountId32Codec().sizeHint(poolAccount);
    size = size + _i1.U32Codec.codec.sizeHint(lpToken);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      creator,
      output,
    );
    const _i4.Tuple2Codec<_i5.Location, _i5.Location>(
      _i5.Location.codec,
      _i5.Location.codec,
    ).encodeTo(
      poolId,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      poolAccount,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      lpToken,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PoolCreated &&
          _i7.listsEqual(
            other.creator,
            creator,
          ) &&
          other.poolId == poolId &&
          _i7.listsEqual(
            other.poolAccount,
            poolAccount,
          ) &&
          other.lpToken == lpToken;

  @override
  int get hashCode => Object.hash(
        creator,
        poolId,
        poolAccount,
        lpToken,
      );
}

/// A successful call of the `AddLiquidity` extrinsic will create this event.
class LiquidityAdded extends Event {
  const LiquidityAdded({
    required this.who,
    required this.mintTo,
    required this.poolId,
    required this.amount1Provided,
    required this.amount2Provided,
    required this.lpToken,
    required this.lpTokenMinted,
  });

  factory LiquidityAdded._decode(_i1.Input input) {
    return LiquidityAdded(
      who: const _i1.U8ArrayCodec(32).decode(input),
      mintTo: const _i1.U8ArrayCodec(32).decode(input),
      poolId: const _i4.Tuple2Codec<_i5.Location, _i5.Location>(
        _i5.Location.codec,
        _i5.Location.codec,
      ).decode(input),
      amount1Provided: _i1.U128Codec.codec.decode(input),
      amount2Provided: _i1.U128Codec.codec.decode(input),
      lpToken: _i1.U32Codec.codec.decode(input),
      lpTokenMinted: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  /// The account that the liquidity was taken from.
  final _i3.AccountId32 who;

  /// T::AccountId
  /// The account that the liquidity tokens were minted to.
  final _i3.AccountId32 mintTo;

  /// T::PoolId
  /// The pool id of the pool that the liquidity was added to.
  final _i4.Tuple2<_i5.Location, _i5.Location> poolId;

  /// T::Balance
  /// The amount of the first asset that was added to the pool.
  final BigInt amount1Provided;

  /// T::Balance
  /// The amount of the second asset that was added to the pool.
  final BigInt amount2Provided;

  /// T::PoolAssetId
  /// The id of the lp token that was minted.
  final int lpToken;

  /// T::Balance
  /// The amount of lp tokens that were minted of that id.
  final BigInt lpTokenMinted;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'LiquidityAdded': {
          'who': who.toList(),
          'mintTo': mintTo.toList(),
          'poolId': [
            poolId.value0.toJson(),
            poolId.value1.toJson(),
          ],
          'amount1Provided': amount1Provided,
          'amount2Provided': amount2Provided,
          'lpToken': lpToken,
          'lpTokenMinted': lpTokenMinted,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(who);
    size = size + const _i3.AccountId32Codec().sizeHint(mintTo);
    size = size +
        const _i4.Tuple2Codec<_i5.Location, _i5.Location>(
          _i5.Location.codec,
          _i5.Location.codec,
        ).sizeHint(poolId);
    size = size + _i1.U128Codec.codec.sizeHint(amount1Provided);
    size = size + _i1.U128Codec.codec.sizeHint(amount2Provided);
    size = size + _i1.U32Codec.codec.sizeHint(lpToken);
    size = size + _i1.U128Codec.codec.sizeHint(lpTokenMinted);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      mintTo,
      output,
    );
    const _i4.Tuple2Codec<_i5.Location, _i5.Location>(
      _i5.Location.codec,
      _i5.Location.codec,
    ).encodeTo(
      poolId,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount1Provided,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount2Provided,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      lpToken,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      lpTokenMinted,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is LiquidityAdded &&
          _i7.listsEqual(
            other.who,
            who,
          ) &&
          _i7.listsEqual(
            other.mintTo,
            mintTo,
          ) &&
          other.poolId == poolId &&
          other.amount1Provided == amount1Provided &&
          other.amount2Provided == amount2Provided &&
          other.lpToken == lpToken &&
          other.lpTokenMinted == lpTokenMinted;

  @override
  int get hashCode => Object.hash(
        who,
        mintTo,
        poolId,
        amount1Provided,
        amount2Provided,
        lpToken,
        lpTokenMinted,
      );
}

/// A successful call of the `RemoveLiquidity` extrinsic will create this event.
class LiquidityRemoved extends Event {
  const LiquidityRemoved({
    required this.who,
    required this.withdrawTo,
    required this.poolId,
    required this.amount1,
    required this.amount2,
    required this.lpToken,
    required this.lpTokenBurned,
    required this.withdrawalFee,
  });

  factory LiquidityRemoved._decode(_i1.Input input) {
    return LiquidityRemoved(
      who: const _i1.U8ArrayCodec(32).decode(input),
      withdrawTo: const _i1.U8ArrayCodec(32).decode(input),
      poolId: const _i4.Tuple2Codec<_i5.Location, _i5.Location>(
        _i5.Location.codec,
        _i5.Location.codec,
      ).decode(input),
      amount1: _i1.U128Codec.codec.decode(input),
      amount2: _i1.U128Codec.codec.decode(input),
      lpToken: _i1.U32Codec.codec.decode(input),
      lpTokenBurned: _i1.U128Codec.codec.decode(input),
      withdrawalFee: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  /// The account that the liquidity tokens were burned from.
  final _i3.AccountId32 who;

  /// T::AccountId
  /// The account that the assets were transferred to.
  final _i3.AccountId32 withdrawTo;

  /// T::PoolId
  /// The pool id that the liquidity was removed from.
  final _i4.Tuple2<_i5.Location, _i5.Location> poolId;

  /// T::Balance
  /// The amount of the first asset that was removed from the pool.
  final BigInt amount1;

  /// T::Balance
  /// The amount of the second asset that was removed from the pool.
  final BigInt amount2;

  /// T::PoolAssetId
  /// The id of the lp token that was burned.
  final int lpToken;

  /// T::Balance
  /// The amount of lp tokens that were burned of that id.
  final BigInt lpTokenBurned;

  /// Permill
  /// Liquidity withdrawal fee (%).
  final _i6.Permill withdrawalFee;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'LiquidityRemoved': {
          'who': who.toList(),
          'withdrawTo': withdrawTo.toList(),
          'poolId': [
            poolId.value0.toJson(),
            poolId.value1.toJson(),
          ],
          'amount1': amount1,
          'amount2': amount2,
          'lpToken': lpToken,
          'lpTokenBurned': lpTokenBurned,
          'withdrawalFee': withdrawalFee,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(who);
    size = size + const _i3.AccountId32Codec().sizeHint(withdrawTo);
    size = size +
        const _i4.Tuple2Codec<_i5.Location, _i5.Location>(
          _i5.Location.codec,
          _i5.Location.codec,
        ).sizeHint(poolId);
    size = size + _i1.U128Codec.codec.sizeHint(amount1);
    size = size + _i1.U128Codec.codec.sizeHint(amount2);
    size = size + _i1.U32Codec.codec.sizeHint(lpToken);
    size = size + _i1.U128Codec.codec.sizeHint(lpTokenBurned);
    size = size + const _i6.PermillCodec().sizeHint(withdrawalFee);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      withdrawTo,
      output,
    );
    const _i4.Tuple2Codec<_i5.Location, _i5.Location>(
      _i5.Location.codec,
      _i5.Location.codec,
    ).encodeTo(
      poolId,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount1,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount2,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      lpToken,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      lpTokenBurned,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      withdrawalFee,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is LiquidityRemoved &&
          _i7.listsEqual(
            other.who,
            who,
          ) &&
          _i7.listsEqual(
            other.withdrawTo,
            withdrawTo,
          ) &&
          other.poolId == poolId &&
          other.amount1 == amount1 &&
          other.amount2 == amount2 &&
          other.lpToken == lpToken &&
          other.lpTokenBurned == lpTokenBurned &&
          other.withdrawalFee == withdrawalFee;

  @override
  int get hashCode => Object.hash(
        who,
        withdrawTo,
        poolId,
        amount1,
        amount2,
        lpToken,
        lpTokenBurned,
        withdrawalFee,
      );
}

/// Assets have been converted from one to another. Both `SwapExactTokenForToken`
/// and `SwapTokenForExactToken` will generate this event.
class SwapExecuted extends Event {
  const SwapExecuted({
    required this.who,
    required this.sendTo,
    required this.amountIn,
    required this.amountOut,
    required this.path,
  });

  factory SwapExecuted._decode(_i1.Input input) {
    return SwapExecuted(
      who: const _i1.U8ArrayCodec(32).decode(input),
      sendTo: const _i1.U8ArrayCodec(32).decode(input),
      amountIn: _i1.U128Codec.codec.decode(input),
      amountOut: _i1.U128Codec.codec.decode(input),
      path: const _i1.SequenceCodec<_i4.Tuple2<_i5.Location, BigInt>>(_i4.Tuple2Codec<_i5.Location, BigInt>(
        _i5.Location.codec,
        _i1.U128Codec.codec,
      )).decode(input),
    );
  }

  /// T::AccountId
  /// Which account was the instigator of the swap.
  final _i3.AccountId32 who;

  /// T::AccountId
  /// The account that the assets were transferred to.
  final _i3.AccountId32 sendTo;

  /// T::Balance
  /// The amount of the first asset that was swapped.
  final BigInt amountIn;

  /// T::Balance
  /// The amount of the second asset that was received.
  final BigInt amountOut;

  /// BalancePath<T>
  /// The route of asset IDs with amounts that the swap went through.
  /// E.g. (A, amount_in) -> (Dot, amount_out) -> (B, amount_out)
  final List<_i4.Tuple2<_i5.Location, BigInt>> path;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'SwapExecuted': {
          'who': who.toList(),
          'sendTo': sendTo.toList(),
          'amountIn': amountIn,
          'amountOut': amountOut,
          'path': path
              .map((value) => [
                    value.value0.toJson(),
                    value.value1,
                  ])
              .toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(who);
    size = size + const _i3.AccountId32Codec().sizeHint(sendTo);
    size = size + _i1.U128Codec.codec.sizeHint(amountIn);
    size = size + _i1.U128Codec.codec.sizeHint(amountOut);
    size = size +
        const _i1.SequenceCodec<_i4.Tuple2<_i5.Location, BigInt>>(_i4.Tuple2Codec<_i5.Location, BigInt>(
          _i5.Location.codec,
          _i1.U128Codec.codec,
        )).sizeHint(path);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      sendTo,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amountIn,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amountOut,
      output,
    );
    const _i1.SequenceCodec<_i4.Tuple2<_i5.Location, BigInt>>(_i4.Tuple2Codec<_i5.Location, BigInt>(
      _i5.Location.codec,
      _i1.U128Codec.codec,
    )).encodeTo(
      path,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SwapExecuted &&
          _i7.listsEqual(
            other.who,
            who,
          ) &&
          _i7.listsEqual(
            other.sendTo,
            sendTo,
          ) &&
          other.amountIn == amountIn &&
          other.amountOut == amountOut &&
          _i7.listsEqual(
            other.path,
            path,
          );

  @override
  int get hashCode => Object.hash(
        who,
        sendTo,
        amountIn,
        amountOut,
        path,
      );
}

/// Assets have been converted from one to another.
class SwapCreditExecuted extends Event {
  const SwapCreditExecuted({
    required this.amountIn,
    required this.amountOut,
    required this.path,
  });

  factory SwapCreditExecuted._decode(_i1.Input input) {
    return SwapCreditExecuted(
      amountIn: _i1.U128Codec.codec.decode(input),
      amountOut: _i1.U128Codec.codec.decode(input),
      path: const _i1.SequenceCodec<_i4.Tuple2<_i5.Location, BigInt>>(_i4.Tuple2Codec<_i5.Location, BigInt>(
        _i5.Location.codec,
        _i1.U128Codec.codec,
      )).decode(input),
    );
  }

  /// T::Balance
  /// The amount of the first asset that was swapped.
  final BigInt amountIn;

  /// T::Balance
  /// The amount of the second asset that was received.
  final BigInt amountOut;

  /// BalancePath<T>
  /// The route of asset IDs with amounts that the swap went through.
  /// E.g. (A, amount_in) -> (Dot, amount_out) -> (B, amount_out)
  final List<_i4.Tuple2<_i5.Location, BigInt>> path;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'SwapCreditExecuted': {
          'amountIn': amountIn,
          'amountOut': amountOut,
          'path': path
              .map((value) => [
                    value.value0.toJson(),
                    value.value1,
                  ])
              .toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(amountIn);
    size = size + _i1.U128Codec.codec.sizeHint(amountOut);
    size = size +
        const _i1.SequenceCodec<_i4.Tuple2<_i5.Location, BigInt>>(_i4.Tuple2Codec<_i5.Location, BigInt>(
          _i5.Location.codec,
          _i1.U128Codec.codec,
        )).sizeHint(path);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amountIn,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amountOut,
      output,
    );
    const _i1.SequenceCodec<_i4.Tuple2<_i5.Location, BigInt>>(_i4.Tuple2Codec<_i5.Location, BigInt>(
      _i5.Location.codec,
      _i1.U128Codec.codec,
    )).encodeTo(
      path,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SwapCreditExecuted &&
          other.amountIn == amountIn &&
          other.amountOut == amountOut &&
          _i7.listsEqual(
            other.path,
            path,
          );

  @override
  int get hashCode => Object.hash(
        amountIn,
        amountOut,
        path,
      );
}

/// Pool has been touched in order to fulfill operational requirements.
class Touched extends Event {
  const Touched({
    required this.poolId,
    required this.who,
  });

  factory Touched._decode(_i1.Input input) {
    return Touched(
      poolId: const _i4.Tuple2Codec<_i5.Location, _i5.Location>(
        _i5.Location.codec,
        _i5.Location.codec,
      ).decode(input),
      who: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::PoolId
  /// The ID of the pool.
  final _i4.Tuple2<_i5.Location, _i5.Location> poolId;

  /// T::AccountId
  /// The account initiating the touch.
  final _i3.AccountId32 who;

  @override
  Map<String, Map<String, List<dynamic>>> toJson() => {
        'Touched': {
          'poolId': [
            poolId.value0.toJson(),
            poolId.value1.toJson(),
          ],
          'who': who.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i4.Tuple2Codec<_i5.Location, _i5.Location>(
          _i5.Location.codec,
          _i5.Location.codec,
        ).sizeHint(poolId);
    size = size + const _i3.AccountId32Codec().sizeHint(who);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    const _i4.Tuple2Codec<_i5.Location, _i5.Location>(
      _i5.Location.codec,
      _i5.Location.codec,
    ).encodeTo(
      poolId,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Touched &&
          other.poolId == poolId &&
          _i7.listsEqual(
            other.who,
            who,
          );

  @override
  int get hashCode => Object.hash(
        poolId,
        who,
      );
}
