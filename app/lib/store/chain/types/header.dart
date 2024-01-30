import 'package:json_annotation/json_annotation.dart';

part 'header.g.dart';

/// Header retrieved via chain.subscribeNewHeads, but some fields are omitted.
@JsonSerializable(explicitToJson: true)
class Header {
  Header(this.number);

  /// Parse into header when retrieved from polkadart RPC.
  factory Header.fromJson(Map<String, dynamic> json) => _$HeaderFromJson(json);
  Map<String, dynamic> toJson() => _$HeaderToJson(this);

  BigInt number;
}
