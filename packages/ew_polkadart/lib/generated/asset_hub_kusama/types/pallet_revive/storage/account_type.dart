// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'contract_info.dart' as _i3;

abstract class AccountType {
  const AccountType();

  factory AccountType.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $AccountTypeCodec codec = $AccountTypeCodec();

  static const $AccountType values = $AccountType();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, dynamic> toJson();
}

class $AccountType {
  const $AccountType();

  Contract contract(_i3.ContractInfo value0) {
    return Contract(value0);
  }

  Eoa eoa() {
    return Eoa();
  }
}

class $AccountTypeCodec with _i1.Codec<AccountType> {
  const $AccountTypeCodec();

  @override
  AccountType decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Contract._decode(input);
      case 1:
        return const Eoa();
      default:
        throw Exception('AccountType: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    AccountType value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Contract:
        (value as Contract).encodeTo(output);
        break;
      case Eoa:
        (value as Eoa).encodeTo(output);
        break;
      default:
        throw Exception('AccountType: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(AccountType value) {
    switch (value.runtimeType) {
      case Contract:
        return (value as Contract)._sizeHint();
      case Eoa:
        return 1;
      default:
        throw Exception('AccountType: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Contract extends AccountType {
  const Contract(this.value0);

  factory Contract._decode(_i1.Input input) {
    return Contract(_i3.ContractInfo.codec.decode(input));
  }

  /// ContractInfo<T>
  final _i3.ContractInfo value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Contract': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.ContractInfo.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.ContractInfo.codec.encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Contract && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Eoa extends AccountType {
  const Eoa();

  @override
  Map<String, dynamic> toJson() => {'EOA': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Eoa;

  @override
  int get hashCode => runtimeType.hashCode;
}
