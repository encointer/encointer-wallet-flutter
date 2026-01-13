// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

import '../cumulus_pallet_parachain_system/pallet/call.dart' as _i4;
import '../cumulus_pallet_xcm/pallet/call.dart' as _i12;
import '../cumulus_pallet_xcmp_queue/pallet/call.dart' as _i10;
import '../frame_system/pallet/call.dart' as _i3;
import '../pallet_balances/pallet/call.dart' as _i7;
import '../pallet_collator_selection/pallet/call.dart' as _i8;
import '../pallet_collective/pallet/call.dart' as _i17;
import '../pallet_encointer_balances/pallet/call.dart' as _i22;
import '../pallet_encointer_bazaar/pallet/call.dart' as _i23;
import '../pallet_encointer_ceremonies/pallet/call.dart' as _i20;
import '../pallet_encointer_communities/pallet/call.dart' as _i21;
import '../pallet_encointer_democracy/pallet/call.dart' as _i26;
import '../pallet_encointer_faucet/pallet/call.dart' as _i25;
import '../pallet_encointer_reputation_commitments/pallet/call.dart' as _i24;
import '../pallet_encointer_scheduler/pallet/call.dart' as _i19;
import '../pallet_encointer_treasuries/pallet/call.dart' as _i27;
import '../pallet_membership/pallet/call.dart' as _i18;
import '../pallet_message_queue/pallet/call.dart' as _i13;
import '../pallet_proxy/pallet/call.dart' as _i15;
import '../pallet_scheduler/pallet/call.dart' as _i16;
import '../pallet_session/pallet/call.dart' as _i9;
import '../pallet_timestamp/pallet/call.dart' as _i5;
import '../pallet_utility/pallet/call.dart' as _i14;
import '../pallet_xcm/pallet/call.dart' as _i11;
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

  Balances balances(_i7.Call value0) {
    return Balances(value0);
  }

  CollatorSelection collatorSelection(_i8.Call value0) {
    return CollatorSelection(value0);
  }

  Session session(_i9.Call value0) {
    return Session(value0);
  }

  XcmpQueue xcmpQueue(_i10.Call value0) {
    return XcmpQueue(value0);
  }

  PolkadotXcm polkadotXcm(_i11.Call value0) {
    return PolkadotXcm(value0);
  }

  CumulusXcm cumulusXcm(_i12.Call value0) {
    return CumulusXcm(value0);
  }

  MessageQueue messageQueue(_i13.Call value0) {
    return MessageQueue(value0);
  }

  Utility utility(_i14.Call value0) {
    return Utility(value0);
  }

  Proxy proxy(_i15.Call value0) {
    return Proxy(value0);
  }

  Scheduler scheduler(_i16.Call value0) {
    return Scheduler(value0);
  }

  Collective collective(_i17.Call value0) {
    return Collective(value0);
  }

  Membership membership(_i18.Call value0) {
    return Membership(value0);
  }

  EncointerScheduler encointerScheduler(_i19.Call value0) {
    return EncointerScheduler(value0);
  }

  EncointerCeremonies encointerCeremonies(_i20.Call value0) {
    return EncointerCeremonies(value0);
  }

  EncointerCommunities encointerCommunities(_i21.Call value0) {
    return EncointerCommunities(value0);
  }

  EncointerBalances encointerBalances(_i22.Call value0) {
    return EncointerBalances(value0);
  }

  EncointerBazaar encointerBazaar(_i23.Call value0) {
    return EncointerBazaar(value0);
  }

  EncointerReputationCommitments encointerReputationCommitments(_i24.Call value0) {
    return EncointerReputationCommitments(value0);
  }

  EncointerFaucet encointerFaucet(_i25.Call value0) {
    return EncointerFaucet(value0);
  }

  EncointerDemocracy encointerDemocracy(_i26.Call value0) {
    return EncointerDemocracy(value0);
  }

  EncointerTreasuries encointerTreasuries(_i27.Call value0) {
    return EncointerTreasuries(value0);
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
      case 10:
        return Balances._decode(input);
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
      case 35:
        return MessageQueue._decode(input);
      case 40:
        return Utility._decode(input);
      case 44:
        return Proxy._decode(input);
      case 48:
        return Scheduler._decode(input);
      case 50:
        return Collective._decode(input);
      case 51:
        return Membership._decode(input);
      case 60:
        return EncointerScheduler._decode(input);
      case 61:
        return EncointerCeremonies._decode(input);
      case 62:
        return EncointerCommunities._decode(input);
      case 63:
        return EncointerBalances._decode(input);
      case 64:
        return EncointerBazaar._decode(input);
      case 65:
        return EncointerReputationCommitments._decode(input);
      case 66:
        return EncointerFaucet._decode(input);
      case 67:
        return EncointerDemocracy._decode(input);
      case 68:
        return EncointerTreasuries._decode(input);
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
      case Balances:
        (value as Balances).encodeTo(output);
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
      case MessageQueue:
        (value as MessageQueue).encodeTo(output);
        break;
      case Utility:
        (value as Utility).encodeTo(output);
        break;
      case Proxy:
        (value as Proxy).encodeTo(output);
        break;
      case Scheduler:
        (value as Scheduler).encodeTo(output);
        break;
      case Collective:
        (value as Collective).encodeTo(output);
        break;
      case Membership:
        (value as Membership).encodeTo(output);
        break;
      case EncointerScheduler:
        (value as EncointerScheduler).encodeTo(output);
        break;
      case EncointerCeremonies:
        (value as EncointerCeremonies).encodeTo(output);
        break;
      case EncointerCommunities:
        (value as EncointerCommunities).encodeTo(output);
        break;
      case EncointerBalances:
        (value as EncointerBalances).encodeTo(output);
        break;
      case EncointerBazaar:
        (value as EncointerBazaar).encodeTo(output);
        break;
      case EncointerReputationCommitments:
        (value as EncointerReputationCommitments).encodeTo(output);
        break;
      case EncointerFaucet:
        (value as EncointerFaucet).encodeTo(output);
        break;
      case EncointerDemocracy:
        (value as EncointerDemocracy).encodeTo(output);
        break;
      case EncointerTreasuries:
        (value as EncointerTreasuries).encodeTo(output);
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
      case Balances:
        return (value as Balances)._sizeHint();
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
      case MessageQueue:
        return (value as MessageQueue)._sizeHint();
      case Utility:
        return (value as Utility)._sizeHint();
      case Proxy:
        return (value as Proxy)._sizeHint();
      case Scheduler:
        return (value as Scheduler)._sizeHint();
      case Collective:
        return (value as Collective)._sizeHint();
      case Membership:
        return (value as Membership)._sizeHint();
      case EncointerScheduler:
        return (value as EncointerScheduler)._sizeHint();
      case EncointerCeremonies:
        return (value as EncointerCeremonies)._sizeHint();
      case EncointerCommunities:
        return (value as EncointerCommunities)._sizeHint();
      case EncointerBalances:
        return (value as EncointerBalances)._sizeHint();
      case EncointerBazaar:
        return (value as EncointerBazaar)._sizeHint();
      case EncointerReputationCommitments:
        return (value as EncointerReputationCommitments)._sizeHint();
      case EncointerFaucet:
        return (value as EncointerFaucet)._sizeHint();
      case EncointerDemocracy:
        return (value as EncointerDemocracy)._sizeHint();
      case EncointerTreasuries:
        return (value as EncointerTreasuries)._sizeHint();
      default:
        throw Exception('RuntimeCall: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  bool isSizeZero() => false;
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

class Balances extends RuntimeCall {
  const Balances(this.value0);

  factory Balances._decode(_i1.Input input) {
    return Balances(_i7.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<Balances, Runtime>
  final _i7.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'Balances': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i7.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
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
      other is Balances && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class CollatorSelection extends RuntimeCall {
  const CollatorSelection(this.value0);

  factory CollatorSelection._decode(_i1.Input input) {
    return CollatorSelection(_i8.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<CollatorSelection, Runtime>
  final _i8.Call value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'CollatorSelection': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i8.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      21,
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
      other is CollatorSelection && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Session extends RuntimeCall {
  const Session(this.value0);

  factory Session._decode(_i1.Input input) {
    return Session(_i9.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<Session, Runtime>
  final _i9.Call value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Session': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i9.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      22,
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
      other is Session && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class XcmpQueue extends RuntimeCall {
  const XcmpQueue(this.value0);

  factory XcmpQueue._decode(_i1.Input input) {
    return XcmpQueue(_i10.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<XcmpQueue, Runtime>
  final _i10.Call value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'XcmpQueue': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i10.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      30,
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
      other is XcmpQueue && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class PolkadotXcm extends RuntimeCall {
  const PolkadotXcm(this.value0);

  factory PolkadotXcm._decode(_i1.Input input) {
    return PolkadotXcm(_i11.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<PolkadotXcm, Runtime>
  final _i11.Call value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'PolkadotXcm': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i11.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      31,
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
  final _i12.Call value0;

  @override
  Map<String, dynamic> toJson() => {'CumulusXcm': null};

  int _sizeHint() {
    int size = 1;
    size = size + const _i12.CallCodec().sizeHint(value0);
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

class MessageQueue extends RuntimeCall {
  const MessageQueue(this.value0);

  factory MessageQueue._decode(_i1.Input input) {
    return MessageQueue(_i13.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<MessageQueue, Runtime>
  final _i13.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'MessageQueue': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i13.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      35,
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
      other is MessageQueue && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Utility extends RuntimeCall {
  const Utility(this.value0);

  factory Utility._decode(_i1.Input input) {
    return Utility(_i14.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<Utility, Runtime>
  final _i14.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'Utility': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i14.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      40,
      output,
    );
    _i14.Call.codec.encodeTo(
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

class Proxy extends RuntimeCall {
  const Proxy(this.value0);

  factory Proxy._decode(_i1.Input input) {
    return Proxy(_i15.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<Proxy, Runtime>
  final _i15.Call value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Proxy': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i15.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      44,
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
      other is Proxy && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Scheduler extends RuntimeCall {
  const Scheduler(this.value0);

  factory Scheduler._decode(_i1.Input input) {
    return Scheduler(_i16.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<Scheduler, Runtime>
  final _i16.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'Scheduler': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i16.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      48,
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
      other is Scheduler && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Collective extends RuntimeCall {
  const Collective(this.value0);

  factory Collective._decode(_i1.Input input) {
    return Collective(_i17.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<Collective, Runtime>
  final _i17.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'Collective': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i17.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      50,
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
      other is Collective && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Membership extends RuntimeCall {
  const Membership(this.value0);

  factory Membership._decode(_i1.Input input) {
    return Membership(_i18.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<Membership, Runtime>
  final _i18.Call value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Membership': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i18.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      51,
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
      other is Membership && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class EncointerScheduler extends RuntimeCall {
  const EncointerScheduler(this.value0);

  factory EncointerScheduler._decode(_i1.Input input) {
    return EncointerScheduler(_i19.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<EncointerScheduler, Runtime>
  final _i19.Call value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'EncointerScheduler': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i19.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      60,
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
      other is EncointerScheduler && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class EncointerCeremonies extends RuntimeCall {
  const EncointerCeremonies(this.value0);

  factory EncointerCeremonies._decode(_i1.Input input) {
    return EncointerCeremonies(_i20.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<EncointerCeremonies, Runtime>
  final _i20.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'EncointerCeremonies': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i20.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      61,
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
      other is EncointerCeremonies && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class EncointerCommunities extends RuntimeCall {
  const EncointerCommunities(this.value0);

  factory EncointerCommunities._decode(_i1.Input input) {
    return EncointerCommunities(_i21.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<EncointerCommunities, Runtime>
  final _i21.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'EncointerCommunities': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i21.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      62,
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
      other is EncointerCommunities && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class EncointerBalances extends RuntimeCall {
  const EncointerBalances(this.value0);

  factory EncointerBalances._decode(_i1.Input input) {
    return EncointerBalances(_i22.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<EncointerBalances, Runtime>
  final _i22.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'EncointerBalances': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i22.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      63,
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
      other is EncointerBalances && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class EncointerBazaar extends RuntimeCall {
  const EncointerBazaar(this.value0);

  factory EncointerBazaar._decode(_i1.Input input) {
    return EncointerBazaar(_i23.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<EncointerBazaar, Runtime>
  final _i23.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'EncointerBazaar': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i23.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      64,
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
      other is EncointerBazaar && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class EncointerReputationCommitments extends RuntimeCall {
  const EncointerReputationCommitments(this.value0);

  factory EncointerReputationCommitments._decode(_i1.Input input) {
    return EncointerReputationCommitments(_i24.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<EncointerReputationCommitments, Runtime>
  final _i24.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'EncointerReputationCommitments': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i24.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      65,
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
      other is EncointerReputationCommitments && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class EncointerFaucet extends RuntimeCall {
  const EncointerFaucet(this.value0);

  factory EncointerFaucet._decode(_i1.Input input) {
    return EncointerFaucet(_i25.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<EncointerFaucet, Runtime>
  final _i25.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'EncointerFaucet': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i25.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      66,
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
      other is EncointerFaucet && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class EncointerDemocracy extends RuntimeCall {
  const EncointerDemocracy(this.value0);

  factory EncointerDemocracy._decode(_i1.Input input) {
    return EncointerDemocracy(_i26.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<EncointerDemocracy, Runtime>
  final _i26.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'EncointerDemocracy': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i26.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      67,
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
      other is EncointerDemocracy && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class EncointerTreasuries extends RuntimeCall {
  const EncointerTreasuries(this.value0);

  factory EncointerTreasuries._decode(_i1.Input input) {
    return EncointerTreasuries(_i27.Call.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::dispatch
  ///::CallableCallFor<EncointerTreasuries, Runtime>
  final _i27.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'EncointerTreasuries': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i27.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      68,
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
      other is EncointerTreasuries && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
