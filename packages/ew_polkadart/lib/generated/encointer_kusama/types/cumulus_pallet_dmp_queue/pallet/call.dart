// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../sp_weights/weight_v2/weight.dart' as _i3;

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

  ServiceOverweight serviceOverweight({
    required BigInt index,
    required _i3.Weight weightLimit,
  }) {
    return ServiceOverweight(
      index: index,
      weightLimit: weightLimit,
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
        return ServiceOverweight._decode(input);
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
      case ServiceOverweight:
        (value as ServiceOverweight).encodeTo(output);
        break;
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case ServiceOverweight:
        return (value as ServiceOverweight)._sizeHint();
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// See [`Pallet::service_overweight`].
class ServiceOverweight extends Call {
  const ServiceOverweight({
    required this.index,
    required this.weightLimit,
  });

  factory ServiceOverweight._decode(_i1.Input input) {
    return ServiceOverweight(
      index: _i1.U64Codec.codec.decode(input),
      weightLimit: _i3.Weight.codec.decode(input),
    );
  }

  /// OverweightIndex
  final BigInt index;

  /// Weight
  final _i3.Weight weightLimit;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'service_overweight': {
          'index': index,
          'weightLimit': weightLimit.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(index);
    size = size + _i3.Weight.codec.sizeHint(weightLimit);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      index,
      output,
    );
    _i3.Weight.codec.encodeTo(
      weightLimit,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ServiceOverweight && other.index == index && other.weightLimit == weightLimit;

  @override
  int get hashCode => Object.hash(
        index,
        weightLimit,
      );
}
