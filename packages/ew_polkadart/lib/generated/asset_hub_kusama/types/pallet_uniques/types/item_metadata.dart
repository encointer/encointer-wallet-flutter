// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i3;

class ItemMetadata {
  const ItemMetadata({
    required this.deposit,
    required this.data,
    required this.isFrozen,
  });

  factory ItemMetadata.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// DepositBalance
  final BigInt deposit;

  /// BoundedVec<u8, StringLimit>
  final List<int> data;

  /// bool
  final bool isFrozen;

  static const $ItemMetadataCodec codec = $ItemMetadataCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'deposit': deposit,
        'data': data,
        'isFrozen': isFrozen,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ItemMetadata &&
          other.deposit == deposit &&
          _i3.listsEqual(
            other.data,
            data,
          ) &&
          other.isFrozen == isFrozen;

  @override
  int get hashCode => Object.hash(
        deposit,
        data,
        isFrozen,
      );
}

class $ItemMetadataCodec with _i1.Codec<ItemMetadata> {
  const $ItemMetadataCodec();

  @override
  void encodeTo(
    ItemMetadata obj,
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
    _i1.BoolCodec.codec.encodeTo(
      obj.isFrozen,
      output,
    );
  }

  @override
  ItemMetadata decode(_i1.Input input) {
    return ItemMetadata(
      deposit: _i1.U128Codec.codec.decode(input),
      data: _i1.U8SequenceCodec.codec.decode(input),
      isFrozen: _i1.BoolCodec.codec.decode(input),
    );
  }

  @override
  int sizeHint(ItemMetadata obj) {
    int size = 0;
    size = size + _i1.U128Codec.codec.sizeHint(obj.deposit);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(obj.data);
    size = size + _i1.BoolCodec.codec.sizeHint(obj.isFrozen);
    return size;
  }
}
