// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;
import '../../sp_runtime/multiaddress/multi_address.dart' as _i3;
import '../../encointer_runtime/proxy_type.dart' as _i4;
import '../../encointer_runtime/runtime_call.dart' as _i5;
import '../../primitive_types/h256.dart' as _i6;

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

  Proxy proxy({
    required _i3.MultiAddress real,
    _i4.ProxyType? forceProxyType,
    required _i5.RuntimeCall call,
  }) {
    return Proxy(
      real: real,
      forceProxyType: forceProxyType,
      call: call,
    );
  }

  AddProxy addProxy({
    required _i3.MultiAddress delegate,
    required _i4.ProxyType proxyType,
    required int delay,
  }) {
    return AddProxy(
      delegate: delegate,
      proxyType: proxyType,
      delay: delay,
    );
  }

  RemoveProxy removeProxy({
    required _i3.MultiAddress delegate,
    required _i4.ProxyType proxyType,
    required int delay,
  }) {
    return RemoveProxy(
      delegate: delegate,
      proxyType: proxyType,
      delay: delay,
    );
  }

  RemoveProxies removeProxies() {
    return const RemoveProxies();
  }

  CreatePure createPure({
    required _i4.ProxyType proxyType,
    required int delay,
    required int index,
  }) {
    return CreatePure(
      proxyType: proxyType,
      delay: delay,
      index: index,
    );
  }

  KillPure killPure({
    required _i3.MultiAddress spawner,
    required _i4.ProxyType proxyType,
    required int index,
    required BigInt height,
    required BigInt extIndex,
  }) {
    return KillPure(
      spawner: spawner,
      proxyType: proxyType,
      index: index,
      height: height,
      extIndex: extIndex,
    );
  }

  Announce announce({
    required _i3.MultiAddress real,
    required _i6.H256 callHash,
  }) {
    return Announce(
      real: real,
      callHash: callHash,
    );
  }

  RemoveAnnouncement removeAnnouncement({
    required _i3.MultiAddress real,
    required _i6.H256 callHash,
  }) {
    return RemoveAnnouncement(
      real: real,
      callHash: callHash,
    );
  }

  RejectAnnouncement rejectAnnouncement({
    required _i3.MultiAddress delegate,
    required _i6.H256 callHash,
  }) {
    return RejectAnnouncement(
      delegate: delegate,
      callHash: callHash,
    );
  }

  ProxyAnnounced proxyAnnounced({
    required _i3.MultiAddress delegate,
    required _i3.MultiAddress real,
    _i4.ProxyType? forceProxyType,
    required _i5.RuntimeCall call,
  }) {
    return ProxyAnnounced(
      delegate: delegate,
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
        return Proxy._decode(input);
      case 1:
        return AddProxy._decode(input);
      case 2:
        return RemoveProxy._decode(input);
      case 3:
        return const RemoveProxies();
      case 4:
        return CreatePure._decode(input);
      case 5:
        return KillPure._decode(input);
      case 6:
        return Announce._decode(input);
      case 7:
        return RemoveAnnouncement._decode(input);
      case 8:
        return RejectAnnouncement._decode(input);
      case 9:
        return ProxyAnnounced._decode(input);
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
      case Proxy:
        (value as Proxy).encodeTo(output);
        break;
      case AddProxy:
        (value as AddProxy).encodeTo(output);
        break;
      case RemoveProxy:
        (value as RemoveProxy).encodeTo(output);
        break;
      case RemoveProxies:
        (value as RemoveProxies).encodeTo(output);
        break;
      case CreatePure:
        (value as CreatePure).encodeTo(output);
        break;
      case KillPure:
        (value as KillPure).encodeTo(output);
        break;
      case Announce:
        (value as Announce).encodeTo(output);
        break;
      case RemoveAnnouncement:
        (value as RemoveAnnouncement).encodeTo(output);
        break;
      case RejectAnnouncement:
        (value as RejectAnnouncement).encodeTo(output);
        break;
      case ProxyAnnounced:
        (value as ProxyAnnounced).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case Proxy:
        return (value as Proxy)._sizeHint();
      case AddProxy:
        return (value as AddProxy)._sizeHint();
      case RemoveProxy:
        return (value as RemoveProxy)._sizeHint();
      case RemoveProxies:
        return 1;
      case CreatePure:
        return (value as CreatePure)._sizeHint();
      case KillPure:
        return (value as KillPure)._sizeHint();
      case Announce:
        return (value as Announce)._sizeHint();
      case RemoveAnnouncement:
        return (value as RemoveAnnouncement)._sizeHint();
      case RejectAnnouncement:
        return (value as RejectAnnouncement)._sizeHint();
      case ProxyAnnounced:
        return (value as ProxyAnnounced)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// See [`Pallet::proxy`].
class Proxy extends Call {
  const Proxy({
    required this.real,
    this.forceProxyType,
    required this.call,
  });

  factory Proxy._decode(_i1.Input input) {
    return Proxy(
      real: _i3.MultiAddress.codec.decode(input),
      forceProxyType: const _i1.OptionCodec<_i4.ProxyType>(_i4.ProxyType.codec)
          .decode(input),
      call: _i5.RuntimeCall.codec.decode(input),
    );
  }

  final _i3.MultiAddress real;

  final _i4.ProxyType? forceProxyType;

  final _i5.RuntimeCall call;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'proxy': {
          'real': real.toJson(),
          'forceProxyType': forceProxyType?.toJson(),
          'call': call.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(real);
    size = size +
        const _i1.OptionCodec<_i4.ProxyType>(_i4.ProxyType.codec)
            .sizeHint(forceProxyType);
    size = size + _i5.RuntimeCall.codec.sizeHint(call);
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
  }
}

/// See [`Pallet::add_proxy`].
class AddProxy extends Call {
  const AddProxy({
    required this.delegate,
    required this.proxyType,
    required this.delay,
  });

  factory AddProxy._decode(_i1.Input input) {
    return AddProxy(
      delegate: _i3.MultiAddress.codec.decode(input),
      proxyType: _i4.ProxyType.codec.decode(input),
      delay: _i1.U32Codec.codec.decode(input),
    );
  }

  final _i3.MultiAddress delegate;

  final _i4.ProxyType proxyType;

  final int delay;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'add_proxy': {
          'delegate': delegate.toJson(),
          'proxyType': proxyType.toJson(),
          'delay': delay,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(delegate);
    size = size + _i4.ProxyType.codec.sizeHint(proxyType);
    size = size + _i1.U32Codec.codec.sizeHint(delay);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      delegate,
      output,
    );
    _i4.ProxyType.codec.encodeTo(
      proxyType,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      delay,
      output,
    );
  }
}

/// See [`Pallet::remove_proxy`].
class RemoveProxy extends Call {
  const RemoveProxy({
    required this.delegate,
    required this.proxyType,
    required this.delay,
  });

  factory RemoveProxy._decode(_i1.Input input) {
    return RemoveProxy(
      delegate: _i3.MultiAddress.codec.decode(input),
      proxyType: _i4.ProxyType.codec.decode(input),
      delay: _i1.U32Codec.codec.decode(input),
    );
  }

  final _i3.MultiAddress delegate;

  final _i4.ProxyType proxyType;

  final int delay;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'remove_proxy': {
          'delegate': delegate.toJson(),
          'proxyType': proxyType.toJson(),
          'delay': delay,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(delegate);
    size = size + _i4.ProxyType.codec.sizeHint(proxyType);
    size = size + _i1.U32Codec.codec.sizeHint(delay);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      delegate,
      output,
    );
    _i4.ProxyType.codec.encodeTo(
      proxyType,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      delay,
      output,
    );
  }
}

/// See [`Pallet::remove_proxies`].
class RemoveProxies extends Call {
  const RemoveProxies();

  @override
  Map<String, dynamic> toJson() => {'remove_proxies': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
  }
}

/// See [`Pallet::create_pure`].
class CreatePure extends Call {
  const CreatePure({
    required this.proxyType,
    required this.delay,
    required this.index,
  });

  factory CreatePure._decode(_i1.Input input) {
    return CreatePure(
      proxyType: _i4.ProxyType.codec.decode(input),
      delay: _i1.U32Codec.codec.decode(input),
      index: _i1.U16Codec.codec.decode(input),
    );
  }

  final _i4.ProxyType proxyType;

  final int delay;

  final int index;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'create_pure': {
          'proxyType': proxyType.toJson(),
          'delay': delay,
          'index': index,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.ProxyType.codec.sizeHint(proxyType);
    size = size + _i1.U32Codec.codec.sizeHint(delay);
    size = size + _i1.U16Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i4.ProxyType.codec.encodeTo(
      proxyType,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      delay,
      output,
    );
    _i1.U16Codec.codec.encodeTo(
      index,
      output,
    );
  }
}

/// See [`Pallet::kill_pure`].
class KillPure extends Call {
  const KillPure({
    required this.spawner,
    required this.proxyType,
    required this.index,
    required this.height,
    required this.extIndex,
  });

  factory KillPure._decode(_i1.Input input) {
    return KillPure(
      spawner: _i3.MultiAddress.codec.decode(input),
      proxyType: _i4.ProxyType.codec.decode(input),
      index: _i1.U16Codec.codec.decode(input),
      height: _i1.CompactBigIntCodec.codec.decode(input),
      extIndex: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  final _i3.MultiAddress spawner;

  final _i4.ProxyType proxyType;

  final int index;

  final BigInt height;

  final BigInt extIndex;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'kill_pure': {
          'spawner': spawner.toJson(),
          'proxyType': proxyType.toJson(),
          'index': index,
          'height': height,
          'extIndex': extIndex,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(spawner);
    size = size + _i4.ProxyType.codec.sizeHint(proxyType);
    size = size + _i1.U16Codec.codec.sizeHint(index);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(height);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(extIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      spawner,
      output,
    );
    _i4.ProxyType.codec.encodeTo(
      proxyType,
      output,
    );
    _i1.U16Codec.codec.encodeTo(
      index,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      height,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      extIndex,
      output,
    );
  }
}

/// See [`Pallet::announce`].
class Announce extends Call {
  const Announce({
    required this.real,
    required this.callHash,
  });

  factory Announce._decode(_i1.Input input) {
    return Announce(
      real: _i3.MultiAddress.codec.decode(input),
      callHash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  final _i3.MultiAddress real;

  final _i6.H256 callHash;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'announce': {
          'real': real.toJson(),
          'callHash': callHash.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(real);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(callHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      real,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      callHash,
      output,
    );
  }
}

/// See [`Pallet::remove_announcement`].
class RemoveAnnouncement extends Call {
  const RemoveAnnouncement({
    required this.real,
    required this.callHash,
  });

  factory RemoveAnnouncement._decode(_i1.Input input) {
    return RemoveAnnouncement(
      real: _i3.MultiAddress.codec.decode(input),
      callHash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  final _i3.MultiAddress real;

  final _i6.H256 callHash;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'remove_announcement': {
          'real': real.toJson(),
          'callHash': callHash.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(real);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(callHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      real,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      callHash,
      output,
    );
  }
}

/// See [`Pallet::reject_announcement`].
class RejectAnnouncement extends Call {
  const RejectAnnouncement({
    required this.delegate,
    required this.callHash,
  });

  factory RejectAnnouncement._decode(_i1.Input input) {
    return RejectAnnouncement(
      delegate: _i3.MultiAddress.codec.decode(input),
      callHash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  final _i3.MultiAddress delegate;

  final _i6.H256 callHash;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'reject_announcement': {
          'delegate': delegate.toJson(),
          'callHash': callHash.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(delegate);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(callHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      delegate,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      callHash,
      output,
    );
  }
}

/// See [`Pallet::proxy_announced`].
class ProxyAnnounced extends Call {
  const ProxyAnnounced({
    required this.delegate,
    required this.real,
    this.forceProxyType,
    required this.call,
  });

  factory ProxyAnnounced._decode(_i1.Input input) {
    return ProxyAnnounced(
      delegate: _i3.MultiAddress.codec.decode(input),
      real: _i3.MultiAddress.codec.decode(input),
      forceProxyType: const _i1.OptionCodec<_i4.ProxyType>(_i4.ProxyType.codec)
          .decode(input),
      call: _i5.RuntimeCall.codec.decode(input),
    );
  }

  final _i3.MultiAddress delegate;

  final _i3.MultiAddress real;

  final _i4.ProxyType? forceProxyType;

  final _i5.RuntimeCall call;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'proxy_announced': {
          'delegate': delegate.toJson(),
          'real': real.toJson(),
          'forceProxyType': forceProxyType?.toJson(),
          'call': call.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(delegate);
    size = size + _i3.MultiAddress.codec.sizeHint(real);
    size = size +
        const _i1.OptionCodec<_i4.ProxyType>(_i4.ProxyType.codec)
            .sizeHint(forceProxyType);
    size = size + _i5.RuntimeCall.codec.sizeHint(call);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      delegate,
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
}
