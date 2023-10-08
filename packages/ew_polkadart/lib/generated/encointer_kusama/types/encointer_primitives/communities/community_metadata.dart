// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'announcement_signer.dart' as _i2;
import 'community_rules.dart' as _i3;
import 'dart:typed_data' as _i4;

class CommunityMetadata {
  const CommunityMetadata({
    required this.name,
    required this.symbol,
    required this.assets,
    this.theme,
    this.url,
    this.announcementSigner,
    required this.rules,
  });

  factory CommunityMetadata.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final List<int> name;

  final List<int> symbol;

  final List<int> assets;

  final List<int>? theme;

  final List<int>? url;

  final _i2.AnnouncementSigner? announcementSigner;

  final _i3.CommunityRules rules;

  static const $CommunityMetadataCodec codec = $CommunityMetadataCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'symbol': symbol,
        'assets': assets,
        'theme': theme,
        'url': url,
        'announcementSigner': announcementSigner?.toJson(),
        'rules': rules.toJson(),
      };
}

class $CommunityMetadataCodec with _i1.Codec<CommunityMetadata> {
  const $CommunityMetadataCodec();

  @override
  void encodeTo(
    CommunityMetadata obj,
    _i1.Output output,
  ) {
    _i1.U8SequenceCodec.codec.encodeTo(
      obj.name,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      obj.symbol,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      obj.assets,
      output,
    );
    const _i1.OptionCodec<List<int>>(_i1.U8SequenceCodec.codec).encodeTo(
      obj.theme,
      output,
    );
    const _i1.OptionCodec<List<int>>(_i1.U8SequenceCodec.codec).encodeTo(
      obj.url,
      output,
    );
    const _i1.OptionCodec<_i2.AnnouncementSigner>(_i2.AnnouncementSigner.codec).encodeTo(
      obj.announcementSigner,
      output,
    );
    _i3.CommunityRules.codec.encodeTo(
      obj.rules,
      output,
    );
  }

  @override
  CommunityMetadata decode(_i1.Input input) {
    return CommunityMetadata(
      name: _i1.U8SequenceCodec.codec.decode(input),
      symbol: _i1.U8SequenceCodec.codec.decode(input),
      assets: _i1.U8SequenceCodec.codec.decode(input),
      theme: const _i1.OptionCodec<List<int>>(_i1.U8SequenceCodec.codec).decode(input),
      url: const _i1.OptionCodec<List<int>>(_i1.U8SequenceCodec.codec).decode(input),
      announcementSigner: const _i1.OptionCodec<_i2.AnnouncementSigner>(_i2.AnnouncementSigner.codec).decode(input),
      rules: _i3.CommunityRules.codec.decode(input),
    );
  }

  @override
  int sizeHint(CommunityMetadata obj) {
    int size = 0;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(obj.name);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(obj.symbol);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(obj.assets);
    size = size + const _i1.OptionCodec<List<int>>(_i1.U8SequenceCodec.codec).sizeHint(obj.theme);
    size = size + const _i1.OptionCodec<List<int>>(_i1.U8SequenceCodec.codec).sizeHint(obj.url);
    size = size +
        const _i1.OptionCodec<_i2.AnnouncementSigner>(_i2.AnnouncementSigner.codec).sizeHint(obj.announcementSigner);
    size = size + _i3.CommunityRules.codec.sizeHint(obj.rules);
    return size;
  }
}
