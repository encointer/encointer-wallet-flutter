// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;
import 'dart:typed_data' as _i4;

import 'package:polkadart/polkadart.dart' as _i1;

import '../types/encointer_node_notee_runtime/runtime_call.dart' as _i5;
import '../types/pallet_sudo/pallet/call.dart' as _i6;
import '../types/sp_core/crypto/account_id32.dart' as _i2;
import '../types/sp_runtime/multiaddress/multi_address.dart' as _i8;
import '../types/sp_weights/weight_v2/weight.dart' as _i7;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<_i2.AccountId32> _key = const _i1.StorageValue<_i2.AccountId32>(
    prefix: 'Sudo',
    storage: 'Key',
    valueCodec: _i2.AccountId32Codec(),
  );

  /// The `AccountId` of the sudo key.
  _i3.Future<_i2.AccountId32?> key({_i1.BlockHash? at}) async {
    final hashedKey = _key.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _key.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `key`.
  _i4.Uint8List keyKey() {
    final hashedKey = _key.hashedKey();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Authenticates the sudo key and dispatches a function call with `Root` origin.
  _i5.Sudo sudo({required _i5.RuntimeCall call}) {
    return _i5.Sudo(_i6.Sudo(call: call));
  }

  /// Authenticates the sudo key and dispatches a function call with `Root` origin.
  /// This function does not check the weight of the call, and instead allows the
  /// Sudo user to specify the weight of the call.
  ///
  /// The dispatch origin for this call must be _Signed_.
  _i5.Sudo sudoUncheckedWeight({
    required _i5.RuntimeCall call,
    required _i7.Weight weight,
  }) {
    return _i5.Sudo(_i6.SudoUncheckedWeight(
      call: call,
      weight: weight,
    ));
  }

  /// Authenticates the current sudo key and sets the given AccountId (`new`) as the new sudo
  /// key.
  _i5.Sudo setKey({required _i8.MultiAddress new_}) {
    return _i5.Sudo(_i6.SetKey(new_: new_));
  }

  /// Authenticates the sudo key and dispatches a function call with `Signed` origin from
  /// a given account.
  ///
  /// The dispatch origin for this call must be _Signed_.
  _i5.Sudo sudoAs({
    required _i8.MultiAddress who,
    required _i5.RuntimeCall call,
  }) {
    return _i5.Sudo(_i6.SudoAs(
      who: who,
      call: call,
    ));
  }

  /// Permanently removes the sudo key.
  ///
  /// **This cannot be un-done.**
  _i5.Sudo removeKey() {
    return _i5.Sudo(_i6.RemoveKey());
  }
}
