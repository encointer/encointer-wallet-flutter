// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import '../../substrate_fixed/fixed_i128.dart' as _i2;
import 'dart:typed_data' as _i3;

class Location {
  const Location({
    required this.lat,
    required this.lon,
  });

  factory Location.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final _i2.FixedI128 lat;

  final _i2.FixedI128 lon;

  static const $LocationCodec codec = $LocationCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, Map<String, BigInt>> toJson() => {
        'lat': lat.toJson(),
        'lon': lon.toJson(),
      };
}

class $LocationCodec with _i1.Codec<Location> {
  const $LocationCodec();

  @override
  void encodeTo(
    Location obj,
    _i1.Output output,
  ) {
    _i2.FixedI128.codec.encodeTo(
      obj.lat,
      output,
    );
    _i2.FixedI128.codec.encodeTo(
      obj.lon,
      output,
    );
  }

  @override
  Location decode(_i1.Input input) {
    return Location(
      lat: _i2.FixedI128.codec.decode(input),
      lon: _i2.FixedI128.codec.decode(input),
    );
  }

  @override
  int sizeHint(Location obj) {
    int size = 0;
    size = size + _i2.FixedI128.codec.sizeHint(obj.lat);
    size = size + _i2.FixedI128.codec.sizeHint(obj.lon);
    return size;
  }
}
