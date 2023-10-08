// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;import 'dart:typed_data' as _i2;import '../../xcm/v3/traits/outcome.dart' as _i3;/// The `Event` enum of this pallet
abstract class Event {const Event();

factory Event.decode(_i1.Input input) { return codec.decode(input); }

static const $EventCodec codec = $EventCodec();

static const $Event values = $Event();

_i2.Uint8List encode() { final output = _i1.ByteOutput(codec.sizeHint(this));
codec.encodeTo(this, output);
return output.toBytes(); } 
int sizeHint() { return codec.sizeHint(this); } 
Map<String,List<dynamic>> toJson();
 }
class $Event {const $Event();

InvalidFormat invalidFormat({required List<int> value0}) { return InvalidFormat(
value0: value0,
); } 
UnsupportedVersion unsupportedVersion({required List<int> value0}) { return UnsupportedVersion(
value0: value0,
); } 
ExecutedDownward executedDownward({required List<int> value0, required _i3.Outcome value1, }) { return ExecutedDownward(
value0: value0,
value1: value1,
); } 
 }
class $EventCodec with _i1.Codec<Event> {const $EventCodec();

@override Event decode(_i1.Input input) { final index = _i1.U8Codec.codec.decode(input);
switch (index) {
case 0:
return InvalidFormat._decode(input);
case 1:
return UnsupportedVersion._decode(input);
case 2:
return ExecutedDownward._decode(input);
default: throw Exception('Event: Invalid variant index: "$index"');
} } 
@override void encodeTo(Event value, _i1.Output output, ) { switch (value.runtimeType) {
case InvalidFormat:
(value as InvalidFormat).encodeTo(output);
break;
case UnsupportedVersion:
(value as UnsupportedVersion).encodeTo(output);
break;
case ExecutedDownward:
(value as ExecutedDownward).encodeTo(output);
break;
default: throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
} } 
@override int sizeHint(Event value) { switch (value.runtimeType) {
case InvalidFormat:
return (value as InvalidFormat)._sizeHint();
case UnsupportedVersion:
return (value as UnsupportedVersion)._sizeHint();
case ExecutedDownward:
return (value as ExecutedDownward)._sizeHint();
default: throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
} } 
 }
/// Downward message is invalid XCM.
/// /[ id /]
class InvalidFormat extends Event {const InvalidFormat({required this.value0});

factory InvalidFormat._decode(_i1.Input input) { return InvalidFormat(
value0: 
const _i1.U8ArrayCodec(32).decode(input)
, 
); }

final List<int> value0;

@override Map<String,List<int>> toJson() => {'InvalidFormat': value0.toList()};

int _sizeHint() { int size = 1;
size = size + const _i1.U8ArrayCodec(32).sizeHint(value0);
return  size; } 
void encodeTo(_i1.Output output) { _i1.U8Codec.codec.encodeTo(0, output, );
const _i1.U8ArrayCodec(32).encodeTo(value0, output, ); } 
 }
/// Downward message is unsupported version of XCM.
/// /[ id /]
class UnsupportedVersion extends Event {const UnsupportedVersion({required this.value0});

factory UnsupportedVersion._decode(_i1.Input input) { return UnsupportedVersion(
value0: 
const _i1.U8ArrayCodec(32).decode(input)
, 
); }

final List<int> value0;

@override Map<String,List<int>> toJson() => {'UnsupportedVersion': value0.toList()};

int _sizeHint() { int size = 1;
size = size + const _i1.U8ArrayCodec(32).sizeHint(value0);
return  size; } 
void encodeTo(_i1.Output output) { _i1.U8Codec.codec.encodeTo(1, output, );
const _i1.U8ArrayCodec(32).encodeTo(value0, output, ); } 
 }
/// Downward message executed with the given outcome.
/// /[ id, outcome /]
class ExecutedDownward extends Event {const ExecutedDownward({required this.value0, required this.value1, });

factory ExecutedDownward._decode(_i1.Input input) { return ExecutedDownward(
value0: 
const _i1.U8ArrayCodec(32).decode(input)
, 
value1: 
_i3.Outcome.codec.decode(input)
, 
); }

final List<int> value0;

final _i3.Outcome value1;

@override Map<String,List<dynamic>> toJson() => {'ExecutedDownward': [value0.toList(), value1.toJson(), ]};

int _sizeHint() { int size = 1;
size = size + const _i1.U8ArrayCodec(32).sizeHint(value0);
size = size + _i3.Outcome.codec.sizeHint(value1);
return  size; } 
void encodeTo(_i1.Output output) { _i1.U8Codec.codec.encodeTo(2, output, );
const _i1.U8ArrayCodec(32).encodeTo(value0, output, );
_i3.Outcome.codec.encodeTo(value1, output, ); } 
 }
