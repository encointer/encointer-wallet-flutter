// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import 'item_metadata_deposit.dart' as _i2;

class ItemMetadata {
  const ItemMetadata({
    required this.deposit,
    required this.data,
  });

  factory ItemMetadata.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Deposit
  final _i2.ItemMetadataDeposit deposit;

  /// BoundedVec<u8, StringLimit>
  final List<int> data;

  static const $ItemMetadataCodec codec = $ItemMetadataCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'deposit': deposit.toJson(),
        'data': data,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ItemMetadata &&
          other.deposit == deposit &&
          _i4.listsEqual(
            other.data,
            data,
          );

  @override
  int get hashCode => Object.hash(
        deposit,
        data,
      );
}

class $ItemMetadataCodec with _i1.Codec<ItemMetadata> {
  const $ItemMetadataCodec();

  @override
  void encodeTo(
    ItemMetadata obj,
    _i1.Output output,
  ) {
    _i2.ItemMetadataDeposit.codec.encodeTo(
      obj.deposit,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      obj.data,
      output,
    );
  }

  @override
  ItemMetadata decode(_i1.Input input) {
    return ItemMetadata(
      deposit: _i2.ItemMetadataDeposit.codec.decode(input),
      data: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  @override
  int sizeHint(ItemMetadata obj) {
    int size = 0;
    size = size + _i2.ItemMetadataDeposit.codec.sizeHint(obj.deposit);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(obj.data);
    return size;
  }
}
