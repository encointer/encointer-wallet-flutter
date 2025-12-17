// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../cumulus_pallet_xcm/pallet/origin.dart' as _i5;
import '../frame_support/dispatch/raw_origin.dart' as _i3;
import '../pallet_collective/raw_origin.dart' as _i6;
import '../pallet_xcm/pallet/origin.dart' as _i4;

abstract class OriginCaller {
  const OriginCaller();

  factory OriginCaller.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $OriginCallerCodec codec = $OriginCallerCodec();

  static const $OriginCaller values = $OriginCaller();

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

class $OriginCaller {
  const $OriginCaller();

  System system(_i3.RawOrigin value0) {
    return System(value0);
  }

  PolkadotXcm polkadotXcm(_i4.Origin value0) {
    return PolkadotXcm(value0);
  }

  CumulusXcm cumulusXcm(_i5.Origin value0) {
    return CumulusXcm(value0);
  }

  Collective collective(_i6.RawOrigin value0) {
    return Collective(value0);
  }
}

class $OriginCallerCodec with _i1.Codec<OriginCaller> {
  const $OriginCallerCodec();

  @override
  OriginCaller decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return System._decode(input);
      case 31:
        return PolkadotXcm._decode(input);
      case 32:
        return CumulusXcm._decode(input);
      case 50:
        return Collective._decode(input);
      default:
        throw Exception('OriginCaller: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    OriginCaller value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case System:
        (value as System).encodeTo(output);
        break;
      case PolkadotXcm:
        (value as PolkadotXcm).encodeTo(output);
        break;
      case CumulusXcm:
        (value as CumulusXcm).encodeTo(output);
        break;
      case Collective:
        (value as Collective).encodeTo(output);
        break;
      default:
        throw Exception('OriginCaller: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(OriginCaller value) {
    switch (value.runtimeType) {
      case System:
        return (value as System)._sizeHint();
      case PolkadotXcm:
        return (value as PolkadotXcm)._sizeHint();
      case CumulusXcm:
        return (value as CumulusXcm)._sizeHint();
      case Collective:
        return (value as Collective)._sizeHint();
      default:
        throw Exception('OriginCaller: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class System extends OriginCaller {
  const System(this.value0);

  factory System._decode(_i1.Input input) {
    return System(_i3.RawOrigin.codec.decode(input));
  }

  /// frame_system::Origin<Runtime>
  final _i3.RawOrigin value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'system': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.RawOrigin.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.RawOrigin.codec.encodeTo(
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
      other is System && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class PolkadotXcm extends OriginCaller {
  const PolkadotXcm(this.value0);

  factory PolkadotXcm._decode(_i1.Input input) {
    return PolkadotXcm(_i4.Origin.codec.decode(input));
  }

  /// pallet_xcm::Origin
  final _i4.Origin value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'PolkadotXcm': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i4.Origin.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      31,
      output,
    );
    _i4.Origin.codec.encodeTo(
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

class CumulusXcm extends OriginCaller {
  const CumulusXcm(this.value0);

  factory CumulusXcm._decode(_i1.Input input) {
    return CumulusXcm(_i5.Origin.codec.decode(input));
  }

  /// cumulus_pallet_xcm::Origin
  final _i5.Origin value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'CumulusXcm': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i5.Origin.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      32,
      output,
    );
    _i5.Origin.codec.encodeTo(
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
      other is CumulusXcm && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Collective extends OriginCaller {
  const Collective(this.value0);

  factory Collective._decode(_i1.Input input) {
    return Collective(_i6.RawOrigin.codec.decode(input));
  }

  /// pallet_collective::Origin<Runtime, pallet_collective::Instance1>
  final _i6.RawOrigin value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Collective': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i6.RawOrigin.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      50,
      output,
    );
    _i6.RawOrigin.codec.encodeTo(
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
