// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../sp_core/crypto/account_id32.dart' as _i3;

/// The `Event` enum of this pallet
abstract class Event {
  const Event();

  factory Event.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $EventCodec codec = $EventCodec();

  static const $Event values = $Event();

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

class $Event {
  const $Event();

  Created created({
    required int assetId,
    required _i3.AccountId32 creator,
    required _i3.AccountId32 owner,
  }) {
    return Created(
      assetId: assetId,
      creator: creator,
      owner: owner,
    );
  }

  Issued issued({
    required int assetId,
    required _i3.AccountId32 owner,
    required BigInt amount,
  }) {
    return Issued(
      assetId: assetId,
      owner: owner,
      amount: amount,
    );
  }

  Transferred transferred({
    required int assetId,
    required _i3.AccountId32 from,
    required _i3.AccountId32 to,
    required BigInt amount,
  }) {
    return Transferred(
      assetId: assetId,
      from: from,
      to: to,
      amount: amount,
    );
  }

  Burned burned({
    required int assetId,
    required _i3.AccountId32 owner,
    required BigInt balance,
  }) {
    return Burned(
      assetId: assetId,
      owner: owner,
      balance: balance,
    );
  }

  TeamChanged teamChanged({
    required int assetId,
    required _i3.AccountId32 issuer,
    required _i3.AccountId32 admin,
    required _i3.AccountId32 freezer,
  }) {
    return TeamChanged(
      assetId: assetId,
      issuer: issuer,
      admin: admin,
      freezer: freezer,
    );
  }

  OwnerChanged ownerChanged({
    required int assetId,
    required _i3.AccountId32 owner,
  }) {
    return OwnerChanged(
      assetId: assetId,
      owner: owner,
    );
  }

  Frozen frozen({
    required int assetId,
    required _i3.AccountId32 who,
  }) {
    return Frozen(
      assetId: assetId,
      who: who,
    );
  }

  Thawed thawed({
    required int assetId,
    required _i3.AccountId32 who,
  }) {
    return Thawed(
      assetId: assetId,
      who: who,
    );
  }

  AssetFrozen assetFrozen({required int assetId}) {
    return AssetFrozen(assetId: assetId);
  }

  AssetThawed assetThawed({required int assetId}) {
    return AssetThawed(assetId: assetId);
  }

  AccountsDestroyed accountsDestroyed({
    required int assetId,
    required int accountsDestroyed,
    required int accountsRemaining,
  }) {
    return AccountsDestroyed(
      assetId: assetId,
      accountsDestroyed: accountsDestroyed,
      accountsRemaining: accountsRemaining,
    );
  }

  ApprovalsDestroyed approvalsDestroyed({
    required int assetId,
    required int approvalsDestroyed,
    required int approvalsRemaining,
  }) {
    return ApprovalsDestroyed(
      assetId: assetId,
      approvalsDestroyed: approvalsDestroyed,
      approvalsRemaining: approvalsRemaining,
    );
  }

  DestructionStarted destructionStarted({required int assetId}) {
    return DestructionStarted(assetId: assetId);
  }

  Destroyed destroyed({required int assetId}) {
    return Destroyed(assetId: assetId);
  }

  ForceCreated forceCreated({
    required int assetId,
    required _i3.AccountId32 owner,
  }) {
    return ForceCreated(
      assetId: assetId,
      owner: owner,
    );
  }

  MetadataSet metadataSet({
    required int assetId,
    required List<int> name,
    required List<int> symbol,
    required int decimals,
    required bool isFrozen,
  }) {
    return MetadataSet(
      assetId: assetId,
      name: name,
      symbol: symbol,
      decimals: decimals,
      isFrozen: isFrozen,
    );
  }

  MetadataCleared metadataCleared({required int assetId}) {
    return MetadataCleared(assetId: assetId);
  }

  ApprovedTransfer approvedTransfer({
    required int assetId,
    required _i3.AccountId32 source,
    required _i3.AccountId32 delegate,
    required BigInt amount,
  }) {
    return ApprovedTransfer(
      assetId: assetId,
      source: source,
      delegate: delegate,
      amount: amount,
    );
  }

  ApprovalCancelled approvalCancelled({
    required int assetId,
    required _i3.AccountId32 owner,
    required _i3.AccountId32 delegate,
  }) {
    return ApprovalCancelled(
      assetId: assetId,
      owner: owner,
      delegate: delegate,
    );
  }

  TransferredApproved transferredApproved({
    required int assetId,
    required _i3.AccountId32 owner,
    required _i3.AccountId32 delegate,
    required _i3.AccountId32 destination,
    required BigInt amount,
  }) {
    return TransferredApproved(
      assetId: assetId,
      owner: owner,
      delegate: delegate,
      destination: destination,
      amount: amount,
    );
  }

  AssetStatusChanged assetStatusChanged({required int assetId}) {
    return AssetStatusChanged(assetId: assetId);
  }

  AssetMinBalanceChanged assetMinBalanceChanged({
    required int assetId,
    required BigInt newMinBalance,
  }) {
    return AssetMinBalanceChanged(
      assetId: assetId,
      newMinBalance: newMinBalance,
    );
  }

  Touched touched({
    required int assetId,
    required _i3.AccountId32 who,
    required _i3.AccountId32 depositor,
  }) {
    return Touched(
      assetId: assetId,
      who: who,
      depositor: depositor,
    );
  }

  Blocked blocked({
    required int assetId,
    required _i3.AccountId32 who,
  }) {
    return Blocked(
      assetId: assetId,
      who: who,
    );
  }

  Deposited deposited({
    required int assetId,
    required _i3.AccountId32 who,
    required BigInt amount,
  }) {
    return Deposited(
      assetId: assetId,
      who: who,
      amount: amount,
    );
  }

  Withdrawn withdrawn({
    required int assetId,
    required _i3.AccountId32 who,
    required BigInt amount,
  }) {
    return Withdrawn(
      assetId: assetId,
      who: who,
      amount: amount,
    );
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Created._decode(input);
      case 1:
        return Issued._decode(input);
      case 2:
        return Transferred._decode(input);
      case 3:
        return Burned._decode(input);
      case 4:
        return TeamChanged._decode(input);
      case 5:
        return OwnerChanged._decode(input);
      case 6:
        return Frozen._decode(input);
      case 7:
        return Thawed._decode(input);
      case 8:
        return AssetFrozen._decode(input);
      case 9:
        return AssetThawed._decode(input);
      case 10:
        return AccountsDestroyed._decode(input);
      case 11:
        return ApprovalsDestroyed._decode(input);
      case 12:
        return DestructionStarted._decode(input);
      case 13:
        return Destroyed._decode(input);
      case 14:
        return ForceCreated._decode(input);
      case 15:
        return MetadataSet._decode(input);
      case 16:
        return MetadataCleared._decode(input);
      case 17:
        return ApprovedTransfer._decode(input);
      case 18:
        return ApprovalCancelled._decode(input);
      case 19:
        return TransferredApproved._decode(input);
      case 20:
        return AssetStatusChanged._decode(input);
      case 21:
        return AssetMinBalanceChanged._decode(input);
      case 22:
        return Touched._decode(input);
      case 23:
        return Blocked._decode(input);
      case 24:
        return Deposited._decode(input);
      case 25:
        return Withdrawn._decode(input);
      default:
        throw Exception('Event: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Event value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Created:
        (value as Created).encodeTo(output);
        break;
      case Issued:
        (value as Issued).encodeTo(output);
        break;
      case Transferred:
        (value as Transferred).encodeTo(output);
        break;
      case Burned:
        (value as Burned).encodeTo(output);
        break;
      case TeamChanged:
        (value as TeamChanged).encodeTo(output);
        break;
      case OwnerChanged:
        (value as OwnerChanged).encodeTo(output);
        break;
      case Frozen:
        (value as Frozen).encodeTo(output);
        break;
      case Thawed:
        (value as Thawed).encodeTo(output);
        break;
      case AssetFrozen:
        (value as AssetFrozen).encodeTo(output);
        break;
      case AssetThawed:
        (value as AssetThawed).encodeTo(output);
        break;
      case AccountsDestroyed:
        (value as AccountsDestroyed).encodeTo(output);
        break;
      case ApprovalsDestroyed:
        (value as ApprovalsDestroyed).encodeTo(output);
        break;
      case DestructionStarted:
        (value as DestructionStarted).encodeTo(output);
        break;
      case Destroyed:
        (value as Destroyed).encodeTo(output);
        break;
      case ForceCreated:
        (value as ForceCreated).encodeTo(output);
        break;
      case MetadataSet:
        (value as MetadataSet).encodeTo(output);
        break;
      case MetadataCleared:
        (value as MetadataCleared).encodeTo(output);
        break;
      case ApprovedTransfer:
        (value as ApprovedTransfer).encodeTo(output);
        break;
      case ApprovalCancelled:
        (value as ApprovalCancelled).encodeTo(output);
        break;
      case TransferredApproved:
        (value as TransferredApproved).encodeTo(output);
        break;
      case AssetStatusChanged:
        (value as AssetStatusChanged).encodeTo(output);
        break;
      case AssetMinBalanceChanged:
        (value as AssetMinBalanceChanged).encodeTo(output);
        break;
      case Touched:
        (value as Touched).encodeTo(output);
        break;
      case Blocked:
        (value as Blocked).encodeTo(output);
        break;
      case Deposited:
        (value as Deposited).encodeTo(output);
        break;
      case Withdrawn:
        (value as Withdrawn).encodeTo(output);
        break;
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case Created:
        return (value as Created)._sizeHint();
      case Issued:
        return (value as Issued)._sizeHint();
      case Transferred:
        return (value as Transferred)._sizeHint();
      case Burned:
        return (value as Burned)._sizeHint();
      case TeamChanged:
        return (value as TeamChanged)._sizeHint();
      case OwnerChanged:
        return (value as OwnerChanged)._sizeHint();
      case Frozen:
        return (value as Frozen)._sizeHint();
      case Thawed:
        return (value as Thawed)._sizeHint();
      case AssetFrozen:
        return (value as AssetFrozen)._sizeHint();
      case AssetThawed:
        return (value as AssetThawed)._sizeHint();
      case AccountsDestroyed:
        return (value as AccountsDestroyed)._sizeHint();
      case ApprovalsDestroyed:
        return (value as ApprovalsDestroyed)._sizeHint();
      case DestructionStarted:
        return (value as DestructionStarted)._sizeHint();
      case Destroyed:
        return (value as Destroyed)._sizeHint();
      case ForceCreated:
        return (value as ForceCreated)._sizeHint();
      case MetadataSet:
        return (value as MetadataSet)._sizeHint();
      case MetadataCleared:
        return (value as MetadataCleared)._sizeHint();
      case ApprovedTransfer:
        return (value as ApprovedTransfer)._sizeHint();
      case ApprovalCancelled:
        return (value as ApprovalCancelled)._sizeHint();
      case TransferredApproved:
        return (value as TransferredApproved)._sizeHint();
      case AssetStatusChanged:
        return (value as AssetStatusChanged)._sizeHint();
      case AssetMinBalanceChanged:
        return (value as AssetMinBalanceChanged)._sizeHint();
      case Touched:
        return (value as Touched)._sizeHint();
      case Blocked:
        return (value as Blocked)._sizeHint();
      case Deposited:
        return (value as Deposited)._sizeHint();
      case Withdrawn:
        return (value as Withdrawn)._sizeHint();
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Some asset class was created.
class Created extends Event {
  const Created({
    required this.assetId,
    required this.creator,
    required this.owner,
  });

  factory Created._decode(_i1.Input input) {
    return Created(
      assetId: _i1.U32Codec.codec.decode(input),
      creator: const _i1.U8ArrayCodec(32).decode(input),
      owner: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::AssetId
  final int assetId;

  /// T::AccountId
  final _i3.AccountId32 creator;

  /// T::AccountId
  final _i3.AccountId32 owner;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Created': {
          'assetId': assetId,
          'creator': creator.toList(),
          'owner': owner.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    size = size + const _i3.AccountId32Codec().sizeHint(creator);
    size = size + const _i3.AccountId32Codec().sizeHint(owner);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      creator,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      owner,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Created &&
          other.assetId == assetId &&
          _i4.listsEqual(
            other.creator,
            creator,
          ) &&
          _i4.listsEqual(
            other.owner,
            owner,
          );

  @override
  int get hashCode => Object.hash(
        assetId,
        creator,
        owner,
      );
}

/// Some assets were issued.
class Issued extends Event {
  const Issued({
    required this.assetId,
    required this.owner,
    required this.amount,
  });

  factory Issued._decode(_i1.Input input) {
    return Issued(
      assetId: _i1.U32Codec.codec.decode(input),
      owner: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AssetId
  final int assetId;

  /// T::AccountId
  final _i3.AccountId32 owner;

  /// T::Balance
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Issued': {
          'assetId': assetId,
          'owner': owner.toList(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    size = size + const _i3.AccountId32Codec().sizeHint(owner);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      owner,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Issued &&
          other.assetId == assetId &&
          _i4.listsEqual(
            other.owner,
            owner,
          ) &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        assetId,
        owner,
        amount,
      );
}

/// Some assets were transferred.
class Transferred extends Event {
  const Transferred({
    required this.assetId,
    required this.from,
    required this.to,
    required this.amount,
  });

  factory Transferred._decode(_i1.Input input) {
    return Transferred(
      assetId: _i1.U32Codec.codec.decode(input),
      from: const _i1.U8ArrayCodec(32).decode(input),
      to: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AssetId
  final int assetId;

  /// T::AccountId
  final _i3.AccountId32 from;

  /// T::AccountId
  final _i3.AccountId32 to;

  /// T::Balance
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Transferred': {
          'assetId': assetId,
          'from': from.toList(),
          'to': to.toList(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    size = size + const _i3.AccountId32Codec().sizeHint(from);
    size = size + const _i3.AccountId32Codec().sizeHint(to);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      from,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      to,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Transferred &&
          other.assetId == assetId &&
          _i4.listsEqual(
            other.from,
            from,
          ) &&
          _i4.listsEqual(
            other.to,
            to,
          ) &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        assetId,
        from,
        to,
        amount,
      );
}

/// Some assets were destroyed.
class Burned extends Event {
  const Burned({
    required this.assetId,
    required this.owner,
    required this.balance,
  });

  factory Burned._decode(_i1.Input input) {
    return Burned(
      assetId: _i1.U32Codec.codec.decode(input),
      owner: const _i1.U8ArrayCodec(32).decode(input),
      balance: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AssetId
  final int assetId;

  /// T::AccountId
  final _i3.AccountId32 owner;

  /// T::Balance
  final BigInt balance;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Burned': {
          'assetId': assetId,
          'owner': owner.toList(),
          'balance': balance,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    size = size + const _i3.AccountId32Codec().sizeHint(owner);
    size = size + _i1.U128Codec.codec.sizeHint(balance);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      owner,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      balance,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Burned &&
          other.assetId == assetId &&
          _i4.listsEqual(
            other.owner,
            owner,
          ) &&
          other.balance == balance;

  @override
  int get hashCode => Object.hash(
        assetId,
        owner,
        balance,
      );
}

/// The management team changed.
class TeamChanged extends Event {
  const TeamChanged({
    required this.assetId,
    required this.issuer,
    required this.admin,
    required this.freezer,
  });

  factory TeamChanged._decode(_i1.Input input) {
    return TeamChanged(
      assetId: _i1.U32Codec.codec.decode(input),
      issuer: const _i1.U8ArrayCodec(32).decode(input),
      admin: const _i1.U8ArrayCodec(32).decode(input),
      freezer: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::AssetId
  final int assetId;

  /// T::AccountId
  final _i3.AccountId32 issuer;

  /// T::AccountId
  final _i3.AccountId32 admin;

  /// T::AccountId
  final _i3.AccountId32 freezer;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'TeamChanged': {
          'assetId': assetId,
          'issuer': issuer.toList(),
          'admin': admin.toList(),
          'freezer': freezer.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    size = size + const _i3.AccountId32Codec().sizeHint(issuer);
    size = size + const _i3.AccountId32Codec().sizeHint(admin);
    size = size + const _i3.AccountId32Codec().sizeHint(freezer);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      issuer,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      admin,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      freezer,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is TeamChanged &&
          other.assetId == assetId &&
          _i4.listsEqual(
            other.issuer,
            issuer,
          ) &&
          _i4.listsEqual(
            other.admin,
            admin,
          ) &&
          _i4.listsEqual(
            other.freezer,
            freezer,
          );

  @override
  int get hashCode => Object.hash(
        assetId,
        issuer,
        admin,
        freezer,
      );
}

/// The owner changed.
class OwnerChanged extends Event {
  const OwnerChanged({
    required this.assetId,
    required this.owner,
  });

  factory OwnerChanged._decode(_i1.Input input) {
    return OwnerChanged(
      assetId: _i1.U32Codec.codec.decode(input),
      owner: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::AssetId
  final int assetId;

  /// T::AccountId
  final _i3.AccountId32 owner;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'OwnerChanged': {
          'assetId': assetId,
          'owner': owner.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    size = size + const _i3.AccountId32Codec().sizeHint(owner);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      owner,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is OwnerChanged &&
          other.assetId == assetId &&
          _i4.listsEqual(
            other.owner,
            owner,
          );

  @override
  int get hashCode => Object.hash(
        assetId,
        owner,
      );
}

/// Some account `who` was frozen.
class Frozen extends Event {
  const Frozen({
    required this.assetId,
    required this.who,
  });

  factory Frozen._decode(_i1.Input input) {
    return Frozen(
      assetId: _i1.U32Codec.codec.decode(input),
      who: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::AssetId
  final int assetId;

  /// T::AccountId
  final _i3.AccountId32 who;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Frozen': {
          'assetId': assetId,
          'who': who.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    size = size + const _i3.AccountId32Codec().sizeHint(who);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Frozen &&
          other.assetId == assetId &&
          _i4.listsEqual(
            other.who,
            who,
          );

  @override
  int get hashCode => Object.hash(
        assetId,
        who,
      );
}

/// Some account `who` was thawed.
class Thawed extends Event {
  const Thawed({
    required this.assetId,
    required this.who,
  });

  factory Thawed._decode(_i1.Input input) {
    return Thawed(
      assetId: _i1.U32Codec.codec.decode(input),
      who: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::AssetId
  final int assetId;

  /// T::AccountId
  final _i3.AccountId32 who;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Thawed': {
          'assetId': assetId,
          'who': who.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    size = size + const _i3.AccountId32Codec().sizeHint(who);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Thawed &&
          other.assetId == assetId &&
          _i4.listsEqual(
            other.who,
            who,
          );

  @override
  int get hashCode => Object.hash(
        assetId,
        who,
      );
}

/// Some asset `asset_id` was frozen.
class AssetFrozen extends Event {
  const AssetFrozen({required this.assetId});

  factory AssetFrozen._decode(_i1.Input input) {
    return AssetFrozen(assetId: _i1.U32Codec.codec.decode(input));
  }

  /// T::AssetId
  final int assetId;

  @override
  Map<String, Map<String, int>> toJson() => {
        'AssetFrozen': {'assetId': assetId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AssetFrozen && other.assetId == assetId;

  @override
  int get hashCode => assetId.hashCode;
}

/// Some asset `asset_id` was thawed.
class AssetThawed extends Event {
  const AssetThawed({required this.assetId});

  factory AssetThawed._decode(_i1.Input input) {
    return AssetThawed(assetId: _i1.U32Codec.codec.decode(input));
  }

  /// T::AssetId
  final int assetId;

  @override
  Map<String, Map<String, int>> toJson() => {
        'AssetThawed': {'assetId': assetId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AssetThawed && other.assetId == assetId;

  @override
  int get hashCode => assetId.hashCode;
}

/// Accounts were destroyed for given asset.
class AccountsDestroyed extends Event {
  const AccountsDestroyed({
    required this.assetId,
    required this.accountsDestroyed,
    required this.accountsRemaining,
  });

  factory AccountsDestroyed._decode(_i1.Input input) {
    return AccountsDestroyed(
      assetId: _i1.U32Codec.codec.decode(input),
      accountsDestroyed: _i1.U32Codec.codec.decode(input),
      accountsRemaining: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::AssetId
  final int assetId;

  /// u32
  final int accountsDestroyed;

  /// u32
  final int accountsRemaining;

  @override
  Map<String, Map<String, int>> toJson() => {
        'AccountsDestroyed': {
          'assetId': assetId,
          'accountsDestroyed': accountsDestroyed,
          'accountsRemaining': accountsRemaining,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    size = size + _i1.U32Codec.codec.sizeHint(accountsDestroyed);
    size = size + _i1.U32Codec.codec.sizeHint(accountsRemaining);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      accountsDestroyed,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      accountsRemaining,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AccountsDestroyed &&
          other.assetId == assetId &&
          other.accountsDestroyed == accountsDestroyed &&
          other.accountsRemaining == accountsRemaining;

  @override
  int get hashCode => Object.hash(
        assetId,
        accountsDestroyed,
        accountsRemaining,
      );
}

/// Approvals were destroyed for given asset.
class ApprovalsDestroyed extends Event {
  const ApprovalsDestroyed({
    required this.assetId,
    required this.approvalsDestroyed,
    required this.approvalsRemaining,
  });

  factory ApprovalsDestroyed._decode(_i1.Input input) {
    return ApprovalsDestroyed(
      assetId: _i1.U32Codec.codec.decode(input),
      approvalsDestroyed: _i1.U32Codec.codec.decode(input),
      approvalsRemaining: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::AssetId
  final int assetId;

  /// u32
  final int approvalsDestroyed;

  /// u32
  final int approvalsRemaining;

  @override
  Map<String, Map<String, int>> toJson() => {
        'ApprovalsDestroyed': {
          'assetId': assetId,
          'approvalsDestroyed': approvalsDestroyed,
          'approvalsRemaining': approvalsRemaining,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    size = size + _i1.U32Codec.codec.sizeHint(approvalsDestroyed);
    size = size + _i1.U32Codec.codec.sizeHint(approvalsRemaining);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      approvalsDestroyed,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      approvalsRemaining,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ApprovalsDestroyed &&
          other.assetId == assetId &&
          other.approvalsDestroyed == approvalsDestroyed &&
          other.approvalsRemaining == approvalsRemaining;

  @override
  int get hashCode => Object.hash(
        assetId,
        approvalsDestroyed,
        approvalsRemaining,
      );
}

/// An asset class is in the process of being destroyed.
class DestructionStarted extends Event {
  const DestructionStarted({required this.assetId});

  factory DestructionStarted._decode(_i1.Input input) {
    return DestructionStarted(assetId: _i1.U32Codec.codec.decode(input));
  }

  /// T::AssetId
  final int assetId;

  @override
  Map<String, Map<String, int>> toJson() => {
        'DestructionStarted': {'assetId': assetId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DestructionStarted && other.assetId == assetId;

  @override
  int get hashCode => assetId.hashCode;
}

/// An asset class was destroyed.
class Destroyed extends Event {
  const Destroyed({required this.assetId});

  factory Destroyed._decode(_i1.Input input) {
    return Destroyed(assetId: _i1.U32Codec.codec.decode(input));
  }

  /// T::AssetId
  final int assetId;

  @override
  Map<String, Map<String, int>> toJson() => {
        'Destroyed': {'assetId': assetId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Destroyed && other.assetId == assetId;

  @override
  int get hashCode => assetId.hashCode;
}

/// Some asset class was force-created.
class ForceCreated extends Event {
  const ForceCreated({
    required this.assetId,
    required this.owner,
  });

  factory ForceCreated._decode(_i1.Input input) {
    return ForceCreated(
      assetId: _i1.U32Codec.codec.decode(input),
      owner: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::AssetId
  final int assetId;

  /// T::AccountId
  final _i3.AccountId32 owner;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ForceCreated': {
          'assetId': assetId,
          'owner': owner.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    size = size + const _i3.AccountId32Codec().sizeHint(owner);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      14,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      owner,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceCreated &&
          other.assetId == assetId &&
          _i4.listsEqual(
            other.owner,
            owner,
          );

  @override
  int get hashCode => Object.hash(
        assetId,
        owner,
      );
}

/// New metadata has been set for an asset.
class MetadataSet extends Event {
  const MetadataSet({
    required this.assetId,
    required this.name,
    required this.symbol,
    required this.decimals,
    required this.isFrozen,
  });

  factory MetadataSet._decode(_i1.Input input) {
    return MetadataSet(
      assetId: _i1.U32Codec.codec.decode(input),
      name: _i1.U8SequenceCodec.codec.decode(input),
      symbol: _i1.U8SequenceCodec.codec.decode(input),
      decimals: _i1.U8Codec.codec.decode(input),
      isFrozen: _i1.BoolCodec.codec.decode(input),
    );
  }

  /// T::AssetId
  final int assetId;

  /// Vec<u8>
  final List<int> name;

  /// Vec<u8>
  final List<int> symbol;

  /// u8
  final int decimals;

  /// bool
  final bool isFrozen;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'MetadataSet': {
          'assetId': assetId,
          'name': name,
          'symbol': symbol,
          'decimals': decimals,
          'isFrozen': isFrozen,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(name);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(symbol);
    size = size + _i1.U8Codec.codec.sizeHint(decimals);
    size = size + _i1.BoolCodec.codec.sizeHint(isFrozen);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      15,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      name,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      symbol,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      decimals,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      isFrozen,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MetadataSet &&
          other.assetId == assetId &&
          _i4.listsEqual(
            other.name,
            name,
          ) &&
          _i4.listsEqual(
            other.symbol,
            symbol,
          ) &&
          other.decimals == decimals &&
          other.isFrozen == isFrozen;

  @override
  int get hashCode => Object.hash(
        assetId,
        name,
        symbol,
        decimals,
        isFrozen,
      );
}

/// Metadata has been cleared for an asset.
class MetadataCleared extends Event {
  const MetadataCleared({required this.assetId});

  factory MetadataCleared._decode(_i1.Input input) {
    return MetadataCleared(assetId: _i1.U32Codec.codec.decode(input));
  }

  /// T::AssetId
  final int assetId;

  @override
  Map<String, Map<String, int>> toJson() => {
        'MetadataCleared': {'assetId': assetId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      16,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MetadataCleared && other.assetId == assetId;

  @override
  int get hashCode => assetId.hashCode;
}

/// (Additional) funds have been approved for transfer to a destination account.
class ApprovedTransfer extends Event {
  const ApprovedTransfer({
    required this.assetId,
    required this.source,
    required this.delegate,
    required this.amount,
  });

  factory ApprovedTransfer._decode(_i1.Input input) {
    return ApprovedTransfer(
      assetId: _i1.U32Codec.codec.decode(input),
      source: const _i1.U8ArrayCodec(32).decode(input),
      delegate: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AssetId
  final int assetId;

  /// T::AccountId
  final _i3.AccountId32 source;

  /// T::AccountId
  final _i3.AccountId32 delegate;

  /// T::Balance
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ApprovedTransfer': {
          'assetId': assetId,
          'source': source.toList(),
          'delegate': delegate.toList(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    size = size + const _i3.AccountId32Codec().sizeHint(source);
    size = size + const _i3.AccountId32Codec().sizeHint(delegate);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      17,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      source,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      delegate,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ApprovedTransfer &&
          other.assetId == assetId &&
          _i4.listsEqual(
            other.source,
            source,
          ) &&
          _i4.listsEqual(
            other.delegate,
            delegate,
          ) &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        assetId,
        source,
        delegate,
        amount,
      );
}

/// An approval for account `delegate` was cancelled by `owner`.
class ApprovalCancelled extends Event {
  const ApprovalCancelled({
    required this.assetId,
    required this.owner,
    required this.delegate,
  });

  factory ApprovalCancelled._decode(_i1.Input input) {
    return ApprovalCancelled(
      assetId: _i1.U32Codec.codec.decode(input),
      owner: const _i1.U8ArrayCodec(32).decode(input),
      delegate: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::AssetId
  final int assetId;

  /// T::AccountId
  final _i3.AccountId32 owner;

  /// T::AccountId
  final _i3.AccountId32 delegate;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ApprovalCancelled': {
          'assetId': assetId,
          'owner': owner.toList(),
          'delegate': delegate.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    size = size + const _i3.AccountId32Codec().sizeHint(owner);
    size = size + const _i3.AccountId32Codec().sizeHint(delegate);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      18,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      owner,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      delegate,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ApprovalCancelled &&
          other.assetId == assetId &&
          _i4.listsEqual(
            other.owner,
            owner,
          ) &&
          _i4.listsEqual(
            other.delegate,
            delegate,
          );

  @override
  int get hashCode => Object.hash(
        assetId,
        owner,
        delegate,
      );
}

/// An `amount` was transferred in its entirety from `owner` to `destination` by
/// the approved `delegate`.
class TransferredApproved extends Event {
  const TransferredApproved({
    required this.assetId,
    required this.owner,
    required this.delegate,
    required this.destination,
    required this.amount,
  });

  factory TransferredApproved._decode(_i1.Input input) {
    return TransferredApproved(
      assetId: _i1.U32Codec.codec.decode(input),
      owner: const _i1.U8ArrayCodec(32).decode(input),
      delegate: const _i1.U8ArrayCodec(32).decode(input),
      destination: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AssetId
  final int assetId;

  /// T::AccountId
  final _i3.AccountId32 owner;

  /// T::AccountId
  final _i3.AccountId32 delegate;

  /// T::AccountId
  final _i3.AccountId32 destination;

  /// T::Balance
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'TransferredApproved': {
          'assetId': assetId,
          'owner': owner.toList(),
          'delegate': delegate.toList(),
          'destination': destination.toList(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    size = size + const _i3.AccountId32Codec().sizeHint(owner);
    size = size + const _i3.AccountId32Codec().sizeHint(delegate);
    size = size + const _i3.AccountId32Codec().sizeHint(destination);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      19,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      owner,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      delegate,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      destination,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is TransferredApproved &&
          other.assetId == assetId &&
          _i4.listsEqual(
            other.owner,
            owner,
          ) &&
          _i4.listsEqual(
            other.delegate,
            delegate,
          ) &&
          _i4.listsEqual(
            other.destination,
            destination,
          ) &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        assetId,
        owner,
        delegate,
        destination,
        amount,
      );
}

/// An asset has had its attributes changed by the `Force` origin.
class AssetStatusChanged extends Event {
  const AssetStatusChanged({required this.assetId});

  factory AssetStatusChanged._decode(_i1.Input input) {
    return AssetStatusChanged(assetId: _i1.U32Codec.codec.decode(input));
  }

  /// T::AssetId
  final int assetId;

  @override
  Map<String, Map<String, int>> toJson() => {
        'AssetStatusChanged': {'assetId': assetId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      20,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AssetStatusChanged && other.assetId == assetId;

  @override
  int get hashCode => assetId.hashCode;
}

/// The min_balance of an asset has been updated by the asset owner.
class AssetMinBalanceChanged extends Event {
  const AssetMinBalanceChanged({
    required this.assetId,
    required this.newMinBalance,
  });

  factory AssetMinBalanceChanged._decode(_i1.Input input) {
    return AssetMinBalanceChanged(
      assetId: _i1.U32Codec.codec.decode(input),
      newMinBalance: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AssetId
  final int assetId;

  /// T::Balance
  final BigInt newMinBalance;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'AssetMinBalanceChanged': {
          'assetId': assetId,
          'newMinBalance': newMinBalance,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    size = size + _i1.U128Codec.codec.sizeHint(newMinBalance);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      21,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      newMinBalance,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AssetMinBalanceChanged && other.assetId == assetId && other.newMinBalance == newMinBalance;

  @override
  int get hashCode => Object.hash(
        assetId,
        newMinBalance,
      );
}

/// Some account `who` was created with a deposit from `depositor`.
class Touched extends Event {
  const Touched({
    required this.assetId,
    required this.who,
    required this.depositor,
  });

  factory Touched._decode(_i1.Input input) {
    return Touched(
      assetId: _i1.U32Codec.codec.decode(input),
      who: const _i1.U8ArrayCodec(32).decode(input),
      depositor: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::AssetId
  final int assetId;

  /// T::AccountId
  final _i3.AccountId32 who;

  /// T::AccountId
  final _i3.AccountId32 depositor;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Touched': {
          'assetId': assetId,
          'who': who.toList(),
          'depositor': depositor.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    size = size + const _i3.AccountId32Codec().sizeHint(who);
    size = size + const _i3.AccountId32Codec().sizeHint(depositor);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      22,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      depositor,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Touched &&
          other.assetId == assetId &&
          _i4.listsEqual(
            other.who,
            who,
          ) &&
          _i4.listsEqual(
            other.depositor,
            depositor,
          );

  @override
  int get hashCode => Object.hash(
        assetId,
        who,
        depositor,
      );
}

/// Some account `who` was blocked.
class Blocked extends Event {
  const Blocked({
    required this.assetId,
    required this.who,
  });

  factory Blocked._decode(_i1.Input input) {
    return Blocked(
      assetId: _i1.U32Codec.codec.decode(input),
      who: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::AssetId
  final int assetId;

  /// T::AccountId
  final _i3.AccountId32 who;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Blocked': {
          'assetId': assetId,
          'who': who.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    size = size + const _i3.AccountId32Codec().sizeHint(who);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      23,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Blocked &&
          other.assetId == assetId &&
          _i4.listsEqual(
            other.who,
            who,
          );

  @override
  int get hashCode => Object.hash(
        assetId,
        who,
      );
}

/// Some assets were deposited (e.g. for transaction fees).
class Deposited extends Event {
  const Deposited({
    required this.assetId,
    required this.who,
    required this.amount,
  });

  factory Deposited._decode(_i1.Input input) {
    return Deposited(
      assetId: _i1.U32Codec.codec.decode(input),
      who: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AssetId
  final int assetId;

  /// T::AccountId
  final _i3.AccountId32 who;

  /// T::Balance
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Deposited': {
          'assetId': assetId,
          'who': who.toList(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    size = size + const _i3.AccountId32Codec().sizeHint(who);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      24,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Deposited &&
          other.assetId == assetId &&
          _i4.listsEqual(
            other.who,
            who,
          ) &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        assetId,
        who,
        amount,
      );
}

/// Some assets were withdrawn from the account (e.g. for transaction fees).
class Withdrawn extends Event {
  const Withdrawn({
    required this.assetId,
    required this.who,
    required this.amount,
  });

  factory Withdrawn._decode(_i1.Input input) {
    return Withdrawn(
      assetId: _i1.U32Codec.codec.decode(input),
      who: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AssetId
  final int assetId;

  /// T::AccountId
  final _i3.AccountId32 who;

  /// T::Balance
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Withdrawn': {
          'assetId': assetId,
          'who': who.toList(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    size = size + const _i3.AccountId32Codec().sizeHint(who);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      25,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Withdrawn &&
          other.assetId == assetId &&
          _i4.listsEqual(
            other.who,
            who,
          ) &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        assetId,
        who,
        amount,
      );
}
