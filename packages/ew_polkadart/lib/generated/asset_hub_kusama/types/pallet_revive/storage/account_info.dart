// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'account_type.dart' as _i2;

class AccountInfo {
  const AccountInfo({
    required this.accountType,
    required this.dust,
  });

  factory AccountInfo.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// AccountType<T>
  final _i2.AccountType accountType;

  /// u32
  final int dust;

  static const $AccountInfoCodec codec = $AccountInfoCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'accountType': accountType.toJson(),
        'dust': dust,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AccountInfo && other.accountType == accountType && other.dust == dust;

  @override
  int get hashCode => Object.hash(
        accountType,
        dust,
      );
}

class $AccountInfoCodec with _i1.Codec<AccountInfo> {
  const $AccountInfoCodec();

  @override
  void encodeTo(
    AccountInfo obj,
    _i1.Output output,
  ) {
    _i2.AccountType.codec.encodeTo(
      obj.accountType,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.dust,
      output,
    );
  }

  @override
  AccountInfo decode(_i1.Input input) {
    return AccountInfo(
      accountType: _i2.AccountType.codec.decode(input),
      dust: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(AccountInfo obj) {
    int size = 0;
    size = size + _i2.AccountType.codec.sizeHint(obj.accountType);
    size = size + _i1.U32Codec.codec.sizeHint(obj.dust);
    return size;
  }
}
