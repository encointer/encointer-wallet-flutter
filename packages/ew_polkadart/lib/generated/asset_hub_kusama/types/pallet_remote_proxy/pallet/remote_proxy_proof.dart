// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i3;

abstract class RemoteProxyProof {
  const RemoteProxyProof();

  factory RemoteProxyProof.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $RemoteProxyProofCodec codec = $RemoteProxyProofCodec();

  static const $RemoteProxyProof values = $RemoteProxyProof();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, dynamic>> toJson();
}

class $RemoteProxyProof {
  const $RemoteProxyProof();

  RelayChain relayChain({
    required List<List<int>> proof,
    required int block,
  }) {
    return RelayChain(
      proof: proof,
      block: block,
    );
  }
}

class $RemoteProxyProofCodec with _i1.Codec<RemoteProxyProof> {
  const $RemoteProxyProofCodec();

  @override
  RemoteProxyProof decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return RelayChain._decode(input);
      default:
        throw Exception('RemoteProxyProof: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    RemoteProxyProof value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case RelayChain:
        (value as RelayChain).encodeTo(output);
        break;
      default:
        throw Exception('RemoteProxyProof: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(RemoteProxyProof value) {
    switch (value.runtimeType) {
      case RelayChain:
        return (value as RelayChain)._sizeHint();
      default:
        throw Exception('RemoteProxyProof: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class RelayChain extends RemoteProxyProof {
  const RelayChain({
    required this.proof,
    required this.block,
  });

  factory RelayChain._decode(_i1.Input input) {
    return RelayChain(
      proof: const _i1.SequenceCodec<List<int>>(_i1.U8SequenceCodec.codec).decode(input),
      block: _i1.U32Codec.codec.decode(input),
    );
  }

  /// Vec<Vec<u8>>
  final List<List<int>> proof;

  /// RemoteBlockNumber
  final int block;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'RelayChain': {
          'proof': proof.map((value) => value).toList(),
          'block': block,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.SequenceCodec<List<int>>(_i1.U8SequenceCodec.codec).sizeHint(proof);
    size = size + _i1.U32Codec.codec.sizeHint(block);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.SequenceCodec<List<int>>(_i1.U8SequenceCodec.codec).encodeTo(
      proof,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      block,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RelayChain &&
          _i3.listsEqual(
            other.proof,
            proof,
          ) &&
          other.block == block;

  @override
  int get hashCode => Object.hash(
        proof,
        block,
      );
}
