// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

enum TrieError {
  invalidStateRoot('InvalidStateRoot', 0),
  incompleteDatabase('IncompleteDatabase', 1),
  valueAtIncompleteKey('ValueAtIncompleteKey', 2),
  decoderError('DecoderError', 3),
  invalidHash('InvalidHash', 4),
  duplicateKey('DuplicateKey', 5),
  extraneousNode('ExtraneousNode', 6),
  extraneousValue('ExtraneousValue', 7),
  extraneousHashReference('ExtraneousHashReference', 8),
  invalidChildReference('InvalidChildReference', 9),
  valueMismatch('ValueMismatch', 10),
  incompleteProof('IncompleteProof', 11),
  rootMismatch('RootMismatch', 12),
  decodeError('DecodeError', 13);

  const TrieError(
    this.variantName,
    this.codecIndex,
  );

  factory TrieError.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $TrieErrorCodec codec = $TrieErrorCodec();

  String toJson() => variantName;

  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $TrieErrorCodec with _i1.Codec<TrieError> {
  const $TrieErrorCodec();

  @override
  TrieError decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return TrieError.invalidStateRoot;
      case 1:
        return TrieError.incompleteDatabase;
      case 2:
        return TrieError.valueAtIncompleteKey;
      case 3:
        return TrieError.decoderError;
      case 4:
        return TrieError.invalidHash;
      case 5:
        return TrieError.duplicateKey;
      case 6:
        return TrieError.extraneousNode;
      case 7:
        return TrieError.extraneousValue;
      case 8:
        return TrieError.extraneousHashReference;
      case 9:
        return TrieError.invalidChildReference;
      case 10:
        return TrieError.valueMismatch;
      case 11:
        return TrieError.incompleteProof;
      case 12:
        return TrieError.rootMismatch;
      case 13:
        return TrieError.decodeError;
      default:
        throw Exception('TrieError: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    TrieError value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }

  @override
  bool isSizeZero() => false;
}
