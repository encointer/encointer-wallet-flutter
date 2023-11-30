/// Header retrieved via chain.subscribeNewHeads, but some fields are omitted.
class Header {
  Header(this.hash, this.number);

  /// Parse into header when retrieved from polkadart RPC.
  factory Header.fromRpc(Map<String, dynamic> json) {
    return Header(json['hash'] as String?, BigInt.parse(json['number'] as String).toInt());
  }

  factory Header.fromJson(Map<String, dynamic> json) {
    return Header(json['hash'] as String?, json['number'] as int?);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'hash': hash, 'number': number};

  String? hash;
  int? number;
}
