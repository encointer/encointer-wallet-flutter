// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../b_tree_set_1.dart' as _i2;

class StorageProof {
  const StorageProof({required this.trieNodes});

  factory StorageProof.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// BTreeSet<Vec<u8>>
  final _i2.BTreeSet trieNodes;

  static const $StorageProofCodec codec = $StorageProofCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, List<List<int>>> toJson() => {'trieNodes': trieNodes.map((value) => value).toList()};

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is StorageProof &&
          _i4.listsEqual(
            other.trieNodes,
            trieNodes,
          );

  @override
  int get hashCode => trieNodes.hashCode;
}

class $StorageProofCodec with _i1.Codec<StorageProof> {
  const $StorageProofCodec();

  @override
  void encodeTo(
    StorageProof obj,
    _i1.Output output,
  ) {
    const _i1.SequenceCodec<List<int>>(_i1.U8SequenceCodec.codec).encodeTo(
      obj.trieNodes,
      output,
    );
  }

  @override
  StorageProof decode(_i1.Input input) {
    return StorageProof(trieNodes: const _i1.SequenceCodec<List<int>>(_i1.U8SequenceCodec.codec).decode(input));
  }

  @override
  int sizeHint(StorageProof obj) {
    int size = 0;
    size = size + const _i2.BTreeSetCodec().sizeHint(obj.trieNodes);
    return size;
  }

  @override
  bool isSizeZero() => const _i2.BTreeSetCodec().isSizeZero();
}
