// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i3;

class CommunityIdentifier {
  const CommunityIdentifier({
    required this.geohash,
    required this.digest,
  });

  factory CommunityIdentifier.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// [u8; 5]
  final List<int> geohash;

  /// [u8; 4]
  final List<int> digest;

  static const $CommunityIdentifierCodec codec = $CommunityIdentifierCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, List<int>> toJson() => {
        'geohash': geohash.toList(),
        'digest': digest.toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CommunityIdentifier &&
          _i3.listsEqual(
            other.geohash,
            geohash,
          ) &&
          _i3.listsEqual(
            other.digest,
            digest,
          );

  @override
  int get hashCode => Object.hash(
        geohash,
        digest,
      );
}

class $CommunityIdentifierCodec with _i1.Codec<CommunityIdentifier> {
  const $CommunityIdentifierCodec();

  @override
  void encodeTo(
    CommunityIdentifier obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(5).encodeTo(
      obj.geohash,
      output,
    );
    const _i1.U8ArrayCodec(4).encodeTo(
      obj.digest,
      output,
    );
  }

  @override
  CommunityIdentifier decode(_i1.Input input) {
    return CommunityIdentifier(
      geohash: const _i1.U8ArrayCodec(5).decode(input),
      digest: const _i1.U8ArrayCodec(4).decode(input),
    );
  }

  @override
  int sizeHint(CommunityIdentifier obj) {
    int size = 0;
    size = size + const _i1.U8ArrayCodec(5).sizeHint(obj.geohash);
    size = size + const _i1.U8ArrayCodec(4).sizeHint(obj.digest);
    return size;
  }
}
