// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i3;

class Groth16ProofBytes {
  const Groth16ProofBytes({required this.proofBytes});

  factory Groth16ProofBytes.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// frame_support::BoundedVec<u8, S>
  final List<int> proofBytes;

  static const $Groth16ProofBytesCodec codec = $Groth16ProofBytesCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, List<int>> toJson() => {'proofBytes': proofBytes};

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Groth16ProofBytes &&
          _i3.listsEqual(
            other.proofBytes,
            proofBytes,
          );

  @override
  int get hashCode => proofBytes.hashCode;
}

class $Groth16ProofBytesCodec with _i1.Codec<Groth16ProofBytes> {
  const $Groth16ProofBytesCodec();

  @override
  void encodeTo(
    Groth16ProofBytes obj,
    _i1.Output output,
  ) {
    _i1.U8SequenceCodec.codec.encodeTo(
      obj.proofBytes,
      output,
    );
  }

  @override
  Groth16ProofBytes decode(_i1.Input input) {
    return Groth16ProofBytes(proofBytes: _i1.U8SequenceCodec.codec.decode(input));
  }

  @override
  int sizeHint(Groth16ProofBytes obj) {
    int size = 0;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(obj.proofBytes);
    return size;
  }
}
