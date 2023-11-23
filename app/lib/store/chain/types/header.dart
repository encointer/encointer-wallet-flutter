/// Header retrieved via chain.subscribeNewHeads, but some fields are omitted.
class Header {
  Header(this.hash, this.number);

  factory Header.fromJson(Map<String, dynamic> json) {
    return Header(json['hash'] as String?, BigInt.parse(json['number'] as String).toInt());
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'hash': hash, 'number': number};

  String? hash;
  int? number;
}
