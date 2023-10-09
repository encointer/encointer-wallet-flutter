// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../ep_core/bip340/bip340.dart' as _i3;

abstract class AnnouncementSigner {
  const AnnouncementSigner();

  factory AnnouncementSigner.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $AnnouncementSignerCodec codec = $AnnouncementSignerCodec();

  static const $AnnouncementSigner values = $AnnouncementSigner();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, List<int>> toJson();
}

class $AnnouncementSigner {
  const $AnnouncementSigner();

  Bip340 bip340(_i3.Bip340 value0) {
    return Bip340(value0);
  }
}

class $AnnouncementSignerCodec with _i1.Codec<AnnouncementSigner> {
  const $AnnouncementSignerCodec();

  @override
  AnnouncementSigner decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Bip340._decode(input);
      default:
        throw Exception('AnnouncementSigner: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    AnnouncementSigner value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Bip340:
        (value as Bip340).encodeTo(output);
        break;
      default:
        throw Exception('AnnouncementSigner: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(AnnouncementSigner value) {
    switch (value.runtimeType) {
      case Bip340:
        return (value as Bip340)._sizeHint();
      default:
        throw Exception('AnnouncementSigner: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Bip340 extends AnnouncementSigner {
  const Bip340(this.value0);

  factory Bip340._decode(_i1.Input input) {
    return Bip340(const _i1.U8ArrayCodec(32).decode(input));
  }

  /// Bip340
  final _i3.Bip340 value0;

  @override
  Map<String, List<int>> toJson() => {'Bip340': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.Bip340Codec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
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
      other is Bip340 &&
          _i4.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}
