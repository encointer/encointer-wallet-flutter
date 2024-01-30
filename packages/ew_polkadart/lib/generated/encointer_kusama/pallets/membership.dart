// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:typed_data' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/encointer_runtime/runtime_call.dart' as _i6;
import '../types/pallet_membership/pallet/call.dart' as _i8;
import '../types/sp_core/crypto/account_id32.dart' as _i2;
import '../types/sp_runtime/multiaddress/multi_address.dart' as _i7;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<List<_i2.AccountId32>> _members = const _i1.StorageValue<List<_i2.AccountId32>>(
    prefix: 'Membership',
    storage: 'Members',
    valueCodec: _i3.SequenceCodec<_i2.AccountId32>(_i2.AccountId32Codec()),
  );

  final _i1.StorageValue<_i2.AccountId32> _prime = const _i1.StorageValue<_i2.AccountId32>(
    prefix: 'Membership',
    storage: 'Prime',
    valueCodec: _i2.AccountId32Codec(),
  );

  /// The current membership, stored as an ordered Vec.
  _i4.Future<List<_i2.AccountId32>> members({_i1.BlockHash? at}) async {
    final hashedKey = _members.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _members.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The current prime member, if one exists.
  _i4.Future<_i2.AccountId32?> prime({_i1.BlockHash? at}) async {
    final hashedKey = _prime.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _prime.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `members`.
  _i5.Uint8List membersKey() {
    final hashedKey = _members.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `prime`.
  _i5.Uint8List primeKey() {
    final hashedKey = _prime.hashedKey();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// See [`Pallet::add_member`].
  _i6.RuntimeCall addMember({required _i7.MultiAddress who}) {
    final _call = _i8.Call.values.addMember(who: who);
    return _i6.RuntimeCall.values.membership(_call);
  }

  /// See [`Pallet::remove_member`].
  _i6.RuntimeCall removeMember({required _i7.MultiAddress who}) {
    final _call = _i8.Call.values.removeMember(who: who);
    return _i6.RuntimeCall.values.membership(_call);
  }

  /// See [`Pallet::swap_member`].
  _i6.RuntimeCall swapMember({
    required _i7.MultiAddress remove,
    required _i7.MultiAddress add,
  }) {
    final _call = _i8.Call.values.swapMember(
      remove: remove,
      add: add,
    );
    return _i6.RuntimeCall.values.membership(_call);
  }

  /// See [`Pallet::reset_members`].
  _i6.RuntimeCall resetMembers({required List<_i2.AccountId32> members}) {
    final _call = _i8.Call.values.resetMembers(members: members);
    return _i6.RuntimeCall.values.membership(_call);
  }

  /// See [`Pallet::change_key`].
  _i6.RuntimeCall changeKey({required _i7.MultiAddress new_}) {
    final _call = _i8.Call.values.changeKey(new_: new_);
    return _i6.RuntimeCall.values.membership(_call);
  }

  /// See [`Pallet::set_prime`].
  _i6.RuntimeCall setPrime({required _i7.MultiAddress who}) {
    final _call = _i8.Call.values.setPrime(who: who);
    return _i6.RuntimeCall.values.membership(_call);
  }

  /// See [`Pallet::clear_prime`].
  _i6.RuntimeCall clearPrime() {
    final _call = _i8.Call.values.clearPrime();
    return _i6.RuntimeCall.values.membership(_call);
  }
}
