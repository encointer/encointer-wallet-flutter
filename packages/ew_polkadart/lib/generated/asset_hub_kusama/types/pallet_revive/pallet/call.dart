// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i8;

import '../../asset_hub_kusama_runtime/runtime_call.dart' as _i7;
import '../../primitive_types/h160.dart' as _i3;
import '../../primitive_types/h256.dart' as _i5;
import '../../primitive_types/u256.dart' as _i6;
import '../../sp_weights/weight_v2/weight.dart' as _i4;

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

  Map<String, dynamic> toJson();
}

class $Call {
  const $Call();

  EthTransact ethTransact({required List<int> payload}) {
    return EthTransact(payload: payload);
  }

  CallVariant callVariant({
    required _i3.H160 dest,
    required BigInt value,
    required _i4.Weight gasLimit,
    required BigInt storageDepositLimit,
    required List<int> data,
  }) {
    return CallVariant(
      dest: dest,
      value: value,
      gasLimit: gasLimit,
      storageDepositLimit: storageDepositLimit,
      data: data,
    );
  }

  Instantiate instantiate({
    required BigInt value,
    required _i4.Weight gasLimit,
    required BigInt storageDepositLimit,
    required _i5.H256 codeHash,
    required List<int> data,
    List<int>? salt,
  }) {
    return Instantiate(
      value: value,
      gasLimit: gasLimit,
      storageDepositLimit: storageDepositLimit,
      codeHash: codeHash,
      data: data,
      salt: salt,
    );
  }

  InstantiateWithCode instantiateWithCode({
    required BigInt value,
    required _i4.Weight gasLimit,
    required BigInt storageDepositLimit,
    required List<int> code,
    required List<int> data,
    List<int>? salt,
  }) {
    return InstantiateWithCode(
      value: value,
      gasLimit: gasLimit,
      storageDepositLimit: storageDepositLimit,
      code: code,
      data: data,
      salt: salt,
    );
  }

  EthInstantiateWithCode ethInstantiateWithCode({
    required _i6.U256 value,
    required _i4.Weight gasLimit,
    required BigInt storageDepositLimit,
    required List<int> code,
    required List<int> data,
  }) {
    return EthInstantiateWithCode(
      value: value,
      gasLimit: gasLimit,
      storageDepositLimit: storageDepositLimit,
      code: code,
      data: data,
    );
  }

  EthCall ethCall({
    required _i3.H160 dest,
    required _i6.U256 value,
    required _i4.Weight gasLimit,
    required BigInt storageDepositLimit,
    required List<int> data,
  }) {
    return EthCall(
      dest: dest,
      value: value,
      gasLimit: gasLimit,
      storageDepositLimit: storageDepositLimit,
      data: data,
    );
  }

  UploadCode uploadCode({
    required List<int> code,
    required BigInt storageDepositLimit,
  }) {
    return UploadCode(
      code: code,
      storageDepositLimit: storageDepositLimit,
    );
  }

  RemoveCode removeCode({required _i5.H256 codeHash}) {
    return RemoveCode(codeHash: codeHash);
  }

  SetCode setCode({
    required _i3.H160 dest,
    required _i5.H256 codeHash,
  }) {
    return SetCode(
      dest: dest,
      codeHash: codeHash,
    );
  }

  MapAccount mapAccount() {
    return MapAccount();
  }

  UnmapAccount unmapAccount() {
    return UnmapAccount();
  }

  DispatchAsFallbackAccount dispatchAsFallbackAccount({required _i7.RuntimeCall call}) {
    return DispatchAsFallbackAccount(call: call);
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return EthTransact._decode(input);
      case 1:
        return CallVariant._decode(input);
      case 2:
        return Instantiate._decode(input);
      case 3:
        return InstantiateWithCode._decode(input);
      case 10:
        return EthInstantiateWithCode._decode(input);
      case 11:
        return EthCall._decode(input);
      case 4:
        return UploadCode._decode(input);
      case 5:
        return RemoveCode._decode(input);
      case 6:
        return SetCode._decode(input);
      case 7:
        return const MapAccount();
      case 8:
        return const UnmapAccount();
      case 9:
        return DispatchAsFallbackAccount._decode(input);
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
      case EthTransact:
        (value as EthTransact).encodeTo(output);
        break;
      case CallVariant:
        (value as CallVariant).encodeTo(output);
        break;
      case Instantiate:
        (value as Instantiate).encodeTo(output);
        break;
      case InstantiateWithCode:
        (value as InstantiateWithCode).encodeTo(output);
        break;
      case EthInstantiateWithCode:
        (value as EthInstantiateWithCode).encodeTo(output);
        break;
      case EthCall:
        (value as EthCall).encodeTo(output);
        break;
      case UploadCode:
        (value as UploadCode).encodeTo(output);
        break;
      case RemoveCode:
        (value as RemoveCode).encodeTo(output);
        break;
      case SetCode:
        (value as SetCode).encodeTo(output);
        break;
      case MapAccount:
        (value as MapAccount).encodeTo(output);
        break;
      case UnmapAccount:
        (value as UnmapAccount).encodeTo(output);
        break;
      case DispatchAsFallbackAccount:
        (value as DispatchAsFallbackAccount).encodeTo(output);
        break;
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case EthTransact:
        return (value as EthTransact)._sizeHint();
      case CallVariant:
        return (value as CallVariant)._sizeHint();
      case Instantiate:
        return (value as Instantiate)._sizeHint();
      case InstantiateWithCode:
        return (value as InstantiateWithCode)._sizeHint();
      case EthInstantiateWithCode:
        return (value as EthInstantiateWithCode)._sizeHint();
      case EthCall:
        return (value as EthCall)._sizeHint();
      case UploadCode:
        return (value as UploadCode)._sizeHint();
      case RemoveCode:
        return (value as RemoveCode)._sizeHint();
      case SetCode:
        return (value as SetCode)._sizeHint();
      case MapAccount:
        return 1;
      case UnmapAccount:
        return 1;
      case DispatchAsFallbackAccount:
        return (value as DispatchAsFallbackAccount)._sizeHint();
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// A raw EVM transaction, typically dispatched by an Ethereum JSON-RPC server.
///
/// # Parameters
///
/// * `payload`: The encoded [`crate::evm::TransactionSigned`].
/// * `gas_limit`: The gas limit enforced during contract execution.
/// * `storage_deposit_limit`: The maximum balance that can be charged to the caller for
///  storage usage.
///
/// # Note
///
/// This call cannot be dispatched directly; attempting to do so will result in a failed
/// transaction. It serves as a wrapper for an Ethereum transaction. When submitted, the
/// runtime converts it into a [`sp_runtime::generic::CheckedExtrinsic`] by recovering the
/// signer and validating the transaction.
class EthTransact extends Call {
  const EthTransact({required this.payload});

  factory EthTransact._decode(_i1.Input input) {
    return EthTransact(payload: _i1.U8SequenceCodec.codec.decode(input));
  }

  /// Vec<u8>
  final List<int> payload;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'eth_transact': {'payload': payload}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(payload);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      payload,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is EthTransact &&
          _i8.listsEqual(
            other.payload,
            payload,
          );

  @override
  int get hashCode => payload.hashCode;
}

/// Makes a call to an account, optionally transferring some balance.
///
/// # Parameters
///
/// * `dest`: Address of the contract to call.
/// * `value`: The balance to transfer from the `origin` to `dest`.
/// * `gas_limit`: The gas limit enforced when executing the constructor.
/// * `storage_deposit_limit`: The maximum amount of balance that can be charged from the
///  caller to pay for the storage consumed.
/// * `data`: The input data to pass to the contract.
///
/// * If the account is a smart-contract account, the associated code will be
/// executed and any value will be transferred.
/// * If the account is a regular account, any value will be transferred.
/// * If no account exists and the call value is not less than `existential_deposit`,
/// a regular account will be created and any value will be transferred.
class CallVariant extends Call {
  const CallVariant({
    required this.dest,
    required this.value,
    required this.gasLimit,
    required this.storageDepositLimit,
    required this.data,
  });

  factory CallVariant._decode(_i1.Input input) {
    return CallVariant(
      dest: const _i1.U8ArrayCodec(20).decode(input),
      value: _i1.CompactBigIntCodec.codec.decode(input),
      gasLimit: _i4.Weight.codec.decode(input),
      storageDepositLimit: _i1.CompactBigIntCodec.codec.decode(input),
      data: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// H160
  final _i3.H160 dest;

  /// BalanceOf<T>
  final BigInt value;

  /// Weight
  final _i4.Weight gasLimit;

  /// BalanceOf<T>
  final BigInt storageDepositLimit;

  /// Vec<u8>
  final List<int> data;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'call': {
          'dest': dest.toList(),
          'value': value,
          'gasLimit': gasLimit.toJson(),
          'storageDepositLimit': storageDepositLimit,
          'data': data,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.H160Codec().sizeHint(dest);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(value);
    size = size + _i4.Weight.codec.sizeHint(gasLimit);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(storageDepositLimit);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(data);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(20).encodeTo(
      dest,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      value,
      output,
    );
    _i4.Weight.codec.encodeTo(
      gasLimit,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      storageDepositLimit,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      data,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CallVariant &&
          _i8.listsEqual(
            other.dest,
            dest,
          ) &&
          other.value == value &&
          other.gasLimit == gasLimit &&
          other.storageDepositLimit == storageDepositLimit &&
          _i8.listsEqual(
            other.data,
            data,
          );

  @override
  int get hashCode => Object.hash(
        dest,
        value,
        gasLimit,
        storageDepositLimit,
        data,
      );
}

/// Instantiates a contract from a previously deployed vm binary.
///
/// This function is identical to [`Self::instantiate_with_code`] but without the
/// code deployment step. Instead, the `code_hash` of an on-chain deployed vm binary
/// must be supplied.
class Instantiate extends Call {
  const Instantiate({
    required this.value,
    required this.gasLimit,
    required this.storageDepositLimit,
    required this.codeHash,
    required this.data,
    this.salt,
  });

  factory Instantiate._decode(_i1.Input input) {
    return Instantiate(
      value: _i1.CompactBigIntCodec.codec.decode(input),
      gasLimit: _i4.Weight.codec.decode(input),
      storageDepositLimit: _i1.CompactBigIntCodec.codec.decode(input),
      codeHash: const _i1.U8ArrayCodec(32).decode(input),
      data: _i1.U8SequenceCodec.codec.decode(input),
      salt: const _i1.OptionCodec<List<int>>(_i1.U8ArrayCodec(32)).decode(input),
    );
  }

  /// BalanceOf<T>
  final BigInt value;

  /// Weight
  final _i4.Weight gasLimit;

  /// BalanceOf<T>
  final BigInt storageDepositLimit;

  /// sp_core::H256
  final _i5.H256 codeHash;

  /// Vec<u8>
  final List<int> data;

  /// Option<[u8; 32]>
  final List<int>? salt;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'instantiate': {
          'value': value,
          'gasLimit': gasLimit.toJson(),
          'storageDepositLimit': storageDepositLimit,
          'codeHash': codeHash.toList(),
          'data': data,
          'salt': salt?.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(value);
    size = size + _i4.Weight.codec.sizeHint(gasLimit);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(storageDepositLimit);
    size = size + const _i5.H256Codec().sizeHint(codeHash);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(data);
    size = size + const _i1.OptionCodec<List<int>>(_i1.U8ArrayCodec(32)).sizeHint(salt);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      value,
      output,
    );
    _i4.Weight.codec.encodeTo(
      gasLimit,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      storageDepositLimit,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      codeHash,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      data,
      output,
    );
    const _i1.OptionCodec<List<int>>(_i1.U8ArrayCodec(32)).encodeTo(
      salt,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Instantiate &&
          other.value == value &&
          other.gasLimit == gasLimit &&
          other.storageDepositLimit == storageDepositLimit &&
          _i8.listsEqual(
            other.codeHash,
            codeHash,
          ) &&
          _i8.listsEqual(
            other.data,
            data,
          ) &&
          other.salt == salt;

  @override
  int get hashCode => Object.hash(
        value,
        gasLimit,
        storageDepositLimit,
        codeHash,
        data,
        salt,
      );
}

/// Instantiates a new contract from the supplied `code` optionally transferring
/// some balance.
///
/// This dispatchable has the same effect as calling [`Self::upload_code`] +
/// [`Self::instantiate`]. Bundling them together provides efficiency gains. Please
/// also check the documentation of [`Self::upload_code`].
///
/// # Parameters
///
/// * `value`: The balance to transfer from the `origin` to the newly created contract.
/// * `gas_limit`: The gas limit enforced when executing the constructor.
/// * `storage_deposit_limit`: The maximum amount of balance that can be charged/reserved
///  from the caller to pay for the storage consumed.
/// * `code`: The contract code to deploy in raw bytes.
/// * `data`: The input data to pass to the contract constructor.
/// * `salt`: Used for the address derivation. If `Some` is supplied then `CREATE2`
/// 	semantics are used. If `None` then `CRATE1` is used.
///
///
/// Instantiation is executed as follows:
///
/// - The supplied `code` is deployed, and a `code_hash` is created for that code.
/// - If the `code_hash` already exists on the chain the underlying `code` will be shared.
/// - The destination address is computed based on the sender, code_hash and the salt.
/// - The smart-contract account is created at the computed address.
/// - The `value` is transferred to the new account.
/// - The `deploy` function is executed in the context of the newly-created account.
class InstantiateWithCode extends Call {
  const InstantiateWithCode({
    required this.value,
    required this.gasLimit,
    required this.storageDepositLimit,
    required this.code,
    required this.data,
    this.salt,
  });

  factory InstantiateWithCode._decode(_i1.Input input) {
    return InstantiateWithCode(
      value: _i1.CompactBigIntCodec.codec.decode(input),
      gasLimit: _i4.Weight.codec.decode(input),
      storageDepositLimit: _i1.CompactBigIntCodec.codec.decode(input),
      code: _i1.U8SequenceCodec.codec.decode(input),
      data: _i1.U8SequenceCodec.codec.decode(input),
      salt: const _i1.OptionCodec<List<int>>(_i1.U8ArrayCodec(32)).decode(input),
    );
  }

  /// BalanceOf<T>
  final BigInt value;

  /// Weight
  final _i4.Weight gasLimit;

  /// BalanceOf<T>
  final BigInt storageDepositLimit;

  /// Vec<u8>
  final List<int> code;

  /// Vec<u8>
  final List<int> data;

  /// Option<[u8; 32]>
  final List<int>? salt;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'instantiate_with_code': {
          'value': value,
          'gasLimit': gasLimit.toJson(),
          'storageDepositLimit': storageDepositLimit,
          'code': code,
          'data': data,
          'salt': salt?.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(value);
    size = size + _i4.Weight.codec.sizeHint(gasLimit);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(storageDepositLimit);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(code);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(data);
    size = size + const _i1.OptionCodec<List<int>>(_i1.U8ArrayCodec(32)).sizeHint(salt);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      value,
      output,
    );
    _i4.Weight.codec.encodeTo(
      gasLimit,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      storageDepositLimit,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      code,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      data,
      output,
    );
    const _i1.OptionCodec<List<int>>(_i1.U8ArrayCodec(32)).encodeTo(
      salt,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is InstantiateWithCode &&
          other.value == value &&
          other.gasLimit == gasLimit &&
          other.storageDepositLimit == storageDepositLimit &&
          _i8.listsEqual(
            other.code,
            code,
          ) &&
          _i8.listsEqual(
            other.data,
            data,
          ) &&
          other.salt == salt;

  @override
  int get hashCode => Object.hash(
        value,
        gasLimit,
        storageDepositLimit,
        code,
        data,
        salt,
      );
}

/// Same as [`Self::instantiate_with_code`], but intended to be dispatched **only**
/// by an EVM transaction through the EVM compatibility layer.
///
/// Calling this dispatchable ensures that the origin's nonce is bumped only once,
/// via the `CheckNonce` transaction extension. In contrast, [`Self::instantiate_with_code`]
/// also bumps the nonce after contract instantiation, since it may be invoked multiple
/// times within a batch call transaction.
class EthInstantiateWithCode extends Call {
  const EthInstantiateWithCode({
    required this.value,
    required this.gasLimit,
    required this.storageDepositLimit,
    required this.code,
    required this.data,
  });

  factory EthInstantiateWithCode._decode(_i1.Input input) {
    return EthInstantiateWithCode(
      value: const _i1.U64ArrayCodec(4).decode(input),
      gasLimit: _i4.Weight.codec.decode(input),
      storageDepositLimit: _i1.CompactBigIntCodec.codec.decode(input),
      code: _i1.U8SequenceCodec.codec.decode(input),
      data: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// U256
  final _i6.U256 value;

  /// Weight
  final _i4.Weight gasLimit;

  /// BalanceOf<T>
  final BigInt storageDepositLimit;

  /// Vec<u8>
  final List<int> code;

  /// Vec<u8>
  final List<int> data;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'eth_instantiate_with_code': {
          'value': value.toList(),
          'gasLimit': gasLimit.toJson(),
          'storageDepositLimit': storageDepositLimit,
          'code': code,
          'data': data,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i6.U256Codec().sizeHint(value);
    size = size + _i4.Weight.codec.sizeHint(gasLimit);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(storageDepositLimit);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(code);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(data);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    const _i1.U64ArrayCodec(4).encodeTo(
      value,
      output,
    );
    _i4.Weight.codec.encodeTo(
      gasLimit,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      storageDepositLimit,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      code,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      data,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is EthInstantiateWithCode &&
          _i8.listsEqual(
            other.value,
            value,
          ) &&
          other.gasLimit == gasLimit &&
          other.storageDepositLimit == storageDepositLimit &&
          _i8.listsEqual(
            other.code,
            code,
          ) &&
          _i8.listsEqual(
            other.data,
            data,
          );

  @override
  int get hashCode => Object.hash(
        value,
        gasLimit,
        storageDepositLimit,
        code,
        data,
      );
}

/// Same as [`Self::call`], but intended to be dispatched **only**
/// by an EVM transaction through the EVM compatibility layer.
class EthCall extends Call {
  const EthCall({
    required this.dest,
    required this.value,
    required this.gasLimit,
    required this.storageDepositLimit,
    required this.data,
  });

  factory EthCall._decode(_i1.Input input) {
    return EthCall(
      dest: const _i1.U8ArrayCodec(20).decode(input),
      value: const _i1.U64ArrayCodec(4).decode(input),
      gasLimit: _i4.Weight.codec.decode(input),
      storageDepositLimit: _i1.CompactBigIntCodec.codec.decode(input),
      data: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// H160
  final _i3.H160 dest;

  /// U256
  final _i6.U256 value;

  /// Weight
  final _i4.Weight gasLimit;

  /// BalanceOf<T>
  final BigInt storageDepositLimit;

  /// Vec<u8>
  final List<int> data;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'eth_call': {
          'dest': dest.toList(),
          'value': value.toList(),
          'gasLimit': gasLimit.toJson(),
          'storageDepositLimit': storageDepositLimit,
          'data': data,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.H160Codec().sizeHint(dest);
    size = size + const _i6.U256Codec().sizeHint(value);
    size = size + _i4.Weight.codec.sizeHint(gasLimit);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(storageDepositLimit);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(data);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
    const _i1.U8ArrayCodec(20).encodeTo(
      dest,
      output,
    );
    const _i1.U64ArrayCodec(4).encodeTo(
      value,
      output,
    );
    _i4.Weight.codec.encodeTo(
      gasLimit,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      storageDepositLimit,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      data,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is EthCall &&
          _i8.listsEqual(
            other.dest,
            dest,
          ) &&
          _i8.listsEqual(
            other.value,
            value,
          ) &&
          other.gasLimit == gasLimit &&
          other.storageDepositLimit == storageDepositLimit &&
          _i8.listsEqual(
            other.data,
            data,
          );

  @override
  int get hashCode => Object.hash(
        dest,
        value,
        gasLimit,
        storageDepositLimit,
        data,
      );
}

/// Upload new `code` without instantiating a contract from it.
///
/// If the code does not already exist a deposit is reserved from the caller
/// and unreserved only when [`Self::remove_code`] is called. The size of the reserve
/// depends on the size of the supplied `code`.
///
/// # Note
///
/// Anyone can instantiate a contract from any uploaded code and thus prevent its removal.
/// To avoid this situation a constructor could employ access control so that it can
/// only be instantiated by permissioned entities. The same is true when uploading
/// through [`Self::instantiate_with_code`].
class UploadCode extends Call {
  const UploadCode({
    required this.code,
    required this.storageDepositLimit,
  });

  factory UploadCode._decode(_i1.Input input) {
    return UploadCode(
      code: _i1.U8SequenceCodec.codec.decode(input),
      storageDepositLimit: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// Vec<u8>
  final List<int> code;

  /// BalanceOf<T>
  final BigInt storageDepositLimit;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'upload_code': {
          'code': code,
          'storageDepositLimit': storageDepositLimit,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(code);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(storageDepositLimit);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      code,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      storageDepositLimit,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UploadCode &&
          _i8.listsEqual(
            other.code,
            code,
          ) &&
          other.storageDepositLimit == storageDepositLimit;

  @override
  int get hashCode => Object.hash(
        code,
        storageDepositLimit,
      );
}

/// Remove the code stored under `code_hash` and refund the deposit to its owner.
///
/// A code can only be removed by its original uploader (its owner) and only if it is
/// not used by any contract.
class RemoveCode extends Call {
  const RemoveCode({required this.codeHash});

  factory RemoveCode._decode(_i1.Input input) {
    return RemoveCode(codeHash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// sp_core::H256
  final _i5.H256 codeHash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'remove_code': {'codeHash': codeHash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i5.H256Codec().sizeHint(codeHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      codeHash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RemoveCode &&
          _i8.listsEqual(
            other.codeHash,
            codeHash,
          );

  @override
  int get hashCode => codeHash.hashCode;
}

/// Privileged function that changes the code of an existing contract.
///
/// This takes care of updating refcounts and all other necessary operations. Returns
/// an error if either the `code_hash` or `dest` do not exist.
///
/// # Note
///
/// This does **not** change the address of the contract in question. This means
/// that the contract address is no longer derived from its code hash after calling
/// this dispatchable.
class SetCode extends Call {
  const SetCode({
    required this.dest,
    required this.codeHash,
  });

  factory SetCode._decode(_i1.Input input) {
    return SetCode(
      dest: const _i1.U8ArrayCodec(20).decode(input),
      codeHash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// H160
  final _i3.H160 dest;

  /// sp_core::H256
  final _i5.H256 codeHash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'set_code': {
          'dest': dest.toList(),
          'codeHash': codeHash.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.H160Codec().sizeHint(dest);
    size = size + const _i5.H256Codec().sizeHint(codeHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    const _i1.U8ArrayCodec(20).encodeTo(
      dest,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      codeHash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetCode &&
          _i8.listsEqual(
            other.dest,
            dest,
          ) &&
          _i8.listsEqual(
            other.codeHash,
            codeHash,
          );

  @override
  int get hashCode => Object.hash(
        dest,
        codeHash,
      );
}

/// Register the callers account id so that it can be used in contract interactions.
///
/// This will error if the origin is already mapped or is a eth native `Address20`. It will
/// take a deposit that can be released by calling [`Self::unmap_account`].
class MapAccount extends Call {
  const MapAccount();

  @override
  Map<String, dynamic> toJson() => {'map_account': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is MapAccount;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Unregister the callers account id in order to free the deposit.
///
/// There is no reason to ever call this function other than freeing up the deposit.
/// This is only useful when the account should no longer be used.
class UnmapAccount extends Call {
  const UnmapAccount();

  @override
  Map<String, dynamic> toJson() => {'unmap_account': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is UnmapAccount;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Dispatch an `call` with the origin set to the callers fallback address.
///
/// Every `AccountId32` can control its corresponding fallback account. The fallback account
/// is the `AccountId20` with the last 12 bytes set to `0xEE`. This is essentially a
/// recovery function in case an `AccountId20` was used without creating a mapping first.
class DispatchAsFallbackAccount extends Call {
  const DispatchAsFallbackAccount({required this.call});

  factory DispatchAsFallbackAccount._decode(_i1.Input input) {
    return DispatchAsFallbackAccount(call: _i7.RuntimeCall.codec.decode(input));
  }

  /// Box<<T as Config>::RuntimeCall>
  final _i7.RuntimeCall call;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'dispatch_as_fallback_account': {'call': call.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i7.RuntimeCall.codec.sizeHint(call);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    _i7.RuntimeCall.codec.encodeTo(
      call,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DispatchAsFallbackAccount && other.call == call;

  @override
  int get hashCode => call.hashCode;
}
