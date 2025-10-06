// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../cumulus_pallet_parachain_system/pallet/call.dart' as _i4;
import '../cumulus_pallet_xcm/pallet/call.dart' as _i14;
import '../cumulus_pallet_xcmp_queue/pallet/call.dart' as _i12;
import '../frame_system/pallet/call.dart' as _i3;
import '../pallet_asset_conversion/pallet/call.dart' as _i27;
import '../pallet_assets/pallet/call_1.dart' as _i21;
import '../pallet_assets/pallet/call_2.dart' as _i24;
import '../pallet_assets/pallet/call_3.dart' as _i26;
import '../pallet_balances/pallet/call.dart' as _i8;
import '../pallet_collator_selection/pallet/call.dart' as _i10;
import '../pallet_message_queue/pallet/call.dart' as _i16;
import '../pallet_migrations/pallet/call.dart' as _i7;
import '../pallet_multisig/pallet/call.dart' as _i18;
import '../pallet_nft_fractionalization/pallet/call.dart' as _i25;
import '../pallet_nfts/pallet/call.dart' as _i23;
import '../pallet_proxy/pallet/call.dart' as _i19;
import '../pallet_remote_proxy/pallet/call.dart' as _i20;
import '../pallet_revive/pallet/call.dart' as _i28;
import '../pallet_session/pallet/call.dart' as _i11;
import '../pallet_state_trie_migration/pallet/call.dart' as _i29;
import '../pallet_timestamp/pallet/call.dart' as _i5;
import '../pallet_uniques/pallet/call.dart' as _i22;
import '../pallet_utility/pallet/call.dart' as _i17;
import '../pallet_vesting/pallet/call.dart' as _i9;
import '../pallet_xcm/pallet/call.dart' as _i13;
import '../pallet_xcm_bridge_hub_router/pallet/call.dart' as _i15;
import '../staging_parachain_info/pallet/call.dart' as _i6;

abstract class RuntimeCall {
  const RuntimeCall();

  factory RuntimeCall.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $RuntimeCallCodec codec = $RuntimeCallCodec();

  static const $RuntimeCall values = $RuntimeCall();

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

class $RuntimeCall {
  const $RuntimeCall();

  System system(_i3.Call value0) {
    return System(value0);
  }

  ParachainSystem parachainSystem(_i4.Call value0) {
    return ParachainSystem(value0);
  }

  Timestamp timestamp(_i5.Call value0) {
    return Timestamp(value0);
  }

  ParachainInfo parachainInfo(_i6.Call value0) {
    return ParachainInfo(value0);
  }

  MultiBlockMigrations multiBlockMigrations(_i7.Call value0) {
    return MultiBlockMigrations(value0);
  }

  Balances balances(_i8.Call value0) {
    return Balances(value0);
  }

  Vesting vesting(_i9.Call value0) {
    return Vesting(value0);
  }

  CollatorSelection collatorSelection(_i10.Call value0) {
    return CollatorSelection(value0);
  }

  Session session(_i11.Call value0) {
    return Session(value0);
  }

  XcmpQueue xcmpQueue(_i12.Call value0) {
    return XcmpQueue(value0);
  }

  PolkadotXcm polkadotXcm(_i13.Call value0) {
    return PolkadotXcm(value0);
  }

  CumulusXcm cumulusXcm(_i14.Call value0) {
    return CumulusXcm(value0);
  }

  ToPolkadotXcmRouter toPolkadotXcmRouter(_i15.Call value0) {
    return ToPolkadotXcmRouter(value0);
  }

  MessageQueue messageQueue(_i16.Call value0) {
    return MessageQueue(value0);
  }

  Utility utility(_i17.Call value0) {
    return Utility(value0);
  }

  Multisig multisig(_i18.Call value0) {
    return Multisig(value0);
  }

  Proxy proxy(_i19.Call value0) {
    return Proxy(value0);
  }

  RemoteProxyRelayChain remoteProxyRelayChain(_i20.Call value0) {
    return RemoteProxyRelayChain(value0);
  }

  Assets assets(_i21.Call value0) {
    return Assets(value0);
  }

  Uniques uniques(_i22.Call value0) {
    return Uniques(value0);
  }

  Nfts nfts(_i23.Call value0) {
    return Nfts(value0);
  }

  ForeignAssets foreignAssets(_i24.Call value0) {
    return ForeignAssets(value0);
  }

  NftFractionalization nftFractionalization(_i25.Call value0) {
    return NftFractionalization(value0);
  }

  PoolAssets poolAssets(_i26.Call value0) {
    return PoolAssets(value0);
  }

  AssetConversion assetConversion(_i27.Call value0) {
    return AssetConversion(value0);
  }

  Revive revive(_i28.Call value0) {
    return Revive(value0);
  }

  StateTrieMigration stateTrieMigration(_i29.Call value0) {
    return StateTrieMigration(value0);
  }
}

class $RuntimeCallCodec with _i1.Codec<RuntimeCall> {
  const $RuntimeCallCodec();

  @override
  RuntimeCall decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return System._decode(input);
      case 1:
        return ParachainSystem._decode(input);
      case 3:
        return Timestamp._decode(input);
      case 4:
        return ParachainInfo._decode(input);
      case 5:
        return MultiBlockMigrations._decode(input);
      case 10:
        return Balances._decode(input);
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
      case 43:
        return RemoteProxyRelayChain._decode(input);
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
        throw Exception('RuntimeCall: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    RuntimeCall value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case System:
        (value as System).encodeTo(output);
        break;
      case ParachainSystem:
        (value as ParachainSystem).encodeTo(output);
        break;
      case Timestamp:
        (value as Timestamp).encodeTo(output);
        break;
      case ParachainInfo:
        (value as ParachainInfo).encodeTo(output);
        break;
      case MultiBlockMigrations:
        (value as MultiBlockMigrations).encodeTo(output);
        break;
      case Balances:
        (value as Balances).encodeTo(output);
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
      case RemoteProxyRelayChain:
        (value as RemoteProxyRelayChain).encodeTo(output);
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
        throw Exception('RuntimeCall: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(RuntimeCall value) {
    switch (value.runtimeType) {
      case System:
        return (value as System)._sizeHint();
      case ParachainSystem:
        return (value as ParachainSystem)._sizeHint();
      case Timestamp:
        return (value as Timestamp)._sizeHint();
      case ParachainInfo:
        return (value as ParachainInfo)._sizeHint();
      case MultiBlockMigrations:
        return (value as MultiBlockMigrations)._sizeHint();
      case Balances:
        return (value as Balances)._sizeHint();
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
      case RemoteProxyRelayChain:
        return (value as RemoteProxyRelayChain)._sizeHint();
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
        throw Exception('RuntimeCall: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class System extends RuntimeCall {
  const System(this.value0);

  factory System._decode(_i1.Input input) {
    return System(_i3.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<System, Runtime>
  final _i3.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'System': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.Call.codec.encodeTo(
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

class ParachainSystem extends RuntimeCall {
  const ParachainSystem(this.value0);

  factory ParachainSystem._decode(_i1.Input input) {
    return ParachainSystem(_i4.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<ParachainSystem, Runtime>
  final _i4.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'ParachainSystem': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i4.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i4.Call.codec.encodeTo(
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

class Timestamp extends RuntimeCall {
  const Timestamp(this.value0);

  factory Timestamp._decode(_i1.Input input) {
    return Timestamp(_i5.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<Timestamp, Runtime>
  final _i5.Call value0;

  @override
  Map<String, Map<String, Map<String, BigInt>>> toJson() => {'Timestamp': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i5.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i5.Call.codec.encodeTo(
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
      other is Timestamp && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class ParachainInfo extends RuntimeCall {
  const ParachainInfo(this.value0);

  factory ParachainInfo._decode(_i1.Input input) {
    return ParachainInfo(_i1.NullCodec.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<ParachainInfo, Runtime>
  final _i6.Call value0;

  @override
  Map<String, dynamic> toJson() => {'ParachainInfo': null};

  int _sizeHint() {
    int size = 1;
    size = size + const _i6.CallCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.NullCodec.codec.encodeTo(
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
      other is ParachainInfo && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class MultiBlockMigrations extends RuntimeCall {
  const MultiBlockMigrations(this.value0);

  factory MultiBlockMigrations._decode(_i1.Input input) {
    return MultiBlockMigrations(_i7.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<MultiBlockMigrations, Runtime>
  final _i7.Call value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'MultiBlockMigrations': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i7.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i7.Call.codec.encodeTo(
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

class Balances extends RuntimeCall {
  const Balances(this.value0);

  factory Balances._decode(_i1.Input input) {
    return Balances(_i8.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<Balances, Runtime>
  final _i8.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'Balances': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i8.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    _i8.Call.codec.encodeTo(
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

class Vesting extends RuntimeCall {
  const Vesting(this.value0);

  factory Vesting._decode(_i1.Input input) {
    return Vesting(_i9.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<Vesting, Runtime>
  final _i9.Call value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Vesting': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i9.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      14,
      output,
    );
    _i9.Call.codec.encodeTo(
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

class CollatorSelection extends RuntimeCall {
  const CollatorSelection(this.value0);

  factory CollatorSelection._decode(_i1.Input input) {
    return CollatorSelection(_i10.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<CollatorSelection, Runtime>
  final _i10.Call value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'CollatorSelection': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i10.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      21,
      output,
    );
    _i10.Call.codec.encodeTo(
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

class Session extends RuntimeCall {
  const Session(this.value0);

  factory Session._decode(_i1.Input input) {
    return Session(_i11.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<Session, Runtime>
  final _i11.Call value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Session': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i11.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      22,
      output,
    );
    _i11.Call.codec.encodeTo(
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

class XcmpQueue extends RuntimeCall {
  const XcmpQueue(this.value0);

  factory XcmpQueue._decode(_i1.Input input) {
    return XcmpQueue(_i12.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<XcmpQueue, Runtime>
  final _i12.Call value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'XcmpQueue': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i12.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      30,
      output,
    );
    _i12.Call.codec.encodeTo(
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

class PolkadotXcm extends RuntimeCall {
  const PolkadotXcm(this.value0);

  factory PolkadotXcm._decode(_i1.Input input) {
    return PolkadotXcm(_i13.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<PolkadotXcm, Runtime>
  final _i13.Call value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'PolkadotXcm': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i13.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      31,
      output,
    );
    _i13.Call.codec.encodeTo(
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

class CumulusXcm extends RuntimeCall {
  const CumulusXcm(this.value0);

  factory CumulusXcm._decode(_i1.Input input) {
    return CumulusXcm(_i1.NullCodec.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<CumulusXcm, Runtime>
  final _i14.Call value0;

  @override
  Map<String, dynamic> toJson() => {'CumulusXcm': null};

  int _sizeHint() {
    int size = 1;
    size = size + const _i14.CallCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      32,
      output,
    );
    _i1.NullCodec.codec.encodeTo(
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

class ToPolkadotXcmRouter extends RuntimeCall {
  const ToPolkadotXcmRouter(this.value0);

  factory ToPolkadotXcmRouter._decode(_i1.Input input) {
    return ToPolkadotXcmRouter(_i15.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<ToPolkadotXcmRouter, Runtime>
  final _i15.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'ToPolkadotXcmRouter': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i15.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      34,
      output,
    );
    _i15.Call.codec.encodeTo(
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

class MessageQueue extends RuntimeCall {
  const MessageQueue(this.value0);

  factory MessageQueue._decode(_i1.Input input) {
    return MessageQueue(_i16.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<MessageQueue, Runtime>
  final _i16.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'MessageQueue': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i16.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      35,
      output,
    );
    _i16.Call.codec.encodeTo(
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

class Utility extends RuntimeCall {
  const Utility(this.value0);

  factory Utility._decode(_i1.Input input) {
    return Utility(_i17.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<Utility, Runtime>
  final _i17.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'Utility': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i17.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      40,
      output,
    );
    _i17.Call.codec.encodeTo(
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

class Multisig extends RuntimeCall {
  const Multisig(this.value0);

  factory Multisig._decode(_i1.Input input) {
    return Multisig(_i18.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<Multisig, Runtime>
  final _i18.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'Multisig': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i18.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      41,
      output,
    );
    _i18.Call.codec.encodeTo(
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

class Proxy extends RuntimeCall {
  const Proxy(this.value0);

  factory Proxy._decode(_i1.Input input) {
    return Proxy(_i19.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<Proxy, Runtime>
  final _i19.Call value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Proxy': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i19.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      42,
      output,
    );
    _i19.Call.codec.encodeTo(
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

class RemoteProxyRelayChain extends RuntimeCall {
  const RemoteProxyRelayChain(this.value0);

  factory RemoteProxyRelayChain._decode(_i1.Input input) {
    return RemoteProxyRelayChain(_i20.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<RemoteProxyRelayChain, Runtime>
  final _i20.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'RemoteProxyRelayChain': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i20.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      43,
      output,
    );
    _i20.Call.codec.encodeTo(
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
      other is RemoteProxyRelayChain && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Assets extends RuntimeCall {
  const Assets(this.value0);

  factory Assets._decode(_i1.Input input) {
    return Assets(_i21.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<Assets, Runtime>
  final _i21.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'Assets': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i21.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      50,
      output,
    );
    _i21.Call.codec.encodeTo(
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

class Uniques extends RuntimeCall {
  const Uniques(this.value0);

  factory Uniques._decode(_i1.Input input) {
    return Uniques(_i22.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<Uniques, Runtime>
  final _i22.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'Uniques': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i22.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      51,
      output,
    );
    _i22.Call.codec.encodeTo(
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

class Nfts extends RuntimeCall {
  const Nfts(this.value0);

  factory Nfts._decode(_i1.Input input) {
    return Nfts(_i23.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<Nfts, Runtime>
  final _i23.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'Nfts': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i23.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      52,
      output,
    );
    _i23.Call.codec.encodeTo(
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

class ForeignAssets extends RuntimeCall {
  const ForeignAssets(this.value0);

  factory ForeignAssets._decode(_i1.Input input) {
    return ForeignAssets(_i24.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<ForeignAssets, Runtime>
  final _i24.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'ForeignAssets': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i24.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      53,
      output,
    );
    _i24.Call.codec.encodeTo(
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

class NftFractionalization extends RuntimeCall {
  const NftFractionalization(this.value0);

  factory NftFractionalization._decode(_i1.Input input) {
    return NftFractionalization(_i25.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<NftFractionalization, Runtime>
  final _i25.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'NftFractionalization': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i25.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      54,
      output,
    );
    _i25.Call.codec.encodeTo(
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

class PoolAssets extends RuntimeCall {
  const PoolAssets(this.value0);

  factory PoolAssets._decode(_i1.Input input) {
    return PoolAssets(_i26.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<PoolAssets, Runtime>
  final _i26.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'PoolAssets': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i26.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      55,
      output,
    );
    _i26.Call.codec.encodeTo(
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

class AssetConversion extends RuntimeCall {
  const AssetConversion(this.value0);

  factory AssetConversion._decode(_i1.Input input) {
    return AssetConversion(_i27.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<AssetConversion, Runtime>
  final _i27.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'AssetConversion': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i27.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      56,
      output,
    );
    _i27.Call.codec.encodeTo(
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

class Revive extends RuntimeCall {
  const Revive(this.value0);

  factory Revive._decode(_i1.Input input) {
    return Revive(_i28.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<Revive, Runtime>
  final _i28.Call value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Revive': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i28.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      60,
      output,
    );
    _i28.Call.codec.encodeTo(
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

class StateTrieMigration extends RuntimeCall {
  const StateTrieMigration(this.value0);

  factory StateTrieMigration._decode(_i1.Input input) {
    return StateTrieMigration(_i29.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<StateTrieMigration, Runtime>
  final _i29.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'StateTrieMigration': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i29.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      70,
      output,
    );
    _i29.Call.codec.encodeTo(
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
