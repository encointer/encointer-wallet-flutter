// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../xcm/versioned_location.dart' as _i2;

class OriginAliaser {
  const OriginAliaser({
    required this.location,
    this.expiry,
  });

  factory OriginAliaser.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// VersionedLocation
  final _i2.VersionedLocation location;

  /// Option<u64>
  final BigInt? expiry;

  static const $OriginAliaserCodec codec = $OriginAliaserCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
        'expiry': expiry,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is OriginAliaser && other.location == location && other.expiry == expiry;

  @override
  int get hashCode => Object.hash(
        location,
        expiry,
      );
}

class $OriginAliaserCodec with _i1.Codec<OriginAliaser> {
  const $OriginAliaserCodec();

  @override
  void encodeTo(
    OriginAliaser obj,
    _i1.Output output,
  ) {
    _i2.VersionedLocation.codec.encodeTo(
      obj.location,
      output,
    );
    const _i1.OptionCodec<BigInt>(_i1.U64Codec.codec).encodeTo(
      obj.expiry,
      output,
    );
  }

  @override
  OriginAliaser decode(_i1.Input input) {
    return OriginAliaser(
      location: _i2.VersionedLocation.codec.decode(input),
      expiry: const _i1.OptionCodec<BigInt>(_i1.U64Codec.codec).decode(input),
    );
  }

  @override
  int sizeHint(OriginAliaser obj) {
    int size = 0;
    size = size + _i2.VersionedLocation.codec.sizeHint(obj.location);
    size = size + const _i1.OptionCodec<BigInt>(_i1.U64Codec.codec).sizeHint(obj.expiry);
    return size;
  }
}
