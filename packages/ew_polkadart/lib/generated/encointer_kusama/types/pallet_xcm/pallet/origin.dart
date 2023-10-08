// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;import 'dart:typed_data' as _i2;import '../../xcm/v3/multilocation/multi_location.dart' as _i3;abstract class Origin {const Origin();

factory Origin.decode(_i1.Input input) { return codec.decode(input); }

static const $OriginCodec codec = $OriginCodec();

static const $Origin values = $Origin();

_i2.Uint8List encode() { final output = _i1.ByteOutput(codec.sizeHint(this));
codec.encodeTo(this, output);
return output.toBytes(); } 
int sizeHint() { return codec.sizeHint(this); } 
Map<String,Map<String,dynamic>> toJson();
 }
class $Origin {const $Origin();

Xcm xcm({required _i3.MultiLocation value0}) { return Xcm(
value0: value0,
); } 
Response response({required _i3.MultiLocation value0}) { return Response(
value0: value0,
); } 
 }
class $OriginCodec with _i1.Codec<Origin> {const $OriginCodec();

@override Origin decode(_i1.Input input) { final index = _i1.U8Codec.codec.decode(input);
switch (index) {
case 0:
return Xcm._decode(input);
case 1:
return Response._decode(input);
default: throw Exception('Origin: Invalid variant index: "$index"');
} } 
@override void encodeTo(Origin value, _i1.Output output, ) { switch (value.runtimeType) {
case Xcm:
(value as Xcm).encodeTo(output);
break;
case Response:
(value as Response).encodeTo(output);
break;
default: throw Exception('Origin: Unsupported "$value" of type "${value.runtimeType}"');
} } 
@override int sizeHint(Origin value) { switch (value.runtimeType) {
case Xcm:
return (value as Xcm)._sizeHint();
case Response:
return (value as Response)._sizeHint();
default: throw Exception('Origin: Unsupported "$value" of type "${value.runtimeType}"');
} } 
 }
class Xcm extends Origin {const Xcm({required this.value0});

factory Xcm._decode(_i1.Input input) { return Xcm(
value0: 
_i3.MultiLocation.codec.decode(input)
, 
); }

final _i3.MultiLocation value0;

@override Map<String,Map<String,dynamic>> toJson() => {'Xcm': value0.toJson()};

int _sizeHint() { int size = 1;
size = size + _i3.MultiLocation.codec.sizeHint(value0);
return  size; } 
void encodeTo(_i1.Output output) { _i1.U8Codec.codec.encodeTo(0, output, );
_i3.MultiLocation.codec.encodeTo(value0, output, ); } 
 }
class Response extends Origin {const Response({required this.value0});

factory Response._decode(_i1.Input input) { return Response(
value0: 
_i3.MultiLocation.codec.decode(input)
, 
); }

final _i3.MultiLocation value0;

@override Map<String,Map<String,dynamic>> toJson() => {'Response': value0.toJson()};

int _sizeHint() { int size = 1;
size = size + _i3.MultiLocation.codec.sizeHint(value0);
return  size; } 
void encodeTo(_i1.Output output) { _i1.U8Codec.codec.encodeTo(1, output, );
_i3.MultiLocation.codec.encodeTo(value0, output, ); } 
 }
