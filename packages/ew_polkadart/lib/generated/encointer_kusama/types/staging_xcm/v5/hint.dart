// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'location/location.dart' as _i3;

abstract class Hint {
  const Hint();

  factory Hint.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $HintCodec codec = $HintCodec();

  static const $Hint values = $Hint();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, Map<String, dynamic>>> toJson();
}

class $Hint {
  const $Hint();

  AssetClaimer assetClaimer({required _i3.Location location}) {
    return AssetClaimer(location: location);
  }
}

class $HintCodec with _i1.Codec<Hint> {
  const $HintCodec();

  @override
  Hint decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return AssetClaimer._decode(input);
      default:
        throw Exception('Hint: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Hint value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case AssetClaimer:
        (value as AssetClaimer).encodeTo(output);
        break;
      default:
        throw Exception('Hint: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Hint value) {
    switch (value.runtimeType) {
      case AssetClaimer:
        return (value as AssetClaimer)._sizeHint();
      default:
        throw Exception('Hint: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class AssetClaimer extends Hint {
  const AssetClaimer({required this.location});

  factory AssetClaimer._decode(_i1.Input input) {
    return AssetClaimer(location: _i3.Location.codec.decode(input));
  }

  /// Location
  final _i3.Location location;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'AssetClaimer': {'location': location.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(location);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.Location.codec.encodeTo(
      location,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AssetClaimer && other.location == location;

  @override
  int get hashCode => location.hashCode;
}
