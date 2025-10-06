// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:typed_data' as _i6;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i4;

import '../types/asset_hub_kusama_runtime/proxy_type.dart' as _i9;
import '../types/asset_hub_kusama_runtime/runtime_call.dart' as _i7;
import '../types/pallet_remote_proxy/pallet/call.dart' as _i11;
import '../types/pallet_remote_proxy/pallet/remote_proxy_proof.dart' as _i10;
import '../types/primitive_types/h256.dart' as _i3;
import '../types/sp_runtime/multiaddress/multi_address.dart' as _i8;
import '../types/tuples.dart' as _i2;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<List<_i2.Tuple2<int, _i3.H256>>> _blockToRoot =
      const _i1.StorageValue<List<_i2.Tuple2<int, _i3.H256>>>(
    prefix: 'RemoteProxyRelayChain',
    storage: 'BlockToRoot',
    valueCodec: _i4.SequenceCodec<_i2.Tuple2<int, _i3.H256>>(_i2.Tuple2Codec<int, _i3.H256>(
      _i4.U32Codec.codec,
      _i3.H256Codec(),
    )),
  );

  /// Stores the last [`Config::MaxStorageRootsToKeep`] block to storage root mappings of the
  /// target chain.
  _i5.Future<List<_i2.Tuple2<int, _i3.H256>>> blockToRoot({_i1.BlockHash? at}) async {
    final hashedKey = _blockToRoot.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _blockToRoot.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Returns the storage key for `blockToRoot`.
  _i6.Uint8List blockToRootKey() {
    final hashedKey = _blockToRoot.hashedKey();
    return hashedKey;
  }
}

class Txs {
  const Txs();

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
  _i7.RemoteProxyRelayChain remoteProxy({
    required _i8.MultiAddress real,
    _i9.ProxyType? forceProxyType,
    required _i7.RuntimeCall call,
    required _i10.RemoteProxyProof proof,
  }) {
    return _i7.RemoteProxyRelayChain(_i11.RemoteProxy(
      real: real,
      forceProxyType: forceProxyType,
      call: call,
      proof: proof,
    ));
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
  _i7.RemoteProxyRelayChain registerRemoteProxyProof({required _i10.RemoteProxyProof proof}) {
    return _i7.RemoteProxyRelayChain(_i11.RegisterRemoteProxyProof(proof: proof));
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
  _i7.RemoteProxyRelayChain remoteProxyWithRegisteredProof({
    required _i8.MultiAddress real,
    _i9.ProxyType? forceProxyType,
    required _i7.RuntimeCall call,
  }) {
    return _i7.RemoteProxyRelayChain(_i11.RemoteProxyWithRegisteredProof(
      real: real,
      forceProxyType: forceProxyType,
      call: call,
    ));
  }
}
