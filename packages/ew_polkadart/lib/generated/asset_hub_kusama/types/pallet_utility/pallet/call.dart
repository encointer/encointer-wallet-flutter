// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../../asset_hub_kusama_runtime/origin_caller.dart' as _i4;
import '../../asset_hub_kusama_runtime/runtime_call.dart' as _i3;
import '../../sp_weights/weight_v2/weight.dart' as _i5;

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

  Batch batch({required List<_i3.RuntimeCall> calls}) {
    return Batch(calls: calls);
  }

  AsDerivative asDerivative({
    required int index,
    required _i3.RuntimeCall call,
  }) {
    return AsDerivative(
      index: index,
      call: call,
    );
  }

  BatchAll batchAll({required List<_i3.RuntimeCall> calls}) {
    return BatchAll(calls: calls);
  }

  DispatchAs dispatchAs({
    required _i4.OriginCaller asOrigin,
    required _i3.RuntimeCall call,
  }) {
    return DispatchAs(
      asOrigin: asOrigin,
      call: call,
    );
  }

  ForceBatch forceBatch({required List<_i3.RuntimeCall> calls}) {
    return ForceBatch(calls: calls);
  }

  WithWeight withWeight({
    required _i3.RuntimeCall call,
    required _i5.Weight weight,
  }) {
    return WithWeight(
      call: call,
      weight: weight,
    );
  }

  IfElse ifElse({
    required _i3.RuntimeCall main,
    required _i3.RuntimeCall fallback,
  }) {
    return IfElse(
      main: main,
      fallback: fallback,
    );
  }

  DispatchAsFallible dispatchAsFallible({
    required _i4.OriginCaller asOrigin,
    required _i3.RuntimeCall call,
  }) {
    return DispatchAsFallible(
      asOrigin: asOrigin,
      call: call,
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
        return Batch._decode(input);
      case 1:
        return AsDerivative._decode(input);
      case 2:
        return BatchAll._decode(input);
      case 3:
        return DispatchAs._decode(input);
      case 4:
        return ForceBatch._decode(input);
      case 5:
        return WithWeight._decode(input);
      case 6:
        return IfElse._decode(input);
      case 7:
        return DispatchAsFallible._decode(input);
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
      case Batch:
        (value as Batch).encodeTo(output);
        break;
      case AsDerivative:
        (value as AsDerivative).encodeTo(output);
        break;
      case BatchAll:
        (value as BatchAll).encodeTo(output);
        break;
      case DispatchAs:
        (value as DispatchAs).encodeTo(output);
        break;
      case ForceBatch:
        (value as ForceBatch).encodeTo(output);
        break;
      case WithWeight:
        (value as WithWeight).encodeTo(output);
        break;
      case IfElse:
        (value as IfElse).encodeTo(output);
        break;
      case DispatchAsFallible:
        (value as DispatchAsFallible).encodeTo(output);
        break;
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case Batch:
        return (value as Batch)._sizeHint();
      case AsDerivative:
        return (value as AsDerivative)._sizeHint();
      case BatchAll:
        return (value as BatchAll)._sizeHint();
      case DispatchAs:
        return (value as DispatchAs)._sizeHint();
      case ForceBatch:
        return (value as ForceBatch)._sizeHint();
      case WithWeight:
        return (value as WithWeight)._sizeHint();
      case IfElse:
        return (value as IfElse)._sizeHint();
      case DispatchAsFallible:
        return (value as DispatchAsFallible)._sizeHint();
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Send a batch of dispatch calls.
///
/// May be called from any origin except `None`.
///
/// - `calls`: The calls to be dispatched from the same origin. The number of call must not
///  exceed the constant: `batched_calls_limit` (available in constant metadata).
///
/// If origin is root then the calls are dispatched without checking origin filter. (This
/// includes bypassing `frame_system::Config::BaseCallFilter`).
///
/// ## Complexity
/// - O(C) where C is the number of calls to be batched.
///
/// This will return `Ok` in all circumstances. To determine the success of the batch, an
/// event is deposited. If a call failed and the batch was interrupted, then the
/// `BatchInterrupted` event is deposited, along with the number of successful calls made
/// and the error of the failed call. If all were successful, then the `BatchCompleted`
/// event is deposited.
class Batch extends Call {
  const Batch({required this.calls});

  factory Batch._decode(_i1.Input input) {
    return Batch(calls: const _i1.SequenceCodec<_i3.RuntimeCall>(_i3.RuntimeCall.codec).decode(input));
  }

  /// Vec<<T as Config>::RuntimeCall>
  final List<_i3.RuntimeCall> calls;

  @override
  Map<String, Map<String, List<Map<String, dynamic>>>> toJson() => {
        'batch': {'calls': calls.map((value) => value.toJson()).toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.SequenceCodec<_i3.RuntimeCall>(_i3.RuntimeCall.codec).sizeHint(calls);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.SequenceCodec<_i3.RuntimeCall>(_i3.RuntimeCall.codec).encodeTo(
      calls,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Batch &&
          _i6.listsEqual(
            other.calls,
            calls,
          );

  @override
  int get hashCode => calls.hashCode;
}

/// Send a call through an indexed pseudonym of the sender.
///
/// Filter from origin are passed along. The call will be dispatched with an origin which
/// use the same filter as the origin of this call.
///
/// NOTE: If you need to ensure that any account-based filtering is not honored (i.e.
/// because you expect `proxy` to have been used prior in the call stack and you do not want
/// the call restrictions to apply to any sub-accounts), then use `as_multi_threshold_1`
/// in the Multisig pallet instead.
///
/// NOTE: Prior to version *12, this was called `as_limited_sub`.
///
/// The dispatch origin for this call must be _Signed_.
class AsDerivative extends Call {
  const AsDerivative({
    required this.index,
    required this.call,
  });

  factory AsDerivative._decode(_i1.Input input) {
    return AsDerivative(
      index: _i1.U16Codec.codec.decode(input),
      call: _i3.RuntimeCall.codec.decode(input),
    );
  }

  /// u16
  final int index;

  /// Box<<T as Config>::RuntimeCall>
  final _i3.RuntimeCall call;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'as_derivative': {
          'index': index,
          'call': call.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U16Codec.codec.sizeHint(index);
    size = size + _i3.RuntimeCall.codec.sizeHint(call);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U16Codec.codec.encodeTo(
      index,
      output,
    );
    _i3.RuntimeCall.codec.encodeTo(
      call,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AsDerivative && other.index == index && other.call == call;

  @override
  int get hashCode => Object.hash(
        index,
        call,
      );
}

/// Send a batch of dispatch calls and atomically execute them.
/// The whole transaction will rollback and fail if any of the calls failed.
///
/// May be called from any origin except `None`.
///
/// - `calls`: The calls to be dispatched from the same origin. The number of call must not
///  exceed the constant: `batched_calls_limit` (available in constant metadata).
///
/// If origin is root then the calls are dispatched without checking origin filter. (This
/// includes bypassing `frame_system::Config::BaseCallFilter`).
///
/// ## Complexity
/// - O(C) where C is the number of calls to be batched.
class BatchAll extends Call {
  const BatchAll({required this.calls});

  factory BatchAll._decode(_i1.Input input) {
    return BatchAll(calls: const _i1.SequenceCodec<_i3.RuntimeCall>(_i3.RuntimeCall.codec).decode(input));
  }

  /// Vec<<T as Config>::RuntimeCall>
  final List<_i3.RuntimeCall> calls;

  @override
  Map<String, Map<String, List<dynamic>>> toJson() => {
        'batch_all': {'calls': calls.map((value) => value.toJson()).toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.SequenceCodec<_i3.RuntimeCall>(_i3.RuntimeCall.codec).sizeHint(calls);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.SequenceCodec<_i3.RuntimeCall>(_i3.RuntimeCall.codec).encodeTo(
      calls,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BatchAll &&
          _i6.listsEqual(
            other.calls,
            calls,
          );

  @override
  int get hashCode => calls.hashCode;
}

/// Dispatches a function call with a provided origin.
///
/// The dispatch origin for this call must be _Root_.
///
/// ## Complexity
/// - O(1).
class DispatchAs extends Call {
  const DispatchAs({
    required this.asOrigin,
    required this.call,
  });

  factory DispatchAs._decode(_i1.Input input) {
    return DispatchAs(
      asOrigin: _i4.OriginCaller.codec.decode(input),
      call: _i3.RuntimeCall.codec.decode(input),
    );
  }

  /// Box<T::PalletsOrigin>
  final _i4.OriginCaller asOrigin;

  /// Box<<T as Config>::RuntimeCall>
  final _i3.RuntimeCall call;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'dispatch_as': {
          'asOrigin': asOrigin.toJson(),
          'call': call.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.OriginCaller.codec.sizeHint(asOrigin);
    size = size + _i3.RuntimeCall.codec.sizeHint(call);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i4.OriginCaller.codec.encodeTo(
      asOrigin,
      output,
    );
    _i3.RuntimeCall.codec.encodeTo(
      call,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DispatchAs && other.asOrigin == asOrigin && other.call == call;

  @override
  int get hashCode => Object.hash(
        asOrigin,
        call,
      );
}

/// Send a batch of dispatch calls.
/// Unlike `batch`, it allows errors and won't interrupt.
///
/// May be called from any origin except `None`.
///
/// - `calls`: The calls to be dispatched from the same origin. The number of call must not
///  exceed the constant: `batched_calls_limit` (available in constant metadata).
///
/// If origin is root then the calls are dispatch without checking origin filter. (This
/// includes bypassing `frame_system::Config::BaseCallFilter`).
///
/// ## Complexity
/// - O(C) where C is the number of calls to be batched.
class ForceBatch extends Call {
  const ForceBatch({required this.calls});

  factory ForceBatch._decode(_i1.Input input) {
    return ForceBatch(calls: const _i1.SequenceCodec<_i3.RuntimeCall>(_i3.RuntimeCall.codec).decode(input));
  }

  /// Vec<<T as Config>::RuntimeCall>
  final List<_i3.RuntimeCall> calls;

  @override
  Map<String, Map<String, List<dynamic>>> toJson() => {
        'force_batch': {'calls': calls.map((value) => value.toJson()).toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.SequenceCodec<_i3.RuntimeCall>(_i3.RuntimeCall.codec).sizeHint(calls);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    const _i1.SequenceCodec<_i3.RuntimeCall>(_i3.RuntimeCall.codec).encodeTo(
      calls,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceBatch &&
          _i6.listsEqual(
            other.calls,
            calls,
          );

  @override
  int get hashCode => calls.hashCode;
}

/// Dispatch a function call with a specified weight.
///
/// This function does not check the weight of the call, and instead allows the
/// Root origin to specify the weight of the call.
///
/// The dispatch origin for this call must be _Root_.
class WithWeight extends Call {
  const WithWeight({
    required this.call,
    required this.weight,
  });

  factory WithWeight._decode(_i1.Input input) {
    return WithWeight(
      call: _i3.RuntimeCall.codec.decode(input),
      weight: _i5.Weight.codec.decode(input),
    );
  }

  /// Box<<T as Config>::RuntimeCall>
  final _i3.RuntimeCall call;

  /// Weight
  final _i5.Weight weight;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'with_weight': {
          'call': call.toJson(),
          'weight': weight.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.RuntimeCall.codec.sizeHint(call);
    size = size + _i5.Weight.codec.sizeHint(weight);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i3.RuntimeCall.codec.encodeTo(
      call,
      output,
    );
    _i5.Weight.codec.encodeTo(
      weight,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is WithWeight && other.call == call && other.weight == weight;

  @override
  int get hashCode => Object.hash(
        call,
        weight,
      );
}

/// Dispatch a fallback call in the event the main call fails to execute.
/// May be called from any origin except `None`.
///
/// This function first attempts to dispatch the `main` call.
/// If the `main` call fails, the `fallback` is attemted.
/// if the fallback is successfully dispatched, the weights of both calls
/// are accumulated and an event containing the main call error is deposited.
///
/// In the event of a fallback failure the whole call fails
/// with the weights returned.
///
/// - `main`: The main call to be dispatched. This is the primary action to execute.
/// - `fallback`: The fallback call to be dispatched in case the `main` call fails.
///
/// ## Dispatch Logic
/// - If the origin is `root`, both the main and fallback calls are executed without
///  applying any origin filters.
/// - If the origin is not `root`, the origin filter is applied to both the `main` and
///  `fallback` calls.
///
/// ## Use Case
/// - Some use cases might involve submitting a `batch` type call in either main, fallback
///  or both.
class IfElse extends Call {
  const IfElse({
    required this.main,
    required this.fallback,
  });

  factory IfElse._decode(_i1.Input input) {
    return IfElse(
      main: _i3.RuntimeCall.codec.decode(input),
      fallback: _i3.RuntimeCall.codec.decode(input),
    );
  }

  /// Box<<T as Config>::RuntimeCall>
  final _i3.RuntimeCall main;

  /// Box<<T as Config>::RuntimeCall>
  final _i3.RuntimeCall fallback;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'if_else': {
          'main': main.toJson(),
          'fallback': fallback.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.RuntimeCall.codec.sizeHint(main);
    size = size + _i3.RuntimeCall.codec.sizeHint(fallback);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i3.RuntimeCall.codec.encodeTo(
      main,
      output,
    );
    _i3.RuntimeCall.codec.encodeTo(
      fallback,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is IfElse && other.main == main && other.fallback == fallback;

  @override
  int get hashCode => Object.hash(
        main,
        fallback,
      );
}

/// Dispatches a function call with a provided origin.
///
/// Almost the same as [`Pallet::dispatch_as`] but forwards any error of the inner call.
///
/// The dispatch origin for this call must be _Root_.
class DispatchAsFallible extends Call {
  const DispatchAsFallible({
    required this.asOrigin,
    required this.call,
  });

  factory DispatchAsFallible._decode(_i1.Input input) {
    return DispatchAsFallible(
      asOrigin: _i4.OriginCaller.codec.decode(input),
      call: _i3.RuntimeCall.codec.decode(input),
    );
  }

  /// Box<T::PalletsOrigin>
  final _i4.OriginCaller asOrigin;

  /// Box<<T as Config>::RuntimeCall>
  final _i3.RuntimeCall call;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'dispatch_as_fallible': {
          'asOrigin': asOrigin.toJson(),
          'call': call.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.OriginCaller.codec.sizeHint(asOrigin);
    size = size + _i3.RuntimeCall.codec.sizeHint(call);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i4.OriginCaller.codec.encodeTo(
      asOrigin,
      output,
    );
    _i3.RuntimeCall.codec.encodeTo(
      call,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DispatchAsFallible && other.asOrigin == asOrigin && other.call == call;

  @override
  int get hashCode => Object.hash(
        asOrigin,
        call,
      );
}
