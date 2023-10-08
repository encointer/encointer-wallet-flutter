// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;
import '../../encointer_primitives/communities/community_identifier.dart' as _i3;

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

  Map<String, Map<String, dynamic>> toJson();
}

class $Call {
  const $Call();

  CreateBusiness createBusiness({
    required _i3.CommunityIdentifier cid,
    required List<int> url,
  }) {
    return CreateBusiness(
      cid: cid,
      url: url,
    );
  }

  UpdateBusiness updateBusiness({
    required _i3.CommunityIdentifier cid,
    required List<int> url,
  }) {
    return UpdateBusiness(
      cid: cid,
      url: url,
    );
  }

  DeleteBusiness deleteBusiness({required _i3.CommunityIdentifier cid}) {
    return DeleteBusiness(
      cid: cid,
    );
  }

  CreateOffering createOffering({
    required _i3.CommunityIdentifier cid,
    required List<int> url,
  }) {
    return CreateOffering(
      cid: cid,
      url: url,
    );
  }

  UpdateOffering updateOffering({
    required _i3.CommunityIdentifier cid,
    required int oid,
    required List<int> url,
  }) {
    return UpdateOffering(
      cid: cid,
      oid: oid,
      url: url,
    );
  }

  DeleteOffering deleteOffering({
    required _i3.CommunityIdentifier cid,
    required int oid,
  }) {
    return DeleteOffering(
      cid: cid,
      oid: oid,
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
        return CreateBusiness._decode(input);
      case 1:
        return UpdateBusiness._decode(input);
      case 2:
        return DeleteBusiness._decode(input);
      case 3:
        return CreateOffering._decode(input);
      case 4:
        return UpdateOffering._decode(input);
      case 5:
        return DeleteOffering._decode(input);
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
      case CreateBusiness:
        (value as CreateBusiness).encodeTo(output);
        break;
      case UpdateBusiness:
        (value as UpdateBusiness).encodeTo(output);
        break;
      case DeleteBusiness:
        (value as DeleteBusiness).encodeTo(output);
        break;
      case CreateOffering:
        (value as CreateOffering).encodeTo(output);
        break;
      case UpdateOffering:
        (value as UpdateOffering).encodeTo(output);
        break;
      case DeleteOffering:
        (value as DeleteOffering).encodeTo(output);
        break;
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case CreateBusiness:
        return (value as CreateBusiness)._sizeHint();
      case UpdateBusiness:
        return (value as UpdateBusiness)._sizeHint();
      case DeleteBusiness:
        return (value as DeleteBusiness)._sizeHint();
      case CreateOffering:
        return (value as CreateOffering)._sizeHint();
      case UpdateOffering:
        return (value as UpdateOffering)._sizeHint();
      case DeleteOffering:
        return (value as DeleteOffering)._sizeHint();
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// See [`Pallet::create_business`].
class CreateBusiness extends Call {
  const CreateBusiness({
    required this.cid,
    required this.url,
  });

  factory CreateBusiness._decode(_i1.Input input) {
    return CreateBusiness(
      cid: _i3.CommunityIdentifier.codec.decode(input),
      url: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  final _i3.CommunityIdentifier cid;

  final List<int> url;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'create_business': {
          'cid': cid.toJson(),
          'url': url,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(cid);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(url);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      url,
      output,
    );
  }
}

/// See [`Pallet::update_business`].
class UpdateBusiness extends Call {
  const UpdateBusiness({
    required this.cid,
    required this.url,
  });

  factory UpdateBusiness._decode(_i1.Input input) {
    return UpdateBusiness(
      cid: _i3.CommunityIdentifier.codec.decode(input),
      url: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  final _i3.CommunityIdentifier cid;

  final List<int> url;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'update_business': {
          'cid': cid.toJson(),
          'url': url,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(cid);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(url);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      url,
      output,
    );
  }
}

/// See [`Pallet::delete_business`].
class DeleteBusiness extends Call {
  const DeleteBusiness({required this.cid});

  factory DeleteBusiness._decode(_i1.Input input) {
    return DeleteBusiness(
      cid: _i3.CommunityIdentifier.codec.decode(input),
    );
  }

  final _i3.CommunityIdentifier cid;

  @override
  Map<String, Map<String, Map<String, List<int>>>> toJson() => {
        'delete_business': {'cid': cid.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(cid);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
  }
}

/// See [`Pallet::create_offering`].
class CreateOffering extends Call {
  const CreateOffering({
    required this.cid,
    required this.url,
  });

  factory CreateOffering._decode(_i1.Input input) {
    return CreateOffering(
      cid: _i3.CommunityIdentifier.codec.decode(input),
      url: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  final _i3.CommunityIdentifier cid;

  final List<int> url;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'create_offering': {
          'cid': cid.toJson(),
          'url': url,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(cid);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(url);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      url,
      output,
    );
  }
}

/// See [`Pallet::update_offering`].
class UpdateOffering extends Call {
  const UpdateOffering({
    required this.cid,
    required this.oid,
    required this.url,
  });

  factory UpdateOffering._decode(_i1.Input input) {
    return UpdateOffering(
      cid: _i3.CommunityIdentifier.codec.decode(input),
      oid: _i1.U32Codec.codec.decode(input),
      url: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  final _i3.CommunityIdentifier cid;

  final int oid;

  final List<int> url;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'update_offering': {
          'cid': cid.toJson(),
          'oid': oid,
          'url': url,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(cid);
    size = size + _i1.U32Codec.codec.sizeHint(oid);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(url);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      oid,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      url,
      output,
    );
  }
}

/// See [`Pallet::delete_offering`].
class DeleteOffering extends Call {
  const DeleteOffering({
    required this.cid,
    required this.oid,
  });

  factory DeleteOffering._decode(_i1.Input input) {
    return DeleteOffering(
      cid: _i3.CommunityIdentifier.codec.decode(input),
      oid: _i1.U32Codec.codec.decode(input),
    );
  }

  final _i3.CommunityIdentifier cid;

  final int oid;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'delete_offering': {
          'cid': cid.toJson(),
          'oid': oid,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(cid);
    size = size + _i1.U32Codec.codec.sizeHint(oid);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      oid,
      output,
    );
  }
}
