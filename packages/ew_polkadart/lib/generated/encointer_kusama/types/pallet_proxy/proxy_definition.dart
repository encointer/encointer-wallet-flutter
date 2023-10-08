// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import '../sp_core/crypto/account_id32.dart' as _i2;
import '../encointer_runtime/proxy_type.dart' as _i3;
import 'dart:typed_data' as _i4;

class ProxyDefinition {
  const ProxyDefinition({
    required this.delegate,
    required this.proxyType,
    required this.delay,
  });

  factory ProxyDefinition.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final _i2.AccountId32 delegate;

  final _i3.ProxyType proxyType;

  final int delay;

  static const $ProxyDefinitionCodec codec = $ProxyDefinitionCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'delegate': delegate.toList(),
        'proxyType': proxyType.toJson(),
        'delay': delay,
      };
}

class $ProxyDefinitionCodec with _i1.Codec<ProxyDefinition> {
  const $ProxyDefinitionCodec();

  @override
  void encodeTo(
    ProxyDefinition obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.delegate,
      output,
    );
    _i3.ProxyType.codec.encodeTo(
      obj.proxyType,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.delay,
      output,
    );
  }

  @override
  ProxyDefinition decode(_i1.Input input) {
    return ProxyDefinition(
      delegate: const _i1.U8ArrayCodec(32).decode(input),
      proxyType: _i3.ProxyType.codec.decode(input),
      delay: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(ProxyDefinition obj) {
    int size = 0;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(obj.delegate);
    size = size + _i3.ProxyType.codec.sizeHint(obj.proxyType);
    size = size + _i1.U32Codec.codec.sizeHint(obj.delay);
    return size;
  }
}
