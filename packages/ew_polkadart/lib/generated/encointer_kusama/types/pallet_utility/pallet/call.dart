// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../../encointer_kusama_runtime/origin_caller.dart' as _i4;
import '../../encointer_kusama_runtime/runtime_call.dart' as _i3;
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
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// See [`Pallet::batch`].
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

/// See [`Pallet::as_derivative`].
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

/// See [`Pallet::batch_all`].
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

/// See [`Pallet::dispatch_as`].
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

/// See [`Pallet::force_batch`].
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

/// See [`Pallet::with_weight`].
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
