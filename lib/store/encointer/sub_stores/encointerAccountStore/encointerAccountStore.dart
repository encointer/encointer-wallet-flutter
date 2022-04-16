import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'encointerAccountStore.g.dart';

/// Stores data specific to an account across all communities.
///
///
@JsonSerializable(explicitToJson: true)
class EncointerAccountStore extends _EncointerAccountStore with _$EncointerAccountStore {
  EncointerAccountStore(String network, String address) : super(network, address);

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory EncointerAccountStore.fromJson(Map<String, dynamic> json) => _$EncointerAccountStoreFromJson(json);
  Map<String, dynamic> toJson() => _$EncointerAccountStoreToJson(this);
}

abstract class _EncointerAccountStore with Store {
  _EncointerAccountStore(this.network, this.address);

  @JsonKey(ignore: true)
  Future<void> Function() cacheFn;

  /// The network this store belongs to.
  final String network;

  /// The account (SS58) this store belongs to.
  final String address;

  void setCacheFn(Function cacheFn) {
    this.cacheFn = cacheFn;
  }
}

void _log(String msg) {
  print("[encointerAccountStore] $msg");
}
