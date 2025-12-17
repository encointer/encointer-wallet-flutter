// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../pallet_collective/pallet/hold_reason.dart' as _i5;
import '../pallet_session/pallet/hold_reason.dart' as _i3;
import '../pallet_xcm/pallet/hold_reason.dart' as _i4;

abstract class RuntimeHoldReason {
  const RuntimeHoldReason();

  factory RuntimeHoldReason.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $RuntimeHoldReasonCodec codec = $RuntimeHoldReasonCodec();

  static const $RuntimeHoldReason values = $RuntimeHoldReason();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, String> toJson();
}

class $RuntimeHoldReason {
  const $RuntimeHoldReason();

  Session session(_i3.HoldReason value0) {
    return Session(value0);
  }

  PolkadotXcm polkadotXcm(_i4.HoldReason value0) {
    return PolkadotXcm(value0);
  }

  Collective collective(_i5.HoldReason value0) {
    return Collective(value0);
  }
}

class $RuntimeHoldReasonCodec with _i1.Codec<RuntimeHoldReason> {
  const $RuntimeHoldReasonCodec();

  @override
  RuntimeHoldReason decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 22:
        return Session._decode(input);
      case 31:
        return PolkadotXcm._decode(input);
      case 50:
        return Collective._decode(input);
      default:
        throw Exception('RuntimeHoldReason: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    RuntimeHoldReason value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Session:
        (value as Session).encodeTo(output);
        break;
      case PolkadotXcm:
        (value as PolkadotXcm).encodeTo(output);
        break;
      case Collective:
        (value as Collective).encodeTo(output);
        break;
      default:
        throw Exception('RuntimeHoldReason: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(RuntimeHoldReason value) {
    switch (value.runtimeType) {
      case Session:
        return (value as Session)._sizeHint();
      case PolkadotXcm:
        return (value as PolkadotXcm)._sizeHint();
      case Collective:
        return (value as Collective)._sizeHint();
      default:
        throw Exception('RuntimeHoldReason: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Session extends RuntimeHoldReason {
  const Session(this.value0);

  factory Session._decode(_i1.Input input) {
    return Session(_i3.HoldReason.codec.decode(input));
  }

  /// pallet_session::HoldReason
  final _i3.HoldReason value0;

  @override
  Map<String, String> toJson() => {'Session': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.HoldReason.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      22,
      output,
    );
    _i3.HoldReason.codec.encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Session && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class PolkadotXcm extends RuntimeHoldReason {
  const PolkadotXcm(this.value0);

  factory PolkadotXcm._decode(_i1.Input input) {
    return PolkadotXcm(_i4.HoldReason.codec.decode(input));
  }

  /// pallet_xcm::HoldReason
  final _i4.HoldReason value0;

  @override
  Map<String, String> toJson() => {'PolkadotXcm': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i4.HoldReason.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      31,
      output,
    );
    _i4.HoldReason.codec.encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PolkadotXcm && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Collective extends RuntimeHoldReason {
  const Collective(this.value0);

  factory Collective._decode(_i1.Input input) {
    return Collective(_i5.HoldReason.codec.decode(input));
  }

  /// pallet_collective::HoldReason<pallet_collective::Instance1>
  final _i5.HoldReason value0;

  @override
  Map<String, String> toJson() => {'Collective': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i5.HoldReason.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      50,
      output,
    );
    _i5.HoldReason.codec.encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Collective && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
