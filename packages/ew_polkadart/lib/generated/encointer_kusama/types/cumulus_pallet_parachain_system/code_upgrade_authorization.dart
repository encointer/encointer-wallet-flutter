// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import '../primitive_types/h256.dart' as _i2;
import 'dart:typed_data' as _i3;

class CodeUpgradeAuthorization {
  const CodeUpgradeAuthorization({
    required this.codeHash,
    required this.checkVersion,
  });

  factory CodeUpgradeAuthorization.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final _i2.H256 codeHash;

  final bool checkVersion;

  static const $CodeUpgradeAuthorizationCodec codec =
      $CodeUpgradeAuthorizationCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'codeHash': codeHash.toList(),
        'checkVersion': checkVersion,
      };
}

class $CodeUpgradeAuthorizationCodec with _i1.Codec<CodeUpgradeAuthorization> {
  const $CodeUpgradeAuthorizationCodec();

  @override
  void encodeTo(
    CodeUpgradeAuthorization obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.codeHash,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      obj.checkVersion,
      output,
    );
  }

  @override
  CodeUpgradeAuthorization decode(_i1.Input input) {
    return CodeUpgradeAuthorization(
      codeHash: const _i1.U8ArrayCodec(32).decode(input),
      checkVersion: _i1.BoolCodec.codec.decode(input),
    );
  }

  @override
  int sizeHint(CodeUpgradeAuthorization obj) {
    int size = 0;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(obj.codeHash);
    size = size + _i1.BoolCodec.codec.sizeHint(obj.checkVersion);
    return size;
  }
}
