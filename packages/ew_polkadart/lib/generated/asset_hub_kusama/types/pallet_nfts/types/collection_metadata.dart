// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i3;

class CollectionMetadata {
  const CollectionMetadata({
    required this.deposit,
    required this.data,
  });

  factory CollectionMetadata.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Deposit
  final BigInt deposit;

  /// BoundedVec<u8, StringLimit>
  final List<int> data;

  static const $CollectionMetadataCodec codec = $CollectionMetadataCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'deposit': deposit,
        'data': data,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CollectionMetadata &&
          other.deposit == deposit &&
          _i3.listsEqual(
            other.data,
            data,
          );

  @override
  int get hashCode => Object.hash(
        deposit,
        data,
      );
}

class $CollectionMetadataCodec with _i1.Codec<CollectionMetadata> {
  const $CollectionMetadataCodec();

  @override
  void encodeTo(
    CollectionMetadata obj,
    _i1.Output output,
  ) {
    _i1.U128Codec.codec.encodeTo(
      obj.deposit,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      obj.data,
      output,
    );
  }

  @override
  CollectionMetadata decode(_i1.Input input) {
    return CollectionMetadata(
      deposit: _i1.U128Codec.codec.decode(input),
      data: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  @override
  int sizeHint(CollectionMetadata obj) {
    int size = 0;
    size = size + _i1.U128Codec.codec.sizeHint(obj.deposit);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(obj.data);
    return size;
  }
}
