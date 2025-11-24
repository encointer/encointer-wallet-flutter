// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../sp_arithmetic/fixed_point/fixed_u128.dart' as _i3;

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

  Map<String, Map<String, BigInt>> toJson();
}

class $Event {
  const $Event();

  DeliveryFeeFactorDecreased deliveryFeeFactorDecreased({required _i3.FixedU128 newValue}) {
    return DeliveryFeeFactorDecreased(newValue: newValue);
  }

  DeliveryFeeFactorIncreased deliveryFeeFactorIncreased({required _i3.FixedU128 newValue}) {
    return DeliveryFeeFactorIncreased(newValue: newValue);
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return DeliveryFeeFactorDecreased._decode(input);
      case 1:
        return DeliveryFeeFactorIncreased._decode(input);
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
      case DeliveryFeeFactorDecreased:
        (value as DeliveryFeeFactorDecreased).encodeTo(output);
        break;
      case DeliveryFeeFactorIncreased:
        (value as DeliveryFeeFactorIncreased).encodeTo(output);
        break;
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case DeliveryFeeFactorDecreased:
        return (value as DeliveryFeeFactorDecreased)._sizeHint();
      case DeliveryFeeFactorIncreased:
        return (value as DeliveryFeeFactorIncreased)._sizeHint();
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Delivery fee factor has been decreased.
class DeliveryFeeFactorDecreased extends Event {
  const DeliveryFeeFactorDecreased({required this.newValue});

  factory DeliveryFeeFactorDecreased._decode(_i1.Input input) {
    return DeliveryFeeFactorDecreased(newValue: _i1.U128Codec.codec.decode(input));
  }

  /// FixedU128
  /// New value of the `DeliveryFeeFactor`.
  final _i3.FixedU128 newValue;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'DeliveryFeeFactorDecreased': {'newValue': newValue}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.FixedU128Codec().sizeHint(newValue);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      newValue,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DeliveryFeeFactorDecreased && other.newValue == newValue;

  @override
  int get hashCode => newValue.hashCode;
}

/// Delivery fee factor has been increased.
class DeliveryFeeFactorIncreased extends Event {
  const DeliveryFeeFactorIncreased({required this.newValue});

  factory DeliveryFeeFactorIncreased._decode(_i1.Input input) {
    return DeliveryFeeFactorIncreased(newValue: _i1.U128Codec.codec.decode(input));
  }

  /// FixedU128
  /// New value of the `DeliveryFeeFactor`.
  final _i3.FixedU128 newValue;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'DeliveryFeeFactorIncreased': {'newValue': newValue}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.FixedU128Codec().sizeHint(newValue);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      newValue,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DeliveryFeeFactorIncreased && other.newValue == newValue;

  @override
  int get hashCode => newValue.hashCode;
}
