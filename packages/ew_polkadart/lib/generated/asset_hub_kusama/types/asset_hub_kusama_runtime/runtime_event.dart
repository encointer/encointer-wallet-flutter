// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../cumulus_pallet_parachain_system/pallet/event.dart' as _i4;
import '../cumulus_pallet_xcm/pallet/event.dart' as _i14;
import '../cumulus_pallet_xcmp_queue/pallet/event.dart' as _i12;
import '../frame_system/pallet/event.dart' as _i3;
import '../pallet_asset_conversion/pallet/event.dart' as _i26;
import '../pallet_asset_conversion_tx_payment/pallet/event.dart' as _i8;
import '../pallet_assets/pallet/event_1.dart' as _i20;
import '../pallet_assets/pallet/event_2.dart' as _i23;
import '../pallet_assets/pallet/event_3.dart' as _i25;
import '../pallet_balances/pallet/event.dart' as _i6;
import '../pallet_collator_selection/pallet/event.dart' as _i10;
import '../pallet_message_queue/pallet/event.dart' as _i16;
import '../pallet_migrations/pallet/event.dart' as _i5;
import '../pallet_multisig/pallet/event.dart' as _i18;
import '../pallet_nft_fractionalization/pallet/event.dart' as _i24;
import '../pallet_nfts/pallet/event.dart' as _i22;
import '../pallet_proxy/pallet/event.dart' as _i19;
import '../pallet_revive/pallet/event.dart' as _i27;
import '../pallet_session/pallet/event.dart' as _i11;
import '../pallet_state_trie_migration/pallet/event.dart' as _i28;
import '../pallet_transaction_payment/pallet/event.dart' as _i7;
import '../pallet_uniques/pallet/event.dart' as _i21;
import '../pallet_utility/pallet/event.dart' as _i17;
import '../pallet_vesting/pallet/event.dart' as _i9;
import '../pallet_xcm/pallet/event.dart' as _i13;
import '../pallet_xcm_bridge_hub_router/pallet/event.dart' as _i15;

abstract class RuntimeEvent {
  const RuntimeEvent();

  factory RuntimeEvent.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $RuntimeEventCodec codec = $RuntimeEventCodec();

  static const $RuntimeEvent values = $RuntimeEvent();

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

class $RuntimeEvent {
  const $RuntimeEvent();

  System system(_i3.Event value0) {
    return System(value0);
  }

  ParachainSystem parachainSystem(_i4.Event value0) {
    return ParachainSystem(value0);
  }

  MultiBlockMigrations multiBlockMigrations(_i5.Event value0) {
    return MultiBlockMigrations(value0);
  }

  Balances balances(_i6.Event value0) {
    return Balances(value0);
  }

  TransactionPayment transactionPayment(_i7.Event value0) {
    return TransactionPayment(value0);
  }

  AssetTxPayment assetTxPayment(_i8.Event value0) {
    return AssetTxPayment(value0);
  }

  Vesting vesting(_i9.Event value0) {
    return Vesting(value0);
  }

  CollatorSelection collatorSelection(_i10.Event value0) {
    return CollatorSelection(value0);
  }

  Session session(_i11.Event value0) {
    return Session(value0);
  }

  XcmpQueue xcmpQueue(_i12.Event value0) {
    return XcmpQueue(value0);
  }

  PolkadotXcm polkadotXcm(_i13.Event value0) {
    return PolkadotXcm(value0);
  }

  CumulusXcm cumulusXcm(_i14.Event value0) {
    return CumulusXcm(value0);
  }

  ToPolkadotXcmRouter toPolkadotXcmRouter(_i15.Event value0) {
    return ToPolkadotXcmRouter(value0);
  }

  MessageQueue messageQueue(_i16.Event value0) {
    return MessageQueue(value0);
  }

  Utility utility(_i17.Event value0) {
    return Utility(value0);
  }

  Multisig multisig(_i18.Event value0) {
    return Multisig(value0);
  }

  Proxy proxy(_i19.Event value0) {
    return Proxy(value0);
  }

  Assets assets(_i20.Event value0) {
    return Assets(value0);
  }

  Uniques uniques(_i21.Event value0) {
    return Uniques(value0);
  }

  Nfts nfts(_i22.Event value0) {
    return Nfts(value0);
  }

  ForeignAssets foreignAssets(_i23.Event value0) {
    return ForeignAssets(value0);
  }

  NftFractionalization nftFractionalization(_i24.Event value0) {
    return NftFractionalization(value0);
  }

  PoolAssets poolAssets(_i25.Event value0) {
    return PoolAssets(value0);
  }

  AssetConversion assetConversion(_i26.Event value0) {
    return AssetConversion(value0);
  }

  Revive revive(_i27.Event value0) {
    return Revive(value0);
  }

  StateTrieMigration stateTrieMigration(_i28.Event value0) {
    return StateTrieMigration(value0);
  }
}

class $RuntimeEventCodec with _i1.Codec<RuntimeEvent> {
  const $RuntimeEventCodec();

  @override
  RuntimeEvent decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return System._decode(input);
      case 1:
        return ParachainSystem._decode(input);
      case 5:
        return MultiBlockMigrations._decode(input);
      case 10:
        return Balances._decode(input);
      case 11:
        return TransactionPayment._decode(input);
      case 13:
        return AssetTxPayment._decode(input);
      case 14:
        return Vesting._decode(input);
      case 21:
        return CollatorSelection._decode(input);
      case 22:
        return Session._decode(input);
      case 30:
        return XcmpQueue._decode(input);
      case 31:
        return PolkadotXcm._decode(input);
      case 32:
        return CumulusXcm._decode(input);
      case 34:
        return ToPolkadotXcmRouter._decode(input);
      case 35:
        return MessageQueue._decode(input);
      case 40:
        return Utility._decode(input);
      case 41:
        return Multisig._decode(input);
      case 42:
        return Proxy._decode(input);
      case 50:
        return Assets._decode(input);
      case 51:
        return Uniques._decode(input);
      case 52:
        return Nfts._decode(input);
      case 53:
        return ForeignAssets._decode(input);
      case 54:
        return NftFractionalization._decode(input);
      case 55:
        return PoolAssets._decode(input);
      case 56:
        return AssetConversion._decode(input);
      case 60:
        return Revive._decode(input);
      case 70:
        return StateTrieMigration._decode(input);
      default:
        throw Exception('RuntimeEvent: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    RuntimeEvent value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case System:
        (value as System).encodeTo(output);
        break;
      case ParachainSystem:
        (value as ParachainSystem).encodeTo(output);
        break;
      case MultiBlockMigrations:
        (value as MultiBlockMigrations).encodeTo(output);
        break;
      case Balances:
        (value as Balances).encodeTo(output);
        break;
      case TransactionPayment:
        (value as TransactionPayment).encodeTo(output);
        break;
      case AssetTxPayment:
        (value as AssetTxPayment).encodeTo(output);
        break;
      case Vesting:
        (value as Vesting).encodeTo(output);
        break;
      case CollatorSelection:
        (value as CollatorSelection).encodeTo(output);
        break;
      case Session:
        (value as Session).encodeTo(output);
        break;
      case XcmpQueue:
        (value as XcmpQueue).encodeTo(output);
        break;
      case PolkadotXcm:
        (value as PolkadotXcm).encodeTo(output);
        break;
      case CumulusXcm:
        (value as CumulusXcm).encodeTo(output);
        break;
      case ToPolkadotXcmRouter:
        (value as ToPolkadotXcmRouter).encodeTo(output);
        break;
      case MessageQueue:
        (value as MessageQueue).encodeTo(output);
        break;
      case Utility:
        (value as Utility).encodeTo(output);
        break;
      case Multisig:
        (value as Multisig).encodeTo(output);
        break;
      case Proxy:
        (value as Proxy).encodeTo(output);
        break;
      case Assets:
        (value as Assets).encodeTo(output);
        break;
      case Uniques:
        (value as Uniques).encodeTo(output);
        break;
      case Nfts:
        (value as Nfts).encodeTo(output);
        break;
      case ForeignAssets:
        (value as ForeignAssets).encodeTo(output);
        break;
      case NftFractionalization:
        (value as NftFractionalization).encodeTo(output);
        break;
      case PoolAssets:
        (value as PoolAssets).encodeTo(output);
        break;
      case AssetConversion:
        (value as AssetConversion).encodeTo(output);
        break;
      case Revive:
        (value as Revive).encodeTo(output);
        break;
      case StateTrieMigration:
        (value as StateTrieMigration).encodeTo(output);
        break;
      default:
        throw Exception('RuntimeEvent: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(RuntimeEvent value) {
    switch (value.runtimeType) {
      case System:
        return (value as System)._sizeHint();
      case ParachainSystem:
        return (value as ParachainSystem)._sizeHint();
      case MultiBlockMigrations:
        return (value as MultiBlockMigrations)._sizeHint();
      case Balances:
        return (value as Balances)._sizeHint();
      case TransactionPayment:
        return (value as TransactionPayment)._sizeHint();
      case AssetTxPayment:
        return (value as AssetTxPayment)._sizeHint();
      case Vesting:
        return (value as Vesting)._sizeHint();
      case CollatorSelection:
        return (value as CollatorSelection)._sizeHint();
      case Session:
        return (value as Session)._sizeHint();
      case XcmpQueue:
        return (value as XcmpQueue)._sizeHint();
      case PolkadotXcm:
        return (value as PolkadotXcm)._sizeHint();
      case CumulusXcm:
        return (value as CumulusXcm)._sizeHint();
      case ToPolkadotXcmRouter:
        return (value as ToPolkadotXcmRouter)._sizeHint();
      case MessageQueue:
        return (value as MessageQueue)._sizeHint();
      case Utility:
        return (value as Utility)._sizeHint();
      case Multisig:
        return (value as Multisig)._sizeHint();
      case Proxy:
        return (value as Proxy)._sizeHint();
      case Assets:
        return (value as Assets)._sizeHint();
      case Uniques:
        return (value as Uniques)._sizeHint();
      case Nfts:
        return (value as Nfts)._sizeHint();
      case ForeignAssets:
        return (value as ForeignAssets)._sizeHint();
      case NftFractionalization:
        return (value as NftFractionalization)._sizeHint();
      case PoolAssets:
        return (value as PoolAssets)._sizeHint();
      case AssetConversion:
        return (value as AssetConversion)._sizeHint();
      case Revive:
        return (value as Revive)._sizeHint();
      case StateTrieMigration:
        return (value as StateTrieMigration)._sizeHint();
      default:
        throw Exception('RuntimeEvent: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class System extends RuntimeEvent {
  const System(this.value0);

  factory System._decode(_i1.Input input) {
    return System(_i3.Event.codec.decode(input));
  }

  /// frame_system::Event<Runtime>
  final _i3.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'System': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.Event.codec.encodeTo(
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
      other is System && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class ParachainSystem extends RuntimeEvent {
  const ParachainSystem(this.value0);

  factory ParachainSystem._decode(_i1.Input input) {
    return ParachainSystem(_i4.Event.codec.decode(input));
  }

  /// cumulus_pallet_parachain_system::Event<Runtime>
  final _i4.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'ParachainSystem': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i4.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i4.Event.codec.encodeTo(
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
      other is ParachainSystem && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class MultiBlockMigrations extends RuntimeEvent {
  const MultiBlockMigrations(this.value0);

  factory MultiBlockMigrations._decode(_i1.Input input) {
    return MultiBlockMigrations(_i5.Event.codec.decode(input));
  }

  /// pallet_migrations::Event<Runtime>
  final _i5.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'MultiBlockMigrations': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i5.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i5.Event.codec.encodeTo(
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
      other is MultiBlockMigrations && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Balances extends RuntimeEvent {
  const Balances(this.value0);

  factory Balances._decode(_i1.Input input) {
    return Balances(_i6.Event.codec.decode(input));
  }

  /// pallet_balances::Event<Runtime>
  final _i6.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Balances': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i6.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    _i6.Event.codec.encodeTo(
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
      other is Balances && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class TransactionPayment extends RuntimeEvent {
  const TransactionPayment(this.value0);

  factory TransactionPayment._decode(_i1.Input input) {
    return TransactionPayment(_i7.Event.codec.decode(input));
  }

  /// pallet_transaction_payment::Event<Runtime>
  final _i7.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'TransactionPayment': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i7.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
    _i7.Event.codec.encodeTo(
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
      other is TransactionPayment && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class AssetTxPayment extends RuntimeEvent {
  const AssetTxPayment(this.value0);

  factory AssetTxPayment._decode(_i1.Input input) {
    return AssetTxPayment(_i8.Event.codec.decode(input));
  }

  /// pallet_asset_conversion_tx_payment::Event<Runtime>
  final _i8.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'AssetTxPayment': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i8.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
    _i8.Event.codec.encodeTo(
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
      other is AssetTxPayment && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Vesting extends RuntimeEvent {
  const Vesting(this.value0);

  factory Vesting._decode(_i1.Input input) {
    return Vesting(_i9.Event.codec.decode(input));
  }

  /// pallet_vesting::Event<Runtime>
  final _i9.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'Vesting': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i9.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      14,
      output,
    );
    _i9.Event.codec.encodeTo(
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
      other is Vesting && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class CollatorSelection extends RuntimeEvent {
  const CollatorSelection(this.value0);

  factory CollatorSelection._decode(_i1.Input input) {
    return CollatorSelection(_i10.Event.codec.decode(input));
  }

  /// pallet_collator_selection::Event<Runtime>
  final _i10.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'CollatorSelection': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i10.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      21,
      output,
    );
    _i10.Event.codec.encodeTo(
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
      other is CollatorSelection && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Session extends RuntimeEvent {
  const Session(this.value0);

  factory Session._decode(_i1.Input input) {
    return Session(_i11.Event.codec.decode(input));
  }

  /// pallet_session::Event<Runtime>
  final _i11.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Session': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i11.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      22,
      output,
    );
    _i11.Event.codec.encodeTo(
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
      other is Session && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class XcmpQueue extends RuntimeEvent {
  const XcmpQueue(this.value0);

  factory XcmpQueue._decode(_i1.Input input) {
    return XcmpQueue(_i12.Event.codec.decode(input));
  }

  /// cumulus_pallet_xcmp_queue::Event<Runtime>
  final _i12.Event value0;

  @override
  Map<String, Map<String, Map<String, List<int>>>> toJson() => {'XcmpQueue': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i12.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      30,
      output,
    );
    _i12.Event.codec.encodeTo(
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
      other is XcmpQueue && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class PolkadotXcm extends RuntimeEvent {
  const PolkadotXcm(this.value0);

  factory PolkadotXcm._decode(_i1.Input input) {
    return PolkadotXcm(_i13.Event.codec.decode(input));
  }

  /// pallet_xcm::Event<Runtime>
  final _i13.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'PolkadotXcm': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i13.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      31,
      output,
    );
    _i13.Event.codec.encodeTo(
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
      other is PolkadotXcm && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class CumulusXcm extends RuntimeEvent {
  const CumulusXcm(this.value0);

  factory CumulusXcm._decode(_i1.Input input) {
    return CumulusXcm(_i14.Event.codec.decode(input));
  }

  /// cumulus_pallet_xcm::Event<Runtime>
  final _i14.Event value0;

  @override
  Map<String, Map<String, List<dynamic>>> toJson() => {'CumulusXcm': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i14.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      32,
      output,
    );
    _i14.Event.codec.encodeTo(
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
      other is CumulusXcm && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class ToPolkadotXcmRouter extends RuntimeEvent {
  const ToPolkadotXcmRouter(this.value0);

  factory ToPolkadotXcmRouter._decode(_i1.Input input) {
    return ToPolkadotXcmRouter(_i15.Event.codec.decode(input));
  }

  /// pallet_xcm_bridge_hub_router::Event<Runtime, pallet_xcm_bridge_hub_router
  ///::Instance1>
  final _i15.Event value0;

  @override
  Map<String, Map<String, Map<String, BigInt>>> toJson() => {'ToPolkadotXcmRouter': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i15.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      34,
      output,
    );
    _i15.Event.codec.encodeTo(
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
      other is ToPolkadotXcmRouter && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class MessageQueue extends RuntimeEvent {
  const MessageQueue(this.value0);

  factory MessageQueue._decode(_i1.Input input) {
    return MessageQueue(_i16.Event.codec.decode(input));
  }

  /// pallet_message_queue::Event<Runtime>
  final _i16.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'MessageQueue': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i16.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      35,
      output,
    );
    _i16.Event.codec.encodeTo(
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
      other is MessageQueue && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Utility extends RuntimeEvent {
  const Utility(this.value0);

  factory Utility._decode(_i1.Input input) {
    return Utility(_i17.Event.codec.decode(input));
  }

  /// pallet_utility::Event
  final _i17.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Utility': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i17.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      40,
      output,
    );
    _i17.Event.codec.encodeTo(
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
      other is Utility && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Multisig extends RuntimeEvent {
  const Multisig(this.value0);

  factory Multisig._decode(_i1.Input input) {
    return Multisig(_i18.Event.codec.decode(input));
  }

  /// pallet_multisig::Event<Runtime>
  final _i18.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'Multisig': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i18.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      41,
      output,
    );
    _i18.Event.codec.encodeTo(
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
      other is Multisig && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Proxy extends RuntimeEvent {
  const Proxy(this.value0);

  factory Proxy._decode(_i1.Input input) {
    return Proxy(_i19.Event.codec.decode(input));
  }

  /// pallet_proxy::Event<Runtime>
  final _i19.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'Proxy': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i19.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      42,
      output,
    );
    _i19.Event.codec.encodeTo(
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
      other is Proxy && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Assets extends RuntimeEvent {
  const Assets(this.value0);

  factory Assets._decode(_i1.Input input) {
    return Assets(_i20.Event.codec.decode(input));
  }

  /// pallet_assets::Event<Runtime, pallet_assets::Instance1>
  final _i20.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'Assets': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i20.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      50,
      output,
    );
    _i20.Event.codec.encodeTo(
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
      other is Assets && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Uniques extends RuntimeEvent {
  const Uniques(this.value0);

  factory Uniques._decode(_i1.Input input) {
    return Uniques(_i21.Event.codec.decode(input));
  }

  /// pallet_uniques::Event<Runtime>
  final _i21.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'Uniques': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i21.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      51,
      output,
    );
    _i21.Event.codec.encodeTo(
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
      other is Uniques && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Nfts extends RuntimeEvent {
  const Nfts(this.value0);

  factory Nfts._decode(_i1.Input input) {
    return Nfts(_i22.Event.codec.decode(input));
  }

  /// pallet_nfts::Event<Runtime>
  final _i22.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'Nfts': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i22.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      52,
      output,
    );
    _i22.Event.codec.encodeTo(
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
      other is Nfts && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class ForeignAssets extends RuntimeEvent {
  const ForeignAssets(this.value0);

  factory ForeignAssets._decode(_i1.Input input) {
    return ForeignAssets(_i23.Event.codec.decode(input));
  }

  /// pallet_assets::Event<Runtime, pallet_assets::Instance2>
  final _i23.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'ForeignAssets': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i23.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      53,
      output,
    );
    _i23.Event.codec.encodeTo(
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
      other is ForeignAssets && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class NftFractionalization extends RuntimeEvent {
  const NftFractionalization(this.value0);

  factory NftFractionalization._decode(_i1.Input input) {
    return NftFractionalization(_i24.Event.codec.decode(input));
  }

  /// pallet_nft_fractionalization::Event<Runtime>
  final _i24.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'NftFractionalization': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i24.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      54,
      output,
    );
    _i24.Event.codec.encodeTo(
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
      other is NftFractionalization && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class PoolAssets extends RuntimeEvent {
  const PoolAssets(this.value0);

  factory PoolAssets._decode(_i1.Input input) {
    return PoolAssets(_i25.Event.codec.decode(input));
  }

  /// pallet_assets::Event<Runtime, pallet_assets::Instance3>
  final _i25.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'PoolAssets': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i25.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      55,
      output,
    );
    _i25.Event.codec.encodeTo(
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
      other is PoolAssets && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class AssetConversion extends RuntimeEvent {
  const AssetConversion(this.value0);

  factory AssetConversion._decode(_i1.Input input) {
    return AssetConversion(_i26.Event.codec.decode(input));
  }

  /// pallet_asset_conversion::Event<Runtime>
  final _i26.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'AssetConversion': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i26.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      56,
      output,
    );
    _i26.Event.codec.encodeTo(
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
      other is AssetConversion && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Revive extends RuntimeEvent {
  const Revive(this.value0);

  factory Revive._decode(_i1.Input input) {
    return Revive(_i27.Event.codec.decode(input));
  }

  /// pallet_revive::Event<Runtime>
  final _i27.Event value0;

  @override
  Map<String, Map<String, Map<String, List<dynamic>>>> toJson() => {'Revive': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i27.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      60,
      output,
    );
    _i27.Event.codec.encodeTo(
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
      other is Revive && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class StateTrieMigration extends RuntimeEvent {
  const StateTrieMigration(this.value0);

  factory StateTrieMigration._decode(_i1.Input input) {
    return StateTrieMigration(_i28.Event.codec.decode(input));
  }

  /// pallet_state_trie_migration::Event<Runtime>
  final _i28.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'StateTrieMigration': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i28.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      70,
      output,
    );
    _i28.Event.codec.encodeTo(
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
      other is StateTrieMigration && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
