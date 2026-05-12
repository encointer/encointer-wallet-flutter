// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../sp_weights/weight_v2/weight.dart' as _i3;

abstract class BlockWeightMode {
  const BlockWeightMode();

  factory BlockWeightMode.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $BlockWeightModeCodec codec = $BlockWeightModeCodec();

  static const $BlockWeightMode values = $BlockWeightMode();

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

class $BlockWeightMode {
  const $BlockWeightMode();

  FullCore fullCore({required int context}) {
    return FullCore(context: context);
  }

  PotentialFullCore potentialFullCore({
    required int context,
    int? firstTransactionIndex,
    required _i3.Weight targetWeight,
  }) {
    return PotentialFullCore(
      context: context,
      firstTransactionIndex: firstTransactionIndex,
      targetWeight: targetWeight,
    );
  }

  FractionOfCore fractionOfCore({
    required int context,
    int? firstTransactionIndex,
  }) {
    return FractionOfCore(
      context: context,
      firstTransactionIndex: firstTransactionIndex,
    );
  }
}

class $BlockWeightModeCodec with _i1.Codec<BlockWeightMode> {
  const $BlockWeightModeCodec();

  @override
  BlockWeightMode decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return FullCore._decode(input);
      case 1:
        return PotentialFullCore._decode(input);
      case 2:
        return FractionOfCore._decode(input);
      default:
        throw Exception('BlockWeightMode: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    BlockWeightMode value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case FullCore:
        (value as FullCore).encodeTo(output);
        break;
      case PotentialFullCore:
        (value as PotentialFullCore).encodeTo(output);
        break;
      case FractionOfCore:
        (value as FractionOfCore).encodeTo(output);
        break;
      default:
        throw Exception('BlockWeightMode: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(BlockWeightMode value) {
    switch (value.runtimeType) {
      case FullCore:
        return (value as FullCore)._sizeHint();
      case PotentialFullCore:
        return (value as PotentialFullCore)._sizeHint();
      case FractionOfCore:
        return (value as FractionOfCore)._sizeHint();
      default:
        throw Exception('BlockWeightMode: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class FullCore extends BlockWeightMode {
  const FullCore({required this.context});

  factory FullCore._decode(_i1.Input input) {
    return FullCore(context: _i1.U32Codec.codec.decode(input));
  }

  /// BlockNumberFor<T>
  final int context;

  @override
  Map<String, Map<String, int>> toJson() => {
        'FullCore': {'context': context}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(context);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      context,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is FullCore && other.context == context;

  @override
  int get hashCode => context.hashCode;
}

class PotentialFullCore extends BlockWeightMode {
  const PotentialFullCore({
    required this.context,
    this.firstTransactionIndex,
    required this.targetWeight,
  });

  factory PotentialFullCore._decode(_i1.Input input) {
    return PotentialFullCore(
      context: _i1.U32Codec.codec.decode(input),
      firstTransactionIndex: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      targetWeight: _i3.Weight.codec.decode(input),
    );
  }

  /// BlockNumberFor<T>
  final int context;

  /// Option<u32>
  final int? firstTransactionIndex;

  /// Weight
  final _i3.Weight targetWeight;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'PotentialFullCore': {
          'context': context,
          'firstTransactionIndex': firstTransactionIndex,
          'targetWeight': targetWeight.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(context);
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(firstTransactionIndex);
    size = size + _i3.Weight.codec.sizeHint(targetWeight);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      context,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      firstTransactionIndex,
      output,
    );
    _i3.Weight.codec.encodeTo(
      targetWeight,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PotentialFullCore &&
          other.context == context &&
          other.firstTransactionIndex == firstTransactionIndex &&
          other.targetWeight == targetWeight;

  @override
  int get hashCode => Object.hash(
        context,
        firstTransactionIndex,
        targetWeight,
      );
}

class FractionOfCore extends BlockWeightMode {
  const FractionOfCore({
    required this.context,
    this.firstTransactionIndex,
  });

  factory FractionOfCore._decode(_i1.Input input) {
    return FractionOfCore(
      context: _i1.U32Codec.codec.decode(input),
      firstTransactionIndex: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
    );
  }

  /// BlockNumberFor<T>
  final int context;

  /// Option<u32>
  final int? firstTransactionIndex;

  @override
  Map<String, Map<String, int?>> toJson() => {
        'FractionOfCore': {
          'context': context,
          'firstTransactionIndex': firstTransactionIndex,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(context);
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(firstTransactionIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      context,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      firstTransactionIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is FractionOfCore && other.context == context && other.firstTransactionIndex == firstTransactionIndex;

  @override
  int get hashCode => Object.hash(
        context,
        firstTransactionIndex,
      );
}
