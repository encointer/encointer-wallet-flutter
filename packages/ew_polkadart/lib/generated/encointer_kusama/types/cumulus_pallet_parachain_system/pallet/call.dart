// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;
import '../../cumulus_primitives_parachain_inherent/parachain_inherent_data.dart'
    as _i3;
import '../../primitive_types/h256.dart' as _i4;

/// Contains a variant per dispatchable extrinsic that this pallet has.
abstract class Call {
  const Call();

  factory Call.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CallCodec codec = $CallCodec();

  static const $Call values = $Call();

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

class $Call {
  const $Call();

  SetValidationData setValidationData(
      {required _i3.ParachainInherentData data}) {
    return SetValidationData(
      data: data,
    );
  }

  SudoSendUpwardMessage sudoSendUpwardMessage({required List<int> message}) {
    return SudoSendUpwardMessage(
      message: message,
    );
  }

  AuthorizeUpgrade authorizeUpgrade({
    required _i4.H256 codeHash,
    required bool checkVersion,
  }) {
    return AuthorizeUpgrade(
      codeHash: codeHash,
      checkVersion: checkVersion,
    );
  }

  EnactAuthorizedUpgrade enactAuthorizedUpgrade({required List<int> code}) {
    return EnactAuthorizedUpgrade(
      code: code,
    );
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return SetValidationData._decode(input);
      case 1:
        return SudoSendUpwardMessage._decode(input);
      case 2:
        return AuthorizeUpgrade._decode(input);
      case 3:
        return EnactAuthorizedUpgrade._decode(input);
      default:
        throw Exception('Call: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Call value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case SetValidationData:
        (value as SetValidationData).encodeTo(output);
        break;
      case SudoSendUpwardMessage:
        (value as SudoSendUpwardMessage).encodeTo(output);
        break;
      case AuthorizeUpgrade:
        (value as AuthorizeUpgrade).encodeTo(output);
        break;
      case EnactAuthorizedUpgrade:
        (value as EnactAuthorizedUpgrade).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case SetValidationData:
        return (value as SetValidationData)._sizeHint();
      case SudoSendUpwardMessage:
        return (value as SudoSendUpwardMessage)._sizeHint();
      case AuthorizeUpgrade:
        return (value as AuthorizeUpgrade)._sizeHint();
      case EnactAuthorizedUpgrade:
        return (value as EnactAuthorizedUpgrade)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// See [`Pallet::set_validation_data`].
class SetValidationData extends Call {
  const SetValidationData({required this.data});

  factory SetValidationData._decode(_i1.Input input) {
    return SetValidationData(
      data: _i3.ParachainInherentData.codec.decode(input),
    );
  }

  final _i3.ParachainInherentData data;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'set_validation_data': {'data': data.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.ParachainInherentData.codec.sizeHint(data);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.ParachainInherentData.codec.encodeTo(
      data,
      output,
    );
  }
}

/// See [`Pallet::sudo_send_upward_message`].
class SudoSendUpwardMessage extends Call {
  const SudoSendUpwardMessage({required this.message});

  factory SudoSendUpwardMessage._decode(_i1.Input input) {
    return SudoSendUpwardMessage(
      message: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  final List<int> message;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'sudo_send_upward_message': {'message': message}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(message);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      message,
      output,
    );
  }
}

/// See [`Pallet::authorize_upgrade`].
class AuthorizeUpgrade extends Call {
  const AuthorizeUpgrade({
    required this.codeHash,
    required this.checkVersion,
  });

  factory AuthorizeUpgrade._decode(_i1.Input input) {
    return AuthorizeUpgrade(
      codeHash: const _i1.U8ArrayCodec(32).decode(input),
      checkVersion: _i1.BoolCodec.codec.decode(input),
    );
  }

  final _i4.H256 codeHash;

  final bool checkVersion;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'authorize_upgrade': {
          'codeHash': codeHash.toList(),
          'checkVersion': checkVersion,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(codeHash);
    size = size + _i1.BoolCodec.codec.sizeHint(checkVersion);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      codeHash,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      checkVersion,
      output,
    );
  }
}

/// See [`Pallet::enact_authorized_upgrade`].
class EnactAuthorizedUpgrade extends Call {
  const EnactAuthorizedUpgrade({required this.code});

  factory EnactAuthorizedUpgrade._decode(_i1.Input input) {
    return EnactAuthorizedUpgrade(
      code: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  final List<int> code;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'enact_authorized_upgrade': {'code': code}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(code);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      code,
      output,
    );
  }
}
