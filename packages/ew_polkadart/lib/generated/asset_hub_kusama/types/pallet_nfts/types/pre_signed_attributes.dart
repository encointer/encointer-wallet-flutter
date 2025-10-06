// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../tuples.dart' as _i2;
import 'attribute_namespace.dart' as _i3;

class PreSignedAttributes {
  const PreSignedAttributes({
    required this.collection,
    required this.item,
    required this.attributes,
    required this.namespace,
    required this.deadline,
  });

  factory PreSignedAttributes.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// CollectionId
  final int collection;

  /// ItemId
  final int item;

  /// Vec<(Vec<u8>, Vec<u8>)>
  final List<_i2.Tuple2<List<int>, List<int>>> attributes;

  /// AttributeNamespace<AccountId>
  final _i3.AttributeNamespace namespace;

  /// Deadline
  final int deadline;

  static const $PreSignedAttributesCodec codec = $PreSignedAttributesCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'collection': collection,
        'item': item,
        'attributes': attributes
            .map((value) => [
                  value.value0,
                  value.value1,
                ])
            .toList(),
        'namespace': namespace.toJson(),
        'deadline': deadline,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PreSignedAttributes &&
          other.collection == collection &&
          other.item == item &&
          _i5.listsEqual(
            other.attributes,
            attributes,
          ) &&
          other.namespace == namespace &&
          other.deadline == deadline;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        attributes,
        namespace,
        deadline,
      );
}

class $PreSignedAttributesCodec with _i1.Codec<PreSignedAttributes> {
  const $PreSignedAttributesCodec();

  @override
  void encodeTo(
    PreSignedAttributes obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.item,
      output,
    );
    const _i1.SequenceCodec<_i2.Tuple2<List<int>, List<int>>>(_i2.Tuple2Codec<List<int>, List<int>>(
      _i1.U8SequenceCodec.codec,
      _i1.U8SequenceCodec.codec,
    )).encodeTo(
      obj.attributes,
      output,
    );
    _i3.AttributeNamespace.codec.encodeTo(
      obj.namespace,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.deadline,
      output,
    );
  }

  @override
  PreSignedAttributes decode(_i1.Input input) {
    return PreSignedAttributes(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      attributes: const _i1.SequenceCodec<_i2.Tuple2<List<int>, List<int>>>(_i2.Tuple2Codec<List<int>, List<int>>(
        _i1.U8SequenceCodec.codec,
        _i1.U8SequenceCodec.codec,
      )).decode(input),
      namespace: _i3.AttributeNamespace.codec.decode(input),
      deadline: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(PreSignedAttributes obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.collection);
    size = size + _i1.U32Codec.codec.sizeHint(obj.item);
    size = size +
        const _i1.SequenceCodec<_i2.Tuple2<List<int>, List<int>>>(_i2.Tuple2Codec<List<int>, List<int>>(
          _i1.U8SequenceCodec.codec,
          _i1.U8SequenceCodec.codec,
        )).sizeHint(obj.attributes);
    size = size + _i3.AttributeNamespace.codec.sizeHint(obj.namespace);
    size = size + _i1.U32Codec.codec.sizeHint(obj.deadline);
    return size;
  }
}
