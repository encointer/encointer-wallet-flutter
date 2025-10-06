// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../asset_hub_kusama_runtime/proxy_type.dart' as _i4;
import '../../asset_hub_kusama_runtime/runtime_call.dart' as _i5;
import '../../sp_runtime/multiaddress/multi_address.dart' as _i3;
import 'remote_proxy_proof.dart' as _i6;

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

  RemoteProxy remoteProxy({
    required _i3.MultiAddress real,
    _i4.ProxyType? forceProxyType,
    required _i5.RuntimeCall call,
    required _i6.RemoteProxyProof proof,
  }) {
    return RemoteProxy(
      real: real,
      forceProxyType: forceProxyType,
      call: call,
      proof: proof,
    );
  }

  RegisterRemoteProxyProof registerRemoteProxyProof({required _i6.RemoteProxyProof proof}) {
    return RegisterRemoteProxyProof(proof: proof);
  }

  RemoteProxyWithRegisteredProof remoteProxyWithRegisteredProof({
    required _i3.MultiAddress real,
    _i4.ProxyType? forceProxyType,
    required _i5.RuntimeCall call,
  }) {
    return RemoteProxyWithRegisteredProof(
      real: real,
      forceProxyType: forceProxyType,
      call: call,
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
        return RemoteProxy._decode(input);
      case 1:
        return RegisterRemoteProxyProof._decode(input);
      case 2:
        return RemoteProxyWithRegisteredProof._decode(input);
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
      case RemoteProxy:
        (value as RemoteProxy).encodeTo(output);
        break;
      case RegisterRemoteProxyProof:
        (value as RegisterRemoteProxyProof).encodeTo(output);
        break;
      case RemoteProxyWithRegisteredProof:
        (value as RemoteProxyWithRegisteredProof).encodeTo(output);
        break;
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case RemoteProxy:
        return (value as RemoteProxy)._sizeHint();
      case RegisterRemoteProxyProof:
        return (value as RegisterRemoteProxyProof)._sizeHint();
      case RemoteProxyWithRegisteredProof:
        return (value as RemoteProxyWithRegisteredProof)._sizeHint();
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Dispatch the given `call` from an account that the sender is authorised on a remote
/// chain.
///
/// The dispatch origin for this call must be _Signed_.
///
/// Parameters:
/// - `real`: The account that the proxy will make a call on behalf of.
/// - `force_proxy_type`: Specify the exact proxy type to be used and checked for this call.
/// - `call`: The call to be made by the `real` account.
/// - `proof`: The proof from the remote chain about the existence of the proxy.
class RemoteProxy extends Call {
  const RemoteProxy({
    required this.real,
    this.forceProxyType,
    required this.call,
    required this.proof,
  });

  factory RemoteProxy._decode(_i1.Input input) {
    return RemoteProxy(
      real: _i3.MultiAddress.codec.decode(input),
      forceProxyType: const _i1.OptionCodec<_i4.ProxyType>(_i4.ProxyType.codec).decode(input),
      call: _i5.RuntimeCall.codec.decode(input),
      proof: _i6.RemoteProxyProof.codec.decode(input),
    );
  }

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress real;

  /// Option<T::ProxyType>
  final _i4.ProxyType? forceProxyType;

  /// Box<<T as pallet_proxy::Config>::RuntimeCall>
  final _i5.RuntimeCall call;

  /// RemoteProxyProof<RemoteBlockNumberOf<T, I>>
  final _i6.RemoteProxyProof proof;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'remote_proxy': {
          'real': real.toJson(),
          'forceProxyType': forceProxyType?.toJson(),
          'call': call.toJson(),
          'proof': proof.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(real);
    size = size + const _i1.OptionCodec<_i4.ProxyType>(_i4.ProxyType.codec).sizeHint(forceProxyType);
    size = size + _i5.RuntimeCall.codec.sizeHint(call);
    size = size + _i6.RemoteProxyProof.codec.sizeHint(proof);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      real,
      output,
    );
    const _i1.OptionCodec<_i4.ProxyType>(_i4.ProxyType.codec).encodeTo(
      forceProxyType,
      output,
    );
    _i5.RuntimeCall.codec.encodeTo(
      call,
      output,
    );
    _i6.RemoteProxyProof.codec.encodeTo(
      proof,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RemoteProxy &&
          other.real == real &&
          other.forceProxyType == forceProxyType &&
          other.call == call &&
          other.proof == proof;

  @override
  int get hashCode => Object.hash(
        real,
        forceProxyType,
        call,
        proof,
      );
}

/// Register a given remote proxy proof in the current [`dispatch_context`].
///
/// The registered remote proof can then be used later in the same context to execute a
/// remote proxy call. This is for example useful when having a multisig operation. The
/// multisig call can use [`Self::remote_proxy_with_registered_proof`] to get an approval by
/// the members of the multisig. The final execution of the multisig call should be at least
/// a batch of `register_remote_proxy_proof` and the multisig call that uses
/// `remote_proxy_with_registered_proof`. This way the final approver can use a recent proof
/// to prove the existence of the remote proxy. Otherwise it would require the multisig
/// members to approve the call in [`Config::MaxStorageRootsToKeep`] amount of time.
///
/// It is supported to register multiple proofs, but the proofs need to be consumed in the
/// reverse order as they were registered. Basically this means last in, first out.
///
/// The [`dispatch_context`] spans the entire lifetime of a transaction and every call in
/// the transaction gets access to the same context.
///
/// # Example
///
/// ```ignore
/// batch([
///    register_remote_proxy_proof,
///    as_multisig(remote_proxy_with_registered_proof(transfer))
/// ])
/// ```
///
/// As `proofs` can not be verified indefinitely (the time the storage roots are stored is
/// limited) this function provides the possibility to provide a "fresh proof" at time of
/// dispatch. As in the example above, this could be useful for multisig operation that
/// depend on multiple members to approve a certain action, which can take multiple days.
class RegisterRemoteProxyProof extends Call {
  const RegisterRemoteProxyProof({required this.proof});

  factory RegisterRemoteProxyProof._decode(_i1.Input input) {
    return RegisterRemoteProxyProof(proof: _i6.RemoteProxyProof.codec.decode(input));
  }

  /// RemoteProxyProof<RemoteBlockNumberOf<T, I>>
  final _i6.RemoteProxyProof proof;

  @override
  Map<String, Map<String, Map<String, Map<String, dynamic>>>> toJson() => {
        'register_remote_proxy_proof': {'proof': proof.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i6.RemoteProxyProof.codec.sizeHint(proof);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i6.RemoteProxyProof.codec.encodeTo(
      proof,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RegisterRemoteProxyProof && other.proof == proof;

  @override
  int get hashCode => proof.hashCode;
}

/// Dispatch the given `call` from an account that the sender is authorised on a remote
/// chain.
///
/// The dispatch origin for this call must be _Signed_. The difference to
/// [`Self::remote_proxy`] is that the proof nees to registered before using
/// [`Self::register_remote_proxy_proof`] (see for more information).
///
/// Parameters:
/// - `real`: The account that the proxy will make a call on behalf of.
/// - `force_proxy_type`: Specify the exact proxy type to be used and checked for this call.
/// - `call`: The call to be made by the `real` account.
class RemoteProxyWithRegisteredProof extends Call {
  const RemoteProxyWithRegisteredProof({
    required this.real,
    this.forceProxyType,
    required this.call,
  });

  factory RemoteProxyWithRegisteredProof._decode(_i1.Input input) {
    return RemoteProxyWithRegisteredProof(
      real: _i3.MultiAddress.codec.decode(input),
      forceProxyType: const _i1.OptionCodec<_i4.ProxyType>(_i4.ProxyType.codec).decode(input),
      call: _i5.RuntimeCall.codec.decode(input),
    );
  }

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress real;

  /// Option<T::ProxyType>
  final _i4.ProxyType? forceProxyType;

  /// Box<<T as pallet_proxy::Config>::RuntimeCall>
  final _i5.RuntimeCall call;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'remote_proxy_with_registered_proof': {
          'real': real.toJson(),
          'forceProxyType': forceProxyType?.toJson(),
          'call': call.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(real);
    size = size + const _i1.OptionCodec<_i4.ProxyType>(_i4.ProxyType.codec).sizeHint(forceProxyType);
    size = size + _i5.RuntimeCall.codec.sizeHint(call);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      real,
      output,
    );
    const _i1.OptionCodec<_i4.ProxyType>(_i4.ProxyType.codec).encodeTo(
      forceProxyType,
      output,
    );
    _i5.RuntimeCall.codec.encodeTo(
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
      other is RemoteProxyWithRegisteredProof &&
          other.real == real &&
          other.forceProxyType == forceProxyType &&
          other.call == call;

  @override
  int get hashCode => Object.hash(
        real,
        forceProxyType,
        call,
      );
}
